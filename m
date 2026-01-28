Return-Path: <netdev+bounces-254669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKjMA/4he2mZBgIAu9opvQ
	(envelope-from <netdev+bounces-254669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:01:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FED9ADE8F
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFCEE300BDB5
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2C037D110;
	Thu, 29 Jan 2026 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DYAAX1Za"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88937E310;
	Thu, 29 Jan 2026 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769677141; cv=none; b=Viiml8P2qvEyGDNKPwTWQRE4fFxJ8BFxQ1TuBFPqi7fN/AJFJGcsnupLzwHnSZXWwPW31iMjBYFchnrYdPuydoyWGfF3CcViQ6YNRdT/IegFMaCou0wbP7p/jNUrgOSyfe4YAQ2zaWPO/laGpHv94yHIijTJcGNzEjsjy9VWbB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769677141; c=relaxed/simple;
	bh=ZEM07gUZA4atbSTuRc39eyPkVvIyZcjTej1KPQqC0G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lScnxntsMQzXwWwhdwxtAOs9Tjh+Ijiq5JV1kzCtjISNLDuElgp0FyiJU/O6q0HLT0JsvxGla9+X+WK+IizhsOB8D4dzTwpbl6tmhzVKPzFLjjecS/nsLm0a07fWvKJXKSfw6EnZI6ynkwavQaQKWusrsOWbmPIcsMmXxXRPPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DYAAX1Za; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 48525C211FB;
	Thu, 29 Jan 2026 08:58:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 65C00606B6;
	Thu, 29 Jan 2026 08:58:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3B6E2119A884E;
	Thu, 29 Jan 2026 09:58:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769677132; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=M87QZDRyHQhsV+Pkt7dg5f1DCunyRH2lCoxOtMpqWO8=;
	b=DYAAX1ZaK3X9kvpOrtOpiZuMTFiy42ulDDrblGemIJWLrdB2UKRx+Gx7Iox0SR49qmIdTV
	dZgJ9GedO0o9zgKhq6SJ1L2rrLaFsURAF6Ohcu+jcpdrkVZ1GJZ2ME9wBvfRhm/R+PUj32
	lSjTrwBTC+8DSgq+3XfIvb6+ScmN7Hxb1HmcFcYpODe5JhHZ0UCw6fABCYhD7YTiT3hJ2K
	9yow6bJqIay8n8+FuGT91Iwa5RFjd9dVi2tODIT6V/YbhvXRx5YaGNfHiCf0Q0wy3z/Ln9
	ZfqQ1B3Xyto0JJZOxSs2+nJXOSQoPDp26FXvxwQpbGt6gPwOEpYmvk0COytfKg==
From: Romain Gantois <romain.gantois@bootlin.com>
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
 Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject:
 Re: [PATCH net-next 05/13] net: phy: Create SFP phy_port before registering
 usptream
Date: Wed, 28 Jan 2026 16:49:30 +0100
Message-ID: <5074665.31r3eYUQgx@fw-rgant>
In-Reply-To: <20260127134202.8208-6-maxime.chevallier@bootlin.com>
References:
 <20260127134202.8208-1-maxime.chevallier@bootlin.com>
 <20260127134202.8208-6-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4710557.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254669-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SEM_FAIL(0.00)[172.234.253.10:query timed out];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[romain.gantois@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url,bootlin.com:dkim]
X-Rspamd-Queue-Id: 9FED9ADE8F
X-Rspamd-Action: no action

--nextPart4710557.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Wed, 28 Jan 2026 16:49:30 +0100
Message-ID: <5074665.31r3eYUQgx@fw-rgant>
In-Reply-To: <20260127134202.8208-6-maxime.chevallier@bootlin.com>
MIME-Version: 1.0

Hi Maxime,

On Tuesday, 27 January 2026 14:41:53 CET Maxime Chevallier wrote:
> When dealing with PHY-driver SFP, we create a phy_port representing the
> SFP bus when we know we have such a bus.

Shouldn't this be "with a PHY-driven SFP"?

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart4710557.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAml6MAoACgkQKCYAIARz
eA6m+w//fQDaTf82LEx8j3/5nKvbOhYFHbQuNbwr2zOCYvg6MKmt8NhNr6E2SYL3
sw7Far2XBvxgL5ZdOVIVCjPVGN1OpBWb0HhzmF3G06Gx9s2iHOcytJeR8r8EKzlL
6ANY7dWjNiEUJlnUtEZxWVnEGDmUdKJR67FsoNNipocxdYSQdS2tCCAH0K1O0VSw
4PWKO5mHWK6duemrl+y/XkFlIWhmgIFRAvGdo9E3on7HvwC1Ew44o2jRnkXpSbx6
iaPTZ8EYWP/WCipI3d1dqO5ziUC0aN3TDrxZVJK0ttSBzV7IEFG0dDr2zpyvP0Ce
Z4gOL9sL9/Wh0f5z6Bv/s0yavZMDIfjygHHPvTUV5WsaZf371zU5STp1y3qeWcdz
lN2iKzVsZRmjKSYKQVyBnS6isQZ9FCYtVEGB+nuvmDrRaub9V3NYRbNvWcd2yuED
Xdnmj+FiDF1MdHjBwGPcSIOuI1OsLyha75paIaexgMIDh1tGPgrmssxJG9evGpIn
SSHGJE9gVA/6khCKpu2/xcAR7Yzn3ZawEHy8GNpbgp+ESO30ENOXruNwge++WbZY
J0sCyp3pFplRQhfGbOEfcpoF9kqq/3Us1ae94GoxtLGFYTy/NHklsPx69OJvw588
HLoZnaNx2toi9iDzVNX0KoII4+UPsI7Horbv4IAoALl9sKLsqW0=
=H/CG
-----END PGP SIGNATURE-----

--nextPart4710557.LvFx2qVVIh--




