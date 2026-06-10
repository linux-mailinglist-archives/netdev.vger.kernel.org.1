Return-Path: <netdev+bounces-297611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N5F7DL1AKWoxTAMAu9opvQ
	(envelope-from <netdev+bounces-297611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:47:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9937C6686C5
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:47:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=compal.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297611-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297611-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 702493036E9E
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CB13EEAE5;
	Wed, 10 Jun 2026 10:41:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef22.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D1E3ED5C9;
	Wed, 10 Jun 2026 10:41:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088068; cv=none; b=Hfl49KBENMYEmiOsTk/gJ8MpSUS2oP+313bCOW7Zedn9L446GsAFFyqU/0xj9NKgPsZbzR80oRK1sdsZuJpGhmx8SywkPgq7VUmQgHzIZxoE6tlmXQduCwJlAIGmV8HmVoao1SXzibcYeDCesA8atkxfmFloxYSDcts5nEYezCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088068; c=relaxed/simple;
	bh=8wc0TGAZfFcMg57JEhtrgTCQQGKbWaZ7qbDTB68hXZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dNb/J2SKMAhfao1kDPtegWyDOKcLBE9pdW83ICGcB23rN3f0yvQxnstzeRJ1kkJhwAqTfBCAPOyXbb4Bu7dDLeVVETUXoHl3jcXZZYw8RMMDFnmVNT15QMeMJ6qbX/lldyCCKNNEODsXh/MJYvbogyL6TwDTbWCi6SNA+jWPGrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
X-UUID: dba714da64b811f1a87c2323a98e90a4-20260610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:8c2f3e9f-d3f0-48ad-bf07-25d52948e3c9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:45d0b6fa-39ea-4a28-8a25-78d1d9de3b28,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dba714da64b811f1a87c2323a98e90a4-20260610
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef22.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1038056116; Wed, 10 Jun 2026 18:40:54 +0800
X-UUID: d9a80e1464b811f1943831befd1aa4bc-20260610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:512d2daa-ebba-4f6f-b96d-9ddcd7d70b51,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:a2ad9c30-7784-4a77-a538-47ed6151d81b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d9a80e1464b811f1943831befd1aa4bc-20260610
Received: from sdbmbx12.tpe.compalcomm.com [(10.113.2.136)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES256-SHA 256/256)
	with ESMTP id 1671670175; Wed, 10 Jun 2026 18:40:51 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX12.tpe.compalcomm.com (10.113.2.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.29;
 Wed, 10 Jun 2026 18:40:50 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69%11]) with mapi id
 15.02.2562.029; Wed, 10 Jun 2026 18:40:50 +0800
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
Subject: RE: [PATCH 01/11] net: wwan: t9xx: Add PCIe core
Thread-Topic: [PATCH 01/11] net: wwan: t9xx: Add PCIe core
Thread-Index: AQHc8bhcdmgibeQV+0mP7OG8OB0FzrY3k7/n
Date: Wed, 10 Jun 2026 10:40:49 +0000
Message-ID: <e61a0079bd34483d9c7e8f7ab2eabbdd@compal.com>
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
 <20260529-t9xx_driver_v1-v1-1-bdbfe2c01e57@compal.com>,<PH0PR11MB5902127C590230B9FE50F78AF0152@PH0PR11MB5902.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5902127C590230B9FE50F78AF0152@PH0PR11MB5902.namprd11.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-29998.006
x-tm-as-result: No-10--35.506200-8.000000
x-tmase-matchedrid: 48uEfNr0eYIuv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZgOe
	+RYG/aOVMleF7vJIPgrSbqGL9tBhQIgwREucKN12Jw66cQh/R5cZ8/pDtedih9THFoOVTUKPV/j
	iEQEirk341TouVyz12EO/61ANu+MmojFeM1oohOn9IVvj4uwqLKrS6L9vFmxJZa2JNgcOiFesgL
	PpvoHoy6HOpBjIHWi50C+gQJtqPNH6wSlgATpxEwx+Jtro8Arbfq7xWexVq1wkxtQqXREtZO7+w
	THUWclzCU+V2K2yEHStn8g1xaZpmOX6IOJSaFeq5enkh7Jrzn6dVbkPpTjx91hj3rL5vKL9IXHO
	M2cG4ibmHeR7UfhKyh6YMyhTYhY9lrz/HEUyDNSeKdOylUhP2afaLeRmLMOx510322JqPPEV++j
	bayV7gzqjgrvKc77TkYA4rVOEqAyIiUsncKJScFIqxe4Du3755lobMer6/dE3vJH2ZioNrYNPey
	Qu0gZXN7R3IlqWz4HU1FKl/T6FwtjOd5pUIofYT+vZ3ApQRae7CI/jbH/kmbeM96vhzuX7ieW6e
	cAvrZCG30f9k3JCJM0LI8dm6ZL9cRyh6V9KDHIRLjqoJJt/9frDHrB5YKTLXFAIRSIiEKJxg7sv
	MtapLiJsZ0L4JGotOvT30G5nOJt+3BndfXUhXQ==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--35.506200-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-29998.006
x-tm-snts-smtp: C081672BF3EBF1B43CB1D23C900413BAB4C7AAC62C6472C4995A75A6828A57932000:8
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
	TAGGED_FROM(0.00)[bounces-297611-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 9937C6686C5

SGkgSmFnaWVsc2tpLA0KDQpUaGFuayB5b3UgZm9yIHRoZSBkZXRhaWxlZCByZXZpZXcuIEJlbG93
IGFyZSB0aGUgY2hhbmdlcyBhbmQgcmVzcG9uc2VzDQpmb3IgdjIuDQoNCj4gPiArI2RlZmluZSBC
QVJfTlVNNg0KPg0KPiBwbGVhc2UgYWRkIGRyaXZlciBwcmVmaXgNCg0KUmVuYW1lZCB0byBNVEtf
UENJX0JBUl9OVU0gYXQgdjIuDQoNCj4gPiArI2RlZmluZSBTRVRfSFdfQklUUyhkZXN0LCBjaHMs
IG1oY2NpZiwgZGV2KVwNCj4gPiArKHtcDQo+ID4gK2lmICgoY2hzKSAmIChkZXYpKQ0KPg0KPiB3
aGF0IGlmIGFueSBvZiB0aGVzZSBpcyBlcXVhbCB0byAwPw0KPiBqdXN0IHNraXAgZG8gbm90IGxv
ZyBhbnl0aGluZz8NCg0KVGhpcyBtYWNybyBjb252ZXJ0cyBTVyBldmVudCBiaXRzIHRvIEhXIGNo
YW5uZWwgYml0cy4gVGhlIGNhbGxlcnMNCmFsd2F5cyBwYXNzIHZhbGlkIG5vbi16ZXJvIHZhbHVl
cyBmb3IgY2hzIGFuZCBkZXYuIEV2ZW4gaWYgZWl0aGVyDQppcyB6ZXJvLCB0aGUgYml0d2lzZSBB
TkQgcHJvZHVjZXMgemVybywgc28gZGVzdCByZW1haW5zIHVuY2hhbmdlZA0KYW5kIHdyaXRpbmcg
emVybyB0byB0aGUgaGFyZHdhcmUgd2lsbCBub3QgdHJpZ2dlciBhbnkgZXZlbnQuIFRoaXMgaXMN
CmEgc2FmZSBuby1vcCBhbmQgZG9lcyBub3Qgd2FycmFudCBhIHdhcm5pbmcgb3IgZXJyb3IgbG9n
Lg0KDQo+ID4gK3UzMiBtdGtfcGNpX21hY19yZWFkMzIoc3RydWN0IG10a19wY2lfcHJpdiAqcHJp
diwgdTY0IGFkZHIpDQo+ID4gK3sNCj4gPiArcmV0dXJuIGlvcmVhZDMyKHByaXYtPm1hY19yZWdf
YmFzZSArIGFkZHIpOw0KPiA+ICt9DQo+ID4gLi4uDQo+DQo+IHdvdWxkIGJlIGxvdmVseSB0byBo
YXZlIGtkb2Mgb2YgdGhlIG5vbi1zdGF0aWMgZnVuY3Rpb25zIGZyb20gdGhlIHNlcmllcw0KDQpD
b252ZXJ0ZWQgdGhlIGZvdXIgTU1JTyB3cmFwcGVyIGZ1bmN0aW9ucyAobXRrX3BjaV9tYWNfcmVh
ZDMyLA0KbXRrX3BjaV9tYWNfd3JpdGUzMiwgbXRrX3BjaV9yZWFkMzIsIG10a19wY2lfd3JpdGUz
MikgdG8gc3RhdGljDQppbmxpbmUgaW4gdGhlIGhlYWRlci4gVGhlc2UgYXJlIHRyaXZpYWwgb25l
LWxpbmUgd3JhcHBlcnMgYXJvdW5kDQppb3JlYWQzMi9pb3dyaXRlMzIgYW5kIGRvIG5vdCB3YXJy
YW50IHNlcGFyYXRlIGZ1bmN0aW9uIGRlZmluaXRpb25zLg0KVGhpcyBhbHNvIHJlZHVjZXMgdGhl
IG92ZXJhbGwgbGluZSBjb3VudC4NCg0KRm9yIHRoZSByZW1haW5pbmcgbm9uLXN0YXRpYyBmdW5j
dGlvbnMsIGtlcm5lbC1kb2MgY29tbWVudHMgaGF2ZSBiZWVuDQphZGRlZCBpbiB2Mi4NCg0KPiA+
ICtzaXplX2wgPSBGSUVMRF9HRVQoR0VOTUFTS19VTEwoMzEsIDApLCBjZmctPnNpemUpOw0KPiA+
ICtzaXplX2ggPSBGSUVMRF9HRVQoR0VOTUFTS19VTEwoNjMsIDMyKSwgY2ZnLT5zaXplKTsNCj4g
PiArcG9zID0gZmZzKHNpemVfbCk7DQo+ID4gK2lmIChwb3MpIHsNCj4gPiArYXRyX3NpemUgPSBw
b3MgLSAyOw0KPiA+ICt9IGVsc2Ugew0KPiA+ICtwb3MgPSBmZnMoc2l6ZV9oKTsNCj4gPiArYXRy
X3NpemUgPSBwb3MgKyAzMDsNCj4NCj4gaSBiZWxpZXZlIGJldHRlciB3b3VsZCBiZSB0byBoYXZl
IHNvbWUgZGVmaW5lcyBpbnN0ZWFkIG9mIG1hZ2ljDQoNClJlcGxhY2VkIG1hZ2ljIG51bWJlcnMg
aW4gbXRrX3BjaV9zZXR1cF9hdHIoKSB3aXRoIG5hbWVkIGRlZmluZXM6DQpBVFJfU0laRV9MTzMy
X01BU0ssIEFUUl9TSVpFX0hJMzJfTUFTSywgQVRSX1NJWkVfQklBU19GUk9NX0xPMzIsDQpBVFJf
QUREUl9BTElHTl9NQVNLLCBBVFJfRU4sIEFUUl9QQVJBTV9PRkZTRVQuDQoNCj4gPiArfQ0KPg0K
PiBwbGVhc2UgcHV0IHNvbWUgYnJlYWtzIHRvIGhhdmUgdGhlIGNvZGUgbG9naWNhbGx5IHNlcGFy
YXRlZA0KDQpBZGRlZCBibGFuayBsaW5lcyB0byBzZXBhcmF0ZSBsb2dpY2FsIGJsb2NrcyBpbiBt
dGtfcGNpX3NldHVwX2F0cigpLg0KDQo+ID4gKy8qIFNSQ19BRERSX0ggKi8NCj4gPiArYWRkciA9
IFJFR19BVFJfUENJRV9XSU4wX1QwX1NSQ19BRERSX01TQiArIG9mZnNldDsNCj4gPiArLi4uDQo+
ID4gKy8qIFNSQ19BRERSX0wgKi8NCj4gPiArYWRkciA9IFJFR19BVFJfUENJRV9XSU4wX1QwX1NS
Q19BRERSX0xTQiArIG9mZnNldDsNCj4gPiArLi4uDQo+ID4gKy8qIFRSU0xfQUREUl9IICovDQo+
ID4gKy4uLg0KPiA+ICsvKiBUUlNMX0FERFJfTCAqLw0KPg0KPiBjb21tZW50cyBzZWVtIHRvIGJl
IHJlZHVuZGFudCBpbW87IGNsZWFyZXIgd291bGQgYmUgdG8gaGF2ZSBqdXN0IG5ld2xpbmUNCj4g
aW5zdGVhZA0KDQpSZXBsYWNlZCByZWR1bmRhbnQgaW5saW5lIGNvbW1lbnRzIHdpdGggYmxhbmsg
bGluZSBzZXBhcmF0b3JzLg0KDQo+ID4gKy8qIFRSU0xfUEFSQU0gKi8NCj4gPiArYWRkciA9IFJF
R19BVFJfUENJRV9XSU4wX1QwX1RSU0xfUEFSQU0gKyBvZmZzZXQ7DQo+ID4gK3ZhbCA9IChjZmct
PnRyc2xfcGFyYW0gPDwgMTYpIHwgY2ZnLT50cnNsX2lkOw0KPg0KPiBhZ2FpbiBhIGxvdCBvZiBt
YWdpYyBoZXJlDQoNClJlcGxhY2VkIHdpdGggQVRSX1BBUkFNX09GRlNFVCBkZWZpbmUuDQoNCj4g
PiAraW50IG5yID0gMDsNCj4NCj4gd2hhdCdzIHRoZSBwb2ludCBvZiB6ZXJvaW5pdGluZyBpZiB0
aGUgdmFsdWUgaXMgYXNzaWduZWQgYXQNCj4gdGhlIG5leHQgbGluZT8NCg0KUmVtb3ZlZCB0aGUg
emVybyBpbml0aWFsaXphdGlvbiBhbmQgc2ltcGxpZmllZCB0aGUgZnVuY3Rpb24uIEFsc28NCmFk
ZGVkIGEgZ3VhcmQgZm9yIGlycV9jbnQgPT0gMCBhbmQgaXJxX2lkIDwgMC4NCg0KPiA+ICtuciA9
IGlycV9pZCAlIHByaXYtPmlycV9jbnQ7DQo+DQo+IGFyZSB3ZSBzdXJlIGlycV9jbnQgd29uJ3Qg
YmUgZXF1YWwgdG8gMCBpbiBhbnkgc2NlbmFyaW8/DQoNCkFkZGVkIGEgIXByaXYtPmlycV9jbnQg
Z3VhcmQgdGhhdCByZXR1cm5zIC1FSU5WQUwgYmVmb3JlIHRoZSBtb2R1bG8NCm9wZXJhdGlvbi4g
QWxzbyBhZGRlZCBhbiBpcnFfaWQgPCAwIGNoZWNrIGZvciBjb21wbGV0ZW5lc3MuDQoNCj4gPiAr
aWYgKHVubGlrZWx5KGlycV9pZCA8IDAgfHwgaXJxX2lkID49IE1US19JUlFfQ05UX01BWCkpDQo+
ID4gK3JldHVybiAtRUlOVkFMOw0KPg0KPiBpcyBpdCBhbnlob3cgYmVuZWZpY2lhbCB0byBwdXQg
dW5saWtlbHkgaGVyZSBhbmQgaW4gY2FzZSBvZiBvdGhlcg0KPiBhcHBlYXJhbmNlcyB3aXRoaW4g
dGhlIHNlcmllcz8NCg0KUmVtb3ZlZCB1bmxpa2VseSgpIGZyb20gdGhlIElSUSBwYXJhbWV0ZXIg
dmFsaWRhdGlvbiBjaGVja3MgaW4NCm10a19wY2lfZ2V0X2lycV9pZCgpLCBtdGtfcGNpX3JlZ2lz
dGVyX2lycSgpLA0KbXRrX3BjaV91bnJlZ2lzdGVyX2lycSgpLCBtdGtfcGNpX21hc2tfaXJxKCks
DQptdGtfcGNpX3VubWFza19pcnEoKSwgYW5kIG10a19wY2lfY2xlYXJfaXJxKCkuIFRoZXNlIGFy
ZSBub3QNCmhvdCBwYXRocyBhbmQgdGhlIGJyYW5jaCBoaW50IHByb3ZpZGVzIG5vIG1lYXN1cmFi
bGUgYmVuZWZpdCBoZXJlLg0KDQo+ID4gK2lmICh1bmxpa2VseSgoaXJxX2lkIDwgMCB8fCBpcnFf
aWQgPj0gTVRLX0lSUV9DTlRfTUFYKSB8fCBwcml2LT5pcnFfdHlwZSAhPSBQQ0lfSVJRX01TSVgp
KSB7DQo+DQo+IHNhbWUgaGVyZQ0KDQpTYW1lIGFzIGFib3ZlLCByZW1vdmVkIHVubGlrZWx5KCku
DQoNCj4gPiArdm9pZCBtdGtfcGNpX21hc2tfZXh0X2V2dChzdHJ1Y3QgbXRrX21kX2RldiAqbWRl
diwgdTMyIGNocykNCj4gPiArew0KPiA+ICtzdHJ1Y3QgbXRrX3BjaV9wcml2ICpwcml2ID0gbWRl
di0+aHdfcHJpdjsNCj4gPiArdTMyIGh3X2JpdHM7DQo+ID4gKw0KPiA+ICtod19iaXRzID0gbXRr
X3BjaV9leHRfZDJoX2V2dF9od19iaXRzKGNocyk7DQo+DQo+IG9uZSBvZiB0aGVzZSBpcyBpbml0
ZWQgYXQgZGVjbGFyYXRpb24sIDJuZCBvbmUgaXNudA0KPiBwbGVhc2Ugc3RheSBjb25zaXN0YW50
LCBAaHdfYml0cyBjYW4gYmUgaW5pdGVkIGFzIHdlbGwNCg0KRml4ZWQuIGh3X2JpdHMgaXMgbm93
IGluaXRpYWxpemVkIGF0IGRlY2xhcmF0aW9uIGluDQptdGtfcGNpX21hc2tfZXh0X2V2dCgpLCBt
dGtfcGNpX3VubWFza19leHRfZXZ0KCksIGFuZA0KbXRrX3BjaV9jbGVhcl9leHRfZXZ0KCkuDQoN
Cj4gPiAraW50IG10a19wY2lfc2VuZF9leHRfZXZ0KHN0cnVjdCBtdGtfbWRfZGV2ICptZGV2LCB1
MzIgY2gpDQo+ID4gK3sNCj4gPiArc3RydWN0IG10a19wY2lfcHJpdiAqcHJpdiA9IG1kZXYtPmh3
X3ByaXY7DQo+ID4gK3UzMiByY19iYXNlOw0KPiA+ICt1MzIgaHdfYml0czsNCj4NCj4gbWlzc2lu
ZyBrZG9jIGhlcmUgYW5kIHRoZXJlDQoNCkFkZGVkIGtlcm5lbC1kb2MgY29tbWVudHMgdG8gYWxs
IG5vbi1zdGF0aWMgZnVuY3Rpb25zIGluIHYyLg0KDQo+IHBsZWFzZSBzcXVhc2ggdmFyaWFibGVz
IG9mIHRoZSBzYW1lIHR5cGUgaW50byBzaW5nbGUgbGluZQ0KDQpNZXJnZWQgcmNfYmFzZSBhbmQg
aHdfYml0cyBpbnRvIGEgc2luZ2xlIGRlY2xhcmF0aW9uIGxpbmUuDQoNCj4gPiArI2Vsc2UNCj4N
Cj4gI2Vsc2UgLyogIUNPTkZJR19BQ1BJICovDQoNCkFkZGVkIGNvbW1lbnRzIHRvICNlbHNlIGFu
ZCAjZW5kaWYgcHJlcHJvY2Vzc29yIGRpcmVjdGl2ZXMuDQoNCj4gPiArI2VuZGlmDQo+DQo+ICNl
bmRpZiAvKiBDT05GSUdfQUNQSSAqLw0KDQpEb25lLg0KDQo+ID4gK21zbGVlcCg1MDApOw0KPg0K
PiBwbGVhc2UgZG9udCB1c2UgbWFnaWMgbnVtYmVyDQo+IGFsc28gd2hlcmUgdGhpcyB2YWx1ZSBo
YXMgYmVlbiBkZXJpdmVkIGZyb20/DQoNClJlcGxhY2VkIHdpdGggTVRLX1BMRFJfUE9XRVJfT0ZG
X0RFTEFZX01TIGRlZmluZS4gVGhpcyA1MDBtcyBkZWxheQ0KaXMgdGhlIG1pbmltdW0gdGltZSBy
ZXF1aXJlZCBieSB0aGUgTWVkaWFUZWsgbW9kZW0gaGFyZHdhcmUgdG8NCmNvbXBsZXRlIHRoZSBw
b3dlci1vZmYgc2VxdWVuY2UgYmVmb3JlIHJlLWluaXRpYWxpemF0aW9uIGNhbiBiZWdpbi4NCg0K
PiA+ICthY3BpX29zX2ZyZWUoYnVmZmVyLnBvaW50ZXIpOw0KPg0KPiBwbGVhZSBhZGQgc29tZSBu
ZXdsaW5lcw0KDQpBZGRlZCBuZXdsaW5lcyBpbiBtdGtfcGNpX3BsZHIoKSBmb3IgYmV0dGVyIHJl
YWRhYmlsaXR5Lg0KDQo+ID4gK2RlZmF1bHQ6DQo+ID4gK2JyZWFrOw0KPiA+ICt9DQo+ID4gKw0K
PiA+ICtyZXR1cm4gLUVJTlZBTDsNCj4NCj4gcGxlYXNlIHB1dCByZXR1cm4gaW50byBkZWZhdWx0
IGxhYmVsDQoNCk1vdmVkIHJldHVybiAtRUlOVkFMIGludG8gdGhlIGRlZmF1bHQgY2FzZSBsYWJl
bC4NCg0KPiA+ICtzdHJ1Y3QgbXRrX3BjaV9wcml2ICpwcml2ID0gY29udGFpbmVyX29mKHdvcmss
IHN0cnVjdCBtdGtfcGNpX3ByaXYsIG1oY2NpZl93b3JrKTsNCj4NCj4gaXNuJ3QgdGhpcyBsaW5l
ID4gODAgY2hhcnM/DQoNCldyYXBwZWQgdGhlIGNvbnRhaW5lcl9vZiBsaW5lIHRvIHN0YXkgd2l0
aGluIDgwIGNvbHVtbnMuDQoNCj4gPiArZGV2X2VycigobWRldiktPmRldiwgIkZhaWxlZCB0byBn
ZXQgbWhjY2lmX2lycV9pZC4gcmV0PSVkXG4iLCByZXQpOw0KPiA+ICtnb3RvIGVycjsNCj4NCj4g
d2h5IGNhbm5vdCBqdXN0IHJldHVybiByZXQ/DQoNClNpbXBsaWZpZWQgbXRrX21oY2NpZl9pbml0
KCkgdG8gcmV0dXJuIGRpcmVjdGx5IGluc3RlYWQgb2YgdXNpbmcNCmEgZ290byBsYWJlbC4NCg0K
PiA+ICtkZXZfZXJyKChtZGV2KS0+ZGV2LCAiRmFpbGVkIHRvIHJlZ2lzdGVyIG1oY2NpZl9pcnEg
Y2FsbGJhY2tcbiIpOw0KPiA+ICtnb3RvIGVycjsNCj4NCj4gaXQncyByZWR1bmRhbnQNCg0KUmVt
b3ZlZCB0aGUgcmVkdW5kYW50IGdvdG8uIFRoZSBmdW5jdGlvbiBub3cgcmV0dXJucyBkaXJlY3Rs
eS4NCg0KPiA+ICtkbyB7DQo+ID4gK2lycV9pZCA9IGZscyhpcnFfc3RhdGUpIC0gMTsNCj4NCj4g
YXJlIHdlIHN1cmUgaXJxX3N0YXRlIGNhbm5vdCBiZSAwPw0KDQpUaGUgY2FsbGVyIG10a19wY2lf
aXJxX21zaXgoKSBhbHJlYWR5IGNoZWNrcyAhaXJxX3N0YXRlIGFuZCByZXR1cm5zDQpJUlFfTk9O
RSBiZWZvcmUgcmVhY2hpbmcgbXRrX3BjaV9pcnFfaGFuZGxlcigpLiBTbyBpcnFfc3RhdGUgaXMN
Cmd1YXJhbnRlZWQgdG8gYmUgbm9uLXplcm8gd2hlbiB0aGUgaGFuZGxlciBpcyBpbnZva2VkLg0K
DQo+ID4gK2lmIChtdGtfcGNpX2xpbmtfY2hlY2sobWRldikpIHsNCj4gPiArcGNpX3NhdmVfc3Rh
dGUocGRldik7DQo+ID4gK30gZWxzZSB7DQo+ID4gK3JldCA9IC1FRkFVTFQ7DQo+ID4gK2dvdG8g
Y2xlYXJfbWFzdGVyOw0KPg0KPiAjZGVmaW5lRUZBVUxUMTQvKiBCYWQgYWRkcmVzcyAqLw0KPiBk
b2VzIGl0IHN1aXQgaGVyZT8NCg0KQ2hhbmdlZCB0aGUgZXJyb3IgY29kZSBmcm9tIC1FRkFVTFQg
dG8gLUVOT0xJTkssIHdoaWNoIGJldHRlcg0KZGVzY3JpYmVzIGEgUENJZSBsaW5rIGZhaWx1cmUu
DQoNCj4gPiArbWRldiA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqbWRldiksIEdGUF9LRVJO
RUwpOw0KPiA+ICtpZiAoIW1kZXYpIHsNCj4gPiArcmV0ID0gLUVOT01FTTsNCj4gPiArZ290byBv
dXQ7DQo+DQo+IGFzIGZvciB0aGUgcmVzdCBvZiB0aGUgbGFiZWxzIHBsZWFzZSBuYW1lIHdoYXQg
aXMgZG9uZQ0KPiBlZyBsb2dfZXJyDQoNClJlbmFtZWQgZ290byBsYWJlbCAib3V0IiB0byAibG9n
X2VyciIuDQoNCj4gcGxlYXNlIGFsc28gdGFrZSBhIGxvb2sgb24gc2FzaGlrbyBub3RlcywgdGhl
cmUgaXMgc29tZSBudW1iZXIgb2YgdGhlbQ0KDQpBZGRyZXNzZWQuIFRoZSBpdGVtcyBmcm9tIHNh
c2hpa28ncyByZXZpZXcgaGF2ZSBiZWVuIGluY29ycG9yYXRlZA0KaW50byB0aGlzIHJldmlzaW9u
Lg0KDQpUaGFua3MuDQoNCkphY2sgV3UNCg0KDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQpUaGlzIG1lc3NhZ2UgbWF5IGNvbnRhaW4gaW5mb3JtYXRpb24g
d2hpY2ggaXMgcHJpdmF0ZSwgcHJpdmlsZWdlZCBvciBjb25maWRlbnRpYWwgb2YgQ29tcGFsIEVs
ZWN0cm9uaWNzLCBJbmMuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQgb2Yg
dGhpcyBtZXNzYWdlLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYW5kIGRlc3Ryb3kvZGVsZXRl
IHRoZSBtZXNzYWdlLiBBbnkgcmV2aWV3LCByZXRyYW5zbWlzc2lvbiwgZGlzc2VtaW5hdGlvbiBv
ciBvdGhlciB1c2Ugb2YsIG9yIHRha2luZyBvZiBhbnkgYWN0aW9uIGluIHJlbGlhbmNlIHVwb24g
dGhpcyBpbmZvcm1hdGlvbiwgYnkgcGVyc29ucyBvciBlbnRpdGllcyBvdGhlciB0aGFuIHRoZSBp
bnRlbmRlZCByZWNpcGllbnQgaXMgcHJvaGliaXRlZC4NCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0NCg==

