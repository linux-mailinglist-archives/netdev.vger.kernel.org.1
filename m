Return-Path: <netdev+bounces-228709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AAEBD2D25
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 13:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A291189C371
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4938F25A2C8;
	Mon, 13 Oct 2025 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PUlNb/UM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331AB2566D2
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355853; cv=none; b=dywY1kHIPZUUoyvLxgeOqJCMYfj23Ug/uLoeEZgr816GW7MRn82ELoH8aUur+qRjx8WbdHjhVfU+9nSg0ibc3bFmS2M3a0pXxckcfPdnwHVg2LYpFiZreREfyPTu+7/5Tg92VZoEzEhQvUM1OkUJ6AX6SdZbcYVZiiocOyVaa2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355853; c=relaxed/simple;
	bh=2C6UuU3lA1cvMMySK6aN8WdRypwkq+po6kgYYOx/UII=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3QUagRhxRQqasIOO2EySOhwG9qxijRlR4tZX4v+JoroW2q/DttfMI8BnvcGM8StafYuNolrgzO3pQVPVbBhLx6Ds062jRVZ1TpLJGoTJxTDQ6CMCOJpw1+/+8sQicTBHQa+3MBCvXcrhBLVf7RqY1b3ivq5+5gu/gU/SbThXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PUlNb/UM; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=xu67p4n6evfypowv7uvnfiwcjq.protonmail; t=1760355830; x=1760615030;
	bh=Cf+K4xGksGI63fT9tHh9sMhD0Zo+BNUG2QgvjzsCjhg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PUlNb/UMYoyP9Me5iNxzOhEBt9lbcvi15lJ1gYiGHPP7YMwcQHdiBM5NS+ZKHFeKb
	 QYKQlRIAvGdt+bZ3lXtWke4dNTqTsglc6Af83+HKBqFFMtEgv2PscS3HHAD3Wye5lX
	 ETl9zR4KJG1gmVn06zct7hw6XqgItuSiNkoZ0yQZ29uNA3fsGNLYj3krO/i0MnT/68
	 zFyBXLL9hCjtRs8+qGKMhM50okCAKc7KrbW1R84bZ4XzZfeqzI2S8h0wL1L1Qe6mBR
	 7wmGb4bYacnvUaH0bQcsVbGvcC1+rzlVnDhaNKLfduZkGaA+FhbTgcuiluePVR4Kbd
	 7FreWkgoItzHw==
Date: Mon, 13 Oct 2025 11:43:45 +0000
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>
From: Zoo Moo <zoomoo100@proton.me>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Marvell 375 and Marvel 88E1514 Phy network problem: mvpp2 or DTS related?
Message-ID: <sGs7xDSqFTh3IlaINxzE4GvtEWPKTTL252AMKaa9ktXAWg-EvzJ7cHHYfFIg3ga3A68lQpo_rxEYHTj8ULaCCscjHILi0vzuRwPCpslpL54=@proton.me>
In-Reply-To: <CAHzn2R3+ow2fJfiZ6Wfd+WMBkEDcgxAR19EtJefrgWWOCniwLg@mail.gmail.com>
References: <wL97kjSJHOArswIoM2huzx9vV9M9uh0SoCZtDVYo-HJFeCwZXraoJ4kc0l1hkxt1XLsejTsRCRCkTqASpo98zAUyfmYoCfzGD3vkaThigVA=@proton.me> <aM_L1Hbind29q_Z_@shell.armlinux.org.uk> <mgCCIJjGoUsB3nhQPO_r2E4X7JvDb5_40Aq9GVv5OoH6OXxsKCuO3lnlVSHj-zH00KV5AY66F4VE6bed9R5yu8SM_jNeBpdGDYAkBNq7hXA=@proton.me> <aNEVX9ew-5kPB22u@shell.armlinux.org.uk> <GyVvHJnPCxv3x_uGwaDIu_KKQgeFhh24x4aRcVQ0WQVr4tjxubB3qeWiSGVmwy8VbKrAQ2nF0iUDLHPTgE7M9ZiOqW1XQ5nTYgzyIcl-VZc=@proton.me> <fw_IlfASLLWC-FISSL4_CyGBtQ4GIHUyP2yekbr82wpiTNryNcql8NAqEdY37qE8AlZjMe4fLdo7I0yYsBaZpYhwB8Eq8GVxYNLUgcTjI7s=@proton.me> <CAHzn2R3+ow2fJfiZ6Wfd+WMBkEDcgxAR19EtJefrgWWOCniwLg@mail.gmail.com>
Feedback-ID: 130971294:user:proton
X-Pm-Message-ID: 893020e5c0fb098a9acb119cb10fa2b7b3a062c2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------a14b49b3190e6f934473065a1798f2d5910dbe86293a5b9038b974df77548853"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------a14b49b3190e6f934473065a1798f2d5910dbe86293a5b9038b974df77548853
Content-Type: multipart/mixed;boundary=---------------------5c82a3d5c3c151d0c7f7eb3f98e9ddd8

-----------------------5c82a3d5c3c151d0c7f7eb3f98e9ddd8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Saturday, 11 October 2025 at 19:27, Marcin Wojtas <marcin.s.wojtas@gmai=
l.com> wrote:

> Hi ZM,
> =


> Have you checked pinctrl settings? The MDIO looks like properly
> working, so I'd double-check if the pins that are assigned to RGMII in
> U-Boot (I assume the interface works there), are not overriden by e.g.
> wrong device tree configuration in kernel.
> =


> Best regards,
> Marcin



Hi Marcin,

Thanks for the suggestion. I've looked at the pinctrl settings in the foll=
owing files and there is nothing set for the 375.

arch/arm/boot/dts/marvell/armada-375.dtsi
arch/arm/boot/dts/marvell/armada-375-synology-ds215j.dts

The missing pinctrl also explain why the SATA drives are not powering up a=
nd detected in the Synology when booting the kernel. =


However, the WD MyCloud Gen2's ethernet and SATA do work without the pinct=
rl settings for SATA and MDIO being set (https://forum.doozan.com/read.php=
?2,94839,page=3D1).
Which is why the synology DS215J is hard to solve as it "should" work in a=
 similar way.

arch/arm/boot/dts/marvell/armada-375-wd-mycloud-gen2.dts

None the less, I tried adding the pinctrl based on the information within =
the following files, but without success:

drivers/pinctrl/mvebu/pinctrl-armada-375.c
Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt


I added the following pin definitions to armada-375.dtsi:

mdio_pins: mdio-pins {
	marvell,pins =3D "mpp37", "mpp38";
	marvell,function =3D "ge";
};

ge0_rgmii_pins: ge0-rgmii-pins {
	marvell,pins =3D "mpp5", "mpp6", "mpp7", "mpp8",
			"mpp9", "mpp10", "mpp11", "mpp12",
			"mpp13", "mpp14", "mpp15", "mpp16";
	marvell,function =3D "ge0";
};

ge1_rgmii_pins: ge1-rgmii-pins {
	marvell,pins =3D "mpp24", "mpp25", "mpp26", "mpp27",
			"mpp28", "mpp29", "mpp30", "mpp31",
			"mpp32", "mpp33", "mpp34", "mpp35";
	marvell,function =3D "ge1";
};


Updated the armada-375-synology-ds215j.dts with the following pinctrl's.

&mdio {
	pinctrl-0 =3D <&mdio_pins>;
	pinctrl-names =3D "default";
	status =3D "okay";
	phy1: ethernet-phy@1 {
		reg =3D <1>;
	};
};

&ethernet {
        status =3D "okay";
};

&eth1 {
	pinctrl-0 =3D <&ge1_rgmii_pins>;
	pinctrl-names =3D "default";
	status =3D "okay";

	phy =3D <&phy1>;
	phy-mode =3D "rgmii-id";
};

However, this didn't fix the problem. The DTS must be missing some other p=
inctrl (like powering on the SATA's interfaces)?
Looking at the many DTS's for the armada-370 arch (e.g. arch/arm/boot/dts/=
marvell/armada-370-synology-ds213j.dts) shows the complexity of setting up=
 the board. Whilst the 375 is missing much of similar looking settings.

Is there any obvious missing GPIO/pincrlt settings that are missing from t=
he armada-375?
-----------------------5c82a3d5c3c151d0c7f7eb3f98e9ddd8
Content-Type: application/pgp-keys; filename="publickey - zoomoo100@proton.me - 0x1C985C6F.asc"; name="publickey - zoomoo100@proton.me - 0x1C985C6F.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - zoomoo100@proton.me - 0x1C985C6F.asc"; name="publickey - zoomoo100@proton.me - 0x1C985C6F.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWjRPYlNCWUpLd1lCQkFI
YVJ3OEJBUWRBMUlsekxwdXFkUkNnOVRlTFZMcC9WWDUxenVNNURkYWwKOHl2SnYrWG1MZnpOS1hw
dmIyMXZiekV3TUVCd2NtOTBiMjR1YldVZ1BIcHZiMjF2YnpFd01FQndjbTkwCmIyNHViV1Urd3NB
UkJCTVdDZ0NEQllKbmc1dElBd3NKQndtUVFkd2s0Nk9STU1ORkZBQUFBQUFBSEFBZwpjMkZzZEVC
dWIzUmhkR2x2Ym5NdWIzQmxibkJuY0dwekxtOXlaK2xkbEsxY0pSU2NBYTdFNnA2OHJ0enYKeVVC
U0FNZTRacy9yVEVYUXFFU0JBeFVLQ0FRV0FBSUJBaGtCQXBzREFoNEJGaUVFSEpoY2IwVjFkdnlC
ClgyMkFRZHdrNDZPUk1NTUFBQU9IQVFEUnhHQlUyTHhGb0ZHNmM4OERiQmwzZmJzQURwWVZuT0Zj
WS9SRQp4dDFRalFFQTZGSjh0OHh4OVpGRG5YWmp1M0NQekdicHJRbHdCd3ZQZ0trVXJVSTVod2pP
T0FSbmc1dEkKRWdvckJnRUVBWmRWQVFVQkFRZEFiMzhJcHRqNXdCNEZ3anorbXhGTzN5TWNyam5B
aEs4Zkt2SFlISXlICjZ3c0RBUWdId3I0RUdCWUtBSEFGZ21lRG0wZ0prRUhjSk9PamtURERSUlFB
QUFBQUFCd0FJSE5oYkhSQQpibTkwWVhScGIyNXpMbTl3Wlc1d1ozQnFjeTV2Y21kQk92cWt0dUtE
bHJ4Wm9NMDBoMld6VlJKWDc2RFoKRW1yTnJaeDN1MDQ0a2dLYkRCWWhCQnlZWEc5RmRYYjhnVjl0
Z0VIY0pPT2prVEREQUFEWmh3RUFqd1JKCmR3M0tGSC9oVktMVlZ6bUkvMklLQkJSV0cxdFdaYTlX
bTh3R3AxSUEvQXRBNGVRWnMwbnRpNDByeVArQgoycy9VTGo2bVBkdXZLdWRUT0d1MS81MEYKPWdl
K24KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=
-----------------------5c82a3d5c3c151d0c7f7eb3f98e9ddd8--

--------a14b49b3190e6f934473065a1798f2d5910dbe86293a5b9038b974df77548853
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmjs5eAJEEHcJOOjkTDDRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmenuzUvwblQaxf8SbeXbXD0AD0WCfh+799GZXrN
PLqCURYhBByYXG9FdXb8gV9tgEHcJOOjkTDDAABYhQEA70GiZiSLyIfLzh2A
XeA01a0SIq0zv6gqrRH0pLs2EFwBAJo/QgE2sNsH8ngkqn+UcfWnvdvMyYHo
2t7D3ccl6YMO
=BNgy
-----END PGP SIGNATURE-----


--------a14b49b3190e6f934473065a1798f2d5910dbe86293a5b9038b974df77548853--


