Return-Path: <netdev+bounces-116869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 139F894BE83
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F70B213F5
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F82E1891D2;
	Thu,  8 Aug 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKceyPEF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAFF1474C3
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123730; cv=none; b=KkvT1NFhm1BUm9D6u0dROBKSsPhvxACnbVjTRH3o6gxcoL3T1KupxjdD+GnR+4T7r0x1cWHyuL+hm2y38fdvUijKAu0WYgRs0+eXW+1tI9FO8BAak0SuphUWmW+sdrQFCEo0MnTlfieNHPIpJalKR7mwlSPRgG3JGTg/8vNxlUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123730; c=relaxed/simple;
	bh=H4Z4VQvOjQ9X0WvQzOV4+9YLlvpoaHNvNY2zrwlxgFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=En0u0eNy5cxPJov3HbjJCv2uz+C3hMT9EtqfE1oHFdcPbyFQl4ihAlkaZ0xhVzjL6UgAW3asKx4DIv6t3JVwhVocPCLidxsBcnDC5wf3lh0ACEt5PI0tHC90Jhlp0K2CZ7aWWDA2AksqaXtRMZlkovxXE3RceJv9qgENFQmXyvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKceyPEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1ABC32782;
	Thu,  8 Aug 2024 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723123729;
	bh=H4Z4VQvOjQ9X0WvQzOV4+9YLlvpoaHNvNY2zrwlxgFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DKceyPEFNFKlk/pTYMaqMbGKqLgH7+gz6Ek0tm9WpfAb/eXAfp7ZDG/YoVHq3IBdm
	 5ILdY50pDlqxHRqFR322uh6dFvszLxXt3YKgmEiPtR2pitKIVRnEfAZ/dZqSlixf34
	 820vLMN/A7F8dNb6+/8UBXt+jFd/KjL2n4mQzthSAnZiJ1bua7IvGyPQYi5ea6wA68
	 cXM/Z5tnfLww9xhfsVCE4jWB1n3EpsBF96NjFXqUMUHLWSSXxT6LZSMqxsHqHtq0d5
	 mkUlZeVlCbKkg0uCEnod2z0oSJfeDtlIq3jMuCQItuIuoKbNFUdJ6GaaLMLZ0/l3Qx
	 yR4y85G/243cQ==
Date: Thu, 8 Aug 2024 06:28:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, "David Ahern"
 <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, Simon Horman
 <horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 0/6] net: nexthop: Increase weight to u16
Message-ID: <20240808062847.4eb13f28@kernel.org>
In-Reply-To: <cover.1723036486.git.petrm@nvidia.com>
References: <cover.1723036486.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 16:13:45 +0200 Petr Machata wrote:
> In CLOS networks, as link failures occur at various points in the network,
> ECMP weights of the involved nodes are adjusted to compensate. With high
> fan-out of the involved nodes, and overall high number of nodes,
> a (non-)ECMP weight ratio that we would like to configure does not fit into
> 8 bits. Instead of, say, 255:254, we might like to configure something like
> 1000:999. For these deployments, the 8-bit weight may not be enough.
> 
> To that end, in this patchset increase the next hop weight from u8 to u16.
> 
> Patch #1 adds a flag that indicates whether the reserved fields are zeroed.
> This is a follow-up to a new fix merged in commit 6d745cd0e972 ("net:
> nexthop: Initialize all fields in dumped nexthops"). The theory behind this
> patch is that there is a strict ordering between the fields actually being
> zeroed, the kernel declaring that they are, and the kernel repurposing the
> fields. Thus clients can use the flag to tell if it is safe to interpret
> the reserved fields in any way.
> 
> Patch #2 contains the substantial code and the commit message covers the
> details of the changes.
> 
> Patches #3 to #6 add selftests.

I did update iproute2 to the branch you sent me last time, but tests
are not happy:

# IPv6 groups functional
# ----------------------
# TEST: Create nexthop group with single nexthop                      [ OK ]
# TEST: Get nexthop group by id                                       [ OK ]
# TEST: Delete nexthop group by id                                    [ OK ]
# TEST: Nexthop group with multiple nexthops                          [ OK ]
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop group with weighted nexthops                          [ OK ]
# TEST: Weighted nexthop group updated when entry is deleted          [ OK ]
# TEST: Nexthops in groups removed on admin down                      [ OK ]
# TEST: Multiple groups with same nexthop                             [ OK ]
# TEST: Nexthops in group removed on admin down - mixed group         [ OK ]
# TEST: Nexthop group can not have a group as an entry                [ OK ]
# TEST: Nexthop group with a blackhole entry                          [ OK ]
# TEST: Nexthop group can not have a blackhole and another nexthop    [ OK ]
# TEST: Nexthop group replace refcounts                               [ OK ]
#       WARNING: Unexpected route entry
# TEST: 16-bit weights                                                [FAIL]
# 
# IPv6 resilient groups functional
# --------------------------------
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop buckets updated when entry is deleted                 [ OK ]
# TEST: Nexthop group updated after replace                           [ OK ]
# TEST: Nexthop buckets updated after replace                         [ OK ]
# TEST: Nexthop group updated when entry is deleted - nECMP           [ OK ]
# TEST: Nexthop buckets updated when entry is deleted - nECMP         [ OK ]
# TEST: Nexthop group updated after replace - nECMP                   [ OK ]
# TEST: Nexthop buckets updated after replace - nECMP                 [ OK ]
#       WARNING: Unexpected route entry
# TEST: 16-bit weights                                                [FAIL]

https://netdev-3.bots.linux.dev/vmksft-net/results/718641/2-fib-nexthops-sh/stdout

