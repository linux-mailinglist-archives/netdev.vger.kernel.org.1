Return-Path: <netdev+bounces-285870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MQcCMVX5/WnYlQAAu9opvQ
	(envelope-from <netdev+bounces-285870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:55:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3017A4F82AE
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB10A3069D1D
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C9F3ED11F;
	Fri,  8 May 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msPO46FU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D003EAC87;
	Fri,  8 May 2026 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251855; cv=none; b=Uh9sWDs8FG4TRcw7gyaAcYTNr1veiwOyc71ANI5t8UG9nhHdHcflqRJp92vUrQL9WAa+vyDd87nhxkmqWtpvG5dBHiGyKRLs+vr9f3I6ahI6347Aw0USGBSjEdZgf0ePG4RAgFHCMsIdl6zKd/NluB53WDKdp3PqhOC4xwS1dh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251855; c=relaxed/simple;
	bh=V/MorCIJowgGq0kdfl5dKhCBp2QF4Bdp3UjUYaZe3uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiI9wCZaqtGU1qqIzohR8ctI1gg+QVkNv34MtOX5+rR5zVpC7h+Li2xrn6cdiqQ7My/PFfgBC/kxraREnKHImwo/V1GvOEw413nwCq8h+27Fngvpj7Ws8xDl1yO7OWw8dVU/fKeVQsIs+MeX/Xuh5jG3m9mdOJ9iQWgg8zoP1gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msPO46FU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AD3C2BCB0;
	Fri,  8 May 2026 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778251854;
	bh=V/MorCIJowgGq0kdfl5dKhCBp2QF4Bdp3UjUYaZe3uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msPO46FUpVbvsrtjvkWka4NOagz5lQTdyqrJ7etMn2isie18YNrfpUJihMmxeAjWt
	 uuw161Sawj0+Sc/t9PduioxD/009T6Z7ot/iRf3rlQ/xK1SUt05Ys+bcydhmoidNs7
	 sOyFN54qJLzxPWx3q9UtFSG752W7NlaRk+4rxVN8Vq147NvedYN3SMECnFQ1WWQYIT
	 mNt1imDlM5d6HEzPeBf2JcXR+Wv0y7rbg02vjR6UpHCYPJEVkt6j5njJ4+DkDcO1LO
	 EHPvlfSlRmgm7R/Z4u0Q6iaHSW1YKsbwZjMjRrIjWHsbpwntmvcd0GfZLvMSG/cJTb
	 3vY7e9c7mNPAA==
Date: Fri, 8 May 2026 15:50:50 +0100
From: Conor Dooley <conor@kernel.org>
To: nicolas.ferre@microchip.com
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: change maintainers for macb Ethernet driver
Message-ID: <20260508-destiny-rebuild-696b3cc5351e@spud>
References: <20260507120444.9733-1-nicolas.ferre@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YuRWKIYUnF3dShEU"
Content-Disposition: inline
In-Reply-To: <20260507120444.9733-1-nicolas.ferre@microchip.com>
X-Rspamd-Queue-Id: 3017A4F82AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285870-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--YuRWKIYUnF3dShEU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 02:04:44PM +0200, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>=20
> I would like to hand over the macb maintenance to Th=E9o, as I'm unable to
> keep up with the recent flow of patches for this driver. After speaking
> with Claudiu, he indicated that he is in the same position as me.
> To help with this work, Conor has agreed to act as a reviewer.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--YuRWKIYUnF3dShEU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaf34OAAKCRB4tDGHoIJi
0t5MAQCuHQM95qauXKbkc5Lh0Wl6BX2vRWdNx4y0VYRFbMYA0AEA11GH9Tu6qf9y
Gx40wZdDmOZCExgih0FSom6VfGxGKAE=
=krFu
-----END PGP SIGNATURE-----

--YuRWKIYUnF3dShEU--

