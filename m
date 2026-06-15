Return-Path: <netdev+bounces-299361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nU38AKm4L2pmFAUAu9opvQ
	(envelope-from <netdev+bounces-299361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:32:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0358F6848D3
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:32:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=compal.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299361-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299361-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58CAD3003BED
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136A63BE651;
	Mon, 15 Jun 2026 08:31:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445642EF653;
	Mon, 15 Jun 2026 08:31:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512316; cv=none; b=bc/Khwowh6DI9QMJ6/u0KMPzC5ko0B5Hi/I1lkVoRBT7SghyDLJfnZsM5RDgX0OjKeAOGZed0Sj4owrITVc8vouLv+DB0uAnz2QGLXvni6yEgZrWWUvnZLB3pAjBJUwV7oSqnQ+eH/ODwR5iajSueXGnCOngoEo3pc3J4Mlra04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512316; c=relaxed/simple;
	bh=nGVodLCDfAeHKfNWjPqQjG+EeynWlzct3RzteugVEXw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g0AZM/6EAagjrZKfjpmqreTTtskqvE7TOl0BgN4VQ0wHhwzmwGHrltDz6jeVITDLtbHC4xulmTKCRo7WwdMSvKBggDaK6nxhlo54bUCSmxsE/1B+7LBzaHhU70Rn0tj9564ZQgYFh8+4dSWFHADRq7mvJafkRRXXik5vApLt+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
X-UUID: a09e10b6689411f1b2470fb4f881575f-20260615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:82cf698a-757f-4b5b-994e-f349dec60ef4,IP:0,U
	RL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e276073,CLOUDID:f1e8e58c-cda4-45e0-8062-07919a72b59f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:11|95|82|106|1,File:130,RT:0,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a09e10b6689411f1b2470fb4f881575f-20260615
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1253451050; Mon, 15 Jun 2026 16:31:38 +0800
X-UUID: 9dee6672689411f1b328fd8a884f4420-20260615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:6ceb72ec-47c1-4400-a462-f034bd721c00,IP:0,U
	RL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e276073,CLOUDID:e549f5e0-ecbd-446c-abfe-8b1546a39ee8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:11|95|82|106|1,File:130,RT:0,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9dee6672689411f1b328fd8a884f4420-20260615
Received: from sdbmbx13.tpe.compalcomm.com [(10.113.2.137)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 52703908; Mon, 15 Jun 2026 16:31:33 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX13.tpe.compalcomm.com (10.113.2.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 15 Jun 2026 16:31:31 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69%11]) with mapi id
 15.02.2562.029; Mon, 15 Jun 2026 16:31:31 +0800
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
	<linux-doc@vger.kernel.org>, "wojackbb@gmail.com" <wojackbb@gmail.com>
Subject: RE: [External Mail] Re: [PATCH v2 3/7] net: wwan: t9xx: Add control
 DMA interface
Thread-Topic: [External Mail] Re: [PATCH v2 3/7] net: wwan: t9xx: Add control
 DMA interface
Thread-Index: AQHc+5UK5Z1B5sirc0yoXNCOaV5ijrY/SrKC
Date: Mon, 15 Jun 2026 08:31:31 +0000
Message-ID: <35ba38814c9948a99152f9f93472f254@compal.com>
References: <20260610-t9xx_driver_v1-v2-0-c65addf23b3f@compal.com>
	<20260610-t9xx_driver_v1-v2-3-c65addf23b3f@compal.com>,<20260613173018.7a0581f1@kernel.org>
In-Reply-To: <20260613173018.7a0581f1@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30008.005
x-tm-as-result: No-10--16.680200-8.000000
x-tmase-matchedrid: cjP2NJ1O6/Euv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZgOe
	+RYG/aOV2HZk1Px5s3L1sr+vVx82IMz74oElhNRBhG+Xocct7w6B1fO2o4QGcPdjLuGFwc5lPK5
	qeOxNMErdx60QJsI2bJimyEYo+pgXO1n0sUglbCfIUNmTDb0adwoSarYdbAHqI7o7pOp5os6pc2
	mXV9zZ15S/WELjxojShf2DcLQxwh0DcBI2JS3GLQn3zfRJfTcD8Xgy2hiIpJWO46CtGFNzgMOZ2
	ctl/jcejJu+N/vNr9LzUm5t/tiDzN4qUXS/mz/uiu6u4shZ+fHppgDSL54JkYvXantxmoFYSIso
	V0TZxSDcveszj20vWY6Zng18I/RXD+aeeWET0ESFhGp9GNPDrVIzqo1F8yQSD9ve31bEcLaQJ8n
	qsxRQEYGIi0hzkCdkXwhCWDuTP8MdhafHrnIzgc0QwjuSC84+vzW3esYP4H61VUsT88UwImDGmf
	/orQCQa5b7kJnZWxnxdg7bpebCJGZITxmZreDrUzfQ/5ngOArBZv5Gre8SapBafzYsWTa52WrhF
	gFRuklb9F1xvxOsDWXVsbtGEcvVDDlsE39IEc+5kTI8BpRqcsCaok0KMOA2fBsCzXrxCwUORIdq
	F12r/I5yJkn2fbl5LZt3ec6HpbgMnq6Az+FfCxZ39z9V3KXg/rYJJyQgPFVkOvLryF1tXjLCLdl
	enY8fc+ub64e6t/UMWF3d1Aqj3Tw8MHI0YDsULCUZCoB5ayi+fUgL9sr/Vd6ZM0SFt29McIIB8J
	0o9GhHr0g+R+j4etXNOAQ2MSi2JpK4F9wnIiZiyuQOZndK/a4OC9teKnGfT/ErSMBW5AQ=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--16.680200-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30008.005
x-tm-snts-smtp: 1C4018DD0DC2381A831877C2263132C393EFEB55DFD9B8727E5F0B0A1AB8DABA2000:8
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299361-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,redhat.com,mediatek.com,collabora.com,kernel.org,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:wojackbb@gmail.com,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,compal.com:mid,compal.com:from_mime];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0358F6848D3

SGkgSmFrdWIsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50Lg0KDQpPbiBXZWQsIDEwIEp1
biAyMDI2IDE4OjQxOjA2ICswODAwIEphY2sgV3UgdmlhIEI0IFJlbGF5IHdyb3RlOg0KPiBUcmFu
c2llbnQgYnVpbGQgd2FybmluZ3M6DQo+DQo+ICsuLi9kcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNp
ZS9tdGtfcGNpX2Rydl9tOXh4LmM6NTI6MzA6IHdhcm5pbmc6IHN5bWJvbCAnbXRrX2Rldl9jZmdf
MDkwMCcgd2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8NCj4gKy4uL2RyaXZl
cnMvbmV0L3d3YW4vdDl4eC9wY2llL210a19jdHJsX2NmZ19tOXh4LmM6MTk6MjI6IHdhcm5pbmc6
IHN5bWJvbCAnbXRrX2N0cmxfaW5mb19tOXh4JyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQg
YmUgc3RhdGljPw0KPiArLi4vZHJpdmVycy9uZXQvd3dhbi90OXh4L3BjaWUvbXRrX2NsZG1hX2Ry
dl9tOXh4LmM6MzM6MjI6IHdhcm5pbmc6IHN5bWJvbCAnbXRrX2NsZG1hX3JlZ3NfbTl4eCcgd2Fz
IG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8NCj4gKy4uL2RyaXZlcnMvbmV0L3d3
YW4vdDl4eC9wY2llL210a19jbGRtYV9kcnZfbTl4eC5jOjE2NjoyMjogd2FybmluZzogc3ltYm9s
ICdjbGRtYV9kcnZfb3BzX205eHgnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0
aWM/DQoNCldpbGwgZml4IGluIHYzLiBNb3ZlZCBleHRlcm4gZGVjbGFyYXRpb25zIGludG8gc2hh
cmVkIGhlYWRlcnMgc28gZWFjaA0KZGVmaW5pbmcgLmMgZmlsZSBpbmNsdWRlcyBpdHMgb3duIGRl
Y2xhcmF0aW9uLg0KDQo+IHBsZWFzZSBhbHNvIHNlZSBhbGwgdGhlIEFJIGNvZGUgY29tbWVudHMg
YXQ6DQo+IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDYxMC10OXh4X2RyaXZl
cl92MS12Mi0zLWM2NWFkZGYyM2IzZkBjb21wYWwuY29tDQoNClRoYW5rIHlvdS4gV2UgaGF2ZSBy
ZXZpZXdlZCB0aGUgQUkgY29tbWVudHMuIEJlbG93IGFyZSBvdXINCnJlc3BvbnNlcyBmb3IgdGhl
IGl0ZW1zIHVuZGVyIHRoaXMgcGF0Y2ggKHBhdGNoIDMpOg0KDQpRMTogSXMgdGhlIHJlZmVyZW5j
ZSBjb3VudCBmb3IgdGhlIHNrYiBpbmNyZW1lbnRlZCBjb3JyZWN0bHkgaGVyZT8gSWYgdGhlIHBv
cnQNCmlzIG5vbi1ibG9ja2luZywgdGhlIGNhbGxlciBtaWdodCBpbW1lZGlhdGVseSBkcm9wIHRo
ZSByZWZlcmVuY2UuIFdpdGhvdXQgYW4NCmV4dHJhIHJlZmVyZW5jZSB0YWtlbiBiZWZvcmUgcXVl
dWVpbmcsIHRoZSBza2IgY291bGQgYmUgZnJlZWQgd2hpbGUgaXQgc3RpbGwNCnJlc2lkZXMgaW4g
dGhlIHF1ZXVlLCByZXN1bHRpbmcgaW4gYSB1c2UtYWZ0ZXItZnJlZSB3aGVuIHRoZSB3b3JrZXIg
dGhyZWFkDQpsYXRlciBhY2Nlc3NlcyB0aGUgbGlzdC4NCg0KICBObyB1c2UtYWZ0ZXItZnJlZSBo
ZXJlLiBUaGUgc2tiIGlzIGFsbG9jYXRlZCBieSB0aGUgcG9ydCBsYXllcg0KICAobXRrX3BvcnRf
c2VuZF9kYXRhIC8gbXRrX3BvcnRfY29tbW9uX3dyaXRlKSBhbmQgb3duZXJzaGlwIGlzDQogIHRy
YW5zZmVycmVkIHRvIHN1Ym1pdF9za2IgoVggdGhlIGNhbGxlciBkb2VzIG5vdCBmcmVlIHRoZSBz
a2IgYWZ0ZXINCiAgYSBzdWNjZXNzZnVsIHN1Ym1pc3Npb24uIE9uIGVycm9yIHJldHVybnMgKC1F
SU5WQUwsIC1FSU8sIC1FQUdBSU4pLA0KICB0aGUgc2tiIGlzIE5PVCBxdWV1ZWQgYW5kIHRoZSBj
YWxsZXIgaGFuZGxlcyBjbGVhbnVwLiBUaGUgc2tiX3F1ZXVlDQogIG9wZXJhdGlvbnMgKHNrYl9x
dWV1ZV9oZWFkL3NrYl9xdWV1ZV90YWlsKSBkbyBub3QgcmVxdWlyZSBhbiBleHRyYQ0KICByZWZl
cmVuY2UgYmVjYXVzZSB0aGUgcXVldWUgYmVjb21lcyB0aGUgc29sZSBvd25lci4gVGhpcyBpcyB0
aGUNCiAgc3RhbmRhcmQga2VybmVsIHBhdHRlcm4goVggc2tiIG93bmVyc2hpcCB0cmFuc2ZlcnMg
dG8gdGhlIHF1ZXVlLCBub3QNCiAgc2hhcmVkIGJldHdlZW4gY2FsbGVyIGFuZCBxdWV1ZS4NCg0K
UTI6IENvdWxkIHRoZXJlIGJlIGEgcmFjZSBjb25kaXRpb24gYmV0d2VlbiBzZXR0aW5nIHRoZSB2
aXJ0dWFsIGFkZHJlc3MgYW5kIHRoZQ0KaGFyZHdhcmUgb3duZXJzaGlwIGZsYWc/IElmIHRoZSB3
b3JrZXIgY2hlY2tzIHRoZSBjb25kaXRpb24gYmV0d2VlbiB0aGVzZSB0d28NCndyaXRlcywgaXQg
bWlnaHQgZXJyb25lb3VzbHkgZGV0ZWN0IGNvbXBsZXRpb24gYW5kIGZyZWUgdGhlIGJ1ZmZlciBi
ZWZvcmUgdGhlDQp0cmFuc2ZlciBldmVuIHN0YXJ0cy4NCg0KICBObyByYWNlLiBUaGUgdHhfZG9u
ZV93b3JrIGNoZWNrczoNCiAgICBpZiAoIXJlcS0+ZGF0YV92bV9hZGRyIHx8IChncGRfZmxhZ3Mg
JiBDTERNQV9HUERfRkxBR19IV08pKQ0KICAgICAgICBicmVhazsNCiAgSXQgb25seSBwcm9jZWVk
cyB3aGVuIGRhdGFfdm1fYWRkciBpcyBzZXQgQU5EIEhXTyBpcyBjbGVhcmVkLg0KICBJbiBzdWJt
aXRfdHgsIHRoZSB3cml0ZSBvcmRlciBpczoNCiAgICAxLiByZXEtPmRhdGFfdm1fYWRkciA9IHNr
Yi0+ZGF0YTsgICAgIChzZXQgbm9uLU5VTEwpDQogICAgMi4gd21iKCk7DQogICAgMy4gZ3BkX2Zs
YWdzIHw9IENMRE1BX0dQRF9GTEFHX0hXTzsgICAoc2V0IEhXTykNCiAgQWZ0ZXIgc3RlcCAxLCBk
YXRhX3ZtX2FkZHIgaXMgbm9uLU5VTEwgYnV0IEhXTyBpcyBzZXQgKHN0ZXAgMyksIHNvDQogIHR4
X2RvbmVfd29yayBzZWVzIEhXTz0xIGFuZCBicmVha3MuIEl0IHdpbGwgb25seSBwcm9jZXNzIHRo
aXMgcmVxDQogIGFmdGVyIHRoZSBoYXJkd2FyZSBjbGVhcnMgSFdPIHVwb24gRE1BIGNvbXBsZXRp
b24uIFRoZSB3bWIoKSBlbnN1cmVzDQogIHRoZSBtZXRhZGF0YSB3cml0ZXMgYXJlIHZpc2libGUg
YmVmb3JlIEhXTyBpcyBzZXQsIGFuZCB0aGUgcm1iKCkgaW4NCiAgdHhfZG9uZV93b3JrIGVuc3Vy
ZXMgSFdPIGlzIHJlYWQgYmVmb3JlIHRoZSBtZXRhZGF0YS4NCg0KUTM6IERvZXMgdGhpcyBwZXJt
YW5lbnRseSBoYWx0IHRoZSByZWNlaXZlIHF1ZXVlIGlmIGEgbWVtb3J5IGFsbG9jYXRpb24gZmFp
bHMNCmR1cmluZyByZWZpbGw/IElmIHRoZSBza2IgYWxsb2NhdGlvbiBmYWlscyBlYXJsaWVyLCB0
aGUgd29ya2VyIGV4aXRzIGhlcmUNCndpdGhvdXQgYWR2YW5jaW5nIHRoZSBmcmVlIGluZGV4LCB3
aGljaCBzZWVtcyB0byBsZWF2ZSB0aGUgcXVldWUgc3R1Y2sNCmluZGVmaW5pdGVseSBvbiBhbGwg
c3Vic2VxdWVudCBleGVjdXRpb25zLg0KDQogIFRoZSBjb25jZXJuIGlzIHBhcnRpYWxseSB2YWxp
ZC4gSWYgbXRrX2NsZG1hX3JlbG9hZF9yeF9za2IoKSBmYWlscw0KICAoc2tiIGFsbG9jIGZhaWx1
cmUpLCB0aGUgY29kZSBqdW1wcyB0byAib3V0IiB3aGljaCB1bm1hc2tzIHRoZQ0KICBpbnRlcnJ1
cHQuIE9uIHRoZSBuZXh0IGhhcmR3YXJlIGludGVycnVwdCwgcnhfZG9uZV93b3JrIHJ1bnMgYWdh
aW4NCiAgYW5kIHJldHJpZXMgZnJvbSB0aGUgc2FtZSBmcmVlX2lkeC4gSWYgcmVxLT5za2IgaXMg
TlVMTCAoYmVjYXVzZQ0KICByZWxvYWQgZmFpbGVkIGFuZCByeF9kb25lIHNldCByZXEtPnNrYiA9
IE5VTEwgYWZ0ZXIgZGlzcGF0Y2gpLCB0aGUNCiAgY29kZSBoaXRzIHRoZSAiIXJlcS0+c2tiIiBl
cnJvciBjaGVjayBhbmQgZ29lcyB0byAib3V0IiChWCBidXQgIm91dCINCiAgbm93IGNvcnJlY3Rs
eSB1bm1hc2tzIHRoZSBpbnRlcnJ1cHQgKGZpeGVkIGluIHYyKSwgc28gdGhlIG5leHQNCiAgaW50
ZXJydXB0IHdpbGwgcmV0cnkuIFRoaXMgY3JlYXRlcyBhIHJldHJ5IGxvb3AgdGhhdCBkZXBlbmRz
IG9uDQogIG1lbW9yeSBiZWNvbWluZyBhdmFpbGFibGUuIFVuZGVyIHN1c3RhaW5lZCBtZW1vcnkg
cHJlc3N1cmUsIHRoZSBSWA0KICBxdWV1ZSBzdGFsbHMgYnV0IHJlY292ZXJzIG9uY2UgbWVtb3J5
IGlzIGZyZWVkLiBUaGlzIGlzIGFjY2VwdGFibGUNCiAgYmVoYXZpb3IgZm9yIGEgY29udHJvbCBw
bGFuZSBpbnRlcmZhY2Ugd2l0aCBzbWFsbCwgaW5mcmVxdWVudA0KICBtZXNzYWdlcy4NCg0KUTQ6
IERvZXMgdGhpcyBsb29wIHNhZmVseSBoYW5kbGUgZmF0YWwgZXJyb3JzIGZyb20gdGhlIHN1Ym1p
c3Npb24gZnVuY3Rpb24/IEl0DQphcHBlYXJzIHRoYXQgb24gZXJyb3JzIG90aGVyIHRoYW4gRUFH
QUlOLCB0aGUgbG9vcCBicmVha3Mgd2l0aG91dCB1bmxpbmtpbmcNCnRoZSBza2IuIFRoZSB3b3Jr
ZXIgbG9vcCB3b3VsZCB0aGVuIHBlZWsgdGhlIGV4YWN0IHNhbWUgc2tiIG9uIHRoZSBuZXh0DQpp
dGVyYXRpb24sIGNhdXNpbmcgYW4gaW5maW5pdGUgYnVzeSBsb29wIHRoYXQgbG9ja3MgdXAgdGhl
IHByb2Nlc3Nvci4NCg0KICBUaGUgY29kZSBzaG93biAod2l0aCBrcmVmX3B1dCkgaXMgZnJvbSBw
YXRjaCA0LCBub3QgcGF0Y2ggMy4NCiAgV2Ugd2lsbCBmaXggdGhlIGlzc3VlIGluIHBhdGNoIDQg
djMuDQoNCg0KUTU6IElzIGEgcmVhZCBtZW1vcnkgYmFycmllciBuZWVkZWQgYWZ0ZXIgY2hlY2tp
bmcgdGhlIGhhcmR3YXJlIG93bmVyc2hpcCBmbGFnPw0KV2l0aG91dCBhIGJhcnJpZXIsIHRoZSBw
cm9jZXNzb3IgbWlnaHQgc3BlY3VsYXRpdmVseSByZWFkIHRoZSBwYXlsb2FkIGxlbmd0aA0KYW5k
IGRhdGEgaW4gbXRrX2NsZG1hX3J4X3NrYl9hZGp1c3QgYmVmb3JlIGNvbmZpcm1pbmcgb3duZXJz
aGlwLCBsZWFkaW5nIHRvDQpwb3RlbnRpYWwgZGF0YSBjb3JydXB0aW9uLg0KDQogIFRoZSBHUEQg
ZGVzY3JpcHRvcnMgYXJlIGFsbG9jYXRlZCBmcm9tIGEgY29oZXJlbnQgRE1BIHBvb2wNCiAgKGRt
YV9wb29sX3phbGxvYyksIHNvIENQVSBjYWNoZSBjb2hlcmVuY3kgaXMgZ3VhcmFudGVlZCBieSB0
aGUgRE1BDQogIG1hcHBpbmcuIEEgZG1hX3JtYigpIGlzIG5vdCBuZWVkZWQgaGVyZSBhcyBjb2hl
cmVudCBtZW1vcnkgZW5zdXJlcw0KICB0aGUgQ1BVIGFsd2F5cyBvYnNlcnZlcyB0aGUgbGF0ZXN0
IHZhbHVlcyB3cml0dGVuIGJ5IHRoZSBkZXZpY2UNCiAgd2l0aG91dCByZW9yZGVyaW5nLg0KDQpR
NjogU2hvdWxkIHRoZSByZXR1cm4gdmFsdWUgb2YgdGhlIHF1ZXVlIHN0b3AgZnVuY3Rpb24gYmUg
Y2hlY2tlZCBiZWZvcmUgdGVhcmluZw0KZG93biBETUEgbWVtb3J5PyBJZiB0aGUgaGFyZHdhcmUg
ZmFpbHMgdG8gc3RvcCB3aXRoaW4gdGhlIHRpbWVvdXQsIHByb2NlZWRpbmcNCnRvIHVubWFwIHRo
ZSBtZW1vcnkgbWlnaHQgcmVzdWx0IGluIHRoZSBhY3RpdmUgaGFyZHdhcmUgd3JpdGluZyB0byBm
cmVlZA0Ka2VybmVsIG1lbW9yeS4NCg0KICBUaGUgY29uY2VybiBpcyB2YWxpZCBpbiB0aGVvcnkg
YnV0IG5vdCBhY3Rpb25hYmxlIGluIHByYWN0aWNlLg0KICBjbGRtYV9zdG9wX3F1ZXVlKCkgcG9s
bHMgdGhlIGhhcmR3YXJlIGZvciB1cCB0byAxMCBpdGVyYXRpb25zIHdpdGgNCiAgdXNsZWVwLiBJ
ZiBpdCB0aW1lcyBvdXQsIHRoZSBoYXJkd2FyZSBpcyBpbiBhIGJyb2tlbiBzdGF0ZSAobGluaw0K
ICBlcnJvciBvciBkZXZpY2UgaGFuZykuIEF0IHRoaXMgcG9pbnQgdGhlIHRlYXJkb3duIGlzIHBh
cnQgb2YNCiAgZGV2aWNlIHJlbW92YWwgb3IgZXJyb3IgcmVjb3ZlcnkgoVggdGhlcmUgaXMgbm8g
c2FmZSBhbHRlcm5hdGl2ZSB0bw0KICBwcm9jZWVkaW5nIHdpdGggY2xlYW51cC4gU2tpcHBpbmcg
dGhlIHRlYXJkb3duIHdvdWxkIGxlYWsgRE1BDQogIG1lbW9yeSBwZXJtYW5lbnRseS4gVGhlIHN5
bmNocm9uaXplX2lycSgpICsgZmx1c2hfd29yaygpIGFmdGVyDQogIHN0b3BfcXVldWUgZW5zdXJl
cyBubyBzb2Z0d2FyZSBoYW5kbGVycyBhcmUgaW4tZmxpZ2h0LiBJZiB0aGUNCiAgaGFyZHdhcmUg
aXMgdHJ1bHkgc3R1Y2ssIHRoZSBQQ0llIGxpbmsgaXMgbGlrZWx5IGFscmVhZHkgZG93bg0KICAo
TElOS19FUlJPUl9WQUwgY2hlY2spLCBtYWtpbmcgZnVydGhlciBNTUlPIGFjY2VzcyBuby1vcHMu
DQoNClE3OiBEb2VzIHRoaXMgbGVhayB0aGUgcmFkaXggdHJlZSBub2RlcyBhbmQgdGhlaXIgY29u
dGVudHMgaWYgdGhlIGFycmF5DQphbGxvY2F0aW9uIGZhaWxzPyBQZXJmb3JtaW5nIG1lbW9yeSBh
bGxvY2F0aW9ucyBpbiBhIHRlYXJkb3duIHBhdGggbWlnaHQNCnBlcm1hbmVudGx5IGxlYWsgbWVt
b3J5IGR1cmluZyBzeXN0ZW0gbWVtb3J5IHByZXNzdXJlLg0KDQogIFdlIHdpbGwgZml4IGluIHYz
IGJ5IHJlcGxhY2luZyBrY2FsbG9jICsNCiAgcmFkaXhfdHJlZV9nYW5nX2xvb2t1cCB3aXRoIHJh
ZGl4X3RyZWVfZm9yX2VhY2hfc2xvdCgpIGl0ZXJhdGlvbiwNCiAgZWxpbWluYXRpbmcgdGhlIGFs
bG9jYXRpb24gaW4gdGhlIHRlYXJkb3duIHBhdGguDQoNCg0KUmVnYXJkaW5nIEFJIGNvbW1lbnRz
IGZvciBvdGhlciBwYXRjaGVzIGluIHRoZSBzZXJpZXMgoVggc2hvdWxkIHdlDQpyZXNwb25kIHRv
IHRob3NlIHVuZGVyIGVhY2ggcmVzcGVjdGl2ZSBwYXRjaCB0aHJlYWQ/DQoNCg0KVGhhbmtzLg0K
DQoNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClRoaXMg
bWVzc2FnZSBtYXkgY29udGFpbiBpbmZvcm1hdGlvbiB3aGljaCBpcyBwcml2YXRlLCBwcml2aWxl
Z2VkIG9yIGNvbmZpZGVudGlhbCBvZiBDb21wYWwgRWxlY3Ryb25pY3MsIEluYy4gSWYgeW91IGFy
ZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIG1lc3NhZ2UsIHBsZWFzZSBub3Rp
ZnkgdGhlIHNlbmRlciBhbmQgZGVzdHJveS9kZWxldGUgdGhlIG1lc3NhZ2UuIEFueSByZXZpZXcs
IHJldHJhbnNtaXNzaW9uLCBkaXNzZW1pbmF0aW9uIG9yIG90aGVyIHVzZSBvZiwgb3IgdGFraW5n
IG9mIGFueSBhY3Rpb24gaW4gcmVsaWFuY2UgdXBvbiB0aGlzIGluZm9ybWF0aW9uLCBieSBwZXJz
b25zIG9yIGVudGl0aWVzIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudCBpcyBwcm9o
aWJpdGVkLg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K

