Return-Path: <netdev+bounces-249077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5659FD13BCC
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EF303010299
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F307B2E9EB9;
	Mon, 12 Jan 2026 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1nH3+cA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06382E92A6
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231532; cv=none; b=cegntOdM+wiLIuyNorHzc95BWkNxp29sxquiI1C7i3a29SsN6pvep5K3o1upkj8ZQ3C3vT5NRldvVGjbIHRPnq9lHXH2VxMl2HNznTbTd42nPy6PXS3dXajiIJTusQvDW0aeiP2kvvHdVCmg+gQ5jr8UmuBi1/vfnJ+UNW30Fno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231532; c=relaxed/simple;
	bh=aFFPDj+MwESAGnXs+pknAyMyPvTmp0k8iv08YtsJQVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LywSusIzj4XU5jhF7qLuTU5jPgaMaUJ0QRr0fg43JzUIhD8ZLX26/hQf+dysDn0qToIMEZZHm4Hgf0JmhJvvja+/zw/PpbpudeEW8p8R7tatOsF3JI2P1RweJ+x/FavwIifsYokOT6BL4Yr1wom6Yig0Q9rdOlwtI52q2QkXTtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1nH3+cA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3022CC16AAE;
	Mon, 12 Jan 2026 15:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768231532;
	bh=aFFPDj+MwESAGnXs+pknAyMyPvTmp0k8iv08YtsJQVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U1nH3+cAZCpnTsQ/YPuAUBZSpi6Dj982YMwgafH4Bd5BYw0bvX9cakxJm8+B3tird
	 F5RPHm2fVpm1SylODyr0JcdSmkwZ796DLom/sZBZ3F3ZfNcysgOX6FXVTi6RJAROFe
	 FaxcYdJu9v/j+UY6d1pVvWlTqFiDqH5ByqAGe7qhrp0WJB79A4PsSEpd6IJ2qYUmP6
	 MIbf3VUpYySmfk2vgou//6ifK5260xe60c0u2u5ze1SlX/Y4CozackgdcrH4wziqxD
	 IZL6nHiNgOpPeRP4+pE/52K46avrJg2md9u/hPx1J5is4NjCStlMCynirlljk4V0b0
	 X1AK/oknY3zMg==
Message-ID: <e4368ed8-154d-4656-838f-4005287d4394@kernel.org>
Date: Mon, 12 Jan 2026 08:25:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] selftests: fib-onlink: Remove "wrong nexthop
 device" IPv4 tests
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, petrm@nvidia.com
References: <20260111120813.159799-1-idosch@nvidia.com>
 <20260111120813.159799-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260111120813.159799-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/26 5:08 AM, Ido Schimmel wrote:
> According to the test description, these tests fail because of a wrong
> nexthop device:
> 
>  # ./fib-onlink-tests.sh -v
>  [...]
>  COMMAND: ip ro add table 254 169.254.101.102/32 via 169.254.3.1 dev veth1 onlink
>  Error: Nexthop has invalid gateway.
> 
>  TEST: Gateway resolves to wrong nexthop device            [ OK ]
>  COMMAND: ip ro add table 1101 169.254.102.103/32 via 169.254.7.1 dev veth5 onlink
>  Error: Nexthop has invalid gateway.
> 
>  TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
>  [...]
> 
> But this is incorrect. They fail because the gateway addresses are local
> addresses:
> 
>  # ip -4 address show
>  [...]
>  28: veth3@if27: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000 link-netns peer_ns-Urqh3o
>      inet 169.254.3.1/24 scope global veth3
>  [...]
>  32: veth7@if31: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master lisa state UP group default qlen 1000 link-netns peer_ns-Urqh3o
>      inet 169.254.7.1/24 scope global veth7
> 
> Therefore, using a local address that matches the nexthop device fails
> as well:
> 
>  # ip ro add table 254 169.254.101.102/32 via 169.254.3.1 dev veth3 onlink
>  Error: Nexthop has invalid gateway.
> 
> Using a gateway address with a "wrong" nexthop device is actually valid
> and allowed:
> 
>  # ip route get 169.254.1.2
>  169.254.1.2 dev veth1 src 169.254.1.1 uid 0
>  # ip ro add table 254 169.254.101.102/32 via 169.254.1.2 dev veth3 onlink
>  # echo $?
>  0
> 
> Remove these tests given that their output is confusing and that the
> scenario that they are testing is already covered by other tests.
> 
> A subsequent patch will add tests for the nexthop device mismatch
> scenario.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/fib-onlink-tests.sh | 6 ------
>  1 file changed, 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



