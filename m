Return-Path: <netdev+bounces-76585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A51F86E49F
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 16:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09FDCB23E65
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0136FBB8;
	Fri,  1 Mar 2024 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7ncAmeT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF7C3984A
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307955; cv=none; b=JaqgPNxX/tx4FLr2mDXHI66W6z4HDluR7Ttlq1tm59M+iUas6fLuNk8WRhfZs852i4bR5URZK+Z0jmngZEMP/2QXKXBX32lLb5PVhK0xDjq6F1KbhXKQHK2GdibGliZP+R+vLg9BNKeRDzzb4fCpmP8AQ5DhO9Va/NP/QsofMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307955; c=relaxed/simple;
	bh=TXN8VR/wzdTCJTFQ7BBfkXr2DPBqsUmIzXETket0NO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQM9nhQwjl+7I7h4qUYY1cw1DRWOPdDwuAXuKrpUnTPyk09bzeYtyVulXmwa8Dv9j1Yvoq0ps9N5YNI+e0O7OEyBdTn9hZMzscClflfZU2Wpi4jEiC9rDsyaCBxQNUTWOnKMWsc/cjNzuFFrih6xDVV8V5UOyu2ofG0Lmmg5Jw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7ncAmeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE237C433C7;
	Fri,  1 Mar 2024 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709307954;
	bh=TXN8VR/wzdTCJTFQ7BBfkXr2DPBqsUmIzXETket0NO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W7ncAmeTDZaQRTcnnXqxDFACER6JxdEUd+ib91K2MdxXkwT1vQuufQKZnSzxWQYjs
	 6K2OlSY/g8WCcQ2BjSAZwoc9QhugoGsCh5Oc0s86n+BjBmMcL7bMRZVX0HSVe91ju0
	 RRYVEVvehYmrKIc15kxF0P9g3woFOhRQ84uZU45FRRa5M4/h6bCnqbeeexojSAbtvr
	 Jiy9Saaix8c8ZldqtfdfcG2QDRtoFa7T9IDtoGDNRcY8nKiqtWuxBy3jvwe1gSMZrz
	 mWF4rWoyBjw6dDdIycB1qvCnPdp+8CNhg+m/LL9WaDccUh6+wkC1hD6FXH8EVke7Yq
	 daoEEbUA7mpzg==
Message-ID: <148968b2-6d8e-476b-afee-5f1b15713c7e@kernel.org>
Date: Fri, 1 Mar 2024 08:45:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/7] net: nexthop: Expose nexthop group stats
 to user space
Content-Language: en-US
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
 mlxsw@nvidia.com
References: <cover.1709217658.git.petrm@nvidia.com>
 <223614cb8fbe91c6050794762becdd9a3c3b689a.1709217658.git.petrm@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <223614cb8fbe91c6050794762becdd9a3c3b689a.1709217658.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 11:16 AM, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Add netlink support for reading NH group stats.
> 
> This data is only for statistics of the traffic in the SW datapath. HW
> nexthop group statistics will be added in the following patches.
> 
> Emission of the stats is keyed to a new op_stats flag to avoid cluttering
> the netlink message with stats if the user doesn't need them:
> NHA_OP_FLAG_DUMP_STATS.
> 
> Co-developed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Use uint to encode NHA_GROUP_STATS_ENTRY_PACKETS
>     - Rename jump target in nla_put_nh_group_stats() to avoid
>       having to rename further in the patchset.
> 
>  include/uapi/linux/nexthop.h | 30 ++++++++++++
>  net/ipv4/nexthop.c           | 92 ++++++++++++++++++++++++++++++++----
>  2 files changed, 114 insertions(+), 8 deletions(-)
> 


> @@ -104,4 +109,29 @@ enum {
>  
>  #define NHA_RES_BUCKET_MAX	(__NHA_RES_BUCKET_MAX - 1)
>  
> +enum {
> +	NHA_GROUP_STATS_UNSPEC,
> +
> +	/* nested; nexthop group entry stats */
> +	NHA_GROUP_STATS_ENTRY,
> +
> +	__NHA_GROUP_STATS_MAX,
> +};
> +
> +#define NHA_GROUP_STATS_MAX	(__NHA_GROUP_STATS_MAX - 1)
> +
> +enum {
> +	NHA_GROUP_STATS_ENTRY_UNSPEC,
> +
> +	/* u32; nexthop id of the nexthop group entry */
> +	NHA_GROUP_STATS_ENTRY_ID,
> +
> +	/* uint; number of packets forwarded via the nexthop group entry */

why not make it a u64?

> +	NHA_GROUP_STATS_ENTRY_PACKETS,
> +
> +	__NHA_GROUP_STATS_ENTRY_MAX,
> +};
> +
> +#define NHA_GROUP_STATS_ENTRY_MAX	(__NHA_GROUP_STATS_ENTRY_MAX - 1)
> +
>  #endif

Reviewed-by: David Ahern <dsahern@kernel.org>



