Return-Path: <netdev+bounces-297613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id saKGNwlBKWo5TAMAu9opvQ
	(envelope-from <netdev+bounces-297613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:48:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CD96686DF
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:48:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=compal.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297613-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297613-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 623C5313E54B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441343F86EC;
	Wed, 10 Jun 2026 10:41:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef22.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670CE3F44C8;
	Wed, 10 Jun 2026 10:41:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088071; cv=none; b=GihBvT52R604SkYLClRQVtGtNiyYbwH9hevhcUQBZV/D3qOT0n7jCQLuoarBzs1ns61K7g/woLe4cfXA6f+VD+WiHndL4uoVA2Ek2/QsnAjgVIAiWl4+HDG3b10ezo3ZxqeGZiJ7z8A1mtxo3AgMXQRGGC0CJpVHWsX5vEs8PxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088071; c=relaxed/simple;
	bh=X4cHUsy17i/oJpycpVVzFP8YI1IsCTMX3DiYCihWkcA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PqtKFMR3suT6vcYs63KnA2KMkTE6rFfC2SkHUkahpeqNCN7D93AiCX8bHPsHU0NEiSQi2yINzgidIJw4WqNc+7tsgmuVbkDSEJG2wpjjUOzQJvtAxVluowIAwUtu3xcAsrrDaboWzVJ7iElDJrfOtQVqgGzypkEOQGlqB0EdOhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
X-UUID: df3c3abc64b811f1a87c2323a98e90a4-20260610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:2ac02e60-505a-4b01-abee-6052979145f9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:8e6a882a-13d2-4d29-83ea-b8014339a000,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: df3c3abc64b811f1a87c2323a98e90a4-20260610
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef22.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1768678905; Wed, 10 Jun 2026 18:41:00 +0800
X-UUID: dc9e333264b811f1943831befd1aa4bc-20260610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:a8d029ca-758b-49d6-a8b3-e566e168da00,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:7c85e7a4-9ef7-4489-861a-e83b251ece46,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dc9e333264b811f1943831befd1aa4bc-20260610
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 43648245; Wed, 10 Jun 2026 18:40:56 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 10 Jun 2026 18:40:52 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69%11]) with mapi id
 15.02.2562.029; Wed, 10 Jun 2026 18:40:52 +0800
From: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, Loic Poulain
	<loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, Shi-Wei Yeh
	<shi-wei.yeh@mediatek.com>, Minano Tseng <Minano.tseng@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"wojackbb@gmail.com" <wojackbb@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH 02/11] net: wwan: t9xx: Add control plane transaction
 layer
Thread-Topic: [PATCH 02/11] net: wwan: t9xx: Add control plane transaction
 layer
Thread-Index: AQHc8bk+1UsrKa/XR0qfabIgrb3y4LY3lQgi
Date: Wed, 10 Jun 2026 10:40:52 +0000
Message-ID: <547cfcb5d0564a7b8a1559910f8d54c8@compal.com>
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
 <20260529-t9xx_driver_v1-v1-2-bdbfe2c01e57@compal.com>,<PH0PR11MB5902FB4FF84AF8041B72D455F0152@PH0PR11MB5902.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5902FB4FF84AF8041B72D455F0152@PH0PR11MB5902.namprd11.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-29998.006
x-tm-as-result: No-10--15.724400-8.000000
x-tmase-matchedrid: 13nEecSBt9Euv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZgOe
	+RYG/aOVMleF7vJIPgqngxQtDfARLJNGCDJJzpnrGG92L3YEEC4KEmq2HWwB6pxT0ucAo6R2dPQ
	2JTiaKeKG4JQWzp0Zih6lu1tpMWzEknndMSHWXqCTlNTCzR+UCOwFnNOJUtAVMLjTaDguNi+3UZ
	vGR+CLKEtQw4utslF9AncoiTVMdT0QPgd/epoDdr+y8+LvjzkGT7IWEFuukP5dzRkE/gTMQeYRj
	GOCJsx0JWAArnzpKFTLmCJM+UUcQ41g3zDt1sv5v9rSd36EgULA931+mNd9sJs7gkGWoKY36QLg
	e8Tcpn0=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--15.724400-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-29998.006
x-tm-snts-smtp: 7FFC1613B90922E79617064043959316F57413319CC95328D8E791F49BFFC0232000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.14 / 15.00];
	DMARC_POLICY_REJECT(2.00)[compal.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-297613-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jedrzej.jagielski@intel.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:wojackbb@gmail.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,compal.com:mid,compal.com:from_mime];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56CD96686DF

SGkgSmFnaWVsc2tpLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuIEJlbG93IGFyZSB0aGUg
Y2hhbmdlcyBhbmQgcmVzcG9uc2VzIGZvciB2Mi4NCg0KPiA+ICtpbnQgbXRrX2N0cmxfaW5pdChz
dHJ1Y3QgbXRrX21kX2RldiAqbWRldikNCj4gPiArew0KPiA+IC4uLg0KPiA+ICtFWFBPUlRfU1lN
Qk9MKG10a19jdHJsX2luaXQpOw0KPg0KPiBwbGVhc2UgYWRkIGtkb2MsIGVzcGVjaWFsbHkgdGhl
cmUncyBFWFBPUlRfU1lNQk9MDQoNCkFkZGVkIGtlcm5lbC1kb2MgY29tbWVudHMgdG8gYm90aCBt
dGtfY3RybF9pbml0KCkgYW5kDQptdGtfY3RybF9leGl0KCkuDQoNCj4gPiAraW50IG10a19jdHJs
X2V4aXQoc3RydWN0IG10a19tZF9kZXYgKm1kZXYpDQo+DQo+IGRvIHdlIG5lZWQgaW50IGlmIDAg
aXMgYWx3YXlzIHJldHVybmVkPw0KDQpDaGFuZ2VkIHRvIHZvaWQgcmV0dXJuIHR5cGUuDQoNCj4g
PiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPiA+ICsgKg0KPiA+
ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjIsIE1lZGlhVGVrIEluYy4NCj4NCj4gc2hvdWxkbid0IDIw
MjYgYmUgcHV0Pw0KDQpUaGUgY29weXJpZ2h0IHllYXIgcmVmbGVjdHMgdGhlIG9yaWdpbmFsIGNy
ZWF0aW9uIGRhdGUgb2YgdGhlDQpzb3VyY2UgY29kZSBieSBNZWRpYVRlay4gVGhpcyBpcyBjb25z
aXN0ZW50IHdpdGggdGhlIGNvbnZlbnRpb24NCnVzZWQgYnkgdGhlIGV4aXN0aW5nIHQ3eHggZHJp
dmVyIGluIHRoZSBrZXJuZWwgdHJlZS4NCg0KPiA+ICtzdGF0aWMgdm9pZCBfX2V4aXQgbXRrX2Nv
bW1vbl9kcnZfZXhpdCh2b2lkKQ0KPg0KPiBpcyBpdCB1c2VkIGFueXdoZXJlIGhlcmUgaW4gdGhl
IHBhdGNoPw0KDQpUaGlzIGlzIHRoZSBtb2R1bGVfZXhpdCBjYWxsYmFjayByZXF1aXJlZCBieSB0
aGUga2VybmVsIG1vZHVsZQ0KZnJhbWV3b3JrLiBJdCBpcyByZWdpc3RlcmVkIHZpYSBtb2R1bGVf
ZXhpdCgpIGFuZCBjYWxsZWQNCmF1dG9tYXRpY2FsbHkgd2hlbiB0aGUgbW9kdWxlIGlzIHVubG9h
ZGVkLiBJdCBpcyBpbnRlbnRpb25hbGx5DQplbXB0eSBhcyBubyBnbG9iYWwgY2xlYW51cCBpcyBu
ZWVkZWQgYXQgbW9kdWxlIGV4aXQgdGltZS4NCg0KVGhhbmtzLg0KDQpKYWNrIFd1DQoNCg0KPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KVGhpcyBtZXNzYWdl
IG1heSBjb250YWluIGluZm9ybWF0aW9uIHdoaWNoIGlzIHByaXZhdGUsIHByaXZpbGVnZWQgb3Ig
Y29uZmlkZW50aWFsIG9mIENvbXBhbCBFbGVjdHJvbmljcywgSW5jLiBJZiB5b3UgYXJlIG5vdCB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgbWVzc2FnZSwgcGxlYXNlIG5vdGlmeSB0aGUg
c2VuZGVyIGFuZCBkZXN0cm95L2RlbGV0ZSB0aGUgbWVzc2FnZS4gQW55IHJldmlldywgcmV0cmFu
c21pc3Npb24sIGRpc3NlbWluYXRpb24gb3Igb3RoZXIgdXNlIG9mLCBvciB0YWtpbmcgb2YgYW55
IGFjdGlvbiBpbiByZWxpYW5jZSB1cG9uIHRoaXMgaW5mb3JtYXRpb24sIGJ5IHBlcnNvbnMgb3Ig
ZW50aXRpZXMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IGlzIHByb2hpYml0ZWQu
DQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo=

