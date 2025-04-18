Return-Path: <netdev+bounces-184206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D2BA93BA2
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 19:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF45464428
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 17:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5F7215782;
	Fri, 18 Apr 2025 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dan0ahEz"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600A74CB5B
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995877; cv=none; b=jFzTLd5CwMqu2YpmIRQFQ2i8tCMvoDXg7RcSR8e20NWSFGSnEzPxwJk05zLGXQ6ajMG5E9euLB1k6D+Ngn2xtQ1Bc/WJj96ejI2vMLH+NznvOYB2GaIQAH0jjEuexTh2qY0KOAjOUi1+6NpRq2mr3SlSXRUhVTDYgpbJNYh50lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995877; c=relaxed/simple;
	bh=OTapgSwgLLdxTvhxyYt2b7x7+wuenEteyF9sDvzxssU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EiRSv7T4xnFB3Yy/QxDO66UkvbsMwOUabxtTb6EEkOpt70XQ7gkItmeLRNqVU4n0qC3I+iOzCn1hJyD3x4begxO+kcB6JiXcMYjJCqZRAWf5LxSNTsTLirnF/JRb48nvJG0D1o4QYj9H2XuQClf1lOEJ2QhGo6TcxrECShVe2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dan0ahEz; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E84B3439EB;
	Fri, 18 Apr 2025 17:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744995873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Us5RYVBuh7gVLQ8W7Dr1/7D4Y1egBvTGmiLiLUIPuoY=;
	b=dan0ahEzr2sSSJTbNwljFF8UC7qMLk+W3FepXqKojPKi8q16jkSpwxEh2hUrjJ8zedbtLp
	WeSO3aYsXEMf2joqe3gTx5c9GTCSqpC1f+znyDafTNBTGMY9IEfBrL1srleP6bvOOS8Stg
	TADzXFsUFWRMrIUF/LcSIFdIZdYInMj+5lkNgsOZfH00ctq6WhKpOm73pLft2/lObgpo86
	TKTQeIS0vjs7PNANsmvcTLBILvafQFAwhiZ159FAfgvBqktL+uCiHxJV+dM9P9BWYMBzVr
	/jUPQEDgN1wD1rukrov5cGtHTiyINM6LbegviuhadRp7NVYK/3PEZz3iBWL2mQ==
Date: Fri, 18 Apr 2025 19:04:31 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com, yuyanghuang@google.com,
 sdf@fomichev.me, gnault@redhat.com, nicolas.dichtel@6wind.com,
 petrm@nvidia.com
Subject: Re: [PATCH net-next v2 12/13] tools: ynl: generate code for rt-addr
 and add a sample
Message-ID: <20250418190431.69c10431@kmaincent-XPS-13-7390>
In-Reply-To: <20250410014658.782120-13-kuba@kernel.org>
References: <20250410014658.782120-1-kuba@kernel.org>
	<20250410014658.782120-13-kuba@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduleemkeehkeejmeejuddttdemtgefgeegmeguugeivdemuggsvdekmegrtdguugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekheekjeemjedutddtmegtfeeggeemugguiedvmegusgdvkeemrgdtuggupdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtp
 hhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Wed,  9 Apr 2025 18:46:57 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> YNL C can now generate code for simple classic netlink families.
> Include rt-addr in the Makefile for generation and add a sample.
>=20
>   $ ./tools/net/ynl/samples/rt-addr
>               lo: 127.0.0.1
>        wlp0s20f3: 192.168.1.101
>               lo: ::
>        wlp0s20f3: fe80::6385:be6:746e:8116
>             vpn0: fe80::3597:d353:b5a7:66dd
>=20
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Hello,

This seems to broke the check-spec:

$ make -C tools/net/ynl   =20
...
rt-addr-user.c:62:10: error: =E2=80=98IFA_PROTO=E2=80=99 undeclared here (n=
ot in a function); did you mean =E2=80=98IFA_RTA=E2=80=99?
   62 |         [IFA_PROTO] =3D { .name =3D "proto", .type =3D YNL_PT_U8, },
      |          ^~~~~~~~~
      |          IFA_RTA
rt-addr-user.c:62:10: error: array index in initializer not of integer type
rt-addr-user.c:62:10: note: (near initialization for =E2=80=98rt_addr_addr_=
attrs_policy=E2=80=99)
rt-addr-user.c:62:23: warning: excess elements in array initializer
   62 |         [IFA_PROTO] =3D { .name =3D "proto", .type =3D YNL_PT_U8, },
      |                       ^
rt-addr-user.c:62:23: note: (near initialization for =E2=80=98rt_addr_addr_=
attrs_policy=E2=80=99)

I found it through git bisect.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

