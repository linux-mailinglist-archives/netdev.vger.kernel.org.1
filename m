Return-Path: <netdev+bounces-227429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4074ABAF0DA
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 05:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52BC1C0AC1
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 03:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D408B27B33A;
	Wed,  1 Oct 2025 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="E0ZxCuEV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71F27AC2E
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287941; cv=none; b=ru1YjLIAdp+OPXGiQ9tZSDdxd6Yfj8zXhVCKmf6YNL3e0mIdZIj61adlBp88iXUsvOKQ3rAJzCoC3VYaggCW8O3c3oM0x+oJ5nwUq5Yn8wcUrHpR1yOfbZk5pjJDRB/IUycPNWmVcTPZS316Kt8iEj/7yTFxJYpOKb1+zr3WuQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287941; c=relaxed/simple;
	bh=dv+65DcdxtHVLUadYVs47I2fVPnq24pF7+WBA3XW1QY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vdm07UkwKIe4nGBoicrYGsVnsehlWYR/7pU2U3j8rx1pTWhvr3C7yQPbb9NvIU/OM25tp1n9ELUGQq/o+4sjScjvGHJK7U2MWkX53j1sZxsmq3gdIhFFmcyszoXG/E4So/JuRzfJzsWCq34isWF2ZtXi3A4KNF/Cc9l1DXXtFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=E0ZxCuEV; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1759287924; x=1759547124;
	bh=dv+65DcdxtHVLUadYVs47I2fVPnq24pF7+WBA3XW1QY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=E0ZxCuEVq/FrB3dQitIgJeuVOXaO7XevXgVnnYR/G0Gw48KQEb9QhnkkHBonfWhdf
	 /uglyC/o1DLr29kgtUd6fyaCFVtZk0Y7ephzSsQGDptiCs/9kYwwg7qrMIZybRuCJW
	 6sd616xbI4plMKIAQAMHMP0sYXp+IK7zI91HyouadWuPhaYVsGfGFj8k18wmi2xUQT
	 1JV8rq5cVzfIAh6DQ98wo/+KmNuDiiqL16uaPPp+dAy/5FwPr5YEJesMF3AYTRQVG+
	 xXshZxMrN+2SwEWJ9p3waQ6AJ01hTwhualcBSzYxsTN4S7FdKKP85zcl2KhU5e8+9D
	 uki1xpCNecjMg==
Date: Wed, 01 Oct 2025 03:05:19 +0000
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
From: Zoo Moo <zoomoo100@proton.me>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>
Subject: Re: Marvell 375 and Marvel 88E1514 Phy network problem: mvpp2 or DTS related?
Message-ID: <fw_IlfASLLWC-FISSL4_CyGBtQ4GIHUyP2yekbr82wpiTNryNcql8NAqEdY37qE8AlZjMe4fLdo7I0yYsBaZpYhwB8Eq8GVxYNLUgcTjI7s=@proton.me>
In-Reply-To: <GyVvHJnPCxv3x_uGwaDIu_KKQgeFhh24x4aRcVQ0WQVr4tjxubB3qeWiSGVmwy8VbKrAQ2nF0iUDLHPTgE7M9ZiOqW1XQ5nTYgzyIcl-VZc=@proton.me>
References: <wL97kjSJHOArswIoM2huzx9vV9M9uh0SoCZtDVYo-HJFeCwZXraoJ4kc0l1hkxt1XLsejTsRCRCkTqASpo98zAUyfmYoCfzGD3vkaThigVA=@proton.me> <aM_L1Hbind29q_Z_@shell.armlinux.org.uk> <mgCCIJjGoUsB3nhQPO_r2E4X7JvDb5_40Aq9GVv5OoH6OXxsKCuO3lnlVSHj-zH00KV5AY66F4VE6bed9R5yu8SM_jNeBpdGDYAkBNq7hXA=@proton.me> <aNEVX9ew-5kPB22u@shell.armlinux.org.uk> <GyVvHJnPCxv3x_uGwaDIu_KKQgeFhh24x4aRcVQ0WQVr4tjxubB3qeWiSGVmwy8VbKrAQ2nF0iUDLHPTgE7M9ZiOqW1XQ5nTYgzyIcl-VZc=@proton.me>
Feedback-ID: 130971294:user:proton
X-Pm-Message-ID: b068ae617b9a871875fb0aa592611dd874087224
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------9eb8e03e1a5965fb6846b81626c1a40e759596240312b200db3b1fbc52c00eb0"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------9eb8e03e1a5965fb6846b81626c1a40e759596240312b200db3b1fbc52c00eb0
Content-Type: multipart/mixed;boundary=---------------------d79d779c1c51507d3816e4f2e5123335

-----------------------d79d779c1c51507d3816e4f2e5123335
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Wednesday, September 24th, 2025 at 11:33 AM, Zoo Moo <zoomoo100@proton.=
me> wrote:
> =


> On Monday, 22 September 2025 at 19:22, Russell King (Oracle) linux@armli=
nux.org.uk wrote:
> =


> > On Mon, Sep 22, 2025 at 08:58:49AM +0000, Zoo Moo wrote:
> > =


> > > Sent with Proton Mail secure email.
> > > =


> > > On Sunday, 21 September 2025 at 19:56, Russell King (Oracle) linux@a=
rmlinux.org.uk wrote:
> > > =


> > > > On Sun, Sep 21, 2025 at 09:05:18AM +0000, Zoo Moo wrote:
> > > =


> > > > > Hi,
> > > =


> > > > > Bodhi from Doozan (https://forum.doozan.com) has been helping me=
 try to get Debian to work on a Synology DS215j NAS. The DS215j is based o=
n a Marvell Armada 375 (88F6720) and uses a Marvel 88E1514 PHY.
> > > =


> > > > Probably wrong RGMII phy-mode. I see you're using rgmii-id. Maybe =
that
> > > > isn't correct. Just a guess based on the problems that RGMII norma=
lly
> > > > causes.
> > > =


> > > Hi Russell,
> > > =


> > > Thanks, we did try different drivers (gmii, sgmii), but they didn't =
help, details in this message https://forum.doozan.com/read.php?2,138851,1=
39291#msg-139291.
> > =


> > What I was meaning was not to try stuff like "SGMII", but try the othe=
r
> > three flavours of RGMII. In other words:
> > =


> > rgmii
> > rgmii-txid
> > rgmii-rxid
> > =


> > If u-boot works, and it's using RGMII, then it's definitely one of the
> > four flavours of RGMII interface.
> > =


> > No need to post the failures of the testing to the forums - just say
> > here whether any of those result in packet flow or not. Nothing else
> > should change - the only difference between these modes are the timing=
s
> > of the RGMII interface, and having the wrong mode is the most common
> > reason for RGMII not working.
> > =


> > Thanks.
> > =


> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> =


> =


> Thanks Russel,
> =


> I tried all flavours again (rgmii, rgmii-id, rgmii-txid and rgmii-rxid),=
 but all resulted in the same outcome.
> =


> ifconfig shows it sends packets, but nothing is received. I cannot detec=
t it actually sending any packets from the device though.
> =


> For example:
> =


> root@(none):~# ifconfig eth0 192.168.27.111 netmask 255.255.255.0 up hw =
ether 00:11:22:33:44:55
> [ 31.727773][ T2055] mvpp2 f10f0000.ethernet eth0: PHY [f10c0054.mdio-mi=
i:01] driver [Marvell 88E1510] (irq=3DPOLL)
> [ 31.738178][ T2055] mvpp2 f10f0000.ethernet eth0: configuring for phy/r=
gmii-txid link mode
> [ 36.007360][ T10] mvpp2 f10f0000.ethernet eth0: Link is Up - 1Gbps/Full=
 - flow control off
> =


> root@(none):~# dhclient eth0
> root@(none):~# ifconfig eth0
> eth0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST> mtu 1500
> =


> inet 192.168.27.111 netmask 255.255.255.0 broadcast 192.168.27.255
> inet6 <IP6 ADDRESS> prefixlen 64 scopeid 0x20<link>
> =


> ether 00:11:22:33:44:55 txqueuelen 2048 (Ethernet)
> RX packets 0 bytes 0 (0.0 B)
> RX errors 0 dropped 0 overruns 0 frame 0
> TX packets 71 bytes 4858 (4.7 KiB)
> TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0
> =


> Do I need to adjust the internal delays? rx-internal-delay-ps/tx-interna=
l-delay-ps
> =


> (reference: https://www.thegoodpenguin.co.uk/blog/linux-ethernet-phy-mod=
e-bindings-explained/)
> =


> Is it something we can determine by looking at the Synology kernel sourc=
e?


Hi,

Any other suggestions I could try to debug this issue?

Appreciate any suggestions.

Cheers,
ZM
-----------------------d79d779c1c51507d3816e4f2e5123335
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
-----------------------d79d779c1c51507d3816e4f2e5123335--

--------9eb8e03e1a5965fb6846b81626c1a40e759596240312b200db3b1fbc52c00eb0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmjcmmEJEEHcJOOjkTDDRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeyzodozlvwJnGBMt0FUApE0WYOSe3JrsrtEO7q
uMxE7RYhBByYXG9FdXb8gV9tgEHcJOOjkTDDAAB9SwD/Q4CzrxaE9YTVGOQO
gLBEUfhzDjmTqwFA0A3WDltLQL0A/3JZM3ekAPH5ZZHx11UYLfRurhMQRzDW
lU750z6N2/4K
=PPz/
-----END PGP SIGNATURE-----


--------9eb8e03e1a5965fb6846b81626c1a40e759596240312b200db3b1fbc52c00eb0--


