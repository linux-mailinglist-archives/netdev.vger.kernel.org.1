Return-Path: <netdev+bounces-191990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AB7ABE1DF
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 19:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13041B61507
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C52926C3AD;
	Tue, 20 May 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nt5QMiYt"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4014182BC
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747762599; cv=none; b=UtknBljDV08VL1TB1QdBMWkr2TvOICjyU5rma+dkxjgk/L0lZtlewMaMmR1x7tftMYdCRoCrg7H3P177b3md4SIAj0RctuA4gEopYiG1CI7/xWmGr8xa4BkKL0/TTwSvcmM9H59cLKqzYOQuZUI8NWKDP6BwKUBOPcH1zADpOvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747762599; c=relaxed/simple;
	bh=1FDpfqsWq7OKrcC4FrzNLcgBrIKX4uxWkSpuOrYYz5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZQDtzDrd/3KyqCeA2a3phFZBg/LHi6nclFV3dUa36Y9L266z4zfs1WAHr9GTD1YASXc3p4xUExmK67zi+QWn7+LAeOXyCT3SD11Vfpx/LA7PeoB/VtGfub5ae3XeLXUhR27kYjBmdOGATvX+YSTF6Km5hLH7JYIYpQ0SghVX0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nt5QMiYt; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6361438F7;
	Tue, 20 May 2025 17:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747762588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFIn2OmflrAxSw9hbTG9fIPxkZuOQvXJOslKOwVTEp8=;
	b=Nt5QMiYtdCG1PxteROFHHKS9l/axaKbuX7NKefIrM7maq0AxHos3Q/s8O6SI8e6jIqfws9
	VCNT7dqx3hOpeXhgnk6G9F007tb3NkqiLAZmibp1dpJp4/bXXw+8i2w9+an8NdWNsf1QqQ
	ONjlNu46MUAelWEFAo8OwK0bYwpRRNH4dNgjSrUNEv7jx/VUKUvTUwubiwB+JnVss37gWJ
	r/tRfWCFFyDB6Hiokq6Rw9UVir8GZvD+dBS3ICyn1j525qhSyG+ZYqDt8LmTQIiu1ie+6X
	o3ADMtw/NR43VZjphBcqUQHz5FGLKbFR1e5wcmDfUAWm8ZbU4j6aDzXm339ReA==
Date: Tue, 20 May 2025 19:36:25 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com, sdf@fomichev.me,
 jstancek@redhat.com
Subject: Re: [PATCH net-next v2 10/12] tools: ynl: enable codegen for TC
Message-ID: <20250520193625.6d6bc18b@kmaincent-XPS-13-7390>
In-Reply-To: <20250520095005.1bdd64c7@kernel.org>
References: <20250520161916.413298-1-kuba@kernel.org>
	<20250520161916.413298-11-kuba@kernel.org>
	<20250520183416.5b720968@kmaincent-XPS-13-7390>
	<20250520095005.1bdd64c7@kernel.org>
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
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdekfeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheevueefveffvdfgjefhleetueefgfdutddugfeiudefteekgfduhffgleehvdffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmegsiedvmegtfhgtfeemvdgufegtmegutgejtgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekheekjeemjedutddtmegsiedvmegtfhgtfeemvdgufegtmegutgejtgdphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpt
 hhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 20 May 2025 09:50:05 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 20 May 2025 18:34:16 +0200 Kory Maincent wrote:
> > > We are ready to support most of TC. Enable C code gen.
> > >=20
> > > Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > ---
> > > v2:
> > >  - add more headers to the local includes to build on Ubuntu 22.04
> > > v1: https://lore.kernel.org/20250517001318.285800-10-kuba@kernel.org
> > > ---   =20
> >=20
> > Now got this build error:
> >=20
> > -e 	GEN tc-user.c
> > -e 	GEN tc-user.h
> > -e 	GEN_RST tc.rst
> > -e 	CC tc-user.o
> > In file included from <command-line>:
> > ./../../../../include/uapi//linux/pkt_cls.h:250:9: error: expected
> > specifier-qualifier-list before =E2=80=98__struct_group=E2=80=99 250 |
> > __struct_group(tc_u32_sel_hdr, hdr, /* no attrs */, |         ^~~~~~~~~=
~~~~~
> > tc-user.c: In function =E2=80=98tc_u32_attrs_parse=E2=80=99:
> > tc-user.c:9086:33: warning: comparison is always false due to limited r=
ange
> > of data type [-Wtype-limits] 9086 |                         if (len <
> > sizeof(struct tc_u32_sel)) |                                 ^
> > make[1]: *** [Makefile:52: tc-user.o] Error 1 =20
>=20
> Odd, are you sure you have the latest headers for Ubuntu 22.04?

Indeed I wasn't but after an update I still got the same error.
More precisely I am on Ubuntu 22.04.5 LTS. linux-headers-5.15.0-140

> I added Ubuntu 22.04 to the GitHub build tester and it passes
> there:
> https://github.com/linux-netdev/ynl-c/actions/runs/15143226607/job/425724=
97918

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

