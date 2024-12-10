Return-Path: <netdev+bounces-150845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597239EBBBF
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56389163B36
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A383023024D;
	Tue, 10 Dec 2024 21:21:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13623ED4A
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733865682; cv=none; b=ffVPWg7DbMYmyN4vxSJbDBF92rw6hbRz1y2/YIeOhE8S9iVPFptV7j71Ap8Qd5szzj3K4NBxkEl8ImR/iUM4Gi/4NAcZHQ9bC7ObVeFZAyPxzjqhpE7Zp/j1kUDTKWbkX1C5VEVEsadqFtPFV8IyU1gdoxjpdNLkDe5xmtrWr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733865682; c=relaxed/simple;
	bh=03QxPv6zHZFNMcD5lh91H1q2l5BIdvYZmqXGPIXUEWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2Iop3NJwewhgrddQb+W8oAlOyASmKK987RtXZ1yzgs6lvziA+lztnE0OPr3APYTFjsIcedUacQDGhT/4qIuagxRVANr6W/5yzoUcr38zEYrr4wQV3Eg93q2fXYCNm5aRydDxSG/Y95WHIzQNsuT8h+cpMccp7UXlxgbIOZtwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.96)
	(envelope-from <joerg@jo-so.de>)
	id 1tL7fI-001fAJ-03;
	Tue, 10 Dec 2024 22:21:08 +0100
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98)
	(envelope-from <joerg@jo-so.de>)
	id 1tL7fH-00000000Qis-1e4Y;
	Tue, 10 Dec 2024 22:21:07 +0100
Date: Tue, 10 Dec 2024 22:21:07 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Eggers <ceggers@arri.de>, netdev@vger.kernel.org
Subject: Re: KSZ8795 not detected at start to boot from NFS
Message-ID: <vuslt6lyxgfyswtpymtu5yklflzqs5f2l2yqtzlypnyqe6llkk@yz3eakhmctsq>
OpenPGP: id=7D2C9A23D1AEA375; url=https://jo-so.de/pgp-key.txt;
 preference=signencrypt
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <a578b29f-53f0-4e33-91a4-3932fa759cd1@lunn.ch>
 <phab74r5xxbufhe6llruqa3tgkxzalytgzqrko4o2bg2xzizjv@apha3we342xn>
 <7080052.9J7NaK4W3v@n9w6sw14>
 <zhuujdhxrquhi4u6n25rryx3yw3lm2ceuijcwjmnrr4awt4ys4@53wh2fqxnd6w>
 <njdcvcha6n3chy2ldrf2ghnj5brgqxqujrk4trp5wyo6jvpo6c@b3qdubsvg6ko>
 <f52b2e7d-e4dc-4afd-8a7f-eaa2d4586fb9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gdvp7ysucchvqtbi"
Content-Disposition: inline
In-Reply-To: <f52b2e7d-e4dc-4afd-8a7f-eaa2d4586fb9@lunn.ch>


--gdvp7ysucchvqtbi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: KSZ8795 not detected at start to boot from NFS
MIME-Version: 1.0

Andrew Lunn schrieb am Di 10. Dez, 18:41 (+0100):
> > So I think it's a timing problem: the ksz8795 isn't ready after the SPI
> > reset, when the chip ID gets read, and this causes the probing to stop.
>=20
> Is there anything in the datasheet about reset timing?=20

Not exactly. On page 127 is a diagram about resetting the chip.

https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocum=
ents/DataSheets/KSZ8795CLX-Data-Sheet-DS00002112.pdf

Here's a commit that contains a calculation and determines 100ms.

commit 1aa4ee0ec7fe929bd46ae20d9457f0a242115643
Author: Marek Vasut <marex@denx.de>
Date:   Wed Jan 20 04:05:02 2021 +0100

    net: dsa: microchip: Adjust reset release timing to match reference res=
et circuit

    commit 1c45ba93d34cd6af75228f34d0675200c81738b5 upstream.

    KSZ8794CNX datasheet section 8.0 RESET CIRCUIT describes recommended
    circuit for interfacing with CPU/FPGA reset consisting of 10k pullup
    resistor and 10uF capacitor to ground. This circuit takes ~100 ms to
    rise enough to release the reset.

    For maximum supply voltage VDDIO=3D3.3V VIH=3D2.0V R=3D10kR C=3D10uF th=
at is
                        VDDIO - VIH
      t =3D R * C * -ln( ------------- ) =3D 10000*0.00001*-(-0.93)=3D0.093=
 s
                           VDDIO
    so we need ~95 ms for the reset to really de-assert, and then the
    original 100us for the switch itself to come out of reset. Simply
    msleep() for 100 ms which fits the constraint with a bit of extra
    space.


J=C3=B6rg

--=20
=E2=80=9EDass man etwas durchdringen kann, wenn man es durchschaut
 hat, ist der Irrtum der Fliege an der Fensterscheibe.=E2=80=9C (Nietzsche)

--gdvp7ysucchvqtbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCZ1iwwgAKCRB9LJoj0a6j
dW6fAP0UkspqH6PurY94sxxPW3jr3q4vNAXKvbj6wgx9WA1rNgEAjOYVZcsYQrlV
QgnB8mLua2VyMM22+JeFfPPky+1hr+Q=
=PcLh
-----END PGP SIGNATURE-----

--gdvp7ysucchvqtbi--

