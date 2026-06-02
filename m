Return-Path: <netdev+bounces-294107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJJ+F3WiHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:29:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC0062B951
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E3A8301254D
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766743ABD90;
	Tue,  2 Jun 2026 09:29:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF7E2248A8;
	Tue,  2 Jun 2026 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.207.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392544; cv=none; b=PjBg4lLL+ZCSQ+6AgKPcRucjTT9QYm2HtMzp2XL9s8kBsJ6b9g5+n6i8DzR2sqk3kVY980RhsIqH8nR/xK8uSbcqv9HPOc01A8R5hVAEu8wXkTxAMUjwbmEGDyiEgAUNIDiOy+MuOc6NYMd4A/9saSBUqcvmX3nR6UG7vL/VsEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392544; c=relaxed/simple;
	bh=VABZ1CYJxSyAO6pE8UUHSnuxDAJz6bqCEjwfDZXVDOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EhNmgHlzz+Q8AOk3G22sUcobqaZu15ad4iCIcaK6c9/0slF606ACOQT1PC/Zlf1WGDSok08LEnlrq2ba4QkP1+CSFIO9oEQK/tjO/UBTWSOmdV0w9nuEMpBXqDrdgKxIx9UD98/tH5W/i1qFVGyrC65JBLKem2SG8wkBtJDVGj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.com
X-UUID: 76642c925e6511f1b2470fb4f881575f-20260602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:82c8a761-6191-42ca-9540-9211b4291d77,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:0dfb2058-ad58-47cc-9b4b-3a26fbdf8d19,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 76642c925e6511f1b2470fb4f881575f-20260602
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2064203717; Tue, 02 Jun 2026 17:28:49 +0800
X-UUID: 73bcc6de5e6511f1943831befd1aa4bc-20260602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:8efdce7d-8eed-473d-b4a8-e89f1457f687,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:5f91b66a-ed42-44b4-bf06-e9ec525572c0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 73bcc6de5e6511f1943831befd1aa4bc-20260602
Received: from sdbmbx12.tpe.compalcomm.com [(10.113.2.136)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES256-SHA 256/256)
	with ESMTP id 428725130; Tue, 02 Jun 2026 17:28:45 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX12.tpe.compalcomm.com (10.113.2.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Jun 2026 17:28:43 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69%11]) with mapi id
 15.02.2562.029; Tue, 2 Jun 2026 17:28:43 +0800
From: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
CC: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg
	<johannes@sipsolutions.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Wen-Zhi Huang
	<wen-zhi.huang@mediatek.com>, Shi-Wei Yeh <shi-wei.yeh@mediatek.com>, "Minano
 Tseng" <Minano.tseng@mediatek.com>, Matthias Brugger
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
Thread-Index: AQHc72BxzEDatfB/BUa8hHwkXE6BbLYq/3Ao
Date: Tue, 2 Jun 2026 09:28:43 +0000
Message-ID: <c1ead55c68914a30a15695d3129021cd@compal.com>
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>,<CAFEp6-0ntknHnpsj99YUHpD8R5SMDHf8Upn+yaED-A-sxonscw@mail.gmail.com>
In-Reply-To: <CAFEp6-0ntknHnpsj99YUHpD8R5SMDHf8Upn+yaED-A-sxonscw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-29982.005
x-tm-as-result: No-10--29.556500-8.000000
x-tmase-matchedrid: +gTBWF+Z0RMuv++HU7VXryRFbfQbCufdN0X64jGy2dbVc/AFNTvLS/Eg
	j3UGiKNtkyzJMuTpdeulugByZXPyC7pPJQ7/EpmFP7JT059tUTsKxicnNfBGioyE2WA45sfutMV
	5iqBd6MBiZ1/9k9vMOWtA+oLByHnjYwxrFKm+6T3f2e6voWUFXpplSCvHsMVhuzAg7efo/wVUfz
	9bnWycddY5jaYSSKYo12OksH2QSRkWKuO3nFTzYNwK3aKXLlLAb9w3YZ1yDIMp7jrUqYfsxQ+f5
	tXTMeztH2xok6cGGNAN00SU3W4zZ8LQv2gzR93UFm7cDHk2CrxhZB0Uz1DJpFnw/O44e4lQ6E0v
	+Eh37RVPIm6EdR4SH8eWrjin4j+g1UQpGtRkoXmSHQtEOSQwHA2LmwHT7i+n8pFEN/tUKSmFWJa
	Y4dCW4tD6xLvX4M4IEA4s0Z67fd2/2tJ3foSBQsD3fX6Y132wmzuCQZagpjfpAuB7xNymfQ==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--29.556500-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-29982.005
x-tm-snts-smtp: CBA70632A13A01BFDCA4587D76F6B11E1034DBCEC79E3A2BAD05732E75EBB37E2000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1FC0062B951
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.14 / 15.00];
	DMARC_POLICY_REJECT(2.00)[compal.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-294107-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

SGkgTG9pYywNCg0KPg0KPiBIaSBKYWNrLA0KPg0KPiBPbiBGcmksIE1heSAyOSwgMjAyNiBhdCAx
MjozMSBQTSBKYWNrIFd1IHZpYSBCNCBSZWxheQ0KPiA8ZGV2bnVsbCtqYWNrYmJfd3UuY29tcGFs
LmNvbUBrZXJuZWwub3JnPiB3cm90ZToNCj4gPg0KPiA+IFQ5WFggaXMgdGhlIFBDSWUgaG9zdCBk
ZXZpY2UgZHJpdmVyIGZvciBNZWRpYVRlaydzDQo+ID4gdDkwMCBtb2RlbS4gVGhlIGRyaXZlciB1
c2VzIHRoZSBXV0FOIGZyYW1ld29yaw0KPiA+IGluZnJhc3RydWN0dXJlIHRvIGNyZWF0ZSB0aGUg
Zm9sbG93aW5nIGNvbnRyb2wgcG9ydHMNCj4gPiBhbmQgbmV0d29yayBpbnRlcmZhY2VzIGZvciBk
YXRhIHRyYW5zYWN0aW9ucy4NCj4gPiAqIC9kZXYvd3dhbjBhdDAgLSBJbnRlcmZhY2UgdGhhdCBz
dXBwb3J0cyBBVCBjb21tYW5kcy4NCj4gPiAqIC9kZXYvd3dhbjBtYmltMCAtIEludGVyZmFjZSBj
b25mb3JtaW5nIHRvIHRoZSBNQklNDQo+ID4gcHJvdG9jb2wuDQo+ID4gKiB3d2FuMC1YIC0gUHJp
bWFyeSBuZXR3b3JrIGludGVyZmFjZSBmb3IgSVAgdHJhZmZpYy4NCj4gPg0KPiA+IFRoZSBtYWlu
IGJsb2NrcyBpbiB0aGUgVDlYWCBkcml2ZXIgYXJlOg0KPiA+ICogSFcgbGF5ZXIgLSBBYnN0cmFj
dHMgdGhlIGhhcmR3YXJlIGJ1cyBvcGVyYXRpb25zIGZvcg0KPiA+IHRoZSBkZXZpY2UsIGFuZCBw
cm92aWRlcyBnZW5lcmljIGludGVyZmFjZXMgZm9yIHRoZQ0KPiA+IHRyYW5zYWN0aW9uIGxheWVy
IHRvIGdldCB0aGUgZGV2aWNlJ3MgaW5mb3JtYXRpb24gYW5kDQo+ID4gY29udHJvbCB0aGUgZGV2
aWNlJ3MgYmVoYXZpb3IuIEl0IGluY2x1ZGVzOg0KPiA+DQo+ID4gKiBQQ0llIC0gSW1wbGVtZW50
cyBwcm9iZSwgcmVtb3ZhbCBhbmQgaW50ZXJydXB0DQo+ID4gaGFuZGxpbmcuDQo+ID4gKiBNSEND
SUYgKE1vZGVtIEhvc3QgQ3Jvc3MtQ29yZSBJbnRlcmZhY2UpIC0gUHJvdmlkZXMNCj4gPiBpbnRl
cnJ1cHQgY2hhbm5lbHMgZm9yIGJpZGlyZWN0aW9uYWwgZXZlbnQNCj4gPiBub3RpZmljYXRpb24g
c3VjaCBhcyBoYW5kc2hha2UgYW5kIHBvcnQgZW51bWVyYXRpb24uDQo+ID4NCj4gPiAqIFRyYW5z
YWN0aW9uIGxheWVyIC0gSW1wbGVtZW50cyBkYXRhIHRyYW5zYWN0aW9ucyBmb3INCj4gPiB0aGUg
Y29udHJvbCBwbGFuZSBhbmQgdGhlIGRhdGEgcGxhbmUuIEl0IGluY2x1ZGVzOg0KPiA+DQo+ID4g
KiBEUE1BSUYgKERhdGEgUGxhbmUgTW9kZW0gQVAgSW50ZXJmYWNlKSAtIENvbnRyb2xzDQo+ID4g
dGhlIGhhcmR3YXJlIHRoYXQgcHJvdmlkZXMgdXBsaW5rIGFuZCBkb3dubGluaw0KPiA+IHF1ZXVl
cyBmb3IgdGhlIGRhdGEgcGF0aC4gVGhlIGRhdGEgZXhjaGFuZ2UgdGFrZXMNCj4gPiBwbGFjZSB1
c2luZyBjaXJjdWxhciBidWZmZXJzIHRvIHNoYXJlIGRhdGEgYnVmZmVyDQo+ID4gYWRkcmVzc2Vz
IGFuZCBtZXRhZGF0YSB0byBkZXNjcmliZSB0aGUgcGFja2V0cy4NCj4gPiAqIENMRE1BIChDcm9z
cyBMYXllciBETUEpIC0gTWFuYWdlcyB0aGUgaGFyZHdhcmUNCj4gPiB1c2VkIGJ5IHRoZSBwb3J0
IGxheWVyIHRvIHNlbmQgY29udHJvbCBtZXNzYWdlcyB0bw0KPiA+IHRoZSBkZXZpY2UgdXNpbmcg
TWVkaWFUZWsncyBDQ0NJIChDcm9zcy1Db3JlDQo+ID4gQ29tbXVuaWNhdGlvbiBJbnRlcmZhY2Up
IHByb3RvY29sLg0KPiA+ICogVFggU2VydmljZXMgLSBEaXNwYXRjaCBwYWNrZXRzIGZyb20gdGhl
IHBvcnQgbGF5ZXINCj4gPiB0byB0aGUgZGV2aWNlLg0KPiA+ICogUlggU2VydmljZXMgLSBEaXNw
YXRjaCBwYWNrZXRzIHRvIHRoZSBwb3J0IGxheWVyDQo+ID4gd2hlbiByZWNlaXZpbmcgcGFja2V0
cyBmcm9tIHRoZSBkZXZpY2UuDQo+ID4NCj4gPiAqIFBvcnQgbGF5ZXIgLSBQcm92aWRlcyBjb250
cm9sIHBsYW5lIGFuZCBkYXRhIHBsYW5lDQo+ID4gaW50ZXJmYWNlcyB0byB1c2Vyc3BhY2UuIEl0
IGluY2x1ZGVzOg0KPiA+DQo+ID4gKiBDb250cm9sIFBsYW5lIC0gUHJvdmlkZXMgZGV2aWNlIG5v
ZGUgaW50ZXJmYWNlcw0KPiA+IGZvciBjb250cm9sbGluZyBkYXRhIHRyYW5zYWN0aW9ucy4NCj4g
PiAqIERhdGEgUGxhbmUgLSBQcm92aWRlcyBuZXR3b3JrIGxpbmsgaW50ZXJmYWNlcw0KPiA+IHd3
YW5YICgwLCAxLCAyLi4uKSBmb3IgSVAgZGF0YSB0cmFuc2FjdGlvbnMuDQo+ID4NCj4gPiAqIENv
cmUgbG9naWMgLSBDb250YWlucyB0aGUgY29yZSBsb2dpYyB0byBrZWVwIHRoZQ0KPiA+IGRldmlj
ZSB3b3JraW5nLiBJdCBpbmNsdWRlczoNCj4gPg0KPiA+ICogRlNNIChGaW5pdGUgU3RhdGUgTWFj
aGluZSkgLSBNb25pdG9ycyB0aGUgc3RhdGUNCj4gPiBvZiB0aGUgZGV2aWNlLCBhbmQgbm90aWZp
ZXMgZWFjaCBtb2R1bGUgd2hlbiB0aGUNCj4gPiBzdGF0ZSBjaGFuZ2VzLg0KPiA+DQo+ID4gVGhl
IGNvbXBpbGF0aW9uIG9mIHRoZSBUOVhYIGRyaXZlciBpcyBlbmFibGVkIGJ5IHRoZQ0KPiA+IENP
TkZJR19NVEtfVDlYWCBhbmQgQ09ORklHX01US19UOVhYX1BDSSBjb25maWcgb3B0aW9uDQo+ID4g
d2hpY2ggZGVwZW5kcyBvbiBDT05GSUdfV1dBTi4NCj4NCj4gQ2FuIHlvdSBzcGVjaWZ5IHdoaWNo
IHVzZXJzcGFjZSBjb3VudGVycGFydCB5b3UgbmVlZCAoZS5nLiwgYQ0KPiBNb2RlbU1hbmFnZXIg
dmVyc2lvbiBvciBhIGxpbmsgdG8gdGhlIHJlbGV2YW50IHBhdGNoIHNlcmllcyk/DQo+DQpUaGUg
ZHJpdmVyIGlzIGFnbm9zdGljIHRvIHRoZSB1c2Vyc3BhY2UgYXBwbGljYXRpb24uIFdlIHZlcmlm
aWVkDQpmdW5jdGlvbmFsaXR5IHVzaW5nIE1vZGVtTWFuYWdlciB2MS4yMy40IGFuZCB2MS4yNS45
NSwgYW5kIGJvdGgNCndvcmsgb3V0IG9mIHRoZSBib3guDQo+DQo+ID4NCj4gPiAtLS0NCj4gPiBK
YWNrIFd1ICgxMSk6DQo+ID4gbmV0OiB3d2FuOiB0OXh4OiBBZGQgUENJZSBjb3JlDQo+ID4gbmV0
OiB3d2FuOiB0OXh4OiBBZGQgY29udHJvbCBwbGFuZSB0cmFuc2FjdGlvbiBsYXllcg0KPiA+IG5l
dDogd3dhbjogdDl4eDogQWRkIGNvbnRyb2wgRE1BIGludGVyZmFjZQ0KPiA+IG5ldDogd3dhbjog
dDl4eDogQWRkIGNvbnRyb2wgcG9ydA0KPiA+IG5ldDogd3dhbjogdDl4eDogQWRkIEZTTSB0aHJl
YWQNCj4gPiBuZXQ6IHd3YW46IHQ5eHg6IEFkZCBBVCAmIE1CSU0gV1dBTiBwb3J0cw0KPiA+IG5l
dDogd3dhbjogdDl4eDogSW50cm9kdWNlIGRhdGEgcGxhbmUgaGFyZHdhcmUNCj4gPiBuZXQ6IHd3
YW46IHQ5eHg6IEFkZCBkYXRhIHBsYW5lIHRyYW5zYWN0aW9uIGxheWVyDQo+ID4gbmV0OiB3d2Fu
OiB0OXh4OiBJbnRyb2R1Y2UgV1dBTiBpbnRlcmZhY2UNCj4gPiBuZXQ6IHd3YW46IHQ5eHg6IEFk
ZCBwb3dlciBtYW5hZ2VtZW50IHN1cHBvcnQNCj4gPiBuZXQ6IHd3YW46IHQ5eHg6IEFkZCBtYWlu
dGFpbmVycyBhbmQgZG9jdW1lbnRhdGlvbg0KPiA+DQo+ID4gLi4uL25ldHdvcmtpbmcvZGV2aWNl
X2RyaXZlcnMvd3dhbi90OXh4LnJzdCB8IDQ4ICsNCj4gPiBNQUlOVEFJTkVSUyB8IDEwICsNCj4g
PiBkcml2ZXJzL25ldC93d2FuL0tjb25maWcgfCAxNyArDQo+ID4gZHJpdmVycy9uZXQvd3dhbi9N
YWtlZmlsZSB8IDEgKw0KPiA+IGRyaXZlcnMvbmV0L3d3YW4vdDl4eC9NYWtlZmlsZSB8IDE2ICsN
Cj4gPiBkcml2ZXJzL25ldC93d2FuL3Q5eHgvbXRrX2N0cmxfcGxhbmUuYyB8IDk1ICsNCj4gPiBk
cml2ZXJzL25ldC93d2FuL3Q5eHgvbXRrX2N0cmxfcGxhbmUuaCB8IDg4ICsNCj4gPiBkcml2ZXJz
L25ldC93d2FuL3Q5eHgvbXRrX2RhdGFfcGxhbmUuYyB8IDEwNCArDQo+ID4gZHJpdmVycy9uZXQv
d3dhbi90OXh4L210a19kYXRhX3BsYW5lLmggfCAxMDUgKw0KPiA+IGRyaXZlcnMvbmV0L3d3YW4v
dDl4eC9tdGtfZGV2LmMgfCA1NSArDQo+ID4gZHJpdmVycy9uZXQvd3dhbi90OXh4L210a19kZXYu
aCB8IDExNCArDQo+ID4gZHJpdmVycy9uZXQvd3dhbi90OXh4L210a19mc20uYyB8IDkzMSArKysr
KysrDQo+ID4gZHJpdmVycy9uZXQvd3dhbi90OXh4L210a19mc20uaCB8IDE0MCArDQo+ID4gZHJp
dmVycy9uZXQvd3dhbi90OXh4L210a19wb3J0LmMgfCA5NjcgKysrKysrKw0KPiA+IGRyaXZlcnMv
bmV0L3d3YW4vdDl4eC9tdGtfcG9ydC5oIHwgMTc2ICsrDQo+ID4gZHJpdmVycy9uZXQvd3dhbi90
OXh4L210a19wb3J0X2lvLmMgfCA1NzYgKysrKysNCj4gPiBkcml2ZXJzL25ldC93d2FuL3Q5eHgv
bXRrX3BvcnRfaW8uaCB8IDQxICsNCj4gPiBkcml2ZXJzL25ldC93d2FuL3Q5eHgvbXRrX3V0aWxp
dHkuaCB8IDMzICsNCj4gPiBkcml2ZXJzL25ldC93d2FuL3Q5eHgvbXRrX3d3YW4uYyB8IDQ3NSAr
KysrDQo+ID4gZHJpdmVycy9uZXQvd3dhbi90OXh4L210a193d2FuLmggfCAxNyArDQo+ID4gZHJp
dmVycy9uZXQvd3dhbi90OXh4L3BjaWUvTWFrZWZpbGUgfCAxOSArDQo+ID4gZHJpdmVycy9uZXQv
d3dhbi90OXh4L3BjaWUvbXRrX2NsZG1hLmMgfCAxNTI3ICsrKysrKysrKysrDQo+ID4gZHJpdmVy
cy9uZXQvd3dhbi90OXh4L3BjaWUvbXRrX2NsZG1hLmggfCAxNzYgKysNCj4gPiBkcml2ZXJzL25l
dC93d2FuL3Q5eHgvcGNpZS9tdGtfY2xkbWFfZHJ2LmMgfCAzNzMgKysrDQo+ID4gZHJpdmVycy9u
ZXQvd3dhbi90OXh4L3BjaWUvbXRrX2NsZG1hX2Rydi5oIHwgMTc0ICsrDQo+ID4gZHJpdmVycy9u
ZXQvd3dhbi90OXh4L3BjaWUvbXRrX2NsZG1hX2Rydl9tOXh4LmMgfCAxNzcgKysNCj4gPiBkcml2
ZXJzL25ldC93d2FuL3Q5eHgvcGNpZS9tdGtfY2xkbWFfZHJ2X205eHguaCB8IDEwMSArDQo+ID4g
ZHJpdmVycy9uZXQvd3dhbi90OXh4L3BjaWUvbXRrX2N0cmxfY2ZnX205eHguYyB8IDU1ICsNCj4g
PiBkcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNpZS9tdGtfZHBtYWlmLmMgfCAyNzE0ICsrKysrKysr
KysrKysrKysrKysrDQo+ID4gZHJpdmVycy9uZXQvd3dhbi90OXh4L3BjaWUvbXRrX2RwbWFpZi5o
IHwgMTYgKw0KPiA+IGRyaXZlcnMvbmV0L3d3YW4vdDl4eC9wY2llL210a19kcG1haWZfZHJ2LmMg
fCAxNTg2ICsrKysrKysrKysrKw0KPiA+IGRyaXZlcnMvbmV0L3d3YW4vdDl4eC9wY2llL210a19k
cG1haWZfZHJ2LmggfCAyNjggKysNCj4gPiBkcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNpZS9tdGtf
ZHBtYWlmX2Rydl9tOXh4LmMgfCA2ODcgKysrKysNCj4gPiBkcml2ZXJzL25ldC93d2FuL3Q5eHgv
cGNpZS9tdGtfZHBtYWlmX3JlZy5oIHwgMzg3ICsrKw0KPiA+IGRyaXZlcnMvbmV0L3d3YW4vdDl4
eC9wY2llL210a19kcG1haWZfcmVnX205eHguaCB8IDM3ICsNCj4gPiBkcml2ZXJzL25ldC93d2Fu
L3Q5eHgvcGNpZS9tdGtfZHBtYWlmX3JpbmcuYyB8IDE2OCArKw0KPiA+IGRyaXZlcnMvbmV0L3d3
YW4vdDl4eC9wY2llL210a19kcG1haWZfcmluZy5oIHwgMTYxICsrDQo+ID4gZHJpdmVycy9uZXQv
d3dhbi90OXh4L3BjaWUvbXRrX3BjaS5jIHwgMTA2NyArKysrKysrKw0KPiA+IGRyaXZlcnMvbmV0
L3d3YW4vdDl4eC9wY2llL210a19wY2kuaCB8IDIxOSArKw0KPiA+IGRyaXZlcnMvbmV0L3d3YW4v
dDl4eC9wY2llL210a19wY2lfZHJ2X205eHguYyB8IDcwICsNCj4gPiBkcml2ZXJzL25ldC93d2Fu
L3Q5eHgvcGNpZS9tdGtfcGNpX3JlZy5oIHwgNzIgKw0KPiA+IGRyaXZlcnMvbmV0L3d3YW4vdDl4
eC9wY2llL210a190cmFuc19jdHJsLmMgfCA1OTMgKysrKysNCj4gPiBkcml2ZXJzL25ldC93d2Fu
L3Q5eHgvcGNpZS9tdGtfdHJhbnNfY3RybC5oIHwgMTA1ICsNCj4gPiA0MyBmaWxlcyBjaGFuZ2Vk
LCAxNDc2MSBpbnNlcnRpb25zKCspDQo+ID4gLS0tDQo+ID4gYmFzZS1jb21taXQ6IGViM2Y0Yjc0
MjZjZmQyYjc5ZDY1YjdkMzcxNTU0ODBiMzIyNTlhMTENCj4gPiBjaGFuZ2UtaWQ6IDIwMjYwNTI5
LXQ5eHhfZHJpdmVyX3YxLTE3NDRmOGFmNzczOQ0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+
IC0tDQo+ID4gSmFjayBXdSA8amFja2JiX3d1QGNvbXBhbC5jb20+DQoNCg0KPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KVGhpcyBtZXNzYWdlIG1heSBjb250
YWluIGluZm9ybWF0aW9uIHdoaWNoIGlzIHByaXZhdGUsIHByaXZpbGVnZWQgb3IgY29uZmlkZW50
aWFsIG9mIENvbXBhbCBFbGVjdHJvbmljcywgSW5jLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5k
ZWQgcmVjaXBpZW50IG9mIHRoaXMgbWVzc2FnZSwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGFu
ZCBkZXN0cm95L2RlbGV0ZSB0aGUgbWVzc2FnZS4gQW55IHJldmlldywgcmV0cmFuc21pc3Npb24s
IGRpc3NlbWluYXRpb24gb3Igb3RoZXIgdXNlIG9mLCBvciB0YWtpbmcgb2YgYW55IGFjdGlvbiBp
biByZWxpYW5jZSB1cG9uIHRoaXMgaW5mb3JtYXRpb24sIGJ5IHBlcnNvbnMgb3IgZW50aXRpZXMg
b3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IGlzIHByb2hpYml0ZWQuDQo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo=

