Return-Path: <netdev+bounces-295096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iHC+Orw3IWoOBQEAu9opvQ
	(envelope-from <netdev+bounces-295096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:30:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4288463E012
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:30:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295096-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295096-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=compal.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E48753004C69
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89E53DFC7F;
	Thu,  4 Jun 2026 08:22:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef22.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919E33E0080;
	Thu,  4 Jun 2026 08:22:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561367; cv=none; b=uArN0TIGYfj0Qij4/acYCgEQp3BYAB8oIMyEn8xBZNTVZPNkR2t7BuCKV+tDxsg88IAjhtzSMDFU6KUzOcRzLZY1BBel1/urOpsPeOydga76alMQeqDuH9HBbaP+vnMDvsGN4QIEpNiN8rrOB/uZJR++CCSd626sO1CAb9C9Dk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561367; c=relaxed/simple;
	bh=3Sw7FAE9X7C90aUEWnkof8I/AA4MOhzFTtic5f5+Q14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ru7dgHXV7Gp3Fxn4q5t5OdnU8Z6H1/vrLVP1eLDqwtB2gE8zIGrZXf+3LNkJP/nrMJfH76/JCRg8Rgmk3/qqO6xz1C1qJh9tT6iwsf4aVU4NBADkM/XbOkyjyi016Ikw3h3ymW7aMm+yarpqwIRLwhSL9wmS8eAM4vEEOXv9sS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
X-UUID: 8ac5f7e45fee11f1a87c2323a98e90a4-20260604
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:9c47129c-84ef-4af2-8e9b-986e7bc084c3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:c24e6886-394e-4a03-8895-d34f53943d06,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8ac5f7e45fee11f1a87c2323a98e90a4-20260604
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef22.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1608742137; Thu, 04 Jun 2026 16:22:36 +0800
X-UUID: 86dc28925fee11f1a42089d3d1632821-20260604
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:cafd1c45-fe82-42b3-bec3-59d3594248ee,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:894e6886-394e-4a03-8895-d34f53943d06,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 86dc28925fee11f1a42089d3d1632821-20260604
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 837588550; Thu, 04 Jun 2026 16:22:29 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 4 Jun 2026 16:22:27 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69%11]) with mapi id
 15.02.2562.029; Thu, 4 Jun 2026 16:22:27 +0800
From: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Jack Wu via B4 Relay
	<devnull+jackbb_wu.compal.com@kernel.org>
CC: Loic Poulain <loic.poulain@oss.qualcomm.com>, Johannes Berg
	<johannes@sipsolutions.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>,
	Shi-Wei Yeh <shi-wei.yeh@mediatek.com>, Minano Tseng
	<Minano.tseng@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Simon
 Horman" <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [External Mail] Re: [PATCH 00/11] net: wwan: t9xx: Add MediaTek
 T9XX WWAN driver
Thread-Topic: [External Mail] Re: [PATCH 00/11] net: wwan: t9xx: Add MediaTek
 T9XX WWAN driver
Thread-Index: AQHc8iePJegWnmu1bUi94DWo9+PN/LYrGJEzgAAe7YCAAtdz8A==
Date: Thu, 4 Jun 2026 08:22:27 +0000
Message-ID: <98dcaccc34ac4083aef7d57d349c4b7a@compal.com>
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
 <20260601173401.2c892526@kernel.org>
 <c279aea41ecf41c6aca4314a2f4e306b@compal.com>,<e7df5082-ef48-43d0-ad07-10e1e64e1d26@gmail.com>
In-Reply-To: <e7df5082-ef48-43d0-ad07-10e1e64e1d26@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-29986.005
x-tm-as-result: No-10--26.646500-8.000000
x-tmase-matchedrid: RjGFKQPDGZ4uv++HU7VXryRFbfQbCufdN0X64jGy2dbVc/AFNTvLS9XY
	nKy9ZqbG0wNjG7j2lpfWtteiDVXz7mpW0A+eYNud4WMcbQqR5OFkrVIXZHd52KloHyDFpaEsbxq
	9W35blN9+M8NObIEDkCLCiAPpH5Zk/7zDDoXJoQ2DhqUecocKp1Izqo1F8yQS6ZPX83a4JSt/+c
	5g4eNP+u8BzumvjiFCXT2nCSyOs5j74diwVvyjRcFwCSR9lLGI8kOnQJj3cxIkxtQqXREtZO/yM
	kwYZmJ2tOKF1u0biJAV2Z+xPG+d+I62nm6DaDgUVnni4UoVxuO6wG+1uTW14Id1FpoF4NeYU19U
	ImjpbIGuh6YVToIwy41RNFEIob/KmQi8fYMxpGuFhGp9GNPDrc1nntU6vE00IXRpMFb6AcKB0h0
	6Pr4Hn4t7NVVLHZ3t19I3/idrQ/D3HS2YoYepd8FvMuNxUA+cG+VnGrXiRgANY08wMOTDmsESno
	2xw0elmPP9edzaP5oCXDmsMNWqfsnvUK8i80ickY9I7o7kkJprcVVB7l3jO+U0ANNKseCVLUD+q
	cOWoY+gM0tM9SAUhJd2NMAW0scp0hdWHIAe0CxzrrrGCGpI0nKYwMz9otrH37CRm+BZCt1uXYbG
	BTRRfjvzjev5OakhYcFXY6YuN83xW9F9t0swPe2k7br7KLbk/NQq8FlIcVgSCDdzAMeX/U7zkly
	hPTD9YIyQM4JfnWklTScbe2l74JsI6K9TYesLZLQpoie3cD5P8StIwFbkBA==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--26.646500-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-29986.005
x-tm-snts-smtp: F1D4721A7B9D4994DC53E26ABE48FCE74F86D29E9474505D022697E8716949DA2000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	DMARC_POLICY_REJECT(2.00)[compal.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295096-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ryazanov.s.a@gmail.com,m:kuba@kernel.org,m:devnull+jackbb_wu.compal.com@kernel.org,m:loic.poulain@oss.qualcomm.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:devnull@kernel.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,redhat.com,mediatek.com,gmail.com,collabora.com,kernel.org,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,compal.com:from_mime,compal.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,jackbb_wu.compal.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4288463E012

SGkNCg0KPiBsZXQgbWUgam9pbiB0aGUgZGlzY3Vzc2lvbiBhbmQgcHV0IG15IDJjLg0KPg0KPiBP
biA2LzIvMjYgMTM6NTgsIFd1LiBKYWNrQkIgKEdTTSkgd3JvdGU6DQo+ID4gSGkgSmFrdWIsDQo+
ID4NCj4gPiA+IE9uIEZyaSwgMjkgTWF5IDIwMjYgMTg6MzE6MzkgKzA4MDAgSmFjayBXdSB2aWEg
QjQgUmVsYXkgd3JvdGU6DQo+ID4gPiA+IDQzIGZpbGVzIGNoYW5nZWQsIDE0NzYxIGluc2VydGlv
bnMoKykNCj4gPiA+DQo+ID4gPiBQbGVhc2UgdHJ5IHRvIGN1dCB0aGlzIGRvd24gdG8gfjVrTG9D
IGZvciB0aGUgaW5pdGlhbCBzdWJtaXNzaW9uLg0KPiA+ID4gV2hhdGV2ZXIgdGhlIGFic29sdXRl
IG1pbmltdW0gc2Vuc2libGUgY2h1bmsgb2YgY29kZSBpcy4NCj4gPiA+DQo+ID4gPiBFYWNoIHBh
dGNoIG11c3QgYnVpbGQgY2xlYW5seSB3aXRoIFc9MQ0KPiA+DQo+ID4gV2UndmUgYWxyZWFkeSBy
ZWR1Y2VkIHRoaXMgc2lnbmlmaWNhbnRseSBmcm9tIHRoZSBvcmlnaW5hbCA0MWsgTG9DDQo+ID4g
ZG93biB0byB+MTQuN2sgYnkgc3RyaXBwaW5nIG91dCBub24tZXNzZW50aWFsIGZlYXR1cmVzIHN1
Y2ggYXMNCj4gPiBleGNlcHRpb24gaGFuZGxpbmcsIG1lbW9yeSBsb2dnaW5nLCBkZXZsaW5rLCBz
dGF0aXN0aWNzLCBkZWJ1Zw0KPiA+IHRyYWNpbmcsIGFuZCBvdGhlcnMuDQo+ID4NCj4gPiBXZSBl
dmVuIHJlbW92ZWQgc29tZSBhcmd1YWJseSBuZWNlc3NhcnkgZmVhdHVyZXMgKFBNLCBtZGxvZywN
Cj4gPiB0aHJvdWdocHV0IG9wdGltaXphdGlvbnMpIHRoYXQgd2UgcGxhbiB0byBzdWJtaXQgYXMg
Zm9sbG93LXVwDQo+ID4gc2VyaWVzLg0KPg0KPiBHcmVhdCB3b3JrLiBIaWdobHkgYXBwcmVjaWF0
ZSENCj4NCj4gPiBOb3RlIHRoYXQgdGhlIGxpbmUgY291bnQgbWF5IHNsaWdodGx5IGluY3JlYXNl
IGluIHYyLCBhcyB3ZSBwbGFuDQo+ID4gdG8gYWRkIG1pc3Npbmcga2RvYyBjb21tZW50cyBiYXNl
ZCBvbiByZXZpZXcgZmVlZGJhY2suDQo+ID4NCj4gPiBGb3IgcmVmZXJlbmNlLCB0aGUgdDd4eCBk
cml2ZXIgKHR3byBnZW5lcmF0aW9ucyBvbGRlciwgc2ltcGxlciBIVykNCj4gPiBoYWQgYW4gaW5p
dGlhbCBzdWJtaXNzaW9uIG9mIH4xMS4zayBMb0MgWzFdLiBUaGUgdDl4eCBoYXJkd2FyZSBpcw0K
PiA+IG1vcmUgY29tcGxleCwgc28gd2UgYmVsaWV2ZSBiZWluZyBpbiBhIHNpbWlsYXIgcmFuZ2Ug
aXMgcmVhc29uYWJsZS4NCj4NCj4gTGV0IG1lIGVsYWJvcmF0ZSBhIGJpdCBoZXJlLiBUaGUgc2l6
ZSBwcm9ibGVtIGlzIG5vdCBkdWUgdG8gYSBnaXQgb3IgYQ0KPiBtYWlsYm94IGxpbWl0YXRpb24u
IEl0IGFyaXNlIGR1ZSB0byB0aGUgaHVtYW4gbGltaXRhdGlvbi4gVGhlIFQ3eHgNCj4gc3VibWlz
c2lvbiByZXZpZXcgdG9vayBzb21ldGhpbmcgYWJvdXQgNCBtb250aHMgYW5kIDggaXRlcmF0aW9u
cy4gQW5kIGl0DQo+IHdhcyAnb25seScgMTEuM2sgbGluZXMuIExldCdzIGRvIHNvbWUgZXh0cmFw
b2xhdGlvbiBhc3N1bWluZyB0aGF0DQo+IGZ1bmN0aW9uIGlzIGxpbmVhci4gMTQuN2sgaXMgMzAl
IGJpZ2dlciwgdGh1cywgZXN0aW1hdGVkIHJldmlld2luZyB0aW1lDQo+IHNob3VsZCBiZSA1IG1v
bnRocyBhbmQgMiB3ZWVrcy4gQW5kIHRoaXMgbG9va3Mgb3B0aW1pc3RpYy4NCj4NCj4gUmVjb21t
ZW5kYXRpb24sIHNoYXJlZCBieSBKYWt1YiwgaXMgcHJhY3RpY2FsLiA1ayBsaW5lcyBtaWdodCBi
ZQ0KPiByZXZpZXdlZCBpbiBhIHJlYXNvbmFibGUgdGltZSBhbmQgbWVyZ2VkIHdpdGggdGhlIGZ1
bGwgY29uZmlkZW5jZSBvZiB0aGUNCj4gcXVhbGl0eS4NCj4NCj4gPiBXZSdkIGxpa2UgdG8ga2Vl
cCB0aGUgZHJpdmVyIGZ1bmN0aW9uYWwgYW5kIHJldmlld2FibGUgaW4gaXRzDQo+ID4gY3VycmVu
dCBzY29wZS4gRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIG9uIGhvdyB3ZSBjb3VsZCBmdXJ0
aGVyDQo+ID4gcmVkdWNlIHRoZSBzaXplIHdoaWxlIG1haW50YWluaW5nIGEgd29ya2luZyBpbml0
aWFsIHN1Ym1pc3Npb24/DQo+DQo+IE9mZiB0aGUgdG9wIG9mIG15IGhlYWQsIEkgd291bGQgc3Vn
Z2VzdCBqb2luaW5nIFQ3eHggYW5kIFQ5eHggY29kZQ0KPiBiYXNlcy4gSXQgY291bGQgYmUgZG9u
ZSB0aHJvdWdoIGZhY3RvcmluZyBvdXQgYSBjb3JlIGZ1bmN0aW9uYWxpdHkgb2YNCj4gVDd4eCBp
bnRvIGEgbGlicmFyeSwgb3IgdGhyb3VnaCBtYWtpbmcgdGhlIGRyaXZlciBsYXllcmVkLg0KPg0K
PiBJIGFtIG5vdCBwcmV0ZW5kaW5nIGJlaW5nIGFuIGV4cGVydCBpbiBhbnkgb2YgdGhlc2UgZHJp
dmVycywgYnV0DQo+IGdlbmVyYWxseSBkaXZpZGUtbi1jb25xdWVyb3IgdG9nZXRoZXIgd2l0aCBj
b2RlIHJldXNlIHdvcmsgcmVsaWFibGUuIEFzDQo+IGFuIGFsdGVybmF0aXZlLCBJIGNvdWxkIHNw
ZW5kIGEgY291cGxlIG9mIHdlZWtzIHJldmlld2luZyB0aGUgbmV3DQo+IHN1Ym1pc3Npb24gYW5k
IHdpbGwgY29tZSB3aXRoIG1vcmUgc3BlY2lmaWMgaWRlYXMgb24gd2hhdCBjYW4gYmUgdGhyb3du
DQo+IGF3YXkgb3IgcmV1c2VkLg0KPg0KDQpUaGFuayB5b3UgZm9yIHRoZSBkZXRhaWxlZCBleHBs
YW5hdGlvbiBhbmQgdGhlIHByYWN0aWNhbCBzdWdnZXN0aW9ucy4NCg0KV2UgZGlzY3Vzc2VkIHRo
aXMgd2l0aCBNZWRpYVRlay4gVGhlIFQ3WFggYW5kIFQ5WFggaGFyZHdhcmUgYXJjaGl0ZWN0dXJl
cw0KaGF2ZSBkaXZlcmdlZCBzaWduaWZpY2FudGx5LCBzbyBkZXZlbG9waW5nIGEgc2hhcmVkIGRy
aXZlciB3b3VsZCByZXF1aXJlDQpzdWJzdGFudGlhbCBlZmZvcnQgYW5kIHJpc2sgaW50cm9kdWNp
bmcgcmVncmVzc2lvbnMgaW4gdGhlIGV4aXN0aW5nIFQ3WFgNCmRyaXZlciwgcmVxdWlyaW5nIGV4
dGVuc2l2ZSB0ZXN0aW5nIHRvIGVuc3VyZSByZWxpYWJpbGl0eS4NCg0KTWVkaWFUZWsgYWxzbyBj
b25maXJtZWQgdGhhdCB0aGUgY3VycmVudCBkcml2ZXIgY2Fubm90IGJlIHJlZHVjZWQgZnVydGhl
cg0Kd2l0aG91dCByZW1vdmluZyBmdW5jdGlvbmFsaXR5LiBPbmUgb3B0aW9uIHdvdWxkIGJlIHRv
IHJlbW92ZSB0aGUgZGF0YQ0KcGxhbmUgYW5kIHBvd2VyIG1hbmFnZW1lbnQgcGF0Y2hlcywgd2hp
Y2ggd291bGQgYnJpbmcgdGhlIHN1Ym1pc3Npb24gZG93bg0KdG8gYXBwcm94aW1hdGVseSA5LDAw
MCBsaW5lczoNCg0KWzAvN10gbmV0OiB3d2FuOiB0OXh4OiBBZGQgTWVkaWFUZWsgVDlYWCBXV0FO
IGRyaXZlcg0KWzEvN10gbmV0OiB3d2FuOiB0OXh4OiBBZGQgUENJZSBjb3JlDQpbMi83XSBuZXQ6
IHd3YW46IHQ5eHg6IEFkZCBjb250cm9sIHBsYW5lIHRyYW5zYWN0aW9uIGxheWVyDQpbMy83XSBu
ZXQ6IHd3YW46IHQ5eHg6IEFkZCBjb250cm9sIERNQSBpbnRlcmZhY2UNCls0LzddIG5ldDogd3dh
bjogdDl4eDogQWRkIGNvbnRyb2wgcG9ydA0KWzUvN10gbmV0OiB3d2FuOiB0OXh4OiBBZGQgRlNN
IHRocmVhZA0KWzYvN10gbmV0OiB3d2FuOiB0OXh4OiBBZGQgQVQgJiBNQklNIFdXQU4gcG9ydHMN
Cls3LzddIG5ldDogd3dhbjogdDl4eDogQWRkIG1haW50YWluZXJzIGFuZCBkb2N1bWVudGF0aW9u
DQoNCldlIGhhdmUgdmVyaWZpZWQgdGhhdCB0aGUgTUJJTSBhbmQgQVQgcG9ydHMgd29yayBpbmRl
cGVuZGVudGx5IGluIHRoaXMNCmNvbmZpZ3VyYXRpb24goVggdGhlIGNvbnRyb2wgcGxhbmUgaXMg
ZnVsbHkgZnVuY3Rpb25hbCwganVzdCB3aXRob3V0IHRoZQ0KbmV0d29yayBpbnRlcmZhY2UuDQoN
ClRoYXQgc2FpZCwgd2Ugd291bGQgcHJlZmVyIHRvIGNvbnRpbnVlIHRoZSByZXZpZXcgd2l0aCB0
aGUgY3VycmVudCAxNC43aw0KbGluZSBzdWJtaXNzaW9uIGlmIHRoZSBjb21tdW5pdHkgaXMgb3Bl
biB0byBpdCwgYXMgaXQgcmVwcmVzZW50cyBhIG1vcmUNCmNvbXBsZXRlIGFuZCB0ZXN0YWJsZSBk
cml2ZXIuIFdlIGFyZSBoYXBweSB0byBnbyBlaXRoZXIgd2F5IGJhc2VkIG9uIHlvdXINCnByZWZl
cmVuY2UuDQoNClRoYW5rcy4NCj4gPiBbMV0NCj4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3Byb2plY3QvbmV0ZGV2YnBmL2NvdmVyLzIwMjIwNTA2MTgxMzEwLjIxODM4MjktMS1yaWNh
cmRvLm1hcnRpbmV6QGxpbnV4LmludGVsLmNvbS8NCj4gPg0KPiA+IFRoYW5rcy4NCj4gPg0KPiA+
DQo+ID4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+
IFRoaXMgbWVzc2FnZSBtYXkgY29udGFpbiBpbmZvcm1hdGlvbiB3aGljaCBpcyBwcml2YXRlLCBw
cml2aWxlZ2VkIG9yDQo+ID4gY29uZmlkZW50aWFsIG9mIENvbXBhbCBFbGVjdHJvbmljcywgSW5j
LiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQNCj4gPiByZWNpcGllbnQgb2YgdGhpcyBtZXNz
YWdlLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYW5kIGRlc3Ryb3kvZGVsZXRlIHRoZQ0KPiA+
IG1lc3NhZ2UuIEFueSByZXZpZXcsIHJldHJhbnNtaXNzaW9uLCBkaXNzZW1pbmF0aW9uIG9yIG90
aGVyIHVzZSBvZiwgb3INCj4gPiB0YWtpbmcgb2YgYW55IGFjdGlvbiBpbiByZWxpYW5jZSB1cG9u
IHRoaXMgaW5mb3JtYXRpb24sIGJ5IHBlcnNvbnMgb3INCj4gPiBlbnRpdGllcyBvdGhlciB0aGFu
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQgaXMgcHJvaGliaXRlZC4NCj4gPiA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+DQo+IEFuZCB0aGlzIGRpc2NsYWlt
ZXIgZG9lcyBub3QgZmFjaWxpdGF0ZSB0aGUgcmV2aWV3LiBBbSBJICdpbnRlbmRlZCcNCj4gcmVj
aXBpZW50IG9yIHNob3VsZCBJIGRlc3Ryb3kgdGhlIG1lc3NhZ2UgQVNBUD8NCg0KUGxlYXNlIGln
bm9yZSB0aGlzIG1lc3NhZ2UuDQpPdXIgY29tcGFueSdzIG1haWwgc2VydmVyIGF1dG9tYXRpY2Fs
bHkgYWRkcyB0aGlzIGFubm91bmNlbWVudCB0byBhbGwgZXh0ZXJuYWwgZW1haWxzLg0KV2UgYXBv
bG9naXplIGZvciB0aGUgaW5jb252ZW5pZW5jZS4NCg0KVGhhbmtzLg0KDQoNCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClRoaXMgbWVzc2FnZSBtYXkgY29u
dGFpbiBpbmZvcm1hdGlvbiB3aGljaCBpcyBwcml2YXRlLCBwcml2aWxlZ2VkIG9yIGNvbmZpZGVu
dGlhbCBvZiBDb21wYWwgRWxlY3Ryb25pY3MsIEluYy4gSWYgeW91IGFyZSBub3QgdGhlIGludGVu
ZGVkIHJlY2lwaWVudCBvZiB0aGlzIG1lc3NhZ2UsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBh
bmQgZGVzdHJveS9kZWxldGUgdGhlIG1lc3NhZ2UuIEFueSByZXZpZXcsIHJldHJhbnNtaXNzaW9u
LCBkaXNzZW1pbmF0aW9uIG9yIG90aGVyIHVzZSBvZiwgb3IgdGFraW5nIG9mIGFueSBhY3Rpb24g
aW4gcmVsaWFuY2UgdXBvbiB0aGlzIGluZm9ybWF0aW9uLCBieSBwZXJzb25zIG9yIGVudGl0aWVz
IG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudCBpcyBwcm9oaWJpdGVkLg0KPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K

