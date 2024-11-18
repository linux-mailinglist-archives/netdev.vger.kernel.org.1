Return-Path: <netdev+bounces-145747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575D19D09AD
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0181D1F212B5
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 06:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48771465AB;
	Mon, 18 Nov 2024 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="f26oMOTx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ByVYC1jS"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3D417597;
	Mon, 18 Nov 2024 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731911687; cv=none; b=rQhHIX7JZlO3CC5PGp9rP4QPsJlW8G1Np83H/ATrga91P/uhx3e4niUJroQQEzWpFMdhBC4/Rx8jlxnPexGmQDaHLKw0hyMJGqBVOzodRiky3dltiAcZbxxmHuLSt2XYV7FFDc67H/i2yMxa0W7K5IF4CtEPwLBXl4dPtjksMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731911687; c=relaxed/simple;
	bh=IYIjzg8kyvzmuFMU/4DUw+BitkdNe7qrwPBfrFApES8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KwLOxGovVn8Rm69svm/krB3Lgjec0ukXHqMzrQosxWp4FpFLTnYfJM3Ah7MI51fSTfkani8pHDB8ShE3umkoCesJdK++JqKNF6WRv2QWZE1ti1vS6Ph45Juad0m4tDfRZVzOL5SnkCym2FIm1Nh6v8umIaL2Tc4C1CvBNbZwPyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=f26oMOTx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ByVYC1jS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 64F661140173;
	Mon, 18 Nov 2024 01:34:44 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 18 Nov 2024 01:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731911684;
	 x=1731998084; bh=hcVuGCXpjh4sHO0KZot3UFeVaekGrZHYxmKg3dP00JU=; b=
	f26oMOTxjQ1y4UA0i8OttMyxO9ckgi/0AAEIWvKdehgRSW37ELwWLjEtYJC1/nJ2
	Vu+eopIkuXLAtUQKZgf6eTWzAq1AEXze3LUAVAmzaU9OUXW1GXuB6gb3lmCuI+wy
	0Ay8+mQwR0TH4E3fXVHnoiIpqM4GYzSOJxBWZS0BHCJGiGZ6etlBlI+Q9BgfNGtR
	1H0yRzHfoBtKFy3Z8EaglBmog0FIeSrBDWup+4F6uSeZUwtDwWtawxOh0QCA9XgZ
	Bm7Ii0+wFA2AlEJfTNnjSL0tkQQZvIYktcxoUd8d8NKUNbxwcWXsNkzAdrjUcONB
	hogv2hk3wKxWR/QTyOIlCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731911684; x=1731998084; bh=h
	cVuGCXpjh4sHO0KZot3UFeVaekGrZHYxmKg3dP00JU=; b=ByVYC1jSCEG+tqq0j
	FL2lKfjHx6M9OG1U8EnIu5R80pYk8g8TyoLOO4zrzvJsG2wV9zfJKPs/nBgqFWrG
	jemrWh/EZBTEwIhlBaFRTOGIWw9mLhouH6auQCmgCkkMe9JbgCw+u4e6QaWHX4Ac
	sItf6/Q/ePqOocR1OTbay9I/0nfsDVklPu9bM1ojOF6kjijMokXIkM//s4Hc/TbM
	p8Iu4HyQTQZJ4+DxoAGSKWD2ltEgIpZfF8GMRDc1+OZdjnxGE6UpiOfbkiwRFY19
	f0XCeP4UU5/VeId1ft+wh46lGGjqhry8pVsbIm8Mhw+6u6/GN6EY4cPMUiIeZSFJ
	ttfpw==
X-ME-Sender: <xms:BOA6Z0Q0T-oEZnPGNiKVH_JiCGto2a8yh_7mONKoaAHewtR7TRs7rA>
    <xme:BOA6Zxx1VFs01CbMiZqGHHlSmwoQKGe9LhLslA6SYbzBGrWmqs5eSF1a6_Q_cekvH
    R-mu1t2zLMxmY2bfX8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecu
    hfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvg
    eqnecuggftrfgrthhtvghrnhephfekledtffefhffghfetteehuefhgfetgefhtdeufedu
    ueeltefghedtjeeifffhnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehjrggtkhihpggthhhouhesrghsphgvvg
    guthgvtghhrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdought
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgv
    fidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepphdriigrsggvlhesphgvnh
    hguhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:BOA6Zx1dXfkqH5sxerWQJZU5WioiWHtptgPGwlGQG1MbeSftWrfr3w>
    <xmx:BOA6Z4AfCFCd_GLCdNZc_mXIRy922ujzdF4YZ2SVY8d5wR5v47XrXg>
    <xmx:BOA6Z9gtBqYDxUV35AdkNZ39zdmjcEX65cP1oamlK_kofpC3a6m1xw>
    <xmx:BOA6Z0ox2FF9kt7pvbT_O0n99yHqdCmtwJYNn6kNluVYWuczKGCClA>
    <xmx:BOA6Z2acTbc-bdrz_g_BePaeOxeJvF-EaCgHttpHxNmFYHYdddSbO-_1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1F0652220072; Mon, 18 Nov 2024 01:34:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 07:34:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jacky Chou" <jacky_chou@aspeedtech.com>, andrew+netdev@lunn.ch,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>,
 krzk+dt@kernel.org, "Conor Dooley" <conor+dt@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, Netdev <netdev@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <4b1a9090-4134-4f77-a380-5ead03fd8ba8@app.fastmail.com>
In-Reply-To: <20241118060207.141048-6-jacky_chou@aspeedtech.com>
References: <20241118060207.141048-1-jacky_chou@aspeedtech.com>
 <20241118060207.141048-6-jacky_chou@aspeedtech.com>
Subject: Re: [net-next v2 5/7] net: ftgmac100: add pin strap configuration for AST2700
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 18, 2024, at 07:02, Jacky Chou wrote:
> @@ -351,6 +352,10 @@ static void ftgmac100_start_hw(struct ftgmac100 *priv)
>  	if (priv->netdev->features & NETIF_F_HW_VLAN_CTAG_RX)
>  		maccr |= FTGMAC100_MACCR_RM_VLAN;
> 
> +	if (of_device_is_compatible(priv->dev->of_node, "aspeed,ast2700-mac") 
> &&
> +	    phydev && phydev->interface == PHY_INTERFACE_MODE_RMII)
> +		maccr |= FTGMAC100_MACCR_RMII_ENABLE;
> +
>  	/* Hit the HW */

Is there a way to probe the presence of 64-bit addressing from
hardware registers? That would be nicer than triggering it from
the compatible string, given that any future SoC is likely
also 64-bit.

      Arnd

