Return-Path: <netdev+bounces-174954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5CEA6191B
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 19:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAA53B6B49
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 18:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B173F204581;
	Fri, 14 Mar 2025 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="AhVe969j"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668920296A;
	Fri, 14 Mar 2025 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975932; cv=none; b=gC96ioJ69BPXBJRRQnTcc1bj0A/ZTmzmjkhRPlXimM5AruOC020hPJqmY8wJm02pJfYmpoPhcgiaIvIoMqPRK3zL/+qic0iRzWlEub7J3jvuhZcItUMiItXJ7L85ZfObdyUGHGwEgKAerJ08K7DMkBRRQsEJyJIM62GfNfjDX1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975932; c=relaxed/simple;
	bh=IpA/1clA163d2frM57ZM3+13u4PilBvKUZY//Lfw3ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfbMxv50fERaqgMslfBhvIxfQYul0lRUK0jr8yT89a9QKiaqZ/xHT3nUdZi8ea25yCAP0xIIFKULWrcPM+jQjtdSJyYNP/3M/32zS2yCDOLNIwjHPjKCklrC8vtbjmOzAPpOtKR3kfKlWg282dk7c1OYZyezrDjYiDn3h4jfX2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=AhVe969j; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741975848;
	bh=IpA/1clA163d2frM57ZM3+13u4PilBvKUZY//Lfw3ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=AhVe969jUzK101QPvAon2jd4JO0HoElkaOFRm1LCB8+UZYwchro8E52TzRgz+fbhB
	 gcEQaifhB9bT7fdhEKVZEN7VG4zy2stkX5PMl5TonO4fidz14g0PpMpn+IFC6PPKie
	 EI4Q8un1SE0mAhuU2l2xwW+nQ1Y1hP4/mqFdraPk=
X-QQ-mid: bizesmtpip2t1741975803t59nigd
X-QQ-Originating-IP: 2QpbIc18kiB+486NM33X2CmpDcFaQmaiaCCU1pptmaY=
Received: from [IPV6:240e:668:120a::212:156] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 15 Mar 2025 02:10:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12078174169830820588
Message-ID: <6AA7B21381EAEF29+021f9ac2-9ea7-41e0-ac14-c033d214f659@uniontech.com>
Date: Sat, 15 Mar 2025 02:10:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] mlxsw: spectrum_acl_bloom_filter: Expand
 chunk_key_offsets[chunk_index]
To: Ido Schimmel <idosch@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch,
 chenlinxuan@uniontech.com, czj2441@163.com, davem@davemloft.net,
 edumazet@google.com, guanwentao@uniontech.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 niecheng1@uniontech.com, petrm@nvidia.com, zhanjun@uniontech.com
References: <484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com>
 <78951564F9FEA017+20250311141701.1626533-1-wangyuli@uniontech.com>
 <Z9GKE-mP3qbmK9cL@shredder> <70a2fa44-c0cf-4dd4-8c17-8cc7abf1fbce@redhat.com>
 <Z9L43xpibqHZ07vW@shredder>
 <8563032ED2B6B840+7af17f62-992a-4275-80c7-ac7ef5276ae7@uniontech.com>
 <Z9M1A8lOuXE4UkyR@shredder>
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
In-Reply-To: <Z9M1A8lOuXE4UkyR@shredder>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Iy7ARFIEYg0nE9BvEA1IEE5H"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MNRAIz40LlBG8xMlsXjry2UfWQxg1srMrpfNF56SDyIjj6ypdTIJZU1s
	eQ+tmXHJsNM6CkOceOYe8hlGYKXSt/HnEUdeYWiewYfMvipXGLnObTg6DCS50d3Oh9zZ9J9
	s5725lybujzuMJV5Ie4y9BP5Azza6hSOwwkPYdXNXY6b5aRHcnEl+v6pdnRGbCd60XCiUZ/
	G2s2hXkoLua0XdwU2z1KSClvBx9Eu/UdACs1IK9kd2jUolatUZ107b5dS7FiqBFg9ew3XSe
	eEZQIcqm/nfm0a5yb2yUcw/UVkxYiB7uYveRmL43y2LkJgRfp1yT6PdcZIvUMpfzBdTNB/r
	0lJvle8yMyM7xjkEhFCBq8rzDDNFg5MtcGyNuuL+pChxcZFxffvAMSG2j1y1v18Hsfdxp+D
	zZzowtKzj1Yvbv+988gTF2BlSracQzuEY5bhyRdmzuyXvTF7nUP3GJ/chtw0OAKl2il0YhW
	xGv4la3qy3SCiXm/sBSWBif/qjKNEpbH1q9tI6v7oJt21f+vdJUpXNTKlwrCHQcQFRV4/T8
	qyXe+lid4DXJldMNzJw9r9XT30NOmObImJX3z/H1V753bU4fywkDjslVCOGwiuV6yrcyjVo
	JZD0219G/aWpwtCQDtdZ2vllCN9THdZIgECfONURNYLQMvmuwahj9tuYsvH5w1H5ntduNOR
	AE9aLPQ9hCKY2k+F53UqBowzgyl9e4iTlaUsEt+Eq20m+DY3fGGVARRsRHTvbcQrk+W5A13
	Gk38SbVk17VA3LudO38rHznIupmTJaCYXI4s8IvyaHGhxho2O5gcpLJ+fssAf4QbBi3FCPh
	a8wsabUuzmziKMUGy3fDxzuOsHkm/eKIEkOR+RS4ZBV5a+aPfBKElfHKsYhESnPCt8vEyrS
	v/2TcEyTDVL0DSS2j0vXy8gTiS3L1QksxPoKEoktxnixa3G4AABYCpOXL9RTd+C16zP5wVP
	Ply4jLszhYPfO56AC/9YJxNY/efRWaNTQHhj9twL4hs7qzBc1ITnVU4EAKVyJ4baihjq6QZ
	BhykDUxHHaCx552FcKv/Bj5MG6+s4gWiHqw6bPGjGAnXelpnQx
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Iy7ARFIEYg0nE9BvEA1IEE5H
Content-Type: multipart/mixed; boundary="------------sr2n6eDcWLKVgTFBWT5ngYiC";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch,
 chenlinxuan@uniontech.com, czj2441@163.com, davem@davemloft.net,
 edumazet@google.com, guanwentao@uniontech.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 niecheng1@uniontech.com, petrm@nvidia.com, zhanjun@uniontech.com
Message-ID: <021f9ac2-9ea7-41e0-ac14-c033d214f659@uniontech.com>
Subject: Re: [PATCH net 1/2] mlxsw: spectrum_acl_bloom_filter: Expand
 chunk_key_offsets[chunk_index]
References: <484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com>
 <78951564F9FEA017+20250311141701.1626533-1-wangyuli@uniontech.com>
 <Z9GKE-mP3qbmK9cL@shredder> <70a2fa44-c0cf-4dd4-8c17-8cc7abf1fbce@redhat.com>
 <Z9L43xpibqHZ07vW@shredder>
 <8563032ED2B6B840+7af17f62-992a-4275-80c7-ac7ef5276ae7@uniontech.com>
 <Z9M1A8lOuXE4UkyR@shredder>
In-Reply-To: <Z9M1A8lOuXE4UkyR@shredder>

--------------sr2n6eDcWLKVgTFBWT5ngYiC
Content-Type: multipart/mixed; boundary="------------0m8Yoj3ZAD3F0nhi08CcGb8G"

--------------0m8Yoj3ZAD3F0nhi08CcGb8G
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSWRvIFNjaGltbWVsLA0KDQpPbiAyMDI1LzMvMTQgMDM6NDEsIElkbyBTY2hpbW1lbCB3
cm90ZToNCj4gUGxlYXNlIHVzZSBwbGFpbiB0ZXh0IGVtYWlscy4NCj4NCk9LDQo+IEl0IHBh
c3NlZCB3aXRoIGNsYW5nIDE4IG9uIEZlZG9yYSA0MCwgYnV0IG5vdyBJIHRlc3RlZCB3aXRo
IGNsYW5nIDE5IG9uDQo+IEZlZG9yYSA0MSBhbmQgaXQncyBpbmRlZWQgZmFpbGluZy4NCj4N
Cj4gSG93IGFib3V0IFsxXT8gSXQncyBzaW1pbGFyIHRvIHlvdXJzIGFuZCBwYXNzZXMgd2l0
aCBib3RoIGNsYW5nDQo+IHZlcnNpb25zLg0KDQpJbmRlZWQsIHRoaXMgaXRlcmF0aW9uIGNv
bXBpbGVzIGNsZWFubHkgd2l0aCBjbGFuZy0xOS4NCg0KTXkgYXBvbG9naWVzIGZvciB0aGUg
ZGVsYXllZCByZXNwb25zZTsgSSd2ZSBkaXNjb3ZlcmVkIHNvbWV0aGluZyByYXRoZXIgDQpt
b3JlIHVuZXhwZWN0ZWQgYW5kIG9kZC4NCg0KVG8gYmUgcHJlY2lzZSwgdGhlIG9yaWdpbmFs
LCB1bm1vZGlmaWVkIGNvZGUgYnVpbGRzIHN1Y2Nlc3NmdWxseSBvbiBib3RoIA0KdGhlIHJl
Y2VudGx5IHJlbGVhc2VkIGNsYW5nLTIwIGFuZCB0aGUgb25nb2luZyBkZXZlbG9wbWVudCBv
ZiBjbGFuZy0yMS4gWzFdDQoNClRoaXMgc3Ryb25nbHkgcG9pbnRzIHRvIGEgY2xhbmctc3Bl
Y2lmaWMgY29tcGlsZXIgYnVnIHRoYXQgb25seSBpbXBhY3RzIA0KY2xhbmctMTkgYW5kIGVh
cmxpZXIgdmVyc2lvbnMgKGFuZCBpdCBhcHBlYXJzIGV2ZW4gY2xhbmctMTggYW5kIGNsYW5n
LTE5IA0Kc2hvdyBkaWZmZXJlbnQgYmVoYXZpb3IgYWNjb3JkaW5nIHRvIHlvdXIgZmluZGlu
Z3MpLi4uDQoNCkknbSBzb21ld2hhdCBhdCBhIGxvc3MgZm9yIHdvcmRzIHJlZ2FyZGluZyB0
aGlzLA0KDQpidXQgaWYgd2UgaW50ZW5kIGZvciB0aGlzIGRyaXZlciB0byBjb21waWxlIG9u
IHMzOTB4IHdpdGggY2xhbmctMTkgKGFzIA0Kb3V0bGluZWQgaW4gdGhlIGNvdmVyIGxldHRl
ciBvZiB0aGlzIHBhdGNoIHNldCwgd2Ugc2hvdWxkIHN0cml2ZSB0byANCnN1cHBvcnQgYW55
IHBvc3NpYmxlIGNvbWJpbmF0aW9ucyB0aGF0IHRoZSBMaW51eCBrZXJuZWwgcHJvamVjdCBl
bmRvcnNlcyksDQoNCm1heWJlIGl0J3Mgc3RpbGwgYmV0dGVyIHRvIGFwcGx5IHRoaXMgY2hh
bmdlLi4uLi4uDQoNClsxXS4gTXkgTGludXggZGlzdHJpYnV0aW9uIGlzIERlYmlhbiBzaWQs
IGFuZCBJJ20gZ2V0dGluZyBhIG1vcmUgcmVjZW50IA0KY2xhbmcgY29tcGlsZXIgZnJvbSB0
aGUgZm9sbG93aW5nIGxpbmssIHdoaWNoIGlzIG5ld2VyIHRoYW4gd2hhdCdzIA0KcHJvdmlk
ZWQgaW4gdGhlIGRpc3RyaWJ1dGlvbidzIHBhY2thZ2UgcmVwb3NpdG9yaWVzOiBodHRwczov
L2FwdC5sbHZtLm9yZy8NCg0KPiBUaGFua3MNCj4NCj4gWzFdDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHhzdy9zcGVjdHJ1bV9hY2xfYmxvb21f
ZmlsdGVyLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHhzdy9zcGVjdHJ1
bV9hY2xfYmxvb21fZmlsdGVyLmMNCj4gaW5kZXggYTU0ZWVkYjY5YTNmLi45YzU0ZGJhNWFk
MTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seHN3
L3NwZWN0cnVtX2FjbF9ibG9vbV9maWx0ZXIuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tZWxsYW5veC9tbHhzdy9zcGVjdHJ1bV9hY2xfYmxvb21fZmlsdGVyLmMNCj4gQEAg
LTIxMiw3ICsyMTIsMjIgQEAgc3RhdGljIGNvbnN0IHU4IG1seHN3X3NwNF9hY2xfYmZfY3Jj
Nl90YWJbMjU2XSA9IHsNCj4gICAgKiBUaGlzIGFycmF5IGRlZmluZXMga2V5IG9mZnNldHMg
Zm9yIGVhc3kgYWNjZXNzIHdoZW4gY29weWluZyBrZXkgYmxvY2tzIGZyb20NCj4gICAgKiBl
bnRyeSBrZXkgdG8gQmxvb20gZmlsdGVyIGNodW5rLg0KPiAgICAqLw0KPiAtc3RhdGljIGNv
bnN0IHU4IGNodW5rX2tleV9vZmZzZXRzW01MWFNXX0JMT09NX0tFWV9DSFVOS1NdID0gezIs
IDIwLCAzOH07DQo+ICtzdGF0aWMgY2hhciAqDQo+ICttbHhzd19zcF9hY2xfYmZfZW5jX2tl
eV9nZXQoc3RydWN0IG1seHN3X3NwX2FjbF9hdGNhbV9lbnRyeSAqYWVudHJ5LA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdTggY2h1bmtfaW5kZXgpDQo+ICt7DQo+ICsgICAg
ICAgc3dpdGNoIChjaHVua19pbmRleCkgew0KPiArICAgICAgIGNhc2UgMDoNCj4gKyAgICAg
ICAgICAgICAgIHJldHVybiAmYWVudHJ5LT5odF9rZXkuZW5jX2tleVsyXTsNCj4gKyAgICAg
ICBjYXNlIDE6DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gJmFlbnRyeS0+aHRfa2V5LmVu
Y19rZXlbMjBdOw0KPiArICAgICAgIGNhc2UgMjoNCj4gKyAgICAgICAgICAgICAgIHJldHVy
biAmYWVudHJ5LT5odF9rZXkuZW5jX2tleVszOF07DQo+ICsgICAgICAgZGVmYXVsdDoNCj4g
KyAgICAgICAgICAgICAgIFdBUk5fT05fT05DRSgxKTsNCj4gKyAgICAgICAgICAgICAgIHJl
dHVybiAmYWVudHJ5LT5odF9rZXkuZW5jX2tleVswXTsNCj4gKyAgICAgICB9DQo+ICt9DQo+
ICAgDQo+ICAgc3RhdGljIHUxNiBtbHhzd19zcDJfYWNsX2JmX2NyYzE2X2J5dGUodTE2IGNy
YywgdTggYykNCj4gICB7DQo+IEBAIC0yNDUsMTIgKzI2MCwxMyBAQCBfX21seHN3X3NwX2Fj
bF9iZl9rZXlfZW5jb2RlKHN0cnVjdCBtbHhzd19zcF9hY2xfYXRjYW1fcmVnaW9uICphcmVn
aW9uLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoYXJlZ2lvbi0+
cmVnaW9uLT5pZCA8PCA0KSk7DQo+ICAgICAgICAgIGZvciAoY2h1bmtfaW5kZXggPSBtYXhf
Y2h1bmtzIC0gY2h1bmtfY291bnQ7IGNodW5rX2luZGV4IDwgbWF4X2NodW5rczsNCj4gICAg
ICAgICAgICAgICBjaHVua19pbmRleCsrKSB7DQo+ICsgICAgICAgICAgICAgICBjaGFyICpl
bmNfa2V5Ow0KPiArDQo+ICAgICAgICAgICAgICAgICAgbWVtc2V0KGNodW5rLCAwLCBwYWRf
Ynl0ZXMpOw0KPiAgICAgICAgICAgICAgICAgIG1lbWNweShjaHVuayArIHBhZF9ieXRlcywg
JmVycF9yZWdpb25faWQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihlcnBf
cmVnaW9uX2lkKSk7DQo+IC0gICAgICAgICAgICAgICBtZW1jcHkoY2h1bmsgKyBrZXlfb2Zm
c2V0LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICZhZW50cnktPmh0X2tleS5lbmNfa2V5
W2NodW5rX2tleV9vZmZzZXRzW2NodW5rX2luZGV4XV0sDQo+IC0gICAgICAgICAgICAgICAg
ICAgICAgY2h1bmtfa2V5X2xlbik7DQo+ICsgICAgICAgICAgICAgICBlbmNfa2V5ID0gbWx4
c3dfc3BfYWNsX2JmX2VuY19rZXlfZ2V0KGFlbnRyeSwgY2h1bmtfaW5kZXgpOw0KPiArICAg
ICAgICAgICAgICAgbWVtY3B5KGNodW5rICsga2V5X29mZnNldCwgZW5jX2tleSwgY2h1bmtf
a2V5X2xlbik7DQo+ICAgICAgICAgICAgICAgICAgY2h1bmsgKz0gY2h1bmtfbGVuOw0KPiAg
ICAgICAgICB9DQo+ICAgICAgICAgICpsZW4gPSBjaHVua19jb3VudCAqIGNodW5rX2xlbjsN
Cj4NClRoYW5rcw0KLS0gDQpXYW5nWXVsaQ0K
--------------0m8Yoj3ZAD3F0nhi08CcGb8G
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

--------------0m8Yoj3ZAD3F0nhi08CcGb8G--

--------------sr2n6eDcWLKVgTFBWT5ngYiC--

--------------Iy7ARFIEYg0nE9BvEA1IEE5H
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ9Rw+QUDAAAAAAAKCRDF2h8wRvQL7mZr
AP0QKxKsim2EPiC2I1QWBiDmPvLBlq3VDClwnJDLMmIZxQEAsIfSJUe8DBkgEMuo4dNkNeGPWhaG
R9C1d2YxYX9b+wM=
=91nv
-----END PGP SIGNATURE-----

--------------Iy7ARFIEYg0nE9BvEA1IEE5H--

