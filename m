Return-Path: <netdev+bounces-101787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559CD900136
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5646D1C22C48
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF73186299;
	Fri,  7 Jun 2024 10:51:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D79361FCE
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757509; cv=none; b=hoxyV7+nUMiYghJd5N3iKmOGBDtqkWN4auVCksHHamZxP2t0aCV3joXGoYF205QaVdwGGIwy1GDK18hcH97JV3V9YqOMrQ6YgI/1I2uo0MeiIkbedxz7DnakEUX6hSwmbGAlKT12RQQ8bMDjQ2TtT27iEj7Ku+bklGAyqa56fnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757509; c=relaxed/simple;
	bh=PMPTA1bVJU53RAjwj6iJrT2Zdt5mcQUQC7vV/S50ypo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sx5Cmzay1BGzWgnl5Hng2CZS+T6jTgEEcyhGQhs8FaRyhmlvAttChrrdOgFw430nJiObQqKbx9KaNvqXPlCYZZm6DzQlDYsauMidpv6kceRpK0QCyxXXvkJTv3BUsK7EJpBaRHm5ldeWG4JzcZ26zh5vAUKE22Gf0xShTuKKjHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz12t1717757468tr893e
X-QQ-Originating-IP: xQDfpmfaCTQ/ZJd+C44DoN5IWglYvwVwgEK/dHVKqvI=
Received: from smtpclient.apple ( [122.231.252.226])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 07 Jun 2024 18:51:06 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12639844150157769632
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH net-next v4 0/6] add sriov support for wangxun NICs
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20240606065229.125314db@kernel.org>
Date: Fri, 7 Jun 2024 18:50:56 +0800
Cc: netdev@vger.kernel.org,
 Jiawen Wu <jiawenwu@trustnetic.com>,
 =?utf-8?B?5rip56uv5by6?= <duanqiangwen@net-swift.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <988BFB51-32C8-499C-837D-91CC1C0FFE42@net-swift.com>
References: <3601E5DE87D2BC4F+20240604155850.51983-1-mengyuanlou@net-swift.com>
 <20240605174226.2b55ebc4@kernel.org>
 <EED7EF04-3358-4E91-BBC5-7B09370F9025@net-swift.com>
 <20240606065229.125314db@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1



> 2024=E5=B9=B46=E6=9C=886=E6=97=A5 21:52=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, 6 Jun 2024 18:13:07 +0800 mengyuanlou@net-swift.com wrote:
>>> You have cut out the ndo_set_vf_* calls but you seem to add no uAPI
>>> access beyond just enabling the PCI SR-IOV capability. What's your =
plan
>>> of making this actually usable? It's a very strange submission. =20
>>=20
>> Vf driver(wxvf) will be submitted later, uAPI for virtual network =
devices will
>> be added in it.
>=20
> I mean the configuration API equivalent to the legacy NDOs.
>=20

It starts here.
- https://lore.kernel.org/netdev/20240403185300.702a8271@kernel.org/

> + .ndo_set_vf_spoofchk =3D wx_ndo_set_vf_spoofchk,
> + .ndo_set_vf_link_state =3D wx_ndo_set_vf_link_state,
> + .ndo_get_vf_config =3D wx_ndo_get_vf_config,
> + .ndo_set_vf_vlan =3D wx_ndo_set_vf_vlan,
> + .ndo_set_vf_mac =3D wx_ndo_set_vf_mac,

Whether these interfaces are going to be deprecated, and I have no idea
about what new apis can replace the ndo_{set|get}_vf_xxx interfaces.

I have seen recently submitted driver(octeon_ep) which support sriov, do =
not=20
add ndo_{set|get}_vf_xxx interfaces.
- =
https://lore.kernel.org/netdev/20231215181425.2681426-1-srasheed@marvell.c=
om/

If I have missed some docs or code?



