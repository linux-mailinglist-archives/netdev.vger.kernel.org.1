Return-Path: <netdev+bounces-172815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFB0A56347
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17619176A1E
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0A51E1E1E;
	Fri,  7 Mar 2025 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cEJQDx7P"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5C31E1DE4;
	Fri,  7 Mar 2025 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338644; cv=none; b=I2ijc3M2Vm4xy7/ZLqZ+QGja1XJ/6R1bPqSafQ3XsZWIRi58h3haaYaZQ3665dnjiUEexVZJeC5FlzkcC39I/760YspE4y0OAtS5Pg25LSzQiPi60v37MkpVfYuJU98xzNCocDzg1miOd94lkGCuTLVAn6Yu6aNqxvkB+JxUSLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338644; c=relaxed/simple;
	bh=uZL3atvFoiEClypzAOdKdARG9JhS9v3gZMmDlO4iStk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYo0vhDdSpx/uxAUzXaexA9bajNMjFSwZt6Ix4aDrdn9ShPDhUSyvUj9RGxZ+mD+cAh9wihgFb4lFrhwH7MJWnYCrxNkKbQ94uQ2oEqz5yvEtYOm05sta8VfLX/lI/DpucRN+HVDnyIieGbA9JdYeerlnqUS4fZqW87Ifuer6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cEJQDx7P; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CCC6C42DF9;
	Fri,  7 Mar 2025 09:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741338639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rJUwtH82uIgJmxU1hir8Izx4pXr/sEMOtTSjrNMmOU=;
	b=cEJQDx7PvsebvwWPjWe6jCL4kkCFVK8faKield18UFn/7DqDeN8mF20F9fl1KZw9Sz2JuU
	hWznocf+F9hQ+dMQPsX4wSnyGS7zGDy0FHQ0x23gx4CnSTuAFeSbHV7pVHExbiRgJoUJ8B
	+E8NBO55q/J89sRiMGN9OTXg2WSyrCWYeJg9ORySg/L802rjx025rEOZ0UIoQQAeSh0/fT
	CK6Xqsz2Hi2fp82yRnnkv18FRnWKR6IpswSlVDgoc//TQA9L5tCU1vU78uWjDr0WQr0q6G
	PHL1IVIF74dkAzUyliRRZxAf3VnrvguVgbCN0IbquXjvWqnBO14C9Hxz1u6sjg==
Date: Fri, 7 Mar 2025 10:10:35 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250307101035.21397a1a@kmaincent-XPS-13-7390>
In-Reply-To: <20250306174619.2823b23a@kernel.org>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
	<20250304-feature_poe_port_prio-v6-6-3dc0c5ebaf32@bootlin.com>
	<20250306174619.2823b23a@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmeektdhfheemgegulegvmeejugehsgemjeeggeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkeehkeejmeejuddttdemkedtfhehmeegugelvgemjeguhegsmeejgeegfedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehordhrvghmphgvlhesphgvn
 hhguhhtrhhonhhigidruggvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 6 Mar 2025 17:46:19 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 04 Mar 2025 11:18:55 +0100 Kory Maincent wrote:
> > +/**
> > + * enum ethtool_pse_budget_eval_strategies - PSE budget evaluation
> > strategies.
> > + * @ETHTOOL_PSE_BUDGET_EVAL_STRAT_DISABLED: Budget evaluation strategy
> > disabled.
> > + * @ETHTOOL_PSE_BUDGET_EVAL_STRAT_STATIC: PSE static budget evaluation
> > strategy.
> > + *	Budget evaluation strategy based on the power requested during PD
> > + *	classification. This strategy is managed by the PSE core.
> > + * @ETHTOOL_PSE_BUDGET_EVAL_STRAT_DYNAMIC: PSE dynamic budget evaluati=
on
> > + *	strategy. Budget evaluation strategy based on the current
> > consumption
> > + *	per ports compared to the total	power budget. This mode
> > is managed by
> > + *	the PSE controller.
> > + */
> > +
> > +enum ethtool_pse_budget_eval_strategies {
> > +	ETHTOOL_PSE_BUDGET_EVAL_STRAT_DISABLED	=3D 1 << 0,
> > +	ETHTOOL_PSE_BUDGET_EVAL_STRAT_STATIC	=3D 1 << 1,
> > +	ETHTOOL_PSE_BUDGET_EVAL_STRAT_DYNAMIC	=3D 1 << 2,
> >  }; =20
>=20
> Leftover?

We still need these to know the PSE method but they shall not be in the uAPI
for now. I will move it out of it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

