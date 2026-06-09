Return-Path: <netdev+bounces-296957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wKF6O3LJJ2rS2AIAu9opvQ
	(envelope-from <netdev+bounces-296957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:06:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA9965D8D9
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:06:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=RXCOQ87z;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=S+mb0wYb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296957-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296957-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43336304EFBE
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AA33EA957;
	Tue,  9 Jun 2026 08:04:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70443E5EE1;
	Tue,  9 Jun 2026 08:04:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992272; cv=none; b=BHI+fbMuZlRMYIcoZ0C8cFLdWZMT96kRGtFqZ00GotSL65Das0h1NvBwzAeGJCBMT/M/rgfGfQQI7/5+Leaguu+oAxV0HfBJoF9J+eS/tFtpBOSvyBxecR5R3ycs3WJxdnBh4yPtJXFjSplZ7v6Msy74PcgNFPraLV0qeuZ2eLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992272; c=relaxed/simple;
	bh=VvMr4YoN9WSk3r+LXJC/KpAC8C8gcu6zJF59cg3PedQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jZ7zc9RlaMXZNQSXkB9HCueYymEbtuxzC5zEUQ3m0gAPt07+ccU8Q1HMU0aG9ah9+BF0T0569k0Q2XIsxaEbFEkMzeWeFZdecVD3/bTZI+rlIloBcZ5fPcsmM0+2rJ0Cs0LkW9ezL8fXnrGMUfVKDcPgkwM/N5JYjyvmn9cOWio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RXCOQ87z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S+mb0wYb; arc=none smtp.client-ip=193.142.43.55
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780992262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VvMr4YoN9WSk3r+LXJC/KpAC8C8gcu6zJF59cg3PedQ=;
	b=RXCOQ87z3kc14Bn22ngjOBOXRIDtZyAau336L+NN1RSEDTsU9q9tuuELu6pEQ7t5FskYHp
	OVjUsb4w6Fr3AulIzjZwe5iFfMj6bGxeSQfUbfK4ParF9bBp11KCraM/W40gSl1RrV/QGz
	PrNrKy/4sjZ1JGqFQwVcM7PKm+lefMh4/db2W5/rLbSlRoVv0ejpF51GjOfhjJ505b8dTG
	JrO9g7WFR0p+aX4UdIGkOjgsfUuwn1HKpoGXwb03MG7U9VT2vyB6HxjMbKtfGUvY2WRbis
	JiRFstIL52wbRU0t+epwY+KBHXa+G6JGT5LrlW6t0RVRb365ITMa/FE3HRQfTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780992262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VvMr4YoN9WSk3r+LXJC/KpAC8C8gcu6zJF59cg3PedQ=;
	b=S+mb0wYblyXotB5WCLqaA5JeE1Jxp5t6R0+ysG5NSrd9/JxrftKBsWDItnhc38nA9js2bf
	WAxU84FLztPj/pDg==
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: hellcreek: replace kcalloc with struct_size
In-Reply-To: <20260608045640.5172-1-rosenp@gmail.com>
References: <20260608045640.5172-1-rosenp@gmail.com>
Date: Tue, 09 Jun 2026 10:04:21 +0200
Message-ID: <87v7bsnnqy.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296957-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EA9965D8D9

--=-=-=
Content-Type: text/plain

On Sun Jun 07 2026, Rosen Penev wrote:
> One fewer allocation for the priv struct.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Kurt Kanzenbach <kurt@linutronix.de>

It looks correct, but i'm currently out of office. I'll test it next
week on hardware.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmonyQUTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzggnXD/oCZui4Xz4iXkF8tS8rmAi1NCjQJeBp
NO1t8uZg91kZYFF4AQXdgnu6w7X/7IsCL+fTfr/AAq9HWgN+IEERoc0UMncdXNaF
Xq9ouuwNuvLAkGtfy02IiVNWP4PEz73D5StpyT5QkOTnxOGcN2M4kMCzsrac5xJI
xLw8/IqPpnOCEHeIH1zjQl4vFXyRzkAVq/F805PlKxhWsCxsPJx20Q+AomDYb+7R
o0kRWTkEkDVV1vcLiM2CqbdPHEr5COlNOnDfRKSaxVIy/bhAzpl/0ztKOqc0c0pO
N27uzBt22kdSuDBMsbJbTVp3+dbJD5mgply0OhxGUTLLYoOceNHZBx0CvJxDVVTJ
WexAT+EHRfUOmJU9pITvjCtYFUIO2SF8dAI077bbKO1lSCM7xCt8J2OpfxRJTO2/
gT/mo81Ib9B6Tb4YtZU9ZqAhcX/bADtx0w6KppiSuS30QIt5n2ipI3bN99C+Z3dI
u8hC/IMvSaEmKSuU1lb6jFIlae5sI/taUUUQRCk+SC1BDLXy/yKAtbeu6OpWTrej
TNvnkelAheoUmRvld0fSIPVN81n10moYejrp1a5ySETveTY64+SqlrX3nJJJL+67
7SRjidRpGx2gNIwQJFrHIr6OcFwj1+bXZ69IminCXBqfbB/gEyVEHqW9Gxyo2MSN
6mFVOS59NFJS+w==
=dPQg
-----END PGP SIGNATURE-----
--=-=-=--

