Return-Path: <netdev+bounces-195712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CAEAD2091
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302453A0F55
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D8C25CC56;
	Mon,  9 Jun 2025 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GclB97S4"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534A25C834;
	Mon,  9 Jun 2025 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749477983; cv=none; b=ZmS+IeV1y6MMTIC32PhAE9MqqcLk1uPrX/JAqXZinH7N2EQqGu7QcDYuZpuN/7q59vWjsNIPOh+1uAbcPXGF7c3MIItt7chktsuS9oqZyVJ59FO6neIh4Dl5/wdH46VU3xf/LbNqaA29gBkYnoiyKugDIvNhpmWWwb+B5By6jaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749477983; c=relaxed/simple;
	bh=3lOJgnhrpQkPu25jDi+5V6s0BfBYYwj8jM4H4EhVCZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fm4+6j/Q2nvdUsKnxRDJEy6+PNSu+CXfdsf/vOsic/yHf3zrAMcD3n7HIahsvBDb0FwqnWeiS/dPDJEcPD0UVrBx9zVHK84PMlZzCPUOGqdvPbQHLFIenxzlILZ2mAd2g9LtLTpKOD1y9LkT7Qfs4S4w9QkoenWXUwhWWhaWyTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GclB97S4; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DCF143B16;
	Mon,  9 Jun 2025 14:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749477979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zn7wuquz4DmlIJeSlveu8NxjTLD/+5rvhB4h/bX2BVM=;
	b=GclB97S4y4Jr4l7SuD1EVFc6EXjzEUhlJx7X6R+GF/Gf9CePGKDtGcO4p5rVnhoB8Nh9i0
	p87KVyZv63vJmN8GERsQm9Y90cdXF3dtmMICIUvLnkVOs0Bu2wDVbi4AAQw21gbOrRDwwh
	rr2m64lN9SWQED3zlmDlqO40A+mDLou43L9vLgTEOq0Mh+90GSupKJJaZn2XriJyghVAUo
	YQeogCebledYjtdxstqiaKDetfc64B8kJhC6jntslj7p84JQg6rEHioDPR2mpUifT0vUhz
	OvJoBSO3v2cho5lcVdgOPmmM33JT4rdh8xOZXfO0Q3rtVJ20Ja3JPLMxS6CClg==
Date: Mon, 9 Jun 2025 16:06:16 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Gal Pressman <gal@nvidia.com>
Cc: patchwork-bot+netdevbpf@kernel.org, andrew@lunn.ch, kuba@kernel.org,
 donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, willemdebruijn.kernel@gmail.com,
 kernelxing@tencent.com, richardcochran@gmail.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
 linux@armlinux.org.uk
Subject: Re: [PATCH net-next v4] net: Add support for providing the PTP
 hardware source in tsinfo
Message-ID: <20250609160616.3afc8acd@kmaincent-XPS-13-7390>
In-Reply-To: <fd48f64f-dec2-489b-a9b9-dc1aa38ca61d@nvidia.com>
References: <20250519-feature_ptp_source-v4-1-5d10e19a0265@bootlin.com>
	<174792123749.2878676.12488958833707087703.git-patchwork-notify@kernel.org>
	<fd48f64f-dec2-489b-a9b9-dc1aa38ca61d@nvidia.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelfeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhudevkeeutddvieffudeltedvgeetteevtedvleethefhuefhgedvueeutdelgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepghgrlhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepphgrthgthhifohhrkhdqsghothdonhgvthguvghvsghpfheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhun
 hhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

Le Mon, 9 Jun 2025 15:18:49 +0300,
Gal Pressman <gal@nvidia.com> a =C3=A9crit :

> On 22/05/2025 16:40, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> >=20
> > This patch was applied to netdev/net-next.git (main)
> > by Paolo Abeni <pabeni@redhat.com>:
> >=20
> > On Mon, 19 May 2025 10:45:05 +0200 you wrote: =20
> >> Multi-PTP source support within a network topology has been merged,
> >> but the hardware timestamp source is not yet exposed to users.
> >> Currently, users only see the PTP index, which does not indicate
> >> whether the timestamp comes from a PHY or a MAC.
> >>
> >> Add support for reporting the hwtstamp source using a
> >> hwtstamp-source field, alongside hwtstamp-phyindex, to describe
> >> the origin of the hardware timestamp.
> >>
> >> [...] =20
> >=20
> > Here is the summary with links:
> >   - [net-next,v4] net: Add support for providing the PTP hardware sourc=
e in
> > tsinfo https://git.kernel.org/netdev/net-next/c/4ff4d86f6cce
> >=20
> > You are awesome, thank you! =20
>=20
> Netdev maintainers,
>=20
> Was there a discussion about merging this without a selftest that covers
> this uapi extension? Is this considered an exception?

Not that I know of.
Indeed I will update tools/testing/selftests/net/hwtstamp_config.c following
the new uAPI using netlink instead of ioctl.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

