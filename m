Return-Path: <netdev+bounces-145746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989719D09AA
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0611F21387
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 06:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3995014A08E;
	Mon, 18 Nov 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qiY+21o/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jHZIIozn"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4817597;
	Mon, 18 Nov 2024 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731911551; cv=none; b=bNVINHaakVGhZNcUh61z01lkz576vrfaNhQEptLR3BJaxEvYPCgDtxW6aTT2VDXfs6mCENa+3516Y9bDDZY6B2UV6RyIqsymv3V0/J6k23GwA8BffOELg0RDDF1O253/MvvBsk3XHH90PA/ts9oRBOGkv5qojRURgG7Y8UcS6OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731911551; c=relaxed/simple;
	bh=UhgwH34PVq//K2PaLvOWBtV3j8HhKT6IiphyPJfEs6E=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=u5dwJLeXzAYBpUcANnN04RALX+pysCdr8qu1r/+sxjPZLCte2zTYkgmDAyV7ajOh6H9nPxPqIeAn7hHCy7N6dv/XXCb97FLMD66dgWdcstNclxzUqr8TXnpqAdAfOqbPVs/4HwiwtwVBdeSnRrqGRr37rnj41c4dm7Lwud2kXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qiY+21o/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jHZIIozn; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B1E9A1380230;
	Mon, 18 Nov 2024 01:32:25 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 18 Nov 2024 01:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731911545;
	 x=1731997945; bh=PtArSHe6OqREEyBvIEFXeJ+RDsFU75KyOaFO11n3GaE=; b=
	qiY+21o/bWM7WXT5KF2T/ChJrHq2/5qVKkj5Yju2Xdr6T92sdiLLwCRGbEtvV+JE
	+JbdFpAaEqrj/w3S4U914zGbygjCuJaImGTaPGAhD9tKyCnJU/dJ+rn+MdFByyUk
	elSUZU2M6LNjiwY3fkXhlfZBEwW3c3QLFxmFbfzS+U5xv8a8INVaf+V8qvnYr8Nu
	Vl16a2AJVijhG7tvMaC2jOhzkbYYh2VxH08m0oI5NzKB7xwbaUJoN2BamWe7a7Mx
	jbvTrfJuDMDNFy8AY8ptFCTkkWr2BZSU87r4/HJnfMXoA+06ujS5J49wIh8MRujp
	fGUQAGfv1xjy8JbCybN7/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731911545; x=1731997945; bh=P
	tArSHe6OqREEyBvIEFXeJ+RDsFU75KyOaFO11n3GaE=; b=jHZIIoznQZ7TcxUNL
	OOXBvC4o5Eg+T5UQyy1cUCEPV4wnaNX9h9cviZsxfpnavptD/ot0Xa0IMVgroMRm
	LWov6N7JQJo0h9YZTNrTFF3Vdxyc4w69/72T1hMR4+j5Zg2ksulW9t1kvoLFzBBM
	P1AMBC+5LrPfa/bdyLoUaGPPltIiO97iMPjrWBAVA/YolP69NYLa/E2FULAPrT+z
	jblzEPX7E6mXBNlAnzK55PPOGMvwr+3pxbGjgStIEJcqr3BPXszBZSWcf1B/n6AR
	Pv5T9SclHbx9NPLwQD9iICFcHCdxjfBJgRX5uQIUmJHFb7eZxL1iMB//GQjSn03d
	/8QKg==
X-ME-Sender: <xms:eN86Z5YXxtm1Hrie6adQKLGILsVOaKZC77bjfeP_vByWruOElQog6Q>
    <xme:eN86ZwbrxszMvHAPI2cuVl2Y39EIA4-R5ShnL-k97VFJsRd0Cc-DKoJuidWtqIyEX
    9y7mO49FZTsNRvmpg4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecu
    hfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvg
    eqnecuggftrfgrthhtvghrnhephfekledtffefhffghfetteehuefhgfetgefhtdeufedu
    ueeltefghedtjeeifffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehjrggtkhihpggthhhouhesrghsphgvvg
    guthgvtghhrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdought
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgv
    fidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepphdriigrsggvlhesphgvnh
    hguhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:eN86Z7_NwbygezGvZxC6RAqet2uq3vF5UyRu_linf2MaWyRyEot6lQ>
    <xmx:eN86Z3qgVRDlcZPEXo96CJv7C83J_2cAOQ4XmNYCR92S9eIU1Iy56w>
    <xmx:eN86Z0q0XtvnT5yldtyDdTOJGxAloql4lHDRhP9pOzRhTF3Q3OKJYA>
    <xmx:eN86Z9Tba16-bRHEA6NqOpVE2-G-Jovop8M8olOFJFe0OfBvEGIH0w>
    <xmx:ed86Z6jpnIvj9RNgX3pci9tRHArA2GJVSmc4v1gL_I_z3wO4a7FJx8TZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B967A2220071; Mon, 18 Nov 2024 01:32:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 07:32:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jacky Chou" <jacky_chou@aspeedtech.com>, andrew+netdev@lunn.ch,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>,
 krzk+dt@kernel.org, "Conor Dooley" <conor+dt@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, Netdev <netdev@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <6a7570d0-2b3d-4403-afb1-f95433ad6ecb@app.fastmail.com>
In-Reply-To: <20241118060207.141048-4-jacky_chou@aspeedtech.com>
References: <20241118060207.141048-1-jacky_chou@aspeedtech.com>
 <20241118060207.141048-4-jacky_chou@aspeedtech.com>
Subject: Re: [net-next v2 3/7] net: ftgmac100: Add reset toggling for Aspeed SOCs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 18, 2024, at 07:02, Jacky Chou wrote:
> @@ -1969,10 +1971,29 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  	}
> 
>  	if (priv->is_aspeed) {
> +		struct reset_control *rst;
> +
>  		err = ftgmac100_setup_clk(priv);
>  		if (err)
>  			goto err_phy_connect;
> 
> +		rst = devm_reset_control_get_optional(priv->dev, NULL);
> +		if (IS_ERR(rst))
> +			goto err_register_netdev;
> +		priv->rst = rst;
> +
> +		err = reset_control_assert(priv->rst);

Since that reset line is optional, how about making it
part of the normal probe procedure, not just the if(aspeed)
section? It seems this does nothing for older devices but
may help for future ones regardless of the SoC family.

      Arnd

