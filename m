Return-Path: <netdev+bounces-174147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109B2A5D9A8
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946383B46A0
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9EB23A9B7;
	Wed, 12 Mar 2025 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0AXphbx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8DC23A9AE
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772222; cv=none; b=jRMd5GSxmxRc+yrHnF9FBymwoDJPbA8ni9g4Rwov2lRa1ozwEV4Qg2CgDgvRNxPD7C/CqzzLpw3lVN3xrYRi79lMAtdTgyRGkgzKfZt3bdkOrZzo/u7GLsjcL1sXk1XLTYVczG4N6LiFSxKAW8qJmLxaTndVUYEL59WU5cgVVN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772222; c=relaxed/simple;
	bh=73lsR/tyS+QRbbffVcBxNPxPcqJay8bXvq9rxpso3zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozWxA+SGEpx8cGgQ5tKTmdmsouygzoh87MeCYDd4fuR+0rsyADMatqiHxN4jKFvkJyYdNCdDVvhLW97AARZM87FuMvEHi4Kt9bT9GzuC+modBeBX54G2UamzkqkcFq4lauknkfgNegqfGu8Fp9ilyuKHjiEuRipB/ymA5jfcc2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0AXphbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC2EC4CEE3;
	Wed, 12 Mar 2025 09:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741772221;
	bh=73lsR/tyS+QRbbffVcBxNPxPcqJay8bXvq9rxpso3zo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m0AXphbxwdcWfItJOXX1DY9CiFwlvFUa2P0DPfjin2TEvVNsEW/O3R2qYpBf+ytZy
	 osyp1gR34tvPt1rpfyhEpYKhXzff1djKimoBCgB2d0HatOXB4JyeVWOxV5IIR4148T
	 tdAmz4fT8gshB0hoLF8mA1D4cXZo9bz/dpNq4JXjDaXaPr+YLeGw+eF+Xke7UnzNvX
	 iJI+uzdggVW1GzIFNIKInXoTs/Fpnof4cVi0IC/hAE2AWzT7QqbykXdgVuJ6omDndD
	 L6TfQE708Tex6fCVJBTqBgbfhXVDRe8rWlcUjfeYJm0SL5XiOfRfaW56i1Qj45iMUd
	 Wmj7J7XWLV8UQ==
Message-ID: <69218ae8-f10e-4d9b-9f60-dae863da11f0@kernel.org>
Date: Wed, 12 Mar 2025 10:36:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] ipv6: Set errno after ip_fib_metrics_init() in
 ip6_route_info_create().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20250312013854.61125-1-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250312013854.61125-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 2:38 AM, Kuniyuki Iwashima wrote:
> While creating a new IPv6, we could get a weird -ENOMEM when
> RTA_NH_ID is set and either of the conditions below is true:
> 
>   1) CONFIG_IPV6_SUBTREES is enabled and rtm_src_len is specified
>   2) nexthop_get() fails
> 
> e.g.)
> 
>   # strace ip -6 route add fe80::dead:beef:dead:beef nhid 1 from ::
>   recvmsg(3, {msg_iov=[{iov_base=[...[
>     {error=-ENOMEM, msg=[... [...]]},
>     [{nla_len=49, nla_type=NLMSGERR_ATTR_MSG}, "Nexthops can not be used with so"...]
>   ]], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 148
> 
> Let's set err explicitly after ip_fib_metrics_init() in
> ip6_route_info_create().
> 
> Fixes: f88d8ea67fbd ("ipv6: Plumb support for nexthop object in a fib6_info")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv6/route.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



