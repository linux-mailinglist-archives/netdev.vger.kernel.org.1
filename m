Return-Path: <netdev+bounces-249081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B96D13C20
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25CB43025187
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E152D3002D1;
	Mon, 12 Jan 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqLaAq9N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97962FFFBE
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231771; cv=none; b=I4X3HGmzngEJLv+5EE3jxrviU4F0KL0RSkN5ZC/ra1ttBXTXQju6YDhT2pGW4tYFpUuCUTupLeg+83X8jKvRwgtkV6caWve5eHw97JtMTFKw8N3MNwYDQYDXIZNNYK5r2GvcE3+24LDg1AdJYLEgns0iDB5KWYX+3DoCpo8yOsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231771; c=relaxed/simple;
	bh=JV5JamZ7YJUbQxGFL19shLo2uCr+K7opl0kHJDfw0P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABrRLfWszL2WqYtu2UyFqols9cpVXMQZZH1OwWE7ViZ/8FrKi/S2veaM1dp6h+wbPJmJzfi0ENyZ0GaDVHpkzB6pf029vRA7bkrgiwgZgNr4L4ywoYca7PTsICqeeLZA49401lDhVrNZtVl7t7+OXSjL0t+zIPtBBi+xHpWPXpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqLaAq9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEC2C16AAE;
	Mon, 12 Jan 2026 15:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768231771;
	bh=JV5JamZ7YJUbQxGFL19shLo2uCr+K7opl0kHJDfw0P4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OqLaAq9Nq09k23YRsPz4Jd3evdrfaGBfWyvoafXNH2WMa/6iFtCBokfwtRoAkCUvS
	 kCL3H+wCvaiexYNnKR89cVG+wUArrep55eErx4517t/wQzF1uGtMtYU2FmCkWpJPlR
	 7yPQ9j4JztxsQGr3bmKwYO5B+oyjVjrTU1YSL6BBenruslRePrLvNccT8xbCVLmPr5
	 ouWLwSsPRq3FNigDL8gKoK9fpwNtdHGQWLD2l14cTzyKh2Nw2nQC3/qbPgYzldYqFc
	 2mUsKbF177frfGuBcyrsevkZ9/+XTOSVg4lC99l00JQRffFMyTpqt2UH7hNX04TW9h
	 SQc0qvUImKWMQ==
Message-ID: <e843db42-b38d-4987-91ca-3cc204fc2915@kernel.org>
Date: Mon, 12 Jan 2026 08:29:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] ipv6: Allow for nexthop device mismatch with
 "onlink"
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, petrm@nvidia.com
References: <20260111120813.159799-1-idosch@nvidia.com>
 <20260111120813.159799-5-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260111120813.159799-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/26 5:08 AM, Ido Schimmel wrote:
> IPv4 allows for a nexthop device mismatch when the "onlink" keyword is
> specified:
> 
>  # ip link add name dummy1 up type dummy
>  # ip address add 192.0.2.1/24 dev dummy1
>  # ip link add name dummy2 up type dummy
>  # ip route add 198.51.100.0/24 nexthop via 192.0.2.2 dev dummy2
>  Error: Nexthop has invalid gateway.
>  # ip route add 198.51.100.0/24 nexthop via 192.0.2.2 dev dummy2 onlink
>  # echo $?
>  0
> 
> This seems to be consistent with the description of "onlink" in the
> ip-route man page: "Pretend that the nexthop is directly attached to
> this link, even if it does not match any interface prefix".
> 
> On the other hand, IPv6 rejects a nexthop device mismatch, even when
> "onlink" is specified:
> 
>  # ip link add name dummy1 up type dummy
>  # ip address add 2001:db8:1::1/64 dev dummy1
>  # ip link add name dummy2 up type dummy
>  # ip route add 2001:db8:10::/64 nexthop via 2001:db8:1::2 dev dummy2
>  RTNETLINK answers: No route to host
>  # ip route add 2001:db8:10::/64 nexthop via 2001:db8:1::2 dev dummy2 onlink
>  Error: Nexthop has invalid gateway or device mismatch.
> 
> This is intentional according to commit fc1e64e1092f ("net/ipv6: Add
> support for onlink flag") which added IPv6 "onlink" support and states
> that "any unicast gateway is allowed as long as the gateway is not a
> local address and if it resolves it must match the given device".
> 
> The condition was later relaxed in commit 4ed591c8ab44 ("net/ipv6: Allow
> onlink routes to have a device mismatch if it is the default route") to
> allow for a nexthop device mismatch if the gateway address is resolved
> via the default route:
> 
>  # ip link add name dummy1 up type dummy
>  # ip route add ::/0 dev dummy1
>  # ip link add name dummy2 up type dummy
>  # ip route add 2001:db8:10::/64 nexthop via 2001:db8:1::2 dev dummy2
>  RTNETLINK answers: No route to host
>  # ip route add 2001:db8:10::/64 nexthop via 2001:db8:1::2 dev dummy2 onlink
>  # echo $?
>  0
> 
> While the decision to forbid a nexthop device mismatch in IPv6 seems to
> be intentional, it is unclear why it was made. Especially when it
> differs from IPv4 and seems to go against the intended behavior of
> "onlink".
> 
> Therefore, relax the condition further and allow for a nexthop device
> mismatch when "onlink" is specified:
> 
>  # ip link add name dummy1 up type dummy
>  # ip address add 2001:db8:1::1/64 dev dummy1
>  # ip link add name dummy2 up type dummy
>  # ip route add 2001:db8:10::/64 nexthop via 2001:db8:1::2 dev dummy2 onlink
>  # echo $?
>  0
> 
> The motivating use case is the fact that FRR would like to be able to
> configure overlay routes of the following form:
> 
>  # ip route add <host-Z> vrf <VRF> encap ip id <ID> src <VTEP-A> dst <VTEP-Z> via <VTEP-Z> dev vxlan0 onlink
> 
> Where vxlan0 is in the default VRF in which "VTEP-Z" is reachable via
> one of the underlay routes (e.g., via swpX). Without this patch, the
> above only works with IPv4, but not with IPv6.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/route.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



