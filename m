Return-Path: <netdev+bounces-297612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LnSPH08/KWreSwMAu9opvQ
	(envelope-from <netdev+bounces-297612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:41:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1502D668623
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:41:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=compal.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297612-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297612-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DC463016743
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF023F411A;
	Wed, 10 Jun 2026 10:41:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef22.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B173AC00;
	Wed, 10 Jun 2026 10:41:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088069; cv=none; b=ppUTO8pn0JH5Dp4RW8uHPsuB93IiIxsKU2zsHU8FZtYncIwd/+RXQsI6QE7ptvAxeud1m6N+n9L8Dkw+TxjZ/dV0Vvp5deZjvAI4Gkm8LnGslaxeiSgluWhEVpJdO11Us+D/DYLgo/I05MurVUIcGZW1J4bEtAq8fppMMO8ocJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088069; c=relaxed/simple;
	bh=+f/5oxE/59agGdO9xOsKFYsgV9DZASerFX23hY+hw0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t4ocjKRidcis3iW3PyN49bLr0iAehSOzLdoMyaDmZw4JVb1XilTTSUiIOuuSbpaUvBPUKrSXu4LgaBJGPPrDDriLEz8cIr0T7AHecf9lvCKmYfZH+rKDs0RrZpAOnaDNPS8JG8RcY/kMTW0BvB+AgcNTdR/ZnciGNHecXlVOSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
X-UUID: e0d2a56e64b811f1a87c2323a98e90a4-20260610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:90e98d0b-3e15-4d36-978b-ea1982db8a03,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:ab6a882a-13d2-4d29-83ea-b8014339a000,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e0d2a56e64b811f1a87c2323a98e90a4-20260610
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef22.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1868212737; Wed, 10 Jun 2026 18:41:03 +0800
X-UUID: de55106064b811f1a42089d3d1632821-20260610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:a7854a01-fdbb-4328-8513-9ce512303ece,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:6dd0b6fa-39ea-4a28-8a25-78d1d9de3b28,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: de55106064b811f1a42089d3d1632821-20260610
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 45276238; Wed, 10 Jun 2026 18:40:59 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 10 Jun 2026 18:40:57 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69%11]) with mapi id
 15.02.2562.029; Wed, 10 Jun 2026 18:40:57 +0800
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
Subject: RE: [PATCH 06/11] net: wwan: t9xx: Add AT & MBIM WWAN ports
Thread-Topic: [PATCH 06/11] net: wwan: t9xx: Add AT & MBIM WWAN ports
Thread-Index: AQHc8b9/L5Xd7Aiq8ESabWeyoJXQQbY3lfxF
Date: Wed, 10 Jun 2026 10:40:57 +0000
Message-ID: <05eed3059d234e12a878ac46fbfc279b@compal.com>
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
 <20260529-t9xx_driver_v1-v1-6-bdbfe2c01e57@compal.com>,<PH0PR11MB5902F4F78C4278F1BF960F73F0152@PH0PR11MB5902.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5902F4F78C4278F1BF960F73F0152@PH0PR11MB5902.namprd11.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-29998.006
x-tm-as-result: No-10--5.331400-8.000000
x-tmase-matchedrid: k7uoLACGqMouv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZgOe
	+RYG/aOVsdzeBfTA9wKXag6JXRDG1sxCYLLJQRDAbSejuH+Mi13KICKMKO5WPfKRRDf7VCkp8Ab
	jTX4b4HLlDHFUfqAqGlLKwBzqakRcwui2PufQomsU/cnBAuvi0zY77k36Z/odeKnzndt922UG3B
	LK+lnjpsUfafKIdHzAyLjSn2B78Ok6BMKTgRzwZpbDzdIFSwJIBgMjvFD8H/0svmzdeMszBZVxT
	+r3oxK8Jwv1cwMqQnoNh194vDCrLCRoQhMu0UDBJPlTeUnhPwo58Sarp97J8xfqd/DJ3Zya7rEb
	Qf2fdE4HPFQWdUWAFlbDbR2YcFkhTqvp3WuBJ3qM7P6UHRSRTB+JLyKkgCp8
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--5.331400-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-29998.006
x-tm-snts-smtp: A1929B96EAF51E793CFF04E9F05CDD4C44C32887E43B9C4C584F23904DC1CA2C2000:8
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-297612-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jedrzej.jagielski@intel.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
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
X-Rspamd-Queue-Id: 1502D668623

SGkgSmFnaWVsc2tpLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuIEJlbG93IGFyZSB0aGUg
Y2hhbmdlcyBhbmQgcmVzcG9uc2VzIGZvciB2Mi4NCg0KPiA+QWRkcyBBVCAmIE1CSU0gcG9ydHMg
dG8gdGhlIHBvcnQgaW5mcmFzdHJ1Y3R1cmUuDQo+DQo+IHBsZWFzZSB1c2UgaW1wZXJhdGl2ZSBt
b2RlIGluIGNvbW1pdCBtc2cNCg0KQ2hhbmdlZCB0byAiQWRkIEFUICYgTUJJTSBwb3J0cyB0byB0
aGUgcG9ydCBpbmZyYXN0cnVjdHVyZS4iDQoNCj4gPiArLyogLUVJTyBtZWFucyBwYXJ0aWFsIGRh
dGEgZGlzcGF0Y2ggY29tcGxldGUsIGRvZXMgbm90IGdvdG8gZHJvcCBmbG93ICovDQo+DQo+IHVu
Y2xlYXIgaG93IGFkZGluZyB0aGlzIGNvbW1lbnQgaXMgcmVsYXRlZCB0byB0aGUgcGF0Y2gNCg0K
QWdyZWVkLiBNb3ZlZCB0aGlzIGNvbW1lbnQgdG8gcGF0Y2ggNCB3aGVyZSB0aGUgY29kZSB3YXMN
CmludHJvZHVjZWQuDQoNCj4gPiAraW50IHJldCA9IDA7DQo+DQo+IGxpa2UgZm9yIHRoZSBwcmV2
aW91cyBjb21taXRzIC0gcGxlYXNlIGRvIG5vdCB6ZXJvaW5pdCB3aGVuIGRvbid0IHJlcXVpcmVk
DQo+IHJldHVyYm5pbmcgMCBhdCB0aGUgZW5kIGlzIGNvbXBsZXRlbHkgZmluZSBoZXJlDQoNClJl
bW92ZWQgemVyby1pbml0aWFsaXphdGlvbiBhbmQgcmV0dXJuIDAgZGlyZWN0bHkuDQoNCj4gPiAr
cmV0ID0gLUVGQVVMVDsNCj4NCj4gaSBiZWxpZXZlIHRoZXJlIGFyZSBiZXR0ZXIgc3VpdGluZyBj
b2Rlcw0KDQpDaGFuZ2VkIHRvIC1FSU5WQUwuIElmIHlvdSBoYXZlIGEgbW9yZSBzdWl0YWJsZSBl
cnJvciBjb2RlIGluDQptaW5kLCBwbGVhc2UgbGV0IHVzIGtub3cuDQoNCj4gPiAraWYgKGxlbiA9
PSAwKQ0KPiA+ICtyZXR1cm4gMDsNCj4NCj4gdGhhdCdzIHJlYWxseSBzdWNjZXNzZnVsIHBhdGg/
DQoNCkNoYW5nZWQgdG8gcmV0dXJuIC1FSU5WQUwgZm9yIHplcm8tbGVuZ3RoIHdyaXRlcy4NCg0K
PiA+ICtzdGF0aWMgaW50IG10a19wb3J0X3d3YW5faW5pdChzdHJ1Y3QgbXRrX3BvcnQgKnBvcnQp
DQo+DQo+IGZvciB0aGUgd2hvbGUgc2VyaWVzIC0gcGxlYXNlIGFzc2VzcyB3aGVyZSBpbnQgb3Zl
ciB2b2lkDQo+IGlzIHJlYWxseSByZXF1aXJlZA0KDQpSZXZpZXdlZCB0aGUgd2hvbGUgc2VyaWVz
LiBDaGFuZ2VkIHBvcnRfb3BzIGV4aXQsIHJlc2V0LA0KZW5hYmxlLCBhbmQgZGlzYWJsZSBjYWxs
YmFja3MgZnJvbSBpbnQgdG8gdm9pZCwgYXMgdGhlaXINCnJldHVybiB2YWx1ZXMgYXJlIG5ldmVy
IGNoZWNrZWQgYnkgY2FsbGVycy4gS2VwdCBpbml0IGFuZA0KcmVjdiBhcyBpbnQgc2luY2UgdGhl
aXIgcmV0dXJuIHZhbHVlcyBhcmUgdXNlZC4NCg0KVGhhbmtzLg0KDQpKYWNrIFd1DQoNCg0KPT09
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

