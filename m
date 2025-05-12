Return-Path: <netdev+bounces-189655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEF5AB3168
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 413677A1D21
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2962586C4;
	Mon, 12 May 2025 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JcP35AC7"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BF22580DB;
	Mon, 12 May 2025 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037991; cv=none; b=dfFklgSymeft77MtgCj5q153C6WVnAw2U7Y0MkJ3mhfDhtr3CCkMAotY7yNZeUdcCrqSh3+2DYrbuHu+TvAI0BZeFiGucwCCR41ZEUmL3FcnRgkN1JO1BGbUfCqbAxSESxbpOrFc4PGc2lXQKgQGmHXHZMA8E50CjIPeui3kTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037991; c=relaxed/simple;
	bh=jOmPHw3PxpWmkFBx5yjdgmw5MHCKuJi6JPgf/knFaTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDwiNxPA4WKQTYlOPKToCUosEG+yKpSgsdx/7Q6r26NwuJ+gseB4ZDo8QevJysJXQTO8/bV589bhNnTNSjfi/F+yfHIm5QllZCXuaJwUEAR3Hqy3Vq+vLXBGKBzRzOR6n2Ok0vjanfsVqTmujS/zkI7o1pE5yQU1NW9pthW9/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JcP35AC7; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B00B43280;
	Mon, 12 May 2025 08:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747037986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJCWwWMnHakM0Z3fFPJDLj8fjIwn2K6+QB1baGulYEc=;
	b=JcP35AC7cvlmoFIoGXOw1UKnJI3bYvWsi4unol/cpHkmvPSgpdvCsdEuwOMvcExQC02C9p
	4b3E/cLEPGDASs8hGQpvKYG5/fWLVuzYOWf8B+QBRFmn9sX8e7c5aaB4ebIQw4F5LqaiQt
	WMR3wW/z48LqumyhX4jke0rwihzQ/TESWYjspXl2dHOOzbNYfZSMPvDJcA9wkp2e/sDGoa
	lLAQ6HCUd/9pZzRYAKzUKHPUodYGF/YZgn4jgAVN14mS/Wvhx/TnzZWNWJgvELMi2CtkDk
	/4teA16FpJ3t0JQcnAW472HONr4UmualZPH5Xb62fLHUsrOGyDzy+gIV52GQFw==
Date: Mon, 12 May 2025 10:19:42 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Xing <kernelxing@tencent.com>, Richard Cochran
 <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v2] net: Add support for providing the PTP
 hardware source in tsinfo
Message-ID: <20250512101942.4a5b80a1@kmaincent-XPS-13-7390>
In-Reply-To: <20250508193645.78e1e4d9@kernel.org>
References: <20250506-feature_ptp_source-v2-1-dec1c3181a7e@bootlin.com>
	<20250508193645.78e1e4d9@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 8 May 2025 19:36:45 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 06 May 2025 14:18:45 +0200 Kory Maincent wrote:
> > +  -
> > +    name: ts-hwtstamp-source
> > +    enum-name: hwtstamp-source
> > +    header: linux/ethtool.h
> > +    type: enum
> > +    name-prefix: hwtstamp-source
> > +    entries: [ netdev, phylib ] =20
>=20
> You're missing value: 1, you should let YNL generate this to avoid
> the discrepancies.
>=20
> diff --git a/Documentation/netlink/specs/ethtool.yaml
> b/Documentation/netlink/specs/ethtool.yaml index 20c6b2bf5def..3e2f470fb2=
13
> 100644 --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -99,12 +99,21 @@ uapi-header: linux/ethtool_netlink_generated.h
>      type: enum
>      entries: [ unknown, disabled, enabled ]
>    -
> -    name: ts-hwtstamp-source
> -    enum-name: hwtstamp-source
> -    header: linux/ethtool.h
> +    name: hwtstamp-source
> +    name-prefix: hwtstamp-source-
>      type: enum
> -    name-prefix: hwtstamp-source

Should we keep the enum-name property as is is already use, or do you prefe=
r to
rename all its use to ethtool-hwtstamp-source?

> -    entries: [ netdev, phylib ]
> +    entries:
> +      -
> +        name: netdev
> +        doc: |
> +          Hardware timestamp comes from a MAC or a device
> +          which has MAC and PHY integrated
> +        value: 1
> +      -
> +        name: phylib
> +        doc: |
> +          Hardware timestamp comes from one PHY device
> +          of the network topology

Oh ok, thanks for the pointers!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

