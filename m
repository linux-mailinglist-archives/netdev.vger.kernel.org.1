Return-Path: <netdev+bounces-280991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKAvGwBl62mtMAAAu9opvQ
	(envelope-from <netdev+bounces-280991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 14:41:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BCF45E92C
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 14:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E22E13005AA0
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307C5370D56;
	Fri, 24 Apr 2026 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P1PNjD6k"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F60363C72
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777034493; cv=none; b=K4vXm5ikWTHram5JUp8MiIbuhwQMFpcpbfbJKolO4zb755JdPHbkZ4re7LJDYRgYr0+o49/FSQkhoqfl+HyfM9+8aIEq9jorY7xXDfqU6wLQ7JtpuXRncDeqVKtVXH3zRwdQkJzGrVr6Mwk9PfxhPsgrPl2lSszvb2OA/UybjLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777034493; c=relaxed/simple;
	bh=hEicbs1wzBY7rUjJ3eZCitqtz5d1kvB3rwSDToMHJ30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1NiKtsi+cTRFcWSnfkgDB7HvI0ZjpmIcaq2JaO23LBsRTnMgvHsH4/kXs0ewQmq2qYrqPr71ZE6tGTI3NQ+40JWB/xQN1SGXB5jP/JfwusPrhMAZF780oxjQX8WzRUo35TpPFWCM0YqeoJ1OUqp7dhLZc03Qyf6I6lceoSr0X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P1PNjD6k; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 48D221A33F7;
	Fri, 24 Apr 2026 12:41:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1799D604EB;
	Fri, 24 Apr 2026 12:41:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8CD31072051C;
	Fri, 24 Apr 2026 14:41:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777034488; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GSmC6zgf5uWdJlGUklCdCmL76WRr4s3hDP8boQgIebU=;
	b=P1PNjD6kj7oo8tpGBNbwwbNWe+EJfegHwMsAdyiDwFuwpUuaSLISiLe6sicbzo9b5pRw+u
	u0QnW/GCkWC5JI8lzL5krztUqWP9seEnJwDLnJOHMksuz9EXEG4HucgMIFnwUft9Q58bJP
	8cQaxIgkj0jVcYGVpHVcWR626XN23XhJ46EHu0HZMKw1wZKx2Q60jM2vi36ifFC7aXM5bI
	tas3SUDO1dScHyDphdM7ocO5AaG8obyRR4TICF9WXl1jvqzbakXRsvoyItfOanaZDy7WWC
	d0Cnigbl/VzBLaV86i4sAaFVbK7WGmLdA0QYHu/tyEK1Tn+GgjaMf/DvGJT+bg==
Date: Fri, 24 Apr 2026 14:41:24 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Corey Leavitt <corey@leavitt.info>
Cc: Carlo Szelinsky <github@szelinsky.de>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Lunn
 <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller
 lookup from MDIO probe
Message-ID: <20260424144124.131837c7@kmaincent-XPS-13-7390>
In-Reply-To: <177693772506.254295.6378636892307427408@leavitt.info>
References: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
	<20260423110544.052f631e@kmaincent-XPS-13-7390>
	<177693772506.254295.6378636892307427408@leavitt.info>
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
X-Rspamd-Queue-Id: E9BCF45E92C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[szelinsky.de,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-280991-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Thu, 23 Apr 2026 09:48:53 +0000
Corey Leavitt <corey@leavitt.info> wrote:

> Hi Kory,
>=20
> Thanks for the pointer -- I had not seen Carlo's thread; I should have
> searched lore before sending and will do so before v2. Adding Carlo on
> cc.
>=20
> Having read it end-to-end, my read of the state as of 2026-04-13 was
> that the conversation had narrowed to two open directions: propagate
> EPROBE_DEFER further up into phylink/MAC probe (Andrew/Russell), or
> resolve psec at PSE controller register time (your msg on 9 Apr,
> "save the phandle ... then at PSE register time look for each PHY and
> try to resolve every unresolved phandle"). Nothing concrete had been
> posted for either.
>=20
> This RFC implements the second direction. pse_core publishes a
> BLOCKING_NOTIFIER chain with REGISTERED / UNREGISTERED events,
> phy_device subscribes, and psec ownership moves from fwnode_mdio probe
> into the notifier handler. Concretely with respect to points raised in
> the earlier thread:
>=20
>   - fwnode_mdio loses PSE awareness entirely, so the MDIO bus scan no
>     longer sees -EPROBE_DEFER from PSE lookup. Consistent with
>     Andrew's point that bus and device lifecycles are separate.
>=20
>   - psec is acquired at PSE register time, before
>     regulator_late_cleanup (30s) can run. Carlo's admin_state_synced
>     guard (his patch 1) therefore isn't needed in this model. psec
>     resolution happens eagerly on the REGISTERED event rather than
>     lazily on first ethtool access, so his patch 2 is also not needed.
>     And because fwnode_mdio no longer looks up PSE at all, the
>     non-fatal EPROBE_DEFER handling there (patch 3) drops out. This
>     series is a different architectural shape, not an increment on
>     his v2.
>=20
>   - Oleksij's concern about lazy resolution dropping UAPI
>     notifications is addressed: the notifier fires at register time,
>     so boot-time observer semantics are preserved.
>=20
>   - One caveat I already owe a fix for in v2: the attach helper in
>     phy_device currently treats every error from of_pse_control_get()
>     as retry-on-notifier, including non-transient ones. Carlo's v2
>     patch 3 was careful to differentiate -EPROBE_DEFER from bad-DT
>     errors at the fwnode_mdio lookup site (which matches his msg 1
>     concern about catching broken bindings at boot rather than
>     silently later). I need to preserve that discrimination at the
>     notifier-handler site -- phydev_warn() on anything other than
>     -EPROBE_DEFER. Trivial, but worth flagging.
>=20
>   - The DSA genphy force-bind sequence Carlo hit
>     (phy_attach_direct -> device_bind_driver -> deferred retry
>     skipped) does not apply, because psec attachment is not tied to
>     phy_probe.
>=20
>   - Patch 1 of this series scopes the regulator handle held by
>     pse_control to its own kref lifetime, fixing a latent
>     dangling-handle sequence that the notifier unregister path makes
>     reachable. This is a separate regulator-lifetime bug from the one
>     Carlo's patch 1 addresses.

This seems to provide a solution to all our problems, and it is well design=
ed.
Carlo, it would be nice if you could test it on your side.

> Validated end-to-end on a Cudy C200P (MT7621 DSA + i2c IP804AR as
> module), with lockdep active, across the i2c driver unbind/rebind
> cycle that triggers UNREGISTERED -> REGISTERED on the live system.
> The cover letter has the full evidence.
>=20
> I would welcome your view on whether this is the shape you had in
> mind on 9 Apr, or whether the MDI-based binding you raised with
> Maxime is the better endpoint and we should be reshaping around that.
> Happy to keep this RFC as the scaffolding either way.

After a second thought, MDI-based binding is currently not in the pipe and =
we
should solve this without it for now.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

