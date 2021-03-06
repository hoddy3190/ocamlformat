(**************************************************************************)
(*                                                                        *)
(*                              OCamlFormat                               *)
(*                                                                        *)
(*            Copyright (c) Facebook, Inc. and its affiliates.            *)
(*                                                                        *)
(*      This source code is licensed under the MIT license found in       *)
(*      the LICENSE file in the root directory of this source tree.       *)
(*                                                                        *)
(**************************************************************************)

type 'a with_comments = {ast: 'a; comments: Cmt.t list; prefix: string}

module W : sig
  type t

  val in_lexer : int list

  val disable : int -> t

  val enable : int -> t

  val to_string : t list -> string
end

exception Warning50 of (Location.t * Warnings.t) list

val parse :
  (Lexing.lexbuf -> 'a) -> Conf.t -> source:string -> 'a with_comments
