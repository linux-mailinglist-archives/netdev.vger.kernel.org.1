Return-Path: <netdev+bounces-295059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9nMtNqQeIWop/QAAu9opvQ
	(envelope-from <netdev+bounces-295059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 08:43:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEF763D4C4
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 08:43:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295059-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295059-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=compal.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C34E13020E2C
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 06:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71E13D79E2;
	Thu,  4 Jun 2026 06:42:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef22.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6DF373C0E;
	Thu,  4 Jun 2026 06:42:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555371; cv=none; b=ukLXEk3xeHILaf3k2y+qSoEo6KNkldEMx48K2CTjDPJ90lI3Uqg+n+AlhqJlNU1zmJrYS3aFno01UdK5zNvniTkZPWn0kMS6OSzMhzG1aZhl8T08Mfqcd4SY6U9ImU5t1gWUYpvBvrvRLdjyu5UcQMCCiG/QETY39MrRVH7Y9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555371; c=relaxed/simple;
	bh=mI9g6gD5BRy3kD3PF5NSErrg5217vlzsf1ZgKqQ13AA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N6gC8QpFDp5BD3naRABHfKubYbybnNAY7mThFkpmvP4+1c2XQAV6tY5zu2E9RipJe/4Tgp8HByTB2WTSi8T8SHyWomPUhCNXSdqw+82f/mTHjCJbeZV9PK/uXnh3Xg7iZJIucE2B2eY21QE0QAB224LyT5Rtl9p2Oug28UyUH/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
X-UUID: 968afd8a5fe011f1a87c2323a98e90a4-20260604
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:c893f2b7-45cf-41fe-b21c-3a1848270a5d,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e276073,CLOUDID:23cf472a-13d2-4d29-83ea-b8014339a000,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|817|836|865|
	888|898,TC:-5,Content:-10|-8|-5|15|50,EDM:-3,IP:nil,URL:11|94|82|106|1,Fil
	e:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR
	:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 968afd8a5fe011f1a87c2323a98e90a4-20260604
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef22.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1459051028; Thu, 04 Jun 2026 14:42:42 +0800
X-UUID: 938fe0325fe011f1a42089d3d1632821-20260604
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:f1996c64-118c-4810-bc2f-8dcf2a3762f9,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e276073,CLOUDID:0fc30542-f53d-456b-bcbe-afd9e5a5b333,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|817|836|865|
	888|898,TC:-5,Content:-10|-8|-5|15|50,EDM:-3,IP:nil,URL:11|94|82|106|1,Fil
	e:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR
	:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 938fe0325fe011f1a42089d3d1632821-20260604
Received: from sdbmbx13.tpe.compalcomm.com [(10.113.2.137)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 1827825207; Thu, 04 Jun 2026 14:42:37 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX13.tpe.compalcomm.com (10.113.2.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 4 Jun 2026 14:42:33 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69%11]) with mapi id
 15.02.2562.029; Thu, 4 Jun 2026 14:42:33 +0800
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
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH 01/11] net: wwan: t9xx: Add PCIe core
Thread-Topic: [PATCH 01/11] net: wwan: t9xx: Add PCIe core
Thread-Index: AQHc8bhcdmgibeQV+0mP7OG8OB0FzrYt9Hq3
Date: Thu, 4 Jun 2026 06:42:33 +0000
Message-ID: <c9e80369a7ec449a814cd85269f1135e@compal.com>
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
 <20260529-t9xx_driver_v1-v1-1-bdbfe2c01e57@compal.com>,<PH0PR11MB5902127C590230B9FE50F78AF0152@PH0PR11MB5902.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5902127C590230B9FE50F78AF0152@PH0PR11MB5902.namprd11.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-29986.005
x-tm-as-result: No-10--7.938100-8.000000
x-tmase-matchedrid: EefIVvJ/ke0uv++HU7VXryRFbfQbCufdN0X64jGy2dbVc/AFNTvLSw2J
	SRqdWmN4dOiVKzG2jpTSPUHhcw+FHAE8OiDrjBOCUirF7gO7fvl0pPFWgq1KNgSjtG4gy/zQk3M
	PpgxG+BYZ+O+6wWe+rfJ3yfksIbvtUohvb26/VwDIUNmTDb0ad1XyfUSvLyzCwuyxgbj8l3/4mW
	TdKLNVsJtnQM1dYEpEhP3qugnKLontZDpZlNWg4O3qPLdU3cUZ8kOnQJj3cxKt4Zcwyi58uXaRl
	uqYn9rmrWwln+vsup2vvs41AhDx9CRoQhMu0UDBJPlTeUnhPwrNWLms91YSA1o7GmCOJYd1O50T
	9A74HCu2FEUBwKd8ytET2zOm+uW5sIEAo6wFidwno0Idd9TzoxCUQCtauB3Whv30+gdEALI=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--7.938100-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-29986.005
x-tm-snts-smtp: EA7519F9C438C9B8BD9413C927FD465DE89BEFAF1CB7E18423535D7878401CC42000:8
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url];
	TAGGED_FROM(0.00)[bounces-295059-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jedrzej.jagielski@intel.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AEF763D4C4

DQoNCj4gU2VudDogRnJpZGF5LCBNYXkgMjksIDIwMjYgMTI6MzIgUE0NCj4NCj4gPiArDQo+DQo+
IHBsZWFzZSBhbHNvIHRha2UgYSBsb29rIG9uIHNhc2hpa28gbm90ZXMsIHRoZXJlIGlzIHNvbWUg
bnVtYmVyIG9mIHRoZW0NCg0KSGkgSmFnaWVsc2tpLA0KDQogIFRoYW5rIHlvdSBmb3IgeW91ciBy
ZXZpZXcuIFdlIGhhdmUgZml4ZWQgc29tZSBpc3N1ZXMgYW5kIGFyZSBzdGlsbCBkaXNjdXNzaW5n
IG90aGVycyB3aXRoIE1lZGlhVGVrLiBBbGwgb2YgdGhlbSB3aWxsIGJlIGFkZHJlc3NlZCBpbiBW
Mi4NCg0KICBSZWdhcmRpbmcgc2FzaGlrbyBub3RlcywgaG93IHNob3VsZCBJIGhhbmRsZSB0aGVt
IGlmIGRpc2N1c3Npb24gaXMgbmVlZGVkPyBJIGNhbm5vdCBmaW5kIHNhc2hpa28ncyBlbWFpbCBh
ZGRyZXNzLCBhbmQgaXRzIHdlYnNpdGUgZG9lcyBub3QgaGF2ZSBhIHJlcGx5IG9wdGlvbi4NCg0K
Rm9yIGV4YW1wbGU6DQogIGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDUyOS10
OXh4X2RyaXZlcl92MS12MS0wLWJkYmZlMmMwMWU1NyU0MGNvbXBhbC5jb20/cGFydD0yDQoNCiAg
UTE6DQogIFRoZSBjb21taXQgbWVzc2FnZSBtZW50aW9ucyBpbXBsZW1lbnRpbmcgVFggYW5kIFJY
IHNlcnZpY2VzLCBidXQgdGhlIHBhdGNoIHByaW1hcmlseSBhZGRzIGVtcHR5IHN0cnVjdHVyZXMg
YW5kIGJvaWxlcnBsYXRlIGNvZGUuIElzIHRoZSBwYXRjaCBtaXNzaW5nIHRoZSBhY3R1YWwgVFgv
UlggaW1wbGVtZW50YXRpb24gZGVzY3JpYmVkIGhlcmU/DQoNCiAgUmVwbHk6DQogIFdlIHBsYW4g
dG8gdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZS4gV291bGQgdGhlIGZvbGxvd2luZyBiZSBhY2Nl
cHRhYmxlPw0KDQogICAgQWRkIHRoZSBjb250cm9sIHBsYW5lIHRyYW5zYWN0aW9uIGxheWVyIGZy
YW1ld29yayBmb3IgdGhlIHQ5eHgNCiAgICBXV0FOIGRyaXZlciwgaW5jbHVkaW5nIGNvbmZpZ3Vy
YXRpb24gb3B0aW9ucywgZGV2aWNlIHN0cnVjdHVyZQ0KICAgIGRlZmluaXRpb25zLCBhbmQgaW5p
dGlhbGl6YXRpb24vY2xlYW51cCBmdW5jdGlvbnMuDQoNCiAgICBUaGUgYWN0dWFsIFRYL1JYIHNl
cnZpY2UgaW1wbGVtZW50YXRpb25zIHRoYXQgdXNlIHRoaXMgZnJhbWV3b3JrDQogICAgYXJlIGlu
dHJvZHVjZWQgaW4gc3Vic2VxdWVudCBwYXRjaGVzLg0KDQoNClRoYW5rcy4NCg0KDQoNCg0KDQo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpUaGlzIG1lc3Nh
Z2UgbWF5IGNvbnRhaW4gaW5mb3JtYXRpb24gd2hpY2ggaXMgcHJpdmF0ZSwgcHJpdmlsZWdlZCBv
ciBjb25maWRlbnRpYWwgb2YgQ29tcGFsIEVsZWN0cm9uaWNzLCBJbmMuIElmIHlvdSBhcmUgbm90
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQgb2YgdGhpcyBtZXNzYWdlLCBwbGVhc2Ugbm90aWZ5IHRo
ZSBzZW5kZXIgYW5kIGRlc3Ryb3kvZGVsZXRlIHRoZSBtZXNzYWdlLiBBbnkgcmV2aWV3LCByZXRy
YW5zbWlzc2lvbiwgZGlzc2VtaW5hdGlvbiBvciBvdGhlciB1c2Ugb2YsIG9yIHRha2luZyBvZiBh
bnkgYWN0aW9uIGluIHJlbGlhbmNlIHVwb24gdGhpcyBpbmZvcm1hdGlvbiwgYnkgcGVyc29ucyBv
ciBlbnRpdGllcyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQgaXMgcHJvaGliaXRl
ZC4NCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg==

