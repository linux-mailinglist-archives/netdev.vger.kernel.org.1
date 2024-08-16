Return-Path: <netdev+bounces-119240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4E2954F45
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8002A1C21067
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519281BE238;
	Fri, 16 Aug 2024 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvUSGAgK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C9179A3;
	Fri, 16 Aug 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826718; cv=none; b=t7Bdh48erTPkDfwNlP/eChJspD5XFX1JtbdekrnGe8MNBP+tXziOUfxEx9B16ti16e+BkeVHg3DZNVPUh5wckr0zvh/CSsdpeCqybOnvR/CFuIFA4m328qwkK/2snqGGwOdmPG05teqMaRsZRmBLPlWKO41jKxJlsZrFQbBUSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826718; c=relaxed/simple;
	bh=ZcXXRfvg6StCh0xx6aQyx/fFHFsybqofThgaPF+YYIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1QJT+bzFTyGYOHx7KP+pi0I1qegwD4j1T2HJ/16iaNvKGzzKjVg6+3vO1A1LowPtxkXp9LBhu8aMnMxSoB1DB07lAr/s1dlGjsUCLoJ0c/oURsw/lyi+Lx7McLMi657i0jzoGr6InQqneh8Z4ns44FbBo/QRbO9aKJHtukpeok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvUSGAgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C97C32782;
	Fri, 16 Aug 2024 16:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723826717;
	bh=ZcXXRfvg6StCh0xx6aQyx/fFHFsybqofThgaPF+YYIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvUSGAgKbCqcR38vZd0lacsEJpBmdX36jKk2+oQknNnQt0YNaq9Ji0An5IdlbvvpN
	 gGSEr/ptP88cM1MI4SqAEA0elmo6lMcJPEmagcqegnyMcRhij3SG6a7sxEq4vZUSS0
	 nev8QH38KEa58Hz6caKvTBPOoDuJe/vIAAcOWxGXJnOIHrvqCb61eiDkeGxCLqsUaU
	 TQYsJ7lxX2ekYX4lfSHFpwCJmY784zY8pFrMJtmPIdNtbYg+4MIAuy0hp4iAZAo28E
	 RY9Ql4Q+udgoUrEXqzCiz933xSecBPHnY5Vl52Yv3G9rThLzucNlZC7qC9lkC+/upr
	 haWMh9sWE7BHA==
Date: Fri, 16 Aug 2024 17:45:13 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, willemb@google.com, hramamurthy@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] gve: Remove unused declaration
 gve_rx_alloc_rings()
Message-ID: <20240816164513.GY632411@kernel.org>
References: <20240816101906.882743-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816101906.882743-1-yuehaibing@huawei.com>

On Fri, Aug 16, 2024 at 06:19:06PM +0800, Yue Haibing wrote:
> Commit f13697cc7a19 ("gve: Switch to config-aware queue allocation")
> convert this function to gve_rx_alloc_rings_gqi().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

In future, please consider grouping similar changes, say up to 10,
in a patchset.

