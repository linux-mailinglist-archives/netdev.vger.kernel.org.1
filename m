Return-Path: <netdev+bounces-181196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799E6A840C0
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A37418998B7
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04807276057;
	Thu, 10 Apr 2025 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mHBP0RAB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovFQjNzg"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5420FA96;
	Thu, 10 Apr 2025 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281234; cv=none; b=NRYm1W944yuRzv0Bh92SwRo/qwRwntl2rxQYAr9FVrnmZLMl9Df78WfMd8+EUCsraBeiY0sSHAyJzH5BoRxpWg1+SmtBhaGWOW4mYsupqZqAZhYuFx41QJKcZSWWfARlUqVs3CP7EUgP8HGJ/J07lyX4MtuJGbo0gGKsD6jZNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281234; c=relaxed/simple;
	bh=6vCuOw2AeDWeVIVYtKX4ef9E4C/7BOqizkflg20ZiBg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=f9wBT1xmTJaWsPOoTF2H94mdeD5PPldvruEwC8xd1SIzFFflcm6s9LKecWmc2X5am75ekTtbUDF9JkPJY0jZ0qdaA6dfhnc9LNRVFHciqPuy34FrJ9P5V1CYZtTvy0mXHvip1dW6+cz8FmteOjGFdvbUR0bXoqDmIt0Sy4X17Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mHBP0RAB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovFQjNzg; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 89650114011B;
	Thu, 10 Apr 2025 06:33:51 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Thu, 10 Apr 2025 06:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744281231;
	 x=1744367631; bh=9ZVsy+u8Fm3uzDsHWAx5pSIoB+hcG1H+DFlE95sUZDk=; b=
	mHBP0RABN5/evqVdcLDafmhl/eBw+M8nMrynhaOcdKy/1G4/dJ8ZIvWZPQtZwrqR
	wEQ/rEyZwjZeU21ivpR/clvDqcMawCfeZZ+uqwwT286xP9mF0sD/Lx8ZI5Yn7+hf
	gCFHRwXiG1eRn0FqhwQY5hH81vXPnl7edxk+3lIlI3wnL9ls4hb1FceIW4GKcJrD
	O4IeZzzfx4NKHucUoC3TFWEkpSqwC2j2MrN9MZVEeZ2LQCP1Dx551p3trneK16WU
	0uj4Dfr7UBQWH2Wokc9dfJUW9bU2cE+/4OeOzaI90wO5i9VkhuXQjix9vcChGQYs
	jHr+osC4ZTq/BmbVooU/OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744281231; x=1744367631; bh=9
	ZVsy+u8Fm3uzDsHWAx5pSIoB+hcG1H+DFlE95sUZDk=; b=ovFQjNzgb8yOF8q9w
	d7yGWos9r4QP2XSEvKfAjMPCm5ZFSh2JOG68wzQnmjIGo63fR83ZMJf2JTgWVkzX
	gUX5c/zZOKyxiFqUuWV/XMc6ovhDf2U8aGC6gxZCx3aw9GGsslb6+rx1RQjaZHdV
	CKGdl3LDlA1rF8+HoDE3Wt2VoasKDIqfedhcHc7dt3tcHwjUinDTAdl9lr7oUGqB
	MO1mi8iqHK93pZdc6SoACgcWhx95SnJQGp57wgx/g/6rrPa+1odEdA8cHSuBJnP9
	YGPSCS2G19vZQ8Rni0h6Xh7h2tKEhosUwRriGvGU50rQ7JTFrjeRQrCY+b9flpE0
	wiYyA==
X-ME-Sender: <xms:jp73Zzr5u-2-yT9r7klL04Sd2xqNZznM6aocr4Xa-aEr86MyGEgo3Q>
    <xme:jp73Z9pVYXBIAs2spukj08uR50buHfrv_G3MiZsb4RiVGISI3QLsVbLMmPpfGASNh
    IHeczReCFie6Lci8ZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhkeeltdfffefhgffhteetheeuhffgteeghfdt
    ueefudeuleetgfehtdejieffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuh
    igrdhorhhgrdhukhdprhgtphhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggv
    lhhrvghgnhhosegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhhsuhgvlhhsmhhthhesghhmrghi
    lhdrtghomhdprhgtphhtthhopeguqhhfvgigthesghhmrghilhdrtghomhdprhgtphhtth
    hopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhh
    ihgrshdrsghgghesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdr
    ohhrgh
X-ME-Proxy: <xmx:jp73ZwPC63QEjRg65RleGg8mfcepyNDhKYQUe8Selt8Jrx69I0ccHg>
    <xmx:jp73Z265V1Lf2vQ8Us6g9e3cQCqXCm0Kky-VebrGT9lSbSU4r40RGg>
    <xmx:jp73Zy6MnnFR-j5t26EMKK9WpKZpPqs-_Y5MlKMfLQzMes8_NEF0_w>
    <xmx:jp73Z-ifwXGMhy6al8aPiEPEIycQWjnMdDJ_1eNT7CtWWx0vSJuTvA>
    <xmx:j573Z7yro9JETGk1AI_wDdM2v3NkVIDK4BCsdAKzbp2Qqqy9ZsQG4NyS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7851E2220074; Thu, 10 Apr 2025 06:33:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T36728e73d2ba2577
Date: Thu, 10 Apr 2025 12:33:27 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Marangi" <ansuelsmth@gmail.com>,
 "Andrew Lunn" <andrew@lunn.ch>, "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Daniel Golle" <daniel@makrotopia.org>,
 "Qingfang Deng" <dqfext@gmail.com>,
 "SkyLake Huang" <SkyLake.Huang@mediatek.com>,
 "Matthias Brugger" <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Simon Horman" <horms@kernel.org>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Message-Id: <11698ed8-e607-4c21-bfa7-a0b7731d0d1e@app.fastmail.com>
In-Reply-To: <20250410100410.348-2-ansuelsmth@gmail.com>
References: <20250410100410.348-1-ansuelsmth@gmail.com>
 <20250410100410.348-2-ansuelsmth@gmail.com>
Subject: Re: [net-next PATCH v2 2/2] net: phy: mediatek: add Airoha PHY ID to SoC
 driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Apr 10, 2025, at 12:04, Christian Marangi wrote:
> 
>  config MEDIATEK_GE_SOC_PHY
>  	tristate "MediaTek SoC Ethernet PHYs"
> -	depends on (ARM64 && ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || COMPILE_TEST
> +	depends on ARM64 || COMPILE_TEST
> +	depends on ARCH_AIROHA || (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || \
> +		   COMPILE_TEST
>  	select MTK_NET_PHYLIB
>  	help
>  	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.

This now also fails for non-compile-test builds with
NVMEM=m, ARCH_MEDIATEK=n, ARCH_AIROHA=y and MEDIATEK_GE_SOC_PHY=y.

     Arnd

