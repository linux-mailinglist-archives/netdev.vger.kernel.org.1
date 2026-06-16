Return-Path: <netdev+bounces-299754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z5mbL8vvMGr/YwUAu9opvQ
	(envelope-from <netdev+bounces-299754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:40:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B1868C963
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:40:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=EQGH2R27;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=QCxOESqc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299754-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299754-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44D0031541FD
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CF33EF643;
	Tue, 16 Jun 2026 06:38:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFCF3EF67D
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:38:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591909; cv=none; b=EddH53EQaRxsek0l/6wWQvYdriVRFRsd16SpwY/Hp3EcmaOUwADouN+2XiAvsKUPw8m+zrq4zHekGHAkpzjLiJbUDA4w6Zz2/SkQ/Bh6wLLeo9bfCI8xHZgB2Ei1Oeq66Pko5H6FXyMFN7GGxCNYSVyjEjCeSKRe76OwHzt53K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591909; c=relaxed/simple;
	bh=mdON1xmhFFaTV1B09/CLgTwEoZe86Ied7BCrgNBTxIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TnOkylIq3/2OzM8MseGmFspu32nlgMyUBLWiRId90qB93nwTQEieERxV/wB8TfKg+PjKuUf8WIw/YUVzWWDxcIWoISo0lks1qcinE9eS61x4rgVhqoUeMIJ2O3DtLH8c2OoeV7jyAfZDUpJHza+WxZc/rJatAwUS2srgF9vFkYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EQGH2R27; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QCxOESqc; arc=none smtp.client-ip=193.142.43.55
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781591905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XNmDdkIyp0gupmFYEnFdpWGoUP94/Kd3ySqPZW4dQxY=;
	b=EQGH2R27FmQW9yTSZZLllyndUQQHxgMrbgZ3KHh1VWsRFflWHdxxTCJfSwyQYVoO62Wxp9
	GzFuACbX992iQLooo8wAElCxQMSpwOtmnSw55vboG+p76+9dj+96qxdQudkF2+aZ8T/QAe
	dMRP7D38dXey+vVpBnYezpiR3ycwLuMp2sugPKyEF4ZbQRTiX8U9Lg0gDyk7FTD6W2aOmZ
	dYhLBsYNpK9qXtJdtFFopwd2xxplvvjQt2bDwaJS851U47qacLsL6W+3gN+8pyz7uLHDt5
	Z76fnbpQJVAGR/SaPvoW8ro6gwiRjihZjDzLWAfR2nqKEjSCmMPnUwGK7NbotA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781591905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XNmDdkIyp0gupmFYEnFdpWGoUP94/Kd3ySqPZW4dQxY=;
	b=QCxOESqcWkY2hA43/WoHO9GRsfTVXzBhSjJBUxHEsi1oANxSOPZZGpTITScPeRjM8MV5a1
	syWRXQeodZJB7UAA==
To: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 "Chester A. Unal" <chester.a.unal@arinc9.com>, Daniel Golle
 <daniel@makrotopia.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wei
 Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, =?utf-8?Q?Cl?=
 =?utf-8?Q?=C3=A9ment_L=C3=A9ger?=
 <clement.leger@bootlin.com>, George McCollister
 <george.mccollister@gmail.com>, David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Sashiko AI Review <sashiko-bot@kernel.org>,
 Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH net] net: dsa: Fix skb ownership in taggers
In-Reply-To: <20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org>
References: <20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org>
Date: Tue, 16 Jun 2026 08:38:23 +0200
Message-ID: <87y0gfdm74.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299754-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,broadcom.com,hauke-m.de,microchip.com,arinc9.com,makrotopia.org,collabora.com,nxp.com,bootlin.com];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:hauke@hauke-m.de,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:wei.fang@nxp.com,m:xiaoning.wang@nxp.com,m:clement.leger@bootlin.com,m:george.mccollister@gmail.com,m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:jonasgorski@gmail.com,m:matthiasbgg@gmail.com,m:georgemccollister@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:email,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18B1868C963

--=-=-=
Content-Type: text/plain

On Tue Jun 16 2026, Linus Walleij wrote:
> The tag_8021q.c tagger calls vlan_insert_tag() in dsa_8021q_xmit().
> vlan_insert_tag() will consume the skb with kfree_skb() on failure
> and return NULL.
>
> When NULL is returned as error code to ->xmit() in dsa_user_xmit()
> it will free the same skb again leading to a double-free.
>
> The idea of dsa_user_xmit() and dsa_switch_rcv() dropping the skb
> they held before the call to ->xmit() and ->rcv() is conceptually
> wrong: the pattern elsewhere in the networking code is that consumers
> drop their skb:s on failure.
>
> Modify the ->xmit() and ->rcv() call sites to not drop the SKB if
> the taggers return NULL from any of these calls. Move those drops into
> the taggers so every callback error path that retains ownership consumes
> the skb before returning NULL.
>
> Keep the existing helper ownership rules: VLAN insertion helpers already
> free on failure (this is the case in tag_8021q.c), while deferred
> transmit paths either transfer the skb reference to worker context or
> hold a worker reference with skb_get() and drop the caller's reference.
>
> For SJA1105 meta RX, transfer the buffered stampable skb under the meta
> lock and return NULL while the skb is waiting for its meta frame: the
> skb is not dropped in this case.
>
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260610153952.1685895-1-kuba@kernel.org/
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Acked-by: Kurt Kanzenbach <kurt@linutronix.de> # hellcreek

> ---
>  net/dsa/tag_hellcreek.c     |  9 +++++++--

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmow718THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgtO1EACp9iMCan2WpWFd1sGdsl/9HVRJZXBo
WpCwEiMcI2zCu37/adEgdBsQKEkfJtkEwCZX4MEtieWcot/hvUkoT1h9JKHRn/j8
cKbIc99RCs+zoHYpsslrMtNIwgcJ/DUaxroMBoiRZckjjri4ZEthrG9DDXAVNErJ
UWWZywGxGNFlIw2J2pXFcXiYuc/OWdsF0QP+Hp5nlCR/+ELbMbz9lzaFpEbqb073
DMaXjcuwkZqovnCcRNP4d5xWiRd4FqiRnkh8SsSbPgnDz9/WYZGxtDZxXhZ/HRsr
4ULxEh2sUuSsqN6Laoe1iEkPhSAmrz0WYZvLKkC6SmiWajIE/Xx9PlolBVtOfJ5i
nNlVsuytHWKrVnlaQPBg90xFEwtNCmnYTnqLvevQWrHHKwql7C4gHX3xMbVf62Ma
HzkyXU3nUF11SU8AWSvQaoLVYZopzwwf3gsgDsUbQDZexwmvvEB6Frg5b/DOKMoI
BJRMfU0x4sL0h6jdOX4/NxjA6TANECsbTIJQGjoNdc7V/+3b3fg/qjGN3s919enJ
gkHVUPeqsuXKk4XaqPhKPzhYUl8NyOD69QC7uEkXdSY0Hs+hdDt5C3adFkZhh1nO
cAJbiky+DpGH+yMGz+YilQDFN//L74u5mV5pHdo32WSc7rOEz0RO9hV0SubmeYdI
f9Ta8alGupj7MA==
=qjN7
-----END PGP SIGNATURE-----
--=-=-=--

