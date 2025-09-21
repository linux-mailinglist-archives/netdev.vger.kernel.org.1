Return-Path: <netdev+bounces-225031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F291CB8D874
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 11:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924BF1892B4A
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 09:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC88225779;
	Sun, 21 Sep 2025 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kA3TQfRa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B831400E
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758445536; cv=none; b=GNr5JbvibaPN8zE0qJOalBFYayqyJpSd9W/J8TNmkI5RL5qIzSYBcxsYui83JPk9Luyd+d8Z8ZWQBEaurvD9rbtPFDEn8uuzVT0Ks/Uqxvvej43VI5N3JrYuz2XIQR7HTRlOzPrforKNrTvPQJzAz4J9Cr3PAv7cIi0PgKGKA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758445536; c=relaxed/simple;
	bh=eRbZmB6YEoSA7Y8xvNlEXjanS80BiM7DxdnabEXg7L8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Pyjir0L49K5qpFGGvEcKw7jhe1e5zxzsP8S9SQhtIrAppK6V/j4xWXS73Inrx2BcvVUfGCzWLRMAPpLvK5x4tB2f5kepy/ZKmFps6JBtQmG4vYUq2NAg1u15jbbcmsxqeOMNWWEiqZIxU4AvOnqb+qeC8SuQrLjpnh3s1Qhdue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kA3TQfRa; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1758445522; x=1758704722;
	bh=eRbZmB6YEoSA7Y8xvNlEXjanS80BiM7DxdnabEXg7L8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kA3TQfRaFp69nk5M5Z1bgn6Zhw4rdZ2lqLtukDB4jOPDlhXJnDRMykFSQSnDgyp8q
	 /AcNWcN2FET4kmzVKT0/WjPu5WCZ7SfKkKCNWBgKyoIeWnXOzrUKlztAZQgDQilabc
	 APiNV/cEnuryIBa5xm4oAbVrq/lOiTXEnGTLJXjSjDEeL7P6DrfTSfyvciDngZw1vb
	 SIo9b9GpfJrotibxHojmwDTorB+d30PWBxXUBvbM5Oo2fzPEaUaiklxYTd1jPnXRuA
	 UiS+Py0z8V+fjUqxUifyBaK83T+y7d45FdOxGmFEEqJF+J+PmIvgJdv0ploGZ+QV8M
	 zNghBOJGLWeZg==
Date: Sun, 21 Sep 2025 09:05:18 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Zoo Moo <zoomoo100@proton.me>
Cc: Marcin Wojtas <mw@semihalf.com>, Russell King <linux@armlinux.org.uk>
Subject: Marvell 375 and Marvel 88E1514 Phy network problem: mvpp2 or DTS related?
Message-ID: <wL97kjSJHOArswIoM2huzx9vV9M9uh0SoCZtDVYo-HJFeCwZXraoJ4kc0l1hkxt1XLsejTsRCRCkTqASpo98zAUyfmYoCfzGD3vkaThigVA=@proton.me>
Feedback-ID: 130971294:user:proton
X-Pm-Message-ID: 9cb292f1c5415e3a9b0751661150c2adabd45e84
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------ef4cebb9cc8b72e8d255fe61bc402c1b3c2dfaea22b5262aa3313aa63bb6709d"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------ef4cebb9cc8b72e8d255fe61bc402c1b3c2dfaea22b5262aa3313aa63bb6709d
Content-Type: multipart/mixed;boundary=---------------------8337196a71e5d2d50c66e6ca4f06e499

-----------------------8337196a71e5d2d50c66e6ca4f06e499
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi,

Bodhi from Doozan (https://forum.doozan.com) has been helping me try to ge=
t Debian to work on a Synology DS215j NAS. The DS215j is based on a Marvel=
l Armada 375 (88F6720) and uses a Marvel 88E1514 PHY.

Even though the eth0 device is detected with the tweaked DTS for the 6.6 k=
ernel. Eth0 can send packets (according to ifconfig and ethtool -S), but n=
othing is ever received by the device or the router.

Even if I manually set an IP and MAC address for eth0 I cannot detect any =
packets leaving the DS215j as I cannot ping/telnet/nmap/wireshark the DS21=
5J. There is also no LED activity on the network hub.

The eth0 interfaces works when booting the stock Synology DSM OS which is =
based on the very old Synology modified 3.x linux kernel. Source is availa=
ble from:
https://global.synologydownload.com/download/ToolChain/Synology%20NAS%20GP=
L%20Source/7.1.1-42962/armada375/linux-3.x.txz

However, the Synology kernel does not use DTS and uses a custom build envi=
ronment.
https://help.synology.com/developer-guide/

Please see the below thread for the gory details of attempting to get DS21=
5j to work:

Debian on Synology DS215j
https://forum.doozan.com/read.php?2,138851


I've created the bugzilla issue with further details:

https://bugzilla.kernel.org/show_bug.cgi?id=3D220591

Cheers,
ZM


Sent with Proton Mail secure email.
-----------------------8337196a71e5d2d50c66e6ca4f06e499
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
-----------------------8337196a71e5d2d50c66e6ca4f06e499--

--------ef4cebb9cc8b72e8d255fe61bc402c1b3c2dfaea22b5262aa3313aa63bb6709d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmjPv8AJEEHcJOOjkTDDRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcND7byWgl4xrT3aXGi4/hHoes7Z2ifUEXmFAN3
Y2Zf/RYhBByYXG9FdXb8gV9tgEHcJOOjkTDDAABgAgD/fyHgdrQ1GCB7R9mw
/jMOgT6IU8a+8XDWf2rmKYtfSxUA/i27Z3NG78UMnOCDB4gr+GNzShyxHoAX
T2FvYW9YMk0M
=auyf
-----END PGP SIGNATURE-----


--------ef4cebb9cc8b72e8d255fe61bc402c1b3c2dfaea22b5262aa3313aa63bb6709d--


