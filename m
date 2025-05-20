Return-Path: <netdev+bounces-191761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EDDABD1E6
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779BD8A3D33
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 08:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E6825B1D2;
	Tue, 20 May 2025 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EJlYGH73"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374D9261589
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729689; cv=none; b=aA5Lgf066yq+4lpbWwIm7jCo7TOLKY8DJ/j8M2BqqdNH0AG4aouVk5LuLwuazu3ufD1HKGi2ExbFIuofwlnqCou7H9psZOTp1nXZ1Mdrbaa/zLogzTF+i3Y7UFgMRsgUMfCOd4An20YzBv//yQfdyh3zmV94ToEL2/TXRA3yUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729689; c=relaxed/simple;
	bh=gu4XLRA1ZqFR5R/C1QzuxeJEhb2fV4oMDmvtjHM7zVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unkvh1KgIRbCQIFltpciorRhOxxmh7RInic49657FeB70+nyc6I9gVJDm8X2LRJDdVJd1wy8PHewWjZ/5Z8IpLgmNDhMY7FWHkPTdJVZ/eTfrNTUA7Lqw2MF/wjhzrd7eBMw9n0BZCxK7jHc1p5hsLZoUka/44ZQeqPWy/V648s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EJlYGH73; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 195EC43289;
	Tue, 20 May 2025 08:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747729686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IK7zXWBFCB7hH5zwPOWPbn7KiodLPCJ2+l6Qfj78MA=;
	b=EJlYGH733HmUXjnOXV+pfriNaBDsUGdIRE3WO4wfxShAoO6MHf9mLAUcrq0X1rezizJ9OE
	67QTmkPM8V+F/keCeBxqa6OUeaQMjmO4og+tzhhkjUAj+lrFwqvvlmi32LtkjvmEiMcAhw
	MIjHUJuqdmCy1PgPmsRb+AlTLf05weOCvzqi0E+fhqYyeUUwRH4nZ9nDeSZAaLwCcWuxwO
	DIj3nIrhIxn7AKRgXNoAL7n/cEAT71inWJQUYmXUSJbimtnYn49DeOghUCy/aGN6xqkemt
	bQBwGK341/rUceBd46Z/wdHJM0xhG37Oj6Qywp6+VEXmmgzSEIFimuICoqUa2Q==
Date: Tue, 20 May 2025 10:28:03 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, daniel@iogearbox.net, nicolas.dichtel@6wind.com,
 jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 8/9] tools: ynl: enable codegen for all rt-
 families
Message-ID: <20250520102803.292ad7bb@kmaincent-XPS-13-7390>
In-Reply-To: <20250519085703.7677ba07@kernel.org>
References: <20250515231650.1325372-1-kuba@kernel.org>
	<20250515231650.1325372-9-kuba@kernel.org>
	<20250519164949.597d6e92@kmaincent-XPS-13-7390>
	<20250519085703.7677ba07@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdefjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhudevkeeutddvieffudeltedvgeetteevtedvleethefhuefhgedvueeutdelgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvu
 ghhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 19 May 2025 08:57:03 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 19 May 2025 16:49:49 +0200 Kory Maincent wrote:
> > > -GENS=3D$(patsubst $(SPECS_DIR)/%.yaml,%,${GENS_PATHS}) rt-addr rt-ro=
ute
> > > +SPECS_PATHS=3D$(wildcard $(SPECS_DIR)/*.yaml)
> > > +GENS_UNSUP=3Dconntrack nftables tc
> > > +GENS=3D$(filter-out ${GENS_UNSUP},$(patsubst
> > > $(SPECS_DIR)/%.yaml,%,${SPECS_PATHS})) SRCS=3D$(patsubst %,%-user.c,$=
{GENS})
> > >  HDRS=3D$(patsubst %,%-user.h,${GENS})
> > >  OBJS=3D$(patsubst %,%-user.o,${GENS})   =20
> >=20
> > This patch introduces a build error when building the specs.
> >=20
> > Maybe we should add a spec build check in the net CI? =20
>=20
> Sorry about that :( We do have build tests, but the problem only
> happens if system headers are much older than the spec. Looks like
> these defines are there on both Fedora and Ubuntu LTS so builds pass.
> Once the initial support is merged we should be out of the woods.

Yeah, I am on an old Ubuntu 22.04 and I have to update my distro one day. ;)

> I can't repro on any of my systems, could you see if=20
> https://lore.kernel.org/all/20250517001318.285800-1-kuba@kernel.org/
> will also give you trouble?

Indeed it does. I have replied to it.

> For the issue reported here could you see if this is enough?
>=20
> diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
> index 4e5c4dff9188..21132e89ceba 100644
> --- a/tools/net/ynl/Makefile.deps
> +++ b/tools/net/ynl/Makefile.deps
> @@ -35,7 +35,8 @@ CFLAGS_rt-addr:=3D$(call
> get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \ $(call
> get_hdr_inc,__LINUX_IF_ADDR_H,if_addr.h) CFLAGS_rt-link:=3D$(call
> get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \ $(call
> get_hdr_inc,_LINUX_IF_LINK_H,if_link.h) -CFLAGS_rt-neigh:=3D$(call
> get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) +CFLAGS_rt-neigh:=3D$(call
> get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
> +	$(call get_hdr_inc,__LINUX_NEIGHBOUR_H,neighbour.h)
>  CFLAGS_rt-route:=3D$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
>  CFLAGS_rt-rule:=3D$(call get_hdr_inc,__LINUX_FIB_RULES_H,fib_rules.h)
>  CFLAGS_tc:=3D$(call get_hdr_inc,__LINUX_PKT_SCHED_H,pkt_sched.h) \
> diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbou=
r.h
> index 5e67a7eaf4a7..b851c36ad25d 100644
> --- a/include/uapi/linux/neighbour.h
> +++ b/include/uapi/linux/neighbour.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef __LINUX_NEIGHBOUR_H
> -#define __LINUX_NEIGHBOUR_H
> +#ifndef _UAPI__LINUX_NEIGHBOUR_H
> +#define _UAPI__LINUX_NEIGHBOUR_H
> =20
>  #include <linux/types.h>
>  #include <linux/netlink.h>

This change indeed fix this build issue.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

