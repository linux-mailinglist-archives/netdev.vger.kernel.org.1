Return-Path: <netdev+bounces-207016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D24B053D5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C43168AE5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 07:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00F1260580;
	Tue, 15 Jul 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FmseD3ns"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F332376E4
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566131; cv=none; b=LCI2SbpNQt1OCTyCj9YTHx5ASPs3h3ok8+GB/rTJ/w3WYG9DVQTl1msL/Aoqz/AGKln5voP+X9QoIM73T1Qg9Vt6ktH1XSoIuarJ5NRmMepjwjz8WBBizwHJtnRKEfCz3A8O1TiP4FDYx9QOH5pjeUFAu/zMs+ohPBCfqkfYI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566131; c=relaxed/simple;
	bh=lCZvuab/16TaVwQ5rI7WJwbKeMlM/ItuANoajbv3L2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dD5y+g2UoT4j13XktS7kNNZI7s+RQt2cQymM7V1bMNzVgzkLJoT2Ecfo4XCDj5NuyQO4MFn0mlVro/kxDERIVFx1NgXZxNub4P7swejap2+NDFYe+ppKL5HxjjDEhLjOV4zkxvYRBuzmu9oRAhUncMrAhYc6Pu73KugxBgKfOl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FmseD3ns; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752566050;
	bh=lCZvuab/16TaVwQ5rI7WJwbKeMlM/ItuANoajbv3L2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=FmseD3nslxv2WzOPOC+m/8JJnbtV9dpKkZWoxzBSjrVBVk5mN+SV7+0j5XkqX+2+b
	 8ybQRaJcQ7hmUAHNRj2r8suwqLBppXBN2EdtKJ3nUE2UAdP14hivwz40UvdLzRsr4c
	 zfChanjJufiNdwK7r6BpEInwX5etTf4vnHzXrVTU=
X-QQ-mid: zesmtpip2t1752566003tb4774524
X-QQ-Originating-IP: jjkK/Vf4L74BdD9kpYPdRm9xTrp/Q9zcy1uOS8r9kg4=
Received: from [IPV6:240e:668:120a::212:232] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 15:53:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8211430334960576053
EX-QQ-RecipientCnt: 62
Message-ID: <5D06C25920559D71+06c9ce34-9867-495c-9842-dcfe9f1d51bb@uniontech.com>
Date: Tue, 15 Jul 2025 15:53:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] treewide: Fix typo "notifer"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, lucas.demarchi@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, airlied@gmail.com,
 simona@ffwll.ch, marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, arend.vanspriel@broadcom.com,
 ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
 jirislaby@kernel.org, jgross@suse.com, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, akpm@linux-foundation.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, ming.li@zohomail.com,
 linux-cxl@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, kvalo@kernel.org,
 johannes.berg@intel.com, quic_ramess@quicinc.com, ragazenta@gmail.com,
 jeff.johnson@oss.qualcomm.com, mingo@kernel.org, j@jannau.net,
 linux@treblig.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-serial@vger.kernel.org, xen-devel@lists.xenproject.org,
 shenlichuan@vivo.com, yujiaoliang@vivo.com, colin.i.king@gmail.com,
 cvam0000@gmail.com, zhanjun@uniontech.com, niecheng1@uniontech.com,
 guanwentao@uniontech.com
References: <B3C019B63C93846F+20250715071245.398846-1-wangyuli@uniontech.com>
 <2025071545-endnote-imprison-2b98@gregkh>
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
In-Reply-To: <2025071545-endnote-imprison-2b98@gregkh>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FHPp0EXrNW93l6uPQg7ZugeB"
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ONLy0qlCLoJgHXaqiT5FGzwH3XheCHXfijw3oYXb5k6a8yNcetl9ldHL
	ejcBmphf81LKaj/GAkUSdSVGDMF3hN4OT7Ep+8JeeXQE6gg+V/t/rjGnl/Q1dmB2KkHyktN
	vxvanjRFofJUJ06iVK1c4RbcsFU4xR4Zy055T2a9mel665jgQZFPqKh+D4OP68sfVzsT12w
	jJdNG4yLPYihKutSgEnJ1GYDWPa+d+4bI4LUmY4Orh/AaLbJsCMUmQlA/oNAd/5d+4KlGCe
	bMClMjgQc8hnIzizLmmKYwJpHxXtbGsYJO4AZvNAPVRvmD9c2oC4bNKMnJykKgjU1vSBrB7
	MMbn9UhV2L/TIcqyjxA55bbhHogRftswqdLbMNWn6wQRNib8+kiZPtfiH23lvb9FXCNOBoW
	c1O+iHRPi1SUEYuNd9qIw8ROmS4SU7hqQjTdOiDJde/JPgZwza7x1+QIZ8qjigweBgnFsYx
	ZUasGm1eatuq3/j8CzE2oT0FB+f6HvC6rQUO9dcRBCUyIFmvRFtjZcLWYwpwbUoQWnhDPv8
	Op8COkrmf0sm42K96mQqBd1juTSD8tuSxdrBwlJJXRl/PbAN7e/ADzVoWJYNL9LBSOt0b/K
	E0d0uUF1vKixVTJ/TibkjqAyFidSAHQghbaki1NJNQn1hckaOirbjncnLany07J3uXyaLkz
	6Fys7TtRk3/FJ/vwFbHuB7cl1/mXpW/lzcdMnwSKN5bNH9k0cEUNHVmls6V2WKppSGYyk7q
	HXF+xPg79vTsbXNF5tVU7OLQUdrzfgaz7hCrL5136Eb1z30v2nHtosuHS3tZiApYxkplY5q
	m7KR+HWE1v4GjpF7v9UMOPTmNcOkRCQ629ZglA1A/+W1cknxMHbvcFN9g+Vhl7k8VTKdBtC
	nyTOmx3+FYqcVy0mB4MIiTZ2Vd5ipQ7vUJ70fbDQwcmoHk05qkwIyH1AVZaZzHSHjy1tElU
	1Bi7iBuxkkdj8d2/aa1axK8truihRj74wjLND/Xj3tSnVoKs3y9rTvYnuEBxA5D57/4j5j/
	/3fXKLHluNWfThLxFtxX0PaFXSmnqxL3Est7TvrKz1ZQlYZ+ahb7iUI4uSehA+uGH0GE3o+
	t20Oj8YR8SXxBmSDz14Bdylu9w9NOrO4KV2KepjqYP7
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FHPp0EXrNW93l6uPQg7ZugeB
Content-Type: multipart/mixed; boundary="------------Jc6hPek6M3VHoBxxe00gmN7f";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, lucas.demarchi@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, airlied@gmail.com,
 simona@ffwll.ch, marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, arend.vanspriel@broadcom.com,
 ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
 jirislaby@kernel.org, jgross@suse.com, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, akpm@linux-foundation.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, ming.li@zohomail.com,
 linux-cxl@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, kvalo@kernel.org,
 johannes.berg@intel.com, quic_ramess@quicinc.com, ragazenta@gmail.com,
 jeff.johnson@oss.qualcomm.com, mingo@kernel.org, j@jannau.net,
 linux@treblig.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-serial@vger.kernel.org, xen-devel@lists.xenproject.org,
 shenlichuan@vivo.com, yujiaoliang@vivo.com, colin.i.king@gmail.com,
 cvam0000@gmail.com, zhanjun@uniontech.com, niecheng1@uniontech.com,
 guanwentao@uniontech.com
Message-ID: <06c9ce34-9867-495c-9842-dcfe9f1d51bb@uniontech.com>
Subject: Re: [PATCH] treewide: Fix typo "notifer"
References: <B3C019B63C93846F+20250715071245.398846-1-wangyuli@uniontech.com>
 <2025071545-endnote-imprison-2b98@gregkh>
In-Reply-To: <2025071545-endnote-imprison-2b98@gregkh>

--------------Jc6hPek6M3VHoBxxe00gmN7f
Content-Type: multipart/mixed; boundary="------------sUIOFoVilt68TT8Wt0dx0iNl"

--------------sUIOFoVilt68TT8Wt0dx0iNl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgZ3JlZyBrLWgsDQoNCk9uIDIwMjUvNy8xNSAxNToyMiwgR3JlZyBLSCB3cm90ZToNCj4g
UGxlYXNlIGJyZWFrIHRoaXMgdXAgaW50byBvbmUtcGF0Y2gtcGVyLXN1YnN5c3RlbSwgbGlr
ZSBpcyByZXF1aXJlZCBmb3INCj4gdGhpbmdzIGxpa2UgdGhpcy4NCj4NCj4gdGhhbmtzLA0K
Pg0KPiBncmVnIGstaA0KPg0KSG9uZXN0bHksIEkndmUgYWx3YXlzIGJlZW4gcXVpdGUgdW5z
dXJlIGhvdyB0byBoYW5kbGUgc2l0dWF0aW9ucyBsaWtlIHRoaXMuDQoNCkl0IHNlZW1zIGV2
ZXJ5IHN1YnN5c3RlbSBtYWludGFpbmVyIGhhcyBkaWZmZXJlbnQgcHJlZmVyZW5jZXMuIEkn
dmUgDQpwcmV2aW91c2x5IGVuY291bnRlcmVkIHNvbWUgbWFpbnRhaW5lcnMgd2hvIHN1Z2dl
c3RlZCBJIHNwbGl0IHN1Y2ggDQpwYXRjaGVzIGJ5IHN1YnN5c3RlbSBzbyBlYWNoIG1haW50
YWluZXIgY291bGQgbWVyZ2UgdGhlbSBpbnRvIHRoZWlyIHRyZWUgDQp3aXRob3V0IGNvbnRl
bnRpb24uIEhvd2V2ZXIsIG90aGVyIG9uZXMgaGF2ZSBhcmd1ZWQgdGhhdCBmaXhpbmcgc3Bl
bGxpbmcgDQplcnJvcnMgaXNuJ3Qgd29ydGggbXVsdGlwbGUgY29tbWl0cywgY2xhaW1pbmcg
aXQgd291bGQgY3JlYXRlIGNoYW9zLg0KDQpTaW5jZSBJIGdlbnVpbmVseSBkaXNjb3ZlciB0
aGVzZSBzcGVsbGluZyBlcnJvcnMgYnkgY2hhbmNlIGVhY2ggdGltZSwgDQphbmQgdG8gYXZv
aWQgZ2l2aW5nIHRoZSBpbXByZXNzaW9uIEknbSAic3BhbW1pbmciIHRoZSBrZXJuZWwgdHJl
ZSBmb3IgDQpzb21lIHVsdGVyaW9yIG1vdGl2ZSwgSSd2ZSBvcHRlZCB0byBzcXVhc2ggdGhl
bSBpbnRvIGEgc2luZ2xlIGNvbW1pdC4NCg0KVGhhdCBzYWlkLCBJIHBlcnNvbmFsbHkgZG9u
J3QgaGF2ZSBhbnkgc3Ryb25nIGZlZWxpbmdzIG9yIHByZWZlcmVuY2VzIG9uIA0KdGhpcyBt
YXR0ZXIuIFNpbmNlIHlvdSd2ZSByZXF1ZXN0ZWQgaXQsIEknbGwgZ28gYWhlYWQgYW5kIHNw
bGl0IGl0IHVwIA0KYW5kIHNlbmQgYSB2MiBwYXRjaHNldC4NCg0KVGhhbmtzLA0KDQotLSAN
CldhbmdZdWxpDQo=
--------------sUIOFoVilt68TT8Wt0dx0iNl
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

--------------sUIOFoVilt68TT8Wt0dx0iNl--

--------------Jc6hPek6M3VHoBxxe00gmN7f--

--------------FHPp0EXrNW93l6uPQg7ZugeB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCaHYI7gUDAAAAAAAKCRDF2h8wRvQL7oEn
AP9MLViBb0RqjK9xx+PcIi0hiZmUC/37qYH8rnmPBkSAXQEAtm2V/wO2Wv0JvbeWgMrpl99ZvtNN
kg8rYtwbJwIkrA4=
=lTpo
-----END PGP SIGNATURE-----

--------------FHPp0EXrNW93l6uPQg7ZugeB--

