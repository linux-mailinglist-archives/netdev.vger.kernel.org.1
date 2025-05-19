Return-Path: <netdev+bounces-191433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3057ABB7B3
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F47188C232
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D58926D4D3;
	Mon, 19 May 2025 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="llt5CK4O"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F126A0EE;
	Mon, 19 May 2025 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643973; cv=none; b=DjDi0ic7fqfgC0Dg1q1/A5lVoTOXtfPdBMhX0c7TGB+YKUBOJIdzvuNS2rNQ44a2V9j+MJZM4tWbFkaLvXRGIlAoiILEFMs7iFrWi6DF4Arndyb2yRZxe71FW6X9dD/fxsjaVPk6JVeuulg2LIuzbVrHu42hhe9O1rYUU6gM+wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643973; c=relaxed/simple;
	bh=6D9qOjGtcK1XSKgzZs9h4tHeekFliCZwqEhlPI4rjD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hiSEnv5eKxX1gi7OCk1oH6wEo+RKoQcR5fi1I3D4pGZ36o3O02VC6DobOjnxR312ggLeqUm/ZdmEWJK9zCotyowD/24k4tthFXWIxE+cgVazOvBbOIZWeMsxPTov47VnGoKbCqlFfSnTQ8DCEopXXY+yld2wldyqfhnqq8kaK0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=llt5CK4O; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C42D1FCED;
	Mon, 19 May 2025 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747643962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJY7beia2nPXzQGnKfBht38YknlO6HPrMLJF1/0I7fk=;
	b=llt5CK4O6/PN2OpBTez/7OuKsKErXIdvo2eFqPpUxMXOKHIbwe3DmqZTyPfkKNRcqy09sq
	k0b+54kET5m9TGvcjjPpfWaD2lETg+Oz5n4+5dUJntczGZ9KINCRapVOYZQbAspe6Kdbso
	6wIKFIw2TF3RXU5y9w9HdfqEw4+UyLl7IV1QT57iqEpWlU7sv/3ZYPonp5k7Zc7IL4oP1S
	vnjjK+E7FaUPTjW5pDVuxyZ3tooTh/QjaRDsT3Zm78xW9CgHhoZecfjZGNUrbTrr8wCCoA
	YTbINGcsD+56wFmakPT88hVZCN8pmDCOWqML/hgLX57+pVKIVkAGMEYjCZM1Kw==
Date: Mon, 19 May 2025 10:39:20 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Donald
 Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Xing
 <kernelxing@tencent.com>, Richard Cochran <richardcochran@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v3] net: Add support for providing the PTP
 hardware source in tsinfo
Message-ID: <20250519103920.2e716b78@kmaincent-XPS-13-7390>
In-Reply-To: <c6eed9e0-8f44-4ffb-b316-d65e0b5a192a@redhat.com>
References: <20250513-feature_ptp_source-v3-1-84888cc50b32@bootlin.com>
	<c6eed9e0-8f44-4ffb-b316-d65e0b5a192a@redhat.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegur
 ghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 15 May 2025 13:51:40 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 5/13/25 1:40 PM, Kory Maincent wrote:
> > diff --git a/Documentation/netlink/specs/ethtool.yaml
> > b/Documentation/netlink/specs/ethtool.yaml index
> > c650cd3dcb80bc93c5039dc8ba2c5c18793ff987..881e483f32e18f77c009f278bd2d2=
029c30af352
> > 100644 --- a/Documentation/netlink/specs/ethtool.yaml +++
> > b/Documentation/netlink/specs/ethtool.yaml @@ -98,6 +98,23 @@ definitio=
ns:
> >      name: tcp-data-split
> >      type: enum
> >      entries: [ unknown, disabled, enabled ]
> > +  -
> > +    name: hwtstamp-source
> > +    enum-name: hwtstamp-source
> > +    name-prefix: hwtstamp-source-
> > +    type: enum
> > +    entries: =20
>=20
> This causes a kdoc warning in the generated hdr, lacking the short
> description for the enum:
>=20
> include/uapi/linux/ethtool_netlink_generated.h:42: warning: missing
> initial short description on line:
>  * enum hwtstamp_source
>=20
> Please add a:
>     doc: <>

Ack, I will.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

