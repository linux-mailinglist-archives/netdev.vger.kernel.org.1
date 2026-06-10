Return-Path: <netdev+bounces-297614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 78lZLBdBKWo+TAMAu9opvQ
	(envelope-from <netdev+bounces-297614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:48:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2386686E8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:48:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=compal.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297614-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297614-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4484531437E3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB773F88BA;
	Wed, 10 Jun 2026 10:41:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6716B3F44D1;
	Wed, 10 Jun 2026 10:41:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088072; cv=none; b=naDMjMUnnGh1tZH11ansd0lzgsYGOqIS6Z7OzIOZe+VWPAgeBpb07SsSOBSZ5lf7Lli717teRLWZEGj88BRyLpqA5qvOUHw/1A2BGRRIGQqcz+Zafe608eyWefYm3/k//2MjQHp59cYcmIreyQHjQe6OmrLlltHvBnwQy6Uawxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088072; c=relaxed/simple;
	bh=uI38I5ENHl5K/xLXbu9kXVyOKQTTDhVkGa0dkyWeeEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DGQUky/AS0qZ3Njk6jl4YkMqXYW2wy7EMxgnSbPDCBkfSqM4Xh0f5z5AqI4A8s0XBE5uvrQmQhvOKT7X/DAldw+XOfd3W4K1C3BKN1+bshwNgT2JbIUppduxMURJbnB+7IDatxwFrDnBML7yrXTokvIuH5eyzgdnbVOAAkD5epA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
X-UUID: e169528464b811f1b2470fb4f881575f-20260610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:62422815-2a37-41d3-bd49-bbe08f423f4f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:b685e7a4-9ef7-4489-861a-e83b251ece46,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e169528464b811f1b2470fb4f881575f-20260610
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 314149127; Wed, 10 Jun 2026 18:41:04 +0800
X-UUID: dd2015dc64b811f1a42089d3d1632821-20260610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:cfca93aa-5195-4858-b403-d2c6918fdf59,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:876a882a-13d2-4d29-83ea-b8014339a000,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dd2015dc64b811f1a42089d3d1632821-20260610
Received: from sdbmbx12.tpe.compalcomm.com [(10.113.2.136)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES256-SHA 256/256)
	with ESMTP id 689644572; Wed, 10 Jun 2026 18:40:57 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX12.tpe.compalcomm.com (10.113.2.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.29;
 Wed, 10 Jun 2026 18:40:55 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69%11]) with mapi id
 15.02.2562.029; Wed, 10 Jun 2026 18:40:55 +0800
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
Subject: RE: [PATCH 03/11] net: wwan: t9xx: Add control DMA interface
Thread-Topic: [PATCH 03/11] net: wwan: t9xx: Add control DMA interface
Thread-Index: AQHc8b2GcEXIidYmSUOshBMxeAbtZrY3lXjp
Date: Wed, 10 Jun 2026 10:40:55 +0000
Message-ID: <336375db52e64e9c9b38882e5ed7a3ea@compal.com>
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
 <20260529-t9xx_driver_v1-v1-3-bdbfe2c01e57@compal.com>,<PH0PR11MB590283906E1724DEFC0985E6F0152@PH0PR11MB5902.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB590283906E1724DEFC0985E6F0152@PH0PR11MB5902.namprd11.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-29998.006
x-tm-as-result: No-10--14.460600-8.000000
x-tmase-matchedrid: IDcII6LbfMAuv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZgOe
	+RYG/aOVMleF7vJIPgrSbqGL9tBhQIgwREucKN123Qno10sIadHt08AkgFFynb5vYc/RF4DMIeU
	yk0r7SB2nLSPyJcfFP21Vadl7H9NiJzYi9JMPqXGFhGp9GNPDrfJDp0CY93MSeKnzndt922XSv5
	FCBxtfs1wBC+ObXMKeHK34MkSkfGc9F1mStRnXLLEGwwlGI5qhvzW3esYP4H7RDig+1bLp5Cl3D
	B68Rh7wjUNbqe3xrue15Jy4WHo1YpJ53TEh1l6gO9AbTF0WkML4qryqgi1bdfo2ryv7FQo4aRBV
	JZ6LCZEBlBlrcnSfn10hRTfTyAkPNHce8OjN0HXdtDLKIRgYoOPBqjds3Z7Jm8FbMD4J+lfWu1q
	i7UBzSJnG3JVss1SOUzrGFfGuC0EwUUvWm9TB7Pe+18RAuG2T0J735/IbYe3yYHi4HOy3fI9Xup
	CU2lE4Utar0GYFavTLmCJM+UUcQ41g3zDt1sv5D4I+2Qtnp0WiWLhmiI4dPyDilljGyWFts2R4R
	gZsli74ibNi9ALLMfHPTxUzJiJsmUIw8x4sD3ZnGpXqGceDwhDRNSuqVU5d
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--14.460600-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-29998.006
x-tm-snts-smtp: 6DBC74E95CE9D5E15F12595340A85DD5246C89B846F683B066B8B85E95F02A7F2000:8
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297614-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jedrzej.jagielski@intel.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,compal.com:mid,compal.com:from_mime];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B2386686E8

SGkgSmFnaWVsc2tpLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuIEJlbG93IGFyZSB0aGUg
Y2hhbmdlcyBhbmQgcmVzcG9uc2VzIGZvciB2Mi4NCg0KPiA+ICtpbnQgaSwgaGlmX2lkOw0KPiA+
ICtzdHJ1Y3QgdHJiICp0cmI7DQo+ID4gK3UzMiB0eHFubzsNCj4NCj4gcGxlYXNlIHN0aWNrIHRv
IFJDVA0KDQpSZW9yZGVyZWQgdmFyaWFibGUgZGVjbGFyYXRpb25zIHRvIGZvbGxvdyByZXZlcnNl
IENocmlzdG1hcyB0cmVlDQpzdHlsZS4NCg0KPiA+ICthZ2FpbjoNCj4gPiArZm9yIChpID0gMDsg
aSA8IHR4cS0+bnJfZ3BkczsgaSsrKSB7DQo+ID4gLi4uDQo+ID4gK3N0YXRlID0gZHJ2X29wcy0+
Y2xkbWFfY2hlY2tfaW50cl9zdGF0dXMoZHJ2X2luZm8sIERJUl9UWCwgdHhxbm8sIFFVRVVFX1hG
RVJfRE9ORSk7DQo+ID4gK2lmIChzdGF0ZSkgew0KPiA+IC4uLg0KPiA+ICtnb3RvIGFnYWluOw0K
Pg0KPiBhcmUgd2Ugc3VyZSB3ZSB3b24ndCBiZSBsb2NrZWQgaGVyZT8NCg0KVGhlIGxvb3AgaXMg
Ym91bmRlZDogZWFjaCBpdGVyYXRpb24gb2YgdGhlIGZvciBsb29wIHByb2Nlc3NlcyBhdA0KbW9z
dCBucl9ncGRzIGRlc2NyaXB0b3JzLCBhbmQgdGhlIGdvdG8gYWdhaW4gcGF0aCBvbmx5IHRyaWdn
ZXJzDQp3aGVuIGEgbmV3IFhGRVJfRE9ORSBpbnRlcnJ1cHQgYXJyaXZlcyB3aGlsZSBwcm9jZXNz
aW5nLiBTaW5jZSB0aGUNClRYIHJpbmcgaGFzIGEgZml4ZWQgbnVtYmVyIG9mIHNsb3RzLCBmb3J3
YXJkIHByb2dyZXNzIGlzIGd1YXJhbnRlZWQNCqFYIG9uY2UgYWxsIGNvbXBsZXRlZCBkZXNjcmlw
dG9ycyBhcmUgY29uc3VtZWQsIHRoZSBmb3IgbG9vcCBicmVha3MNCmF0IHRoZSBIV08gY2hlY2su
IGNvbmRfcmVzY2hlZCgpIHByZXZlbnRzIHNvZnQgbG9ja3VwLiBUaGlzIHBhdHRlcm4NCmlzIGNv
bnNpc3RlbnQgd2l0aCB0aGUgUlggd29yayBoYW5kbGVyIGluIHRoZSBzYW1lIGZpbGUuDQoNCj4g
PiArZXJyID0gbXRrX2NsZG1hX2NoZWNrX3J4X3JlcShkcnZfaW5mbywgcnhxKTsNCj4gPiAraWYg
KCFlcnIpDQo+ID4gK2dvdG8gYWdhaW47DQo+DQo+IHVuY2xlYXIgZm9yIG1lDQo+IHJlcGVhdCB3
aGVuIDAgaXMgcmV0dXJuZWQNCj4gZG8gbm90IHJlcGVhdCB3aGVuIC1FQUdBSU4gaXMgcmV0dXJu
ZWQgYnkgbXRrX2NsZG1hX2NoZWNrX3J4X3JlcT8NCg0KbXRrX2NsZG1hX2NoZWNrX3J4X3JlcSgp
IHJldHVybnMgMCB3aGVuIHRoZXJlIGFyZSBtb3JlIFJYDQpkZXNjcmlwdG9ycyByZWFkeSBmb3Ig
cHJvY2Vzc2luZyAoSFcgY3VycmVudCBhZGRyZXNzIGRpZmZlcnMgZnJvbQ0KdGhlIHNvZnR3YXJl
IGZyZWUgaW5kZXggYW5kIEhXTyBiaXQgaXMgY2xlYXJlZCksIHNvIHRoZSBsb29wDQpjb250aW51
ZXMuIE5vbi16ZXJvIG1lYW5zIGVpdGhlciBubyBtb3JlIGRhdGEgaXMgYXZhaWxhYmxlIG9yIGFu
DQplcnJvciBvY2N1cnJlZDoNCi0gLUVBR0FJTjogSFcgaXMgc3RpbGwgd29ya2luZyBvbiB0aGUg
Y3VycmVudCBkZXNjcmlwdG9yLCBvciBIV08NCiAgYml0IGRpZG4ndCBjbGVhciBpbiB0aW1lIKFY
IG5vIG1vcmUgZGF0YSB0byBwcm9jZXNzLg0KLSAtRU5YSU86IEhXIGN1cnJlbnQgYWRkcmVzcyBy
ZWFkIGJhY2sgYXMgMCwgaW5kaWNhdGluZyBhIGxpbmsNCiAgZXJyb3IuDQoNCldlIGFncmVlIHRo
ZSBzZW1hbnRpY3MgY291bGQgYmUgY2xlYXJlci4gV291bGQgeW91IHByZWZlciB3ZQ0KcmVuYW1l
L3Jlc3RydWN0dXJlIHRoaXMgoVggZm9yIGV4YW1wbGUsIHJldHVybmluZyBhIGJvb2wgKHRydWUg
PQ0KbW9yZSB3b3JrKSBhbmQgaGFuZGxpbmcgZXJyb3JzIHNlcGFyYXRlbHksIG9yIHVzaW5nIGEg
ZGlmZmVyZW50DQplcnJvciBjb2RlIGluc3RlYWQgb2YgLUVBR0FJTj8gT3BlbiB0byBzdWdnZXN0
aW9ucyBvbiB3aGF0IHdvdWxkDQpiZSBtb3N0IGludHVpdGl2ZSBoZXJlLg0KDQo+IHNvIGhvdyBF
QUdBSU4gaXMgYWN0dWFsbHkgdXNlZCBoZXJlPw0KDQotRUFHQUlOIGlzIHJldHVybmVkIGJ5IG10
a19jbGRtYV9zdWJtaXRfdHgoKSB3aGVuIHJlcV9idWRnZXQgPT0gMA0KKFRYIGRlc2NyaXB0b3Ig
cmluZyBmdWxsKS4gSW4gbXRrX2N0cmxfdHJiX2hhbmRsZXIsIHRoaXMgdHJpZ2dlcnMNCmZsb3cg
Y29udHJvbDogaWYgcGFja2V0cyB3ZXJlIGFscmVhZHkgYmF0Y2hlZCAodHhfYnVyc3RfY250ID4g
MCksDQpmbHVzaCB0aGVtOyBvdGhlcndpc2UgcmV0dXJuIGltbWVkaWF0ZWx5IGFuZCBsZWF2ZSB0
aGUgc2tiIGluIHRoZQ0KcXVldWUgZm9yIHJldHJ5IGFmdGVyIFRYIGNvbXBsZXRpb24gZnJlZXMg
YnVkZ2V0Lg0KDQpXZSBhZ3JlZSB0aGUgc2VtYW50aWNzIGNvdWxkIGJlIGNsZWFyZXIuIENvdWxk
IHlvdSBzdWdnZXN0IHdoaWNoDQplcnJvciBjb2RlIHdvdWxkIGJlIG1vcmUgYXBwcm9wcmlhdGUg
Zm9yIHRoaXMgY2FzZT8NCg0KPiA+ICtzdGF0aWMgaW50IG10a19jbGRtYV9yeHFfZnJlZShzdHJ1
Y3QgY2xkbWFfZHJ2X2luZm8gKmRydl9pbmZvLCB1MzIgcnhxbm8pDQo+DQo+IHBsZWFzZSBtYWtl
IGl0IHZvaWQNCg0KQ2hhbmdlZCB0byB2b2lkIHJldHVybiB0eXBlLg0KDQo+ID4gK2ludCByZXQg
PSAwOw0KPiA+IC4uLg0KPiA+ICtyZXR1cm4gcmV0Ow0KPg0KPiBqdXN0IHJldHVybiAwLCBubyBu
ZWVkIHRvIHplcm9pbml0IHJldA0KDQpSZW1vdmVkIHplcm9pbml0IGFuZCByZXR1cm4gMCBkaXJl
Y3RseSBpbiBtdGtfY2xkbWFfc3RhcnRfeGZlcigpLg0KDQo+ID4gK2ludCBtdGtfY2xkbWFfZXhp
dChzdHJ1Y3QgbXRrX2N0cmxfdHJhbnMgKnRyYW5zKQ0KPg0KPiB2b2lkPw0KDQpDaGFuZ2VkIHRv
IHZvaWQgcmV0dXJuIHR5cGUuDQoNCj4gPiAraW50IGVyciA9IDA7DQo+DQo+IHBsZWFzZSBiZSBj
b25zaXN0ZW50IHdpdGhpbiB0aGUgc2VyaWVzDQo+IGVpdGhlciB5b3UgbmFtZSAncmV0JyAgZWl0
aGVyICdlcnInDQoNClJlbmFtZWQgYWxsICdlcnInIHRvICdyZXQnIGNvbnNpc3RlbnRseSB0aHJv
dWdob3V0IHRoZSBwYXRjaC4NCg0KPiA+ICtpbnQgZXJyID0gMDsNCj4NCj4gbm8gbmVlZCB0byB6
ZXJvaW5pdA0KDQpSZW1vdmVkIHVubmVjZXNzYXJ5IHplcm8taW5pdGlhbGl6YXRpb24gaW4gbXRr
X2NsZG1hX3R4KCkuDQoNCj4gPiAraWYgKHVubGlrZWx5KCFkcnZfaW5mbykpIHsNCj4gPiArcmV0
ID0gLUVJTlZBTDsNCj4gPiArZ290byBvdXQ7DQo+ID4gK30NCj4NCj4gd2h5IGNhbm5vdCByZXR1
cm4gZGlyZWN0bHk/DQoNCkNoYW5nZWQgdG8gcmV0dXJuIGRpcmVjdGx5IGluc3RlYWQgb2YgZ290
byBvdXQgaW4NCm10a19jbGRtYV9zdWJtaXRfdHgoKSBlcnJvciBwYXRocy4NCg0KPiA+ICtpZiAo
dW5saWtlbHkoIWRydl9pbmZvKSkgew0KPg0KPiB3aGF0J3MgdGUgYmVuZWZpdCBvZiB1c2luZyB1
bmxpa2VseSBoZXJlPw0KDQpSZW1vdmVkIHVubGlrZWx5KCkgZnJvbSB2YWxpZGF0aW9uIHBhdGhz
IGluDQptdGtfY2xkbWFfY2hlY2tfY2hfY2ZnKCkuDQoNCj4gPiArdTMyIGFkZHI7DQo+ID4gK3Uz
MiB2YWw7DQo+ID4gK3UzMiBzdGE7DQo+DQo+IHBsZWFzZSBzcXVhc2gNCg0KU3F1YXNoZWQgaW50
byBhIHNpbmdsZSBkZWNsYXJhdGlvbiBsaW5lLg0KDQpUaGFua3MuDQoNCkphY2sgV3UNCg0KDQo9
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

