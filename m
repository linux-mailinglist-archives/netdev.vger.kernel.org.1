Return-Path: <netdev+bounces-191760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1A3ABD1E5
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706BD8A27C0
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 08:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA9421CC54;
	Tue, 20 May 2025 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IuwOivEt"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5C11BD01D
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729679; cv=none; b=Bo7A6iRSfALnCnOk5r8cgPgjjzGI7gUBVGNi4jHRH1utReX+jEXLQjFXsmCmJNz4pgkBG+OdrUG4atyI1c8wi7i3tJClHiDa22obf8hMkK1EKXjkeB5rq3ON3HelLPwDRpKuairPdX5mjbSUDt1eL7065bYdjzvfiWVI4SzqYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729679; c=relaxed/simple;
	bh=MRtka3lLsR47NVMiRI2LofEhTy0zzz7+AXv0sna92q0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9ZSKEcmgp/cwiGNK23dIW7bAFkxElnLOEh8alYtzYNFYnsDP+ma0E5O11YziVPc7Oj0+EfjBv+I47wXWQONjBG6w/Gqme27WeGris6cHjc+fENogtnfDmpj7XmvkeDKssSEkF37T6tgzOy8Yvd0k+O4mtYzQ8EC2IQ+Wv2zI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IuwOivEt; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5499B1FCF0;
	Tue, 20 May 2025 08:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747729674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SvFrPs58EPkB1J1eYKbcnugPjOO4rAYBLdE3gnAWnA0=;
	b=IuwOivEtdrrnsvRP/JH8O/Ww8lmeA/fNquZkkfXmSL3IN4kdfx6qoegP0eErWavQfItCZi
	PkbXpmg08H/C0Wq1BM78epaxmoB9XcIy8EM4QcJuX8kHdDK+j8ElmMFc6IDPOb3FyS5I7f
	lcRwYONqSwcVHD3M8JmJWXEKy0CSY3Ena5iInVORKUSJyWY+yfchEu8AQtFIOmeGpSvOol
	z5O3Ej5O7ue8nEZcGVg4ZS6wYXMVQEBrIBB0b/Oj91xyIKprx0lquyFZ9NN07Bu0xrhuVb
	5WWUT1oxybtA52H8j5D6ezpBqaddOqcWJ8NAc0iGAJNQ3rXwJGXiljMJ+TDZ7Q==
Date: Tue, 20 May 2025 10:27:51 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com, sdf@fomichev.me,
 jstancek@redhat.com
Subject: Re: [PATCH net-next 09/11] tools: ynl: enable codegen for TC
Message-ID: <20250520102751.512d0cf5@kmaincent-XPS-13-7390>
In-Reply-To: <20250517001318.285800-10-kuba@kernel.org>
References: <20250517001318.285800-1-kuba@kernel.org>
	<20250517001318.285800-10-kuba@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdefjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtp
 hhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 16 May 2025 17:13:16 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> We are ready to support most of TC. Enable C code gen.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

This patch brings spec build error:
$ make -C tools/net/ynl -j9
...
-e 	CC tc-user.o
In file included from <command-line>:
./../../../../include/uapi//linux/pkt_cls.h:250:9: error: expected specifie=
r-qualifier-list before =E2=80=98__struct_group=E2=80=99
  250 |         __struct_group(tc_u32_sel_hdr, hdr, /* no attrs */,
      |         ^~~~~~~~~~~~~~
tc-user.c:560:10: error: =E2=80=98TCA_CT_HELPER_NAME=E2=80=99 undeclared he=
re (not in a function); did you mean =E2=80=98TCA_ACT_BPF_NAME=E2=80=99?
  560 |         [TCA_CT_HELPER_NAME] =3D { .name =3D "helper-name", .type =
=3D YNL_PT_NUL_STR, },
      |          ^~~~~~~~~~~~~~~~~~
      |          TCA_ACT_BPF_NAME
tc-user.c:560:10: error: array index in initializer not of integer type
tc-user.c:560:10: note: (near initialization for =E2=80=98tc_act_ct_attrs_p=
olicy=E2=80=99)
tc-user.c:560:32: warning: excess elements in array initializer
  560 |         [TCA_CT_HELPER_NAME] =3D { .name =3D "helper-name", .type =
=3D YNL_PT_NUL_STR, },
      |                                ^
tc-user.c:560:32: note: (near initialization for =E2=80=98tc_act_ct_attrs_p=
olicy=E2=80=99)
tc-user.c:561:10: error: =E2=80=98TCA_CT_HELPER_FAMILY=E2=80=99 undeclared =
here (not in a function)
  561 |         [TCA_CT_HELPER_FAMILY] =3D { .name =3D "helper-family", .ty=
pe =3D YNL_PT_U8, },
      |          ^~~~~~~~~~~~~~~~~~~~
tc-user.c:561:10: error: array index in initializer not of integer type
tc-user.c:561:10: note: (near initialization for =E2=80=98tc_act_ct_attrs_p=
olicy=E2=80=99)
tc-user.c:561:34: warning: excess elements in array initializer
  561 |         [TCA_CT_HELPER_FAMILY] =3D { .name =3D "helper-family", .ty=
pe =3D YNL_PT_U8, },
      |                                  ^
tc-user.c:561:34: note: (near initialization for =E2=80=98tc_act_ct_attrs_p=
olicy=E2=80=99)
tc-user.c:562:10: error: =E2=80=98TCA_CT_HELPER_PROTO=E2=80=99 undeclared h=
ere (not in a function)
  562 |         [TCA_CT_HELPER_PROTO] =3D { .name =3D "helper-proto", .type=
 =3D YNL_PT_U8, },
      |          ^~~~~~~~~~~~~~~~~~~
tc-user.c:562:10: error: array index in initializer not of integer type
tc-user.c:562:10: note: (near initialization for =E2=80=98tc_act_ct_attrs_p=
olicy=E2=80=99)
tc-user.c:562:33: warning: excess elements in array initializer
  562 |         [TCA_CT_HELPER_PROTO] =3D { .name =3D "helper-proto", .type=
 =3D YNL_PT_U8, },
      |                                 ^
tc-user.c:562:33: note: (near initialization for =E2=80=98tc_act_ct_attrs_p=
olicy=E2=80=99)
tc-user.c:637:10: error: =E2=80=98TCA_MIRRED_BLOCKID=E2=80=99 undeclared he=
re (not in a function); did you mean =E2=80=98TCA_MIRRED_PAD=E2=80=99?
  637 |         [TCA_MIRRED_BLOCKID] =3D { .name =3D "blockid", .type =3D Y=
NL_PT_BINARY,},
      |          ^~~~~~~~~~~~~~~~~~
      |          TCA_MIRRED_PAD
tc-user.c:637:10: error: array index in initializer not of integer type
tc-user.c:637:10: note: (near initialization for =E2=80=98tc_act_mirred_att=
rs_policy=E2=80=99)
tc-user.c:637:32: warning: excess elements in array initializer
  637 |         [TCA_MIRRED_BLOCKID] =3D { .name =3D "blockid", .type =3D Y=
NL_PT_BINARY,},
      |                                ^
tc-user.c:637:32: note: (near initialization for =E2=80=98tc_act_mirred_att=
rs_policy=E2=80=99)
tc-user.c:722:10: error: =E2=80=98TCA_SKBEDIT_QUEUE_MAPPING_MAX=E2=80=99 un=
declared here (not in a function); did you mean =E2=80=98TCA_SKBEDIT_QUEUE_=
MAPPING=E2=80=99?
  722 |         [TCA_SKBEDIT_QUEUE_MAPPING_MAX] =3D { .name =3D "queue-mapp=
ing-max", .type =3D YNL_PT_U16, },
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |          TCA_SKBEDIT_QUEUE_MAPPING
tc-user.c:722:10: error: array index in initializer not of integer type
tc-user.c:722:10: note: (near initialization for =E2=80=98tc_act_skbedit_at=
trs_policy=E2=80=99)
tc-user.c:722:43: warning: excess elements in array initializer
  722 |         [TCA_SKBEDIT_QUEUE_MAPPING_MAX] =3D { .name =3D "queue-mapp=
ing-max", .type =3D YNL_PT_U16, },
      |                                           ^
tc-user.c:722:43: note: (near initialization for =E2=80=98tc_act_skbedit_at=
trs_policy=E2=80=99)
tc-user.c:758:10: error: =E2=80=98TCA_TUNNEL_KEY_NO_FRAG=E2=80=99 undeclare=
d here (not in a function); did you mean =E2=80=98TCA_TUNNEL_KEY_NO_CSUM=E2=
=80=99?
  758 |         [TCA_TUNNEL_KEY_NO_FRAG] =3D { .name =3D "no-frag", .type =
=3D YNL_PT_FLAG, },
      |          ^~~~~~~~~~~~~~~~~~~~~~
      |          TCA_TUNNEL_KEY_NO_CSUM
tc-user.c:758:10: error: array index in initializer not of integer type
tc-user.c:758:10: note: (near initialization for =E2=80=98tc_act_tunnel_key=
_attrs_policy=E2=80=99)
tc-user.c:758:36: warning: excess elements in array initializer
  758 |         [TCA_TUNNEL_KEY_NO_FRAG] =3D { .name =3D "no-frag", .type =
=3D YNL_PT_FLAG, },
      |                                    ^
tc-user.c:758:36: note: (near initialization for =E2=80=98tc_act_tunnel_key=
_attrs_policy=E2=80=99)
tc-user.c:1295:10: error: =E2=80=98TCA_EXT_WARN_MSG=E2=80=99 undeclared her=
e (not in a function); did you mean =E2=80=98TCA_NAT_PARMS=E2=80=99?
 1295 |         [TCA_EXT_WARN_MSG] =3D { .name =3D "ext-warn-msg", .type =
=3D YNL_PT_NUL_STR, },
      |          ^~~~~~~~~~~~~~~~
      |          TCA_NAT_PARMS
tc-user.c:1295:10: error: array index in initializer not of integer type
tc-user.c:1295:10: note: (near initialization for =E2=80=98tc_attrs_policy=
=E2=80=99)
tc-user.c:1295:30: warning: excess elements in array initializer
 1295 |         [TCA_EXT_WARN_MSG] =3D { .name =3D "ext-warn-msg", .type =
=3D YNL_PT_NUL_STR, },
      |                              ^
tc-user.c:1295:30: note: (near initialization for =E2=80=98tc_attrs_policy=
=E2=80=99)
tc-user.c: In function =E2=80=98tc_u32_attrs_parse=E2=80=99:
tc-user.c:9086:33: warning: comparison is always false due to limited range=
 of data type [-Wtype-limits]
 9086 |                         if (len < sizeof(struct tc_u32_sel))
      |                                 ^
make[1]: *** [Makefile:52: tc-user.o] Error 1

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

