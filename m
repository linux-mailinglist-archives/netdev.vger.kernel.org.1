Return-Path: <netdev+bounces-305716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UBffIiwZTmrADAIAu9opvQ
	(envelope-from <netdev+bounces-305716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 11:32:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B5E723C3D
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 11:32:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=compal.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305716-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305716-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A16C302813E
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C366B411665;
	Wed,  8 Jul 2026 09:30:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDF340BCC1;
	Wed,  8 Jul 2026 09:30:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503036; cv=none; b=ceBTo8N7yb5XSUOnx3nRWeww8p2Bl3SQ1XlVQ3vjHgTxrxMgeTvVebcxVZNeToN5M++R8t4e8tRflnGFLGUemGH7u+hPvwaucPS8g/EMMds802tPn3C5JqNnfFBQrR6zT1KaDWWo5Xo+KcsETyvqGbc+9sGE38G155Qha22Y5Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503036; c=relaxed/simple;
	bh=fdXCHFlSHY6Pi75XVezjTuGAQRUzEJGxffv1ff2kPdo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=je4wM1L8bj+uoDJbaFBkEy6LRtG/jBG2MYovLdf1McACdrm9wlgv6ghqjnen4kKUr/R7pQvkM3Z12vO9zcf+MOLr5mMIQ2/AUBxdJK1gBje/h/TRGSR2gR+Eo26U3zGAia4gqU2U/bTJ1yefYRqfsnxxFE5jQ4TE/jO6129nMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
X-UUID: a318ae327aaf11f1b2470fb4f881575f-20260708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:ace3b483-2243-4700-bb3f-c990361bb1fa,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:922b396e-22d0-4ede-bde2-6d8eba2d8269,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a318ae327aaf11f1b2470fb4f881575f-20260708
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 430219693; Wed, 08 Jul 2026 17:30:19 +0800
X-UUID: a0d994747aaf11f1b328fd8a884f4420-20260708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:67e242bb-a205-4bc1-8542-34d19cf307b3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:b579e314-ea64-44d4-98db-4e1fb89955a3,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a0d994747aaf11f1b328fd8a884f4420-20260708
Received: from sdbmbx13.tpe.compalcomm.com [(10.113.2.137)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 2050100014; Wed, 08 Jul 2026 17:30:16 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX13.tpe.compalcomm.com (10.113.2.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Wed, 8 Jul 2026 17:30:12 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::2b98:6c2c:37df:2a86%11]) with mapi id
 15.02.2562.043; Wed, 8 Jul 2026 17:30:12 +0800
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
Thread-Index: AQHdA/KoG0AzoVDQmky5mWyAxH40ubZVI4cU///wpwCABNxa7P//y6CAgAm0KDo=
Date: Wed, 8 Jul 2026 09:30:12 +0000
Message-ID: <e85332119e154021b062b5fc55c0e7b8@compal.com>
References: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
 <20260624-t9xx_driver_v1-v3-2-73ff03f60c48@compal.com>
 <2a90ae6b-2b6d-4340-b557-915252cc3488@lunn.ch>
 <49939d4d682f4c1fb359973ea2cdbd00@compal.com>
 <92b1e341-31a1-4f60-80d5-ccf8f742a38a@lunn.ch>
 <4ec081f8df234cc584702abc67213965@compal.com>,<1e75c090-f4aa-4a02-82f5-fd4f3854acbe@lunn.ch>
In-Reply-To: <1e75c090-f4aa-4a02-82f5-fd4f3854acbe@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30054.005
x-tm-as-result: No-10--3.904000-8.000000
x-tmase-matchedrid: CEwNJ/T/RZQuv++HU7VXryRFbfQbCufdN0X64jGy2db7+pncqRJfyx3E
	y8bUOyJjLw+bI5poIljs40ztshOst3xCS+CiD3FqO9AbTF0WkMJ2Tr80kEaYUBxnMY5CbhsDBK5
	jsahkTKnXaWrmEWCMgtXNOAQ2MSi2E+WLy1iJCWo58Sarp97J8xfqd/DJ3Zya7rEbQf2fdE7Y1X
	9Lfi2tyajbSjLATgmfsOVWI173K16vZxwuuLqHzTAkd+hz53cJ9DE2tWwfka1IaQZV+iBbeJT/N
	1bEGeXqAyJyOEvE0jHbYRPoS4v8I1dlNryGcEYBugRp53kzD5HdjOqvc66oIgeBiFV2jjCF
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--3.904000-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30054.005
x-tm-snts-smtp: 67EF2485A09C352298FE9A9653BA47C3F06CDA692DB1F078D6CA9BF212C9D1CA2000:8
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
	TAGGED_FROM(0.00)[bounces-305716-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[compal.com:mid,compal.com:from_mime,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: B0B5E723C3D

SGkgQW5kcmV3LA0KDQo+ID4gV2Ugd2lsbCBhbHNvIHJlbW92ZSBhbGwgdW5uZWNlc3NhcnkgZGV2
bV9rZnJlZSgpIGNhbGxzIGZyb20gcHJvYmUNCj4gPiBlcnJvciBwYXRocyBhbmQgcmVtb3ZlIHBh
dGhzLCBrZWVwaW5nIHRoZW0gb25seSB3aGVyZSByZXNvdXJjZXMNCj4gPiBhcmUgZnJlZWQgYW5k
IHJlLWFsbG9jYXRlZCBhdCBydW50aW1lIChlLmcuLCBDTERNQSBxdWV1ZSBsaWZlY3ljbGUNCj4g
PiBkdXJpbmcgbW9kZW0gcmVzZXQgY3ljbGVzKS4NCj4NCj4gVGhlcmUgaXMgbm8gcG9pbnQgdXNp
bmcgZGV2bV8gaWYgeW91IGFyZSBnb2luZyB0byBtYW51YWxseSBtYW5hZ2UNCj4gdGhlaXIgcmVs
ZWFzZS4gQW55dGhpbmcgd2hpY2ggaGFzIGEgc2hvcnRlciBsaWZldGltZSB0aGFuIHRoZSBkZXZp
Y2UNCj4gc2hvdWxkIHVzZSBremFsbG9jKCkva2ZyZWUoKS4NCg0KV2Ugd2lsbCBjb252ZXJ0IGFs
bCBydW50aW1lLW1hbmFnZWQgcmVzb3VyY2VzIGZyb20NCmRldm1fa3phbGxvYy9kZXZtX2tmcmVl
IHRvIHBsYWluIGt6YWxsb2Mva2ZyZWUsIHNpbmNlIHRoZXkgaGF2ZQ0Kc2hvcnRlciBsaWZldGlt
ZXMgdGhhbiB0aGUgZGV2aWNlLiBPbmx5IGRldmljZS1saWZldGltZSByZXNvdXJjZXMNCndpbGwg
cmVtYWluIGFzIGRldm1fa3phbGxvYy4NCg0KVGhhbmtzLg0KICAgIEphY2sgV3U=

