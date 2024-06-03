Return-Path: <netdev+bounces-100173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7378D806D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 12:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C392A1C211D0
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E089380039;
	Mon,  3 Jun 2024 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="EOi56gk3"
X-Original-To: netdev@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC3D107A8
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412216; cv=none; b=isod1NRMIOz721PkZdzQvvQwBo6zyhy8wBXm/TZs789OXRaSzULZgZlNRsZSkC0CWEMnktmO49tpqsYPs1WNGTl/hjqdj8m80qtRDsJxL2s8rz1WTlFh0jtriNZuwMZ6riFzfk1alVHfjsXawopsLIaQAVq9JYNk/91x5k4gz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412216; c=relaxed/simple;
	bh=LGAeIZbEGlNogy3a7BgFAyoVgu/qQ6sg4lC/Y1Yfbb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0Jamo0pCI+Kge8D6QrKIWqpA9Z+mJXxTOBXsFDeSStm9u+nE/D27Eg/6T0T2TolwubJxxaYsYkjrTMmyEOl+KEssRcGZf/vicdg6xzSqX4Xe4LVWvuPEyhTfeMQGggKwG1lOljKJc4v5f+wdREMCb3omPawVb0VqxfDQpUzdiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=EOi56gk3; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=LGAe
	IZbEGlNogy3a7BgFAyoVgu/qQ6sg4lC/Y1Yfbb8=; b=EOi56gk30X9qm38z64C6
	MlXUudjZYukrpr3i0IjSjrjL6tOY4r56EaHde/4uXHCx+Cx7jNzO6MYlvmHqRsHf
	eUlJM3SVs3OsebxtpPpYzpm8XReHL4UE0N8FE2cC2amtMZThwyD202Q6QFqpzS1l
	fqZ9kZpnz7ubcJyLPXt8bXrILcdLEJjameL+mbt8h9ZCVRPU57y8muj1yW5FFRMY
	mX12/IXJJKsrigoSlkE0UK0cGWp1Cb2O/tgXpihhS72CQM18lryZJCMJ7XApKz+1
	UF6cffn5JQuc8R8NFM8WlkXo3NKOJIskoavi6uhjmKLb7wqJjOK3pzecnXQ+62tL
	Ig==
Received: (qmail 1928111 invoked from network); 3 Jun 2024 12:56:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 12:56:52 +0200
X-UD-Smtp-Session: l3s3148p1@NCHcMPoZUpEgAwDPXzLGAH1eNELjOc3g
Date: Mon, 3 Jun 2024 12:56:52 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux@treblig.org
Cc: mkl@pengutronix.de, mailhol.vincent@wanadoo.fr, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, wsa@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: mscan: remove unused struct 'mscan_state'
Message-ID: <yxgejygwcuk3esvxduqsulyvzqq7qrybapvrtcrv4ms7ui4vau@rmzwgklpwlvw>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux@treblig.org, mkl@pengutronix.de, mailhol.vincent@wanadoo.fr, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, wsa@kernel.org, 
	linux-kernel@vger.kernel.org
References: <20240525232509.191735-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e7sdijexrwy6hipo"
Content-Disposition: inline
In-Reply-To: <20240525232509.191735-1-linux@treblig.org>


--e7sdijexrwy6hipo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> 'mscan_state' is unused since the original
> commit afa17a500a36 ("net/can: add driver for mscan family &
> mpc52xx_mscan").
>=20
> Remove it.
>=20
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Wow, that driver was a long time ago. Thanks for the flashback :)

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--e7sdijexrwy6hipo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZdoXQACgkQFA3kzBSg
KbYajA/+P2GdL3li4kRBt6vrzf3oWd3mI3/SEv+b+2yd75o/or4frVEqUTUIz9n8
cDvvxRu6AtjbSUnF+LG1xNN7rD4eamvYAStihILY6k4sTt1dz2pVRmW5HyXL2qA0
TY0YtfkC/VAB26btZAYkLAEi6sov3boFSUbJ6iTPzDiaA+72mS40iFogTGV9Yp0e
VocP+6ppafQ+i+gU3s7Eq7POt1ZIl6Dck+Slco0IY+esc5zqj7tBizp0ZmcqMGSK
d4AXRoX/5QHdCwnrBLctdsDA0uz6cgpwj2JDWH0CRf75TNIYVDCtQeBxoM+CkQfl
bbsZ5RjEX/VEcCOWsFDSkyndLdMX686amh9ObGaMTjw6gQK8jwFexeGoUktDmACv
Ir3kpH0643Pa+OL10D2POpTjFue+wxwmU9mq1XLbA0AggxZ2RjzlJmKShYTNohRs
iZjNMY43Lmn0bNTpRQB3kEyuXCtHyVf5PKYzxeYa2dZjv/g4R3DLzkny6B1BOu/i
j1uSRUWxVy3aNT1O82QLo6pN/zWjdg9mWlCUUyXNstfUDYCpXh+q9IXifAsG9m6k
IUjOgfAs/fC+B+/ZLgOEMWyk8iV7uhI2QrFz1n70pZzd9xBkWGgYKLnji5c6rV/z
NnBkf4VVg3UOM1uoPQEAvIwg9K+mDLQ4VTNE/jvfKqUfV4dqaRU=
=oY2Y
-----END PGP SIGNATURE-----

--e7sdijexrwy6hipo--

