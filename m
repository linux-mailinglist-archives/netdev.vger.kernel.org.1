Return-Path: <netdev+bounces-225759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4681AB98024
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 03:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26DF16CAA4
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 01:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FA61ACEDF;
	Wed, 24 Sep 2025 01:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PVdg1a8e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760002BB1D
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758677598; cv=none; b=mpMk1EuUCR2ubhJFOMFMByHMsNM+flmp1gQx6Gifxr9vRqGl+Ek/8E53ITMDHHulcyfaM+Duim3Bjhj79E3ZXfFRpKq4OmSg5WmJIY6J81Uup9luFkC1OkqCU0h++8IfYkqz1TFKAh0xMrie6JhJsG5yUbjYDpZK2BE2GGYWoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758677598; c=relaxed/simple;
	bh=q8Hk2YxyLZnyZr+ObWGosFqJWHgcDDeqMJTczps9OAQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1jSHzFkE+ofWyi6OMOtgAYIsjudFBJxhMZ4hv3UdaZfeS/yWlhVp6FVSAaW8okKOXor/D/s1i3aqJvay4QjpafJAroYwgASwhs6X+vvnAFl5QMYWr8VLBBNAaD/tuDQk15SDxUV2cVpJsLiT9HgqqLdUalcbyEiL4pAPI4c00o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PVdg1a8e; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=a6jelhte7vefpfzscxv4vpt6ai.protonmail; t=1758677585; x=1758936785;
	bh=m1w97UadNM5DglyOgBNnmJYXxbOZPac+gE4V2brBbDc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PVdg1a8eNthbk+yi0VrKXLDsKRHcxQHvlb17hB5gP3X6avqcMIyI4cem16Mk3qXYa
	 tfC+dCyw6SMjy6M928xJL7jGlLtaTvW+qojI66LA3pX0M803sQzyhqryIl29vOIn9J
	 xRPfb2aiX9sf94a+oNjXobJhIIsXiXpdAn7L5s8eLxGp6XywJTkhZiqptzrGpZpLg0
	 qJv3/hz0uTWlYeBDTxaUN8OhF5woVMHRT/Sc1odo0aBgWr7SypDsH+mkdjzXb30Sgm
	 khiCl1JpDl/3gxeU6sOje5aPzhBbVNzmIBv2ZEmcN7C3hz9AvC6ihTa6BiBe8f8T5u
	 N+ho6Md1cm66A==
Date: Wed, 24 Sep 2025 01:33:00 +0000
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
From: Zoo Moo <zoomoo100@proton.me>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>
Subject: Re: Marvell 375 and Marvel 88E1514 Phy network problem: mvpp2 or DTS related?
Message-ID: <GyVvHJnPCxv3x_uGwaDIu_KKQgeFhh24x4aRcVQ0WQVr4tjxubB3qeWiSGVmwy8VbKrAQ2nF0iUDLHPTgE7M9ZiOqW1XQ5nTYgzyIcl-VZc=@proton.me>
In-Reply-To: <aNEVX9ew-5kPB22u@shell.armlinux.org.uk>
References: <wL97kjSJHOArswIoM2huzx9vV9M9uh0SoCZtDVYo-HJFeCwZXraoJ4kc0l1hkxt1XLsejTsRCRCkTqASpo98zAUyfmYoCfzGD3vkaThigVA=@proton.me> <aM_L1Hbind29q_Z_@shell.armlinux.org.uk> <mgCCIJjGoUsB3nhQPO_r2E4X7JvDb5_40Aq9GVv5OoH6OXxsKCuO3lnlVSHj-zH00KV5AY66F4VE6bed9R5yu8SM_jNeBpdGDYAkBNq7hXA=@proton.me> <aNEVX9ew-5kPB22u@shell.armlinux.org.uk>
Feedback-ID: 130971294:user:proton
X-Pm-Message-ID: 30ed5d444c7d0c70bb0a9a01f651594aad60e527
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------120ca18d958f31f9c3d7aaf8735b4eb1772b90233573fbc4eedf1c9d570d0353"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------120ca18d958f31f9c3d7aaf8735b4eb1772b90233573fbc4eedf1c9d570d0353
Content-Type: multipart/mixed;boundary=---------------------cd2f7be89a38d69f5bcf2dd52f38e81b

-----------------------cd2f7be89a38d69f5bcf2dd52f38e81b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8






Sent with Proton Mail secure email.

On Monday, 22 September 2025 at 19:22, Russell King (Oracle) <linux@armlin=
ux.org.uk> wrote:

> On Mon, Sep 22, 2025 at 08:58:49AM +0000, Zoo Moo wrote:
> =


> > Sent with Proton Mail secure email.
> > =


> > On Sunday, 21 September 2025 at 19:56, Russell King (Oracle) linux@arm=
linux.org.uk wrote:
> > =


> > > On Sun, Sep 21, 2025 at 09:05:18AM +0000, Zoo Moo wrote:
> > =


> > > > Hi,
> > =


> > > > Bodhi from Doozan (https://forum.doozan.com) has been helping me t=
ry to get Debian to work on a Synology DS215j NAS. The DS215j is based on =
a Marvell Armada 375 (88F6720) and uses a Marvel 88E1514 PHY.
> > =


> > > Probably wrong RGMII phy-mode. I see you're using rgmii-id. Maybe th=
at
> > > isn't correct. Just a guess based on the problems that RGMII normall=
y
> > > causes.
> > =


> > Hi Russell,
> > =


> > Thanks, we did try different drivers (gmii, sgmii), but they didn't he=
lp, details in this message https://forum.doozan.com/read.php?2,138851,139=
291#msg-139291.
> =


> =


> What I was meaning was not to try stuff like "SGMII", but try the other
> three flavours of RGMII. In other words:
> =


> rgmii
> rgmii-txid
> rgmii-rxid
> =


> If u-boot works, and it's using RGMII, then it's definitely one of the
> four flavours of RGMII interface.
> =


> No need to post the failures of the testing to the forums - just say
> here whether any of those result in packet flow or not. Nothing else
> should change - the only difference between these modes are the timings
> of the RGMII interface, and having the wrong mode is the most common
> reason for RGMII not working.
> =


> Thanks.
> =


> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Thanks Russel,

I tried all flavours again (rgmii, rgmii-id, rgmii-txid and rgmii-rxid), b=
ut all resulted in the same outcome. =



ifconfig shows it sends packets, but nothing is received. I cannot detect =
it actually sending any packets from the device though.

For example:

root@(none):~# ifconfig eth0 192.168.27.111 netmask 255.255.255.0 up hw et=
her 00:11:22:33:44:55
[   31.727773][ T2055] mvpp2 f10f0000.ethernet eth0: PHY [f10c0054.mdio-mi=
i:01] driver [Marvell 88E1510] (irq=3DPOLL)
[   31.738178][ T2055] mvpp2 f10f0000.ethernet eth0: configuring for phy/r=
gmii-txid link mode
[   36.007360][   T10] mvpp2 f10f0000.ethernet eth0: Link is Up - 1Gbps/Fu=
ll - flow control off

root@(none):~# dhclient eth0
root@(none):~# ifconfig eth0                                              =
     =


eth0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500              =
       =


        inet 192.168.27.111  netmask 255.255.255.0  broadcast 192.168.27.2=
55
        inet6 <IP6 ADDRESS>  prefixlen 64  scopeid 0x20<link>
        ether 00:11:22:33:44:55  txqueuelen 2048  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 71  bytes 4858 (4.7 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

Do I need to adjust the internal delays? rx-internal-delay-ps/tx-internal-=
delay-ps

(reference: https://www.thegoodpenguin.co.uk/blog/linux-ethernet-phy-mode-=
bindings-explained/)

Is it something we can determine by looking at the Synology kernel source?
-----------------------cd2f7be89a38d69f5bcf2dd52f38e81b
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
-----------------------cd2f7be89a38d69f5bcf2dd52f38e81b--

--------120ca18d958f31f9c3d7aaf8735b4eb1772b90233573fbc4eedf1c9d570d0353
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmjTSjwJEEHcJOOjkTDDRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdlESTZtg3t0SkQksmf0dgRcPMpvKCfjMgPn2vM
7CqKjhYhBByYXG9FdXb8gV9tgEHcJOOjkTDDAAAchwD/bIYUPYWTx6PVjFNu
cThHvUyWzTH1AeoAe4hQLty3sh4A/2OFl+c0yAN0P83Yf6jmJ97KGIKVmac8
3MD6mbKOGK8F
=t5y8
-----END PGP SIGNATURE-----


--------120ca18d958f31f9c3d7aaf8735b4eb1772b90233573fbc4eedf1c9d570d0353--


