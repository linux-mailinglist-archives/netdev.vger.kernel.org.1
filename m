Return-Path: <netdev+bounces-249082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5BBD13BDE
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4983C302FA3D
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63035357727;
	Mon, 12 Jan 2026 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNNi2kxt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8BF359FB3
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231870; cv=none; b=ILr2dTkWtL48gvSZeRMtlQ8m1jHdPhmOv60IdXgyHXRtvmcZ4qu2k073lx6dolopqzHKBMEgnzHoV/IC7Dn93cPEjv6vo0NbycD1TZYo6F/arxOJsJNqfIlhoUfr4nxkDg69fimmAnt2U0YHeOTVixue600/LM905UOm1mPZbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231870; c=relaxed/simple;
	bh=oqkHeg20v0Ctwgx8cUdhq5K8bjfqxApRXloyrEtVQVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syv9KMp+QWz/LV1DOSwQVm+YDZmNwSyKzJAifW0HIRc9u/Zmen+8ZEEw/hNkLsktJyKDN9zPbYIHSvcX0PWtvdtCfAOjQRBFiAkYrP5G7lssbBPUmyMtBVaIR/ZE9y4hguvqanK4pzWKQ62GRPhT6Yp67hE1HulGNhsi+7vgU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNNi2kxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7A9C16AAE;
	Mon, 12 Jan 2026 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768231870;
	bh=oqkHeg20v0Ctwgx8cUdhq5K8bjfqxApRXloyrEtVQVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UNNi2kxtDt6gHAwsjGiVyySptESn1Eo9ol9HIZbpCz0029aYYQoXEiXqd7EvvcFGS
	 br4bCrV2LOlyRUyWoWKSWuaT0KiABGF9EVGfjZOctmKxNpR2oLdJMIgCXBMoOW1lkV
	 RrtImZOnUikNnoKmFT12La8Qo7H8ja5EwbNDtWgVt3jzHNkcXE+QNz0j7VQtE+llcz
	 Uni3nd4weC9LNE5/yeaLjzcNCfGYlBNquRkC9tAUvTom9qUXnWIv8R1zZgU/Mm4sVk
	 5Yynr9IJKI3cM3ECxybgTCH8K4tbkGKo4E50tbtFZfoylK/+S1mwHR2DRuPy4mBX0K
	 n6KyFav/9m+5Q==
Message-ID: <5730342a-b96b-42c0-8945-f7f27cfe1260@kernel.org>
Date: Mon, 12 Jan 2026 08:31:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] selftests: fib-onlink: Add test cases for
 nexthop device mismatch
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, petrm@nvidia.com
References: <20260111120813.159799-1-idosch@nvidia.com>
 <20260111120813.159799-6-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260111120813.159799-6-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/26 5:08 AM, Ido Schimmel wrote:
> Add test cases that verify that when the "onlink" keyword is specified,
> both address families (with and without VRF) accept routes with a
> gateway address that is reachable via a different interface than the one
> specified.
> 
> Output without "ipv6: Allow for nexthop device mismatch with "onlink"":
> 
>  # ./fib-onlink-tests.sh | grep mismatch
>  TEST: nexthop device mismatch                             [ OK ]
>  TEST: nexthop device mismatch                             [ OK ]
>  TEST: nexthop device mismatch                             [FAIL]
>  TEST: nexthop device mismatch                             [FAIL]
> 
> Output with "ipv6: Allow for nexthop device mismatch with "onlink"":
> 
>  # ./fib-onlink-tests.sh | grep mismatch
>  TEST: nexthop device mismatch                             [ OK ]
>  TEST: nexthop device mismatch                             [ OK ]
>  TEST: nexthop device mismatch                             [ OK ]
>  TEST: nexthop device mismatch                             [ OK ]
> 
> That is, the IPv4 tests were always passing, but the IPv6 ones only pass
> after the specified patch.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/fib-onlink-tests.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



