Return-Path: <netdev+bounces-301825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z34sJLqKPGr1pAgAu9opvQ
	(envelope-from <netdev+bounces-301825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:56:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF35B6C2437
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:56:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=compal.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301825-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301825-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8BDB301A433
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 01:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ECD3839B3;
	Thu, 25 Jun 2026 01:56:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40D036D503;
	Thu, 25 Jun 2026 01:56:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352566; cv=none; b=mIV5Gs7w/U0/tl6huPKElyJk/FENBja+WvYETRc+azWMj/e5F5v90L7UENx9c3YMXVXagRuJI0eKPJtZe7GI+FW0Gt+o79tbebdY+iEpnmdjJ2ajHT7KoD1srQl/vpeNauNFZFazc4G8TBcKL2Tu7JlskHCx2UhLhCZOC7P3OmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352566; c=relaxed/simple;
	bh=TYnjqPNVFu7ROXRSzsNG7oC6Xw/dD3rEz9+rqBfvRdk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lwcP2QTAojNWFuiLsxhndRnYqtP1z0ZXWvW3oCBmvuoEzWU4kiTimCeQZlXaat9iELpu6MCx6FPgMoJJDh2ApT/FhaQhWUpTjfy4/QfuGCDPHK1Nj7xAL41auTCPLjSYrIYcCC16cjtrqDUBtPIcf4imRtXo7bN2bbblnnnMZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
X-UUID: 00e40fba703911f1b2470fb4f881575f-20260625
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:595ade6c-3006-4358-acec-b1be158fd2a5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:3851d1fc-4e5b-4880-a751-e09c9abb260d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 00e40fba703911f1b2470fb4f881575f-20260625
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 383728583; Thu, 25 Jun 2026 09:55:55 +0800
X-UUID: fe6aebbe703811f1a9f9c99e036204b4-20260625
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:33c3770c-6076-40bd-b9fb-7dfd19789dd8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:a1a3b245-bfd5-44dc-a827-0ed06cccddf4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fe6aebbe703811f1a9f9c99e036204b4-20260625
Received: from sdbmbx12.tpe.compalcomm.com [(10.113.2.136)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES256-SHA 256/256)
	with ESMTP id 1419889263; Thu, 25 Jun 2026 09:55:51 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX12.tpe.compalcomm.com (10.113.2.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.29;
 Thu, 25 Jun 2026 09:55:49 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69%11]) with mapi id
 15.02.2562.029; Thu, 25 Jun 2026 09:55:49 +0800
From: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
To: Jakub Kicinski <kuba@kernel.org>
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
Subject: RE: [External Mail] Re: [PATCH v3 0/7] net: wwan: t9xx: Add MediaTek
 T9XX WWAN driver
Thread-Topic: [External Mail] Re: [PATCH v3 0/7] net: wwan: t9xx: Add MediaTek
 T9XX WWAN driver
Thread-Index: AQHdBDbr7gV1PIIW20uy7p6BeLMYarZOgjDU
Date: Thu, 25 Jun 2026 01:55:49 +0000
Message-ID: <cec5736466864641967b99adcfaf324a@compal.com>
References: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>,<20260624170917.09967c74@kernel.org>
In-Reply-To: <20260624170917.09967c74@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30028.002
x-tm-as-result: No-10--16.192600-8.000000
x-tmase-matchedrid: gIzQ6PxOy4Muv++HU7VXryRFbfQbCufdN0X64jGy2dbVc/AFNTvLS9XY
	nKy9ZqbG0wNjG7j2lpdVUa9LFLuAZpxv10buNpyDTAmQRh6AQEfVmJNHK/THAdorNiZ3c9zKLRf
	XC5L8hclDfCGkjjCVDTpfMfqKQCtJRC61Eoj6CJWbZ5Rb+gO6ITj61oDLR3drl2KBmLXt0epcRg
	SNUhN0V7Gs6LmC3y4my5giTPlFHEONYN8w7dbL+QJmkj1SAkweoli4ZoiOHT8g4pZYxslhbbNke
	EYGbJYuA/3R8k/14e0=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--16.192600-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30028.002
x-tm-snts-smtp: 111CFFE2D82E31ED4BD8D70AC0B219B45BE41667AA6B454FDB79CD9BE7D3B1502000:8
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301825-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,redhat.com,mediatek.com,collabora.com,kernel.org,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: BF35B6C2437

SGkgSmFrdWIsDQoNCj4gT24gV2VkLCAyNCBKdW4gMjAyNiAxODowNDowNiArMDgwMCBKYWNrIFd1
IHZpYSBCNCBSZWxheSB3cm90ZToNCj4gPiBUOVhYIGlzIHRoZSBQQ0llIGhvc3QgZGV2aWNlIGRy
aXZlciBmb3IgTWVkaWFUZWsncw0KPiA+IHQ5MDAgbW9kZW0uIFRoZSBkcml2ZXIgdXNlcyB0aGUg
V1dBTiBmcmFtZXdvcmsNCj4gPiBpbmZyYXN0cnVjdHVyZSB0byBjcmVhdGUgdGhlIGZvbGxvd2lu
ZyBjb250cm9sIHBvcnRzDQo+ID4gYW5kIG5ldHdvcmsgaW50ZXJmYWNlcyBmb3IgZGF0YSB0cmFu
c2FjdGlvbnMuDQo+DQo+IFJlcGx5aW5nIGFmdGVyIGEgbG9uZyBkZWxheSBhbmQgdGhlbiBpbW1l
ZGlhdGVseSBwb3N0aW5nIGEgbmV3IHZlcnNpb24NCj4gb2YgcGF0Y2hlcyBpcyB2ZXJ5IGJhZC4g
RG9uJ3QgYm90aGVyIHJlcGx5aW5nIGFuZCBqdXN0IHB1dCB0aGUgY29tbWVudHMNCj4geW91IGhh
ZCBpbiB0aGUgY2hhbmdlbG9nIG9mIHRoZSBuZXcgcG9zdGluZy4gT3RoZXJ3aXNlIHRoZSBkaXNj
dXNzaW9uDQo+IG1heSBnZXQgc3BsaXQuDQoNCiAgU29ycnkgYWJvdXQgdGhlIGNvbmZ1c2lvbi4N
Cg0KICBJIGhhdmUgYSBxdWVzdGlvbiBhYm91dCB0aGUgcHJlZmVycmVkIHdvcmtmbG93OiB0aGUg
Y292ZXINCiAgbGV0dGVyIGNoYW5nZWxvZyB3b3VsZCBnZXQgcXVpdGUgbG9uZyBpZiBJIGluY2x1
ZGUgZGV0YWlsZWQNCiAgZXhwbGFuYXRpb25zIGZvciBlYWNoIHNhc2hpa28gY29tbWVudCB3ZSBj
aG9zZSBub3QgdG8gZml4Lg0KDQogIFdhcyB0aGUgY29uY2VybiBtb3JlIGFib3V0IHRpbWluZz8g
U2hvdWxkIHdlIGhhdmUgcmVwbGllZA0KICB0byB0aGUgc2FzaGlrbyByZXZpZXcgcHJvbXB0bHkg
d2hlbiBpdCBjYW1lIGluLCByYXRoZXIgdGhhbg0KICB3YWl0aW5nIHVudGlsIHRoZSBmdWxsIHYz
IHdhcyByZWFkeT8NCg0KICBUaGFua3MgZm9yIHRoZSBndWlkYW5jZS4NCg0KDQo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpUaGlzIG1lc3NhZ2UgbWF5IGNv
bnRhaW4gaW5mb3JtYXRpb24gd2hpY2ggaXMgcHJpdmF0ZSwgcHJpdmlsZWdlZCBvciBjb25maWRl
bnRpYWwgb2YgQ29tcGFsIEVsZWN0cm9uaWNzLCBJbmMuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRl
bmRlZCByZWNpcGllbnQgb2YgdGhpcyBtZXNzYWdlLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIg
YW5kIGRlc3Ryb3kvZGVsZXRlIHRoZSBtZXNzYWdlLiBBbnkgcmV2aWV3LCByZXRyYW5zbWlzc2lv
biwgZGlzc2VtaW5hdGlvbiBvciBvdGhlciB1c2Ugb2YsIG9yIHRha2luZyBvZiBhbnkgYWN0aW9u
IGluIHJlbGlhbmNlIHVwb24gdGhpcyBpbmZvcm1hdGlvbiwgYnkgcGVyc29ucyBvciBlbnRpdGll
cyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQgaXMgcHJvaGliaXRlZC4NCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg==

