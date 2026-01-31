Return-Path: <netdev+bounces-255447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEMDJtgbfmn5VgIAu9opvQ
	(envelope-from <netdev+bounces-255447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 16:12:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 030E6C2A41
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 16:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAE6A3011111
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A590B352F80;
	Sat, 31 Jan 2026 15:12:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA703587C6
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769872324; cv=none; b=jngbfg23JFaXVsDNv+uifm486zKXsQxrIX6OMQv1mTGXRciWE+idUZFzUT734SzcIfBo8kFXC9ZlC1IOuKoHlel0fsST4cLEkEHxJTrMIvRNesn9+Pk1JYqxJnJe93QWQvAdiGVjq/wRIuQuPEEj2593HRPxzF330X/RtEouqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769872324; c=relaxed/simple;
	bh=Rw88yKb3KZqqYW+ZvJrAaS4iZ9qjJKr36+r+XVg7YKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsGMv1RLBlrG8fvYnn/2I1fKwmgbIDrTo6bjKEuJZxaPxwZ4eBWke729i5X7Q7mFZZmOB+0q5aTXjsktk1MkfKr91f8ze5icP104+Fj21iRsGghYJ19/m+2him5+BB+c9cnrKYNWSPg1x/0oVpXtvGSxZVXTLHCt3aSbtzLGHWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vmCdI-0004OL-MZ; Sat, 31 Jan 2026 16:11:32 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vmCdG-003QgM-0O;
	Sat, 31 Jan 2026 16:11:29 +0100
Received: from pengutronix.de (unknown [IPv6:2001:67c:1810:f051:561c:856e:5964:a6ed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4331E4DC6F6;
	Sat, 31 Jan 2026 15:11:28 +0000 (UTC)
Date: Sat, 31 Jan 2026 16:11:25 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Michael Grzeschik <m.grzeschik@pengutronix.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vincent Mailhol <mailhol@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
	Ping-Ke Shih <pkshih@realtek.com>, Thomas =?utf-8?Q?M=C3=BChlbacher?= <tmuehlbacher@posteo.net>, 
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net-next] net: remove unnecessary module_init/exit
 functions
Message-ID: <20260131-wooden-overjoyed-rook-f04e62-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260131004327.18112-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6yd7qrhj4jkcdcod"
Content-Disposition: inline
In-Reply-To: <20260131004327.18112-1-enelsonmoore@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255447-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email,pengutronix.de:url,pengutronix.de:mid]
X-Rspamd-Queue-Id: 030E6C2A41
X-Rspamd-Action: no action


--6yd7qrhj4jkcdcod
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] net: remove unnecessary module_init/exit
 functions
MIME-Version: 1.0

On 30.01.2026 16:42:56, Ethan Nelson-Moore wrote:
> Many network drivers have unnecessary empty module_init and module_exit
> functions. Remove them (including some that just print a message). Note
> that if a module_init function exists, a module_exit function must also
> exist; otherwise, the module cannot be unloaded.
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/can/sja1000/sja1000.c             | 16 ----------

For drivers/net/can

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6yd7qrhj4jkcdcod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml+G5oACgkQDHRl3/mQ
kZwFxQgAqTWarHnOMLQgAfktq8C6b1xbDfGkeLEVgqQLgeK3hr1CXec3E3TbKYn9
n5CEvjy5bGfh0RJ/tLDbPATx5kzwrGteRHpqmd8mO+Cn063l06OpcLLLJ/HxEU1Y
icgrkF8XRG4pCrzHtFFLtI5lxDIbx1Gb4T3o3IiusfphN5bN0ySKkPQVluOrK0nG
S1lwcjqHjGYr2kXQ0PB5ULHdOiugYBGk1ZgOoOrZyjQSyC0sye50YThQhek3xEDV
cMBf/NMFIfSjXkx/z8B87YOK2hotfB5qHilqje1AClDuK45Bjs6A+xb+EwAPc3Lt
ktHD4Px12IJbaBaJo4hCFxyCM1Xm4g==
=iYrI
-----END PGP SIGNATURE-----

--6yd7qrhj4jkcdcod--

