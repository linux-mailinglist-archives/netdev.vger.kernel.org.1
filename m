Return-Path: <netdev+bounces-302489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8lJbKecfQmqM0gkAu9opvQ
	(envelope-from <netdev+bounces-302489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:33:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A166D70B2
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:33:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=compal.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302489-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302489-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91EF9306D260
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 07:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97383D47C0;
	Mon, 29 Jun 2026 07:27:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623E3D171F;
	Mon, 29 Jun 2026 07:26:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718021; cv=none; b=NuBfYzhuKRII13YmSfyS7zqQULD8Q2dJFgjbkFX8y/GbW3Qum5Av/KVpwkJBLhCnqNb95gJKU0ZmWOeR/ObLp2/wbfBCLF/05YTxRldkKIJxTGFEbZh5UYImp5UciKyXKaUWGPH9Yhak45DMYSXWnOKNuNsRmWcQ8EeSQxOSmFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718021; c=relaxed/simple;
	bh=SyP1rDr+scbd8EHqOhd2SEKwzz9Yk3yho9coNffyF3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L5Ax4B+Mdlq6DDSMLfLWlk914mrXMDI5jnbS/uHg+uSMiNhBMKUifbpmsGZNXRGnci/3yxJ7IeBcHxOfmWSzits7vHwCWBo0zuipLax1d9fE58fQA1iYLpcHiO/WKE7FgZGZ+7Yk/3LfyFC2/cMwHQgfwry4z5i48/ugvRs9aS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
X-UUID: e513c540738b11f1b2470fb4f881575f-20260629
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:37279384-69ba-457e-9911-d0efb34ab850,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:2eed0748-b183-4e35-bd22-a1c52f713e18,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e513c540738b11f1b2470fb4f881575f-20260629
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 212231599; Mon, 29 Jun 2026 15:26:50 +0800
X-UUID: e216f86c738b11f1a9f9c99e036204b4-20260629
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:412e1593-7594-480f-8640-49ac201ef9bf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:d57df88b-c1a3-4335-bf81-c4a7f9da024d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e216f86c738b11f1a9f9c99e036204b4-20260629
Received: from sdbmbx12.tpe.compalcomm.com [(10.113.2.136)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES256-SHA 256/256)
	with ESMTP id 1908956407; Mon, 29 Jun 2026 15:26:45 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX12.tpe.compalcomm.com (10.113.2.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.29;
 Mon, 29 Jun 2026 15:26:40 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::7d1b:448d:4d95:51b0]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::7d1b:448d:4d95:51b0%11]) with mapi id
 15.02.2562.029; Mon, 29 Jun 2026 15:26:40 +0800
From: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov
	<ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, Shi-Wei Yeh
	<shi-wei.yeh@mediatek.com>, Minano Tseng <Minano.tseng@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [External Mail] Re: [PATCH v3 2/7] net: wwan: t9xx: Add control
 plane transaction layer
Thread-Topic: [External Mail] Re: [PATCH v3 2/7] net: wwan: t9xx: Add control
 plane transaction layer
Thread-Index: AQHdA/KoG0AzoVDQmky5mWyAxH40ubZVI4cU
Date: Mon, 29 Jun 2026 07:26:40 +0000
Message-ID: <49939d4d682f4c1fb359973ea2cdbd00@compal.com>
References: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
 <20260624-t9xx_driver_v1-v3-2-73ff03f60c48@compal.com>,<2a90ae6b-2b6d-4340-b557-915252cc3488@lunn.ch>
In-Reply-To: <2a90ae6b-2b6d-4340-b557-915252cc3488@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30036.005
x-tm-as-result: No-10--4.183300-8.000000
x-tmase-matchedrid: tkB2VEODQ1cuv++HU7VXryRFbfQbCufdN0X64jGy2db7+pncqRJfy2XQ
	7TcqkNINhElhJj9TP7jAaX2MpgGS36gkniSqkpn+WZxYhPYYrMlHgZVDYg0zz4vmY1hE2VDUJQk
	txNYzOLPtFo0/MAzmm/xu9bNQI/V0YNP5ZvfGAKupSoJx15avkdZEjr6xrP/hagCqz15rA4CvI7
	qr7lIWqpm1ztAFUDBkjMlIlc7424OFF2q3JMLbrJGPSO6O5JCao4NJa7SjFsq4ssz2NHTRNT0wV
	pvG2n4d28gAxP/Ts6IHvfG6dvIquv6mDCw61sljHGqZLFSL6vqvbctbyBVCOC+JND9IHIJ4kfMa
	fuDIkC0Ich2EKbNazC40qe60KYOEZS4zlkrLF17MiA92IomI4m+o7cT3SFLw39InOc4KUjGgIAo
	CghvZZgz+8rPHUa6xHcvjWJiii5la1X5Zxk7x/Q==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--4.183300-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30036.005
x-tm-snts-smtp: BD93CB2734EF2CC9B20D2CE68070D84515D2F48398ED874D2E0ED1AAC02636F92000:8
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
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302489-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,compal.com:mid,compal.com:from_mime];
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
X-Rspamd-Queue-Id: 60A166D70B2

SGkgQW5kcmV3LA0KDQo+ID4gK3N0YXRpYyBpbnQgX19pbml0IG10a19jb21tb25fZHJ2X2luaXQo
dm9pZCkNCj4gPiArew0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArbW9kdWxlX2luaXQo
bXRrX2NvbW1vbl9kcnZfaW5pdCk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBfX2V4aXQgbXRr
X2NvbW1vbl9kcnZfZXhpdCh2b2lkKQ0KPiA+ICt7DQo+ID4gK30NCj4gPiArbW9kdWxlX2V4aXQo
bXRrX2NvbW1vbl9kcnZfZXhpdCk7DQo+DQo+IFNpbmNlIHRoZXNlIGRvbid0IGRvIGFueXRoaW5n
LCB0aGV5IHNob3VsZCBub3QgYmUgbmVlZGVkLg0KDQpXaWxsIG1vdmUgbW9kdWxlX2luaXQvbW9k
dWxlX2V4aXQgdG8gdGhlIHBhdGNoIHRoYXQgZmlyc3QgYWRkcw0KY29udGVudCB0byB0aGVtIGlu
IHY0Lg0KDQo+ID4gKwlTRVRfSFdfQklUUyhod19iaXRzLCBjaHMsIE1IQ0NJRl9SQzJFUF9FVlRf
REVWSUNFX1JFU0VULA0KPiA+ICsJCSAgICBERVZfRVZUX0gyRF9ERVZJQ0VfUkVTRVQpOw0KPiA+
ICsNCj4gPiArCXJldHVybiBMRTMyX1RPX1UzMihjcHVfdG9fbGUzMihod19iaXRzKSk7DQo+DQo+
IFBsZWFzZSBkb24ndCBhZGQgd2hpdGUgc3BhY2UgbGlrZSB0aGlzLiBJIGFzc3VtZSBhIHByZXZp
b3VzIHBhdGNoDQo+IGFkZGVkIHRoaXMgY29kZSwgc28gbW92ZSB0aGlzIHRvIHRoYXQgcGF0Y2gu
DQoNCldpbGwgcmVtb3ZlIHRoZSBleHRyYSBibGFuayBsaW5lIGluIHY0Lg0KDQo+ID4gLQlkZXZt
X2tmcmVlKGRldiwgbWRldik7DQo+ID4gKwltdGtfZGV2X2ZyZWUobWRldik7DQo+DQo+IFdoeSBh
cmUgeW91IHJlbW92aW5nIGRldm1fIGNhbGxzPw0KDQptdGtfZGV2X2FsbG9jL210a19kZXZfZnJl
ZSBhcmUgcGFpcmVkIHdyYXBwZXJzIHNvIHRoZSBjYWxsZXINCmRvZXNuJ3QgbmVlZCB0byBrbm93
IHRoZSB1bmRlcmx5aW5nIGFsbG9jYXRpb24gbWVjaGFuaXNtLg0KVGhlIGRldm1fa2ZyZWUgaXMg
c3RpbGwgY2FsbGVkIGluc2lkZSBtdGtfZGV2X2ZyZWUuDQoNClRoYW5rcy4NCg0KSmFjayBXdS4N
Cg0K

