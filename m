Return-Path: <netdev+bounces-293213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WONrNSfpGWpazwgAu9opvQ
	(envelope-from <netdev+bounces-293213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:29:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C1F607DF5
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2DB230DFB88
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30103ECBE5;
	Fri, 29 May 2026 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="NuNKoHdV"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A113E5ECB
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082612; cv=none; b=aqVpHLzQkyJ8pHNFZ3CyMrQlVfyVkIM4RmNbUkuYRvx2Q61Ep2aGLip2xA37TEj4OIPYLvDWl94EAsgHchM81mhJ3Pbo7UtN+bdeysvyr4ypj4+4w9ypTwlFv/3Xg0s/1oh8Jzd8WUkCIwm6ZyAY3gKpbL/+Il5b4K2HRoIEt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082612; c=relaxed/simple;
	bh=dmxii1tseHteJk2hETRDOMAzdBRTMhokl7S8N6F8eco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGgRmBJS6NvefkTneCq4YuYtOhjb35X/IvVB82b7D+jH6MYx90qNqZDoEkp8jtt5cEEAipktZxIUvHFfbntAiw8gR+Vg+daaWU0wlbrRN4NHp/DQZ/mjDXfR5/772TorV7pUM+NGpJ1y1biZWqlqZdQLW0v5lQsFV3KHrN/oWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=NuNKoHdV; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8287320059;
	Fri, 29 May 2026 19:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780082608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ifMQbo73xD+U9Kp8zhdBidzj4xF3PjSxIjqhbVROWok=;
	b=NuNKoHdVLKpgeyMG19mM29oJ0AtSBjRyp/lBvmUYPVEZ1GYmtHe+PG7jzj25QM5hG3gS31
	jIES4al59uAdOnOFxYTB2LICqlS1o/TFQbPls8JQ7dHqw7dsfjQFRZ68giNXL1EM4m3t9c
	tLCoNVU+/fwq0vv7Em/xxqdVPK7ShTM=
From: Sven Eckelmann <sven@narfation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org
Subject:
 Re: [PATCH net-next 01/15] batman-adv: drop batman-adv specific version
Date: Fri, 29 May 2026 21:23:21 +0200
Message-ID: <3637868.44csPzL39Z@sven-desktop>
In-Reply-To: <20260529112430.09c1a08e@kernel.org>
References:
 <20260528142924.329658-1-sw@simonwunderlich.de> <5075322.GXAFRqVoOG@ripper>
 <20260529112430.09c1a08e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8904532.T7Z3S40VBb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293213-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,open-mesh.org:url,narfation.org:dkim]
X-Rspamd-Queue-Id: 58C1F607DF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--nextPart8904532.T7Z3S40VBb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 29 May 2026 21:23:21 +0200
Message-ID: <3637868.44csPzL39Z@sven-desktop>
In-Reply-To: <20260529112430.09c1a08e@kernel.org>
MIME-Version: 1.0

On Friday, 29 May 2026 20:24:30 CEST Jakub Kicinski wrote:
> > > To be clear, definitely a move in the right direction. I hope we can
> > > move _all the way_ in the right direction, tho, without still defining
> > > OOT-feeling version.h file with a dedicated BATADV_SOURCE_VERSION =20
> >=20
> > version.c and version.h are there to not recompile more parts of batman=
=2Dadv=20
> > than necessary when the linux kernel version changes. Has nothing to do
> > with OOT. If you consider this a no-go, I can also just place=20
> > generated/utsrelease.h + UTS_RELEASE in the three different files.
>=20
> Ah! My bad, sorry for the accusation! =F0=9F=99=82
>=20
> The re-compilation thing is annoying but it's solvable.
> Please TAL at commit 3f9ed5f5aa9ecffd2 for inspiration.

Interesting, didn't knew about it. This should work for the in-function one=
s=20
and avoids the const batadv_version string + version.h.

https://git.open-mesh.org/batadv.git/commit/?id=3D6f864eb5cfd8315b8f9a29167=
263282fe4593f3a


Now we are left with version.c. MODULE_VERSION doesn't accept "dynamically=
=20
generated" strings for obvious reasons. Which could be handled via:

* MODULE_VERSION(UTS_RELEASE) in version.c (keeping it in a separate file)
* MODULE_VERSION(UTS_RELEASE) in main.c (requires recompilation of main.c)
* MODULE_VERSION($STATIC_STRING) in main.c (then somebody needs to come up=
=20
  with one)
* something else

What would you prefer?

Regards,
	Sven
--nextPart8904532.T7Z3S40VBb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCahnnqQAKCRBND3cr0xT1
y9ZnAQD24lphhoj0ZUTST9soYaVsHJ0FJgejx6k7ey/9Ps5UuQEA7HgjYVaP8kbT
7C5kaF6r/QybbZuI6TPdYX+n+8+3Zws=
=7rgI
-----END PGP SIGNATURE-----

--nextPart8904532.T7Z3S40VBb--




