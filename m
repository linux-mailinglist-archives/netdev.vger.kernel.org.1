Return-Path: <netdev+bounces-254666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNC+Mkwhe2mCBgIAu9opvQ
	(envelope-from <netdev+bounces-254666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:58:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75892ADE51
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 025D73008327
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E07537E30D;
	Thu, 29 Jan 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2p89WbYY"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CC137996D;
	Thu, 29 Jan 2026 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769677129; cv=none; b=Jk66nA6cwcjMSrO0R5hQQVhd0hpTGBPJYhAU7KKUwuXdb/a2peu7eOYp8V3xeSonQEaqse7SA73Wn6y8eAyvJY41bwWqCcQ6f+qsMBtVwbkVcSXa1oMiKQsPmXUuAwfXCZQ3QzybxdvEH7YXu6SgQOoz4pMbCgcDbfoEQz1JjBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769677129; c=relaxed/simple;
	bh=n8l5ZMrxRjMfbCzpA/tPyTP1qNe3V/9tguAGw6mAxLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBX//Xp/mm2CHdE0JvLhnp1F4yvO5Z7gqbboKReUlFceEa+Pspt/tRJ5DIiqmj19VHJx9LHczy9eLU7pEBP6yPv1ejls7GQZrvDImY2/1tsqZjesaDAo9QzYK2rqqIMcTIMENHluL4mC7KuzWk8ZiSaPpJzL6fMUbAAG69HVXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2p89WbYY; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0D9D11A2ADC;
	Thu, 29 Jan 2026 08:58:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D12F1606B6;
	Thu, 29 Jan 2026 08:58:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CC29119A884E;
	Thu, 29 Jan 2026 09:58:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769677124; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=NwKLuSE3r9FFRNMthHrpD7xKUjwlQn1LO7jf3zWxFMk=;
	b=2p89WbYYYMSjsqxczIeYCPdH/yzIHoQ+aAVZaW7lWWaqNQ6kURtXcb2vY7Md1FBjykS/zN
	0mo5IzuQUTT8nfnM/dGXAHXChBKYq0QrLRyYm1IXNccYLz3PTFrjZcqjam+tpq/f2QzkKJ
	lzLxtTtEEl7agPp+iE69lnhyBUWtTKzQn6HSEyBQGg8yuUfcI3foBn9IWlVvzqYSpEZbhu
	1tXh43Y7ZAil0VNEqE5+b3wBsWNElzCR+sVOY/d8shsMBz1qhXHjcSnXzCzig2NezxxZZm
	/ALhCqr68Lo0ofFpVQfHarIFwbnfJeEK/X9Jt0+jdehABtjEy6I0NpgG7srOQA==
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
 Re: [PATCH net-next 09/13] net: phy: phy_port: Store information about a MII
 port's occupancy
Date: Wed, 28 Jan 2026 17:08:40 +0100
Message-ID: <2338720.iZASKD2KPV@fw-rgant>
In-Reply-To: <20260127134202.8208-10-maxime.chevallier@bootlin.com>
References:
 <20260127134202.8208-1-maxime.chevallier@bootlin.com>
 <20260127134202.8208-10-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2028866.PYKUYFuaPT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254666-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.gantois@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75892ADE51
X-Rspamd-Action: no action

--nextPart2028866.PYKUYFuaPT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Wed, 28 Jan 2026 17:08:40 +0100
Message-ID: <2338720.iZASKD2KPV@fw-rgant>
In-Reply-To: <20260127134202.8208-10-maxime.chevallier@bootlin.com>
MIME-Version: 1.0

On Tuesday, 27 January 2026 14:41:57 CET Maxime Chevallier wrote:
> MII phy_ports are not meant to be connected directly to a link partner.
> They are meant to feed into some media converter devices, so far we only
> support SFP modules for that.
> 
> We have information about what MII they can handle, however we don't
> store anything about whether they are currently connected to an SFP
> module or not. As phy_port aims at listing the front-facing ports, let's
> store an "occupied" bit to know whether or not a MII port is currently
> front-facing (i.e. there's no module in the SFP cage), or occupied (i.e.
> there's an SFP module).

To me, "front-facing" refers to things like user ports on a switch versus CPU-
facing ports, I don't find it intuitive to use it to qualify a port's state of 
being connected to an empty SFP cage.

Why not use something like "vacant" or "empty" instead?

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart2028866.PYKUYFuaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAml6NIgACgkQKCYAIARz
eA6Arw//Yp1G4Zn+BAmiRsh/biEO7ZoLQM7RWf1XXDAq6ifO0U+VDfPKaG486NWY
wxLG5XdgOFpdMYYmGUNVwQrekh+tweqj9koWk0GTv3DLCPEcjHYytyD5Zr34AxVv
Kf0/fHASfl++5X61zZCZkeY6L4M4uJPbn4WjhkkrYuST0E5KOXbrd4jJt+6Ifiyk
Sm8CNy8GJCINyF0wL3n/GBFJ+S2arE/tXcM36YrU8FcG425M6Sj7/DudozKH2zrS
F2on+PCydaOm2kHjqmhbIbf96xXMnK0i7OQ1fGsmy3U9mQXW8jXl/NDoruF/oHRv
GMjrCVZ7lNb+P+8Klrdj691y0aVP7Wqj/fPFqMRpwGjX49nB1vsLXe2NaDZMPI9c
L8vM7FOyV73Lcc2u+i8BBa7EiLTG/tcwqVRCLMYvx8Fqv3HxDMpr82CXjQ66rmb6
t1AazMvYw3KWedwu+SEy88UHEoA/gMP06IJBMXI9W405kOqHsL7aTDJW2nyM6712
O2CQOzGB61MpFjg9/ey1ngvHDJfn9p9dv/Ov+ZTQLaCizZ8vfKIs9wsHXc8TD1/y
qQ18TRIQPgjh21knQfzhfAzrT13f79hHDfMwVga/SruMCju6c5I0Z9W9GJQkEbpE
m/nxYL38233YM7/Q1bifqMyDv+/cSvVQi3mRCZJEeJQQYtgcrXU=
=IEDB
-----END PGP SIGNATURE-----

--nextPart2028866.PYKUYFuaPT--




