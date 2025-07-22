Return-Path: <netdev+bounces-208804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98279B0D2EC
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4311889301
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 07:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703FE2D878A;
	Tue, 22 Jul 2025 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="mLe5XmGU"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACD62D0C9B
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169091; cv=none; b=XlsJRoCAIXseQbkQlly6GNZ/fWZJxmzwLSivm9hZxUY1ALvRIwq8ph48RVncfxcYUDZLa3x38Um1dGCRiBFXnfgoqj3fVaXRowZhx8mHWQardXLitYRX4cIP2u4+CZNN1klRhJU5H8PBzmuRJMR2zovh+3aKlvzh049c1ciCQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169091; c=relaxed/simple;
	bh=4HhP2iNixfpmY9GA50RldzfymFrP5PRb/ex2XnKjRrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbhN+3X55WatXx9msq3UDIfqm4RPKOqrX3NXro7ejl86hBjyJz1vZb2eCgng1vQMIs71U+MhGyxUiuOeEbzdjQYv5dUTqc/XX1RBnA0e9QXUQ8VmDJyEaJMu5KkeRg284cZg/jFTdlnzKuI8M5+aEtiaiO2O5rMjVgSa+8Ubvmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=mLe5XmGU; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753168998;
	bh=4HhP2iNixfpmY9GA50RldzfymFrP5PRb/ex2XnKjRrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=mLe5XmGUOArSYdy/2/xBjJ8ilefcPJfI7C2P1v5h7B6E8O0V9PMg+NtyBhaDSkeR5
	 AdzNmtpcZtE+7m1/mxUJSQ0fPLb13pFQBo2xwPv4R9v4GVq8YxQC5Ym2YssnmgJYtA
	 XQ2tuch7o1eHx/9SfyMctramX02mE4k8SKTPjs9A=
X-QQ-mid: zesmtpip4t1753168943tb2aa8fc1
X-QQ-Originating-IP: jlkPh//3cQuVzne1YV9Hj8c3k19VYTQ4PPPWu+FTW/A=
Received: from [IPV6:240e:668:120a::212:232] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 15:22:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3880468087656715595
EX-QQ-RecipientCnt: 62
Message-ID: <634BA467821D37FE+0b2ace38-07d9-4500-8bb7-5a4fa65c4b9f@uniontech.com>
Date: Tue, 22 Jul 2025 15:22:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] serial: 8250_dw: Fix typo "notifer"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: airlied@gmail.com, akpm@linux-foundation.org, alison.schofield@intel.com,
 andrew+netdev@lunn.ch, andriy.shevchenko@linux.intel.com,
 arend.vanspriel@broadcom.com, bp@alien8.de,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 colin.i.king@gmail.com, cvam0000@gmail.com, dan.j.williams@intel.com,
 dave.hansen@linux.intel.com, dave.jiang@intel.com, dave@stgolabs.net,
 davem@davemloft.net, dri-devel@lists.freedesktop.org, edumazet@google.com,
 guanwentao@uniontech.com, hpa@zytor.com, ilpo.jarvinen@linux.intel.com,
 intel-xe@lists.freedesktop.org, ira.weiny@intel.com, j@jannau.net,
 jeff.johnson@oss.qualcomm.com, jgross@suse.com, jirislaby@kernel.org,
 johannes.berg@intel.com, jonathan.cameron@huawei.com, kuba@kernel.org,
 kvalo@kernel.org, kvm@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux@treblig.org, lucas.demarchi@intel.com,
 marcin.s.wojtas@gmail.com, ming.li@zohomail.com, mingo@kernel.org,
 mingo@redhat.com, netdev@vger.kernel.org, niecheng1@uniontech.com,
 oleksandr_tyshchenko@epam.com, pabeni@redhat.com, pbonzini@redhat.com,
 quic_ramess@quicinc.com, ragazenta@gmail.com, rodrigo.vivi@intel.com,
 seanjc@google.com, shenlichuan@vivo.com, simona@ffwll.ch,
 sstabellini@kernel.org, tglx@linutronix.de,
 thomas.hellstrom@linux.intel.com, vishal.l.verma@intel.com, x86@kernel.org,
 xen-devel@lists.xenproject.org, yujiaoliang@vivo.com, zhanjun@uniontech.com
References: <BD5C52D2838AEA48+20250715134050.539234-1-wangyuli@uniontech.com>
 <2BF1749F02ADE664+20250715134407.540483-6-wangyuli@uniontech.com>
 <2025071607-outbid-heat-b0ba@gregkh>
Content-Language: en-US
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <2025071607-outbid-heat-b0ba@gregkh>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1TBt0IFfjz321DLdIVEctMps"
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N99Qg+lZy8McGXx0ffJq3rOXsIj0XR0XBhhg3pPLdCHVvSoWiQ9jSxX5
	yXwkUCxI8kF1fWgwc3H34nIx+NJzXhg1AJUHHkEfIcGKFVRwQVJwlE0TPgFuHhQD83eFqFV
	KZl1V6dj4p3V5R82ewzRYaLkZPfEVOnKODdIywXC5zEoydWIOtgD3e1f7DPY6uJBll+urzY
	LV1XzwxamygqixghmMPOlRs8jHn0TP65sp03tkpnJ+gMmDbq8jKIWMYLFTKy7L7ppTMTNm5
	PuWyiKfs2GWAillZ3Rq8huwkBo5Rp1oUAGt5nM0UZcReu8orBG+EQBKeYMQC6EbTDPvT5aN
	jNAHGubRkoP87WK59MCBdaOHu6H4H/oXqRSnQBvBjDRUvPLIXDkqFQDj23Mfttfr9MYOFlK
	H7acVPlDI01uId4bOPyiZQBWeHtq1Gqp4kWpeiK6IUgiFQGre0efNmCyiCwM2gMF/K6NEGE
	xceND45oWn1s8FzE5V5QC1K2RPg9JBJ9PhghbOmw7y/pvjCYr9F08lPatewtfiCWMf0AEIq
	DfiTA+jWpCe51gphHt2mA8P4E0yKcppSzliEaZVaEmIt1NNyu8ytFUGafkb9+cEa1o6VNle
	7wDNAoWRC3yFFBzT3WUVWyjN8t/+vLLJS0xGT4UNzX4cY3R2EIhfsB+h4ah+Hjn9SvGfPWP
	E/3oArF5XjmDCVO5g4qrPJDfnQizyJPhjOK5bUiRWB37Wp1GjBZT8AeNi0im6SdJGzVDU3+
	AOd4Bz1jq4oDeDowAjAqGLB+1614Zk48cUrQ4w/TtPNBSuVjwTq6zk6sFSNFo/xcBpECTCF
	U8TsVFWOcYswRvq0WXkddW+nx/We2cpF99xGXc+gZhbJCDhKcfNQS9/uu5GnVyuZ1LrsL2i
	jgex+fZx5DIBXETG2zDz6hGBRSWuAqbA7YpQ4v03gGCXSRmpjzXXjnVsy7htRQQVEHalBj1
	pxSjVhD61q58YhRneCrSNqPXkIDxpuIEk2ungxlkzmqJPHX1omKkbtFMYkotSOH1yTPuCvA
	YrO55enoNRQE5WDjQmV2n89LCS613dmChBdi69CqEogfnbr7/zEX/DDZla8DwHUDtXoxJyk
	H/7KzW0lvwHmuguzSrGObDNb5pHWn5HQsH8ckUqdobF
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1TBt0IFfjz321DLdIVEctMps
Content-Type: multipart/mixed; boundary="------------7NzxUd2CIcc1X22DyUWciByd";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: airlied@gmail.com, akpm@linux-foundation.org, alison.schofield@intel.com,
 andrew+netdev@lunn.ch, andriy.shevchenko@linux.intel.com,
 arend.vanspriel@broadcom.com, bp@alien8.de,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 colin.i.king@gmail.com, cvam0000@gmail.com, dan.j.williams@intel.com,
 dave.hansen@linux.intel.com, dave.jiang@intel.com, dave@stgolabs.net,
 davem@davemloft.net, dri-devel@lists.freedesktop.org, edumazet@google.com,
 guanwentao@uniontech.com, hpa@zytor.com, ilpo.jarvinen@linux.intel.com,
 intel-xe@lists.freedesktop.org, ira.weiny@intel.com, j@jannau.net,
 jeff.johnson@oss.qualcomm.com, jgross@suse.com, jirislaby@kernel.org,
 johannes.berg@intel.com, jonathan.cameron@huawei.com, kuba@kernel.org,
 kvalo@kernel.org, kvm@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux@treblig.org, lucas.demarchi@intel.com,
 marcin.s.wojtas@gmail.com, ming.li@zohomail.com, mingo@kernel.org,
 mingo@redhat.com, netdev@vger.kernel.org, niecheng1@uniontech.com,
 oleksandr_tyshchenko@epam.com, pabeni@redhat.com, pbonzini@redhat.com,
 quic_ramess@quicinc.com, ragazenta@gmail.com, rodrigo.vivi@intel.com,
 seanjc@google.com, shenlichuan@vivo.com, simona@ffwll.ch,
 sstabellini@kernel.org, tglx@linutronix.de,
 thomas.hellstrom@linux.intel.com, vishal.l.verma@intel.com, x86@kernel.org,
 xen-devel@lists.xenproject.org, yujiaoliang@vivo.com, zhanjun@uniontech.com
Message-ID: <0b2ace38-07d9-4500-8bb7-5a4fa65c4b9f@uniontech.com>
Subject: Re: [PATCH v2 6/8] serial: 8250_dw: Fix typo "notifer"
References: <BD5C52D2838AEA48+20250715134050.539234-1-wangyuli@uniontech.com>
 <2BF1749F02ADE664+20250715134407.540483-6-wangyuli@uniontech.com>
 <2025071607-outbid-heat-b0ba@gregkh>
In-Reply-To: <2025071607-outbid-heat-b0ba@gregkh>

--------------7NzxUd2CIcc1X22DyUWciByd
Content-Type: multipart/mixed; boundary="------------3ELnNhbpHyc90r6KiSkcbbdY"

--------------3ELnNhbpHyc90r6KiSkcbbdY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgZ3JlZyBrLWgsDQoNCk9uIDIwMjUvNy8xNiAxNjowOCwgR3JlZyBLSCB3cm90ZToNCj4+
IFNpZ25lZC1vZmYtYnk6IFdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPg0KPiBJ
cyB5b3VyIG5hbWUgYWxsIG9uZSB3b3JkIGxpa2UgdGhhdCwgb3Igc2hvdWxkIHRoZXJlIGJl
IGEgIiAiIGJldHdlZW4NCj4gdGhlbT8NCg0KSWYgSSB3ZXJlIHRvIGZvbGxvdyBXZXN0ZXJu
IG5hbWluZyBjb252ZW50aW9ucywgbXkgbmFtZSB3b3VsZCBiZSB3cml0dGVuIA0KYXMgJ1l1
bGkgV2FuZycuDQoNCkhvd2V2ZXIsIGZyYW5rbHksIEkgZmluZCBpdCB1bm5lY2Vzc2FyeSBh
bmQgY2FuJ3QgYmUgYm90aGVyZWQgdG8gZm9sbG93IA0KdGhlaXIgY3VzdG9tcywgdW5sZXNz
IGEgbWFpbnRhaW5lciBzdHJvbmdseSBpbnNpc3RzLiAoRm9yIGV4YW1wbGUsIHlvdSANCmNh
biBzZWUgdGhhdCBteSBzaWduYXR1cmUgb24gY29tbWl0cyBmb3IgdGhlIExvb25nQXJjaCBz
dWJzeXN0ZW0gaXMgDQpkaWZmZXJlbnQgZnJvbSBteSBvdGhlciBjb250cmlidXRpb25zKS4N
Cg0KU2luY2UgQ2hpbmVzZSBuYW1lcyBhcmUgd3JpdHRlbiB3aXRob3V0IGFueSBzcGFjZXMg
aW4gQ2hpbmVzZSANCmNoYXJhY3RlcnMsIEkgZG9uJ3QgdGhpbmsgaXQgbWF0dGVycy4NCg0K
PiBBbHNvLCBhcyBvdGhlcnMgc2FpZCwgZG9uJ3QgbGluayB0byB5b3VyIG93biBwYXRjaC4N
Ck9LLCBJJ2xsIHNlbmQgdGhlIHBhdGNoc2V0IHYzLg0KDQoNClRoYW5rcywNCg0KLS0gDQrn
jovmmLHlipsNCg==
--------------3ELnNhbpHyc90r6KiSkcbbdY
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------3ELnNhbpHyc90r6KiSkcbbdY--

--------------7NzxUd2CIcc1X22DyUWciByd--

--------------1TBt0IFfjz321DLdIVEctMps
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCaH88KgUDAAAAAAAKCRDF2h8wRvQL7pms
AP9jnuV1Ar3880YbizkuBFljgc3bOdOu/RxLmWu2LJmNBAD/S6F38qLfKIrdjJNkNGO7V3LvW7p0
ssmAK5aDMMRZzAI=
=fJ9f
-----END PGP SIGNATURE-----

--------------1TBt0IFfjz321DLdIVEctMps--

