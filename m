Return-Path: <netdev+bounces-301586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ts5MjehO2o9aggAu9opvQ
	(envelope-from <netdev+bounces-301586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:19:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7B76BCDED
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:19:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=compal.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301586-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301586-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A95F2301F5DE
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B51939EF20;
	Wed, 24 Jun 2026 09:19:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef22.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80C3815CA;
	Wed, 24 Jun 2026 09:19:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292779; cv=none; b=I7m4D7cwMLoeHUhGZeHu7X1atUOyfB65Gq/Icu9uh/NTIxDDjzJ62C0XWQrtDmp1l6NhyN2ujlhqWBhC7g+kqCPCn8vawJgtEvVE2vqrSVQCcUCZ4gDM0YAoHbICbco5JFK6qs9R3q2pPqbwpqlrUnrAM39auLKlM4EKp2mkxNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292779; c=relaxed/simple;
	bh=GwKKl2U0qYWfSS/Mrd3yEhjbcYWftLf0CK5Tc953E+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gQVQ24FApCCwKqsXOaXmKhFXZM5YPgeFDUYAJspXtPWKvDFhfeUPqBpX8D0KLGStqq1ZKS0IScydgqE5zRezvUmFwek55RaF2QTLj2HJN0VRkUppvMbNFpoGrwZkTOjEJa/9fgcJW207r/uiZo+8A5lW0TOS2kfeid/0pxOz1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
X-UUID: cea6859a6fad11f1a87c2323a98e90a4-20260624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:ea013ba1-1786-4a30-a4ba-59ebf642b83c,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e276073,CLOUDID:63856dd2-3d7e-4517-903d-51a0446bfbb1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|110|111|836|865|888|898
	,TC:-5,Content:0|15|50,EDM:1,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cea6859a6fad11f1a87c2323a98e90a4-20260624
Received: from sdmg12.sdbg.compal.com [(10.113.168.10)] by tpecef22.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 965987540; Wed, 24 Jun 2026 17:19:31 +0800
X-UUID: cbaa831e6fad11f1a9f9c99e036204b4-20260624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:91d88124-e2df-40e4-9978-ba7299b240b9,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e276073,CLOUDID:4e720dee-45e6-4692-a476-3f71842ee83b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|110|111|836|865|888|898
	,TC:-5,Content:0|15|50,EDM:1,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cbaa831e6fad11f1a9f9c99e036204b4-20260624
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg12.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 1997440592; Wed, 24 Jun 2026 17:19:26 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 24 Jun 2026 17:19:24 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69%11]) with mapi id
 15.02.2562.029; Wed, 24 Jun 2026 17:19:24 +0800
From: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov
	<ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, Shi-Wei Yeh
	<shi-wei.yeh@mediatek.com>, Minano Tseng <Minano.tseng@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [External Mail] [PATCH v2 4/7] net: wwan: t9xx: Add control port
Thread-Topic: [External Mail] [PATCH v2 4/7] net: wwan: t9xx: Add control port
Thread-Index: AQHc+MXER+0e36Bzt0KVnqSuSEmcJ7ZNgzOD
Date: Wed, 24 Jun 2026 09:19:24 +0000
Message-ID: <5f97412b98854bf7be00ce05eb65e1a8@compal.com>
References: <20260610-t9xx_driver_v1-v2-0-c65addf23b3f@compal.com>,<20260610-t9xx_driver_v1-v2-4-c65addf23b3f@compal.com>
In-Reply-To: <20260610-t9xx_driver_v1-v2-4-c65addf23b3f@compal.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30026.005
x-tm-as-result: No-10--23.579800-8.000000
x-tmase-matchedrid: UNEQujRoVJIuv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZnw0
	UcwaiWo2OEjNu/JAa11YsTeqDGqRggCyCXo9mCokAszeqtinEntp06mpfxpYpqWXeo1JBrZgJQk
	txNYzOLO76Z45RLYMBAcvNLEF1stGsKIo/QD9OP8L6av7YvHcfN1tZYGGteqdZjRClRrKzAC9e7
	i1M18PVvefNr6cZ5KJPpfTE7RY85419qws1c0mMmhvgRiYA2uX6horV6wkbup0tRNYhG3TbD+9W
	C60mVVgEhLKqmh66Gbsfp8hy0bbwfXxEsHu55A0Wdpm2XfIKrS8SGqPh5Lrzb5gR7aKDORv+M7M
	mtn1ctIGMx4i57hu3IP+YxQyesZonHWf2RnUpXRdY3l8suey3m1VBF1Wx8RHTiIxB64ZVbPd3kq
	aUDwUQgA3Nt3/cPaVmHBRWUbBCOQroMkkjPdrkXfJtzQYHWne8kOnQJj3cxL1Rudqy9AHLacRC9
	tpZbCNR5sntbzu87bSJbEy89PWhahTyJKvz2AI1tM63VFvEPm6wG+1uTW14Md/JSkHuJ0XYUI5W
	g/NCMHBOsvcedR6ud77X2nYPRhXzxLA25BQ1yOUnSCU9aFRnY6Y3KWHZUQHlkWKVfNAci9+ffcd
	uU8czVg5Cbf2Cb5kSiiY7iGx6AGx4kKnYaip3/ALb/kGCZix51PXML9iZzmr/Z09Ox/NTcr9LYT
	CdG1Be1XpmK8H/hqPk2Izce0do4SDjDp353TvN8p8TeI8dTeXNMZ7DbUqw6loHyDFpaEssNGbeS
	bzWLknjFc8xLI8LCoL+4D7QGjwXE3xYO16EyoRLjqoJJt/9fmA1kk/6T8voli4ZoiOHT8g4pZYx
	slhbbNkeEYGbJYuA/3R8k/14e0=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--23.579800-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30026.005
x-tm-snts-smtp: 66316D71112EAE6D637C09451A0EF4684EC4FCBF6EC2AB73615D14EE64F3B40F2000:8
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,sea.lore.kernel.org:server fail,compal.com:server fail];
	TAGGED_FROM(0.00)[bounces-301586-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:JackBB_Wu@compal.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org,compal.com];
	FORGED_SENDER(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: BF7B76BCDED

SGkgSmFrdWIsDQoNCkFkZHJlc3Npbmcgc2FzaGlrbyBBSSBjb2RlIHJldmlldyBjb21tZW50cyBm
b3IgdGhpcyBwYXRjaCwgYXMNCnJlcXVlc3RlZCBieSB5b3UgaW4gdGhlIHBhdGNoIDMvNyByZXZp
ZXc6DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBmL3BhdGNo
LzIwMjYwNjEwLXQ5eHhfZHJpdmVyX3YxLXYyLTMtYzY1YWRkZjIzYjNmQGNvbXBhbC5jb20vIzI3
MDA2MDg4DQoNClExOiBEb2VzIHRoaXMgdW5jb25kaXRpb25hbGx5IGZyZWUgdGhlIGludGVybmFs
IHBvcnQgbWVtb3J5PyBJZiBhbiBpbnRlcm5hbA0KdXNlciBvciBhbiBhY3RpdmUgVFJCIGhvbGRz
IGEgcmVmZXJlbmNlIHRvIHRoZSBwb3J0IGR1cmluZyBkZXZpY2UgdGVhcmRvd24sDQppdCBzZWVt
cyB0aGlzIGJ5cGFzc2VzIGtyZWZfcHV0IGFuZCBkaXJlY3RseSBjYWxscyB0aGUgcmVsZWFzZSBm
dW5jdGlvbi4NClRoaXMgY291bGQgbGVhZCB0byBhIHVzZS1hZnRlci1mcmVlIHdoZW4gdGhleSBh
dHRlbXB0IHRvIGFjY2VzcyB0aGUgcG9ydA0Kb3IgZHJvcCB0aGVpciByZWZlcmVuY2UuDQoNCiAg
SW50ZXJuYWwgcG9ydHMgYXJlIGV4Y2x1c2l2ZWx5IHVzZWQgYnkgdGhlIEZTTSBsYXllci4gRHVy
aW5nDQogIHRlYXJkb3duLCBtdGtfZnNtX2N0cmxfY2hfc3RvcCBjYWxscyBtdGtfcG9ydF9pbnRl
cm5hbF9jbG9zZSwNCiAgd2hpY2ggY2FsbHMga3JlZl9wdXQgdG8gcmVsZWFzZSB0aGUgdXNlcidz
IHJlZmVyZW5jZSBiZWZvcmUNCiAgbXRrX3BvcnRfZnJlZV9vcl9iYWNrdXAgaXMgcmVhY2hlZC4g
QnkgdGhlIHRpbWUNCiAgbXRrX3BvcnRfZnJlZV9vcl9iYWNrdXAgcnVucywgdGhlIGtyZWYgY291
bnQgaXMgMSAodGhlIGluaXRpYWwNCiAgYWxsb2NhdGlvbiByZWZlcmVuY2Ugb25seSkuIENhbGxp
bmcgbXRrX3BvcnRfcmVsZWFzZSBkaXJlY3RseSBhdA0KICB0aGlzIHBvaW50IGlzIGVxdWl2YWxl
bnQgdG8ga3JlZl9wdXQgZGVjcmVtZW50aW5nIGZyb20gMSB0byAwLg0KICBJbnRlcm5hbCBwb3J0
cyBkbyBub3QgdXNlIHRoZSBzdGFsZSBsaXN0IGJhY2t1cCBtZWNoYW5pc20sIHNvDQogIGJ5cGFz
c2luZyBrcmVmX3B1dCBhdm9pZHMgdGhlIHVubmVjZXNzYXJ5IHN0YWxlIGxpc3QgY2hlY2sgaW4g
dGhlDQogIGtyZWZfcHV0IHBhdGguDQoNClEyOiBJcyBpdCBzYWZlIHRvIHRyYXZlcnNlIHRoZSBw
b3J0X3RibCByYWRpeCB0cmVlIHdpdGhvdXQgaG9sZGluZw0KcmN1X3JlYWRfbG9jayBvciB0aGUg
cG9ydF9tbmdyX2dycF9tdHggbXV0ZXg/IENvbmN1cnJlbnQgcG9ydCBkZWxldGlvbnMNCmNvdWxk
IGZyZWUgcmFkaXggdHJlZSBub2RlcyBvciBtdGtfcG9ydCBzdHJ1Y3R1cmVzIGR1cmluZyB0cmF2
ZXJzYWwsDQpwb3RlbnRpYWxseSBsZWFkaW5nIHRvIGEgdXNlLWFmdGVyLWZyZWUgd2hlbiB0aGUg
dW4tcmVmY291bnRlZCBwb2ludGVycw0KYXJlIGRlcmVmZXJlbmNlZC4NCg0KICBtdGtfcG9ydF9z
ZWFyY2hfYnlfbmFtZSBpcyBvbmx5IGNhbGxlZCBmcm9tIG10a19wb3J0X2ludGVybmFsX29wZW4s
DQogIHdoaWNoIGlzIGV4Y2x1c2l2ZWx5IGludm9rZWQgYnkgdGhlIEZTTSBrdGhyZWFkIGR1cmlu
Zw0KICBtdGtfZnNtX2N0cmxfY2hfc3RhcnQuIFBvcnQgY3JlYXRpb24gYW5kIGRlc3RydWN0aW9u
IGFyZSBhbHNvDQogIGRyaXZlbiBieSBGU00gc3RhdGUgdHJhbnNpdGlvbnMgb24gdGhlIHNhbWUg
a3RocmVhZC4gU2luY2UgdGhlIEZTTQ0KICBzZXJpYWxpemVzIHRoZXNlIG9wZXJhdGlvbnMsIG5v
IGNvbmN1cnJlbnQgcG9ydCByZW1vdmFsIGNhbiBvY2N1cg0KICB3aGlsZSBzZWFyY2hfYnlfbmFt
ZSBpcyBpdGVyYXRpbmcgdGhlIHJhZGl4IHRyZWUuDQoNClEzOiBJZiB0aGlzIGFycmF5IGFsbG9j
YXRpb24gZmFpbHMgZHVyaW5nIHRlYXJkb3duLCBkb2VzIHRoZSBmdW5jdGlvbiBza2lwDQpkZWxl
dGluZyBpdGVtcyBmcm9tIHRoZSByYWRpeCB0cmVlIGFuZCBmcmVlaW5nIHRoZSBkeW5hbWljYWxs
eSBhbGxvY2F0ZWQNCm10a19wb3J0IG9iamVjdHM/IFRoaXMgYXBwZWFycyB0byBieXBhc3MgdGhl
IHRlYXJkb3duIHBoYXNlIGVudGlyZWx5IGFuZA0KbGVhayBtZW1vcnkuDQoNCiAgVmFsaWQuIEZp
eGVkIGluIHYzIGJ5IHJlcGxhY2luZyBrY2FsbG9jICsgcmFkaXhfdHJlZV9nYW5nX2xvb2t1cA0K
ICB3aXRoIHJhZGl4X3RyZWVfZm9yX2VhY2hfc2xvdCgpIGFuZCBzaW5nbGUtZW50cnkgZ2FuZ19s
b29rdXAsDQogIGVsaW1pbmF0aW5nIHRoZSBhbGxvY2F0aW9uIGluIHRoZSB0ZWFyZG93biBwYXRo
Lg0KDQpRNDogU2hvdWxkIHdlIGluY3JlbWVudCB0aGUgcG9ydCdzIHJlZmVyZW5jZSBjb3VudCB3
aGVuIGFzc2lnbmluZyBpdCB0bw0KdHJiLT5wcml2PyBJZiBhIHdyaXRlciB0aHJlYWQgaXMgaW50
ZXJydXB0ZWQgYnkgYSBzaWduYWwgd2hpbGUgd2FpdGluZyBmb3INCmhhcmR3YXJlIGNvbXBsZXRp
b24sIGl0IHJldHVybnMgYW5kIGRyb3BzIHRoZSBwb3J0LiBJZiB0aGUgcG9ydCBpcyB0aGVuDQpj
bG9zZWQgYW5kIGZyZWVkLCB0aGUgYXN5bmNocm9ub3VzIGNhbGxiYWNrIG10a19wb3J0X3R4X2Nv
bXBsZXRlIHdpbGwNCmRlcmVmZXJlbmNlIHRoZSBmcmVlZCBwb3J0LCByZXN1bHRpbmcgaW4gYSB1
c2UtYWZ0ZXItZnJlZS4NCg0KICBUaGUgVFJCIGxpZmVjeWNsZSBpcyBwcm90ZWN0ZWQgYnkga3Jl
ZiBvbiB0aGUgVFJCIGl0c2VsZiAoa3JlZl9nZXQNCiAgYmVmb3JlIHN1Ym1pdCwga3JlZl9wdXQg
aW4gYm90aCB0aGUgY2FsbGVyIGFuZCB0aGUgY29tcGxldGlvbg0KICBjYWxsYmFjaykuIFdoZW4g
YSBibG9ja2luZyBvcGVyYXRpb24gdGltZXMgb3V0LCB0aGUgY2FsbGVyIHJlbGVhc2VzDQogIGl0
cyBrcmVmIHJlZmVyZW5jZSwgYnV0IHRoZSBUUkIgcmVtYWlucyBhbGl2ZSBpbiB0aGUgdHJhbnNh
Y3Rpb24NCiAgbGF5ZXIgdW50aWwgdGhlIGNvbXBsZXRpb24gY2FsbGJhY2sgZmlyZXMuIFRoZSBw
b3J0IGlzIG5vdCBmcmVlZCBhdA0KICB0aGlzIHBvaW50IKFYIHBvcnQgZGVzdHJ1Y3Rpb24gZ29l
cyB0aHJvdWdoIGtyZWZfcHV0KCZwb3J0LT5rcmVmLA0KICBtdGtfcG9ydF9yZWxlYXNlKSwgYW5k
IHRoZSBwb3J0J3MgcmVmZXJlbmNlIGNvdW50IGlzIG5vdCBkZWNyZW1lbnRlZA0KICB1bnRpbCB0
aGUgY2xvc2UgcGF0aCBjb21wbGV0ZXMuIEFkZGl0aW9uYWxseSwgVFJCX0NNRF9ESVNBQkxFDQog
IHRyaWdnZXJzIG10a19jdHJsX2NoX2ZsdXNoIGluIHRoZSB0cmFuc2FjdGlvbiBsYXllciwgd2hp
Y2ggZm9yY2VzDQogIGFsbCBwZW5kaW5nIFRSQnMgdG8gY29tcGxldGUgYmVmb3JlIHRoZSBwb3J0
IHRlYXJkb3duIHByb2NlZWRzLg0KDQpRNTogQ2FuIGNvbmN1cnJlbnQgcGFja2V0IHRyYW5zbWlz
c2lvbnMgb24gdGhlIHNhbWUgcG9ydCByYWNlIGhlcmU/IFRoZXJlDQpkb2VzIG5vdCBhcHBlYXIg
dG8gYmUgYW55IHN5bmNocm9uaXphdGlvbiBwcm90ZWN0aW5nIHRoZSByZWFkIGFuZCBpbmNyZW1l
bnQNCm9mIHBvcnQtPnR4X3NlcS4NCg0KICB0eF9zZXEgaXMgYSBwZXItcG9ydCA4LWJpdCBzZXF1
ZW5jZSBudW1iZXIuIEVhY2ggcG9ydCBoYXMgYSBzaW5nbGUNCiAgd3JpdGVyIGluIHByYWN0aWNl
OiBleHRlcm5hbCBwb3J0cyBhcmUgd3JpdHRlbiBmcm9tIHVzZXIgc3BhY2UgdmlhDQogIGNkZXYg
d3JpdGUoKSAoc2VyaWFsaXplZCBieSB0aGUgZmlsZSBkZXNjcmlwdG9yKSwgYW5kIGludGVybmFs
DQogIHBvcnRzIGFyZSB3cml0dGVuIGV4Y2x1c2l2ZWx5IGJ5IHRoZSBGU00ga3RocmVhZC4gQ29u
Y3VycmVudA0KICB0cmFuc21pc3Npb25zIG9uIHRoZSBzYW1lIHBvcnQgZG8gbm90IG9jY3VyIGlu
IG5vcm1hbCBvcGVyYXRpb24uDQoNClE2OiBEb2VzIHRoaXMgc2FmZWx5IGhhbmRsZSBmcmFnbWVu
dGVkIFNLQnM/IFdpdGhvdXQgdXNpbmcgcHNrYl9tYXlfcHVsbA0Kb3Igc2ltaWxhciwgdGhlIGhl
YWRlciBtaWdodCBzcGFuIGFjcm9zcyBtdWx0aXBsZSBETUEgZnJhZ21lbnRzLiBJZg0Kc2tiLT5k
YXRhIGRvZXMgbm90IGNvbnRhaW4gdGhlIGVudGlyZSAxNi1ieXRlIGhlYWRlciwgdGhpcyBjYXN0
IGNvdWxkDQpyZXN1bHQgaW4gcmVhZGluZyBvdXQtb2YtYm91bmRzIG1lbW9yeS4NCg0KICBUaGUg
UlggU0tCcyBhcmUgYWxsb2NhdGVkIGludGVybmFsbHkgYnkgdGhlIENMRE1BIGRyaXZlciB1c2lu
Zw0KICBfX2Rldl9hbGxvY19za2Igd2l0aCBsaW5lYXIgYnVmZmVycy4gVGhlIENDQ0kgaGVhZGVy
IGFsd2F5cyByZXNpZGVzDQogIGluIHRoZSBjb250aWd1b3VzIGxpbmVhciBkYXRhIHJlZ2lvbi4g
bXRrX3BvcnRfc3RyaXBfaGVhZGVyIGFscmVhZHkNCiAgdmFsaWRhdGVzIHNrYi0+bGVuID49IHNp
emVvZigqY2NjaV9oKSBiZWZvcmUgYWNjZXNzaW5nIHRoZSBoZWFkZXIuDQogIFNpbmNlIHRoZXNl
IFNLQnMgYXJlIG5vdCByZWNlaXZlZCBmcm9tIHRoZSBuZXR3b3JrIHN0YWNrIGFuZCBhcmUNCiAg
YWx3YXlzIGxpbmVhciwgcHNrYl9tYXlfcHVsbCBpcyBub3QgbmVlZGVkIGhlcmUuDQoNClE3OiBJ
cyB0aGVyZSBhIGJvdW5kcyBjaGVjayB0byBlbnN1cmUgdGhhdCB0aGUgcGFja2V0IGJ1ZmZlciBp
cyBsYXJnZQ0KZW5vdWdoIHRvIGhvbGQgdGhlIG51bWJlciBvZiBwb3J0cyBzcGVjaWZpZWQgYnkg
bXNnLT5wb3J0X2NudD8gSWYgdGhlDQptb2RlbSBwcm92aWRlcyBhbiBhcmJpdHJhcmlseSBsYXJn
ZSBjb3VudCwgdGhpcyBsb29wIGNvdWxkIHJlYWQgcGFzdCB0aGUNCmVuZCBvZiB0aGUgcGFja2V0
IGRhdGEuDQoNCiAgVGhlIG1lc3NhZ2UgaXMgYWxyZWFkeSB2YWxpZGF0ZWQgYnkgaGVhZF9wYXR0
ZXJuLCB0YWlsX3BhdHRlcm4sIGFuZA0KICB2ZXJzaW9uIGNoZWNrcyBiZWZvcmUgdGhlIGxvb3Au
IFRoZSBwb3J0IGVudW1lcmF0aW9uIHByb3RvY29sDQogIGJldHdlZW4gaG9zdCBhbmQgbW9kZW0g
Z3VhcmFudGVlcyB0aGF0IHRoZSBidWZmZXIgY29udGFpbnMgZXhhY3RseQ0KICBwb3J0X2NudCBl
bnRyaWVzLiBUaGUgbW9kZW0gZmlybXdhcmUgaXMgYSB0cnVzdGVkIHNvdXJjZSChWCB0aGlzIGlz
DQogIGEgY29udHJvbCBwbGFuZSBpbnRlcmZhY2UsIG5vdCBhbiB1bnRydXN0ZWQgbmV0d29yayBw
cm90b2NvbC4NCg0KUTg6IElmIGEgc2lnbmFsIGlzIHBlbmRpbmcsIHdhaXRfZXZlbnRfaW50ZXJy
dXB0aWJsZV90aW1lb3V0IHdpbGwgcmV0dXJuDQotRVJFU1RBUlRTWVMgaW1tZWRpYXRlbHkuIEp1
bXBpbmcgYmFjayB0byBzdGFydF93YWl0IHdpdGhvdXQgcmV0dXJuaW5nIHRvDQp1c2Vyc3BhY2Ug
dG8gaGFuZGxlIHRoZSBzaWduYWwgY3JlYXRlcyBhbiBpbmZpbml0ZSB0aWdodCBsb29wIHRoYXQg
d2lsbA0Kc3RhbGwgdGhlIENQVSBhdCAxMDAlIHVudGlsIHRoZSBoYXJkd2FyZSBjb21wbGV0ZXMu
DQoNCiAgVGhpcyBpcyBpbnRlbnRpb25hbC4gQ2hhbm5lbCBlbmFibGUvZGlzYWJsZSBhcmUgY29u
dHJvbCBwbGFuZQ0KICBvcGVyYXRpb25zIHRoYXQgbXVzdCBjb21wbGV0ZSBvciB0aW1lb3V0IKFY
IGFib3J0aW5nIG1pZC1vcGVyYXRpb24NCiAgZHVlIHRvIGEgc2lnbmFsIHdvdWxkIGxlYXZlIHRo
ZSBjaGFubmVsIGluIGFuIGluY29uc2lzdGVudCBzdGF0ZS4NCiAgVGhlIGxvb3AgZG9lcyBub3Qg
c3BpbjogZWFjaCBpdGVyYXRpb24gc2xlZXBzIGluDQogIHdhaXRfZXZlbnRfaW50ZXJydXB0aWJs
ZV90aW1lb3V0IHVudGlsIGVpdGhlciB0aGUgc2lnbmFsIHJlLWZpcmVzLA0KICB0aGUgY29uZGl0
aW9uIGlzIG1ldCwgb3IgdGhlIHRpbWVvdXQgZXhwaXJlcy4gVGhlIHRpbWVvdXQNCiAgKE1US19E
RkxUX1RSQl9USU1FT1VUKSBndWFyYW50ZWVzIGJvdW5kZWQgZXhlY3V0aW9uLg0KDQpROTogSXMg
dGhlcmUgYSByYWNlIGNvbmRpdGlvbiBiZXR3ZWVuIGNoZWNraW5nIFBPUlRfU19PUEVOIGFuZCBz
ZXR0aW5nIGl0Pw0KSWYgdHdvIHRocmVhZHMgY29uY3VycmVudGx5IG9wZW4gdGhlIHNhbWUgcG9y
dCwgdGhleSBtaWdodCBib3RoIHJlYWQgdGhlDQpiaXQgYXMgY2xlYXIgYW5kIHByb2NlZWQgd2l0
aCBpbml0aWFsaXphdGlvbi4gQ291bGQgdGVzdF9hbmRfc2V0X2JpdCBiZQ0KdXNlZD8NCg0KICBB
bGwgY2FsbGVycyBvZiBtdGtfcG9ydF9jb21tb25fb3BlbiBhY3F1aXJlIHBvcnRfbW5ncl9ncnBf
bXR4IHZpYQ0KICBtdGtfcG9ydF9nZXRfbG9ja2VkIGJlZm9yZSBjYWxsaW5nIHRoaXMgZnVuY3Rp
b24sIHdoaWNoIHNlcmlhbGl6ZXMNCiAgY29uY3VycmVudCBvcGVuIGF0dGVtcHRzIG9uIHRoZSBz
YW1lIHBvcnQuIFRoZSB0ZXN0X2JpdC9zZXRfYml0DQogIHNlcXVlbmNlIGlzIHByb3RlY3RlZCBi
eSB0aGUgbXV0ZXguDQoNClExMDogSWYgbXRrX3BvcnRfY29tbW9uX29wZW4gZmFpbHMsIHRoZSBw
b3J0IHJlZmVyZW5jZSBpcyBkcm9wcGVkIHZpYQ0KbXRrX3BvcnRfcHV0X2xvY2tlZCwgYnV0IHRo
ZSBwb2ludGVyIGl0c2VsZiBpcyBub3Qgc2V0IHRvIE5VTEwgYmVmb3JlDQpqdW1waW5nIHRvIG91
dC4gVGhpcyBjYXVzZXMgdGhlIGZ1bmN0aW9uIHRvIHJldHVybiBhbiB1bi1yZWZjb3VudGVkLA0K
aW52YWxpZCBwb3J0IHBvaW50ZXIuDQoNCiAgVmFsaWQuIEZpeGVkIGluIHYzIGJ5IGFkZGluZyBw
b3J0ID0gTlVMTCBhZnRlciBtdGtfcG9ydF9wdXRfbG9ja2VkKCkNCiAgaW4gdGhlIGVycm9yIHBh
dGguDQoNClExMTogSWYgbXRrX2NsZG1hX3N1Ym1pdF90eCBmYWlscyB3aXRoIGEgZmF0YWwgZXJy
b3IgKGxpa2UgLUVJTlZBTCksIHRoZQ0KZXJyb3IgcGF0aCBicmVha3Mgb3V0IG9mIHRoZSBzd2l0
Y2ggd2l0aG91dCB1bmxpbmtpbmcgdGhlIFNLQiBmcm9tDQpza2JfbGlzdCBhbmQgd2l0aG91dCBz
aWduYWxpbmcgY29tcGxldGlvbi4gV2lsbCB0aGUgbmV4dCBwcm9jZXNzaW5nIGxvb3ANCnJldHJp
ZXZlIHRoZSBleGFjdCBzYW1lIGZhaWxpbmcgU0tCIHdpdGggc2tiX3BlZWsgYW5kIGluZmluaXRl
bHkgcmVwZWF0DQp0aGUgZmFpbHVyZT8NCg0KICBWYWxpZC4gRml4ZWQgaW4gdjMgYnkgcmVzdG9y
aW5nIHNrYl91bmxpbmsgKyB0cmJfY29tcGxldGUgZm9yDQogIG5vbi1FQUdBSU4gZXJyb3JzIGlu
IHRoZSBUWCBwYXRoLg0KDQpUaGFua3MuDQoNCg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KVGhpcyBtZXNzYWdlIG1heSBjb250YWluIGluZm9ybWF0aW9u
IHdoaWNoIGlzIHByaXZhdGUsIHByaXZpbGVnZWQgb3IgY29uZmlkZW50aWFsIG9mIENvbXBhbCBF
bGVjdHJvbmljcywgSW5jLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IG9m
IHRoaXMgbWVzc2FnZSwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGFuZCBkZXN0cm95L2RlbGV0
ZSB0aGUgbWVzc2FnZS4gQW55IHJldmlldywgcmV0cmFuc21pc3Npb24sIGRpc3NlbWluYXRpb24g
b3Igb3RoZXIgdXNlIG9mLCBvciB0YWtpbmcgb2YgYW55IGFjdGlvbiBpbiByZWxpYW5jZSB1cG9u
IHRoaXMgaW5mb3JtYXRpb24sIGJ5IHBlcnNvbnMgb3IgZW50aXRpZXMgb3RoZXIgdGhhbiB0aGUg
aW50ZW5kZWQgcmVjaXBpZW50IGlzIHByb2hpYml0ZWQuDQo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09DQo=

