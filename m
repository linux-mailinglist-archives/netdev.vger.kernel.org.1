Return-Path: <netdev+bounces-76583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C294086E482
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 16:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3B8B248C2
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8726D1D8;
	Fri,  1 Mar 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMJ9hwpj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8893A8F8
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307419; cv=none; b=gsqSZszP266/l4MLj81b44d9Xs8oUeoUTtPbFMgHPdqWAvBxLE2JEhubAlT1YyTyL7mnPyToCgX8wjnnYTD84N1Tqvv1j7h7z3BDq+9umXYcx01oN8reQxw8t1HJt8PpkmtmB7pn5p6oAxs/ynGmUAhZed5fKaaIvXb/+T8YUcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307419; c=relaxed/simple;
	bh=50TChCFJ124g6jiLkHigElaX4VLMgjo1fOcgo20L7J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pC6qy0h4jfmFuRZC6r7s5u2aCMrReWZeytC4rdZrRPJoICGCcBaErQjIe1BANX4BK7OlzNPXXihEVmgWs2yGiu4Q4p8GG5bM5sm8Ckfur/2QTVrExdChNOBQp45ZxTsFYSopo6UKWPY7Kpxi4M3MJmvwawh3yh61I7yJLqIhyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMJ9hwpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05274C433F1;
	Fri,  1 Mar 2024 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709307419;
	bh=50TChCFJ124g6jiLkHigElaX4VLMgjo1fOcgo20L7J4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kMJ9hwpj4b+WDmyjSXVUJcAuOhnH0k5CfAzeuv1B+/EvRPhmJpzVdD2HYljT6eG+5
	 ILtBUzbGDXkyo1r5nvnrC6g77ZHYr889Gr2pcwOVfwn47fIEvHKm3/c/1v2ZFKfDHn
	 sqZcSXpqGq9N/8aOKdq8WUOLWY+BAi/IThnUFqyycnea+IQym7sCi9vmpsRAfG2Wq8
	 9AZb3eZSCmQKlSJxZy2zLtN66IDXGr6ba3/zrGsd8k4VVbBxDbdSrGOulvY+Xt1i07
	 wLmnVJ+Y3kdwQlnaAqHbMtw8w7uSXDUsB9SNZ7PCcrf0tI7KxsvOx+U9ACg3FRFddr
	 iLShVrbTvvc5w==
Message-ID: <27777e66-ca76-4d70-85e9-29347a358b7e@kernel.org>
Date: Fri, 1 Mar 2024 08:36:58 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/7] net: nexthop: Add nexthop group entry
 stats
Content-Language: en-US
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
 mlxsw@nvidia.com
References: <cover.1709217658.git.petrm@nvidia.com>
 <e0bba52945a53398c0b0af6ea5bc4a11f130960c.1709217658.git.petrm@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <e0bba52945a53398c0b0af6ea5bc4a11f130960c.1709217658.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 11:16 AM, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Add nexthop group entry stats to count the number of packets forwarded
> via each nexthop in the group. The stats will be exposed to user space
> for better data path observability in the next patch.
> 
> The per-CPU stats pointer is placed at the beginning of 'struct
> nh_grp_entry', so that all the fields accessed for the data path reside
> on the same cache line:
> 
> struct nh_grp_entry {
>         struct nexthop *           nh;                   /*     0     8 */
>         struct nh_grp_entry_stats * stats;               /*     8     8 */
>         u8                         weight;               /*    16     1 */
> 
>         /* XXX 7 bytes hole, try to pack */
> 
>         union {
>                 struct {
>                         atomic_t   upper_bound;          /*    24     4 */
>                 } hthr;                                  /*    24     4 */
>                 struct {
>                         struct list_head uw_nh_entry;    /*    24    16 */
>                         u16        count_buckets;        /*    40     2 */
>                         u16        wants_buckets;        /*    42     2 */
>                 } res;                                   /*    24    24 */
>         };                                               /*    24    24 */
>         struct list_head           nh_list;              /*    48    16 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         struct nexthop *           nh_parent;            /*    64     8 */
> 
>         /* size: 72, cachelines: 2, members: 6 */
>         /* sum members: 65, holes: 1, sum holes: 7 */
>         /* last cacheline: 8 bytes */
> };
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Set err on nexthop_create_group() error path
> 
>  include/net/nexthop.h |  6 ++++++
>  net/ipv4/nexthop.c    | 25 +++++++++++++++++++++----
>  2 files changed, 27 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



