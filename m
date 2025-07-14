Return-Path: <netdev+bounces-206614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 756F1B03B8F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 12:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09CA189BD42
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8E7239E69;
	Mon, 14 Jul 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPUYUyDO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC156111BF;
	Mon, 14 Jul 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752487286; cv=none; b=JXNImLoYjIR5V5ZRXPJxwJda3p6IxwzwyA4Fjfh7LjOKpRqHL0h5M6gDraH1MzdX7Sdh9SjD+RxV4OXdEj6+qTn6iTjpJO1Eis9ugeS0CaamsBB8AfuWBJpfyDRsOoM0/9XD37DwCNZ4TPhkTHIPtT4HWu2Q8ZXqpMOFalAAhbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752487286; c=relaxed/simple;
	bh=ZKlfhggKlOIGxvSFvIANQzO+iVOz60Z2guplptlzY1Y=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=DZPg3hIE7fV3K4L8gcB2DiHQQNzo+rQ/J201VX0oWmA3ONwOaB1n5vFo9DqUeChXP1aD/eszIQTElnVmwVXUvTH7f1Yjcg7U0LEF/rVf96deRXaYzVKTd7FdHqvkUe1P6rTPgB6HwbYgKGXN3rQLPiR1gYrEKqrWXBerxIDwyUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPUYUyDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6BDC4CEF4;
	Mon, 14 Jul 2025 10:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752487286;
	bh=ZKlfhggKlOIGxvSFvIANQzO+iVOz60Z2guplptlzY1Y=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=XPUYUyDOrK0FSN+4dyPJeGlrPyYOJM7q09+vkQofRG/pj1O/veGZ2pE7Aq/f6GD9K
	 Etix9fjIL6c4HjGLCnxWZb+nIRtWPEkKoxW4PYLiA56idW3NyRaL7XGp/tKApXJnKQ
	 jA8mhnSMgU1HCd8LU5pD0WCKGBWHyNbh3MizHMfo718GIH5xcssUlo05sn7Fk9RVwp
	 OEkjr2KWuVYsyiqp2nG3CwVvaSUaOnm7qQlcBxE9vS8roE4DWWUs3CU+wO29blpmSU
	 lRCSlV52P95O2ztQVwZ316rHSNmQU5v/SEDZ8ofHZ/mMjvY9H75YxIJaawN4dqY3Hg
	 p9sOf52nUeBYw==
Content-Type: multipart/signed;
 boundary=387ade367386a6356486f6ee7b635420fbf56ee5ca28a94e7e0254cdeefb;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 14 Jul 2025 12:01:22 +0200
Message-Id: <DBBOW776RS0Z.1UZDHR9MGX26P@kernel.org>
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: am65-cpsw: fixup PHY
 mode for fixed RGMII TX delay
Cc: "Dwaipayan Ray" <dwaipayanray1@gmail.com>, "Lukas Bulwahn"
 <lukas.bulwahn@gmail.com>, "Joe Perches" <joe@perches.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Nishanth Menon" <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, "Siddharth Vadapalli" <s-vadapalli@ti.com>,
 "Roger Quadros" <rogerq@kernel.org>, "Tero Kristo" <kristo@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux@ew.tq-group.com>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>, "Andrew Lunn" <andrew@lunn.ch>
From: "Michael Walle" <mwalle@kernel.org>
To: "Matthias Schiffer" <matthias.schiffer@ew.tq-group.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Andy Whitcroft" <apw@canonical.com>
X-Mailer: aerc 0.16.0
References: <cover.1750756583.git.matthias.schiffer@ew.tq-group.com>
 <9b3fb1fbf719bef30702192155c6413cd5de5dcf.1750756583.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <9b3fb1fbf719bef30702192155c6413cd5de5dcf.1750756583.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

--387ade367386a6356486f6ee7b635420fbf56ee5ca28a94e7e0254cdeefb
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue Jun 24, 2025 at 12:53 PM CEST, Matthias Schiffer wrote:
> All am65-cpsw controllers have a fixed TX delay, so the PHY interface
> mode must be fixed up to account for this.
>
> Modes that claim to a delay on the PCB can't actually work. Warn people
> to update their Device Trees if one of the unsupported modes is specified=
.
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

For whatever reason, this patch is breaking network on our board
(just transmission). We have rgmii-id in our devicetree which is now
modified to be just rgmii-rxid. The board has a TI AM67A (J722S) with a
Broadcom BCM54210E PHY. I'm not sure, if AM67A MAC doesn't add any
delay or if it's too small. I'll need to ask around if there are any
measurements but my colleague doing the measurements is on holiday
at the moment.

-michael

--387ade367386a6356486f6ee7b635420fbf56ee5ca28a94e7e0254cdeefb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaHTVchIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hHLwF9E9ztKCoOYS0RHC6gA9ZJQpIMkhGKEO9j
1KseN/0Iehs3rgSim31YE3mtYR6pufKrAX9dE6aY41tiyR4+KV9wg5ozGle9rDLz
8veF90sPBa1PQS56tKbBI4rDvyOKhE7FUtM=
=BTle
-----END PGP SIGNATURE-----

--387ade367386a6356486f6ee7b635420fbf56ee5ca28a94e7e0254cdeefb--

