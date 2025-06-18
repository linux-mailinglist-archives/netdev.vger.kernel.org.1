Return-Path: <netdev+bounces-199066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC056ADECD8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E69F188C732
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA778285CA2;
	Wed, 18 Jun 2025 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4q4dPAS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0F145FE0;
	Wed, 18 Jun 2025 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250379; cv=none; b=LTu0XJwykwQmr9+YV9BFoG+djmJNGZrcDpTJ2B1RxMgeLtz0Kyup+KNgJv8cCE6RBfelOQNVW04HXU6VFImlgMCCL9OQX+mtYr3++GgHl1AFZIQAe1N1/XstgHt+FDTxWvDurGN9Hoh7YinuB5qgC8vM2ran+H7onQ3K2UtXOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250379; c=relaxed/simple;
	bh=WG7j8G6GOIk4GTEuTb80cckRD2B1MQmBRHVOT434W38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hi2us/brEnk3yyQs066B10wvLpK7ON4uhI6eFcVH+FfXh+dObuDYs0TOcFzlVkRL1SKpV0TMjkL4Lbwo2gb+nfNDDSDy5A+/ltGR398dRFz2M7ImxKzzITH5NWEzAB8zBFQqlFd38W5rXBslqKNcqvwfFu6EitHEXCAeybRfUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4q4dPAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD17BC4CEE7;
	Wed, 18 Jun 2025 12:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750250379;
	bh=WG7j8G6GOIk4GTEuTb80cckRD2B1MQmBRHVOT434W38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4q4dPASMsbovjTlxIqD3yC4iPmDJDtuKDOHClUD084oQrFRwVfB5RPk9youEtp8q
	 LxAS8xZpTtBGT4/bq2CvIc+4tE9IL9uUx+hj+6mThaDE73v1VrPWjtifDEbDg5+5ie
	 KrAzDPUey8kV3gAK7upUCpF25Pr824GFimEjbkBJHf4gKXhgVk27I6Y64J3H+Sl3qZ
	 A6T3eIKgPlOUb8xuta5CHXlka1gbAAB4vbSKOh8aaBDjr1AmybJLydgHelPLRUuH8w
	 opgUL6KCNR5tlwkgzwz/etBVcsL/scCEh+5gkriE0bLX/AoCjwNo/LyIuiXvMo/hWY
	 NyBtEMBv9tnYA==
Date: Wed, 18 Jun 2025 13:39:33 +0100
From: Simon Horman <horms@kernel.org>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: linux@fw-web.de, nbd@nbd.name, sean.wang@mediatek.com,
	lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, daniel@makrotopia.org,
	arinc.unal@arinc9.com
Subject: Re: Re: [net-next v4 2/3] net: ethernet: mtk_eth_soc: add consts for
 irq index
Message-ID: <20250618123933.GP1699@horms.kernel.org>
References: <20250616080738.117993-1-linux@fw-web.de>
 <20250616080738.117993-3-linux@fw-web.de>
 <20250618083623.GF2545@horms.kernel.org>
 <trinity-86a5b58b-a74a-48be-80ae-aa306e95f214-1750238697100@trinity-msg-rest-gmx-gmx-live-b647dc579-2m42j>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-86a5b58b-a74a-48be-80ae-aa306e95f214-1750238697100@trinity-msg-rest-gmx-gmx-live-b647dc579-2m42j>

On Wed, Jun 18, 2025 at 09:24:57AM +0000, Frank Wunderlich wrote:
> Hi,
> 
> > Gesendet: Mittwoch, 18. Juni 2025 um 10:36
> > Von: "Simon Horman" <horms@kernel.org>
> > Betreff: Re: [net-next v4 2/3] net: ethernet: mtk_eth_soc: add consts for irq index
> >
> > On Mon, Jun 16, 2025 at 10:07:35AM +0200, Frank Wunderlich wrote:
> > > From: Frank Wunderlich <frank-w@public-files.de>
> > > 
> > > Use consts instead of fixed integers for accessing IRQ array.
> > > 
> > > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > > ---
> > > v4:
> > > - calculate max from last (rx) irq index and use it for array size too
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> thanks for review and the RB
> 
> i thinking about changing the const names to this:
> 
> MTK_ETH_IRQ_SHARED	=> MTK_FE_IRQ_SHARED
> MTK_ETH_IRQ_TX		=> MTK_FE_IRQ_TX
> MTK_ETH_IRQ_RX		=> MTK_FE_IRQ_RX
> MTK_ETH_IRQ_MAX		=> MTK_FE_IRQ_NUM
> 
> because of i currently working on RSS/LRO patches and here MTK_FE_IRQ_NUM is used as name 
> with same meaning like my current MTK_ETH_IRQ_MAX (where max should be same as RX and NUM
> is one more because it is a count).
> Current IRQs also target the MTK frame-engine which is different to the PDMA RX engine
> used for RSS/LRO later, so MTK_ETH_IRQ_RX and MTK_ETH_IRQ_MAX are maybe misleading when RSS/LRO 
> support will come in.
> 
> can i change the consts like this and keep your RB?

Yes, no objections from my side.

