Return-Path: <netdev+bounces-196559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB88EAD54D8
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A875189CDFE
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D3226E710;
	Wed, 11 Jun 2025 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="wPzaOHYc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F921771B;
	Wed, 11 Jun 2025 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643265; cv=none; b=l8fyh9YZ5fd6Yf/ZcWqO5fwwj6nR+yfyy0+/zvB/LXUE2fqDR7mgPz44bMONv1LOMmRWjZhS4jDwhl12NfJ62Gi2rNYkj2J4vB1816QiDl+L461KpfGIwUkpr+fSuLzZb8LLdzzDpv2pHF7FAQr5ZZRNKSxbstCm4TTUNalN9Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643265; c=relaxed/simple;
	bh=DPyif7wjB/BI1uDQ9ZSb6fLiuDBkinB69PeQhrtVH8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3MEdA/ygwdhhNDdKxgOOz5AmbWmPmja41mnl8v/e7/FdPJ1MmGTAMSWICcEDFtP9nTM/htJ7woNrSxzYj1HVCCYar5C4337OYmE7yWmlWwAHwh5AdWus+dYaqGgvGLyu7Iv04cw8/CC2SYuXL77vqrwJBmfyQpy1n2etcQHNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=wPzaOHYc; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1749643256; x=1750248056; i=christian@heusel.eu;
	bh=y5brXmuflksAR6xqecLLmPo29ypK+ylrFjGvOfgZwOw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wPzaOHYc7zw+ykR1vAtEFlguoWp3KzaO1iMeant2Nn51z3ogvrsJ+NlVaeqUSA9T
	 4jhhG69BnhqI16gnOU7vTgIL15VXjb2KptKpPaoMErceC4DBPHdp4o/gEUqn9zq3h
	 kJodlxSln3eNqHKVT3TfNZyp3lLpIMldZMlisTRf+LNg/eBPgco2o3z5WppRcSmCV
	 IxGGPkTJSEWDfCjehiURlF9vMAOc7os8y0cZOYqPtgxE9EoDk7Skn2FaZZoiK+iHJ
	 eanGeepiHQn+KNfY2jQAMdRCGNo+o7KVCh1IAraSElWGgULLQ2GyuiaInu0ruGYsc
	 QafamKLZXYW8v6AIbA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([89.244.90.56]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mzyi6-1un3IM2Wco-00twZQ; Wed, 11 Jun 2025 13:46:08 +0200
Date: Wed, 11 Jun 2025 13:46:01 +0200
From: Christian Heusel <christian@heusel.eu>
To: Jacek =?utf-8?Q?=C5=81uczak?= <difrost.kernel@gmail.com>
Cc: regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>, 
	kuni1840@gmail.com, kuniyu@amazon.com, davem@davemloft.net, edumazet@google.com, 
	Mario Limonciello <mario.limonciello@amd.com>, Eric Naim <dnaim@cachyos.org>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
Message-ID: <58be003a-c956-494b-be04-09a5d2c411b9@heusel.eu>
References: <68d38b0b-1666-4974-85d4-15575789c8d4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ifh6e7xanojzxv73"
Content-Disposition: inline
In-Reply-To: <68d38b0b-1666-4974-85d4-15575789c8d4@gmail.com>
X-Provags-ID: V03:K1:JMLDmodqvcWSrhKyrRJsk+6IfTaOJfrOveoGwq/L+3WmTLXx7ht
 gsbgLkZjCAivZknjqXmTTBL/WPzGMAci6efmGubjPju9f7ifdgl5MRJTXB9H7pwwk2s65LJ
 BQ3Cs6COvNckYrCSwk1msmpTHT+aocIZ1GyYvm8WIXcUlWdpPvO6vBYWuK2KmcnxylwF5GU
 yTX5aub+3P9CdIpumxHRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JcT55P5Ok5E=;BKMLisiLHaedVLWZCs/YQNYmvfK
 rL91c7cVkfGkLMu8C0zGVbj7K6fgAaA40ImVOTgri7iahTrRWosFO5D1VNdvk2oYyV75XCiiO
 I0Ah7d1EyIQI0i2bPrCCTFHBMJ+y0BWxb+2uMNi+JQuB6dtW9Ih1+F272UAep/+McpJVDg8bK
 hX1a7lqra+4rgzrH5Vt3/qcQKbrjHCBsaK48ZPRiX7nreJHYr7grY8ugvzx4gt+LWzravXoOA
 Tq8ddpP4cvycYaXxGuHv2rnT297V9BIrSXfiJsmikr0LUfQUGQ32hCoimj3w0glDbwjTw5sgO
 FD/vNkKDkmZBqU+HeQvG70SsSAQ5sr717NcBpjMne+6smsEXkH4l6dy7pLwf6UqI5Xm1ShJtk
 FwSs45l1xXRFvP/fyNS7401/XLSs0ygbDnYGLI9NUhPu45jiBsNhdpihT1X8ZLKN+BDEKqdrr
 G/pEpdCdBZRiNvJUKvbpOhs2EXGpkvEHZhmQMw8Gut2hcDWZ8SsH8ve8Rx579IXD4RyNvao1l
 Z4LFfpD9DJz6hpQt8RMqh3iicxK1RJH66e4592oOtxoLy1p67lOdUHxAE8Wh4TTVI96Xqsn6w
 u+U5RgZuo5+ok9JAvAk5ery2Qjt9Gss4Vjz40lcDmSQeqwqdaYZjekKUKx9Qji/kzOe98Lsod
 NHU+jswZRD55RVcChgPBu62KSszNIERarQzAHfJpy0RVN/0jAN3xKnzykXwEhsT8FNYrHoaMA
 YBd0fdVAAu6fWbdopXW5NpOZxob9R8Rv83omMBP732q0A89etptkqw5Ud1KaiqU0o7ZvECPzx
 vbQTb59HZnVYj3MI27dC8fMU+yAZPDe89+5v1drJrD8YpzcpkXNm3A4Z4M19tC9HgFxH+kGLG
 qN7/ncQ0ZEvPf6AwbWhBifXNPuDk3vaXtgslCl6F3Dnk9sLU4xLmJEcKlqzsXqGdryrrTxGBh
 bFf0wQWUSAvpLBkEQq1VqLSq2NzYDV6Lcgj2hp4becC5bpq6cEoiWOaOuYCUXJo+nqKBi7LA+
 mW+LK3xH+OMGkmF+44T5mhv9zyg1Jf2fRCphdWU90i4WLKqTueVHn6dgFYGEkTigR3mqdG793
 ND+vGUkB2q/yE5tqR4fgDFnc282talI8bkqD5Xvr++b4eOb7kbN9PtL4a1bSQIBC/MtgMlSSE
 HxULC/lmE+wQozbSrMVtCOpy4c92a2YD9BiXYfBTwZ8Vu9ndeSv4Gy59BzbPIrfNMHK3LjDCO
 EoxhUlfvU8l2kTMgWLYjzfolI4q6sWDrGY6qjr9qEM09PqBWYbmdQTI8DES/fCZDMxd84toyM
 JXRAqjgFo2RMNRBBSfmnz96eraXxUUD3T97ewlwlULt9iPuyVi0o+jSX0eSx6JhEJF4kgvFdt
 rlqf5CWkNmSXUqFMFGcbjCjTeo46Ha7Np+xDgtbg8rkoWgzrH+v+i6rEAe


--ifh6e7xanojzxv73
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="ofsj7hvjgjxpsigb"
Content-Disposition: inline
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
MIME-Version: 1.0


--ofsj7hvjgjxpsigb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25/06/10 09:22PM, Jacek =C5=81uczak wrote:
> Hi,

Hey,

> Bisection points to:
> [3f84d577b79d2fce8221244f2509734940609ca6] af_unix: Inherit sk_flags
> at connect().

I'm also suffering from an issue that I have bisected to the same commit,
although in a totally different environment and with other reproduction
steps: For me the Xorg server crashes as soon as I re-plug my laptops
power chord and afterwards I can only switch to a TTY to debug. No
errors are logged in the dmesg.

This is the relevant excerpt from the Xorg log (full one is attached):

[    36.544] (EE) modeset(0): Failed to set CTM property: -13
[    36.544] (EE) modeset(0): Failed to set CTM property: -13
[    36.544] (II) modeset(0): EDID vendor "LEN", prod id 16553
[    36.544] (II) modeset(0): Printing DDC gathered Modelines:
[    36.544] (II) modeset(0): Modeline "1920x1080"x0.0  138.78  1920 1968 2=
000 2080  1080 1090 1096 1112 -hsync -vsync (66.7 kHz eP)
[    36.547] (EE) modeset(0): Failed to set CTM property: -13
[    36.547] (EE) modeset(0): Failed to set CTM property: -13
[    36.547] (II) modeset(0): EDID vendor "LEN", prod id 16553
[    36.547] (II) modeset(0): Printing DDC gathered Modelines:
[    36.547] (II) modeset(0): Modeline "1920x1080"x0.0  138.78  1920 1968 2=
000 2080  1080 1090 1096 1112 -hsync -vsync (66.7 kHz eP)
[    36.897] (WW) modeset(0): Present-unflip: queue flip during flip on CRT=
C 0 failed: Permission denied
[    37.196] (EE) modeset(0): Failed to set CTM property: -13
[    37.196] (EE) modeset(0): failed to set mode: No such file or directory


I can also confirm that reverting the patch on top of 6.16-rc1 fixes the
issue for me (thanks for coming up with the revert to Naim from the
CachyOS team!).

My xorg version is 21.1.16-1 on Arch Linux and I have attached the
revert, my xorg log from the crash and bisection log to this mail!

I'll also CC a few of the netdev people that might have further insights
for this issue!

> Reverting entire SO_PASSRIGHTS fixes the issue.
>=20
> Regards,
> -Jacek

Cheers,
Chris

---

#regzbot introduced: 3f84d577b79d2
#regzbot title: af_unix: Change in streams crashes various display servers

---

git bisect start
# status: waiting for both good and bad commits
# good: [0ff41df1cb268fc69e703a08a57ee14ae967d0ca] Linux 6.15
git bisect good 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
# status: waiting for bad commit, 1 good commit known
# bad: [19272b37aa4f83ca52bdf9c16d5d81bdd1354494] Linux 6.16-rc1
git bisect bad 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
# bad: [1b98f357dadd6ea613a435fbaef1a5dd7b35fd21] Merge tag 'net-next-6.16'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect bad 1b98f357dadd6ea613a435fbaef1a5dd7b35fd21
# good: [a61e26038143727d9b0f1bc01b0370f77f2ad7e4] Merge tag 'media/v6.16-1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good a61e26038143727d9b0f1bc01b0370f77f2ad7e4
# good: [bbff27b54e4271a42ea1dba93a76e51165f2dbaa] Merge tag 'nios2_updates=
_for_v6.16' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux
git bisect good bbff27b54e4271a42ea1dba93a76e51165f2dbaa
# good: [e39d14a760c039af0653e3df967e7525413924a0] net: dsa: b53: implement=
 setting ageing time
git bisect good e39d14a760c039af0653e3df967e7525413924a0
# good: [ed73728fd14e14714a86b4826fb7115d9dade1b6] Merge tag 'mt76-next-202=
5-05-21' of https://github.com/nbd168/wireless
git bisect good ed73728fd14e14714a86b4826fb7115d9dade1b6
# bad: [bb91f7547f79434e8818d3f235437e021d34c1cb] octeontx2-af: NPC: Clear =
Unicast rule on nixlf detach
git bisect bad bb91f7547f79434e8818d3f235437e021d34c1cb
# good: [c6a957d067912f1ab4e3be4c92d3730c21d1ddb8] selftests: drv-net: Fix =
"envirnoments" to "environments"
git bisect good c6a957d067912f1ab4e3be4c92d3730c21d1ddb8
# good: [ea6342d98928e243f2024fb97a9b4d42ee55dfba] net: add skb_copy_and_cr=
c32c_datagram_iter()
git bisect good ea6342d98928e243f2024fb97a9b4d42ee55dfba
# good: [33e1b1b3991ba8c0d02b2324a582e084272205d6] Merge git://git.kernel.o=
rg/pub/scm/linux/kernel/git/netdev/net
git bisect good 33e1b1b3991ba8c0d02b2324a582e084272205d6
# good: [23205562ffc8de20f57afdd984858cab29e77968] Bluetooth: separate CIS_=
LINK and BIS_LINK link types
git bisect good 23205562ffc8de20f57afdd984858cab29e77968
# good: [3041bbbeb41b807d2e24d7d78d9cc1387d95898a] af_unix: Don't pass stru=
ct socket to maybe_add_creds().
git bisect good 3041bbbeb41b807d2e24d7d78d9cc1387d95898a
# good: [0e81cfd971dc4833c699dcd8924e54a5021bc4e8] af_unix: Move SOCK_PASS{=
CRED,PIDFD,SEC} to struct sock.
git bisect good 0e81cfd971dc4833c699dcd8924e54a5021bc4e8
# bad: [77cbe1a6d8730a07f99f9263c2d5f2304cf5e830] af_unix: Introduce SO_PAS=
SRIGHTS.
git bisect bad 77cbe1a6d8730a07f99f9263c2d5f2304cf5e830
# bad: [3f84d577b79d2fce8221244f2509734940609ca6] af_unix: Inherit sk_flags=
 at connect().
git bisect bad 3f84d577b79d2fce8221244f2509734940609ca6
# first bad commit: [3f84d577b79d2fce8221244f2509734940609ca6] af_unix: Inh=
erit sk_flags at connect().


--ofsj7hvjgjxpsigb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Xorg.0.log"
Content-Transfer-Encoding: quoted-printable

[    20.012]=20
X.Org X Server 1.21.1.16
X Protocol Version 11, Revision 0
[    20.012] Current Operating System: Linux meterpeter 6.16.0-rc1-1-mainli=
ne #1 SMP PREEMPT_DYNAMIC Mon, 09 Jun 2025 11:55:49 +0000 x86_64
[    20.012] Kernel command line: initrd=3D\initramfs-linux-mainline.img cr=
yptdevice=3DUUID=3D8913bf3e-3df0-478e-b072-f7bec731154b:archlinux root=3D/d=
ev/mapper/archlinux rootflags=3Dsubvol=3D@ rw loglevel=3D4 drm.panic_screen=
=3Dqr_code
[    20.012] =20
[    20.012] Current version of pixman: 0.46.2
[    20.012] 	Before reporting problems, check http://wiki.x.org
	to make sure that you have the latest version.
[    20.012] Markers: (--) probed, (**) from config file, (=3D=3D) default =
setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[    20.013] (=3D=3D) Log file: "/home/chris/.local/share/xorg/Xorg.0.log",=
 Time: Wed Jun 11 13:40:52 2025
[    20.015] (=3D=3D) Using config directory: "/etc/X11/xorg.conf.d"
[    20.015] (=3D=3D) Using system config directory "/usr/share/X11/xorg.co=
nf.d"
[    20.015] (=3D=3D) No Layout section.  Using the first Screen section.
[    20.015] (=3D=3D) No screen section available. Using defaults.
[    20.015] (**) |-->Screen "Default Screen Section" (0)
[    20.015] (**) |   |-->Monitor "<default monitor>"
[    20.015] (=3D=3D) No monitor specified for screen "Default Screen Secti=
on".
	Using a default monitor configuration.
[    20.015] (**) Allowing byte-swapped clients
[    20.015] (=3D=3D) Automatically adding devices
[    20.015] (=3D=3D) Automatically enabling devices
[    20.015] (=3D=3D) Automatically adding GPU devices
[    20.015] (=3D=3D) Automatically binding GPU devices
[    20.015] (=3D=3D) Max clients allowed: 256, resource mask: 0x1fffff
[    20.017] (WW) The directory "/usr/share/fonts/Type1" does not exist.
[    20.017] 	Entry deleted from font path.
[    20.017] (WW) The directory "/usr/share/fonts/100dpi" does not exist.
[    20.018] 	Entry deleted from font path.
[    20.018] (WW) The directory "/usr/share/fonts/75dpi" does not exist.
[    20.018] 	Entry deleted from font path.
[    20.018] (=3D=3D) FontPath set to:
	/usr/share/fonts/misc,
	/usr/share/fonts/TTF,
	/usr/share/fonts/OTF
[    20.018] (=3D=3D) ModulePath set to "/usr/lib/xorg/modules"
[    20.018] (II) The server relies on udev to provide the list of input de=
vices.
	If no devices become available, reconfigure udev or disable AutoAddDevices.
[    20.018] (II) Module ABI versions:
[    20.018] 	X.Org ANSI C Emulation: 0.4
[    20.018] 	X.Org Video Driver: 25.2
[    20.018] 	X.Org XInput driver : 24.4
[    20.018] 	X.Org Server Extension : 10.0
[    20.018] (++) using VT number 2

[    20.018] (--) controlling tty is VT number 2, auto-enabling KeepTty
[    20.019] (II) systemd-logind: took control of session /org/freedesktop/=
login1/session/c1
[    20.020] (II) xfree86: Adding drm device (/dev/dri/card1)
[    20.020] (II) Platform probe for /sys/devices/pci0000:00/0000:00:08.1/0=
000:04:00.0/drm/card1
[    20.021] (II) systemd-logind: got fd for /dev/dri/card1 226:1 fd 13 pau=
sed 0
[    20.026] (--) PCI:*(4@0:0:0) 1002:164c:17aa:5097 rev 194, Mem @ 0x46000=
0000/268435456, 0x470000000/2097152, 0xfd300000/524288, I/O @ 0x00001000/256
[    20.027] (WW) Open ACPI failed (/var/run/acpid.socket) (No such file or=
 directory)
[    20.027] (II) LoadModule: "glx"
[    20.027] (II) Loading /usr/lib/xorg/modules/extensions/libglx.so
[    20.035] (II) Module glx: vendor=3D"X.Org Foundation"
[    20.035] 	compiled for 1.21.1.16, module version =3D 1.0.0
[    20.035] 	ABI class: X.Org Server Extension, version 10.0
[    20.035] (=3D=3D) Matched ati as autoconfigured driver 0
[    20.035] (=3D=3D) Matched modesetting as autoconfigured driver 1
[    20.035] (=3D=3D) Matched fbdev as autoconfigured driver 2
[    20.035] (=3D=3D) Matched vesa as autoconfigured driver 3
[    20.035] (=3D=3D) Assigned the driver to the xf86ConfigLayout
[    20.035] (II) LoadModule: "ati"
[    20.035] (WW) Warning, couldn't open module ati
[    20.035] (EE) Failed to load module "ati" (module does not exist, 0)
[    20.035] (II) LoadModule: "modesetting"
[    20.035] (II) Loading /usr/lib/xorg/modules/drivers/modesetting_drv.so
[    20.038] (II) Module modesetting: vendor=3D"X.Org Foundation"
[    20.038] 	compiled for 1.21.1.16, module version =3D 1.21.1
[    20.039] 	Module class: X.Org Video Driver
[    20.039] 	ABI class: X.Org Video Driver, version 25.2
[    20.039] (II) LoadModule: "fbdev"
[    20.039] (WW) Warning, couldn't open module fbdev
[    20.039] (EE) Failed to load module "fbdev" (module does not exist, 0)
[    20.039] (II) LoadModule: "vesa"
[    20.039] (WW) Warning, couldn't open module vesa
[    20.039] (EE) Failed to load module "vesa" (module does not exist, 0)
[    20.039] (II) modesetting: Driver for Modesetting Kernel Drivers: kms
[    20.039] (II) modeset(0): using drv /dev/dri/card1
[    20.039] (WW) VGA arbiter: cannot open kernel arbiter, no multi-card su=
pport
[    20.039] (II) modeset(0): Creating default Display subsection in Screen=
 section
	"Default Screen Section" for depth/fbbpp 24/32
[    20.039] (=3D=3D) modeset(0): Depth 24, (=3D=3D) framebuffer bpp 32
[    20.039] (=3D=3D) modeset(0): RGB weight 888
[    20.039] (=3D=3D) modeset(0): Default visual is TrueColor
[    20.039] (II) Loading sub module "glamoregl"
[    20.039] (II) LoadModule: "glamoregl"
[    20.040] (II) Loading /usr/lib/xorg/modules/libglamoregl.so
[    20.047] (II) Module glamoregl: vendor=3D"X.Org Foundation"
[    20.047] 	compiled for 1.21.1.16, module version =3D 1.0.1
[    20.047] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    20.356] (II) modeset(0): glamor X acceleration enabled on AMD Radeon G=
raphics (radeonsi, renoir, ACO, DRM 3.64, 6.16.0-rc1-1-mainline)
[    20.356] (II) modeset(0): glamor initialized
[    20.356] (=3D=3D) modeset(0): VariableRefresh: disabled
[    20.356] (=3D=3D) modeset(0): AsyncFlipSecondaries: disabled
[    20.358] (II) modeset(0): Output eDP-1 has no monitor section
[    20.358] (II) modeset(0): Output HDMI-1 has no monitor section
[    20.358] (II) modeset(0): Output DP-1 has no monitor section
[    20.360] (II) modeset(0): EDID for output eDP-1
[    20.360] (II) modeset(0): Manufacturer: LEN  Model: 40a9  Serial#: 0
[    20.360] (II) modeset(0): Year: 2019  Week: 41
[    20.360] (II) modeset(0): EDID Version: 1.4
[    20.360] (II) modeset(0): Digital Display Input
[    20.360] (II) modeset(0): 8 bits per channel
[    20.360] (II) modeset(0): Digital interface is DisplayPort
[    20.360] (II) modeset(0): Max Image Size [cm]: horiz.: 31  vert.: 17
[    20.360] (II) modeset(0): Gamma: 2.20
[    20.360] (II) modeset(0): DPMS capabilities: StandBy Suspend Off
[    20.360] (II) modeset(0): Supported color encodings: RGB 4:4:4=20
[    20.360] (II) modeset(0): First detailed timing is preferred mode
[    20.360] (II) modeset(0): Preferred mode is native pixel format and ref=
resh rate
[    20.360] (II) modeset(0): redX: 0.590 redY: 0.350   greenX: 0.330 green=
Y: 0.555
[    20.360] (II) modeset(0): blueX: 0.153 blueY: 0.119   whiteX: 0.313 whi=
teY: 0.329
[    20.360] (II) modeset(0): Manufacturer's mask: 0
[    20.360] (II) modeset(0): Supported detailed timing:
[    20.360] (II) modeset(0): clock: 138.8 MHz   Image Size:  309 x 173 mm
[    20.360] (II) modeset(0): h_active: 1920  h_sync: 1968  h_sync_end 2000=
 h_blank_end 2080 h_border: 0
[    20.360] (II) modeset(0): v_active: 1080  v_sync: 1090  v_sync_end 1096=
 v_blanking: 1112 v_border: 0
[    20.360] (II) modeset(0): Supported detailed timing:
[    20.360] (II) modeset(0): clock: 138.8 MHz   Image Size:  309 x 173 mm
[    20.360] (II) modeset(0): h_active: 1920  h_sync: 1968  h_sync_end 2000=
 h_blank_end 2080 h_border: 0
[    20.360] (II) modeset(0): v_active: 1080  v_sync: 1090  v_sync_end 1096=
 v_blanking: 1112 v_border: 0
[    20.361] (II) modeset(0): Unknown vendor-specific block f
[    20.361] (II) modeset(0):  N140HCA-EAE
[    20.361] (II) modeset(0): EDID (in hex):
[    20.361] (II) modeset(0): 	00ffffffffffff0030aea94000000000
[    20.361] (II) modeset(0): 	291d0104a51f1178e228659759548e27
[    20.361] (II) modeset(0): 	1e505400000001010101010101010101
[    20.361] (II) modeset(0): 	010101010101363680a0703820403020
[    20.361] (II) modeset(0): 	a60035ad10000018363680a070382040
[    20.361] (II) modeset(0): 	3020a60035ad100000180000000f00d1
[    20.361] (II) modeset(0): 	093cd109301e0a000dae0a14000000fe
[    20.361] (II) modeset(0): 	004e3134304843412d4541450a200046
[    20.361] (II) modeset(0): Printing probed modes for output eDP-1
[    20.361] (II) modeset(0): Modeline "1920x1080"x60.0  138.78  1920 1968 =
2000 2080  1080 1090 1096 1112 -hsync -vsync (66.7 kHz eP)
[    20.361] (II) modeset(0): Modeline "1920x1080"x119.9  266.50  1920 1944=
 1960 2000  1080 1081 1084 1111 doublescan +hsync -vsync (133.2 kHz d)
[    20.361] (II) modeset(0): Modeline "1920x1080"x60.0  173.00  1920 2048 =
2248 2576  1080 1083 1088 1120 -hsync +vsync (67.2 kHz d)
[    20.361] (II) modeset(0): Modeline "1920x1080"x59.9  138.50  1920 1968 =
2000 2080  1080 1083 1088 1111 +hsync -vsync (66.6 kHz d)
[    20.361] (II) modeset(0): Modeline "1680x1050"x60.0  146.25  1680 1784 =
1960 2240  1050 1053 1059 1089 -hsync +vsync (65.3 kHz d)
[    20.361] (II) modeset(0): Modeline "1680x1050"x60.0  138.78  1680 1968 =
2000 2080  1050 1090 1096 1112 -hsync -vsync (66.7 kHz e)
[    20.361] (II) modeset(0): Modeline "1680x1050"x59.9  119.00  1680 1728 =
1760 1840  1050 1053 1059 1080 +hsync -vsync (64.7 kHz d)
[    20.361] (II) modeset(0): Modeline "1400x1050"x60.0  122.00  1400 1488 =
1640 1880  1050 1052 1064 1082 +hsync +vsync (64.9 kHz d)
[    20.361] (II) modeset(0): Modeline "1600x900"x120.0  246.00  1600 1728 =
1900 2200  900 901 904 932 doublescan -hsync +vsync (111.8 kHz d)
[    20.361] (II) modeset(0): Modeline "1600x900"x119.9  186.50  1600 1624 =
1640 1680  900 901 904 926 doublescan +hsync -vsync (111.0 kHz d)
[    20.361] (II) modeset(0): Modeline "1600x900"x59.9  118.25  1600 1696 1=
856 2112  900 903 908 934 -hsync +vsync (56.0 kHz d)
[    20.361] (II) modeset(0): Modeline "1600x900"x59.8   97.50  1600 1648 1=
680 1760  900 903 908 926 +hsync -vsync (55.4 kHz d)
[    20.361] (II) modeset(0): Modeline "1280x1024"x60.0  138.78  1280 1968 =
2000 2080  1024 1090 1096 1112 -hsync -vsync (66.7 kHz e)
[    20.361] (II) modeset(0): Modeline "1280x1024"x60.0  108.00  1280 1328 =
1440 1688  1024 1025 1028 1066 +hsync +vsync (64.0 kHz d)
[    20.361] (II) modeset(0): Modeline "1440x900"x60.0  138.78  1440 1968 2=
000 2080  900 1090 1096 1112 -hsync -vsync (66.7 kHz e)
[    20.361] (II) modeset(0): Modeline "1400x900"x60.0  103.50  1400 1480 1=
624 1848  900 903 913 934 -hsync +vsync (56.0 kHz d)
[    20.361] (II) modeset(0): Modeline "1400x900"x59.9   86.50  1400 1448 1=
480 1560  900 903 913 926 +hsync -vsync (55.4 kHz d)
[    20.361] (II) modeset(0): Modeline "1280x960"x60.0  108.00  1280 1376 1=
488 1800  960 961 964 1000 +hsync +vsync (60.0 kHz d)
[    20.361] (II) modeset(0): Modeline "1440x810"x120.0  198.12  1440 1548 =
1704 1968  810 811 814 839 doublescan -hsync +vsync (100.7 kHz d)
[    20.361] (II) modeset(0): Modeline "1440x810"x119.9  151.88  1440 1464 =
1480 1520  810 811 814 833 doublescan +hsync -vsync (99.9 kHz d)
[    20.361] (II) modeset(0): Modeline "1368x768"x59.9   85.25  1368 1440 1=
576 1784  768 771 781 798 -hsync +vsync (47.8 kHz d)
[    20.361] (II) modeset(0): Modeline "1368x768"x59.9   72.25  1368 1416 1=
448 1528  768 771 781 790 +hsync -vsync (47.3 kHz d)
[    20.361] (II) modeset(0): Modeline "1280x800"x120.0  174.25  1280 1380 =
1516 1752  800 801 804 829 doublescan -hsync +vsync (99.5 kHz d)
[    20.361] (II) modeset(0): Modeline "1280x800"x60.0  138.78  1280 1968 2=
000 2080  800 1090 1096 1112 -hsync -vsync (66.7 kHz e)
[    20.361] (II) modeset(0): Modeline "1280x800"x119.9  134.25  1280 1304 =
1320 1360  800 801 804 823 doublescan +hsync -vsync (98.7 kHz d)
[    20.361] (II) modeset(0): Modeline "1280x800"x59.8   83.50  1280 1352 1=
480 1680  800 803 809 831 -hsync +vsync (49.7 kHz d)
[    20.361] (II) modeset(0): Modeline "1280x800"x59.9   71.00  1280 1328 1=
360 1440  800 803 809 823 +hsync -vsync (49.3 kHz d)
[    20.361] (II) modeset(0): Modeline "1280x720"x120.0  156.12  1280 1376 =
1512 1744  720 721 724 746 doublescan -hsync +vsync (89.5 kHz d)
[    20.361] (II) modeset(0): Modeline "1280x720"x60.0  138.78  1280 1968 2=
000 2080  720 1090 1096 1112 -hsync -vsync (66.7 kHz e)
[    20.361] (II) modeset(0): Modeline "1280x720"x120.0  120.75  1280 1304 =
1320 1360  720 721 724 740 doublescan +hsync -vsync (88.8 kHz d)
[    20.361] (II) modeset(0): Modeline "1280x720"x59.9   74.50  1280 1344 1=
472 1664  720 723 728 748 -hsync +vsync (44.8 kHz d)
[    20.361] (II) modeset(0): Modeline "1280x720"x59.7   63.75  1280 1328 1=
360 1440  720 723 728 741 +hsync -vsync (44.3 kHz d)
[    20.361] (II) modeset(0): Modeline "1024x768"x60.0  138.78  1024 1968 2=
000 2080  768 1090 1096 1112 -hsync -vsync (66.7 kHz e)
[    20.361] (II) modeset(0): Modeline "1024x768"x120.1  133.47  1024 1100 =
1212 1400  768 768 770 794 doublescan -hsync +vsync (95.3 kHz d)
[    20.361] (II) modeset(0): Modeline "1024x768"x60.0   65.00  1024 1048 1=
184 1344  768 771 777 806 -hsync -vsync (48.4 kHz d)
[    20.361] (II) modeset(0): Modeline "960x720"x120.0  117.00  960 1024 11=
28 1300  720 720 722 750 doublescan -hsync +vsync (90.0 kHz d)
[    20.361] (II) modeset(0): Modeline "928x696"x120.1  109.15  928 976 108=
8 1264  696 696 698 719 doublescan -hsync +vsync (86.4 kHz d)
[    20.361] (II) modeset(0): Modeline "896x672"x120.0  102.40  896 960 106=
0 1224  672 672 674 697 doublescan -hsync +vsync (83.7 kHz d)
[    20.361] (II) modeset(0): Modeline "1024x576"x119.9   98.50  1024 1092 =
1200 1376  576 577 580 597 doublescan -hsync +vsync (71.6 kHz d)
[    20.361] (II) modeset(0): Modeline "1024x576"x119.9   78.38  1024 1048 =
1064 1104  576 577 580 592 doublescan +hsync -vsync (71.0 kHz d)
[    20.361] (II) modeset(0): Modeline "1024x576"x59.9   46.50  1024 1064 1=
160 1296  576 579 584 599 -hsync +vsync (35.9 kHz d)
[    20.361] (II) modeset(0): Modeline "1024x576"x59.8   42.00  1024 1072 1=
104 1184  576 579 584 593 +hsync -vsync (35.5 kHz d)
[    20.361] (II) modeset(0): Modeline "960x600"x119.9   96.62  960 1028 11=
28 1296  600 601 604 622 doublescan -hsync +vsync (74.6 kHz d)
[    20.361] (II) modeset(0): Modeline "960x600"x120.0   77.00  960 984 100=
0 1040  600 601 604 617 doublescan +hsync -vsync (74.0 kHz d)
[    20.361] (II) modeset(0): Modeline "960x540"x119.9   86.50  960 1024 11=
24 1288  540 541 544 560 doublescan -hsync +vsync (67.2 kHz d)
[    20.361] (II) modeset(0): Modeline "960x540"x120.0   69.25  960 984 100=
0 1040  540 541 544 555 doublescan +hsync -vsync (66.6 kHz d)
[    20.361] (II) modeset(0): Modeline "960x540"x59.6   40.75  960 992 1088=
 1216  540 543 548 562 -hsync +vsync (33.5 kHz d)
[    20.361] (II) modeset(0): Modeline "960x540"x59.8   37.25  960 1008 104=
0 1120  540 543 548 556 +hsync -vsync (33.3 kHz d)
[    20.361] (II) modeset(0): Modeline "800x600"x60.0  138.78  800 1968 200=
0 2080  600 1090 1096 1112 -hsync -vsync (66.7 kHz e)
[    20.362] (II) modeset(0): Modeline "800x600"x120.0   81.00  800 832 928=
 1080  600 600 602 625 doublescan +hsync +vsync (75.0 kHz d)
[    20.362] (II) modeset(0): Modeline "800x600"x60.3   40.00  800 840 968 =
1056  600 601 605 628 +hsync +vsync (37.9 kHz d)
[    20.362] (II) modeset(0): Modeline "800x600"x56.2   36.00  800 824 896 =
1024  600 601 603 625 +hsync +vsync (35.2 kHz d)
[    20.362] (II) modeset(0): Modeline "840x525"x120.0   73.12  840 892 980=
 1120  525 526 529 544 doublescan -hsync +vsync (65.3 kHz d)
[    20.362] (II) modeset(0): Modeline "840x525"x119.8   59.50  840 864 880=
 920  525 526 529 540 doublescan +hsync -vsync (64.7 kHz d)
[    20.362] (II) modeset(0): Modeline "864x486"x59.9   32.50  864 888 968 =
1072  486 489 494 506 -hsync +vsync (30.3 kHz d)
[    20.362] (II) modeset(0): Modeline "864x486"x59.6   30.50  864 912 944 =
1024  486 489 494 500 +hsync -vsync (29.8 kHz d)
[    20.362] (II) modeset(0): Modeline "700x525"x120.0   61.00  700 744 820=
 940  525 526 532 541 doublescan +hsync +vsync (64.9 kHz d)
[    20.362] (II) modeset(0): Modeline "800x450"x119.9   59.12  800 848 928=
 1056  450 451 454 467 doublescan -hsync +vsync (56.0 kHz d)
[    20.362] (II) modeset(0): Modeline "800x450"x119.6   48.75  800 824 840=
 880  450 451 454 463 doublescan +hsync -vsync (55.4 kHz d)
[    20.362] (II) modeset(0): Modeline "640x512"x120.0   54.00  640 664 720=
 844  512 512 514 533 doublescan +hsync +vsync (64.0 kHz d)
[    20.362] (II) modeset(0): Modeline "700x450"x119.9   51.75  700 740 812=
 924  450 451 456 467 doublescan -hsync +vsync (56.0 kHz d)
[    20.362] (II) modeset(0): Modeline "700x450"x119.8   43.25  700 724 740=
 780  450 451 456 463 doublescan +hsync -vsync (55.4 kHz d)
[    20.362] (II) modeset(0): Modeline "640x480"x60.0  138.78  640 1968 200=
0 2080  480 1090 1096 1112 -hsync -vsync (66.7 kHz e)
[    20.362] (II) modeset(0): Modeline "640x480"x120.0   54.00  640 688 744=
 900  480 480 482 500 doublescan +hsync +vsync (60.0 kHz d)
[    20.362] (II) modeset(0): Modeline "640x480"x59.9   25.18  640 656 752 =
800  480 490 492 525 -hsync -vsync (31.5 kHz d)
[    20.362] (II) modeset(0): Modeline "720x405"x59.5   22.50  720 744 808 =
896  405 408 413 422 -hsync +vsync (25.1 kHz d)
[    20.362] (II) modeset(0): Modeline "720x405"x59.0   21.75  720 768 800 =
880  405 408 413 419 +hsync -vsync (24.7 kHz d)
[    20.362] (II) modeset(0): Modeline "684x384"x119.8   42.62  684 720 788=
 892  384 385 390 399 doublescan -hsync +vsync (47.8 kHz d)
[    20.362] (II) modeset(0): Modeline "684x384"x119.7   36.12  684 708 724=
 764  384 385 390 395 doublescan +hsync -vsync (47.3 kHz d)
[    20.362] (II) modeset(0): Modeline "640x400"x119.8   41.75  640 676 740=
 840  400 401 404 415 doublescan -hsync +vsync (49.7 kHz d)
[    20.362] (II) modeset(0): Modeline "640x400"x120.0   35.50  640 664 680=
 720  400 401 404 411 doublescan +hsync -vsync (49.3 kHz d)
[    20.362] (II) modeset(0): Modeline "640x360"x119.7   37.25  640 672 736=
 832  360 361 364 374 doublescan -hsync +vsync (44.8 kHz d)
[    20.362] (II) modeset(0): Modeline "640x360"x119.7   31.88  640 664 680=
 720  360 361 364 370 doublescan +hsync -vsync (44.3 kHz d)
[    20.362] (II) modeset(0): Modeline "640x360"x59.8   18.00  640 664 720 =
800  360 363 368 376 -hsync +vsync (22.5 kHz d)
[    20.362] (II) modeset(0): Modeline "640x360"x59.3   17.75  640 688 720 =
800  360 363 368 374 +hsync -vsync (22.2 kHz d)
[    20.362] (II) modeset(0): Modeline "512x384"x120.0   32.50  512 524 592=
 672  384 385 388 403 doublescan -hsync -vsync (48.4 kHz d)
[    20.362] (II) modeset(0): Modeline "512x288"x120.0   23.25  512 532 580=
 648  288 289 292 299 doublescan -hsync +vsync (35.9 kHz d)
[    20.362] (II) modeset(0): Modeline "512x288"x119.8   21.00  512 536 552=
 592  288 289 292 296 doublescan +hsync -vsync (35.5 kHz d)
[    20.362] (II) modeset(0): Modeline "480x270"x119.3   20.38  480 496 544=
 608  270 271 274 281 doublescan -hsync +vsync (33.5 kHz d)
[    20.362] (II) modeset(0): Modeline "480x270"x119.6   18.62  480 504 520=
 560  270 271 274 278 doublescan +hsync -vsync (33.3 kHz d)
[    20.362] (II) modeset(0): Modeline "400x300"x120.6   20.00  400 420 484=
 528  300 300 302 314 doublescan +hsync +vsync (37.9 kHz d)
[    20.362] (II) modeset(0): Modeline "400x300"x112.7   18.00  400 412 448=
 512  300 300 301 312 doublescan +hsync +vsync (35.2 kHz d)
[    20.362] (II) modeset(0): Modeline "432x243"x119.8   16.25  432 444 484=
 536  243 244 247 253 doublescan -hsync +vsync (30.3 kHz d)
[    20.362] (II) modeset(0): Modeline "432x243"x119.1   15.25  432 456 472=
 512  243 244 247 250 doublescan +hsync -vsync (29.8 kHz d)
[    20.362] (II) modeset(0): Modeline "320x240"x120.1   12.59  320 328 376=
 400  240 245 246 262 doublescan -hsync -vsync (31.5 kHz d)
[    20.362] (II) modeset(0): Modeline "360x202"x119.0   11.25  360 372 404=
 448  202 204 206 211 doublescan -hsync +vsync (25.1 kHz d)
[    20.362] (II) modeset(0): Modeline "360x202"x118.3   10.88  360 384 400=
 440  202 204 206 209 doublescan +hsync -vsync (24.7 kHz d)
[    20.362] (II) modeset(0): Modeline "320x180"x119.7    9.00  320 332 360=
 400  180 181 184 188 doublescan -hsync +vsync (22.5 kHz d)
[    20.362] (II) modeset(0): Modeline "320x180"x118.6    8.88  320 344 360=
 400  180 181 184 187 doublescan +hsync -vsync (22.2 kHz d)
[    20.362] (II) modeset(0): EDID for output HDMI-1
[    20.362] (II) modeset(0): EDID for output DP-1
[    20.362] (II) modeset(0): Output eDP-1 connected
[    20.362] (II) modeset(0): Output HDMI-1 disconnected
[    20.362] (II) modeset(0): Output DP-1 disconnected
[    20.362] (II) modeset(0): Using exact sizes for initial modes
[    20.362] (II) modeset(0): Output eDP-1 using initial mode 1920x1080 +0+0
[    20.362] (=3D=3D) modeset(0): Using gamma correction (1.0, 1.0, 1.0)
[    20.362] (=3D=3D) modeset(0): DPI set to (96, 96)
[    20.362] (II) Loading sub module "fb"
[    20.362] (II) LoadModule: "fb"
[    20.362] (II) Module "fb" already built-in
[    20.466] (=3D=3D) modeset(0): Backing store enabled
[    20.466] (=3D=3D) modeset(0): Silken mouse enabled
[    20.467] (II) modeset(0): Initializing kms color map for depth 24, 8 bp=
c.
[    20.468] (=3D=3D) modeset(0): DPMS enabled
[    20.468] (II) modeset(0): [DRI2] Setup complete
[    20.468] (II) modeset(0): [DRI2]   DRI driver: radeonsi
[    20.468] (II) modeset(0): [DRI2]   VDPAU driver: radeonsi
[    20.468] (II) Initializing extension Generic Event Extension
[    20.468] (II) Initializing extension SHAPE
[    20.468] (II) Initializing extension MIT-SHM
[    20.468] (II) Initializing extension XInputExtension
[    20.468] (II) Initializing extension XTEST
[    20.468] (II) Initializing extension BIG-REQUESTS
[    20.468] (II) Initializing extension SYNC
[    20.468] (II) Initializing extension XKEYBOARD
[    20.469] (II) Initializing extension XC-MISC
[    20.469] (II) Initializing extension SECURITY
[    20.469] (II) Initializing extension XFIXES
[    20.469] (II) Initializing extension RENDER
[    20.469] (II) Initializing extension RANDR
[    20.469] (II) Initializing extension COMPOSITE
[    20.469] (II) Initializing extension DAMAGE
[    20.469] (II) Initializing extension MIT-SCREEN-SAVER
[    20.469] (II) Initializing extension DOUBLE-BUFFER
[    20.470] (II) Initializing extension RECORD
[    20.470] (II) Initializing extension DPMS
[    20.470] (II) Initializing extension Present
[    20.470] (II) Initializing extension DRI3
[    20.470] (II) Initializing extension X-Resource
[    20.470] (II) Initializing extension XVideo
[    20.470] (II) Initializing extension XVideo-MotionCompensation
[    20.470] (II) Initializing extension GLX
[    20.480] (II) AIGLX: Loaded and initialized radeonsi
[    20.480] (II) GLX: Initialized DRI2 GL provider for screen 0
[    20.480] (II) Initializing extension XFree86-VidModeExtension
[    20.480] (II) Initializing extension XFree86-DGA
[    20.481] (II) Initializing extension XFree86-DRI
[    20.481] (II) Initializing extension DRI2
[    20.481] (II) modeset(0): Damage tracking initialized
[    20.481] (II) modeset(0): Setting screen physical size to 508 x 285
[    20.571] (II) config/udev: Adding input device Power Button (/dev/input=
/event3)
[    20.571] (**) Power Button: Applying InputClass "libinput keyboard catc=
hall"
[    20.571] (**) Power Button: Applying InputClass "system-keyboard"
[    20.571] (II) LoadModule: "libinput"
[    20.571] (II) Loading /usr/lib/xorg/modules/input/libinput_drv.so
[    20.578] (II) Module libinput: vendor=3D"X.Org Foundation"
[    20.578] 	compiled for 1.21.1.13, module version =3D 1.5.0
[    20.578] 	Module class: X.Org XInput Driver
[    20.578] 	ABI class: X.Org XInput driver, version 24.4
[    20.578] (II) Using input driver 'libinput' for 'Power Button'
[    20.579] (II) systemd-logind: got fd for /dev/input/event3 13:67 fd 24 =
paused 0
[    20.579] (**) Power Button: always reports core events
[    20.579] (**) Option "Device" "/dev/input/event3"
[    20.587] (II) event3  - Power Button: is tagged by udev as: Keyboard
[    20.587] (II) event3  - Power Button: device is a keyboard
[    20.587] (II) event3  - Power Button: device removed
[    20.587] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNXPW=
RBN:00/input/input3/event3"
[    20.587] (II) XINPUT: Adding extended input device "Power Button" (type=
: KEYBOARD, id 6)
[    20.587] (**) Option "xkb_layout" "de"
[    20.615] (II) event3  - Power Button: is tagged by udev as: Keyboard
[    20.615] (II) event3  - Power Button: device is a keyboard
[    20.616] (II) config/udev: Adding input device Video Bus (/dev/input/ev=
ent5)
[    20.616] (**) Video Bus: Applying InputClass "libinput keyboard catchal=
l"
[    20.617] (**) Video Bus: Applying InputClass "system-keyboard"
[    20.617] (II) Using input driver 'libinput' for 'Video Bus'
[    20.618] (II) systemd-logind: got fd for /dev/input/event5 13:69 fd 27 =
paused 0
[    20.618] (**) Video Bus: always reports core events
[    20.618] (**) Option "Device" "/dev/input/event5"
[    20.619] (II) event5  - Video Bus: is tagged by udev as: Keyboard
[    20.619] (II) event5  - Video Bus: device is a keyboard
[    20.619] (II) event5  - Video Bus: device removed
[    20.619] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNXSY=
BUS:00/PNP0A08:00/device:0a/LNXVIDEO:00/input/input6/event5"
[    20.619] (II) XINPUT: Adding extended input device "Video Bus" (type: K=
EYBOARD, id 7)
[    20.619] (**) Option "xkb_layout" "de"
[    20.621] (II) event5  - Video Bus: is tagged by udev as: Keyboard
[    20.621] (II) event5  - Video Bus: device is a keyboard
[    20.621] (II) config/udev: Adding input device Power Button (/dev/input=
/event0)
[    20.621] (**) Power Button: Applying InputClass "libinput keyboard catc=
hall"
[    20.621] (**) Power Button: Applying InputClass "system-keyboard"
[    20.621] (II) Using input driver 'libinput' for 'Power Button'
[    20.622] (II) systemd-logind: got fd for /dev/input/event0 13:64 fd 28 =
paused 0
[    20.622] (**) Power Button: always reports core events
[    20.622] (**) Option "Device" "/dev/input/event0"
[    20.624] (II) event0  - Power Button: is tagged by udev as: Keyboard
[    20.624] (II) event0  - Power Button: device is a keyboard
[    20.624] (II) event0  - Power Button: device removed
[    20.624] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNXSY=
BUS:00/PNP0C0C:00/input/input0/event0"
[    20.624] (II) XINPUT: Adding extended input device "Power Button" (type=
: KEYBOARD, id 8)
[    20.624] (**) Option "xkb_layout" "de"
[    20.625] (II) event0  - Power Button: is tagged by udev as: Keyboard
[    20.625] (II) event0  - Power Button: device is a keyboard
[    20.626] (II) config/udev: Adding input device Lid Switch (/dev/input/e=
vent1)
[    20.626] (II) No input driver specified, ignoring this device.
[    20.626] (II) This device may have been added with another device file.
[    20.626] (II) config/udev: Adding input device Sleep Button (/dev/input=
/event2)
[    20.626] (**) Sleep Button: Applying InputClass "libinput keyboard catc=
hall"
[    20.626] (**) Sleep Button: Applying InputClass "system-keyboard"
[    20.626] (II) Using input driver 'libinput' for 'Sleep Button'
[    20.628] (II) systemd-logind: got fd for /dev/input/event2 13:66 fd 29 =
paused 0
[    20.628] (**) Sleep Button: always reports core events
[    20.628] (**) Option "Device" "/dev/input/event2"
[    20.628] (II) event2  - Sleep Button: is tagged by udev as: Keyboard
[    20.629] (II) event2  - Sleep Button: device is a keyboard
[    20.629] (II) event2  - Sleep Button: device removed
[    20.629] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNXSY=
BUS:00/PNP0C0E:00/input/input2/event2"
[    20.629] (II) XINPUT: Adding extended input device "Sleep Button" (type=
: KEYBOARD, id 9)
[    20.629] (**) Option "xkb_layout" "de"
[    20.630] (II) event2  - Sleep Button: is tagged by udev as: Keyboard
[    20.630] (II) event2  - Sleep Button: device is a keyboard
[    20.631] (II) config/udev: Adding input device HD-Audio Generic HDMI/DP=
,pcm=3D7 (/dev/input/event8)
[    20.631] (II) No input driver specified, ignoring this device.
[    20.631] (II) This device may have been added with another device file.
[    20.631] (II) config/udev: Adding input device HD-Audio Generic HDMI/DP=
,pcm=3D8 (/dev/input/event9)
[    20.631] (II) No input driver specified, ignoring this device.
[    20.631] (II) This device may have been added with another device file.
[    20.632] (II) config/udev: Adding input device HD-Audio Generic HDMI/DP=
,pcm=3D3 (/dev/input/event7)
[    20.632] (II) No input driver specified, ignoring this device.
[    20.632] (II) This device may have been added with another device file.
[    20.632] (II) config/udev: Adding input device HD-Audio Generic Mic (/d=
ev/input/event10)
[    20.632] (II) No input driver specified, ignoring this device.
[    20.632] (II) This device may have been added with another device file.
[    20.633] (II) config/udev: Adding input device HD-Audio Generic Headpho=
ne (/dev/input/event11)
[    20.633] (II) No input driver specified, ignoring this device.
[    20.633] (II) This device may have been added with another device file.
[    20.633] (II) config/udev: Adding input device AT Translated Set 2 keyb=
oard (/dev/input/event4)
[    20.633] (**) AT Translated Set 2 keyboard: Applying InputClass "libinp=
ut keyboard catchall"
[    20.633] (**) AT Translated Set 2 keyboard: Applying InputClass "system=
-keyboard"
[    20.633] (II) Using input driver 'libinput' for 'AT Translated Set 2 ke=
yboard'
[    20.635] (II) systemd-logind: got fd for /dev/input/event4 13:68 fd 30 =
paused 0
[    20.635] (**) AT Translated Set 2 keyboard: always reports core events
[    20.635] (**) Option "Device" "/dev/input/event4"
[    20.636] (II) event4  - AT Translated Set 2 keyboard: is tagged by udev=
 as: Keyboard
[    20.636] (II) event4  - AT Translated Set 2 keyboard: device is a keybo=
ard
[    20.636] (II) event4  - AT Translated Set 2 keyboard: device removed
[    20.636] (**) Option "config_info" "udev:/sys/devices/platform/i8042/se=
rio0/input/input4/event4"
[    20.636] (II) XINPUT: Adding extended input device "AT Translated Set 2=
 keyboard" (type: KEYBOARD, id 10)
[    20.636] (**) Option "xkb_layout" "de"
[    20.638] (II) event4  - AT Translated Set 2 keyboard: is tagged by udev=
 as: Keyboard
[    20.638] (II) event4  - AT Translated Set 2 keyboard: device is a keybo=
ard
[    20.639] (II) config/udev: Adding input device ETPS/2 Elantech TrackPoi=
nt (/dev/input/event12)
[    20.639] (**) ETPS/2 Elantech TrackPoint: Applying InputClass "libinput=
 pointer catchall"
[    20.639] (II) Using input driver 'libinput' for 'ETPS/2 Elantech TrackP=
oint'
[    20.640] (II) systemd-logind: got fd for /dev/input/event12 13:76 fd 31=
 paused 0
[    20.640] (**) ETPS/2 Elantech TrackPoint: always reports core events
[    20.640] (**) Option "Device" "/dev/input/event12"
[    20.641] (II) event12 - ETPS/2 Elantech TrackPoint: is tagged by udev a=
s: Mouse Pointingstick
[    20.641] (II) event12 - ETPS/2 Elantech TrackPoint: device is a pointer
[    20.642] (II) event12 - ETPS/2 Elantech TrackPoint: device removed
[    20.642] (II) libinput: ETPS/2 Elantech TrackPoint: Step value 0 was pr=
ovided, libinput Fallback acceleration function is used.
[    20.642] (II) libinput: ETPS/2 Elantech TrackPoint: Step value 0 was pr=
ovided, libinput Fallback acceleration function is used.
[    20.642] (II) libinput: ETPS/2 Elantech TrackPoint: Step value 0 was pr=
ovided, libinput Fallback acceleration function is used.
[    20.642] (**) Option "config_info" "udev:/sys/devices/platform/i8042/se=
rio1/input/input14/event12"
[    20.642] (II) XINPUT: Adding extended input device "ETPS/2 Elantech Tra=
ckPoint" (type: MOUSE, id 11)
[    20.642] (**) Option "AccelerationScheme" "none"
[    20.642] (**) ETPS/2 Elantech TrackPoint: (accel) selected scheme none/0
[    20.642] (**) ETPS/2 Elantech TrackPoint: (accel) acceleration factor: =
2.000
[    20.642] (**) ETPS/2 Elantech TrackPoint: (accel) acceleration threshol=
d: 4
[    20.643] (II) event12 - ETPS/2 Elantech TrackPoint: is tagged by udev a=
s: Mouse Pointingstick
[    20.644] (II) event12 - ETPS/2 Elantech TrackPoint: device is a pointer
[    20.645] (II) config/udev: Adding input device ETPS/2 Elantech TrackPoi=
nt (/dev/input/mouse0)
[    20.645] (II) No input driver specified, ignoring this device.
[    20.645] (II) This device may have been added with another device file.
[    20.645] (II) config/udev: Adding input device ETPS/2 Elantech Touchpad=
 (/dev/input/event13)
[    20.645] (**) ETPS/2 Elantech Touchpad: Applying InputClass "libinput t=
ouchpad catchall"
[    20.645] (II) Using input driver 'libinput' for 'ETPS/2 Elantech Touchp=
ad'
[    20.646] (II) systemd-logind: got fd for /dev/input/event13 13:77 fd 32=
 paused 0
[    20.646] (**) ETPS/2 Elantech Touchpad: always reports core events
[    20.647] (**) Option "Device" "/dev/input/event13"
[    20.648] (II) event13 - ETPS/2 Elantech Touchpad: is tagged by udev as:=
 Touchpad
[    20.649] (II) event13 - ETPS/2 Elantech Touchpad: device is a touchpad
[    20.650] (II) event13 - ETPS/2 Elantech Touchpad: device removed
[    20.650] (II) libinput: ETPS/2 Elantech Touchpad: Step value 0 was prov=
ided, libinput Fallback acceleration function is used.
[    20.650] (II) libinput: ETPS/2 Elantech Touchpad: Step value 0 was prov=
ided, libinput Fallback acceleration function is used.
[    20.650] (II) libinput: ETPS/2 Elantech Touchpad: Step value 0 was prov=
ided, libinput Fallback acceleration function is used.
[    20.650] (**) Option "config_info" "udev:/sys/devices/platform/i8042/se=
rio1/input/input8/event13"
[    20.650] (II) XINPUT: Adding extended input device "ETPS/2 Elantech Tou=
chpad" (type: TOUCHPAD, id 12)
[    20.651] (**) Option "AccelerationScheme" "none"
[    20.652] (**) ETPS/2 Elantech Touchpad: (accel) selected scheme none/0
[    20.652] (**) ETPS/2 Elantech Touchpad: (accel) acceleration factor: 2.=
000
[    20.652] (**) ETPS/2 Elantech Touchpad: (accel) acceleration threshold:=
 4
[    20.652] (II) event13 - ETPS/2 Elantech Touchpad: is tagged by udev as:=
 Touchpad
[    20.654] (II) event13 - ETPS/2 Elantech Touchpad: device is a touchpad
[    20.655] (II) config/udev: Adding input device ETPS/2 Elantech Touchpad=
 (/dev/input/mouse1)
[    20.655] (II) No input driver specified, ignoring this device.
[    20.655] (II) This device may have been added with another device file.
[    20.659] (II) config/udev: Adding input device ThinkPad Extra Buttons (=
/dev/input/event6)
[    20.659] (**) ThinkPad Extra Buttons: Applying InputClass "libinput key=
board catchall"
[    20.659] (**) ThinkPad Extra Buttons: Applying InputClass "system-keybo=
ard"
[    20.659] (II) Using input driver 'libinput' for 'ThinkPad Extra Buttons'
[    20.660] (II) systemd-logind: got fd for /dev/input/event6 13:70 fd 33 =
paused 0
[    20.660] (**) ThinkPad Extra Buttons: always reports core events
[    20.660] (**) Option "Device" "/dev/input/event6"
[    20.661] (II) event6  - ThinkPad Extra Buttons: is tagged by udev as: K=
eyboard Switch
[    20.661] (II) event6  - ThinkPad Extra Buttons: device is a keyboard
[    20.661] (II) event6  - ThinkPad Extra Buttons: device removed
[    20.661] (**) Option "config_info" "udev:/sys/devices/platform/thinkpad=
_acpi/input/input7/event6"
[    20.661] (II) XINPUT: Adding extended input device "ThinkPad Extra Butt=
ons" (type: KEYBOARD, id 13)
[    20.661] (**) Option "xkb_layout" "de"
[    20.662] (II) event6  - ThinkPad Extra Buttons: is tagged by udev as: K=
eyboard Switch
[    20.662] (II) event6  - ThinkPad Extra Buttons: device is a keyboard
[    20.670] (II) modeset(0): Disabling kernel dirty updates, not required.
[    36.544] (EE) modeset(0): Failed to set CTM property: -13
[    36.544] (EE) modeset(0): Failed to set CTM property: -13
[    36.544] (II) modeset(0): EDID vendor "LEN", prod id 16553
[    36.544] (II) modeset(0): Printing DDC gathered Modelines:
[    36.544] (II) modeset(0): Modeline "1920x1080"x0.0  138.78  1920 1968 2=
000 2080  1080 1090 1096 1112 -hsync -vsync (66.7 kHz eP)
[    36.547] (EE) modeset(0): Failed to set CTM property: -13
[    36.547] (EE) modeset(0): Failed to set CTM property: -13
[    36.547] (II) modeset(0): EDID vendor "LEN", prod id 16553
[    36.547] (II) modeset(0): Printing DDC gathered Modelines:
[    36.547] (II) modeset(0): Modeline "1920x1080"x0.0  138.78  1920 1968 2=
000 2080  1080 1090 1096 1112 -hsync -vsync (66.7 kHz eP)
[    36.897] (WW) modeset(0): Present-unflip: queue flip during flip on CRT=
C 0 failed: Permission denied
[    37.196] (EE) modeset(0): Failed to set CTM property: -13
[    37.196] (EE) modeset(0): failed to set mode: No such file or directory
[    39.549] (**) Option "fd" "24"
[    39.549] (II) event3  - Power Button: device removed
[    39.550] (**) Option "fd" "27"
[    39.550] (II) event5  - Video Bus: device removed
[    39.550] (**) Option "fd" "28"
[    39.550] (II) event0  - Power Button: device removed
[    39.550] (**) Option "fd" "29"
[    39.550] (II) event2  - Sleep Button: device removed
[    39.550] (**) Option "fd" "30"
[    39.550] (II) event4  - AT Translated Set 2 keyboard: device removed
[    39.550] (**) Option "fd" "31"
[    39.550] (II) event12 - ETPS/2 Elantech TrackPoint: device removed
[    39.550] (**) Option "fd" "32"
[    39.550] (II) event13 - ETPS/2 Elantech Touchpad: device removed
[    39.551] (**) Option "fd" "33"
[    39.551] (II) event6  - ThinkPad Extra Buttons: device removed
[    39.551] (II) AIGLX: Suspending AIGLX clients for VT switch
[    39.551] (EE) systemd-logind: failed to ack pause: Device not taken
[    39.860] (II) systemd-logind: got pause for 13:68
[    39.860] (II) systemd-logind: got pause for 13:70
[    39.860] (II) systemd-logind: got pause for 13:67
[    39.861] (II) systemd-logind: got pause for 13:64
[    39.861] (II) systemd-logind: got pause for 13:66
[    39.861] (II) systemd-logind: got pause for 13:77
[    39.861] (II) systemd-logind: got pause for 13:69
[    39.861] (II) systemd-logind: got pause for 13:76

--ofsj7hvjgjxpsigb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg_6.16rc1.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.16.0-rc1-1-mainline (linux-mainline@archlinu=
x) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU Binutils) 2.44.0) #1 SMP PREEMPT=
_DYNAMIC Mon, 09 Jun 2025 11:55:49 +0000
[    0.000000] Command line: initrd=3D\initramfs-linux-mainline.img cryptde=
vice=3DUUID=3D8913bf3e-3df0-478e-b072-f7bec731154b:archlinux root=3D/dev/ma=
pper/archlinux rootflags=3Dsubvol=3D@ rw loglevel=3D4 drm.panic_screen=3Dqr=
_code
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009bfffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009c00000-0x0000000009da0fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000009da1000-0x0000000009efffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f0efff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000009f0f000-0x00000000c4b7dfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c4b7e000-0x00000000cad7dfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000cad7e000-0x00000000cc17dfff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000cc17e000-0x00000000cc1fdfff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000cc1fe000-0x00000000cdffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ce000000-0x00000000cfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fdc00000-0x00000000fdcfffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000003ee2fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000003ee300000-0x000000042fffffff] reser=
ved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.7 by Lenovo
[    0.000000] efi: ACPI=3D0xcc1fd000 ACPI 2.0=3D0xcc1fd014 SMBIOS=3D0xc7c6=
8000 SMBIOS 3.0=3D0xc7c5b000 TPMFinalLog=3D0xcb01e000 MEMATTR=3D0xc15c0018 =
ESRT=3D0xc323a018 RNG=3D0xcc1fcf18 INITRD=3D0x99b7bf18 TPMEventLog=3D0xcc1f=
1018=20
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem61: MMIO range=3D[0xfdc00000-0xfdcfffff] (1MB=
) from e820 map
[    0.000000] e820: remove [mem 0xfdc00000-0xfdcfffff] reserved
[    0.000000] efi: Not removing mem62: MMIO range=3D[0xfed80000-0xfed80fff=
] (4KB) from e820 map
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: LENOVO 20YDS00G00/20YDS00G00, BIOS R1OET26W (1.05 ) 04/=
28/2021
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2096.299 MHz processor
[    0.000012] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000014] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000020] last_pfn =3D 0x3ee300 max_arch_pfn =3D 0x400000000
[    0.000027] MTRR map: 6 entries (3 fixed + 3 variable; max 20), built fr=
om 9 variable MTRRs
[    0.000029] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.000350] last_pfn =3D 0xce000 max_arch_pfn =3D 0x400000000
[    0.004483] esrt: Reserving ESRT space from 0x00000000c323a018 to 0x0000=
0000c323a0c8.
[    0.004489] e820: update [mem 0xc323a000-0xc323afff] usable =3D=3D> rese=
rved
[    0.004503] Using GB pages for direct mapping
[    0.004836] Secure boot disabled
[    0.004838] RAMDISK: [mem 0x93880000-0x961ecfff]
[    0.005075] ACPI: Early table checksum verification disabled
[    0.005079] ACPI: RSDP 0x00000000CC1FD014 000024 (v02 LENOVO)
[    0.005082] ACPI: XSDT 0x00000000CC1FB188 0000FC (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005088] ACPI: FACP 0x00000000C5997000 000114 (v06 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005092] ACPI: DSDT 0x00000000C5982000 00F37E (v01 LENOVO TP-R1O   00=
001050 INTL 20180313)
[    0.005094] ACPI: FACS 0x00000000CB01A000 000040
[    0.005096] ACPI: SSDT 0x00000000C7C9B000 00094D (v01 LENOVO UsbCTabl 00=
000001 INTL 20180313)
[    0.005098] ACPI: SSDT 0x00000000C7C8E000 007229 (v02 LENOVO TP-R1O   00=
000002 MSFT 04000000)
[    0.005100] ACPI: IVRS 0x00000000C7C8D000 0001A4 (v02 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005103] ACPI: SSDT 0x00000000C7C3B000 000924 (v01 LENOVO WmiTable 00=
000001 INTL 20180313)
[    0.005105] ACPI: SSDT 0x00000000C7BB6000 000632 (v02 LENOVO Tpm2Tabl 00=
001000 INTL 20180313)
[    0.005107] ACPI: TPM2 0x00000000C7BB5000 000034 (v03 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005109] ACPI: POAT 0x00000000C7BB2000 000055 (v03 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005111] ACPI: BATB 0x00000000C7B9D000 00004A (v02 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005114] ACPI: HPET 0x00000000C5996000 000038 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005116] ACPI: APIC 0x00000000C5995000 000138 (v02 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005118] ACPI: MCFG 0x00000000C5994000 00003C (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005120] ACPI: SBST 0x00000000C5993000 000030 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005122] ACPI: WSMT 0x00000000C5992000 000028 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005124] ACPI: VFCT 0x00000000C5974000 00D884 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005126] ACPI: SSDT 0x00000000C5970000 003E88 (v02 LENOVO TP-R1O   00=
000001 AMD  00000001)
[    0.005129] ACPI: CRAT 0x00000000C596F000 000B80 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005131] ACPI: CDIT 0x00000000C596E000 000029 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005133] ACPI: FPDT 0x00000000C7B9E000 000034 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005135] ACPI: SSDT 0x00000000C596C000 000149 (v01 LENOVO TP-R1O   00=
000001 INTL 20180313)
[    0.005137] ACPI: SSDT 0x00000000C596A000 0014C3 (v01 LENOVO TP-R1O   00=
000001 INTL 20180313)
[    0.005139] ACPI: SSDT 0x00000000C5968000 0015A8 (v01 LENOVO TP-R1O   00=
000001 INTL 20180313)
[    0.005141] ACPI: SSDT 0x00000000C5964000 003979 (v01 LENOVO TP-R1O   00=
000001 INTL 20180313)
[    0.005143] ACPI: BGRT 0x00000000C5963000 000038 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005146] ACPI: UEFI 0x00000000CB019000 0000B2 (v01 LENOVO TP-R1O   00=
001050 PTEC 00000002)
[    0.005148] ACPI: SSDT 0x00000000C7C9A000 000090 (v01 LENOVO TP-R1O   00=
000001 INTL 20180313)
[    0.005150] ACPI: SSDT 0x00000000C7C99000 0009BD (v01 LENOVO TP-R1O   00=
000001 INTL 20180313)
[    0.005152] ACPI: Reserving FACP table memory at [mem 0xc5997000-0xc5997=
113]
[    0.005153] ACPI: Reserving DSDT table memory at [mem 0xc5982000-0xc5991=
37d]
[    0.005153] ACPI: Reserving FACS table memory at [mem 0xcb01a000-0xcb01a=
03f]
[    0.005154] ACPI: Reserving SSDT table memory at [mem 0xc7c9b000-0xc7c9b=
94c]
[    0.005155] ACPI: Reserving SSDT table memory at [mem 0xc7c8e000-0xc7c95=
228]
[    0.005155] ACPI: Reserving IVRS table memory at [mem 0xc7c8d000-0xc7c8d=
1a3]
[    0.005156] ACPI: Reserving SSDT table memory at [mem 0xc7c3b000-0xc7c3b=
923]
[    0.005156] ACPI: Reserving SSDT table memory at [mem 0xc7bb6000-0xc7bb6=
631]
[    0.005157] ACPI: Reserving TPM2 table memory at [mem 0xc7bb5000-0xc7bb5=
033]
[    0.005157] ACPI: Reserving POAT table memory at [mem 0xc7bb2000-0xc7bb2=
054]
[    0.005158] ACPI: Reserving BATB table memory at [mem 0xc7b9d000-0xc7b9d=
049]
[    0.005159] ACPI: Reserving HPET table memory at [mem 0xc5996000-0xc5996=
037]
[    0.005159] ACPI: Reserving APIC table memory at [mem 0xc5995000-0xc5995=
137]
[    0.005160] ACPI: Reserving MCFG table memory at [mem 0xc5994000-0xc5994=
03b]
[    0.005160] ACPI: Reserving SBST table memory at [mem 0xc5993000-0xc5993=
02f]
[    0.005161] ACPI: Reserving WSMT table memory at [mem 0xc5992000-0xc5992=
027]
[    0.005162] ACPI: Reserving VFCT table memory at [mem 0xc5974000-0xc5981=
883]
[    0.005162] ACPI: Reserving SSDT table memory at [mem 0xc5970000-0xc5973=
e87]
[    0.005163] ACPI: Reserving CRAT table memory at [mem 0xc596f000-0xc596f=
b7f]
[    0.005163] ACPI: Reserving CDIT table memory at [mem 0xc596e000-0xc596e=
028]
[    0.005164] ACPI: Reserving FPDT table memory at [mem 0xc7b9e000-0xc7b9e=
033]
[    0.005165] ACPI: Reserving SSDT table memory at [mem 0xc596c000-0xc596c=
148]
[    0.005165] ACPI: Reserving SSDT table memory at [mem 0xc596a000-0xc596b=
4c2]
[    0.005166] ACPI: Reserving SSDT table memory at [mem 0xc5968000-0xc5969=
5a7]
[    0.005167] ACPI: Reserving SSDT table memory at [mem 0xc5964000-0xc5967=
978]
[    0.005167] ACPI: Reserving BGRT table memory at [mem 0xc5963000-0xc5963=
037]
[    0.005168] ACPI: Reserving UEFI table memory at [mem 0xcb019000-0xcb019=
0b1]
[    0.005169] ACPI: Reserving SSDT table memory at [mem 0xc7c9a000-0xc7c9a=
08f]
[    0.005169] ACPI: Reserving SSDT table memory at [mem 0xc7c99000-0xc7c99=
9bc]
[    0.005227] No NUMA configuration found
[    0.005228] Faking a node at [mem 0x0000000000000000-0x00000003ee2fffff]
[    0.005235] NODE_DATA(0) allocated [mem 0x3ee2d5280-0x3ee2fffff]
[    0.005443] Zone ranges:
[    0.005444]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.005445]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.005446]   Normal   [mem 0x0000000100000000-0x00000003ee2fffff]
[    0.005447]   Device   empty
[    0.005448] Movable zone start for each node
[    0.005450] Early memory node ranges
[    0.005450]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.005451]   node   0: [mem 0x0000000000100000-0x0000000009bfffff]
[    0.005452]   node   0: [mem 0x0000000009da1000-0x0000000009efffff]
[    0.005453]   node   0: [mem 0x0000000009f0f000-0x00000000c4b7dfff]
[    0.005454]   node   0: [mem 0x00000000cc1fe000-0x00000000cdffffff]
[    0.005454]   node   0: [mem 0x0000000100000000-0x00000003ee2fffff]
[    0.005456] Initmem setup node 0 [mem 0x0000000000001000-0x00000003ee2ff=
fff]
[    0.005461] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.005477] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.005621] On node 0, zone DMA32: 417 pages in unavailable ranges
[    0.011742] On node 0, zone DMA32: 15 pages in unavailable ranges
[    0.012060] On node 0, zone DMA32: 30336 pages in unavailable ranges
[    0.037007] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.037073] On node 0, zone Normal: 7424 pages in unavailable ranges
[    0.037792] ACPI: PM-Timer IO Port: 0x408
[    0.037801] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.037802] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.037803] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.037803] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.037804] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.037804] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.037805] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.037805] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.037806] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.037807] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.037807] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.037808] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.037808] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.037809] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.037809] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.037810] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.037823] IOAPIC[0]: apic_id 32, version 33, address 0xfec00000, GSI 0=
-23
[    0.037828] IOAPIC[1]: apic_id 33, version 33, address 0xfec01000, GSI 2=
4-55
[    0.037830] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.037831] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.037835] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.037836] ACPI: HPET id: 0x43538210 base: 0xfed00000
[    0.037845] e820: update [mem 0xc0cdd000-0xc0d6dfff] usable =3D=3D> rese=
rved
[    0.037859] CPU topo: Max. logical packages:   1
[    0.037859] CPU topo: Max. logical dies:       1
[    0.037860] CPU topo: Max. dies per package:   1
[    0.037864] CPU topo: Max. threads per core:   2
[    0.037865] CPU topo: Num. cores per package:     6
[    0.037865] CPU topo: Num. threads per package:  12
[    0.037866] CPU topo: Allowing 12 present CPUs plus 0 hotplug CPUs
[    0.037884] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.037885] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x000fffff]
[    0.037887] PM: hibernation: Registered nosave memory: [mem 0x09c00000-0=
x09da0fff]
[    0.037888] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0=
x09f0efff]
[    0.037889] PM: hibernation: Registered nosave memory: [mem 0xc0cdd000-0=
xc0d6dfff]
[    0.037891] PM: hibernation: Registered nosave memory: [mem 0xc323a000-0=
xc323afff]
[    0.037892] PM: hibernation: Registered nosave memory: [mem 0xc4b7e000-0=
xcc1fdfff]
[    0.037893] PM: hibernation: Registered nosave memory: [mem 0xce000000-0=
xffffffff]
[    0.037895] [mem 0xd0000000-0xf7ffffff] available for PCI devices
[    0.037896] Booting paravirtualized kernel on bare hardware
[    0.037899] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.043239] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:12 nr_cpu_ids:12 =
nr_node_ids:1
[    0.043844] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u262144
[    0.043850] pcpu-alloc: s217088 r8192 d28672 u262144 alloc=3D1*2097152
[    0.043852] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 -- -=
- -- --=20
[    0.043875] Kernel command line: initrd=3D\initramfs-linux-mainline.img =
cryptdevice=3DUUID=3D8913bf3e-3df0-478e-b072-f7bec731154b:archlinux root=3D=
/dev/mapper/archlinux rootflags=3Dsubvol=3D@ rw loglevel=3D4 drm.panic_scre=
en=3Dqr_code
[    0.043950] Unknown kernel command line parameters "cryptdevice=3DUUID=
=3D8913bf3e-3df0-478e-b072-f7bec731154b:archlinux", will be passed to user =
space.
[    0.043970] printk: log buffer data + meta data: 131072 + 458752 =3D 589=
824 bytes
[    0.046085] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.047140] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.047276] software IO TLB: area num 16.
[    0.064258] Fallback order for Node 0: 0=20
[    0.064267] Built 1 zonelists, mobility grouping on.  Total pages: 38856=
78
[    0.064268] Policy zone: Normal
[    0.064584] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.101234] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D12, =
Nodes=3D1
[    0.109987] ftrace: allocating 55951 entries in 220 pages
[    0.109990] ftrace: allocated 220 pages with 5 groups
[    0.110090] Dynamic Preempt: full
[    0.110144] rcu: Preemptible hierarchical RCU implementation.
[    0.110145] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D12.
[    0.110145] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.110146] 	Trampoline variant of Tasks RCU enabled.
[    0.110147] 	Rude variant of Tasks RCU enabled.
[    0.110147] 	Tracing variant of Tasks RCU enabled.
[    0.110148] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    0.110148] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D12
[    0.110160] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjus=
t=3D1 rcu_task_cpu_ids=3D12.
[    0.110162] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_=
adjust=3D1 rcu_task_cpu_ids=3D12.
[    0.110164] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb=
_adjust=3D1 rcu_task_cpu_ids=3D12.
[    0.115003] NR_IRQS: 524544, nr_irqs: 1064, preallocated irqs: 16
[    0.115213] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.115329] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.115365] Console: colour dummy device 80x25
[    0.115367] printk: legacy console [tty0] enabled
[    0.115412] ACPI: Core revision 20250404
[    0.115569] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484873504 ns
[    0.115588] APIC: Switch to symmetric I/O mode setup
[    0.116120] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:0xa0
[    0.116122] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:0xa0
[    0.116126] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:0xa0
[    0.116127] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:0xa0
[    0.116128] AMD-Vi: Using global IVHD EFR:0x206d73ef22254ade, EFR2:0x0
[    0.117229] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.121595] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x1e37884f63e, max_idle_ns: 440795207701 ns
[    0.121603] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 4192.59 BogoMIPS (lpj=3D2096299)
[    0.121626] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.121677] LVT offset 1 assigned for vector 0xf9
[    0.121784] LVT offset 2 assigned for vector 0xf4
[    0.121810] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.121811] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    0.121815] process: using mwait in idle threads
[    0.121819] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.121820] Spectre V2 : Mitigation: Retpolines
[    0.121822] RETBleed: Mitigation: untrained return thunk
[    0.121822] Spectre V2 : Selecting STIBP always-on mode to complement re=
tbleed mitigation
[    0.121823] Spectre V2 : User space: Mitigation: STIBP always-on protect=
ion
[    0.121824] Speculative Return Stack Overflow: Mitigation: Safe RET
[    0.121825] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.121826] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on context=
 switch and VMEXIT
[    0.121827] Spectre V2 : Enabling Speculation Barrier for firmware calls
[    0.121828] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.121829] x86/bugs: return thunk changed
[    0.121836] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.121837] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.121838] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.121839] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.121840] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'compacted' format.
[    0.153275] Freeing SMP alternatives memory: 56K
[    0.153282] pid_max: default: 32768 minimum: 301
[    0.156378] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.156472] landlock: Up and running.
[    0.156476] Yama: becoming mindful.
[    0.156739] LSM support for eBPF active
[    0.156790] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.156813] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.260026] smpboot: CPU0: AMD Ryzen 5 5500U with Radeon Graphics (famil=
y: 0x17, model: 0x68, stepping: 0x1)
[    0.260300] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.260309] ... version:                0
[    0.260311] ... bit width:              48
[    0.260313] ... generic registers:      6
[    0.260314] ... value mask:             0000ffffffffffff
[    0.260315] ... max period:             00007fffffffffff
[    0.260317] ... fixed-purpose events:   0
[    0.260318] ... event mask:             000000000000003f
[    0.260460] signal: max sigframe size: 1776
[    0.260514] rcu: Hierarchical SRCU implementation.
[    0.260516] rcu: 	Max phase no-delay instances is 400.
[    0.260598] Timer migration: 2 hierarchy levels; 8 children per group; 2=
 crossnode level
[    0.266697] MCE: In-kernel MCE decoding enabled.
[    0.266752] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.266873] smp: Bringing up secondary CPUs ...
[    0.266987] smpboot: x86: Booting SMP configuration:
[    0.266988] .... node  #0, CPUs:        #2  #4  #6  #8 #10  #1  #3  #5  =
#7  #9 #11
[    0.275740] Spectre V2 : Update user space SMT mitigation: STIBP always-=
on
[    0.281648] smp: Brought up 1 node, 12 CPUs
[    0.281648] smpboot: Total of 12 processors activated (50311.17 BogoMIPS)
[    0.282756] Memory: 15079052K/15542712K available (19791K kernel code, 2=
940K rwdata, 16620K rodata, 4652K init, 4980K bss, 443332K reserved, 0K cma=
-reserved)
[    0.283794] devtmpfs: initialized
[    0.283794] x86/mm: Memory block size: 128MB
[    0.286319] ACPI: PM: Registering ACPI NVS region [mem 0x09f00000-0x09f0=
efff] (61440 bytes)
[    0.286319] ACPI: PM: Registering ACPI NVS region [mem 0xcad7e000-0xcc17=
dfff] (20971520 bytes)
[    0.286735] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    0.286735] posixtimers hash table entries: 8192 (order: 5, 131072 bytes=
, linear)
[    0.286735] futex hash table entries: 4096 (262144 bytes on 1 NUMA nodes=
, total 256 KiB, linear).
[    0.286735] pinctrl core: initialized pinctrl subsystem
[    0.286856] PM: RTC time: 11:40:33, date: 2025-06-11
[    0.287662] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.288084] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.288321] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.288557] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.288578] audit: initializing netlink subsys (disabled)
[    0.288614] audit: type=3D2000 audit(1749642032.173:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.288774] thermal_sys: Registered thermal governor 'fair_share'
[    0.288776] thermal_sys: Registered thermal governor 'bang_bang'
[    0.288778] thermal_sys: Registered thermal governor 'step_wise'
[    0.288780] thermal_sys: Registered thermal governor 'user_space'
[    0.288781] thermal_sys: Registered thermal governor 'power_allocator'
[    0.288795] cpuidle: using governor ladder
[    0.288795] cpuidle: using governor menu
[    0.288795] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.288795] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.288842] PCI: ECAM [mem 0xf8000000-0xfbffffff] (base 0xf8000000) for =
domain 0000 [bus 00-3f]
[    0.288858] PCI: Using configuration type 1 for base access
[    0.288997] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.289705] HugeTLB: allocation took 0ms with hugepage_allocation_thread=
s=3D3
[    0.289705] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.289705] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.289705] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.289705] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.289816] raid6: skipped pq benchmark and selected avx2x4
[    0.289816] raid6: using avx2x2 recovery algorithm
[    0.290825] ACPI: Added _OSI(Module Device)
[    0.290828] ACPI: Added _OSI(Processor Device)
[    0.290830] ACPI: Added _OSI(Processor Aggregator Device)
[    0.324855] ACPI: 12 ACPI AML tables successfully acquired and loaded
[    0.327966] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.349101] ACPI: EC: EC started
[    0.349103] ACPI: EC: interrupt blocked
[    0.350029] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.350032] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle tran=
sactions
[    0.350034] ACPI: Interpreter enabled
[    0.350054] ACPI: PM: (supports S0 S3 S4 S5)
[    0.350056] ACPI: Using IOAPIC for interrupt routing
[    0.351891] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.351893] PCI: Using E820 reservations for host bridge windows
[    0.354542] ACPI: \_SB_.PCI0.GPP5.PXSX.WRST: New power resource
[    0.363188] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.363196] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.363343] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplu=
g LTR DPC]
[    0.363639] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER =
PCIeCapability]
[    0.363641] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.363655] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 0xf8000000-0xfbf=
fffff] for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.364118] PCI host bridge to bus 0000:00
[    0.364125] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000efff=
f window]
[    0.364128] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xf7fffff=
f window]
[    0.364130] pci_bus 0000:00: root bus resource [mem 0xfc000000-0xfdfffff=
f window]
[    0.364132] pci_bus 0000:00: root bus resource [mem 0x430000000-0xffffff=
ffff window]
[    0.364134] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.364137] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.364139] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.364154] pci 0000:00:00.0: [1022:1630] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.364251] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600 convent=
ional PCI endpoint
[    0.364343] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.364464] pci 0000:00:02.0: [1022:1632] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.364571] pci 0000:00:02.1: [1022:1634] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.364585] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.364591] pci 0000:00:02.1:   bridge window [mem 0xfd600000-0xfd6fffff]
[    0.364642] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.364777] pci 0000:00:02.2: [1022:1634] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.364791] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.364796] pci 0000:00:02.2:   bridge window [io  0x3000-0x3fff]
[    0.364799] pci 0000:00:02.2:   bridge window [mem 0xfd500000-0xfd5fffff]
[    0.364844] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.364975] pci 0000:00:02.3: [1022:1634] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.364990] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.364994] pci 0000:00:02.3:   bridge window [io  0x2000-0x2fff]
[    0.364997] pci 0000:00:02.3:   bridge window [mem 0xfd400000-0xfd4fffff]
[    0.365044] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.365172] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.365279] pci 0000:00:08.1: [1022:1635] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.365293] pci 0000:00:08.1: PCI bridge to [bus 04]
[    0.365297] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.365300] pci 0000:00:08.1:   bridge window [mem 0xfd000000-0xfd3fffff]
[    0.365306] pci 0000:00:08.1:   bridge window [mem 0x460000000-0x4701fff=
ff 64bit pref]
[    0.365313] pci 0000:00:08.1: enabling Extended Tags
[    0.365348] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.365512] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.365655] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.365834] pci 0000:00:18.0: [1022:1448] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.365918] pci 0000:00:18.1: [1022:1449] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.366003] pci 0000:00:18.2: [1022:144a] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.366085] pci 0000:00:18.3: [1022:144b] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.366170] pci 0000:00:18.4: [1022:144c] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.366250] pci 0000:00:18.5: [1022:144d] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.366332] pci 0000:00:18.6: [1022:144e] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.366419] pci 0000:00:18.7: [1022:144f] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.366623] pci 0000:01:00.0: [144d:a809] type 00 class 0x010802 PCIe En=
dpoint
[    0.366660] pci 0000:01:00.0: BAR 0 [mem 0xfd600000-0xfd603fff 64bit]
[    0.367087] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.367154] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000 PCIe En=
dpoint
[    0.367201] pci 0000:02:00.0: BAR 0 [io  0x3000-0x30ff]
[    0.367206] pci 0000:02:00.0: BAR 2 [mem 0xfd504000-0xfd504fff 64bit]
[    0.367211] pci 0000:02:00.0: BAR 4 [mem 0xfd500000-0xfd503fff 64bit]
[    0.367302] pci 0000:02:00.0: supports D1 D2
[    0.367304] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.367646] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.368070] pci 0000:03:00.0: [10ec:c822] type 00 class 0x028000 PCIe En=
dpoint
[    0.368130] pci 0000:03:00.0: BAR 0 [io  0x2000-0x20ff]
[    0.368137] pci 0000:03:00.0: BAR 2 [mem 0xfd400000-0xfd40ffff 64bit]
[    0.368242] pci 0000:03:00.0: supports D1 D2
[    0.368244] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.368646] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.368748] pci 0000:04:00.0: [1002:164c] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.368772] pci 0000:04:00.0: BAR 0 [mem 0x460000000-0x46fffffff 64bit p=
ref]
[    0.368776] pci 0000:04:00.0: BAR 2 [mem 0x470000000-0x4701fffff 64bit p=
ref]
[    0.368779] pci 0000:04:00.0: BAR 4 [io  0x1000-0x10ff]
[    0.368781] pci 0000:04:00.0: BAR 5 [mem 0xfd300000-0xfd37ffff]
[    0.368787] pci 0000:04:00.0: enabling Extended Tags
[    0.368841] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.368980] pci 0000:04:00.1: [1002:1637] type 00 class 0x040300 PCIe Le=
gacy Endpoint
[    0.369002] pci 0000:04:00.1: BAR 0 [mem 0xfd3c8000-0xfd3cbfff]
[    0.369011] pci 0000:04:00.1: enabling Extended Tags
[    0.369043] pci 0000:04:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.369144] pci 0000:04:00.2: [1022:15df] type 00 class 0x108000 PCIe En=
dpoint
[    0.369168] pci 0000:04:00.2: BAR 2 [mem 0xfd200000-0xfd2fffff]
[    0.369171] pci 0000:04:00.2: BAR 5 [mem 0xfd3cc000-0xfd3cdfff]
[    0.369177] pci 0000:04:00.2: enabling Extended Tags
[    0.369306] pci 0000:04:00.3: [1022:1639] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.369330] pci 0000:04:00.3: BAR 0 [mem 0xfd000000-0xfd0fffff 64bit]
[    0.369339] pci 0000:04:00.3: enabling Extended Tags
[    0.369372] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
[    0.369649] pci 0000:04:00.4: [1022:1639] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.369673] pci 0000:04:00.4: BAR 0 [mem 0xfd100000-0xfd1fffff 64bit]
[    0.369682] pci 0000:04:00.4: enabling Extended Tags
[    0.369715] pci 0000:04:00.4: PME# supported from D0 D3hot D3cold
[    0.369826] pci 0000:04:00.5: [1022:15e2] type 00 class 0x048000 PCIe En=
dpoint
[    0.369848] pci 0000:04:00.5: BAR 0 [mem 0xfd380000-0xfd3bffff]
[    0.369857] pci 0000:04:00.5: enabling Extended Tags
[    0.369888] pci 0000:04:00.5: PME# supported from D0 D3hot D3cold
[    0.369992] pci 0000:04:00.6: [1022:15e3] type 00 class 0x040300 PCIe En=
dpoint
[    0.370015] pci 0000:04:00.6: BAR 0 [mem 0xfd3c0000-0xfd3c7fff]
[    0.370023] pci 0000:04:00.6: enabling Extended Tags
[    0.370054] pci 0000:04:00.6: PME# supported from D0 D3hot D3cold
[    0.370183] pci 0000:00:08.1: PCI bridge to [bus 04]
[    0.370581] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.370685] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.370760] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.370856] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.370946] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.371015] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.371083] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.371152] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.372737] ACPI: EC: interrupt unblocked
[    0.372739] ACPI: EC: event unblocked
[    0.372743] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.372745] ACPI: EC: GPE=3D0x3
[    0.372747] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC initialization comp=
lete
[    0.372749] ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used to handle transactions =
and events
[    0.372868] iommu: Default domain type: Translated
[    0.372868] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.372868] SCSI subsystem initialized
[    0.372868] libata version 3.00 loaded.
[    0.372868] ACPI: bus type USB registered
[    0.372868] usbcore: registered new interface driver usbfs
[    0.372868] usbcore: registered new interface driver hub
[    0.372868] usbcore: registered new device driver usb
[    0.372868] EDAC MC: Ver: 3.0.0
[    0.373955] efivars: Registered efivars operations
[    0.374675] NetLabel: Initializing
[    0.374676] NetLabel:  domain hash size =3D 128
[    0.374678] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.374698] NetLabel:  unlabeled traffic allowed by default
[    0.374704] mctp: management component transport protocol core
[    0.374706] NET: Registered PF_MCTP protocol family
[    0.374719] PCI: Using ACPI for IRQ routing
[    0.376810] PCI: pci_cache_line_size set to 64 bytes
[    0.377618] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.377621] e820: reserve RAM buffer [mem 0x09c00000-0x0bffffff]
[    0.377623] e820: reserve RAM buffer [mem 0x09f00000-0x0bffffff]
[    0.377624] e820: reserve RAM buffer [mem 0xc0cdd000-0xc3ffffff]
[    0.377626] e820: reserve RAM buffer [mem 0xc323a000-0xc3ffffff]
[    0.377628] e820: reserve RAM buffer [mem 0xc4b7e000-0xc7ffffff]
[    0.377629] e820: reserve RAM buffer [mem 0xce000000-0xcfffffff]
[    0.377631] e820: reserve RAM buffer [mem 0x3ee300000-0x3efffffff]
[    0.377677] pci 0000:04:00.0: vgaarb: setting as boot VGA device
[    0.377677] pci 0000:04:00.0: vgaarb: bridge control possible
[    0.377677] pci 0000:04:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.377677] vgaarb: loaded
[    0.377689] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.377696] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.379687] clocksource: Switched to clocksource tsc-early
[    0.380725] VFS: Disk quotas dquot_6.6.0
[    0.380736] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.380854] pnp: PnP ACPI init
[    0.381115] system 00:00: [mem 0xfec00000-0xfec01fff] could not be reser=
ved
[    0.381119] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.381122] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.381450] system 00:02: [io  0x0400-0x04cf] has been reserved
[    0.381453] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    0.381455] system 00:02: [io  0x04d6] has been reserved
[    0.381458] system 00:02: [io  0x0c00-0x0c01] has been reserved
[    0.381460] system 00:02: [io  0x0c14] has been reserved
[    0.381462] system 00:02: [io  0x0c50-0x0c52] has been reserved
[    0.381465] system 00:02: [io  0x0c6c] has been reserved
[    0.381467] system 00:02: [io  0x0c6f] has been reserved
[    0.381469] system 00:02: [io  0x0cd0-0x0cdb] has been reserved
[    0.381580] system 00:03: [mem 0x000e0000-0x000fffff] could not be reser=
ved
[    0.381583] system 00:03: [mem 0x00000000-0x01ffffff] could not be reser=
ved
[    0.381586] system 00:03: [mem 0xfec10000-0xfec1001f] has been reserved
[    0.381591] system 00:03: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.381594] system 00:03: [mem 0xfed61000-0xfed613ff] has been reserved
[    0.381597] system 00:03: [mem 0xfed80000-0xfed80fff] has been reserved
[    0.382015] pnp: PnP ACPI: found 6 devices
[    0.388861] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.389055] NET: Registered PF_INET protocol family
[    0.389337] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.406073] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.406105] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.406176] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.406429] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.406514] TCP: Hash tables configured (established 131072 bind 65536)
[    0.406642] MPTCP token hash table entries: 16384 (order: 6, 393216 byte=
s, linear)
[    0.406720] UDP hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.406803] UDP-Lite hash table entries: 8192 (order: 7, 524288 bytes, l=
inear)
[    0.406902] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.406913] NET: Registered PF_XDP protocol family
[    0.406927] pci 0000:00:02.3: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 03] add_size 200000 add_align 100000
[    0.406940] pci 0000:00:02.3: bridge window [mem 0x430000000-0x4301fffff=
 64bit pref]: assigned
[    0.406944] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.406949] pci 0000:00:02.1:   bridge window [mem 0xfd600000-0xfd6fffff]
[    0.406955] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.406958] pci 0000:00:02.2:   bridge window [io  0x3000-0x3fff]
[    0.406962] pci 0000:00:02.2:   bridge window [mem 0xfd500000-0xfd5fffff]
[    0.406967] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.406970] pci 0000:00:02.3:   bridge window [io  0x2000-0x2fff]
[    0.406973] pci 0000:00:02.3:   bridge window [mem 0xfd400000-0xfd4fffff]
[    0.406976] pci 0000:00:02.3:   bridge window [mem 0x430000000-0x4301fff=
ff 64bit pref]
[    0.407005] pci 0000:00:08.1: PCI bridge to [bus 04]
[    0.407007] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.407011] pci 0000:00:08.1:   bridge window [mem 0xfd000000-0xfd3fffff]
[    0.407014] pci 0000:00:08.1:   bridge window [mem 0x460000000-0x4701fff=
ff 64bit pref]
[    0.407022] pci_bus 0000:00: resource 4 [mem 0x000a0000-0x000effff windo=
w]
[    0.407024] pci_bus 0000:00: resource 5 [mem 0xd0000000-0xf7ffffff windo=
w]
[    0.407026] pci_bus 0000:00: resource 6 [mem 0xfc000000-0xfdffffff windo=
w]
[    0.407028] pci_bus 0000:00: resource 7 [mem 0x430000000-0xffffffffff wi=
ndow]
[    0.407030] pci_bus 0000:00: resource 8 [io  0x0000-0x0cf7 window]
[    0.407033] pci_bus 0000:00: resource 9 [io  0x0d00-0xffff window]
[    0.407035] pci_bus 0000:01: resource 1 [mem 0xfd600000-0xfd6fffff]
[    0.407037] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.407039] pci_bus 0000:02: resource 1 [mem 0xfd500000-0xfd5fffff]
[    0.407042] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    0.407044] pci_bus 0000:03: resource 1 [mem 0xfd400000-0xfd4fffff]
[    0.407061] pci_bus 0000:03: resource 2 [mem 0x430000000-0x4301fffff 64b=
it pref]
[    0.407064] pci_bus 0000:04: resource 0 [io  0x1000-0x1fff]
[    0.407066] pci_bus 0000:04: resource 1 [mem 0xfd000000-0xfd3fffff]
[    0.407068] pci_bus 0000:04: resource 2 [mem 0x460000000-0x4701fffff 64b=
it pref]
[    0.407752] pci 0000:04:00.1: D0 power state depends on 0000:04:00.0
[    0.407787] pci 0000:04:00.3: extending delay after power-on from D3hot =
to 20 msec
[    0.408176] pci 0000:04:00.4: extending delay after power-on from D3hot =
to 20 msec
[    0.408314] PCI: CLS 32 bytes, default 64
[    0.408340] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters support=
ed
[    0.408404] Trying to unpack rootfs image as initramfs...
[    0.408444] pci 0000:00:00.0: Adding to iommu group 0
[    0.408471] pci 0000:00:01.0: Adding to iommu group 1
[    0.408500] pci 0000:00:02.0: Adding to iommu group 2
[    0.408523] pci 0000:00:02.1: Adding to iommu group 3
[    0.408543] pci 0000:00:02.2: Adding to iommu group 4
[    0.408563] pci 0000:00:02.3: Adding to iommu group 5
[    0.408597] pci 0000:00:08.0: Adding to iommu group 6
[    0.408616] pci 0000:00:08.1: Adding to iommu group 6
[    0.408653] pci 0000:00:14.0: Adding to iommu group 7
[    0.408671] pci 0000:00:14.3: Adding to iommu group 7
[    0.408749] pci 0000:00:18.0: Adding to iommu group 8
[    0.408772] pci 0000:00:18.1: Adding to iommu group 8
[    0.408790] pci 0000:00:18.2: Adding to iommu group 8
[    0.408810] pci 0000:00:18.3: Adding to iommu group 8
[    0.408828] pci 0000:00:18.4: Adding to iommu group 8
[    0.408847] pci 0000:00:18.5: Adding to iommu group 8
[    0.408865] pci 0000:00:18.6: Adding to iommu group 8
[    0.408884] pci 0000:00:18.7: Adding to iommu group 8
[    0.408906] pci 0000:01:00.0: Adding to iommu group 9
[    0.408931] pci 0000:02:00.0: Adding to iommu group 10
[    0.408952] pci 0000:03:00.0: Adding to iommu group 11
[    0.408968] pci 0000:04:00.0: Adding to iommu group 6
[    0.408975] pci 0000:04:00.1: Adding to iommu group 6
[    0.408989] pci 0000:04:00.2: Adding to iommu group 6
[    0.408998] pci 0000:04:00.3: Adding to iommu group 6
[    0.409008] pci 0000:04:00.4: Adding to iommu group 6
[    0.409016] pci 0000:04:00.5: Adding to iommu group 6
[    0.409026] pci 0000:04:00.6: Adding to iommu group 6
[    0.410693] AMD-Vi: Extended features (0x206d73ef22254ade, 0x0): PPR X2A=
PIC NX GT IA GA PC GA_vAPIC
[    0.410714] AMD-Vi: Interrupt remapping enabled
[    0.410715] AMD-Vi: X2APIC enabled
[    0.411031] AMD-Vi: Virtual APIC enabled
[    0.411040] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.411041] software IO TLB: mapped [mem 0x00000000bc1a0000-0x00000000c0=
1a0000] (64MB)
[    0.411156] LVT offset 0 assigned for vector 0x400
[    0.411408] perf: AMD IBS detected (0x000003ff)
[    0.411415] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/b=
ank).
[    0.446285] Initialise system trusted keyrings
[    0.446299] Key type blacklist registered
[    0.446381] workingset: timestamp_bits=3D36 max_order=3D22 bucket_order=
=3D0
[    0.446696] fuse: init (API version 7.44)
[    0.446803] integrity: Platform Keyring initialized
[    0.446806] integrity: Machine keyring initialized
[    0.458056] xor: automatically using best checksumming function   avx   =
   =20
[    0.458060] Key type asymmetric registered
[    0.458061] Asymmetric key parser 'x509' registered
[    0.458091] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    0.458184] io scheduler mq-deadline registered
[    0.458186] io scheduler kyber registered
[    0.458209] io scheduler bfq registered
[    0.459564] ledtrig-cpu: registered to indicate activity on CPUs
[    0.459713] pcieport 0000:00:02.1: PME: Signaling with IRQ 28
[    0.459864] pcieport 0000:00:02.2: PME: Signaling with IRQ 29
[    0.459992] pcieport 0000:00:02.3: PME: Signaling with IRQ 30
[    0.460016] pcieport 0000:00:02.3: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    0.460535] pcieport 0000:00:08.1: PME: Signaling with IRQ 31
[    0.462449] ACPI: AC: AC Adapter [AC] (off-line)
[    0.462517] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input0
[    0.462551] ACPI: button: Power Button [PWRB]
[    0.462602] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input1
[    0.466266] ACPI: button: Lid Switch [LID]
[    0.466367] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input2
[    0.466490] ACPI: button: Sleep Button [SLPB]
[    0.466633] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input3
[    0.467346] ACPI: button: Power Button [PWRF]
[    0.468181] Monitor-Mwait will be used to enter C-1 state
[    0.470984] Estimated ratio of average max frequency by base frequency (=
times 1024): 1501
[    0.471806] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.473107] ACPI: battery: Slot [BAT0] (battery present)
[    0.475008] Non-volatile memory driver v1.3
[    0.475010] Linux agpgart interface v0.103
[    0.477405] tpm_tis STM0125:00: 2.0 TPM (device-id 0x0, rev-id 78)
[    0.477644] Freeing initrd memory: 42420K
[    0.712474] ACPI: bus type drm_connector registered
[    0.715213] xhci_hcd 0000:04:00.3: xHCI Host Controller
[    0.715221] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus =
number 1
[    0.715807] xhci_hcd 0000:04:00.3: hcc params 0x0268ffe5 hci version 0x1=
10 quirks 0x0000020000000010
[    0.716971] xhci_hcd 0000:04:00.3: xHCI Host Controller
[    0.716975] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus =
number 2
[    0.716978] xhci_hcd 0000:04:00.3: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.717074] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.16
[    0.717077] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.717079] usb usb1: Product: xHCI Host Controller
[    0.717081] usb usb1: Manufacturer: Linux 6.16.0-rc1-1-mainline xhci-hcd
[    0.717083] usb usb1: SerialNumber: 0000:04:00.3
[    0.717250] hub 1-0:1.0: USB hub found
[    0.717287] hub 1-0:1.0: 4 ports detected
[    0.717805] usb usb2: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    0.717831] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.16
[    0.717833] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.717836] usb usb2: Product: xHCI Host Controller
[    0.717838] usb usb2: Manufacturer: Linux 6.16.0-rc1-1-mainline xhci-hcd
[    0.717840] usb usb2: SerialNumber: 0000:04:00.3
[    0.717959] hub 2-0:1.0: USB hub found
[    0.717983] hub 2-0:1.0: 2 ports detected
[    0.718354] xhci_hcd 0000:04:00.4: xHCI Host Controller
[    0.718359] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus =
number 3
[    0.718962] xhci_hcd 0000:04:00.4: hcc params 0x0268ffe5 hci version 0x1=
10 quirks 0x0000020000000010
[    0.720154] xhci_hcd 0000:04:00.4: xHCI Host Controller
[    0.720158] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus =
number 4
[    0.720161] xhci_hcd 0000:04:00.4: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.720263] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.16
[    0.720266] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.720268] usb usb3: Product: xHCI Host Controller
[    0.720270] usb usb3: Manufacturer: Linux 6.16.0-rc1-1-mainline xhci-hcd
[    0.720272] usb usb3: SerialNumber: 0000:04:00.4
[    0.720445] hub 3-0:1.0: USB hub found
[    0.720498] hub 3-0:1.0: 4 ports detected
[    0.720974] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    0.721000] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.16
[    0.721002] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.721005] usb usb4: Product: xHCI Host Controller
[    0.721007] usb usb4: Manufacturer: Linux 6.16.0-rc1-1-mainline xhci-hcd
[    0.721009] usb usb4: SerialNumber: 0000:04:00.4
[    0.721172] hub 4-0:1.0: USB hub found
[    0.721195] hub 4-0:1.0: 2 ports detected
[    0.721458] usbcore: registered new interface driver usbserial_generic
[    0.721465] usbserial: USB Serial support registered for generic
[    0.721507] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    0.727381] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.727417] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.727675] rtc_cmos 00:01: RTC can wake from S4
[    0.728531] rtc_cmos 00:01: registered as rtc0
[    0.728566] rtc_cmos 00:01: setting system clock to 2025-06-11T11:40:33 =
UTC (1749642033)
[    0.728597] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram
[    0.730074] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input4
[    0.730654] simple-framebuffer simple-framebuffer.0: [drm] Registered 1 =
planes with drm panic
[    0.730662] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 o=
n minor 0
[    0.733781] fbcon: Deferring console take-over
[    0.733787] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    0.733907] hid: raw HID events driver (C) Jiri Kosina
[    0.733947] usbcore: registered new interface driver usbhid
[    0.733949] usbhid: USB HID core driver
[    0.734068] drop_monitor: Initializing network drop monitor service
[    0.734215] NET: Registered PF_INET6 protocol family
[    0.742801] Segment Routing with IPv6
[    0.742806] RPL Segment Routing with IPv6
[    0.742836] In-situ OAM (IOAM) with IPv6
[    0.742886] NET: Registered PF_PACKET protocol family
[    0.744679] x86/amd: Previous system reset reason [0x00080800]: software=
 wrote 0x6 to reset control register 0xCF9
[    0.744706] microcode: Current revision: 0x08608108
[    0.744710] microcode: Updated early from: 0x08608103
[    0.745376] resctrl: L3 allocation detected
[    0.745379] resctrl: MB allocation detected
[    0.745381] resctrl: L3 monitoring detected
[    0.745405] IPI shorthand broadcast: enabled
[    0.749012] sched_clock: Marking stable (747884226, 356622)->(760253917,=
 -12013069)
[    0.749536] registered taskstats version 1
[    0.752037] Loading compiled-in X.509 certificates
[    0.758457] Loaded X.509 cert 'Build time autogenerated kernel key: a861=
867ae24ee8fc8f9c6b72df754d72f881d9a7'
[    0.762513] zswap: loaded using pool zstd/zsmalloc
[    0.762622] Demotion targets for Node 0: null
[    0.763083] Key type .fscrypt registered
[    0.763086] Key type fscrypt-provisioning registered
[    0.764074] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[    0.764131] Key type big_key registered
[    0.765265] integrity: Loading X.509 certificate: UEFI:db
[    0.765290] integrity: Loaded X.509 cert 'Lenovo Ltd.: ThinkPad Product =
CA 2012: 838b1f54c1550463f45f98700640f11069265949'
[    0.765293] integrity: Loading X.509 certificate: UEFI:db
[    0.765304] integrity: Loaded X.509 cert 'Lenovo(Beijing)Ltd: swqagent: =
24b0bd0836b2f545edea93e058bd3a3c5a8f6a49'
[    0.765305] integrity: Loading X.509 certificate: UEFI:db
[    0.765315] integrity: Loaded X.509 cert 'Lenovo UEFI CA 2014: 4b91a6873=
2eaefdd2c8ffffc6b027ec3449e9c8f'
[    0.765316] integrity: Loading X.509 certificate: UEFI:db
[    0.765329] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.765331] integrity: Loading X.509 certificate: UEFI:db
[    0.765344] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.766802] blacklist: Duplicate blacklisted hash bin:80b4d96931bf0d02fd=
91a61e19d14f1da452e66db2408ca8604d411f92659f0a
[    0.766805] blacklist: Duplicate blacklisted hash bin:f52f83a3fa9cfbd692=
0f722824dbe4034534d25b8507246b3b957dac6e1bce7a
[    0.766810] blacklist: Duplicate blacklisted hash bin:c5d9d8a186e2c82d09=
afaa2a6f7f2e73870d3e64f72c4e08ef67796a840f0fbd
[    0.766812] blacklist: Duplicate blacklisted hash bin:1aec84b84b6c65a512=
20a9be7181965230210d62d6d33c48999c6b295a2b0a06
[    0.766815] blacklist: Duplicate blacklisted hash bin:c3a99a460da464a057=
c3586d83cef5f4ae08b7103979ed8932742df0ed530c66
[    0.766817] blacklist: Duplicate blacklisted hash bin:58fb941aef95a25943=
b3fb5f2510a0df3fe44c58c95e0ab80487297568ab9771
[    0.766819] blacklist: Duplicate blacklisted hash bin:5391c3a2fb112102a6=
aa1edc25ae77e19f5d6f09cd09eeb2509922bfcd5992ea
[    0.766821] blacklist: Duplicate blacklisted hash bin:d626157e1d6a718bc1=
24ab8da27cbb65072ca03a7b6b257dbdcbbd60f65ef3d1
[    0.766823] blacklist: Duplicate blacklisted hash bin:d063ec28f67eba53f1=
642dbf7dff33c6a32add869f6013fe162e2c32f1cbe56d
[    0.766826] blacklist: Duplicate blacklisted hash bin:29c6eb52b43c3aa18b=
2cd8ed6ea8607cef3cfae1bafe1165755cf2e614844a44
[    0.766828] blacklist: Duplicate blacklisted hash bin:90fbe70e69d633408d=
3e170c6832dbb2d209e0272527dfb63d49d29572a6f44c
[    0.766831] blacklist: Duplicate blacklisted hash bin:106faceacfecfd4e30=
3b74f480a08098e2d0802b936f8ec774ce21f31686689c
[    0.766833] blacklist: Duplicate blacklisted hash bin:174e3a0b5b43c6a607=
bbd3404f05341e3dcf396267ce94f8b50e2e23a9da920c
[    0.766835] blacklist: Duplicate blacklisted hash bin:2b99cf26422e92fe36=
5fbf4bc30d27086c9ee14b7a6fff44fb2f6b9001699939
[    0.766837] blacklist: Duplicate blacklisted hash bin:2e70916786a6f77351=
1fa7181fab0f1d70b557c6322ea923b2a8d3b92b51af7d
[    0.766840] blacklist: Duplicate blacklisted hash bin:3fce9b9fdf3ef09d54=
52b0f95ee481c2b7f06d743a737971558e70136ace3e73
[    0.766843] blacklist: Duplicate blacklisted hash bin:47cc086127e2069a86=
e03a6bef2cd410f8c55a6d6bdb362168c31b2ce32a5adf
[    0.766845] blacklist: Duplicate blacklisted hash bin:71f2906fd222497e54=
a34662ab2497fcc81020770ff51368e9e3d9bfcbfd6375
[    0.766848] blacklist: Duplicate blacklisted hash bin:82db3bceb4f60843ce=
9d97c3d187cd9b5941cd3de8100e586f2bda5637575f67
[    0.766850] blacklist: Duplicate blacklisted hash bin:8ad64859f195b5f58d=
afaa940b6a6167acd67a886e8f469364177221c55945b9
[    0.766852] blacklist: Duplicate blacklisted hash bin:8d8ea289cfe70a1c07=
ab7365cb28ee51edd33cf2506de888fbadd60ebf80481c
[    0.766855] blacklist: Duplicate blacklisted hash bin:aeebae3151271273ed=
95aa2e671139ed31a98567303a332298f83709a9d55aa1
[    0.766857] blacklist: Duplicate blacklisted hash bin:c409bdac4775add8db=
92aa22b5b718fb8c94a1462c1fe9a416b95d8a3388c2fc
[    0.766860] blacklist: Duplicate blacklisted hash bin:c617c1a8b1ee2a811c=
28b5a81b4c83d7c98b5b0c27281d610207ebe692c2967f
[    0.766862] blacklist: Duplicate blacklisted hash bin:c90f336617b8e7f983=
975413c997f10b73eb267fd8a10cb9e3bdbfc667abdb8b
[    0.766865] blacklist: Duplicate blacklisted hash bin:64575bd912789a2e14=
ad56f6341f52af6bf80cf94400785975e9f04e2d64d745
[    0.766867] blacklist: Duplicate blacklisted hash bin:45c7c8ae750acfbb48=
fc37527d6412dd644daed8913ccd8a24c94d856967df8e
[    0.767087] blacklist: Duplicate blacklisted hash bin:47ff1b63b140b6fc04=
ed79131331e651da5b2e2f170f5daef4153dc2fbc532b1
[    0.767089] blacklist: Duplicate blacklisted hash bin:5391c3a2fb112102a6=
aa1edc25ae77e19f5d6f09cd09eeb2509922bfcd5992ea
[    0.767139] blacklist: Duplicate blacklisted hash bin:80b4d96931bf0d02fd=
91a61e19d14f1da452e66db2408ca8604d411f92659f0a
[    0.767180] blacklist: Duplicate blacklisted hash bin:992d359aa7a5f789d2=
68b94c11b9485a6b1ce64362b0edb4441ccc187c39647b
[    0.767232] blacklist: Duplicate blacklisted hash bin:c452ab846073df5ace=
25cca64d6b7a09d906308a1a65eb5240e3c4ebcaa9cc0c
[    0.767262] blacklist: Duplicate blacklisted hash bin:e051b788ecbaeda530=
46c70e6af6058f95222c046157b8c4c1b9c2cfc65f46e5
[    0.768194] PM:   Magic number: 13:125:681
[    0.769464] RAS: Correctable Errors collector initialized.
[    0.774481] clk: Disabling unused clocks
[    0.774486] PM: genpd: Disabling unused power domains
[    0.776166] Freeing unused decrypted memory: 2028K
[    0.777011] Freeing unused kernel image (initmem) memory: 4652K
[    0.777044] Write protecting the kernel read-only data: 38912k
[    0.777565] Freeing unused kernel image (text/rodata gap) memory: 688K
[    0.778106] Freeing unused kernel image (rodata/data gap) memory: 1812K
[    0.838458] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.838464] rodata_test: all tests were successful
[    0.838472] Run /init as init process
[    0.838474]   with arguments:
[    0.838475]     /init
[    0.838477]   with environment:
[    0.838479]     HOME=3D/
[    0.838480]     TERM=3Dlinux
[    0.838482]     cryptdevice=3DUUID=3D8913bf3e-3df0-478e-b072-f7bec731154=
b:archlinux
[    0.889935] fbcon: Taking over console
[    0.891316] Console: switching to colour frame buffer device 240x67
[    0.955362] usb 3-3: new full-speed USB device number 2 using xhci_hcd
[    0.955396] usb 1-3: new high-speed USB device number 2 using xhci_hcd
[    1.019154] Key type psk registered
[    1.021388] ccp 0000:04:00.2: enabling device (0000 -> 0002)
[    1.021576] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  p=
ost: no)
[    1.021693] ccp 0000:04:00.2: ccp: unable to access the device: you migh=
t be running a broken BIOS.
[    1.021990] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/device:0a/LNXVIDEO:00/input/input6
[    1.023716] ccp 0000:04:00.2: tee enabled
[    1.023881] ccp 0000:04:00.2: psp enabled
[    1.043362] nvme nvme0: pci function 0000:01:00.0
[    1.056469] nvme nvme0: D3 entry latency set to 8 seconds
[    1.082620] nvme nvme0: allocated 64 MiB host memory buffer (1 segment).
[    1.082930] usb 1-3: New USB device found, idVendor=3D13d3, idProduct=3D=
56fb, bcdDevice=3D20.04
[    1.082943] usb 1-3: New USB device strings: Mfr=3D3, Product=3D1, Seria=
lNumber=3D2
[    1.082950] usb 1-3: Product: Integrated Camera
[    1.082956] usb 1-3: Manufacturer: Azurewave
[    1.082960] usb 1-3: SerialNumber: 0000
[    1.101319] usb 3-3: New USB device found, idVendor=3D06cb, idProduct=3D=
00fd, bcdDevice=3D 0.00
[    1.101333] usb 3-3: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D1
[    1.101339] usb 3-3: SerialNumber: 3b39bbc4a1e6
[    1.131909] nvme nvme0: 12/0/0 default/read/poll queues
[    1.145116]  nvme0n1: p1 p2
[    1.160085] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    1.160090] thinkpad_acpi: http://ibm-acpi.sf.net/
[    1.160092] thinkpad_acpi: ThinkPad BIOS R1OET26W (1.05 ), EC R1OHT26W
[    1.160094] thinkpad_acpi: Lenovo ThinkPad E14 Gen 3, model 20YDS00G00
[    1.160486] thinkpad_acpi: radio switch found; radios are enabled
[    1.160499] thinkpad_acpi: This ThinkPad has standard ACPI backlight bri=
ghtness control, supported by the ACPI video driver
[    1.160501] thinkpad_acpi: Disabling thinkpad-acpi brightness events by =
default...
[    1.162767] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is u=
nblocked
[    1.207417] thinkpad_acpi: Standard ACPI backlight interface available, =
not loading native one
[    1.213675] usb 3-4: new full-speed USB device number 3 using xhci_hcd
[    1.294415] thinkpad_acpi: secondary fan control detected & enabled
[    1.305800] thinkpad_acpi: battery 1 registered (start 95, stop 100, beh=
aviours: 0xb)
[    1.305818] ACPI: battery: new hook: ThinkPad Battery Extension
[    1.320278] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_=
acpi/input/input7
[    1.360273] usb 3-4: New USB device found, idVendor=3D0bda, idProduct=3D=
c123, bcdDevice=3D 0.00
[    1.360285] usb 3-4: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    1.360291] usb 3-4: Product: Bluetooth Radio
[    1.360297] usb 3-4: Manufacturer: Realtek
[    1.360302] usb 3-4: SerialNumber: 00e04c000001
[    1.428372] tsc: Refined TSC clocksource calibration: 2112.151 MHz
[    1.428384] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1e7=
207274dd, max_idle_ns: 440795303238 ns
[    1.429000] clocksource: Switched to clocksource tsc
[    2.123366] clocksource: timekeeping watchdog on CPU3: Marking clocksour=
ce 'tsc' as unstable because the skew is too large:
[    2.123372] clocksource:                       'hpet' wd_nsec: 499805771=
 wd_now: 1b8c9b1 wd_last: 14b975c mask: ffffffff
[    2.123376] clocksource:                       'tsc' cs_nsec: 495998876 =
cs_now: 69309bea4 cs_last: 654984384 mask: ffffffffffffffff
[    2.123380] clocksource:                       Clocksource 'tsc' skewed =
-3806895 ns (-3 ms) over watchdog 'hpet' interval of 499805771 ns (499 ms)
[    2.123384] clocksource:                       'tsc' is current clocksou=
rce.
[    2.123393] tsc: Marking TSC unstable due to clocksource watchdog
[    2.123404] TSC found unstable after boot, most likely due to broken BIO=
S. Use 'tsc=3Dunstable'.
[    2.123407] sched_clock: Marking unstable (2123051188, 356675)<-(2135416=
305, -12013069)
[    2.124043] clocksource: Checking clocksource tsc synchronization from C=
PU 8 to CPUs 0,2-4,6.
[    2.124179] clocksource: Switched to clocksource hpet
[    4.338375] [drm] amdgpu kernel modesetting enabled.
[    4.363859] amdgpu: Virtual CRAT table created for CPU
[    4.363881] amdgpu: Topology: Add CPU node
[    4.364073] amdgpu 0000:04:00.0: enabling device (0006 -> 0007)
[    4.364149] [drm] initializing kernel modesetting (RENOIR 0x1002:0x164C =
0x17AA:0x5097 0xC2).
[    4.364518] [drm] register mmio base: 0xFD300000
[    4.364520] [drm] register mmio size: 524288
[    4.368981] amdgpu 0000:04:00.0: amdgpu: detected ip block number 0 <soc=
15_common>
[    4.368986] amdgpu 0000:04:00.0: amdgpu: detected ip block number 1 <gmc=
_v9_0>
[    4.368989] amdgpu 0000:04:00.0: amdgpu: detected ip block number 2 <veg=
a10_ih>
[    4.368992] amdgpu 0000:04:00.0: amdgpu: detected ip block number 3 <psp>
[    4.368994] amdgpu 0000:04:00.0: amdgpu: detected ip block number 4 <smu>
[    4.368997] amdgpu 0000:04:00.0: amdgpu: detected ip block number 5 <dm>
[    4.369000] amdgpu 0000:04:00.0: amdgpu: detected ip block number 6 <gfx=
_v9_0>
[    4.369003] amdgpu 0000:04:00.0: amdgpu: detected ip block number 7 <sdm=
a_v4_0>
[    4.369006] amdgpu 0000:04:00.0: amdgpu: detected ip block number 8 <vcn=
_v2_0>
[    4.369008] amdgpu 0000:04:00.0: amdgpu: detected ip block number 9 <jpe=
g_v2_0>
[    4.369028] amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS from VFCT
[    4.369032] amdgpu: ATOM BIOS: 113-LUCIENNE-016
[    4.382890] Console: switching to colour dummy device 80x25
[    4.390951] amdgpu 0000:04:00.0: vgaarb: deactivate vga console
[    4.390962] amdgpu 0000:04:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re enabled
[    4.390968] amdgpu 0000:04:00.0: amdgpu: MODE2 reset
[    4.391078] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[    4.391092] amdgpu 0000:04:00.0: amdgpu: VRAM: 1024M 0x000000F400000000 =
- 0x000000F43FFFFFFF (1024M used)
[    4.391095] amdgpu 0000:04:00.0: amdgpu: GART: 1024M 0x0000000000000000 =
- 0x000000003FFFFFFF
[    4.391102] [drm] Detected VRAM RAM=3D1024M, BAR=3D1024M
[    4.391104] [drm] RAM width 128bits DDR4
[    4.391392] [drm] amdgpu: 1024M of VRAM memory ready
[    4.391396] [drm] amdgpu: 7397M of GTT memory ready.
[    4.391418] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    4.391591] [drm] PCIE GART of 1024M enabled.
[    4.391594] [drm] PTB located at 0x000000F43FC00000
[    4.392320] amdgpu 0000:04:00.0: amdgpu: [drm] Loading DMUB firmware via=
 PSP: version=3D0x0101002B
[    4.393126] amdgpu 0000:04:00.0: amdgpu: Found VCN firmware Version ENC:=
 1.24 DEC: 8 VEP: 0 Revision: 3
[    4.394391] amdgpu 0000:04:00.0: amdgpu: reserve 0x400000 from 0xf43f800=
000 for PSP TMR
[    4.496050] amdgpu 0000:04:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[    4.506602] amdgpu 0000:04:00.0: amdgpu: RAP: optional rap ta ucode is n=
ot available
[    4.512163] amdgpu 0000:04:00.0: amdgpu: psp gfx command LOAD_TA(0x1) fa=
iled and response status is (0x7)
[    4.512377] amdgpu 0000:04:00.0: amdgpu: psp gfx command INVOKE_CMD(0x3)=
 failed and response status is (0x4)
[    4.512380] amdgpu 0000:04:00.0: amdgpu: Secure display: Generic Failure.
[    4.512390] amdgpu 0000:04:00.0: amdgpu: SECUREDISPLAY: query securedisp=
lay TA failed. ret 0x0
[    4.512599] amdgpu 0000:04:00.0: amdgpu: SMU is initialized successfully!
[    4.513785] amdgpu 0000:04:00.0: amdgpu: [drm] Display Core v3.2.334 ini=
tialized on DCN 2.1
[    4.513793] amdgpu 0000:04:00.0: amdgpu: [drm] DP-HDMI FRL PCON supported
[    4.514585] amdgpu 0000:04:00.0: amdgpu: [drm] DMUB hardware initialized=
: version=3D0x0101002B
[    4.696549] amdgpu 0000:04:00.0: amdgpu: [drm] Using ACPI provided EDID =
for eDP-1
[    4.703788] [drm] kiq ring mec 2 pipe 1 q 0
[    4.710506] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    4.710525] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    4.710744] amdgpu: Virtual CRAT table created for GPU
[    4.710867] amdgpu: Topology: Add dGPU node [0x164c:0x1002]
[    4.710870] kfd kfd: amdgpu: added device 1002:164c
[    4.710884] amdgpu 0000:04:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 8,=
 active_cu_number 7
[    4.710892] amdgpu 0000:04:00.0: amdgpu: ring gfx uses VM inv eng 0 on h=
ub 0
[    4.710895] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 1 on hub 0
[    4.710897] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 4 on hub 0
[    4.710899] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 5 on hub 0
[    4.710901] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 6 on hub 0
[    4.710904] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 7 on hub 0
[    4.710906] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 8 on hub 0
[    4.710908] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 9 on hub 0
[    4.710910] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 10 on hub 0
[    4.710913] amdgpu 0000:04:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 11 on hub 0
[    4.710915] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on=
 hub 8
[    4.710917] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 =
on hub 8
[    4.710919] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4=
 on hub 8
[    4.710922] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5=
 on hub 8
[    4.710924] amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6=
 on hub 8
[    4.712994] amdgpu 0000:04:00.0: amdgpu: Runtime PM not available
[    4.713432] amdgpu 0000:04:00.0: amdgpu: [drm] Using custom brightness c=
urve
[    4.713778] amdgpu 0000:04:00.0: [drm] Registered 4 planes with drm panic
[    4.713781] [drm] Initialized amdgpu 3.64.0 for 0000:04:00.0 on minor 1
[    4.718562] fbcon: amdgpudrmfb (fb0) is primary device
[    4.718979] [drm] pre_validate_dsc:1627 MST_DSC dsc precompute is not ne=
eded
[    4.748124] Console: switching to colour frame buffer device 240x67
[    4.767297] amdgpu 0000:04:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice
[    4.853290] device-mapper: uevent: version 1.0.3
[    4.853506] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised:=
 dm-devel@lists.linux.dev
[    4.872797] Key type trusted registered
[    4.879558] Key type encrypted registered
[   10.388347] BTRFS: device label archlinux-btrfs devid 1 transid 780573 /=
dev/mapper/archlinux (253:0) scanned by mount (487)
[   10.389004] BTRFS info (device dm-0): first mount of filesystem 924db749=
-b786-4970-9fed-688cccb609e9
[   10.389036] BTRFS info (device dm-0): using crc32c (crc32c-x86) checksum=
 algorithm
[   10.389044] BTRFS info (device dm-0): using free-space-tree
[   10.735045] systemd[1]: systemd 257.6-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPEN=
SSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETU=
P +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM=
2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINI=
T +LIBARCHIVE)
[   10.735058] systemd[1]: Detected architecture x86-64.
[   10.737716] systemd[1]: Hostname set to <meterpeter>.
[   10.932370] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[   11.150691] systemd[1]: Queued start job for default target Graphical In=
terface.
[   11.179723] systemd[1]: Created slice Slice /system/dirmngr.
[   11.180470] systemd[1]: Created slice Slice /system/getty.
[   11.181089] systemd[1]: Created slice Slice /system/gpg-agent.
[   11.181789] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[   11.182499] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[   11.183172] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[   11.183807] systemd[1]: Created slice Slice /system/keyboxd.
[   11.184444] systemd[1]: Created slice Slice /system/modprobe.
[   11.185059] systemd[1]: Created slice Slice /system/systemd-fsck.
[   11.185566] systemd[1]: Created slice User and Session Slice.
[   11.185715] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[   11.185845] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[   11.186148] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[   11.186250] systemd[1]: Expecting device /dev/disk/by-uuid/924db749-b786=
-4970-9fed-688cccb609e9...
[   11.186327] systemd[1]: Expecting device /dev/disk/by-uuid/FABC-FA07...
[   11.186417] systemd[1]: Reached target Local Encrypted Volumes.
[   11.186506] systemd[1]: Reached target Local Integrity Protected Volumes.
[   11.186587] systemd[1]: Reached target Preparation for Network.
[   11.186662] systemd[1]: Reached target Path Units.
[   11.186733] systemd[1]: Reached target Remote File Systems.
[   11.186803] systemd[1]: Reached target Slice Units.
[   11.186887] systemd[1]: Reached target Local Verity Protected Volumes.
[   11.187046] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   11.187217] systemd[1]: Listening on LVM2 poll daemon socket.
[   11.188566] systemd[1]: Listening on Process Core Dump Socket.
[   11.189388] systemd[1]: Listening on Credential Encryption/Decryption.
[   11.189586] systemd[1]: Listening on Journal Socket (/dev/log).
[   11.189756] systemd[1]: Listening on Journal Sockets.
[   11.189857] systemd[1]: TPM PCR Measurements was skipped because of an u=
nmet condition check (ConditionSecurity=3Dmeasured-uki).
[   11.189880] systemd[1]: Make TPM PCR Policy was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[   11.189975] systemd[1]: Listening on udev Control Socket.
[   11.190099] systemd[1]: Listening on udev Kernel Socket.
[   11.192604] systemd[1]: Mounting Huge Pages File System...
[   11.193911] systemd[1]: Mounting POSIX Message Queue File System...
[   11.195081] systemd[1]: Mounting Kernel Debug File System...
[   11.196260] systemd[1]: Mounting Kernel Trace File System...
[   11.197959] systemd[1]: Starting Create List of Static Device Nodes...
[   11.214325] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[   11.216451] systemd[1]: Starting Load Kernel Module configfs...
[   11.218110] systemd[1]: Starting Load Kernel Module dm_mod...
[   11.219861] systemd[1]: Starting Load Kernel Module drm...
[   11.221574] systemd[1]: Starting Load Kernel Module fuse...
[   11.224025] systemd[1]: Starting Load Kernel Module loop...
[   11.224204] systemd[1]: Clear Stale Hibernate Storage Info was skipped b=
ecause of an unmet condition check (ConditionPathExists=3D/sys/firmware/efi=
/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[   11.227065] systemd[1]: Starting Journal Service...
[   11.228714] systemd[1]: Starting Load Kernel Modules...
[   11.228840] systemd[1]: TPM PCR Machine ID Measurement was skipped becau=
se of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[   11.230254] systemd[1]: Starting Remount Root and Kernel File Systems...
[   11.230475] systemd[1]: Early TPM SRK Setup was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[   11.232158] systemd[1]: Starting Load udev Rules from Credentials...
[   11.233809] systemd[1]: Starting Coldplug All udev Devices...
[   11.237381] systemd[1]: Mounted Huge Pages File System.
[   11.238527] systemd[1]: Mounted POSIX Message Queue File System.
[   11.239549] systemd[1]: Mounted Kernel Debug File System.
[   11.241142] systemd[1]: Mounted Kernel Trace File System.
[   11.242219] loop: module loaded
[   11.242524] systemd[1]: Finished Create List of Static Device Nodes.
[   11.244122] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[   11.244517] systemd[1]: Finished Load Kernel Module configfs.
[   11.246018] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[   11.246408] systemd[1]: Finished Load Kernel Module dm_mod.
[   11.247885] systemd[1]: modprobe@drm.service: Deactivated successfully.
[   11.248276] systemd[1]: Finished Load Kernel Module drm.
[   11.248670] systemd-journald[560]: Collecting audit messages is disabled.
[   11.250131] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[   11.250501] systemd[1]: Finished Load Kernel Module fuse.
[   11.251874] systemd[1]: modprobe@loop.service: Deactivated successfully.
[   11.252193] systemd[1]: Finished Load Kernel Module loop.
[   11.253627] systemd[1]: Finished Load Kernel Modules.
[   11.254989] systemd[1]: Finished Remount Root and Kernel File Systems.
[   11.256337] systemd[1]: Finished Load udev Rules from Credentials.
[   11.259135] systemd[1]: Activating swap /swap/swapfile...
[   11.261198] systemd[1]: Mounting FUSE Control File System...
[   11.263072] systemd[1]: Mounting Kernel Configuration File System...
[   11.264570] systemd[1]: Rebuild Hardware Database was skipped because no=
 trigger condition checks were met.
[   11.280233] systemd[1]: Starting Load/Save OS Random Seed...
[   11.280983] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[   11.282354] systemd[1]: Starting Apply Kernel Variables...
[   11.285186] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[   11.286500] systemd[1]: TPM SRK Setup was skipped because of an unmet co=
ndition check (ConditionSecurity=3Dmeasured-uki).
[   11.288296] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling.
[   11.289454] systemd[1]: Mounted FUSE Control File System.
[   11.289460] Adding 16777212k swap on /swap/swapfile.  Priority:-2 extent=
s:33 across:450363392k SS
[   11.290279] systemd[1]: Activated swap /swap/swapfile.
[   11.292628] systemd[1]: Mounted Kernel Configuration File System.
[   11.293707] systemd[1]: Reached target Swaps.
[   11.339601] systemd[1]: Started Journal Service.
[   11.778044] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, re=
vision 0
[   11.778053] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port=
 selection
[   11.786237] i2c i2c-5: Successfully instantiated SPD at 0x50
[   11.787031] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at=
 0xb20
[   11.799613] ACPI: bus type thunderbolt registered
[   11.866893] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840=
 ms ovfl timer
[   11.866901] RAPL PMU: hw unit of domain package 2^-16 Joules
[   11.866904] RAPL PMU: hw unit of domain core 2^-16 Joules
[   11.868213] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[   11.873338] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO ad=
dress
[   11.875560] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[   11.875631] sp5100-tco sp5100-tco: initialized. heartbeat=3D60 sec (nowa=
yout=3D0)
[   11.881967] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   11.882416] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[   11.882888] snd_rn_pci_acp3x 0000:04:00.5: enabling device (0000 -> 0002)
[   11.897477] ee1004 5-0050: 512 byte EE1004-compliant SPD EEPROM, read-on=
ly
[   11.909116] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[   11.917196] r8169 0000:02:00.0 eth0: RTL8168gu/8111gu, 38:f3:ab:58:be:e8=
, XID 509, IRQ 68
[   11.917207] r8169 0000:02:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[   11.920486] r8169 0000:02:00.0 enp2s0: renamed from eth0
[   12.107315] snd_hda_intel 0000:04:00.1: enabling device (0000 -> 0002)
[   12.109567] snd_hda_intel 0000:04:00.1: Handle vga_switcheroo audio clie=
nt
[   12.110380] snd_hda_intel 0000:04:00.6: enabling device (0000 -> 0002)
[   12.110879] kvm_amd: TSC scaling supported
[   12.110885] kvm_amd: Nested Virtualization enabled
[   12.110888] kvm_amd: Nested Paging enabled
[   12.110891] kvm_amd: LBR virtualization supported
[   12.110903] kvm_amd: Virtual VMLOAD VMSAVE supported
[   12.110905] kvm_amd: Virtual GIF supported
[   12.132677] snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 (ops amdgpu_d=
m_audio_component_bind_ops [amdgpu])
[   12.135101] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devices/pci0000:=
00/0000:00:08.1/0000:04:00.1/sound/card0/input9
[   12.135236] input: HD-Audio Generic HDMI/DP,pcm=3D7 as /devices/pci0000:=
00/0000:00:08.1/0000:04:00.1/sound/card0/input10
[   12.135408] input: HD-Audio Generic HDMI/DP,pcm=3D8 as /devices/pci0000:=
00/0000:00:08.1/0000:04:00.1/sound/card0/input11
[   12.156933] snd_hda_codec_realtek hdaudioC1D0: ALC257: picked fixup  for=
 PCI SSID 17aa:0000
[   12.157616] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC257: li=
ne_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   12.157623] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[   12.157627] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[   12.157631] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=3D0x0
[   12.157634] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   12.157637] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=3D0x12
[   12.157640] snd_hda_codec_realtek hdaudioC1D0:      Mic=3D0x19
[   12.185547] intel_rapl_common: Found RAPL domain package
[   12.185554] intel_rapl_common: Found RAPL domain core
[   12.186110] amd_atl: AMD Address Translation Library initialized
[   12.188909] rtw88_8822ce 0000:03:00.0: enabling device (0000 -> 0003)
[   12.192063] rtw88_8822ce 0000:03:00.0: WOW Firmware version 9.9.4, H2C v=
ersion 15
[   12.192978] rtw88_8822ce 0000:03:00.0: Firmware version 9.9.15, H2C vers=
ion 15
[   12.240092] psmouse serio1: elantech: assuming hardware version 4 (with =
firmware version 0x5f3001)
[   12.250508] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:0=
8.1/0000:04:00.6/sound/card1/input12
[   12.250653] input: HD-Audio Generic Headphone as /devices/pci0000:00/000=
0:00:08.1/0000:04:00.6/sound/card1/input13
[   12.252808] psmouse serio1: elantech: Synaptics capabilities query resul=
t 0x90, 0x18, 0x0d.
[   12.256709] rtw88_8822ce 0000:03:00.0 wlp3s0: renamed from wlan0
[   12.267005] psmouse serio1: elantech: Elan sample query result 00, 0d, a7
[   12.280046] psmouse serio1: elantech: Elan ic body: 0x11, current fw ver=
sion: 0x4
[   12.318183] systemd-journald[560]: Received client request to flush runt=
ime journal.
[   12.355768] psmouse serio1: elantech: Trying to set up SMBus access
[   12.355819] psmouse serio1: elantech: SMbus companion is not ready yet
[   12.383621] input: ETPS/2 Elantech TrackPoint as /devices/platform/i8042=
/serio1/input/input14
[   12.392502] mousedev: PS/2 mouse device common for all mice
[   12.400800] input: ETPS/2 Elantech Touchpad as /devices/platform/i8042/s=
erio1/input/input8
[   13.038140] Bluetooth: Core ver 2.22
[   13.038608] mc: Linux media interface: v0.10
[   13.038893] NET: Registered PF_BLUETOOTH protocol family
[   13.038898] Bluetooth: HCI device and connection manager initialized
[   13.038905] Bluetooth: HCI socket layer initialized
[   13.038910] Bluetooth: L2CAP socket layer initialized
[   13.038921] Bluetooth: SCO socket layer initialized
[   13.075245] videodev: Linux video capture interface: v2.00
[   13.199235] usbcore: registered new interface driver btusb
[   13.203896] Bluetooth: hci0: RTL: examining hci_ver=3D0a hci_rev=3D000c =
lmp_ver=3D0a lmp_subver=3D8822
[   13.205858] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D3
[   13.205865] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_fw.bin
[   13.207521] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_config.bin
[   13.207737] Bluetooth: hci0: RTL: cfg_sz 6, total sz 37346
[   13.242572] usb 1-3: Found UVC 1.10 device Integrated Camera (13d3:56fb)
[   13.252399] usb 1-3: Found UVC 1.50 device Integrated Camera (13d3:56fb)
[   13.254489] usbcore: registered new interface driver uvcvideo
[   13.532897] Bluetooth: hci0: RTL: fw version 0xaed66dcb
[   13.639908] Bluetooth: hci0: AOSP extensions version v1.00
[   13.639916] Bluetooth: hci0: AOSP quality report is supported
[   13.798447] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-200:00, irq=3DMAC)
[   13.950703] r8169 0000:02:00.0 enp2s0: Link is Down
[   15.520753] tun: Universal TUN/TAP device driver, 1.6
[   18.744653] wlp3s0: authenticate with 74:42:7f:8b:74:ad (local address=
=3Dcc:6b:1e:3d:f9:f7)
[   18.949402] wlp3s0: send auth to 74:42:7f:8b:74:ad (try 1/3)
[   18.953069] wlp3s0: authenticated
[   18.954417] wlp3s0: associate with 74:42:7f:8b:74:ad (try 1/3)
[   18.959395] wlp3s0: RX AssocResp from 74:42:7f:8b:74:ad (capab=3D0x1511 =
status=3D0 aid=3D2)
[   18.959816] wlp3s0: associated
[   19.047640] wlp3s0: Limiting TX power to 20 (23 - 3) dBm as advertised b=
y 74:42:7f:8b:74:ad
[   23.287103] nvme nvme0: using unchecked data buffer

--ofsj7hvjgjxpsigb--

--ifh6e7xanojzxv73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmhJbHkACgkQwEfU8yi1
JYVjvA//VduwQzLQDyj9TSIqvCaKsoIQNtUswvRCm/Hp+YZUgbN/yVaEQOiDBHJP
NcL8IEIG70slmv3LH63uStWL22qSpOZkv6rhPIX7nTyeEfCUADbTjvT/mFxUc2Nz
TfsIyIt1WwFkNCUhwc9MF7lqtgpX39pLzE38YKU/ZXOzq4wuu3bf1QtAcJKuxKAl
DJyLB/LNs/uL0iSgIWgmO5evPZeXmlGXAv4GZgh8JUPfcmvK3Kc/siOKxW3ej1Vp
GzH3EoSLy6YTC8qd89hHrwHX9GczxxdrJFxPhYVSbxwitoiszDzTtSv41qEZZ+tk
THayhCKiVzUnMTmU4+Yuj/FJAZvqD5RO6ZZiBhq0DtEw8pv7Q6KfjAjfqx4lFslT
2BTBebpUDsyvfS+60Dhj8ijRNTIP2hcrX1SSvyDOtDzW0+KBlXnYAqMGZszVNWpG
+iVoTdDukBfUG8lCgpa3oKdJTCucidf1W3Z5WFUykadVT5QmnoeIWch7kXfuKMlG
xLN1X3G6ZMWQ7Yt2nULVY2ipLG0/5pVRY1+zJB318EK/RaHnMBUKl2ZCBB8icFUq
kOdMeXrYkQMvf/rfVf1qVxf+Bc74atk5J1uj75x4rfJN00nNDv7XCJvBalquZ7K3
UXPhKwDm8gi0HuueITE5i86a+EvEnvkKkLONUf2LyjjPMowfQb0=
=SlAO
-----END PGP SIGNATURE-----

--ifh6e7xanojzxv73--

