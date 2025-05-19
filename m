Return-Path: <netdev+bounces-191553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EC7ABC14A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 16:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F89188D4F5
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6613280CC9;
	Mon, 19 May 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GHTzXxha"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D728000A
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666195; cv=none; b=mw1R3Q3MGbUXYx55ahV3JoQI9fhs7ZEe5H5BINFR6dGExuquVSCJVa8PjCk9CYxPucPd4Vp5JSqnLHmTIKwKMTKkif2+4lmNcecDhGlEnfurs1keWSemqRRgQ3QlMegkYsLAzgm433dGL9EONlkKVgAEAUbdIgxihGZR+KDETUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666195; c=relaxed/simple;
	bh=Vp17GqqGTV1g/ha2tScDyQWOt31Abqsyiij/fj0l0C0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvHqsubl3Cg52lB5k6kMX0rI7qDvkHBQIbfvpAdv8LcbFkiD5gqnfmuslSzOUAed59jtEzS1remONjBHaTQ54t7MD8Tm04BYojZQ55mSqTWWuy5wGQhAJQRtY09C0bo8flLFkc+0S7a+JdMl65/kkl5qYRF405+6p3eJ2QrpvrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GHTzXxha; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA95342E7E;
	Mon, 19 May 2025 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747666191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDQg72xYSOYHbCNL9sBjMomziaYCG5q3JwE1bnhWH+8=;
	b=GHTzXxhaqPLVPJczmIJ4ws7TzIjkN1Rvs0jWJG25FJmLI8OT/BMI/uV0zW7+QBr0FblmFt
	ZccM0ub3Av6ETKwhWKoLsLnZnY6qYEUiuy+5PdkKEMY7ILxX5GC9c5lGSsahkovSpr5gMS
	ixPV9ds7EV7gf9W/1bdhE/AJxf4auOaT+TlKtX74WgTii9f18aE6t+m9n1ym/wo0lAJvX0
	CuVdXqaiUql43LgSBpAnz7lWP3DDKPeXAJbaUzPKdzCVjrJxP8aiiTnZmUkIKzAmG4Pz8P
	0mPX+e04WRinjUYd32K+cw73l2miKvgOYOOSTG2YaHFP4hk6U1zo4Eq4yqpYbg==
Date: Mon, 19 May 2025 16:49:49 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, daniel@iogearbox.net, nicolas.dichtel@6wind.com,
 jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 8/9] tools: ynl: enable codegen for all rt-
 families
Message-ID: <20250519164949.597d6e92@kmaincent-XPS-13-7390>
In-Reply-To: <20250515231650.1325372-9-kuba@kernel.org>
References: <20250515231650.1325372-1-kuba@kernel.org>
	<20250515231650.1325372-9-kuba@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdduieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtp
 hhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 15 May 2025 16:16:49 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> Switch from including Classic netlink families one by one to excluding.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/Makefile.deps      | 4 ++++
>  tools/net/ynl/generated/Makefile | 7 +++----
>  2 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
> index a5e6093903fb..e5a5cb1b2cff 100644
> --- a/tools/net/ynl/Makefile.deps
> +++ b/tools/net/ynl/Makefile.deps
> @@ -33,5 +33,9 @@ CFLAGS_ovs_flow:=3D$(call
> get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h) CFLAGS_ovs_vport:=3D$(ca=
ll
> get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h) CFLAGS_rt-addr:=3D$(call
> get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \ $(call
> get_hdr_inc,__LINUX_IF_ADDR_H,if_addr.h) +CFLAGS_rt-link:=3D$(call
> get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
> +	$(call get_hdr_inc,_LINUX_IF_LINK_H,if_link.h)
> +CFLAGS_rt-neigh:=3D$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
>  CFLAGS_rt-route:=3D$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
> +CFLAGS_rt-rule:=3D$(call get_hdr_inc,__LINUX_FIB_RULES_H,fib_rules.h)
>  CFLAGS_tcp_metrics:=3D$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metric=
s.h)
> diff --git a/tools/net/ynl/generated/Makefile
> b/tools/net/ynl/generated/Makefile index 6603ad8d4ce1..9208feed28c1 100644
> --- a/tools/net/ynl/generated/Makefile
> +++ b/tools/net/ynl/generated/Makefile
> @@ -22,10 +22,9 @@ TOOL:=3D../pyynl/ynl_gen_c.py
>  TOOL_RST:=3D../pyynl/ynl_gen_rst.py
> =20
>  SPECS_DIR:=3D../../../../Documentation/netlink/specs
> -GENS_PATHS=3D$(shell grep -nrI --files-without-match \
> -		'protocol: netlink' \
> -		$(SPECS_DIR))
> -GENS=3D$(patsubst $(SPECS_DIR)/%.yaml,%,${GENS_PATHS}) rt-addr rt-route
> +SPECS_PATHS=3D$(wildcard $(SPECS_DIR)/*.yaml)
> +GENS_UNSUP=3Dconntrack nftables tc
> +GENS=3D$(filter-out ${GENS_UNSUP},$(patsubst
> $(SPECS_DIR)/%.yaml,%,${SPECS_PATHS})) SRCS=3D$(patsubst %,%-user.c,${GEN=
S})
>  HDRS=3D$(patsubst %,%-user.h,${GENS})
>  OBJS=3D$(patsubst %,%-user.o,${GENS})

This patch introduces a build error when building the specs.

Maybe we should add a spec build check in the net CI?

$ make -C tools/net/ynl -j9
-e 	CC rt-neigh-user.o
rt-neigh-user.c:122:10: error: =E2=80=98NDTPA_INTERVAL_PROBE_TIME_MS=E2=80=
=99 undeclared here (not in a function); did you mean =E2=80=98NDTPA_DELAY_=
PROBE_TIME=E2=80=99?
  122 |         [NDTPA_INTERVAL_PROBE_TIME_MS] =3D { .name =3D "interval-pr=
obe-time-ms", .type =3D YNL_PT_U64, },
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |          NDTPA_DELAY_PROBE_TIME
rt-neigh-user.c:122:10: error: array index in initializer not of integer ty=
pe
rt-neigh-user.c:122:10: note: (near initialization for =E2=80=98rt_neigh_nd=
tpa_attrs_policy=E2=80=99)
rt-neigh-user.c:122:42: warning: excess elements in array initializer
  122 |         [NDTPA_INTERVAL_PROBE_TIME_MS] =3D { .name =3D "interval-pr=
obe-time-ms", .type =3D YNL_PT_U64, },
      |                                          ^
rt-neigh-user.c:122:42: note: (near initialization for =E2=80=98rt_neigh_nd=
tpa_attrs_policy=E2=80=99)
rt-neigh-user.c:146:10: error: =E2=80=98NDA_FLAGS_EXT=E2=80=99 undeclared h=
ere (not in a function)
  146 |         [NDA_FLAGS_EXT] =3D { .name =3D "flags-ext", .type =3D YNL_=
PT_U32, },
      |          ^~~~~~~~~~~~~
rt-neigh-user.c:146:10: error: array index in initializer not of integer ty=
pe
rt-neigh-user.c:146:10: note: (near initialization for =E2=80=98rt_neigh_ne=
ighbour_attrs_policy=E2=80=99)
rt-neigh-user.c:146:27: warning: excess elements in array initializer
  146 |         [NDA_FLAGS_EXT] =3D { .name =3D "flags-ext", .type =3D YNL_=
PT_U32, },
      |                           ^
rt-neigh-user.c:146:27: note: (near initialization for =E2=80=98rt_neigh_ne=
ighbour_attrs_policy=E2=80=99)
rt-neigh-user.c:147:10: error: =E2=80=98NDA_NDM_STATE_MASK=E2=80=99 undecla=
red here (not in a function)
  147 |         [NDA_NDM_STATE_MASK] =3D { .name =3D "ndm-state-mask", .typ=
e =3D YNL_PT_U16, },
      |          ^~~~~~~~~~~~~~~~~~
rt-neigh-user.c:147:10: error: array index in initializer not of integer ty=
pe
rt-neigh-user.c:147:10: note: (near initialization for =E2=80=98rt_neigh_ne=
ighbour_attrs_policy=E2=80=99)
rt-neigh-user.c:147:32: warning: excess elements in array initializer
  147 |         [NDA_NDM_STATE_MASK] =3D { .name =3D "ndm-state-mask", .typ=
e =3D YNL_PT_U16, },
      |                                ^
rt-neigh-user.c:147:32: note: (near initialization for =E2=80=98rt_neigh_ne=
ighbour_attrs_policy=E2=80=99)
rt-neigh-user.c:148:10: error: =E2=80=98NDA_NDM_FLAGS_MASK=E2=80=99 undecla=
red here (not in a function); did you mean =E2=80=98XDP_FLAGS_MASK=E2=80=99?
  148 |         [NDA_NDM_FLAGS_MASK] =3D { .name =3D "ndm-flags-mask", .typ=
e =3D YNL_PT_U8, },
      |          ^~~~~~~~~~~~~~~~~~
      |          XDP_FLAGS_MASK
rt-neigh-user.c:148:10: error: array index in initializer not of integer ty=
pe
rt-neigh-user.c:148:10: note: (near initialization for =E2=80=98rt_neigh_ne=
ighbour_attrs_policy=E2=80=99)
rt-neigh-user.c:148:32: warning: excess elements in array initializer
  148 |         [NDA_NDM_FLAGS_MASK] =3D { .name =3D "ndm-flags-mask", .typ=
e =3D YNL_PT_U8, },
      |                                ^
rt-neigh-user.c:148:32: note: (near initialization for =E2=80=98rt_neigh_ne=
ighbour_attrs_policy=E2=80=99)
make[1]: *** [Makefile:52: rt-neigh-user.o] Error 1

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

