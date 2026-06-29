Return-Path: <netdev+bounces-302491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e1wlCtogQmrP0gkAu9opvQ
	(envelope-from <netdev+bounces-302491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:38:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C20916D714D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:38:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=compal.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302491-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302491-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57EC930C78DC
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92A63D8105;
	Mon, 29 Jun 2026 07:29:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA13C063E;
	Mon, 29 Jun 2026 07:29:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718196; cv=none; b=ZnuYeLW8DUoNkZBW/8VA89vbXUKNvT+8fE8Cn3Z6yugtvqc2ilMG8Zr3CBzWQW2+Ek3UOB75VZiRmQCO5MhdkVPzg5KWcOTmyE+IOtLrjIPg0HnykTu6VZ4lYWNB7CsIZrq65zRPKMsZAL8NpShSLlfKNw6D/OBfAmSTZYqe5Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718196; c=relaxed/simple;
	bh=JEmazexdEjQceaq8RuFjuuddx0SGFge2E+F8Vah1LAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sv4cauihJsvkXpWlZdeYGmn+wb1hE7DxiCGF1Ct2OFiKbgHtoDTnskxlh0sPIVCXeecORm60JuROjo4pjXlr9enMJFBU8BVC5CX0HnoxEJKC7mHa0ElD4/SzAfO4WycrOXJWiADtQ+BVcuJPv3TVk+J26Xhhb8jhiFJloD/dPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
X-UUID: 4e43e284738c11f1b2470fb4f881575f-20260629
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:be9b4272-56cf-4e91-ae26-1fc831deedf6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:9d139912-9a7e-42e1-81ab-466f1025c889,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4e43e284738c11f1b2470fb4f881575f-20260629
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 344033330; Mon, 29 Jun 2026 15:29:47 +0800
X-UUID: 4ad2ccaa738c11f1b328fd8a884f4420-20260629
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:1fa9fa6c-31b0-4637-8a18-3b434aa4d833,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:64f40748-b183-4e35-bd22-a1c52f713e18,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4ad2ccaa738c11f1b328fd8a884f4420-20260629
Received: from sdbmbx13.tpe.compalcomm.com [(10.113.2.137)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 160527563; Mon, 29 Jun 2026 15:29:41 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX13.tpe.compalcomm.com (10.113.2.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 29 Jun 2026 15:29:39 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::7d1b:448d:4d95:51b0]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::7d1b:448d:4d95:51b0%11]) with mapi id
 15.02.2562.029; Mon, 29 Jun 2026 15:29:39 +0800
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
Subject: RE: [External Mail] Re: [PATCH v3 3/7] net: wwan: t9xx: Add control
 DMA interface
Thread-Topic: [External Mail] Re: [PATCH v3 3/7] net: wwan: t9xx: Add control
 DMA interface
Thread-Index: AQHdA/S+CwMCW7pQiESBKr0/82m1rbZVKgXn
Date: Mon, 29 Jun 2026 07:29:39 +0000
Message-ID: <970c47c350314cd3804cf89c782ac0f6@compal.com>
References: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
 <20260624-t9xx_driver_v1-v3-3-73ff03f60c48@compal.com>,<dc007021-9013-47b2-b06a-fe4a50d26722@lunn.ch>
In-Reply-To: <dc007021-9013-47b2-b06a-fe4a50d26722@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30036.005
x-tm-as-result: No-10--8.478700-8.000000
x-tmase-matchedrid: q6+TWfRxf4cuv++HU7VXryRFbfQbCufdN0X64jGy2db7+pncqRJfyyKW
	8VJRcYq50d8wVypPKQLFjZEb2XXb3XkHMxUIdlxLbSejuH+Mi12dVbkPpTjx96zU/PXAxei4Rwv
	rUDOnxbSG4JQWzp0ZirEQ0+Zqfe0ecXL3P3dqoBwKonRFsndtvW3OCu/eDpHU46a484IITvqB4k
	+feVEvLIV5aJP42NR/UqXCEoYB+d2eLwfnJiUpL5GPSO6O5JCao4NJa7SjFsrXNxRQEjCxuVo7G
	mCOJYd1O50T9A74HCu2FEUBwKd8yqnVdfVjtgB0tC7XpKGqhd4X0Ptm/gKnCihqD7a/0RgVmiaa
	avfjQzE=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--8.478700-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30036.005
x-tm-snts-smtp: F486DDB1691634C44801D42887E841FF8D7C96BF50693F24AC5918CFE8BC784F2000:8
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302491-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,compal.com:mid,compal.com:from_mime];
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
X-Rspamd-Queue-Id: C20916D714D

SGkgQW5kcmV3LA0KDQo+ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCBtdGtfY2xkbWFfY2xyX2JkX2Rz
YyhzdHJ1Y3QgY2xkbWFfZHJ2X2luZm8gKmRydl9pbmZvLA0KPiA+ICsJCQkJCXN0cnVjdCBiZF9k
c2MgKmJkX2RzY19wb29sLCBpbnQgbnJfYmRzKQ0KPg0KPiBObyBpbmxpbmUgZnVuY3Rpb25zIGlu
IEMgZmlsZXMuIFBsZWFzZSBsZXQgdGhlIGNvbXBpbGVyIGRlY2lkZS4NCg0KV2lsbCByZW1vdmUg
aW5saW5lIGZyb20gYWxsIHN0YXRpYyBmdW5jdGlvbnMgaW4gLmMgZmlsZXMuDQoNCj4gPiArCQli
ZF9kc2MtPnNrYiA9IF9fZGV2X2FsbG9jX3NrYihyZXEtPmZyYWdfc2l6ZSwgR0ZQX0tFUk5FTCk7
DQo+ID4gKwkJaWYgKCFiZF9kc2MtPnNrYikgew0KPiA+ICsJCQlkZXZfd2FybigobWRldiktPmRl
diwgIkZhaWxlZCB0byBhbGxvYyBTS0JcbiIpOw0KPg0KPiBZb3UgbWlnaHQgd2FudCB0byByYXRl
IGxpbWl0IHRoaXMsIGFuZCB0aGUgb3RoZXIgc2ltaWxhciBtZXNzYWdlcyBpbg0KPiB0aGUgZGF0
YSBwYXRoLCBvdGhlcndpc2UgaXQgY291bGQgYmUgYSBET1MuDQoNCldpbGwgc3dpdGNoIHRvIGRl
dl93YXJuX3JhdGVsaW1pdGVkKCkgZm9yIGRhdGEgcGF0aCB3YXJuaW5ncy4NCg0KPiA+ICsJfSB3
aGlsZSAoKytjbnQgPCAxMCk7DQo+DQo+IFBsZWFzZSB1c2Ugb25lIG9mIHRoZSBoZWxwZXJzIGZy
b20gaW9wb2xsLmguDQoNCldpbGwgcmVwbGFjZSB3aXRoIHJlYWRfcG9sbF90aW1lb3V0KCkgaW4g
djQuDQoNCj4gPiArCQkJZGV2bV9rZnJlZSh0cmFucy0+bWRldi0+ZGV2LCBzcnZfcXVlKTsNCj4N
Cj4gSXQgaXMgdW51c3VhbCB0byBzZWUgZGV2bV9rZnJlZSgpLiBXaHkgaXMgaXQgbmVlZGVkPw0K
DQpXaWxsIHJlbW92ZSByZWR1bmRhbnQgZGV2bV9rZnJlZSgpIGNhbGxzIGFuZCBsZXQgZGV2cmVz
IGhhbmRsZQ0KY2xlYW51cCBvbiBwcm9iZSBmYWlsdXJlLg0KDQo+ID4gK3N0YXRpYyB1bnNpZ25l
ZCBpbnQgY3RybF9wb3J0X2NobF9tdHU7DQo+DQo+IElzIHRoaXMgYSBnbG9iYWwgdmFyaWFibGU/
IFdoeSBpcyBpdCBub3QgcGFydCBvZiBwcml2Pw0KDQo+ID4gK21vZHVsZV9wYXJhbShjdHJsX3Bv
cnRfY2hsX210dSwgdWludCwgMDY0NCk7DQo+DQo+IE5vIG1vZHVsZXMgcGFyYW1ldGVycyBwbGVh
c2UuIElmIHRoaXMgaXMgYW4gTVRVLCB3aHkgbm90IHVzZSB0aGUNCj4gbm9ybWFsIG5ldHdvcmtp
bmcgaW50ZXJmYWNlcyB0byBzZXQgdGhlIE1UVT8NCg0KV2lsbCByZW1vdmUgdGhlIG1vZHVsZSBw
YXJhbWV0ZXIgZW50aXJlbHkuIFRoZSBjb250cm9sIHBvcnQgTVRVDQppcyBkZXRlcm1pbmVkIGJ5
IHRoZSBkZXZpY2UgZHVyaW5nIGhhbmRzaGFrZS4NCg0KVGhhbmtzLg0KDQpKYWNrIFd1

