Return-Path: <netdev+bounces-179744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98816A7E6C7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2C73AACA9
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F4C20DD6E;
	Mon,  7 Apr 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CObBzKRS"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D24E20896C;
	Mon,  7 Apr 2025 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043269; cv=none; b=Pq1HD5XRBoTigBFBXUHjq02afVS2OLctEjHnwvLQRG7tADAXbWoyl7BEv0wxMAblJAtz83Qi+MmwEqn+ZCHBxV2meoLlm8+B22lO7Rve0s/qecnWxVY1YKPBcASr8vxt6JvjGpVricapLTd+8IhltrCuwHNzccvAHdQw9Ofgez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043269; c=relaxed/simple;
	bh=8HnaG/eG2QgDsXkFgpjbIklESPg41acrEUDgvqvQ0mw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocioSS/I+RaFpBPeMgpMxwBo/sU99P/k1Vykap1LsQHoaF7K1e2FsiDXQcUCPKQNc01KmVQa7KI7bndOea20FXDK4mK5pTQXaKu0uqtkyPDwq5vjws5R4a+Lupw2CzFJAjcyS3QkjD1VnplxzPY8+WMOKmnS7PxsstjEGypVACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CObBzKRS; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 024C943DF3;
	Mon,  7 Apr 2025 16:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744043263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T37MrcReRu3n4dLXt3U+NVNLtXb9JL/zdt0u4v0w6kk=;
	b=CObBzKRSeL3FF/dNWuapvRiAGerYon6k1J7eOu+wHYiv/SYAjEC1TrS8OEnMvC9J4gx5tz
	2BPZJmMRr4PoA71CjpwNB2ITH4wo9rTbBOVmD5TonuC4l5kqbZRKeH+ok6zIBy793sE4PG
	t2aJE8rZ25xbV2tWEgfkK00Sk6TVYVnRYLQo9oe9hn/ckUxe9RpDAs0wmyrTvi+x1oOGRq
	9gruGm8B08dtES4D6QVlqBnQQjmCrxAsrnx5R69zSz/D3U1Yf+dxZkSI9/20h/EKu+5ZJV
	pBZ95mXvYPNfC5yr3qXNex+r4MWhxUhGkUyfMo3iuX9RYCFhZ78PGZhEX8mICg==
Date: Mon, 7 Apr 2025 18:27:38 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Christian Marangi
 <ansuelsmth@gmail.com>, upstream@airoha.com, Heiner Kallweit
 <hkallweit1@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Clark Wang <xiaoning.wang@nxp.com>, Claudiu
 Beznea <claudiu.beznea@microchip.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, Joyce Ooi
 <joyce.ooi@intel.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Li Yang
 <leoyang.li@nxp.com>, Madalin Bucur <madalin.bucur@nxp.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal
 Simek <michal.simek@amd.com>, Naveen N Rao <naveen@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Rob Herring
 <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, Robert Hancock
 <robert.hancock@calian.com>, Saravana Kannan <saravanak@google.com>, Shawn
 Guo <shawnguo@kernel.org>, UNGLinuxDriver@microchip.com, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC net-next PATCH 00/13] Add PCS core support
Message-ID: <20250407182738.498d96b0@kmaincent-XPS-13-7390>
In-Reply-To: <20250403181907.1947517-1-sean.anderson@linux.dev>
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfduveekuedtvdeiffduleetvdegteetveetvdelteehhfeuhfegvdeuuedtleegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegledprhgtphhtthhopehsvggrnhdrrghnuggvrhhsohhnsehlihhnuhigrdguvghvpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegur
 ghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhk
X-GND-Sasl: kory.maincent@bootlin.com

On Thu,  3 Apr 2025 14:18:54 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> This series adds support for creating PCSs as devices on a bus with a
> driver (patch 3). As initial users,
>=20
> - The Lynx PCS (and all of its users) is converted to this system (patch =
5)
> - The Xilinx PCS is broken out from the AXI Ethernet driver (patches 6-8)
> - The Cadence MACB driver is converted to support external PCSs (namely
>   the Xilinx PCS) (patches 9-10).
>=20
> The last few patches add device links for pcs-handle to improve boot time=
s,
> and add compatibles for all Lynx PCSs.
>=20
> Care has been taken to ensure backwards-compatibility. The main source
> of this is that many PCS devices lack compatibles and get detected as
> PHYs. To address this, pcs_get_by_fwnode_compat allows drivers to edit
> the devicetree to add appropriate compatibles.

I don't dive into your patch series and I don't know if you have heard abou=
t it
but Christian Marangi is currently working on fwnode for PCS:
https://lore.kernel.org/netdev/20250406221423.9723-1-ansuelsmth@gmail.com

Maybe you should sync with him!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

