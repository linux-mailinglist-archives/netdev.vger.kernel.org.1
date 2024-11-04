Return-Path: <netdev+bounces-141643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 080BE9BBE3D
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 20:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3723B1C20CC0
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 19:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C21C729B;
	Mon,  4 Nov 2024 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DpHYZJBW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5E123A6
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749787; cv=none; b=UhXOUhqRJFHmuhj9ky+k9u5Wsb7hlkjznU5iWMaCvcfyfvhrdrIe/SKRxQpv0F8d3krvwFYZ1dNSjQZcs4cwPKUFZqqPKPEYmxFyKc2N3oEBdfkkLHxqRwaBUKsY5PtaJmJCAWAIynKoa7LSBsDO+hJZScTcEWnj1Z/3a2dfhUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749787; c=relaxed/simple;
	bh=Nf5Oa36AE0kErRWsLE8NS4ZzAEfhRzCT9x1wQZGG/6M=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=BR6j5luxtQLOD9eTDs/xneiYrUgeVKiZyGE0e4ye+WG5JL67FbZwNBEjWirgA5n3tEu8rGGgWfEYVa73SzJGz462om6DCqPVPJDVEL2yjuZoeSR8rqc0XstT1kjNp+I3ETJBwnAz6Ugq2JBg4ajXNu2c64k6TRskdTN8VX0RiDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DpHYZJBW; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1730749776; x=1731008976;
	bh=Nf5Oa36AE0kErRWsLE8NS4ZzAEfhRzCT9x1wQZGG/6M=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=DpHYZJBWUzyYHnCV0fCW6MEDGU9aeScXoo/Dw2jyDgIxkZBCSf//naAcZSo/BS1Ys
	 zXI+bBYCzi9GfN6/iuI/iIzO/2jg+sJIlGZJpLB3W/gHnMwlb5EFtsDPDKK5inylGy
	 gb0AAAthKCSQrhpJnEdCgMlzcEjqUPHX/GJn+cPvUV9xF9i7HxYgFYjipSDUV/ohJi
	 Wze9xkNjCwcqtNmaLKl7jpbVuP9Vg3HkIsUincodYCYEQV53cbTq0NndXblDFVsN9f
	 x/1u8HCFCTdz/qees+dOEdLVgx+BCUpaklCh5FhpWCiFHla7LzqEc9ppuuV+Joz2BC
	 HpFzX3nXZ7vRg==
Date: Mon, 04 Nov 2024 19:49:33 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Shochraos <shochraos@proton.me>
Subject: Unknown NIC not recognized by r8169 Kernel-Driver
Message-ID: <H90iT3HXlAkoSxqgPoAXPAZL_ZJ3pFxNGMtFkULq5wVhR9gcTqAPBO84chKKq3NwdgWClT7yuZ9xdLUpIR9SjZRZIcD_qGOq4KufDW2JDYA=@proton.me>
Feedback-ID: 100367158:user:proton
X-Pm-Message-ID: de1e1865599b729c348c61772b60be3a84f20991
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------d7b92fe3551ba5ad858995b9b5a8cf7ec8e7a62ae144ea287caa6f5b44ba402a"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------d7b92fe3551ba5ad858995b9b5a8cf7ec8e7a62ae144ea287caa6f5b44ba402a
Content-Type: multipart/mixed;boundary=---------------------fd5ec8d4f8ee20c1b12e978ff625be30

-----------------------fd5ec8d4f8ee20c1b12e978ff625be30
Content-Type: multipart/alternative;boundary=---------------------0c834aa3abdf3d4af68e6134055fee9a

-----------------------0c834aa3abdf3d4af68e6134055fee9a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hello,

I'm Moritz Freund and I'm currently using Linux as my daily driver. I rece=
ntly switched my motherboard to the Gigabyte x870E Aorus Elite Wifi 7 and =
now ethernet is not working anymore. I suspect that the Realtek-NIC used i=
n that motherboard is a new one as it was released recently.
The command "sudo dmesg | grep r8169" prints the following error message: =
"[ =C2=A0 =C2=A09.452481] r8169 0000:0e:00.0: error -ENODEV: unknown chip =
XID 688, contact r8169 maintainers (see MAINTAINERS file)".
I'm using the distribution CachyOS-Linux and I already contacted the maint=
ainers of that distribution, who told me that I shoulld contact the mainta=
iners of the kernel-driver.
I'm using the 6.11.6-2-cachyos driver as printed out by "uname -r".

Sincerely
Moritz Freund
-----------------------0c834aa3abdf3d4af68e6134055fee9a
Content-Type: multipart/related;boundary=---------------------25bdafbedb9c658b40392a83c766bf31

-----------------------25bdafbedb9c658b40392a83c766bf31
Content-Type: text/html;charset=utf-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0
cHg7Ij5IZWxsbyw8YnI+PGJyPkknbSBNb3JpdHogRnJldW5kIGFuZCBJJ20gY3VycmVudGx5IHVz
aW5nIExpbnV4IGFzIG15IGRhaWx5IGRyaXZlci4gSSByZWNlbnRseSBzd2l0Y2hlZCBteSBtb3Ro
ZXJib2FyZCB0byB0aGUgR2lnYWJ5dGUgeDg3MEUgQW9ydXMgRWxpdGUgV2lmaSA3IGFuZCBub3cg
ZXRoZXJuZXQgaXMgbm90IHdvcmtpbmcgYW55bW9yZS4gSSBzdXNwZWN0IHRoYXQgdGhlIFJlYWx0
ZWstTklDIHVzZWQgaW4gdGhhdCBtb3RoZXJib2FyZCBpcyBhIG5ldyBvbmUgYXMgaXQgd2FzIHJl
bGVhc2VkIHJlY2VudGx5Ljxicj5UaGUgY29tbWFuZCAic3VkbyBkbWVzZyB8IGdyZXAgcjgxNjki
IHByaW50cyB0aGUgZm9sbG93aW5nIGVycm9yIG1lc3NhZ2U6ICI8c3Bhbj5bICZuYnNwOyAmbmJz
cDs5LjQ1MjQ4MV0gcjgxNjkgMDAwMDowZTowMC4wOiBlcnJvciAtRU5PREVWOiB1bmtub3duIGNo
aXAgWElEIDY4OCwgY29udGFjdCByODE2OSBtYWludGFpbmVycyAoc2VlIE1BSU5UQUlORVJTIGZp
bGUpPC9zcGFuPiIuPGJyPkknbSB1c2luZyB0aGUgZGlzdHJpYnV0aW9uIENhY2h5T1MtTGludXgg
YW5kIEkgYWxyZWFkeSBjb250YWN0ZWQgdGhlIG1haW50YWluZXJzIG9mIHRoYXQgZGlzdHJpYnV0
aW9uLCB3aG8gdG9sZCBtZSB0aGF0IEkgc2hvdWxsZCBjb250YWN0IHRoZSBtYWludGFpbmVycyBv
ZiB0aGUga2VybmVsLWRyaXZlci4gPGJyPkknbSB1c2luZyB0aGUgNi4xMS42LTItY2FjaHlvcyBk
cml2ZXIgYXMgcHJpbnRlZCBvdXQgYnkgInVuYW1lIC1yIi48YnI+PGJyPlNpbmNlcmVseTxicj5N
b3JpdHogRnJldW5kPGJyPjwvZGl2Pgo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNh
bnMtc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsiIGNsYXNzPSJwcm90b25tYWlsX3NpZ25hdHVyZV9i
bG9jayBwcm90b25tYWlsX3NpZ25hdHVyZV9ibG9jay1lbXB0eSI+CiAgICA8ZGl2IGNsYXNzPSJw
cm90b25tYWlsX3NpZ25hdHVyZV9ibG9jay11c2VyIHByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2Nr
LWVtcHR5Ij48L2Rpdj4KCiAgICAgICAgICAgIDxkaXYgY2xhc3M9InByb3Rvbm1haWxfc2lnbmF0
dXJlX2Jsb2NrLXByb3RvbiBwcm90b25tYWlsX3NpZ25hdHVyZV9ibG9jay1lbXB0eSI+CgogICAg
ICAgICAgICA8L2Rpdj4KPC9kaXY+Cg==
-----------------------25bdafbedb9c658b40392a83c766bf31--
-----------------------0c834aa3abdf3d4af68e6134055fee9a--
-----------------------fd5ec8d4f8ee20c1b12e978ff625be30--

--------d7b92fe3551ba5ad858995b9b5a8cf7ec8e7a62ae144ea287caa6f5b44ba402a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmcpJT8JkNQ0XG5Ck74XFiEEAAf3C0enkLqEKu2j1DRcbkKT
vhcAAFNrAQC7YqsLcDW9wLKjlERQcACFj3+r5EPTyReveYVeckrvggEAx9qj
F+33hP/1dCgi3886CJrXLQ2x+23f6aqGPIStyAY=
=OSHp
-----END PGP SIGNATURE-----


--------d7b92fe3551ba5ad858995b9b5a8cf7ec8e7a62ae144ea287caa6f5b44ba402a--


