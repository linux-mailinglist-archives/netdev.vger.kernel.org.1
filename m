Return-Path: <netdev+bounces-182688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A90A89B3B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEBB37A66B0
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A0428A1E3;
	Tue, 15 Apr 2025 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mCfuv+ac"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3437E288C98;
	Tue, 15 Apr 2025 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744714492; cv=none; b=VuGtO581w3nQvJkX0XtAPzNGcSHskd07oLv//Fw7efHOJEHXA3JdVn23qZd71H8ftiJ/6/gwwemWYmXW2LKg0Um2f5CHFGjnS/682VMBEhhBxlqpdBap0VZFxr10SuBz3FeeOvG2Rf3GTjUyYk9zmYM2wKDrvUT0BQ0Q3w6hO7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744714492; c=relaxed/simple;
	bh=+ob3/6QHUlCNUnyCHrMdoUGCcUP4Ey19rJzogGictWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1BLQOJP/cpb94qG/xCMEp6WvxOWauriTNsW4daHkQnSdOvJWPWx1yohsWJiCOK4HY+PRKfawrAxV+iP2PVC5F3DE9KiQtssa46Xpff6/eF/kwF4oZDx+Zv+VFUYnGdFT2ASfxSjT30+D9HOaKaDGII3NGJBlA17D+5/Zp5ijFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mCfuv+ac; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 415CF439EF;
	Tue, 15 Apr 2025 10:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744714488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mU1L0OE4kqRPKvQXu+iydZ3XN/8SOPqiZLDwwEQ+2VQ=;
	b=mCfuv+acyWBVEOk80bVR88MWbZihQzFzcW+stWpRN/l17K3BaXZZDLLn2DQo5PMG0YfFR/
	KoQPbiuhOBwwrDvnsX85xi3qgQmPIpZFdnFBd0YNRFxRvvyoxDmdJWmaWzfPmWvuUNTSc1
	v5Ir/o134mD+MulWaQkAdGTbsafUtdbilckUjHhFrig1dHF83cU5n2DDVoJVFktwMErPFC
	qRLwJ0UtjLv6/u++ARoKBvHAgaNfnhhoLnLGpbyAciMy/yLtFpQnZWdCKe104bnfOT12H4
	SdBOoPsbEm8ZaYgc82l5dMJ6KKgfKtmYmXW6sSj7tPprSNqoOs3BhROFmvQi8A==
Date: Tue, 15 Apr 2025 12:54:45 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe
 Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Tero Kristo
 <kristo@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
Message-ID: <20250415125445.27d6ed8d@fedora.home>
In-Reply-To: <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
	<218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeffedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudfgleelvddtffdvkeduieejudeuvedvveffheduhedvueduteehkeehiefgteehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehmrghtthhhihgrshdrshgthhhifhhfvghrsegvfidrthhqqdhgrhhouhhprdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvhesl
 hhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Matthias,

On Tue, 15 Apr 2025 12:18:01 +0200
Matthias Schiffer <matthias.schiffer@ew.tq-group.com> wrote:

> As discussed [1], the comments for the different rgmii(-*id) modes do not
> accurately describe what these values mean.
> 
> As the Device Tree is primarily supposed to describe the hardware and not
> its configuration, the different modes need to distinguish board designs
> (if a delay is built into the PCB using different trace lengths); whether
> a delay is added on the MAC or the PHY side when needed should not matter.
> 
> Unfortunately, implementation in MAC drivers is somewhat inconsistent
> where a delay is fixed or configurable on the MAC side. As a first step
> towards sorting this out, improve the documentation.
> 
> Link: https://lore.kernel.org/lkml/d25b1447-c28b-4998-b238-92672434dc28@lunn.ch/ [1]
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Thanks for doing that ! I've tried to document that as well in the
past but it didn't go anywhere and was more clumsy. I think your wording
is clear and helpful.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

