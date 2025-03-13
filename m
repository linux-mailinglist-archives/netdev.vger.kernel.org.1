Return-Path: <netdev+bounces-174645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60340A5FB20
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DAE1888AA9
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC4E269B0E;
	Thu, 13 Mar 2025 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FtuwpaN0"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA372690F4;
	Thu, 13 Mar 2025 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882372; cv=none; b=TbpIKqifQrgeuJPIedG0HKmISMyq95ooPNq6EkD8iQ2J9gobxdsOo1xlpmsic/IB+dPgIjMWPHFSurgTKz4is4Acwle6evvItJ9YldTR6L5c1uqQkcu/9oKxfZYC85pDCuwQQVqCox/0nMe0uMREDODXtiXINU1rg8tn2aNuXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882372; c=relaxed/simple;
	bh=5WTjyQjqiZlITXL/Hqqnhk2xRpGKhNIkm0JjXZTIGFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIgEe0Vb6XUfyISEuhtinSHJpxjw9yGYNYwc+lQfWGOum0RXflkUmGd73JCpBPz2+UiDHq45rspt3YpL5Zp1PibuThOzYSDaXF0ovGloUv1UH6CGRk10Q0zWPMZl70SPHfizYISz27TuHoFvv5j3hxpdBSQ+vhfsKLOCgqXIt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FtuwpaN0; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741882292;
	bh=QN+pqP5WGQxw5m+xISBGa0dBdHFpjziMM8lqs45W21k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=FtuwpaN0MLz1qkVwEkgM0kVPe0OMMG0RK3uLnFESmSnB2cHLWYCFTKW2FJvGK2r9e
	 BiG8kRprxN8mvZzGy088Kr9ee/Em1UujP1lFVEmNxl9vqjuUo6joMxE3jd5wKcy312
	 Ty3h+eZxRQ7LDZpYjCemwRwrtD6IvZaPd6sbBnII=
X-QQ-mid: bizesmtpip2t1741882244t1ooon7
X-QQ-Originating-IP: mTyvzFoj2eAkBSqSL+st6jNWXUYoEKlLxLkaiL6XBYs=
Received: from [IPV6:240e:36c:d16:500:4589:e5b ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 14 Mar 2025 00:10:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5201203476452846978
Message-ID: <8563032ED2B6B840+7af17f62-992a-4275-80c7-ac7ef5276ae7@uniontech.com>
Date: Fri, 14 Mar 2025 00:10:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] mlxsw: spectrum_acl_bloom_filter: Expand
 chunk_key_offsets[chunk_index]
To: Ido Schimmel <idosch@nvidia.com>, Paolo Abeni <pabeni@redhat.com>
Cc: andrew+netdev@lunn.ch, chenlinxuan@uniontech.com, czj2441@163.com,
 davem@davemloft.net, edumazet@google.com, guanwentao@uniontech.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 niecheng1@uniontech.com, petrm@nvidia.com, zhanjun@uniontech.com
References: <484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com>
 <78951564F9FEA017+20250311141701.1626533-1-wangyuli@uniontech.com>
 <Z9GKE-mP3qbmK9cL@shredder> <70a2fa44-c0cf-4dd4-8c17-8cc7abf1fbce@redhat.com>
 <Z9L43xpibqHZ07vW@shredder>
From: WangYuli <wangyuli@uniontech.com>
Content-Language: en-US
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <Z9L43xpibqHZ07vW@shredder>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CZDE3t3J09XbRT611EWB2l2u"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OPGrLrMdbUDMGI+pjYZK/iY9rGaYRBBBIBzai7yBlWGcoBjLzLLM5QSM
	gRvG7y0jJu9raeQvvST2R7TKTZQcj+QRTuBWboTE14c9QEw44vzlMxyuHqe9soVngEVSlW+
	r+dhWa+uIib1r2tyU8TVmlQEjZij09Ay8bEc11MXy0bIAMKyk5kO5K7v3DBHv3BrQcX0AmV
	2bPWcHHOCW5xYnWgbLjiH+uQAlqtMtaowU/6hCPTZih7xuscjzc4t4N1/nKekMPjQ9x09Jp
	GxedUJOFmYRVKFj8T+WHTlbccrH66gWaOXTsxNK1nuVRh7gUlz/zjcmtrVHPH10gtfQEHw7
	HVu5/1+wUIUUEIBUkYIsIu1MC6kcIg0p/OtSSyOZf47ZAMy2G5GtMjMZ9A0uR/I7tooHXA2
	uI9k89ozLkqTAjAUycKAzwFzOy94wuCzc1M5b9tWBvQlkkVKSUfuzcK0fEryG67lGBuYOpd
	epjNANZeN95mvZE5LJ7sSBIxyyMgar7LcBLOBPMZqI3pEgxSiSLe8OwZ17apnJZkSKG4l7E
	MhZEto7VAM6U1gB4NcDdAC2p/b3RVofdZs2TlsU4T4lW1WIAnF92Hopby1Woc3B3oeADQJI
	/jkd5svekJarnqu7lSupJaUTCRgrIdSDOsGjhdLF2e3g58bifdDzzOQD4jzy1+b34yAZNBY
	Agg/QXJsvzR0O+WoguTxetZFbIhm9KbOHbS059ju5aNo5PG+FwfjXtIv3Wa3/MJ1wyNPOZy
	I/aNNV8NoAbE4lXPlc3C+c7d4hpNpmsRoQoK+C9W1WCI6DDORY9+cv47Yn7bL7qrACD3RZy
	ZzhUUHT4IVi9yJdqklUGVIq+O9qDbdg2aTfYl7dO6yUyhUN2h79Jupmdil7gW1FiJ/vk6lc
	2rorxcnihJ8GennsvQ7CENMj3Oh5vWfBRNP3RpDO8mAUuozZD14TbzzIUXdmJIecbhA+Mgc
	8kTXN7fffdt40XNhRMPmZYMZ9iaGHAmb3OsdAYZJUKAeSaXC5e6hswghR5SlADvydLSIb7s
	aarUxuF/S8y35CzqnvswbIzBNiryNGGCiCwSWgKvfWkgJS0BvGO/moKKwk/1VT6s8GLACOt
	Xu8ueSkWxBDPJleJ0vzJfo=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CZDE3t3J09XbRT611EWB2l2u
Content-Type: multipart/mixed; boundary="------------zkLbIZBFofBxPl5MmnWbCdGZ";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Ido Schimmel <idosch@nvidia.com>, Paolo Abeni <pabeni@redhat.com>
Cc: andrew+netdev@lunn.ch, chenlinxuan@uniontech.com, czj2441@163.com,
 davem@davemloft.net, edumazet@google.com, guanwentao@uniontech.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 niecheng1@uniontech.com, petrm@nvidia.com, zhanjun@uniontech.com
Message-ID: <7af17f62-992a-4275-80c7-ac7ef5276ae7@uniontech.com>
Subject: Re: [PATCH net 1/2] mlxsw: spectrum_acl_bloom_filter: Expand
 chunk_key_offsets[chunk_index]
References: <484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com>
 <78951564F9FEA017+20250311141701.1626533-1-wangyuli@uniontech.com>
 <Z9GKE-mP3qbmK9cL@shredder> <70a2fa44-c0cf-4dd4-8c17-8cc7abf1fbce@redhat.com>
 <Z9L43xpibqHZ07vW@shredder>
In-Reply-To: <Z9L43xpibqHZ07vW@shredder>

--------------zkLbIZBFofBxPl5MmnWbCdGZ
Content-Type: multipart/mixed; boundary="------------SdEWfqeqxLIUntY2Kr3is73x"

--------------SdEWfqeqxLIUntY2Kr3is73x
Content-Type: multipart/alternative;
 boundary="------------U72oK4dhadUK2E63rCcS0hmG"

--------------U72oK4dhadUK2E63rCcS0hmG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSWRvIFNjaGltbWVsLA0KDQpPbiAyMDI1LzMvMTMgMjM6MjUsIElkbyBTY2hpbW1lbCB3
cm90ZToNCj4gSSB3b3VsZCBsaWtlIHRvIGdldCBhIHdhcm5pbmcgaWYgJ2NodW5rX2NvdW50
JyBpcyBsYXJnZXIgdGhhbg0KPiAnTUxYU1dfQkxPT01fS0VZX0NIVU5LUycgc2luY2UgaXQg
c2hvdWxkIG5ldmVyIGhhcHBlbi4NCj4NCj4gSSB3YXMgYWJsZSB0byByZXByb2R1Y2UgdGhl
IGJ1aWxkIGZhaWx1cmUgYW5kIHRoZSBmb2xsb3dpbmcgcGF0Y2ggc2VlbXMNCj4gdG8gc29s
dmUgaXQgZm9yIG1lLiBJdCByZW1vdmVzIHRoZSAnbWF4X2NodW5rcycgYXJndW1lbnQgc2lu
Y2UgaXQncw0KPiBhbHdheXMgJ01MWFNXX0JMT09NX0tFWV9DSFVOS1MnICgzKSBhbmQgdmVy
aWZpZXMgdGhhdCB0aGUgbnVtYmVyIG9mDQo+IGNodW5rcyB0aGF0IHdhcyBjYWxjdWxhdGVk
IGlzIG5ldmVyIGdyZWF0ZXIgdGhhbiBpdC4NCj4NCj4gV2FuZ1l1bGksIGNhbiB5b3UgcGxl
YXNlIHRlc3QgaXQ/DQoNCk15IHRlc3RzIHN0aWxsIHNob3cgdGhlIHNhbWUgY29tcGlsYXRp
b24gZmFpbGluZy4NCg0KSW5kZWVkLCBJIGhhdmUgYWxyZWFkeSB0cmllZCBzaW1pbGFyIGZp
eGVzIGR1cmluZyBteSBpbnZlc3RpZ2F0aW9uLCBidXQgDQp0byBubyBhdmFpbC4NCg0KPiBB
bHNvLCBpZiB5b3Ugd2FudCBpdCBpbiBuZXQuZ2l0IChhcyBvcHBvc2VkIHRvIG5ldC1uZXh0
LmdpdCksIHRoZW4gaXQNCj4gbmVlZHMgYSBGaXhlcyB0YWc6DQo+DQo+IEZpeGVzOiA3NTg1
Y2FjZGI5NzggKCJtbHhzdzogc3BlY3RydW1fYWNsOiBBZGQgQmxvb20gZmlsdGVyIGhhbmRs
aW5nIikNCk9LDQo+DQo+IEFuZCBJIGRvbid0IHRoaW5rIHdlIG5lZWQgcGF0Y2ggIzIuDQpX
aGlsZSAjMiBpcyBhZG1pdHRlZGx5IGEgc2Vjb25kYXJ5IG1vZGlmaWNhdGlvbiBjb21wYXJl
ZCB0byAjMSwgc2hvdWxkIA0KeW91IGJlIGFncmVlYWJsZSwgSSBiZWxpZXZlIGl0J3Mgc3Rp
bGwgcHJlZmVyYWJsZSB0byBjb21iaW5lICMyIHdpdGggIzEgDQppbnN0ZWFkIG9mIG91dHJp
Z2h0IGRpc2NhcmRpbmcgIzIuDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tZWxsYW5veC9tbHhzdy9zcGVjdHJ1bV9hY2xfYmxvb21fZmlsdGVyLmMgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHhzdy9zcGVjdHJ1bV9hY2xfYmxvb21fZmls
dGVyLmMNCj4gaW5kZXggYTU0ZWVkYjY5YTNmLi5hMWFiNWIwOWE2YzUgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seHN3L3NwZWN0cnVtX2FjbF9i
bG9vbV9maWx0ZXIuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9t
bHhzdy9zcGVjdHJ1bV9hY2xfYmxvb21fZmlsdGVyLmMNCj4gQEAgLTIzMSw3ICsyMzEsNyBA
QCBzdGF0aWMgdTE2IG1seHN3X3NwMl9hY2xfYmZfY3JjKGNvbnN0IHU4ICpidWZmZXIsIHNp
emVfdCBsZW4pDQo+ICAgc3RhdGljIHZvaWQNCj4gICBfX21seHN3X3NwX2FjbF9iZl9rZXlf
ZW5jb2RlKHN0cnVjdCBtbHhzd19zcF9hY2xfYXRjYW1fcmVnaW9uICphcmVnaW9uLA0KPiAg
IAkJCSAgICAgc3RydWN0IG1seHN3X3NwX2FjbF9hdGNhbV9lbnRyeSAqYWVudHJ5LA0KPiAt
CQkJICAgICBjaGFyICpvdXRwdXQsIHU4ICpsZW4sIHU4IG1heF9jaHVua3MsIHU4IHBhZF9i
eXRlcywNCj4gKwkJCSAgICAgY2hhciAqb3V0cHV0LCB1OCAqbGVuLCB1OCBwYWRfYnl0ZXMs
DQo+ICAgCQkJICAgICB1OCBrZXlfb2Zmc2V0LCB1OCBjaHVua19rZXlfbGVuLCB1OCBjaHVu
a19sZW4pDQo+ICAgew0KPiAgIAlzdHJ1Y3QgbWx4c3dfYWZrX2tleV9pbmZvICprZXlfaW5m
byA9IGFyZWdpb24tPnJlZ2lvbi0+a2V5X2luZm87DQo+IEBAIC0yNDEsMTAgKzI0MSwxNCBA
QCBfX21seHN3X3NwX2FjbF9iZl9rZXlfZW5jb2RlKHN0cnVjdCBtbHhzd19zcF9hY2xfYXRj
YW1fcmVnaW9uICphcmVnaW9uLA0KPiAgIA0KPiAgIAlibG9ja19jb3VudCA9IG1seHN3X2Fm
a19rZXlfaW5mb19ibG9ja3NfY291bnRfZ2V0KGtleV9pbmZvKTsNCj4gICAJY2h1bmtfY291
bnQgPSAxICsgKChibG9ja19jb3VudCAtIDEpID4+IDIpOw0KPiArCWlmIChXQVJOX09OX09O
Q0UoY2h1bmtfY291bnQgPiBNTFhTV19CTE9PTV9LRVlfQ0hVTktTKSkgew0KPiArCQkqbGVu
ID0gMDsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gICAJZXJwX3JlZ2lvbl9pZCA9IGNwdV90
b19iZTE2KGFlbnRyeS0+aHRfa2V5LmVycF9pZCB8DQo+ICAgCQkJCSAgIChhcmVnaW9uLT5y
ZWdpb24tPmlkIDw8IDQpKTsNCj4gLQlmb3IgKGNodW5rX2luZGV4ID0gbWF4X2NodW5rcyAt
IGNodW5rX2NvdW50OyBjaHVua19pbmRleCA8IG1heF9jaHVua3M7DQo+IC0JICAgICBjaHVu
a19pbmRleCsrKSB7DQo+ICsJZm9yIChjaHVua19pbmRleCA9IE1MWFNXX0JMT09NX0tFWV9D
SFVOS1MgLSBjaHVua19jb3VudDsNCj4gKwkgICAgIGNodW5rX2luZGV4IDwgTUxYU1dfQkxP
T01fS0VZX0NIVU5LUzsgY2h1bmtfaW5kZXgrKykgew0KPiAgIAkJbWVtc2V0KGNodW5rLCAw
LCBwYWRfYnl0ZXMpOw0KPiAgIAkJbWVtY3B5KGNodW5rICsgcGFkX2J5dGVzLCAmZXJwX3Jl
Z2lvbl9pZCwNCj4gICAJCSAgICAgICBzaXplb2YoZXJwX3JlZ2lvbl9pZCkpOw0KPiBAQCAt
MjYyLDcgKzI2Niw2IEBAIG1seHN3X3NwMl9hY2xfYmZfa2V5X2VuY29kZShzdHJ1Y3QgbWx4
c3dfc3BfYWNsX2F0Y2FtX3JlZ2lvbiAqYXJlZ2lvbiwNCj4gICAJCQkgICAgY2hhciAqb3V0
cHV0LCB1OCAqbGVuKQ0KPiAgIHsNCj4gICAJX19tbHhzd19zcF9hY2xfYmZfa2V5X2VuY29k
ZShhcmVnaW9uLCBhZW50cnksIG91dHB1dCwgbGVuLA0KPiAtCQkJCSAgICAgTUxYU1dfQkxP
T01fS0VZX0NIVU5LUywNCj4gICAJCQkJICAgICBNTFhTV19TUDJfQkxPT01fQ0hVTktfUEFE
X0JZVEVTLA0KPiAgIAkJCQkgICAgIE1MWFNXX1NQMl9CTE9PTV9DSFVOS19LRVlfT0ZGU0VU
LA0KPiAgIAkJCQkgICAgIE1MWFNXX1NQMl9CTE9PTV9DSFVOS19LRVlfQllURVMsDQo+IEBA
IC0zNzksNyArMzgyLDYgQEAgbWx4c3dfc3A0X2FjbF9iZl9rZXlfZW5jb2RlKHN0cnVjdCBt
bHhzd19zcF9hY2xfYXRjYW1fcmVnaW9uICphcmVnaW9uLA0KPiAgIAl1OCBjaHVua19jb3Vu
dCA9IDEgKyAoKGJsb2NrX2NvdW50IC0gMSkgPj4gMik7DQo+ICAgDQo+ICAgCV9fbWx4c3df
c3BfYWNsX2JmX2tleV9lbmNvZGUoYXJlZ2lvbiwgYWVudHJ5LCBvdXRwdXQsIGxlbiwNCj4g
LQkJCQkgICAgIE1MWFNXX0JMT09NX0tFWV9DSFVOS1MsDQo+ICAgCQkJCSAgICAgTUxYU1df
U1A0X0JMT09NX0NIVU5LX1BBRF9CWVRFUywNCj4gICAJCQkJICAgICBNTFhTV19TUDRfQkxP
T01fQ0hVTktfS0VZX09GRlNFVCwNCj4gICAJCQkJICAgICBNTFhTV19TUDRfQkxPT01fQ0hV
TktfS0VZX0JZVEVTLA0KPg0KLS0gDQpXYW5nWXVsaQ0K
--------------U72oK4dhadUK2E63rCcS0hmG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p>Hi Ido Schimmel,</p>
    <div class=3D"moz-cite-prefix">On 2025/3/13 23:25, Ido Schimmel wrote=
:<span
      style=3D"white-space: pre-wrap">
</span></div>
    <blockquote type=3D"cite" cite=3D"mid:Z9L43xpibqHZ07vW@shredder">
      <pre wrap=3D"" class=3D"moz-quote-pre">I would like to get a warnin=
g if 'chunk_count' is larger than
'MLXSW_BLOOM_KEY_CHUNKS' since it should never happen.

I was able to reproduce the build failure and the following patch seems
to solve it for me. It removes the 'max_chunks' argument since it's
always 'MLXSW_BLOOM_KEY_CHUNKS' (3) and verifies that the number of
chunks that was calculated is never greater than it.

WangYuli, can you please test it?</pre>
    </blockquote>
    <p>My tests still show the same compilation failing.</p>
    <p>Indeed, I have already tried similar fixes during my
      investigation, but to no avail.</p>
    <blockquote type=3D"cite" cite=3D"mid:Z9L43xpibqHZ07vW@shredder">
      <pre wrap=3D"" class=3D"moz-quote-pre">
Also, if you want it in net.git (as opposed to net-next.git), then it
needs a Fixes tag:

Fixes: 7585cacdb978 ("mlxsw: spectrum_acl: Add Bloom filter handling")</p=
re>
    </blockquote>
    OK
    <blockquote type=3D"cite" cite=3D"mid:Z9L43xpibqHZ07vW@shredder">
      <pre wrap=3D"" class=3D"moz-quote-pre">

And I don't think we need patch #2.</pre>
    </blockquote>
    While #2 is admittedly a secondary modification compared to #1,
    should you be agreeable, I believe it's still preferable to combine
    #2 with #1 instead of outright discarding #2.
    <blockquote type=3D"cite" cite=3D"mid:Z9L43xpibqHZ07vW@shredder">
      <pre wrap=3D"" class=3D"moz-quote-pre">

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filte=
r.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
index a54eedb69a3f..a1ab5b09a6c5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
@@ -231,7 +231,7 @@ static u16 mlxsw_sp2_acl_bf_crc(const u8 *buffer, siz=
e_t len)
 static void
 __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 			     struct mlxsw_sp_acl_atcam_entry *aentry,
-			     char *output, u8 *len, u8 max_chunks, u8 pad_bytes,
+			     char *output, u8 *len, u8 pad_bytes,
 			     u8 key_offset, u8 chunk_key_len, u8 chunk_len)
 {
 	struct mlxsw_afk_key_info *key_info =3D aregion-&gt;region-&gt;key_info=
;
@@ -241,10 +241,14 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_at=
cam_region *aregion,
=20
 	block_count =3D mlxsw_afk_key_info_blocks_count_get(key_info);
 	chunk_count =3D 1 + ((block_count - 1) &gt;&gt; 2);
+	if (WARN_ON_ONCE(chunk_count &gt; MLXSW_BLOOM_KEY_CHUNKS)) {
+		*len =3D 0;
+		return;
+	}
 	erp_region_id =3D cpu_to_be16(aentry-&gt;ht_key.erp_id |
 				   (aregion-&gt;region-&gt;id &lt;&lt; 4));
-	for (chunk_index =3D max_chunks - chunk_count; chunk_index &lt; max_chu=
nks;
-	     chunk_index++) {
+	for (chunk_index =3D MLXSW_BLOOM_KEY_CHUNKS - chunk_count;
+	     chunk_index &lt; MLXSW_BLOOM_KEY_CHUNKS; chunk_index++) {
 		memset(chunk, 0, pad_bytes);
 		memcpy(chunk + pad_bytes, &amp;erp_region_id,
 		       sizeof(erp_region_id));
@@ -262,7 +266,6 @@ mlxsw_sp2_acl_bf_key_encode(struct mlxsw_sp_acl_atcam=
_region *aregion,
 			    char *output, u8 *len)
 {
 	__mlxsw_sp_acl_bf_key_encode(aregion, aentry, output, len,
-				     MLXSW_BLOOM_KEY_CHUNKS,
 				     MLXSW_SP2_BLOOM_CHUNK_PAD_BYTES,
 				     MLXSW_SP2_BLOOM_CHUNK_KEY_OFFSET,
 				     MLXSW_SP2_BLOOM_CHUNK_KEY_BYTES,
@@ -379,7 +382,6 @@ mlxsw_sp4_acl_bf_key_encode(struct mlxsw_sp_acl_atcam=
_region *aregion,
 	u8 chunk_count =3D 1 + ((block_count - 1) &gt;&gt; 2);
=20
 	__mlxsw_sp_acl_bf_key_encode(aregion, aentry, output, len,
-				     MLXSW_BLOOM_KEY_CHUNKS,
 				     MLXSW_SP4_BLOOM_CHUNK_PAD_BYTES,
 				     MLXSW_SP4_BLOOM_CHUNK_KEY_OFFSET,
 				     MLXSW_SP4_BLOOM_CHUNK_KEY_BYTES,

</pre>
    </blockquote>
    <div class=3D"moz-signature">-- <br>
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DU=
TF-8">
      WangYuli</div>
  </body>
</html>

--------------U72oK4dhadUK2E63rCcS0hmG--

--------------SdEWfqeqxLIUntY2Kr3is73x
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

--------------SdEWfqeqxLIUntY2Kr3is73x--

--------------zkLbIZBFofBxPl5MmnWbCdGZ--

--------------CZDE3t3J09XbRT611EWB2l2u
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ9MDggUDAAAAAAAKCRDF2h8wRvQL7oRP
AP9aJyF72tDQlCSxErenGTOZri/lHe+9QvALTa50c/urTAD+KBXDQfp4TRgU+NPkPopoAXvBUKON
g5rwczc5knm9dwI=
=Er4c
-----END PGP SIGNATURE-----

--------------CZDE3t3J09XbRT611EWB2l2u--


