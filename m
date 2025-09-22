Return-Path: <netdev+bounces-225323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCA0B92333
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 18:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1848A1896FE3
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 16:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BF02D94B3;
	Mon, 22 Sep 2025 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KdLt3BPy"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1076930DD37;
	Mon, 22 Sep 2025 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558033; cv=none; b=L6v27tSTgsYAozCGtXnZq9fxOXXJ6K8Nz3fxI0SHSxqcfhAjA+hXW+vDXt9fmd4sIIw8sjwgKfDOGldjkHe5wtvnVq2GsAKsIswI2IKw5H2ad4g88wLysKwVeGTWRpoelEIk9GYNnCqkXP9FkZP/xjtIgdPhE9xKzvWmA0WYz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558033; c=relaxed/simple;
	bh=Be4GevQkmF/nFmdQN6+ONfubwu/F5kbrYP4ewlUZlXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHUoIfapOnyX8QKcyUScrTbbjR73UgkkBi9ItODpibURoe6FeK96z+I6XO129tt+GCkmWM/MUY2qxaalEYGXExW91fKV98lTSkc9eb8DGnPlR13CJq/dfSzfUFjMN7odSbsgp0Swq0Hu4t8VUwiXVl/cp0SfT/HRcPRRbOgWgbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KdLt3BPy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3DF8F1A0F08;
	Mon, 22 Sep 2025 16:20:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 111CE60635;
	Mon, 22 Sep 2025 16:20:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66EEE102F193E;
	Mon, 22 Sep 2025 18:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758558027; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=u/5Oa4oSVwwK58CYuiN5FtTp13SFKt17H/vR6qsflCQ=;
	b=KdLt3BPy4PPPNqmCpLPibifuqjV5FPeD0cBX2voEwmizA1QmtL20rgI0pk8JotVuVlC9ip
	Ov53SUeg1HnoEY4Zp1pKqGWgFGCv5UxLS0rxM8x2UWxBtnslr+GvHYBkih5UMcWzlN6wbD
	4vC3qpwJYPg95RR1lFzM07GJHyDt9tggZV+sIpglXNoN8SVO0/pvskRiq1utZ9EGAWFmeD
	KOfBKRP/eh2KL6LfojppLod1KjszwKsEZYLRcdVuYtAVy2V5PWeDmbiBwK+exRRhQxuVwe
	voRsEmabOC9vWIVqJUGKNgfFpiNd+llXGcqklnQju+nakoNXPz736re0eUmx1Q==
Date: Mon, 22 Sep 2025 18:20:02 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>,
 kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Luka Perkov <luka.perkov@sartura.hr>, Robert Marko
 <robert.marko@sartura.hr>, Sridhar Rao <srao@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 0/5] net: pse-pd: pd692x0: Add permanent
 configuration management support
Message-ID: <20250922182002.6948586f@kmaincent-XPS-13-7390>
In-Reply-To: <20250917141912.314ea89b@kernel.org>
References: <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
	<20250916165440.3d4e498a@kernel.org>
	<20250917114655.6ed579eb@kmaincent-XPS-13-7390>
	<20250917141912.314ea89b@kernel.org>
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
X-Last-TLS-Session-Version: TLSv1.3

Hello Jakub,

On Wed, 17 Sep 2025 14:19:12 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 17 Sep 2025 11:46:55 +0200 Kory Maincent wrote:
> > > On Mon, 15 Sep 2025 19:06:25 +0200 Kory Maincent wrote:   =20
>  [...] =20
> > >=20
> > > I'm still unclear on the technical justification for this.
> > > "There's a tool in another project which does it this way"
> > > is not usually sufficient upstream. For better or worse we
> > > like to re-implement things from first principles.
> > >=20
> > > Could you succinctly explain why "saving config" can't be implemented
> > > by some user space dumping out ethtool configuration, saving it under
> > > /etc, and using that config after reboot. A'la iptables-save /
> > > iptables-restore?   =20
> >=20
> > I think the only reason to save the config in the NVM instead of the
> > userspace is to improve boot time. As Oleksij described: =20
> > > I can confirm a field case from industrial/medical gear. Closed syste=
m,
> > > several modules on SPE, PoDL for power. Requirement: power the PDs as
> > > early as possible, even before Linux. The box boots faster if power-up
> > > and Linux init run in parallel. In this setup the power-on state is
> > > pre-designed by the product team and should not be changed by Linux at
> > > runtime.   =20
> >=20
> > He told me that he also had added support for switches in Barebox for t=
he
> > same reason, the boot time. I don't know if it is a reasonable reason to
> > add it in Linux. =20
>=20
> Right, subjectively I focused on the last sentence of Oleksij's reply.
> I vote we leave it out for now.

I would like to restart the discussion as I have one more argument besides =
the
boot time optimization coming from Luka Perkov in CC.

According to him, not having this feature supported also brings an issue ac=
ross
reboot:
"When a network switch reboots, any devices receiving Power over
Ethernet (PoE) from that switch will lose power unless the PoE
configuration is persisted across the reboot cycle. This creates a
significant operational impact: WiFi access points and other
PoE-powered devices will experience an unplanned hard power loss,
forcing them offline without any opportunity for graceful shutdown.

The critical issue is not the impact on the switch itself, but rather
the cascading effect on all dependent infrastructure. Without
kernel-level persistence of PoE settings, a simple switch reboot
(whether for maintenance, updates, or recovery) forces all connected
PoE devices into an abrupt power cycle. This results in extended
downtime as these devices must complete their full boot sequence once
power is restored, rather than remaining operational throughout the
switch's reboot process."

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

