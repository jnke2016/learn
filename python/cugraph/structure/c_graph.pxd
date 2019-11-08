# Copyright (c) 2019, NVIDIA CORPORATION.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# cython: profile=False
# distutils: language = c++
# cython: embedsignature = True
# cython: language_level = 3

from cudf._lib.cudf cimport *


cdef extern from "cugraph.h":

    struct gdf_edge_list:
        gdf_column *src_indices
        gdf_column *dest_indices
        gdf_column *edge_data

    struct gdf_adj_list:
        gdf_column *offsets
        gdf_column *indices
        gdf_column *edge_data
        void get_vertex_identifiers(gdf_column *identifiers)
        void get_source_indices(gdf_column *indices)

    struct gdf_dynamic:
        void   *data

    ctypedef enum gdf_prop_type:
        GDF_PROP_UNDEF = 0
        GDF_PROP_FALSE
        GDF_PROP_TRUE

    struct cugraph::Graph_properties:
        bool directed
        bool weighted
        bool multigraph
        bool bipartite
        bool tree
        gdf_prop_type has_negative_edges

    struct cugraph::Graph:
        gdf_edge_list *edgeList
        gdf_adj_list *adjList
        gdf_adj_list *transposedAdjList
        gdf_dynamic  *dynAdjList
        cugraph::Graph_properties *prop
        size_t numberOfVertices


    cdef void cugraph::renumber_vertices(
        const gdf_column *src,
        const gdf_column *dst,
        gdf_column *src_renumbered,
        gdf_column *dst_renumbered,
        gdf_column *numbering_map) except +

    cdef void cugraph::edge_list_view(
        cugraph::Graph *graph,
        const gdf_column *source_indices,
        const gdf_column *destination_indices,
        const gdf_column *edge_data) except +
    cdef void cugraph::add_edge_list(Graph *graph) except +
    cdef void cugraph::delete_edge_list(Graph *graph) except +

    cdef void cugraph::adj_list_view (
        cugraph::Graph *graph,
        const gdf_column *offsets,
        const gdf_column *indices,
        const gdf_column *edge_data) except +
    cdef void cugraph::add_adj_list(Graph *graph) except +
    cdef void cugraph::delete_adj_list(Graph *graph) except +

    cdef void cugraph::add_transposed_adj_list(Graph *graph) except +
    cdef void cugraph::delete_transposed_adj_list(Graph *graph) except +

    cdef void cugraph::get_two_hop_neighbors(
        cugraph::Graph* graph,
        gdf_column* first,
        gdf_column* second) except +

    cdef void cugraph::degree(
        cugraph::Graph *graph,
        gdf_column *degree,
        int x) except +

    cdef void cugraph::number_of_vertices(Graph *graph) except +
