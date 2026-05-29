Return-Path: <netdev+bounces-293216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JCvIcztGWrlzwgAu9opvQ
	(envelope-from <netdev+bounces-293216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:49:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF321607FA9
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14EFF303E499
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35A11C5F11;
	Fri, 29 May 2026 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivAS6l8F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD44AEEF
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084041; cv=none; b=c7P7ba+N82r5t8o5J+nFN7pW4bzjaHJHtaRjbsRnqT24oQVV/4VsCEv0sIOVu1Sf1SfJDlPlOHml5De9E773Dy6Kr0JQ9Rqc5yiQUysXQG3UetEz/WgjLanVHEbcM65c3VsaVyJPcDTvb7ZwYsbVGOZkzjqQRb1doSsHgCEHEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084041; c=relaxed/simple;
	bh=7hGek/4KlC7vuo0O+KAuOxkTIKgA8qmI14VnHkg6dCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJeadga//Tnx9gTwNKu1gLigIOp8PmuHbi8QoyO8q4iEdKc63/FcCkPDWhp8lpr+3Um0jDCWmK+B22OrhB83AsW1XNxqVJJaLI2pw/Z1jMt3L7PisYgayaKBJv+8OrkLEsG4H8/cQRorKh4OyRa0OF5npmyZN/aA8aLF/iUomhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivAS6l8F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99081F00893;
	Fri, 29 May 2026 19:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084040;
	bh=179JUm3VpbXnuI7eHWbCZCmEHffJgACXTUZAPW838js=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ivAS6l8F9JZ3mbPqI5jVtLWq+a/QQCF1O+pDdRbCjggyPoWBAy3Rt1zJ223/UbDOJ
	 tdfJmq8m8GhlvrIzLDj7q+sNXwTBg3MzMjrGzkveSLKcaHChpRzCOkFt8Ak6hFzUaO
	 JoVqoWOy5PY3FZ0NqSXN5jWQFaqIMgV5j26VlQBYJbjM6vdzeRtvhsW8tQbKGowVqp
	 7/Bezd2wFqdy4nE/tjMyzyn5ZsuHN7971n2Qjc6PEK9dHTxYv1Ntoy2k464MHaFy+t
	 MfoP/5EvdSlziRi5aX3gDUhGQ9/aWn0Wngz94gciGrHaVcm54329x/J8zbg03W8X0x
	 cLep7+dxSVe2Q==
Date: Fri, 29 May 2026 12:47:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, netdev@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 01/15] batman-adv: drop batman-adv specific
 version
Message-ID: <20260529124718.30eab6ba@kernel.org>
In-Reply-To: <3637868.44csPzL39Z@sven-desktop>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
	<5075322.GXAFRqVoOG@ripper>
	<20260529112430.09c1a08e@kernel.org>
	<3637868.44csPzL39Z@sven-desktop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-293216-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,open-mesh.org:url]
X-Rspamd-Queue-Id: DF321607FA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 21:23:21 +0200 Sven Eckelmann wrote:
> On Friday, 29 May 2026 20:24:30 CEST Jakub Kicinski wrote:
>  [...] =20
> > >=20
> > > version.c and version.h are there to not recompile more parts of batm=
an-adv=20
> > > than necessary when the linux kernel version changes. Has nothing to =
do
> > > with OOT. If you consider this a no-go, I can also just place=20
> > > generated/utsrelease.h + UTS_RELEASE in the three different files. =20
> >=20
> > Ah! My bad, sorry for the accusation! =F0=9F=99=82
> >=20
> > The re-compilation thing is annoying but it's solvable.
> > Please TAL at commit 3f9ed5f5aa9ecffd2 for inspiration. =20
>=20
> Interesting, didn't knew about it. This should work for the in-function o=
nes=20
> and avoids the const batadv_version string + version.h.
>=20
> https://git.open-mesh.org/batadv.git/commit/?id=3D6f864eb5cfd8315b8f9a291=
67263282fe4593f3a
>=20
>=20
> Now we are left with version.c. MODULE_VERSION doesn't accept "dynamicall=
y=20
> generated" strings for obvious reasons. Which could be handled via:
>=20
> * MODULE_VERSION(UTS_RELEASE) in version.c (keeping it in a separate file)
> * MODULE_VERSION(UTS_RELEASE) in main.c (requires recompilation of main.c)
> * MODULE_VERSION($STATIC_STRING) in main.c (then somebody needs to come u=
p=20
>   with one)
> * something else
>=20
> What would you prefer?

No strong preference, I'd probably go with option 2 since it seems=20
the simplest. But option 1 seems okay, too, if you prefer that.

