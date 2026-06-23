Return-Path: <netdev+bounces-301391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 79NSHhSaOmpkBQgAu9opvQ
	(envelope-from <netdev+bounces-301391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:37:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5AE6B7F5C
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:37:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=bqqY4zxE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301391-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301391-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1398D3020AA0
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855763A6F1B;
	Tue, 23 Jun 2026 14:35:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4C3C10A0
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 14:35:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225353; cv=none; b=u/5xwdi1ySsRnftziJ03Vm94U3xEEvLXZUg66zjNtJ1D7qW328Muwlc99gGieSb/9+g+2V97IVguVdwCyOfzyaK3qoj+XE3gFjM4oFtmxZwWN+eeYLhYVTHt/1bldbNUQRMldoQTAxokFWS+/bZ2itmAltaUlbWi9FoNElsefQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225353; c=relaxed/simple;
	bh=fKy5YnCZhDxCWkfmcmX8SEvo4bn+lLypjOoYVvYBSDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrgnCOGFKMtQmECysqRp/6hvLNYR76yI8AhFe7jFd4IhT3rsVcGa5xm4xuJe+KEiR3tuyzGHB8gQ5MOKd/XTOeJSK1b9qjNkqtJQ67MxcKvH7gQsL5oDflU5FIKXVzCUmIovNqjK7A0xmd53gJhVOJup1IEyKIqNHIRv20ynzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=bqqY4zxE; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b7866869so56417105e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782225348; x=1782830148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p03/V4N3PaxsAZCpDTVaKukRbxS3xX9UfTKCkcMJvwQ=;
        b=bqqY4zxEpvYf4mVxdM+NTFNqIvNTRJSfwck96w9NaLf5gqIW06u0cFTvDYZBDuqPQk
         yx5tOrcq/qnNt7ZywetVAq6zw//ZPYuLe3hBad74aEUy+6Sjgr4z2Q+p1R9MelC77cSB
         khEnTqMQ84BQKU7oRlkBOiIre0lmt8fR2XLnRPqW4xBRzUUy5fq2WHdQAIUKeG170Z8c
         p1dXhbWyKh3aJuHoVMaPUFKxxLhlXKr6/4Dhf3okaQe9wfkjXAkeEo3KHFeo2Rvqf8sT
         AkuVXOwejHxIXELWcoJNpizf88JN+E9raHobh0YXs17/kXsp858NdfZCeea2X9R8TjCR
         c0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225348; x=1782830148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p03/V4N3PaxsAZCpDTVaKukRbxS3xX9UfTKCkcMJvwQ=;
        b=LCiTR14j1Uj4yFb3lPKJrKcbpR5HK6Jf5n3cXNVHvif3b1TfPNOMaqx7N8DQ5kVwVb
         i9wJfdmX69mBQMv473KFQwPFzm/uEsibQwKWc1GShFwB0tt2OnNCGVoMoqhBI8OmwxI4
         P4/3gGgGAZLYKd1IOxJCa9o39bBAa4vrdYAV9NadiijLvEoxK1PkkxPnfcU00i23/sug
         Z/uylD4+cr15jPoV854FhXeWlebnjOpqAGyXcXK3RycOMM2qxci0OzDfcSLRDGPoodqG
         3Z4LT/xaDcugwrf3Hb5kwh7cz6l3n6zmO0AknPyVW068cgY+xBJgwJ8dIL/d3lIFMUk8
         hWWA==
X-Forwarded-Encrypted: i=1; AFNElJ/LhGzJO2wZoOCoLLUdgSbeDwddI1lSx7jjfe8GmjxMbM5c0wJCnRMiCp/SENxlHbMgMmBm6yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlB2DaLuPRbuyMkXlqt2lENqofV3PH2BYXcv/cJGtNMQEKdH3s
	eO/DovYNK44++9CeU9oBPSKpYOrGHPyCSBr+qcDnz8R/67EeErTZCL4j0vnNUmQHBMo=
X-Gm-Gg: AfdE7cmrs/ipKgLllraU91NCP8tv+XzyuJKtYLMTejuXyaRQkPMBvi3FUCIMFaU1E9S
	FeUcyCx7wB1bYsgqIW+onnKuGnM58G7hqhrAj9iz/R4Wp3kjGX0HVVlT/H05cVi5KKp2mL1y5lw
	HXQ8MNyZlIqnjP04tLwo8i3MFTVc1BgemYzC2IKGhCaHyO3xmyi6zBwu3KsvQjEssBR8fYJzHhx
	amhXfUmp/0y0DsO/cQXz8Mb5SEgphgVYpjT0qewhSdAe9uzhqXENX3fcSeSaxDMQY07KqgHUN21
	tmKBSmklP0ktfffbfZCpfdZyQSejNydpoq36PCYDD4d4Dt/rMMkqXa+DUIetnAoptDG825Nkp9R
	RP4bv1M34yYA7GG4RrDVTrvCAyXXeobt2JSKR7gzijfyJzYtw227+uSRCfZZY9cGHCxbh1kdK8j
	u7KVUCE9dSumG7C/1qrgbdLnLOHUtfH3O4ioV28xsD70CpyNrYdr3l3QEU2T00yp/AtIdvZBrQj
	xcQXYvfVaEqZQ==
X-Received: by 2002:a05:600c:81c5:b0:492:4ed1:77cf with SMTP id 5b1f17b1804b1-4925b35338bmr40281835e9.11.1782225348031;
        Tue, 23 Jun 2026 07:35:48 -0700 (PDT)
Received: from localhost (p200300f65f47db0493d7da2f3a2c0dc4.dip0.t-ipconnect.de. [2003:f6:5f47:db04:93d7:da2f:3a2c:dc4])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46666788226sm35782076f8f.23.2026.06.23.07.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:35:47 -0700 (PDT)
Date: Tue, 23 Jun 2026 16:35:46 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mika Westerberg <westeri@kernel.org>, 
	Yehezkel Bernat <YehezkelShB@gmail.com>, Andreas Noever <andreas.noever@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 0/3] thunderbold: A few cleanups
Message-ID: <ajqZcKCYphDMIqRn@monoceros>
References: <cover.1781776904.git.u.kleine-koenig@baylibre.com>
 <20260623121746.GD3066@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l34oe6w67l43o6ih"
Content-Disposition: inline
In-Reply-To: <20260623121746.GD3066@black.igk.intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mika.westerberg@linux.intel.com,m:westeri@kernel.org,m:YehezkelShB@gmail.com,m:andreas.noever@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andreasnoever@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301391-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,monoceros:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB5AE6B7F5C


--l34oe6w67l43o6ih
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/3] thunderbold: A few cleanups
MIME-Version: 1.0

Hello Mika,

On Tue, Jun 23, 2026 at 02:17:46PM +0200, Mika Westerberg wrote:
> On Thu, Jun 18, 2026 at 12:14:49PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > Uwe Kleine-K=F6nig (The Capable Hub) (3):
> >   thunderbold: Stop passing matched device ID to .probe()
> >   thunderbold: Assert that a service driver has a probe callback
> >   thunderbold: Drop comma after device id array terminator
>=20
> Fixed the typo "thunderbold" -> "thunderbolt" and applied all to

Oh.

> thunderbolt.git/next. I also took the networking patch, let me know if
> that's not okay (I'm the maintainer of that driver too and it looked fine=
).

Sounds fine to me. So assuming you're not offending the network guys,
that should be ok.

Thanks!
Uwe

--l34oe6w67l43o6ih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmo6mcAACgkQj4D7WH0S
/k7T+gf/Xgon2MgxvTPWE6llhCIH/yeCNiL+YW+XDYeJThkZMnsedTRVqwEaSK46
AJk1q5IsrPrZvHr4/S+8hknSgwKwiS8Jwecmn4NjFk/LvU/gKuYqx2eV8q08dJNl
xVkiQWfIiDAExtK4cmixSKiIJIEDK6bj/k3XV1Z+rk8inM7H2eSWLs+6ntqhj+1T
TVPhuVw4RYo0nOyAjsYjj9rPIGk//jdEjoNuyaVwaROm7KcknCu9YKIiBbtimJ7p
3X4y5sHIUOmSG24xqqMxt+xMVyyTNhb+2yLlaFpk45eLm1x4fJoKxxGnwzvWw4mL
sVfl6UCiHFCwX21uyZ24tpQ3NnByOg==
=+gL3
-----END PGP SIGNATURE-----

--l34oe6w67l43o6ih--

