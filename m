Return-Path: <netdev+bounces-187350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838A0AA680F
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 02:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD99C46648B
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B2735950;
	Fri,  2 May 2025 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoKfvxiY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEFB2576;
	Fri,  2 May 2025 00:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746147438; cv=none; b=Pjn4rxjIsELNyol0BlvrqMy0OwxmZrEhdo79lMiFg2z/b58An0dBSY04u38wuDQ9RYwuJsIfFL8e5kgsXu/tF5ipvMLS5wrRSy3k7AgJCUCtUOQi7lKH1piEapDoaf8coRIjmsOURS5efD6+I926/L4da+50ITtHuPqfPRdpgGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746147438; c=relaxed/simple;
	bh=MoqpqiYmYsjQ16yN73Y7SVxbPLWAuOZzKEnuNo+e/Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3bZ/KwxwGJStkWV76f9SK+RIKyUbogFMfhaPzG5AHjEFRd7tIslEFQ8huv2oNIrOaqYfH/FkhqikuiyDV/i6ZDJygZJGfWMcMxgUSqkCq6uagr6glYKLZ8tJYB/bszy1hJux6axJPcghOdy2IPOvCbx7jPMVRoN1Sw4ICx1HAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoKfvxiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C32C4CEE3;
	Fri,  2 May 2025 00:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746147435;
	bh=MoqpqiYmYsjQ16yN73Y7SVxbPLWAuOZzKEnuNo+e/Lw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KoKfvxiYkOFnahr34ekNz23PL+yeDdfBJIyL5MdW8IwgD0IxzGRGB6VjzXjXmh1aJ
	 at5E4VYqg8hLg0DsqD41btJu+cgTTmJNJbd1+qVpO+4kMU5UKr72cev98KbpnZMQ5b
	 +1LI5ukrFFsaiVwKcG+5V/1/p4aEGnSpzQiiuv4JlZfMLolyRq6Vg5Zka5FBjltgpQ
	 MUgpUz5K9yhFMDyypTBEHbytEUITAt/a375ixRBuBqq3IkwcYzPju4XV6fNUb3uy0e
	 hnJIGJYYxS+gPLYSfTCKwsOvOelO/wDOLQLT2QnTuJgcG3zgydww5cKZqmskvfJC2E
	 2INRE/s0errdA==
Date: Thu, 1 May 2025 17:57:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v9 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250501175713.54aa656e@kernel.org>
In-Reply-To: <20250430051756.574067-5-lukma@denx.de>
References: <20250430051756.574067-1-lukma@denx.de>
	<20250430051756.574067-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 07:17:53 +0200 Lukasz Majewski wrote:
> +static int __init mtip_switch_dma_init(struct switch_enet_private *fep)
> +{
...
> +}

> +static int mtip_sw_probe(struct platform_device *pdev)

One more warning:

WARNING: modpost: drivers/net/ethernet/freescale/mtipsw/nxp-mtipl2sw: section mismatch in reference: mtip_sw_probe+0xa50 (section: .text) -> mtip_switch_dma_init (section: .init.text)

We only see it with clang, not sure why. The warning looks legit.
-- 
pw-bot: cr

