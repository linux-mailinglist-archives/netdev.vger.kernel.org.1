Return-Path: <netdev+bounces-223503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030D6B595EA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A122C32149B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A35730BF65;
	Tue, 16 Sep 2025 12:20:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C172D8DDA;
	Tue, 16 Sep 2025 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025239; cv=none; b=l2aEXeNisMYzKjeZkOiIhBzAQDynwattHTTNEclKvrDsorn+60Fm7e9AWdZebcEFroYd2JlM9qpzfWjDcI0wEcF24nvkPiVT/XzfqlJXVlJBadHk13+b3O5AaXOtU8TXxHaix/zNZiwoF1Zhqkm/SrOtuvvZkbtMhcKoEd717ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025239; c=relaxed/simple;
	bh=Ea9+rkswREodz+LF4GSRMjtdY2KBM5WSAG3M5nIxo/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1MJHDuu1ZZ6wwdmJi7TpioSQWZe3Rrz8D372XOuEWtBaqH5kRSnbFfI9wJpGEvyJodE/s9nu3hItDcpQKirupKosT5a2HtMiflrvw4Pxg3G9MeqvwyKo5r02HhYnIjb0dYRlhB6fBa5jxuRIJJ9lVxpoDwEvBWTeSVZRDw3TRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id B1D73340DBF;
	Tue, 16 Sep 2025 12:20:36 +0000 (UTC)
Date: Tue, 16 Sep 2025 20:20:26 +0800
From: Yixun Lan <dlan@gentoo.org>
To: pabeni@redhat.com
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, andrew+netdev@lunn.ch,
	kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, p.zabel@pengutronix.de, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	uwu@dram.page, vadim.fedorenko@linux.dev, junhui.liu@pigmoral.tech,
	horms@kernel.org, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, conor.dooley@microchip.com,
	troy.mitchell@linux.spacemit.com, hendrik.hamerlinck@hammernet.be,
	andrew@lunn.ch
Subject: Re: [PATCH net-next v12 0/5] Add Ethernet MAC support for SpacemiT K1
Message-ID: <20250916122026-GYB1255161@gentoo.org>
References: <20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn>
 <175802161326.713595.16381910315366172301.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175802161326.713595.16381910315366172301.git-patchwork-notify@kernel.org>

Hi Paolo Abeni,

Thanks for taking this series, but I have one comment (see below)

On 11:20 Tue 16 Sep     , patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
> 
> On Sun, 14 Sep 2025 12:23:11 +0800 you wrote:
> > SpacemiT K1 has two gigabit Ethernet MACs with RGMII and RMII support.
> > Add devicetree bindings, driver, and DTS for it.
> > 
> > Tested primarily on BananaPi BPI-F3. Basic TX/RX functionality also
> > tested on Milk-V Jupiter.
> > 
> > I would like to note that even though some bit field names superficially
> > resemble that of DesignWare MAC, all other differences point to it in
> > fact being a custom design.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [net-next,v12,1/5] dt-bindings: net: Add support for SpacemiT K1
>     https://git.kernel.org/netdev/net-next/c/62a12a221769
>   - [net-next,v12,2/5] net: spacemit: Add K1 Ethernet MAC
>     https://git.kernel.org/netdev/net-next/c/bfec6d7f2001
..
>   - [net-next,v12,3/5] riscv: dts: spacemit: Add Ethernet support for K1
>     https://git.kernel.org/netdev/net-next/c/60775f28cfb7
>   - [net-next,v12,4/5] riscv: dts: spacemit: Add Ethernet support for BPI-F3
>     https://git.kernel.org/netdev/net-next/c/3c247a6366d5
>   - [net-next,v12,5/5] riscv: dts: spacemit: Add Ethernet support for Jupiter
>     https://git.kernel.org/netdev/net-next/c/e32dc7a936b1
> 

Generally, I'd expect the DT part patch (3-5) to go via SpacemiT's SoC tree[1],
so, this will avoid potential conflicts..

Can you drop patch 3-5? then I will take care of them, plus there is one more
patch in my queue..

Link: https://github.com/spacemit-com/linux/tree/k1/dt-for-next [1]

-- 
Yixun Lan (dlan)

