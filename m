Return-Path: <netdev+bounces-176943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BCBA6CD56
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 01:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4F53B07B1
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 00:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A8E80B;
	Sun, 23 Mar 2025 00:01:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A94647
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742688090; cv=none; b=UBd1tBg88Mxq25vj05C1P64azdANVoLSbzlkPJXWqs+JgtRtNSyPY627Zm+Sa3SKsB2Pu9/hyWRA0aAyMuwCLSsz61ifaIk4oi1VTtFrGLq7uTmyKzKcHiDkscBqgMnxsFspgw7h86pPClOGOTrlSelcPW5uNla0RE5xbpx2Khs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742688090; c=relaxed/simple;
	bh=clZyGx7FyTaNY0b31ckgOs2WG5cQqvhILoUFei9JS7U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W7b1ctAW/OTJ2Cz9p6JWJME15k8JOMKQBYDEYyjon4ZLxtbmpsAk1M3rlsAxa7sSB/BXCjs2cWBFeQGBXrErRAd75IIdHwhW9J550plNfiB7qWwKszGKqOSabMFCD+nDb1nfAb9tiXTB6inX4dNYProlMSgSUT9z9wF9fs0r1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpip2t1742688041tmaqloa
X-QQ-Originating-IP: 0JhvJIdo/rU5lLpqCfRwlvWFJFzbxiNqHyoIj2qImPY=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 23 Mar 2025 08:00:40 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2458011106060878887
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH net-next v9 0/6] add sriov support for wangxun NICs
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <203E2DE385ACD88C+20250319073356.55085-1-mengyuanlou@net-swift.com>
Date: Sun, 23 Mar 2025 08:00:29 +0800
Cc: kuba@kernel.org,
 horms@kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A4FB01EA-0BF0-41C1-9596-03D0EDA00E4C@net-swift.com>
References: <203E2DE385ACD88C+20250319073356.55085-1-mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: ONeCszOCk2GVVvOoWHku3pOQlJ7dyyBb7TmacmYvqt4lRU5KoGKuSryo
	UIVnKq4IvGCaQDaCBwtafSIICaMt7XlA1QRp/47TrqDiv2tpac6l/9nPF/S9JYNlVYTMhGD
	0DAT0JMtb36aCb+taho/Ai3wuiiCbCIZ6MmXVYssgH3ORdDuaOUYeZ7u/e7KQ66TDATIFEn
	KcRkIXuMsidd/+hLy3KSvBklcfkIKQ7pxVwBfXcyI7TrAouVIsnU71JPbLhhIrik0V33yy7
	GKvrd4b0nlTTTYNXK4skeCAmLWn+JoQdD0zvPTzE7FjwPsh4kaUG6La4yRYeDt+T1ynaFim
	LwjILhLmgEgChK1MWBEEYQ0kQ+UzBLg/Tib/mSbOoUwYZv8IdcaOmBYg7fF0/+hhvTsEJl7
	RyYMvURILkbXwV3Lrb/hIs7l1P2euCiH+658vUlRJO9BMYpz2ZUlhNOaksM+ARnyF3vMCKt
	zgD6rtDOGk0p1dJ4RuaeIDtYoN2vcROAexwGdvx8wUzPGdQRBlBRaiJ8SMagtaKlSNrLiXS
	9qCAfK9uHuR+jdedjL+fSePprg+lCzylIV6mg0nibySfBO+ATccDrlYY2rmd1y7gQJQWxZE
	PzZAw8IYVrYnXShtDCt8gJLdWXVE9o/TB8kqB7fSAOuwBJdMcOhLw/5bb26Cv8SaB/n1yXR
	Nb1lMNrcBLyu0MNs91g53Y/ifsZ15z7V/jkAXT+frQVEackN5Q6VDj51STNCpGR8De5FGza
	8wUZc2u0KeDZJW4yNXM9dvC0tQbUeAJNpiU+/RYG1C4drlbci15H15Ktc35zPUzX5rzXliQ
	H0KcI5Wg5lXQ4GGLUR4n9G4gIb1sJF1vh4mhaIqTnpDjNLJ9pNgu68po6RYYWgfBIJ90Qsu
	3PbkQ4DtvIj4Fz5J1/u4t9royV4sV8zCrcvPMNUwgEc46Flp1ufe0m8jgBhjjeWjWi9a34t
	xizj9Hzf18nmN6GiqFmnhtHEjnJR24wcTeNz2m3yv+vpB1WaXGnXE3DK3aujQQZRGHxF50W
	vHLo96e/yd/Nl4MJB7vseep6jPrItaGcgzEjl7yg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hi

> 2025=E5=B9=B43=E6=9C=8819=E6=97=A5 15:33=EF=BC=8CMengyuan Lou =
<mengyuanlou@net-swift.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Add sriov_configure for ngbe and txgbe drivers.
> Reallocate queue and irq resources when sriov is enabled.
> Add wx_msg_task in interrupts handler, which is used to process the
> configuration sent by vfs.
> Add ping_vf for wx_pf to tell vfs about pf link change.
> Do not add uAPIs for in these patches, since the legacy APIs =
ndo_set_vf_*
> callbacks are considered frozen. And new apis are being replanned.
>=20
> v9:
> - Using FIELD_{GET,PREP} macros makes the code more readable.
> - Add support for the new mac_type aml in the configuration flow.
> v8: =
https://lore.kernel.org/netdev/20250309154252.79234-1-mengyuanlou@net-swif=
t.com/
> - Request a separate processing function when ngbe num_vfs is equal to =
7.
> - Add the comment explains why pf needs to reuse interrupt 0 when the =
ngbe
> num_vfs equals 7.
> - Remove some useless api version checks because vf will not send =
commands
> higher than its own api version.
> - Fix some code syntax and logic errors.
> v7: =
https://lore.kernel.org/netdev/20250206103750.36064-1-mengyuanlou@net-swif=
t.com/
> - Use pci_sriov_set_totalvfs instead of checking the limit manually.
> v6: =
https://lore.kernel.org/netdev/20250110102705.21846-1-mengyuanlou@net-swif=
t.com/
> - Remove devlink allocation and PF/VF devlink port creation in these =
patches.
> v5: =
https://lore.kernel.org/netdev/598334BC407FB6F6+20240804124841.71177-1-men=
gyuanlou@net-swift.com/
> - Add devlink allocation which will be used to add uAPI.
> - Remove unused EXPORT_SYMBOL.
> - Unify some functions return styles in patch 1/4.
> - Make the code line less than 80 columns.
> v4: =
https://lore.kernel.org/netdev/3601E5DE87D2BC4F+20240604155850.51983-1-men=
gyuanlou@net-swift.com/
> - Move wx_ping_vf to patch 6.
> - Modify return section format in Kernel docs.
> v3: =
https://lore.kernel.org/netdev/587FAB7876D85676+20240415110225.75132-1-men=
gyuanlou@net-swift.com/
> - Do not accept any new implementations of the old SR-IOV API.
> - So remove ndo_vf_xxx in these patches. Switch mode ops will be added
> - in vf driver which will be submitted later.
> v2: =
https://lore.kernel.org/netdev/EF19E603F7CCA7B9+20240403092714.3027-1-meng=
yuanlou@net-swift.com/
> - Fix some used uninitialised.
> - Use poll + yield with delay instead of busy poll of 10 times in =
mbx_lock obtain.
> - Split msg_task and flow into separate patches.
> v1: =
https://lore.kernel.org/netdev/DA3033FE3CCBBB84+20240307095755.7130-1-meng=
yuanlou@net-swift.com/
>=20
> Mengyuan Lou (6):
>  net: libwx: Add mailbox api for wangxun pf drivers
>  net: libwx: Add sriov api for wangxun nics
>  net: libwx: Redesign flow when sriov is enabled
>  net: libwx: Add msg task func
>  net: ngbe: add sriov function support
>  net: txgbe: add sriov function support
>=20
> drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
> drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 302 +++++-
> drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   4 +
> drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 128 ++-
> drivers/net/ethernet/wangxun/libwx/wx_mbx.c   | 176 ++++
> drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |  77 ++
> drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 909 ++++++++++++++++++
> drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  18 +
> drivers/net/ethernet/wangxun/libwx/wx_type.h  |  93 +-
> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  93 +-
> drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   5 +
> drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   3 +
> .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  21 +-
> .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  27 +
> .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   6 +
> .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   7 +-
> 16 files changed, 1837 insertions(+), 34 deletions(-)
> create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
> create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h
>=20
> --=20
> 2.48.1
>=20


