Return-Path: <netdev+bounces-225160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D06B8FAA6
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B853BFB47
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F81277CBF;
	Mon, 22 Sep 2025 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lfqKcm9h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CA321B9DE
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531545; cv=none; b=pAtcJ4U6jF1vDQ76TPLV3zulova1QSaSi+j41YCHeOGJGo5BLHkGumqBgs5RnLPofgQFKGL/osTXF8izyODlwQ7vsWjVcPl9KlfdJSyV/c3vDDPf4w60u+eq+EgSkBh9fhR682i9mhSyKG7Q/oo3+SbnLfcJGDMRFJYUX3vGdW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531545; c=relaxed/simple;
	bh=GzOIcG8zyw8uZ+6xex6j632SGXXJZ8hrSjZcZYpTneU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/14IYPzkIhf53dUUUuRUNIdv1QxDWCP7YiKV4ImyRVw8t6QjH3ZSRaTkWf6cyCanF+usseCjym+Sy5ISe5wFMo8exj1YqHjPeiPRsYvTWokzSfws+HhePGSeZD1WPVwhb8pU+P6mhl7blyj0dgCu1VapLZOq0a67WYjCNwS5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lfqKcm9h; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1758531534; x=1758790734;
	bh=iUkAxXxJ2fKYCTAKSWzh6rUdQSO3VFwBquLke/MxrYE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lfqKcm9htGre5pog/H2KDrF7nHZlABE8ZGxjhHKKUWAD0IWht938f2XRHbWBkMnKF
	 FkTjNJ5lXt1zf5uCFKIWMxjMYOAisfht1BXicVc3S3L4BkgX4zdWOYzTmr2Z4/6KQE
	 NtyraGIqtGLksjByu6UBRT9LNu8FwNsTKd793/Ew9jFpNotFG2TNXKLc+uaof+SeTU
	 Qv+ILb9VMKsY1tjjvQtkUUAWM3nNPaNAq38oOlGVPpGeNfGPytBLSLLUtGIiKY08IJ
	 0AitCltFCay6kltxYlH4/kOQYpt24qX9KzVC8Iw+nAwUj18uMNn/E05K0ykzLVaA6/
	 LBsjiCWh/9Q6Q==
Date: Mon, 22 Sep 2025 08:58:49 +0000
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
From: Zoo Moo <zoomoo100@proton.me>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>
Subject: Re: Marvell 375 and Marvel 88E1514 Phy network problem: mvpp2 or DTS related?
Message-ID: <mgCCIJjGoUsB3nhQPO_r2E4X7JvDb5_40Aq9GVv5OoH6OXxsKCuO3lnlVSHj-zH00KV5AY66F4VE6bed9R5yu8SM_jNeBpdGDYAkBNq7hXA=@proton.me>
In-Reply-To: <aM_L1Hbind29q_Z_@shell.armlinux.org.uk>
References: <wL97kjSJHOArswIoM2huzx9vV9M9uh0SoCZtDVYo-HJFeCwZXraoJ4kc0l1hkxt1XLsejTsRCRCkTqASpo98zAUyfmYoCfzGD3vkaThigVA=@proton.me> <aM_L1Hbind29q_Z_@shell.armlinux.org.uk>
Feedback-ID: 130971294:user:proton
X-Pm-Message-ID: 498dc62c18f9646ec732d458397ead0dbb8f0231
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------a56d8fc580bf2ece5293619b3066ff3ddef3b0d429d12f45225c92811ead63a7"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------a56d8fc580bf2ece5293619b3066ff3ddef3b0d429d12f45225c92811ead63a7
Content-Type: multipart/mixed;boundary=---------------------5b78bffbe33420013dfdf01766c03f1f

-----------------------5b78bffbe33420013dfdf01766c03f1f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Sent with Proton Mail secure email.

On Sunday, 21 September 2025 at 19:56, Russell King (Oracle) <linux@armlin=
ux.org.uk> wrote:

> On Sun, Sep 21, 2025 at 09:05:18AM +0000, Zoo Moo wrote:
> =


> > Hi,
> > =


> > Bodhi from Doozan (https://forum.doozan.com) has been helping me try t=
o get Debian to work on a Synology DS215j NAS. The DS215j is based on a Ma=
rvell Armada 375 (88F6720) and uses a Marvel 88E1514 PHY.
> =


> =


> Probably wrong RGMII phy-mode. I see you're using rgmii-id. Maybe that
> isn't correct. Just a guess based on the problems that RGMII normally
> causes.

Hi Russell,

Thanks, we did try different drivers (gmii, sgmii), but they didn't help, =
details in this message https://forum.doozan.com/read.php?2,138851,139291#=
msg-139291.

I'm happy to try again if you think it will help with debugging.

The uboot log indicates the rgmii is the correct driver ("RGMII0 Module on=
 MAC0"). Or is it misleading?

--------------------------------------------------
BootROM - 1.51
Booting from SPI flash


General initialization - Version: 1.0.0
High speed PHY - Version: 0.1.1 (COM-PHY-V20) =


USB2 UTMI PHY initialized succesfully
USB2 UTMI PHY initialized succesfully
High speed PHY - Ended Successfully

DDR3 Training Sequence - Ver 5.7.1
TWSI Read failed
Error reading from TWSI
DDR3 Training Sequence - Run with PBS.
DDR3 Training Sequence - Ended Successfully =


BootROM: Image checksum verification PASSED

 __   __                      _ _
|  \/  | __ _ _ ____   _____| | |
| |\/| |/ _` | '__\ \ / / _ \ | |
| |  | | (_| | |   \ V /  __/ | |
|_|  |_|\__,_|_|    \_/ \___|_|_|
         _   _     ____              _
        | | | |   | __ )  ___   ___ | |_ =


        | | | |___|  _ \ / _ \ / _ \| __| =


        | |_| |___| |_) | (_) | (_) | |_ =


         \___/    |____/ \___/ \___/ \__| =


 ** LOADER **


U-Boot 2013.01-g5d1ab78 (Oct 27 2015 - 11:38:34) Marvell version: 2014_T2.=
0p3

mvBoardTwsiGet: Twsi Read fail
mvBoardIoExpValSet: Error: Read from IO Expander failed
Board: SYNO-DS215j
SoC:   MV88F6720 Rev A0
       running 2 CPUs
CPU:   ARM Cortex A9 MPCore (Rev 1) LE
       CPU 0
       CPU    @ 800 [MHz]
       L2     @ 400 [MHz]
       TClock @ 200 [MHz]
       DDR    @ 534 [MHz]
       DDR 16Bit Width, FastPath Memory Access, DLB Enabled
DRAM:  512 MiB

Map:   Code:		0x1fed2000:0x1ff93080
       BSS:		0x1ffefe10
       Stack:		0x1f9c1f20
       Heap:		0x1f9c2000:0x1fed2000

MMC:   MRVL_MMC: 0
SF: Detected MX25L6405D with page size 64 KiB, total 8 MiB
PCI-e 0: Detected No Link.
USB2.0 0: Host Mode
USB2.0 1: Device Mode
USB3.0 0: Host Mode
Board configuration detected:
	RGMII0 Module on MAC0
	PON ETH SERDES on MAC1 [SFP]
SERDES configuration:
	Lane #0: PCIe0
	Lane #1: SATA1
	Lane #2: SATA0
	Lane #3: USB3

Synology Model: DS215j
Fan Status: Good
-----------------------5b78bffbe33420013dfdf01766c03f1f
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
-----------------------5b78bffbe33420013dfdf01766c03f1f--

--------a56d8fc580bf2ece5293619b3066ff3ddef3b0d429d12f45225c92811ead63a7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmjRD7kJEEHcJOOjkTDDRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeDQ5SsZLfsjGDNAbRbnuUWLg7T5xvArBIpfLZS
bEQ58BYhBByYXG9FdXb8gV9tgEHcJOOjkTDDAADKNgD9GWevkNVGBu6cLJij
p2CSgszLaJz1vnLWpYSHyyJ6hekBAPCoU+nhN85xhxoBAHEIVLnIqBmSxPdF
Bp6saIGQzOoK
=hbtD
-----END PGP SIGNATURE-----


--------a56d8fc580bf2ece5293619b3066ff3ddef3b0d429d12f45225c92811ead63a7--


