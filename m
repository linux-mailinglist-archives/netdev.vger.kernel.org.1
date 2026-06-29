Return-Path: <netdev+bounces-302475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rxCbIjocQmqR0QkAu9opvQ
	(envelope-from <netdev+bounces-302475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:18:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F30EC6D6E3A
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:18:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=compal.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302475-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302475-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9E69308793E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 07:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3D43BB69E;
	Mon, 29 Jun 2026 07:06:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13638F62F;
	Mon, 29 Jun 2026 07:05:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716760; cv=none; b=rb5e2cqscT0iueG42JuDjfA9z06UCu4QarsgAOdyKVnW/k8qId4T6+iJ9CL0LIbGu5RjUIe9gINxaVF2zSLl72e+fgNop0wXR2czv4c4PErB5xd4PoY+BwzRv3M3weEaIVi8pTWdNU0wB7MqULBlY6F4mQNaMAYWA48AFvHxmIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716760; c=relaxed/simple;
	bh=BeTnNwE9zAl/2PeQiD7HfAWUZzInG8v71OulXD0GcmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KD7mX53OBT0HTWUcC2KLuSGAvYfegB6H75TkcBpZbX7wYEe3s0Eid37QofldMOM3uU8j0FfrH9tRhDRkISO48lox+fLijzgMmv6yVkX9BkaJqQvlHcJZGR3QcxC0hDqC7CB5TjNafxK9wLWnb36QOCoxBb3/ht+s3afq76Xjyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
X-UUID: f28fab56738811f1b2470fb4f881575f-20260629
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:c9fe79e4-5e75-4812-a739-c9bf76782507,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:5348f88b-c1a3-4335-bf81-c4a7f9da024d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f28fab56738811f1b2470fb4f881575f-20260629
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 555330373; Mon, 29 Jun 2026 15:05:44 +0800
X-UUID: f0550e30738811f1b328fd8a884f4420-20260629
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:9f5b2324-446e-4959-8583-243ad8fb5f36,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:6df59e0c-7517-44c1-aea5-8c9d3ce153dd,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f0550e30738811f1b328fd8a884f4420-20260629
Received: from sdbmbx12.tpe.compalcomm.com [(10.113.2.136)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES256-SHA 256/256)
	with ESMTP id 238474838; Mon, 29 Jun 2026 15:05:41 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX12.tpe.compalcomm.com (10.113.2.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.29;
 Mon, 29 Jun 2026 15:05:38 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::7d1b:448d:4d95:51b0]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::7d1b:448d:4d95:51b0%11]) with mapi id
 15.02.2562.029; Mon, 29 Jun 2026 15:05:38 +0800
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
Subject: RE: [External Mail] Re: [PATCH v3 1/7] net: wwan: t9xx: Add PCIe core
Thread-Topic: [External Mail] Re: [PATCH v3 1/7] net: wwan: t9xx: Add PCIe
 core
Thread-Index: AQHdA/IH10HhI6o7GUuqYj0+Wsnzp7ZVIxqw
Date: Mon, 29 Jun 2026 07:05:38 +0000
Message-ID: <e1345ff36a94468c83a0f82e5b2ec22d@compal.com>
References: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
 <20260624-t9xx_driver_v1-v3-1-73ff03f60c48@compal.com>,<b6ee3440-385f-4567-993d-c10db6f10b97@lunn.ch>
In-Reply-To: <b6ee3440-385f-4567-993d-c10db6f10b97@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30036.005
x-tm-as-result: No-10--8.890000-8.000000
x-tmase-matchedrid: CEwNJ/T/RZQuv++HU7VXryRFbfQbCufdN0X64jGy2db7+pncqRJfy2XQ
	7TcqkNINLfgCWmpP5eNQyXUpsiJmUqfDm5zpCGQxJw66cQh/R5edVbkPpTjx908Amukj7bVmEbr
	AUOQkjxDQ+sS71+DOCDt5SMZ9h0apLRtwOjyP9FeiWLhmiI4dPyDilljGyWFts2R4RgZsli4Ghf
	Rb1Tj8IFtuSLLSc0B1Rj1QPIRw621+ObWvlxRIpL6eQJjrK3FJ
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--8.890000-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30036.005
x-tm-snts-smtp: 1842DB57374D5C5769838A65F7F54A1E39FC6395FFF685D109E847A256343F1B2000:8
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
	TAGGED_FROM(0.00)[bounces-302475-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: F30EC6D6E3A

SGkgQW5kcmV3LA0KDQo+ID4gKyNlbHNlIC8qICFDT05GSUdfQUNQSSAqLw0KPiA+ICsJZGV2X2Vy
cigobWRldiktPmRldiwgIlVuc3VwcG9ydGVkLCBDT05GSUcgQUNQSSBoYXNuJ3QgYmVlbiBzZXQg
dG8gJ3knXG4iKTsNCj4NCj4gV2h5IG5vdCBqdXN0IGhhdmUgdGhlIEtjb25maWcgZGVwZW5kIG9u
IEFDUEk/DQoNCldpbGwgYWRkICJkZXBlbmRzIG9uIEFDUEkiIGFuZCByZW1vdmUgdGhlICNpZmRl
ZiBibG9ja3MgaW4gdjQuDQoNCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlkZXZfZXJyKChtZGV2
KS0+ZGV2LCAiRmFpbGVkIHRvIHJlZ2lzdGVyIG1oY2NpZl9pcnEgY2FsbGJhY2tcbiIpOw0KPg0K
PiBXaHkgdGhlICgpIGFyb3VuZCBtZGV2Pw0KDQpXaWxsIHJlbW92ZSB0aGUgdW5uZWNlc3Nhcnkg
cGFyZW50aGVzZXMgZnJvbSBhbGwgb2NjdXJyZW5jZXMgaW4gdjQuDQoNClRoYW5rcy4=

