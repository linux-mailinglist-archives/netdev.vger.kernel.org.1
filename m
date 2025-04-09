Return-Path: <netdev+bounces-180613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C73A81DFB
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588433BFFC2
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4994222D7AF;
	Wed,  9 Apr 2025 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dSBftMqN"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ED322CBE6;
	Wed,  9 Apr 2025 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182485; cv=none; b=fhc/D7Rv/1OAnJZ7nxSp10vwudiI6anm+M2bA4VsAfrN30ustobqC32UliahhQaogOlZIx3WbFRxYirURoeNIsxyASun4S0nQfm23WO3nKV1EVkcD3h8/oCyEWt75L6disKIJS2vl18m/izSeS0ocF9Eso6seWTfdciQHwm6/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182485; c=relaxed/simple;
	bh=7fYf2v+WQaBPYIpK3VnnhW/8ORET4qfJFexoueFeRbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldIluQaUvELneLK47/qM0Ve4YQ4EZH0N54++I5m8YBKJCnh42QAfpsDQSxFkDkSBMmFSBpBOl30UDQMEGe3KDCmRqDg3BV5mQocJqamhWYxHPZrvp8wlZICrCLFA7zYUvu4/5dj5cXPCyr0UDiZlFKODJ0/U0SE4vX42PWEuWTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dSBftMqN; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 584852047C;
	Wed,  9 Apr 2025 07:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744182479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZlEU/CzuHV3jCOgs94woTuzZFDAACQlWjPWeu//Pr0=;
	b=dSBftMqNWrNrVih04KqB6BFDVmnnEnUtoAvUaPtg9UmBFDHN82iyJRyFUY83U+IrRJ/c2f
	aTpERBb6YufZPFyaW9nl5TmxavHY16QToLY8kqoTjDpfn2OQ4eJFC5ieHFS9OJtbCzCWMH
	xcm9okGOnQp/samWMULZMaW9v6i1NNu5IZKrHW7t0AOg4HUz6UFMFfpE9xGpSwkusYLWEc
	pgut8NQ3gJSOgsvjS+Bw2lSHxUlP0NpRAPVMdZyx19eIMh27Wt+FhWPiN8610oAsxsLR2L
	EbfDqJXTWgsVXtuzTeAWJYgEdqLUCMyinbeuQTBSrG3Lz3qgYrpTBjTck/VQjw==
Date: Wed, 9 Apr 2025 09:07:51 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Chester A.
 Unal" <chester.a.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Simon
 Horman <horms@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
Subject: Re: [net-next PATCH v14 07/16] net: mdio: regmap: add support for
 C45 read/write
Message-ID: <20250409090751.6bc42b5b@fedora.home>
In-Reply-To: <20250408095139.51659-8-ansuelsmth@gmail.com>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
	<20250408095139.51659-8-ansuelsmth@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdehfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtoheprghnshhuvghlshhmthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkr
 hiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Christian,

On Tue,  8 Apr 2025 11:51:14 +0200
Christian Marangi <ansuelsmth@gmail.com> wrote:

> Add support for C45 read/write for mdio regmap. This can be done
> by enabling the support_encoded_addr bool in mdio regmap config and by
> using the new API devm_mdio_regmap_init to init a regmap.
> 
> To support C45, additional info needs to be appended to the regmap
> address passed to regmap OPs.
> 
> The logic applied to the regmap address value:
> - First the regnum value (20, 16)
> - Second the devnum value (25, 21)
> - A bit to signal if it's C45 (26)
> 
> devm_mdio_regmap_init MUST be used to register a regmap for this to
> correctly handle internally the encode/decode of the address.
> 
> Drivers needs to define a mdio_regmap_init_config where an optional regmap
> name can be defined and MUST define C22 OPs (mdio_read/write).
> To support C45 operation also C45 OPs (mdio_read/write_c45).
> 
> The regmap from devm_mdio_regmap_init will internally decode the encoded
> regmap address and extract the various info (addr, devnum if C45 and
> regnum). It will then call the related OP and pass the extracted values to
> the function.
> 
> Example for a C45 read operation:
> - With an encoded address with C45 bit enabled, it will call the
>   .mdio_read_c45 and addr, devnum and regnum will be passed.
>   .mdio_read_c45 will then return the val and val will be stored in the
>   regmap_read pointer and will return 0. If .mdio_read_c45 returns
>   any error, then the regmap_read will return such error.
> 
> With support_encoded_addr enabled, also C22 will encode the address in
> the regmap address and .mdio_read/write will called accordingly similar
> to C45 operation.

This driver's orginal goal is to address the case where we have a
PHY-like device that has the same register layout and behaviour as a
C22 PHY, but where the registers are not accesses through MDIO (MMIO
for example, as in altera-tse or dwmac-socfpga, or potentially SPI even
though  there's no example upstream).

What is done here is quite different, I guess it could work if we have
MMIO C45 phys that understand the proposed encoding, but I don't really
understand the dance where C45 accesses are wrapped by this mdio-regmap
driver into regmap accesss, but the regmap itself converts it back to
C45 accesses. Is it just so that it fits well with MFD ?

I'm not really against that, it still converts mdio access to regmap so
there's that, but is there a way to elaborate or document somewhere why
we need to do go through C45 -> regmap -> C45 instead of just
writing a mii_bus driver in the first place ?

As I said, I think this could work and even be re-used in other places,
so I'm ok with that, it's just not really clear from the commit log what
problem this solves.

Maxime

