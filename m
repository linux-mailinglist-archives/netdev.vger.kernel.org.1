Return-Path: <netdev+bounces-145160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0839CD5D2
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536071F220BD
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6D414F9D9;
	Fri, 15 Nov 2024 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhpdQXWr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D442D052;
	Fri, 15 Nov 2024 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731640924; cv=none; b=ua46sqwQc1nYUq30ipW8YQj/wN4SWhtghYJQADMjIo3B2DxQBtLLytFMFScXzUzcK0fljuMrwUY4G1Yx/4PceGDcrxwxR+fDVnIYegpYB6zCHqlHNm20qNpLujdZvv8Wxci3lJQSpNkocjtJSXs/aRbyUEKVZ5pysgiLG5uZTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731640924; c=relaxed/simple;
	bh=hbfvdurmQjEVxYb6k7AOAGgfnneezr5EVZ7PBjoghW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VvG6M0Yo4gKn3UoEF8z0RKzlck/TPxdLpesC5s7ZAZ5SV0pNOiS+utg4vA/ymSQKXCBHtDon+O/41Y4pWorDjLljClgU3GFa5vot8fr7yQ0yNMh4kRAxMFdmPZwh0bsXsC6LYlStt1pBF+6YbUQVs1QP+H0nVX44s/XsfMWNeFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhpdQXWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8D0C4CECD;
	Fri, 15 Nov 2024 03:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731640924;
	bh=hbfvdurmQjEVxYb6k7AOAGgfnneezr5EVZ7PBjoghW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lhpdQXWrz/EBT1Qf7tnSUwgb1Wk5EF1S5pJliSXTPUUFsTk/J5ZbUjY5p60gu5EKH
	 y/fQLTC8qBgENpQ1tSnpmOrwcaveVVYzeeTY+rWcwt3tuDICjfC2G95Wd1xHuq9Zh3
	 IHcNWdCfbhxRANZwlWF6FiLAvrdEGazO+lUaBDGhxi2sqdbjRdCUcnDaT0NMfDTyrg
	 aZo5nhDiFKBXWEC4XCcPuGgN7QKipi3iroYA21u4jABCqHiuAMbTa/7O8earrfK52y
	 JMQw8i4CaxOqY6iijDAC4mCqrARM2JZDNyCuorVxNSCxo/zVl0HawOGebv0MdT0NWt
	 a/1d+DVKifdSA==
Date: Thu, 14 Nov 2024 19:22:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
Subject: Re: [net-next PATCH v5 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <20241114192202.215869ed@kernel.org>
In-Reply-To: <20241112204743.6710-4-ansuelsmth@gmail.com>
References: <20241112204743.6710-1-ansuelsmth@gmail.com>
	<20241112204743.6710-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 21:47:26 +0100 Christian Marangi wrote:
> +	MIB_DESC(1, 0x00, "TxDrop"),
> +	MIB_DESC(1, 0x04, "TxCrcErr"),

What is a CRC Tx error :o 
Just out of curiosity, not saying its worng.

> +	MIB_DESC(1, 0x08, "TxUnicast"),
> +	MIB_DESC(1, 0x0c, "TxMulticast"),
> +	MIB_DESC(1, 0x10, "TxBroadcast"),
> +	MIB_DESC(1, 0x14, "TxCollision"),

Why can't these be rtnl stats, please keep in mind that we ask that
people don't duplicate in ethtool -S what can be exposed via standard
stats

> +	MIB_DESC(1, 0x18, "TxSingleCollision"),
> +	MIB_DESC(1, 0x1c, "TxMultipleCollision"),
> +	MIB_DESC(1, 0x20, "TxDeferred"),
> +	MIB_DESC(1, 0x24, "TxLateCollision"),
> +	MIB_DESC(1, 0x28, "TxExcessiveCollistion"),
> +	MIB_DESC(1, 0x2c, "TxPause"),
> +	MIB_DESC(1, 0x30, "TxPktSz64"),
> +	MIB_DESC(1, 0x34, "TxPktSz65To127"),
> +	MIB_DESC(1, 0x38, "TxPktSz128To255"),
> +	MIB_DESC(1, 0x3c, "TxPktSz256To511"),
> +	MIB_DESC(1, 0x40, "TxPktSz512To1023"),
> +	MIB_DESC(1, 0x44, "TxPktSz1024To1518"),
> +	MIB_DESC(1, 0x48, "TxPktSz1519ToMax"),

we have standard stats for rmon, too

> +	MIB_DESC(2, 0x4c, "TxBytes"),
> +	MIB_DESC(1, 0x54, "TxOversizeDrop"),
> +	MIB_DESC(2, 0x58, "TxBadPktBytes"),
> +	MIB_DESC(1, 0x80, "RxDrop"),
> +	MIB_DESC(1, 0x84, "RxFiltering"),
> +	MIB_DESC(1, 0x88, "RxUnicast"),
> +	MIB_DESC(1, 0x8c, "RxMulticast"),
> +	MIB_DESC(1, 0x90, "RxBroadcast"),
> +	MIB_DESC(1, 0x94, "RxAlignErr"),
> +	MIB_DESC(1, 0x98, "RxCrcErr"),
> +	MIB_DESC(1, 0x9c, "RxUnderSizeErr"),
> +	MIB_DESC(1, 0xa0, "RxFragErr"),
> +	MIB_DESC(1, 0xa4, "RxOverSzErr"),
> +	MIB_DESC(1, 0xa8, "RxJabberErr"),
> +	MIB_DESC(1, 0xac, "RxPause"),
> +	MIB_DESC(1, 0xb0, "RxPktSz64"),
> +	MIB_DESC(1, 0xb4, "RxPktSz65To127"),
> +	MIB_DESC(1, 0xb8, "RxPktSz128To255"),
> +	MIB_DESC(1, 0xbc, "RxPktSz256To511"),
> +	MIB_DESC(1, 0xc0, "RxPktSz512To1023"),
> +	MIB_DESC(1, 0xc4, "RxPktSz1024To1518"),
> +	MIB_DESC(1, 0xc8, "RxPktSz1519ToMax"),
> +	MIB_DESC(2, 0xcc, "RxBytes"),
> +	MIB_DESC(1, 0xd4, "RxCtrlDrop"),
> +	MIB_DESC(1, 0xd8, "RxIngressDrop"),
> +	MIB_DESC(1, 0xdc, "RxArlDrop"),
> +	MIB_DESC(1, 0xe0, "FlowControlDrop"),
> +	MIB_DESC(1, 0xe4, "WredDrop"),
> +	MIB_DESC(1, 0xe8, "MirrorDrop"),
> +	MIB_DESC(2, 0xec, "RxBadPktBytes"),
> +	MIB_DESC(1, 0xf4, "RxsFlowSamplingPktDrop"),
> +	MIB_DESC(1, 0xf8, "RxsFlowTotalPktDrop"),
> +	MIB_DESC(1, 0xfc, "PortControlDrop"),
-- 
pw-bot: cr

