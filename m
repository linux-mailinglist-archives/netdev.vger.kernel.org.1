Return-Path: <netdev+bounces-294151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DkGCTS4HmrZJgAAu9opvQ
	(envelope-from <netdev+bounces-294151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:02:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D85162D16E
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 612CD304C62B
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 10:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21AC38B7B1;
	Tue,  2 Jun 2026 10:58:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef22.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878CD303CAB;
	Tue,  2 Jun 2026 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397929; cv=none; b=sz3ZsyNexO/Bxy2ZM+KN6iOfeG/tLTlxcE83tG+W7AZDPFlHrQq5qB88sV4vYTCkcDdzfVOf2oHWE/K38CwvmCXWOS8mJHxyiKj3CoffTJecr+gT59PndihCyGQmU3rFGKkUfzcYeJ6DPp8+CoMsU1YgM4A7mOErSHlylyx3FpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397929; c=relaxed/simple;
	bh=MAOU/H4rP3vMD5JkGQ/N6kaHM6Ob1xXG95h7Yn8X/I8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Epi//UQlY7Qxivwy/vJVIVyzjfd1Y6QbxiMDJqEXkir3GdDIS9hyTprkbMox0vnuFVUHEOK+2OWjBQaOQgcIxlLKH9RNUo7bUgOiOSDk/C0hEI3hBGXWoLQiU4vZz2HsgfxMXDlwoW5wH1kxoBGDP3nfxj0xwDSUCnUdFSyR1Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: 054f0f425e7211f1a87c2323a98e90a4-20260602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:b8fb18fe-69d2-430e-a2d4-b25185e77789,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:6129ffd6-0b04-449f-bc4f-a909b8df9b02,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 054f0f425e7211f1a87c2323a98e90a4-20260602
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef22.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 767860867; Tue, 02 Jun 2026 18:58:43 +0800
X-UUID: 032bf1445e7211f1943831befd1aa4bc-20260602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:b2ed9818-399c-4c40-83a8-13e3fd1ae099,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:4429ffd6-0b04-449f-bc4f-a909b8df9b02,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 032bf1445e7211f1943831befd1aa4bc-20260602
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 1693711392; Tue, 02 Jun 2026 18:58:39 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Jun 2026 18:58:37 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69%11]) with mapi id
 15.02.2562.029; Tue, 2 Jun 2026 18:58:37 +0800
From: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
To: Jakub Kicinski <kuba@kernel.org>, Jack Wu via B4 Relay
	<devnull+jackbb_wu.compal.com@kernel.org>
CC: Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov
	<ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Wen-Zhi
 Huang <wen-zhi.huang@mediatek.com>, Shi-Wei Yeh <shi-wei.yeh@mediatek.com>,
	"Minano Tseng" <Minano.tseng@mediatek.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "Simon Horman" <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [External Mail] Re: [PATCH 00/11] net: wwan: t9xx: Add MediaTek
 T9XX WWAN driver
Thread-Topic: [External Mail] Re: [PATCH 00/11] net: wwan: t9xx: Add MediaTek
 T9XX WWAN driver
Thread-Index: AQHc8iePJegWnmu1bUi94DWo9+PN/LYrGJEz
Date: Tue, 2 Jun 2026 10:58:37 +0000
Message-ID: <c279aea41ecf41c6aca4314a2f4e306b@compal.com>
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>,<20260601173401.2c892526@kernel.org>
In-Reply-To: <20260601173401.2c892526@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-29982.005
x-tm-as-result: No-10--20.911500-8.000000
x-tmase-matchedrid: 13nEecSBt9Euv++HU7VXryRFbfQbCufdN0X64jGy2dbVc/AFNTvLS9XY
	nKy9ZqbG0wNjG7j2lpfWtteiDVXz7mpW0A+eYNud4WMcbQqR5OFkrVIXZHd52KloHyDFpaEsbxq
	9W35blN9+M8NObIEDkCLCiAPpH5Zk/7zDDoXJoQ2DhqUecocKp5Wa6EbToghtwd4te8L2vhKVPE
	hvdlk+CqeenaCmQghS8mtEegHTuKyGtpiI1cumNtTSGjubFor4a3FVQe5d4zvlNADTSrHglS1A/
	qnDlqGPFpzeGnmPO0/7sEGacnICGo1g3zDt1sv5v9rSd36EgULA931+mNd9sJs7gkGWoKY36QLg
	e8Tcpn0=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--20.911500-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-29982.005
x-tm-snts-smtp: 3683968551714F2E1CC524964F4B12B68B09CA53E3CB9515879F16383EF833F72000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5D85162D16E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.14 / 15.00];
	DMARC_POLICY_REJECT(2.00)[compal.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-294151-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,redhat.com,mediatek.com,collabora.com,kernel.org,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,jackbb_wu.compal.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

SGkgSmFrdWIsDQoNCj4gT24gRnJpLCAyOSBNYXkgMjAyNiAxODozMTozOSArMDgwMCBKYWNrIFd1
IHZpYSBCNCBSZWxheSB3cm90ZToNCj4gPiA0MyBmaWxlcyBjaGFuZ2VkLCAxNDc2MSBpbnNlcnRp
b25zKCspDQo+DQo+IFBsZWFzZSB0cnkgdG8gY3V0IHRoaXMgZG93biB0byB+NWtMb0MgZm9yIHRo
ZSBpbml0aWFsIHN1Ym1pc3Npb24uDQo+IFdoYXRldmVyIHRoZSBhYnNvbHV0ZSBtaW5pbXVtIHNl
bnNpYmxlIGNodW5rIG9mIGNvZGUgaXMuDQo+DQo+IEVhY2ggcGF0Y2ggbXVzdCBidWlsZCBjbGVh
bmx5IHdpdGggVz0xDQoNCldlJ3ZlIGFscmVhZHkgcmVkdWNlZCB0aGlzIHNpZ25pZmljYW50bHkg
ZnJvbSB0aGUgb3JpZ2luYWwgNDFrIExvQw0KZG93biB0byB+MTQuN2sgYnkgc3RyaXBwaW5nIG91
dCBub24tZXNzZW50aWFsIGZlYXR1cmVzIHN1Y2ggYXMNCmV4Y2VwdGlvbiBoYW5kbGluZywgbWVt
b3J5IGxvZ2dpbmcsIGRldmxpbmssIHN0YXRpc3RpY3MsIGRlYnVnDQp0cmFjaW5nLCBhbmQgb3Ro
ZXJzLg0KDQpXZSBldmVuIHJlbW92ZWQgc29tZSBhcmd1YWJseSBuZWNlc3NhcnkgZmVhdHVyZXMg
KFBNLCBtZGxvZywNCnRocm91Z2hwdXQgb3B0aW1pemF0aW9ucykgdGhhdCB3ZSBwbGFuIHRvIHN1
Ym1pdCBhcyBmb2xsb3ctdXANCnNlcmllcy4NCg0KTm90ZSB0aGF0IHRoZSBsaW5lIGNvdW50IG1h
eSBzbGlnaHRseSBpbmNyZWFzZSBpbiB2MiwgYXMgd2UgcGxhbg0KdG8gYWRkIG1pc3Npbmcga2Rv
YyBjb21tZW50cyBiYXNlZCBvbiByZXZpZXcgZmVlZGJhY2suDQoNCkZvciByZWZlcmVuY2UsIHRo
ZSB0N3h4IGRyaXZlciAodHdvIGdlbmVyYXRpb25zIG9sZGVyLCBzaW1wbGVyIEhXKQ0KaGFkIGFu
IGluaXRpYWwgc3VibWlzc2lvbiBvZiB+MTEuM2sgTG9DIFsxXS4gVGhlIHQ5eHggaGFyZHdhcmUg
aXMNCm1vcmUgY29tcGxleCwgc28gd2UgYmVsaWV2ZSBiZWluZyBpbiBhIHNpbWlsYXIgcmFuZ2Ug
aXMgcmVhc29uYWJsZS4NCg0KV2UnZCBsaWtlIHRvIGtlZXAgdGhlIGRyaXZlciBmdW5jdGlvbmFs
IGFuZCByZXZpZXdhYmxlIGluIGl0cw0KY3VycmVudCBzY29wZS4gRG8geW91IGhhdmUgYW55IHN1
Z2dlc3Rpb25zIG9uIGhvdyB3ZSBjb3VsZCBmdXJ0aGVyDQpyZWR1Y2UgdGhlIHNpemUgd2hpbGUg
bWFpbnRhaW5pbmcgYSB3b3JraW5nIGluaXRpYWwgc3VibWlzc2lvbj8NCg0KWzFdIGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9uZXRkZXZicGYvY292ZXIvMjAyMjA1MDYxODEz
MTAuMjE4MzgyOS0xLXJpY2FyZG8ubWFydGluZXpAbGludXguaW50ZWwuY29tLw0KDQpUaGFua3Mu
DQoNCg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KVGhp
cyBtZXNzYWdlIG1heSBjb250YWluIGluZm9ybWF0aW9uIHdoaWNoIGlzIHByaXZhdGUsIHByaXZp
bGVnZWQgb3IgY29uZmlkZW50aWFsIG9mIENvbXBhbCBFbGVjdHJvbmljcywgSW5jLiBJZiB5b3Ug
YXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgbWVzc2FnZSwgcGxlYXNlIG5v
dGlmeSB0aGUgc2VuZGVyIGFuZCBkZXN0cm95L2RlbGV0ZSB0aGUgbWVzc2FnZS4gQW55IHJldmll
dywgcmV0cmFuc21pc3Npb24sIGRpc3NlbWluYXRpb24gb3Igb3RoZXIgdXNlIG9mLCBvciB0YWtp
bmcgb2YgYW55IGFjdGlvbiBpbiByZWxpYW5jZSB1cG9uIHRoaXMgaW5mb3JtYXRpb24sIGJ5IHBl
cnNvbnMgb3IgZW50aXRpZXMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IGlzIHBy
b2hpYml0ZWQuDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
DQo=

