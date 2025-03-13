Return-Path: <netdev+bounces-174473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6B6A5EE95
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B9D3B2485
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 08:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA63262D2F;
	Thu, 13 Mar 2025 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cR0+acIA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754262620EA;
	Thu, 13 Mar 2025 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856122; cv=none; b=hr+lfJG/tPOB6gZxiGB+KR4KKll+P9Dld4RibBk0SXLR/m4S8fLcSIUymp2w/91WUnxziFRrJYSErs7ThSszw3GCKsNN+1Zn/EUQL/lUBrzCDT4f3UrKNXauTheW0Gb1F5x2Y2Ap+vy2H0lgaQgcyk6Mn+S1sSgXB1KveVLauJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856122; c=relaxed/simple;
	bh=XwjCfI3PYs+k4ge2/19lbnCKTO1W3bbZ1BVlPBosLAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+V+GeElZ6UTgypxms86IhvpfN4lAY0JFyfZNKNyLCbi4aV3dFxECJ4MX3dgJbp7Qyo/9jRdi/yJZoXF6h6cAt7wFperrvHUvd97qgCjqQjDN9qLsrNMsfN8+z30/LrcHowavqU5g107iuuBZ4n/hvtgllBQuR+h5JvL5EefCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cR0+acIA; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741856013;
	bh=XwjCfI3PYs+k4ge2/19lbnCKTO1W3bbZ1BVlPBosLAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=cR0+acIAu/YrqW+StIjpOeqB8IkWiURO6Kmn0pvo0yadFKSsjTTJcYs1jclz49pIE
	 IlWvfqsYX+STaFYC6/Brl3qPsWiylMJgucLfititN4EuKo7ciDDjY+jvQyvv4VsqW5
	 Fmm8L8YFcYgsBdvREzKeftc/+aG4TZo2s8XMWQNw=
X-QQ-mid: bizesmtpip3t1741855968tfgm8di
X-QQ-Originating-IP: g/3SVHke8ELRYY0Le9r5VgG9TdisfuFZVTOWJLY/URE=
Received: from [IPV6:240e:668:120a::212:156] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Mar 2025 16:52:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10379655542431610625
Message-ID: <056F72F0353D1A56+962a801c-5f9f-4aec-b0f9-ae917f0c55af@uniontech.com>
Date: Thu, 13 Mar 2025 16:52:46 +0800
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
Cc: andrew+netdev@lunn.ch, chenlinxuan@uniontech.com, czj2441@163.com,
 davem@davemloft.net, edumazet@google.com, guanwentao@uniontech.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 niecheng1@uniontech.com, pabeni@redhat.com, petrm@nvidia.com,
 zhanjun@uniontech.com
References: <484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com>
 <78951564F9FEA017+20250311141701.1626533-1-wangyuli@uniontech.com>
 <Z9GKE-mP3qbmK9cL@shredder>
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
X-Priority: 5 (Lowest)
In-Reply-To: <Z9GKE-mP3qbmK9cL@shredder>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pkIVHBvgQzjsex30mv8cGK1t"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NTA/F5hzAX/xymhrKL4TgT/i8bzeD6cWL9vMTxv/XM1nbk75FAwnHtMw
	UY6H3Crp9rQbw6xdIEg1sC4HAAKbZOpORYt1YBZgwYnbF3yv1Ps5mPf9drml//5If3JB3hY
	sPbwLsJf4vo/YbmHdP21tjSs0Ps+6LOKZ6RkmLc61V07OPvSIHQV29IUpaZBwdzL/HKhu67
	sM3dsLSzHQlpCS6nbf0T3JzJa9csxzaCmNS2sc+B8II5294+vW3mhzcGE6HhXubOw6n7wll
	nTycLnQ8KoUJe2H68r9NrI2/zoEMdr411MJSvVENvSwwZ39O09Dpi6fECSKGbX+1M8jZoqw
	+TiYmSRizi1UddNy2cggcEgTvvIODV+3m2epl7oJZcThmtJE9B0/FYNaQB/sfT1nACTk4s5
	igRd89ApC6njqaB3Q58LWmKMcA2eo0vbyPLmsEoq9F1h0bVPWrwm0yxl6kB0KUOgOo4wqj0
	oAD34Y6eGazgeG0h1PhsWvPLrb2pc4ut+mm6xNvzS0PTQE0JurJjDfzPZLIC7sK41JsuivJ
	Vo60TgOEhFNPu0tLvhfQjtLuPJVeratrxrKLq+n7PyOoiwiKkKQsiZ6plGtz7qz8yUmcvcy
	+ErX8yleZv/MEHukejqIgwcqQnE1tuRUs7YuX8v5/v+ml46Z+z+aX5Iu4LiNZ1PUCM+5PST
	V+DAfv0kp0yghxapCFJ+FVtPO2oi7SP5PnTqG0tub7d4/Wk0dif85nniASy9OcW02/9I+W8
	gdBLu+t3vvKE5V2gq4+bD4I2Xy4E88b8zhuLdRkRiH+A5iFcVA31DaUV7iZzzY0hW8w9Pp3
	SXwX48Pfhf0zwEHLgl3CQTUHS9HCc/z/vD919JKtI6UaMTgeZwgH29o4o8dryFTyg2lwmCq
	NSA7bG72P9dEZzXG0V7wfz/0She1yGjyv0cVrs/dhXNctjEEHJekZ2rgUFt+at3cPa1eIbE
	RNf0OMIK0MOoK2t/5TpZR9Ie/8FA3soeMB8kQ0s0/4NxduxA3XTTcRujN5iN852WnPlcGPO
	rBehko0ZgEm//zW9p6KG5DXJD5nHq7fDBFu86MkA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pkIVHBvgQzjsex30mv8cGK1t
Content-Type: multipart/mixed; boundary="------------sZ3GbweUo5GtcSc0KWDsFoKJ";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: andrew+netdev@lunn.ch, chenlinxuan@uniontech.com, czj2441@163.com,
 davem@davemloft.net, edumazet@google.com, guanwentao@uniontech.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 niecheng1@uniontech.com, pabeni@redhat.com, petrm@nvidia.com,
 zhanjun@uniontech.com
Message-ID: <962a801c-5f9f-4aec-b0f9-ae917f0c55af@uniontech.com>
Subject: Re: [PATCH net 1/2] mlxsw: spectrum_acl_bloom_filter: Expand
 chunk_key_offsets[chunk_index]
References: <484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com>
 <78951564F9FEA017+20250311141701.1626533-1-wangyuli@uniontech.com>
 <Z9GKE-mP3qbmK9cL@shredder>
In-Reply-To: <Z9GKE-mP3qbmK9cL@shredder>

--------------sZ3GbweUo5GtcSc0KWDsFoKJ
Content-Type: multipart/mixed; boundary="------------a0REcw6hKuPo3CtuynppO4Tn"

--------------a0REcw6hKuPo3CtuynppO4Tn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSWRvIFNjaGltbWUsDQoNCk9uIDIwMjUvMy8xMiAyMToyMCwgSWRvIFNjaGltbWVsIHdy
b3RlOg0KPiBJJ20gbm90IHN1cmUgd2h5IHRoZSBmaXggc3VwcHJlc3NlcyB0aGUgd2Fybmlu
ZyB3aGVuIHRoZSB3YXJuaW5nIGlzDQo+IGFib3V0IHRoZSBkZXN0aW5hdGlvbiBidWZmZXIg
YW5kIHRoZSBmaXggaXMgYWJvdXQgdGhlIHNvdXJjZS4gQ2FuIHlvdQ0KPiBjaGVjayBpZiB0
aGUgYmVsb3cgaGVscHM/IEl0IHJlbW92ZXMgdGhlIHBhcmFtZXRlcml6YXRpb24gZnJvbQ0K
PiBfX21seHN3X3NwX2FjbF9iZl9rZXlfZW5jb2RlKCkgYW5kIGluc3RlYWQgc3BsaXRzIGl0
IHRvIHR3byB2YXJpYW50cy4NCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21lbGxhbm94L21seHN3L3NwZWN0cnVtX2FjbF9ibG9vbV9maWx0ZXIuYyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seHN3L3NwZWN0cnVtX2FjbF9ibG9vbV9maWx0
ZXIuYw0KPiBpbmRleCBhNTRlZWRiNjlhM2YuLjNlMWU0YmU3MmRhMiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4c3cvc3BlY3RydW1fYWNsX2Js
b29tX2ZpbHRlci5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21s
eHN3L3NwZWN0cnVtX2FjbF9ibG9vbV9maWx0ZXIuYw0KPiBAQCAtMTEwLDcgKzExMCw2IEBA
IHN0YXRpYyBjb25zdCB1MTYgbWx4c3dfc3AyX2FjbF9iZl9jcmMxNl90YWJbMjU2XSA9IHsN
Cj4gICAgKiArLS0tLS0tLS0tLS0rLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSsNCj4gICAgKi8NCj4gICANCj4gLSNkZWZpbmUgTUxYU1dfU1A0X0JM
T09NX0NIVU5LX1BBRF9CWVRFUyAwDQo+ICAgI2RlZmluZSBNTFhTV19TUDRfQkxPT01fQ0hV
TktfS0VZX0JZVEVTIDE4DQo+ICAgI2RlZmluZSBNTFhTV19TUDRfQkxPT01fS0VZX0NIVU5L
X0JZVEVTIDIwDQo+ICAgDQo+IEBAIC0yMjksMTAgKzIyOCw5IEBAIHN0YXRpYyB1MTYgbWx4
c3dfc3AyX2FjbF9iZl9jcmMoY29uc3QgdTggKmJ1ZmZlciwgc2l6ZV90IGxlbikNCj4gICB9
DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQNCj4gLV9fbWx4c3dfc3BfYWNsX2JmX2tleV9lbmNv
ZGUoc3RydWN0IG1seHN3X3NwX2FjbF9hdGNhbV9yZWdpb24gKmFyZWdpb24sDQo+IC0JCQkg
ICAgIHN0cnVjdCBtbHhzd19zcF9hY2xfYXRjYW1fZW50cnkgKmFlbnRyeSwNCj4gLQkJCSAg
ICAgY2hhciAqb3V0cHV0LCB1OCAqbGVuLCB1OCBtYXhfY2h1bmtzLCB1OCBwYWRfYnl0ZXMs
DQo+IC0JCQkgICAgIHU4IGtleV9vZmZzZXQsIHU4IGNodW5rX2tleV9sZW4sIHU4IGNodW5r
X2xlbikNCj4gK21seHN3X3NwMl9hY2xfYmZfa2V5X2VuY29kZShzdHJ1Y3QgbWx4c3dfc3Bf
YWNsX2F0Y2FtX3JlZ2lvbiAqYXJlZ2lvbiwNCj4gKwkJCSAgICBzdHJ1Y3QgbWx4c3dfc3Bf
YWNsX2F0Y2FtX2VudHJ5ICphZW50cnksDQo+ICsJCQkgICAgY2hhciAqb3V0cHV0LCB1OCAq
bGVuKQ0KPiAgIHsNCj4gICAJc3RydWN0IG1seHN3X2Fma19rZXlfaW5mbyAqa2V5X2luZm8g
PSBhcmVnaW9uLT5yZWdpb24tPmtleV9pbmZvOw0KPiAgIAl1OCBjaHVua19pbmRleCwgY2h1
bmtfY291bnQsIGJsb2NrX2NvdW50Ow0KPiBAQCAtMjQzLDMwICsyNDEsMTcgQEAgX19tbHhz
d19zcF9hY2xfYmZfa2V5X2VuY29kZShzdHJ1Y3QgbWx4c3dfc3BfYWNsX2F0Y2FtX3JlZ2lv
biAqYXJlZ2lvbiwNCj4gICAJY2h1bmtfY291bnQgPSAxICsgKChibG9ja19jb3VudCAtIDEp
ID4+IDIpOw0KPiAgIAllcnBfcmVnaW9uX2lkID0gY3B1X3RvX2JlMTYoYWVudHJ5LT5odF9r
ZXkuZXJwX2lkIHwNCj4gICAJCQkJICAgKGFyZWdpb24tPnJlZ2lvbi0+aWQgPDwgNCkpOw0K
PiAtCWZvciAoY2h1bmtfaW5kZXggPSBtYXhfY2h1bmtzIC0gY2h1bmtfY291bnQ7IGNodW5r
X2luZGV4IDwgbWF4X2NodW5rczsNCj4gLQkgICAgIGNodW5rX2luZGV4KyspIHsNCj4gLQkJ
bWVtc2V0KGNodW5rLCAwLCBwYWRfYnl0ZXMpOw0KPiAtCQltZW1jcHkoY2h1bmsgKyBwYWRf
Ynl0ZXMsICZlcnBfcmVnaW9uX2lkLA0KPiArCWZvciAoY2h1bmtfaW5kZXggPSBNTFhTV19C
TE9PTV9LRVlfQ0hVTktTIC0gY2h1bmtfY291bnQ7DQo+ICsJICAgICBjaHVua19pbmRleCA8
IE1MWFNXX0JMT09NX0tFWV9DSFVOS1M7IGNodW5rX2luZGV4KyspIHsNCj4gKwkJbWVtc2V0
KGNodW5rLCAwLCBNTFhTV19TUDJfQkxPT01fQ0hVTktfUEFEX0JZVEVTKTsNCj4gKwkJbWVt
Y3B5KGNodW5rICsgTUxYU1dfU1AyX0JMT09NX0NIVU5LX1BBRF9CWVRFUywgJmVycF9yZWdp
b25faWQsDQo+ICAgCQkgICAgICAgc2l6ZW9mKGVycF9yZWdpb25faWQpKTsNCj4gLQkJbWVt
Y3B5KGNodW5rICsga2V5X29mZnNldCwNCj4gKwkJbWVtY3B5KGNodW5rICsgTUxYU1dfU1Ay
X0JMT09NX0NIVU5LX0tFWV9PRkZTRVQsDQo+ICAgCQkgICAgICAgJmFlbnRyeS0+aHRfa2V5
LmVuY19rZXlbY2h1bmtfa2V5X29mZnNldHNbY2h1bmtfaW5kZXhdXSwNCj4gLQkJICAgICAg
IGNodW5rX2tleV9sZW4pOw0KPiAtCQljaHVuayArPSBjaHVua19sZW47DQo+ICsJCSAgICAg
ICBNTFhTV19TUDJfQkxPT01fQ0hVTktfS0VZX0JZVEVTKTsNCj4gKwkJY2h1bmsgKz0gTUxY
U1dfU1AyX0JMT09NX0tFWV9DSFVOS19CWVRFUzsNCj4gICAJfQ0KPiAtCSpsZW4gPSBjaHVu
a19jb3VudCAqIGNodW5rX2xlbjsNCj4gLX0NCj4gLQ0KPiAtc3RhdGljIHZvaWQNCj4gLW1s
eHN3X3NwMl9hY2xfYmZfa2V5X2VuY29kZShzdHJ1Y3QgbWx4c3dfc3BfYWNsX2F0Y2FtX3Jl
Z2lvbiAqYXJlZ2lvbiwNCj4gLQkJCSAgICBzdHJ1Y3QgbWx4c3dfc3BfYWNsX2F0Y2FtX2Vu
dHJ5ICphZW50cnksDQo+IC0JCQkgICAgY2hhciAqb3V0cHV0LCB1OCAqbGVuKQ0KPiAtew0K
PiAtCV9fbWx4c3dfc3BfYWNsX2JmX2tleV9lbmNvZGUoYXJlZ2lvbiwgYWVudHJ5LCBvdXRw
dXQsIGxlbiwNCj4gLQkJCQkgICAgIE1MWFNXX0JMT09NX0tFWV9DSFVOS1MsDQo+IC0JCQkJ
ICAgICBNTFhTV19TUDJfQkxPT01fQ0hVTktfUEFEX0JZVEVTLA0KPiAtCQkJCSAgICAgTUxY
U1dfU1AyX0JMT09NX0NIVU5LX0tFWV9PRkZTRVQsDQo+IC0JCQkJICAgICBNTFhTV19TUDJf
QkxPT01fQ0hVTktfS0VZX0JZVEVTLA0KPiAtCQkJCSAgICAgTUxYU1dfU1AyX0JMT09NX0tF
WV9DSFVOS19CWVRFUyk7DQo+ICsJKmxlbiA9IGNodW5rX2NvdW50ICogTUxYU1dfU1AyX0JM
T09NX0tFWV9DSFVOS19CWVRFUzsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHVuc2lnbmVk
IGludA0KPiBAQCAtMzc1LDE1ICszNjAsMjQgQEAgbWx4c3dfc3A0X2FjbF9iZl9rZXlfZW5j
b2RlKHN0cnVjdCBtbHhzd19zcF9hY2xfYXRjYW1fcmVnaW9uICphcmVnaW9uLA0KPiAgIAkJ
CSAgICBjaGFyICpvdXRwdXQsIHU4ICpsZW4pDQo+ICAgew0KPiAgIAlzdHJ1Y3QgbWx4c3df
YWZrX2tleV9pbmZvICprZXlfaW5mbyA9IGFyZWdpb24tPnJlZ2lvbi0+a2V5X2luZm87DQo+
IC0JdTggYmxvY2tfY291bnQgPSBtbHhzd19hZmtfa2V5X2luZm9fYmxvY2tzX2NvdW50X2dl
dChrZXlfaW5mbyk7DQo+IC0JdTggY2h1bmtfY291bnQgPSAxICsgKChibG9ja19jb3VudCAt
IDEpID4+IDIpOw0KPiAtDQo+IC0JX19tbHhzd19zcF9hY2xfYmZfa2V5X2VuY29kZShhcmVn
aW9uLCBhZW50cnksIG91dHB1dCwgbGVuLA0KPiAtCQkJCSAgICAgTUxYU1dfQkxPT01fS0VZ
X0NIVU5LUywNCj4gLQkJCQkgICAgIE1MWFNXX1NQNF9CTE9PTV9DSFVOS19QQURfQllURVMs
DQo+IC0JCQkJICAgICBNTFhTV19TUDRfQkxPT01fQ0hVTktfS0VZX09GRlNFVCwNCj4gLQkJ
CQkgICAgIE1MWFNXX1NQNF9CTE9PTV9DSFVOS19LRVlfQllURVMsDQo+IC0JCQkJICAgICBN
TFhTV19TUDRfQkxPT01fS0VZX0NIVU5LX0JZVEVTKTsNCj4gKwl1OCBjaHVua19pbmRleCwg
Y2h1bmtfY291bnQsIGJsb2NrX2NvdW50Ow0KPiArCWNoYXIgKmNodW5rID0gb3V0cHV0Ow0K
PiArCV9fYmUxNiBlcnBfcmVnaW9uX2lkOw0KPiArDQo+ICsJYmxvY2tfY291bnQgPSBtbHhz
d19hZmtfa2V5X2luZm9fYmxvY2tzX2NvdW50X2dldChrZXlfaW5mbyk7DQo+ICsJY2h1bmtf
Y291bnQgPSAxICsgKChibG9ja19jb3VudCAtIDEpID4+IDIpOw0KPiArCWVycF9yZWdpb25f
aWQgPSBjcHVfdG9fYmUxNihhZW50cnktPmh0X2tleS5lcnBfaWQgfA0KPiArCQkJCSAgIChh
cmVnaW9uLT5yZWdpb24tPmlkIDw8IDQpKTsNCj4gKwlmb3IgKGNodW5rX2luZGV4ID0gTUxY
U1dfQkxPT01fS0VZX0NIVU5LUyAtIGNodW5rX2NvdW50Ow0KPiArCSAgICAgY2h1bmtfaW5k
ZXggPCBNTFhTV19CTE9PTV9LRVlfQ0hVTktTOyBjaHVua19pbmRleCsrKSB7DQo+ICsJCW1l
bWNweShjaHVuaywgJmVycF9yZWdpb25faWQsIHNpemVvZihlcnBfcmVnaW9uX2lkKSk7DQo+
ICsJCW1lbWNweShjaHVuayArIE1MWFNXX1NQNF9CTE9PTV9DSFVOS19LRVlfT0ZGU0VULA0K
PiArCQkgICAgICAgJmFlbnRyeS0+aHRfa2V5LmVuY19rZXlbY2h1bmtfa2V5X29mZnNldHNb
Y2h1bmtfaW5kZXhdXSwNCj4gKwkJICAgICAgIE1MWFNXX1NQNF9CTE9PTV9DSFVOS19LRVlf
QllURVMpOw0KPiArCQljaHVuayArPSBNTFhTV19TUDRfQkxPT01fS0VZX0NIVU5LX0JZVEVT
Ow0KPiArCX0NCj4gKwkqbGVuID0gY2h1bmtfY291bnQgKiBNTFhTV19TUDRfQkxPT01fS0VZ
X0NIVU5LX0JZVEVTOw0KPiArDQo+ICAgCW1seHN3X3NwNF9iZl9rZXlfc2hpZnRfY2h1bmtz
KGNodW5rX2NvdW50LCBvdXRwdXQpOw0KPiAgIH0NCj4NClNhZGx5LCBpdCB3b3VsZCBhcHBl
YXIgeW91ciBtb2RpZmljYXRpb25zIGhhdmVuJ3QgdGFrZW4gZWZmZWN0Lg0KDQpUaGUgc2Ft
ZSBlcnJvciBvdXRwdXQgaXMgc3RpbGwgcHJlc2VudC4NCg0KSSBjYW4gYWxzbyBkZXRhaWwg
aG93IHRvIHJlcHJvZHVjZSB0aGUgZXJyb3IuIFlvdSBjYW4gdmVyaWZ5IHRoaXMgdmlhIA0K
TExWTSBjcm9zcy1jb21waWxhdGlvbiB1c2luZyB0aGUgWzFdIGNvbmZpZyBvbiBhbnkgY29t
cHV0ZXIuDQoNCiDCoMKgwqAgWzFdLiANCmh0dHBzOi8vZ2l0aHViLmNvbS9kZWVwaW4tY29t
bXVuaXR5L2tlcm5lbC9ibG9iL2xpbnV4LTYuNi55L2FyY2gvczM5MC9jb25maWdzL2RlZXBp
bl9zMzkweF96MTNfZGVmY29uZmlnDQoNClRoZSBjb21tYW5kIEkndmUgYmVlbiBlbXBsb3lp
bmcgaXM6DQoNCiDCoMKgwqAgbWFrZSBBUkNIPXMzOTAgQ1JPU1NfQ09NUElMRT1zMzkweC1s
aW51eC1nbnUtIENDPSJjY2FjaGUgY2xhbmciIA0KLWokKG5wcm9jKQ0KDQoNClRoYW5rcywN
Cg0KLS0gDQpXYW5nWXVsaQ0K
--------------a0REcw6hKuPo3CtuynppO4Tn
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

--------------a0REcw6hKuPo3CtuynppO4Tn--

--------------sZ3GbweUo5GtcSc0KWDsFoKJ--

--------------pkIVHBvgQzjsex30mv8cGK1t
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ9Kc3gUDAAAAAAAKCRDF2h8wRvQL7pgS
AQD1J9Bz0u0xEvXdxILhK/gv6DYqIy+oqFz7Crm1OrIImQD+ILHTXHpOnZGp6KtlNJIztJp5C/wj
Px3R8IlvgCITRgE=
=dGrn
-----END PGP SIGNATURE-----

--------------pkIVHBvgQzjsex30mv8cGK1t--


