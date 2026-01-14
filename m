Return-Path: <netdev+bounces-249952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D12AD219BD
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD8D5301CB78
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250063AEF2A;
	Wed, 14 Jan 2026 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXg12Ors"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED43B5310;
	Wed, 14 Jan 2026 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430114; cv=none; b=Y6IG6EDwNvNHVXT9tQSX2MJBSN1nk3R32ZpZ6RY5vUcyZaPfrjgsSxFSP2OeQV1nu+dFSdK44WMhHXmKm3+H51OwD3+EImk6SsjUHBef5o4E/n2hHy4PjMxQCydgUg4Z6TN8CUMCzRrYzFjcJEc68RWexHh2c+3pTNGpvmORlak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430114; c=relaxed/simple;
	bh=bGPeZJuOX9kFSWCNT1OsWd84cPtXULGfVrA4w55KR8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK4NxQ4cBIZVWDELYWd/TE5jQUGil4eQFxb4P331xbn8jN059NJGf3sMvfYPgCz1tQVChQQxq7SDeHaUn1ge3NrNS7py+xmHulcIh60s4DyD66r5/X4+OpdjewpgDaYWKF/DHY503B4ToVpZk0RBKsM5CxG42D3o8y2VVLaWR4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXg12Ors; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5199FC4CEF7;
	Wed, 14 Jan 2026 22:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768430112;
	bh=bGPeZJuOX9kFSWCNT1OsWd84cPtXULGfVrA4w55KR8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXg12OrsRxSkC6k3bL4TBr3lPksxPQ4tRk1ebifPMy7VqNRMKLB7GQ5zbQMTsTD1w
	 sb0gHNEEfR6Jlf+Hr1vcontVtcbWLU/byX/TdsQAqR1KRnN7zZnZz0pZ8vhLRv0TNV
	 qD0M2ep09UXDHkOB0mR2btEZB6At0jLE/XZ3o3jR+UYSXj1lsqkXotacyDOLreJJli
	 v4UkL0xjW6RUnTZQtOWuyh+6J4f5HACfRePfHihlV29q5qgJVNptIkf92INwJcuXgK
	 Zuxr+rRaPmrbkHwYMqQuSdeUzNTD7bnTHM029jGuToB03xJpsPK/1ZyPQqxtH2e2Gh
	 r5TSAfIk309mA==
Date: Wed, 14 Jan 2026 23:35:10 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add
 EN7581-7996 support
Message-ID: <aWgaHqXylN2eyS5R@lore-desk>
References: <aWdbWN6HS0fRqeDk@lore-desk>
 <75f9d8c9-20a9-4b7e-a41c-8a17c8288550@kernel.org>
 <69676b6c.050a0220.5afb9.88e4@mx.google.com>
 <e2d2c011-e041-4cf7-9ff5-7d042cd9005f@kernel.org>
 <69677256.5d0a0220.2dc5a5.fad0@mx.google.com>
 <76bbffa8-e830-4d02-a676-b494616568a2@lunn.ch>
 <6967c46a.5d0a0220.1ba90b.393c@mx.google.com>
 <9340a82a-bae8-4ef6-9484-3d2842cf34aa@lunn.ch>
 <aWfdY53PQPcqTpYv@lore-desk>
 <e8b48d9e-f5ba-400b-8e4a-66ea7608c9ae@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hY6eQNj4UDrrBkRP"
Content-Disposition: inline
In-Reply-To: <e8b48d9e-f5ba-400b-8e4a-66ea7608c9ae@lunn.ch>


--hY6eQNj4UDrrBkRP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > In the current codebase the NPU driver does not need to access the WiFi=
 PCIe
> > slot (or any other external device) since the offloading (wired and wir=
eless)
> > is fully managed by the NPU chip (hw + firmware binaries).
>=20
> Are you saying the NPU itself enumerates the PCI busses and finds the
> WiFi device?  If it can do that, why not ask it which PCI device it is
> using?

nope, we do not need any PCI enumeration in the NPU driver at the moment
(please see below).

>=20
> Or this the PCI slot to use somehow embedded within the firmware?

in the current implementation the NPU driver does not need any reference to
WiFi or Ethernet devices. The NPU exports offloading APIs to consumer devic=
es
(e.g. WiFi or Ethernet devices). In particular,
1- during NPU module probe, the NPU driver configures NPU hw registers and
   loads the NPU firmware binaries.
2- NPU consumers (ethernet and/or wifi devices) get a reference to the NPU
   device via device-tree in order to consume NPU APIs for offloading.
3- netfilter flowtable offloads traffic to the selected ethernet and/or WiFi
   device that runs the NPU APIs accessible via the NPU reference obtained =
via
   dts.

The issue here is the NPU firmware binaries for EN7581, loaded by the NPU
driver during NPU probe and used for offloading, depend on the WiFi chipset
(e.g. MT7996 or MT7992) available on the EN7581 board (we have two different
NPU binaries for MT7996 offloading and for MT7992 offloading).

Regards,
Lorenzo

>=20
> Or is it simply hard coded in the NPU silicon which slot to use?
>=20
>    Andrew

--hY6eQNj4UDrrBkRP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWgaHgAKCRA6cBh0uS2t
rJN6AQDkgeHf1sv0dehgGn3QZ1vcixxjd3NNGP9dNVCMq+9ssQEAys3dZo7kFmYB
mF4zbcTbKw/Osa6twW99r8dYvPutLwE=
=k96L
-----END PGP SIGNATURE-----

--hY6eQNj4UDrrBkRP--

