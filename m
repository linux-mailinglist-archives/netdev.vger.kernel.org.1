Return-Path: <netdev+bounces-280673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPxWOerh6WlQmgIAu9opvQ
	(envelope-from <netdev+bounces-280673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:10:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA12244F11D
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8BC93080034
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BE73E122A;
	Thu, 23 Apr 2026 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VG/yoEpb"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E463DEFF5
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776935158; cv=none; b=nnTpheppOZ+FSD0QXFrh1mabuHEaAE53IRMvS9YocmrEPG6YYvAGpPDP+xysoe27OWQNML81paha70t9CkLegBwS/2ztdqLJr695/MQqdDJ45CbUwTxwf58PHcsF6OnSXPKs7iL18rHoEj20orLF51ROwwdsGVhBaOLi1RKEgQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776935158; c=relaxed/simple;
	bh=0wtiFezDKyaxNULAdHxx9242Kp7jiYvX8Jk7t4Pw8aI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNDfQr0eFpDlFDNzzZk7mqh9Ysp0xan7YSaC8i39tcGPq7GEni1WI2ywnU1E0z/ygay6ZahLKS+4KELld3VugIzi97svZpRMer7tMdqKIKNcxZtR0JCyknb3jTOGOWuffysONvpAI9QyxRN4patCEfsdmHQV830XVT/qFA0P2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VG/yoEpb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9249C1A33B9;
	Thu, 23 Apr 2026 09:05:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A79560495;
	Thu, 23 Apr 2026 09:05:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96CD510460A92;
	Thu, 23 Apr 2026 11:05:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776935151; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZUjiXgUQ6NKbZaLjNry6Yj8P8wNfKg9Mrmw2T6xzVd0=;
	b=VG/yoEpbYzNLx9jF8GIwUchh/nvKn9Sqvu7FAzaEbFp7qyeUpFZ1IpR2pHmivMhYfXY2W9
	kAySdhDUAWQ25bebSyPIB1hEiDVLwM7LP0cOsvpqXBVkU4GfQVfvmSBeTfR9Z1hhiSISJt
	eMIdMYKHjG4ZtFuPtLZbCR6k1vKtwrFOuU0taft+G051/IaZ/sBJ/4mvmZS0iOFeSfGgkb
	roHGklSRC0qqc3BHVg9zfiTWinRZmsH3aZmyynEKMD8K1S8bRRkCJSQ3O4i4foBMcUh75D
	huZyW40C7r/RE89oaavg1T33bVhIuWz1jtW1vY1V4Cao1/KIQib85gbEzVl4Cw==
Date: Thu, 23 Apr 2026 11:05:44 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Corey Leavitt via B4 Relay <devnull+corey.leavitt.info@kernel.org>
Cc: corey@leavitt.info, Oleksij Rempel <o.rempel@pengutronix.de>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller
 lookup from MDIO probe
Message-ID: <20260423110544.052f631e@kmaincent-XPS-13-7390>
In-Reply-To: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
References: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280673-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[leavitt.info,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,corey.leavitt.info];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[leavitt.info:email,bootlin.com:dkim,bootlin.com:url]
X-Rspamd-Queue-Id: BA12244F11D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Corey,

On Thu, 23 Apr 2026 01:42:13 -0600
Corey Leavitt via B4 Relay <devnull+corey.leavitt.info@kernel.org> wrote:

> On systems where a PSE controller driver loads as a module and a
> device-tree PHY node carries a `pses =3D <&pse_pi>` reference,
> fwnode_mdiobus_register_phy() tries to resolve the PSE handle before
> the controller driver has probed. of_pse_control_get() returns
> -EPROBE_DEFER, the enclosing MDIO/DSA probe fails, and driver-core
> re-queues the work. The retry loop spins until the PSE driver module
> loads and its controller registers.

I will take a look at your series but FYI there was already a RFC series
tackling this issue:
https://lore.kernel.org/lkml/20260330132952.2950531-4-github@szelinsky.de/

It rose a debate and there was currently no final solution.
=20
> Commit fa2f0454174c ("net: pse-pd: Introduce attached_phydev to pse
> control") made each retry expensive. It reordered
> fwnode_mdiobus_register_phy() so the PHY is registered before the
> PSE lookup. Every deferral now performs a full
> phy_device_register() / phy_device_remove() cycle. On a board with a
> sufficiently tight watchdog the retry loop can starve the watchdog
> kthread. On the reporting hardware (MT7621 + gpio-wdt, 1-second
> margin) the retry loop converts a slow probe phase into a reset
> before userspace loads.
>=20
> The affected population today looks small. OpenWrt, where PSE
> actually ships, is still on 6.12 (pre-regression), and most
> environments with CONFIG_PSE_*=3Dm do not have boards whose DT
> references a PSE controller from a PHY. Still, the mechanism is
> general. Any modular PSE driver combined with the documented
> `pses =3D <&...>` binding reproduces the retry loop. Whether it
> reaches brick-grade or merely slow/flaky boot depends on local
> watchdog timing. More exposure is expected as distribution and
> embedded kernels move to 6.13 and later.
>=20
> The narrow fix would be to partially revert the ordering in
> fa2f0454174c so each defer is cheap again. That keeps the same
> architecture (fwnode_mdio holding PSE knowledge, -EPROBE_DEFER
> flowing across the subsystem boundary), and any future reorder
> reintroduces the same class of bug. This series takes the larger
> fix: decouple PSE controller lookup from MDIO registration entirely.
> pse_core now publishes a BLOCKING_NOTIFIER chain with REGISTERED
> and UNREGISTERED events. phy_device subscribes, owns phydev->psec
> lifetime, and attaches PSE handles in response to controller
> lifecycle rather than during probe. fwnode_mdio loses its PSE
> awareness, and -EPROBE_DEFER no longer flows out of fwnode_mdio.
>=20
> Patch breakdown:
>=20
>   1. Scope the pse_control regulator handle to kref lifetime
>      (Fixes: d83e13761d5b). A latent bug that patch 4 makes
>      reachable.
>   2. Add the notifier chain (enum, head, register/unregister
>      helpers). Pure infrastructure. No subscribers yet, no
>      observable change.
>   3. Fire REGISTERED and UNREGISTERED events from the controller
>      register/unregister paths. Still no subscribers, still no
>      observable change.
>   4. Subscribe from the PHY layer, take ownership of phydev->psec
>      via the notifier, and remove fwnode_find_pse_control() from
>      fwnode_mdio.
>=20
> Patch 1 is bundled here per stable-kernel-rules section 4
> reachability guidance. On mainline today, with no notifier
> subscriber, no caller drives the dangling regulator-handle sequence.
> Patches 2 and 3 are deliberately split to separate "add
> infrastructure" from "wire it up". Happy to fold them if maintainers
> prefer the combined form.
>=20
> Validated on a Cudy C200P (MT7621 + IP804AR) running an OpenWrt
> build of 6.18.21 with the series applied. A lockdep build
> (CONFIG_PROVE_LOCKING + CONFIG_DEBUG_ATOMIC_SLEEP) shows no splats
> from the series' code paths during boot, PHY attach, PHY detach, or
> a full controller unbind/rebind cycle. ethtool --set-pse drives all
> four PoE-capable LAN ports, and a Ruckus H510 class-4 PD plugged
> into lan3 negotiates and receives 48 V.
>=20
> The C200P has no SFP cage, so the SFP path change in sfp.c
> (phy_device_register -> phy_device_register_locked) isn't exercised
> on the bench. Verified by call-graph audit: every path reaching
> sfp_sm_probe_phy() holds rtnl at entry, via sfp_timeout,
> sfp_check_state, sfp_probe, sfp_remove, or
> sfp_bus_{add,del}_upstream.
>=20
> Not addressed by this series: ethtool --show-pse returns "No data
> available" on DSA netdevs in 6.18, because dev->phydev is NULL for
> DSA-frontend netdevs and ethnl_req_get_phydev() therefore returns
> NULL. That's a DSA / ethtool integration quirk that predates this
> work.
>=20
> Sending as RFC because this is my first net-next series. I'd
> appreciate maintainer guidance on whether patch 1 should go to net
> rather than net-next, and whether the patch 2/3 split is preferred
> to the combined form.
>=20
> Signed-off-by: Corey Leavitt <corey@leavitt.info>
> ---
> Corey Leavitt (4):
>       net: pse-pd: scope pse_control regulator handle to kref lifetime
>       net: pse-pd: add notifier chain for controller lifecycle events
>       net: pse-pd: fire lifecycle events on controller register/unregister
>       net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio =
hook
>=20
>  drivers/net/mdio/fwnode_mdio.c |  34 ----------
>  drivers/net/phy/phy_device.c   | 144
> ++++++++++++++++++++++++++++++++++++++--- drivers/net/phy/sfp.c          |
> 2 +- drivers/net/pse-pd/pse_core.c  |  60 ++++++++++++++++-
>  include/linux/phy.h            |   2 +
>  include/linux/pse-pd/pse.h     |  41 ++++++++++++
>  6 files changed, 236 insertions(+), 47 deletions(-)
> ---
> base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
> change-id: 20260422-pse-notifier-decouple-efa80d77f4be
>=20
> Best regards,
> -- =20
> Corey Leavitt <corey@leavitt.info>
>=20
>=20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

