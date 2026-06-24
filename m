Return-Path: <netdev+bounces-301587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4a83OByiO2p+aggAu9opvQ
	(envelope-from <netdev+bounces-301587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:23:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CE46BCE73
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:23:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=compal.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301587-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301587-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C2F73002B53
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8223AB277;
	Wed, 24 Jun 2026 09:23:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef21.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5EC128816;
	Wed, 24 Jun 2026 09:23:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293014; cv=none; b=HYZp4/noym+d6tmdkmA+0JXWZu2TcKvALGl2FG9y2dGdXnqxX8zL305wCOdS551Wrd+iKteJ5LyJmll7z3z9FbCHOPBBQCvSfIVJKb7eK/mLYSaZdYk2LgBvb31wt0ojTtJ1nog0IlrfQ7GuEs650Lak8/W0azJWN3KDCkC1jLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293014; c=relaxed/simple;
	bh=kfmN/299C8z5pYoTv1sCTVlcVcwsAboyJ8CkJhyGSxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1sTS2tNFB6MNcNCml5JZvOphEsDP872VDt7nZPY/uwny9GWbJvAw+JxwQtNKOel+GerC1Kxx1wXOJQNZymBx1q6oqjb2pqzpvkpiWcC3d4uUC+soaEQutYltZ/xsll5KQ1STaMZLtamzGHPYUegxbGbGdjneSqwOR4GdwISDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
X-UUID: 5843a7606fae11f1b2470fb4f881575f-20260624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:c8ddd946-1994-480e-bdd2-fbb4fd2d7791,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e276073,CLOUDID:61ffc9fc-4e5b-4880-a751-e09c9abb260d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|110|111|836|865|888|898
	,TC:-5,Content:0|15|50,EDM:1,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5843a7606fae11f1b2470fb4f881575f-20260624
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef21.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1490156709; Wed, 24 Jun 2026 17:23:22 +0800
X-UUID: 554249686fae11f1b328fd8a884f4420-20260624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:3e49c427-2562-4786-a639-9c291c1f9cca,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e276073,CLOUDID:bf8e6dd2-3d7e-4517-903d-51a0446bfbb1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|110|111|836|865|888|898
	,TC:-5,Content:0|15|50,EDM:1,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 554249686fae11f1b328fd8a884f4420-20260624
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 1212262690; Wed, 24 Jun 2026 17:23:17 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 24 Jun 2026 17:23:15 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69%11]) with mapi id
 15.02.2562.029; Wed, 24 Jun 2026 17:23:15 +0800
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
Subject: RE: [External Mail] [PATCH v2 5/7] net: wwan: t9xx: Add FSM thread
Thread-Topic: [External Mail] [PATCH v2 5/7] net: wwan: t9xx: Add FSM thread
Thread-Index: AQHc+MXDUpehNtGBGUClc7qxhLutgrZNhA86
Date: Wed, 24 Jun 2026 09:23:15 +0000
Message-ID: <8a93c44a3b214cc68c95997b6035252d@compal.com>
References: <20260610-t9xx_driver_v1-v2-0-c65addf23b3f@compal.com>,<20260610-t9xx_driver_v1-v2-5-c65addf23b3f@compal.com>
In-Reply-To: <20260610-t9xx_driver_v1-v2-5-c65addf23b3f@compal.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30026.005
x-tm-as-result: No-10--16.388200-8.000000
x-tmase-matchedrid: UNEQujRoVJIuv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZnw0
	UcwaiWo2OEjNu/JAa11YsTeqDGqRggCyCXo9mCokAszeqtinEnv9jl71CJrVKa5QnhHrCc3s2k7
	b7QdK9/zylwn5FDK7tSu1vClmM6mxn7qYOAYs56VSU7TOghylTummANIvngmRD9ve31bEcLb1bv
	orSnaVR5CcXQyYa0qJbHROBy5a/VB3KIPvqFihBWtBBLLG9hTaK+QmJASJGWETSooVXiwTRl+NS
	I88aPEVpx1e44xilph+wSlad/nPxBPSDOhTpONbJO58QVRaY2crGV73AsU0Z+EKbxqb5I/nxm18
	36UNMCxUPL7a7MR7U9vzyy5P9WxrghGKOY8A1QWKXsEnE1HIgaBK3DLMYz2EBqY7rJ5Fy/iJybp
	aYXgigYRQ91AWgsHtsjvuTi7pjCZPoSh6GtacW30R968WXL3fwJqiTQow4DZyVJSqhMFT9S61xV
	tosjiyZGhNQ3tl+tJXq3MAX+jFwaPN2CXhNI5hlJ0glPWhUZ2OmNylh2VEBxskT01fdi+v/xsVJ
	M4GjliZA9Hez0VXZaRG6r2Kd06R0VJ6kb0BrXIyYhVjrk9k7xUk9SpeetB1c/iaMMsH3GnPNYF/
	wtwB1fUkThHTqPNyAA5uL0s/dleXndXZSdHmc0gfObGUdKnYnVW5D6U48fea0bdgqtu5hMIQ0L0
	571cTaVbxHU94+rt4mNn28Kz2yoMtImFPWUGf98pvHsX7ODj+tgknJCA8VaDdlaiSklndYtsGA1
	MBOo7alQVcER5uM2nd+N2u8/JYJbv4HibF1SgRLjqoJJt/9fmA1kk/6T8voli4ZoiOHT8g4pZYx
	slhbbNkeEYGbJYuA/3R8k/14e0=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--16.388200-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30026.005
x-tm-snts-smtp: 90B5FD0A1211B2BAE8714A0291F359F462D21A5995D0C82E37271AF0212823F62000:8
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301587-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:JackBB_Wu@compal.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org,compal.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,compal.com:mid,compal.com:from_mime];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08CE46BCE73

SGkgSmFrdWIsDQoNCkFkZHJlc3Npbmcgc2FzaGlrbyBBSSBjb2RlIHJldmlldyBjb21tZW50cyBm
b3IgdGhpcyBwYXRjaCwgYXMNCnJlcXVlc3RlZCBieSB5b3UgaW4gdGhlIHBhdGNoIDMvNyByZXZp
ZXc6DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBmL3BhdGNo
LzIwMjYwNjEwLXQ5eHhfZHJpdmVyX3YxLXYyLTMtYzY1YWRkZjIzYjNmQGNvbXBhbC5jb20vIzI3
MDA2MDg4DQoNClExOiBXaWxsIHRoaXMgY29tcGlsZSBvbiBzdGFuZGFyZCBjb21waWxlcnM/IFRo
ZSBjb250YWluZXJfb2YgbWFjcm8gcmVsaWVzDQpvbiBvZmZzZXRvZiwgd2hpY2ggcmVxdWlyZXMg
YW4gaW50ZWdlciBjb25zdGFudCBleHByZXNzaW9uLiBFdmFsdWF0aW5nDQpoc19pbmZvLT5pZCBk
eW5hbWljYWxseSBhdCBydW50aW1lIHdpbGwgY2F1c2UgYSBjb21waWxhdGlvbiBlcnJvci4NCg0K
ICBUaGlzIGNvbXBpbGVzIGNvcnJlY3RseS4gVGhlIExpbnV4IGtlcm5lbCdzIGNvbnRhaW5lcl9v
ZiB1c2VzDQogIF9fYnVpbHRpbl9vZmZzZXRvZiAoR0NDIGV4dGVuc2lvbiksIHdoaWNoIHN1cHBv
cnRzIHZhcmlhYmxlIGFycmF5DQogIGluZGljZXMuIEdDQyBhbmQgQ2xhbmcgYm90aCBnZW5lcmF0
ZSBydW50aW1lIG9mZnNldCBjYWxjdWxhdGlvbg0KICBjb2RlIGZvciBjb250YWluZXJfb2YocHRy
LCB0eXBlLCBtZW1iZXJbdmFyaWFibGVfaW5kZXhdKS4gVGhpcw0KICBwYXR0ZXJuIGlzIHVzZWQg
aW4gbXVsdGlwbGUgcGxhY2VzIGluIHRoZSBrZXJuZWwuDQoNClEyOiBDb3VsZCB0aGlzIHJlc3Vs
dCBpbiBhIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZT8gSWYgdGhlIGRldmljZSBzZW5kcw0KbXVs
dGlwbGUgQ1RSTF9NU0dfSFMyIG1lc3NhZ2VzLCB0aGUgc2Vjb25kIG1lc3NhZ2Ugb3ZlcndyaXRl
cyB0aGUgc2tiDQpwb2ludGVyLiBXaGVuIHRoZSBmaXJzdCBldmVudCBpcyBwcm9jZXNzZWQsIGl0
IGZyZWVzIHRoZSBza2IgYW5kIHNldHMNCmhzX2luZm8tPnJ0X2RhdGEgdG8gTlVMTCwgY2F1c2lu
ZyBhIGRlcmVmIG9uIHRoZSBzZWNvbmQgZXZlbnQuDQoNCiAgVGhpcyBjYW5ub3QgaGFwcGVuIGlu
IHByYWN0aWNlLiBUaGUgaGFuZHNoYWtlIGZvbGxvd3MgYSBzdHJpY3QNCiAgSFMxIC0+IEhTMiAt
PiBIUzMgc2VxdWVuY2UuIFRoZSBNSENDSUYgY2hhbm5lbCBpbnRlcnJ1cHQgaXMgbWFza2VkDQog
IGluIG10a19mc21faHMxX2hhbmRsZXIoKSBiZWZvcmUgdGhlIEZTTSBldmVudCBpcyBzdWJtaXR0
ZWQsDQogIHByZXZlbnRpbmcgZHVwbGljYXRlIEhTMiBub3RpZmljYXRpb25zLiBPbmx5IG9uZSBI
UzIgbWVzc2FnZSBpcw0KICBleHBlY3RlZCBwZXIgaGFuZHNoYWtlIGN5Y2xlLg0KDQpRMzogQ2Fu
IHRoaXMgcmVhZCBwYXN0IHRoZSBlbmQgb2YgdGhlIHBhY2tldD8gV2UgcGFzcyBydGZ0X2VudHJ5
LT5kYXRhIHRvDQp0aGUgYWN0aW9uIGNhbGxiYWNrIGJlZm9yZSBjaGVja2luZyBpZiBydGZ0X2Vu
dHJ5LT5kYXRhX2xlbiBmaXRzIHdpdGhpbg0KdGhlIHJlbWFpbmluZyBwYWNrZXQgbGVuZ3RoLg0K
DQogIFRoZSBib3VuZHMgY2hlY2sgYXQgdGhlIGxvb3Agc3RhcnQgZW5zdXJlcyB0aGUgcnRmdF9l
bnRyeSBzdHJ1Y3QNCiAgaGVhZGVyIGlzIHdpdGhpbiBib3VuZHMuIFRoZSBhY3Rpb24gZnVuY3Rp
b25zIG9ubHkgcmVhZCBmaXhlZC1zaXplDQogIGZpZWxkcyAoZS5nLiwgYSBzaW5nbGUgX19sZTMy
IGZvciBwYWNrZXQgcGFkZGluZyBtb2RlKS4gVGhlIG1vZGVtDQogIGZpcm13YXJlIGlzIGEgdHJ1
c3RlZCBzb3VyY2UgoVggdGhlIGZlYXR1cmUgcXVlcnkgcHJvdG9jb2wgdXNlcw0KICBoZWFkX3Bh
dHRlcm4vdGFpbF9wYXR0ZXJuIGludGVncml0eSBjaGVja3MsIGFuZCB0aGUgbWVzc2FnZSBmb3Jt
YXQNCiAgaXMgZ3VhcmFudGVlZCBieSB0aGUgbW9kZW0gZmlybXdhcmUuDQoNClE0OiBDb3VsZCB0
aGlzIHJlc3VsdCBpbiB1bmFsaWduZWQgbWVtb3J5IGFjY2Vzc2VzIG9uIHRoZSBuZXh0IGxvb3AN
Cml0ZXJhdGlvbj8gU2luY2UgZGF0YV9sZW4gaXMgbm90IHZlcmlmaWVkIHRvIGJlIGEgbXVsdGlw
bGUgb2YgNCwgdGhlDQpuZXh0IHJ0ZnRfZW50cnkgY291bGQgYmUgbWlzYWxpZ25lZC4NCg0KICBP
biB4ODYgKHRoZSB0YXJnZXQgcGxhdGZvcm0gZm9yIHRoaXMgUENJZSBXV0FOIG1vZGVtKSwgdW5h
bGlnbmVkDQogIG1lbW9yeSBhY2Nlc3MgaXMgaGFuZGxlZCBuYXRpdmVseSB3aXRob3V0IHRyYXBz
LiBUaGUgZmVhdHVyZSBxdWVyeQ0KICBlbnRyaWVzIGZyb20gdGhlIG1vZGVtIGZpcm13YXJlIGFy
ZSBhbHdheXMgbmF0dXJhbGx5IGFsaWduZWQgaW4NCiAgcHJhY3RpY2UgKGRhdGFfbGVuIGlzIGFs
d2F5cyBhIG11bHRpcGxlIG9mIDQgZm9yIHRoZSBkZWZpbmVkDQogIGZlYXR1cmUgdHlwZXMpLg0K
DQpRNTogRG9lcyB0aGlzIGNvZGUgZW5zdXJlIHRoZSBwYWNrZXQgaXMgbG9uZyBlbm91Z2ggYmVm
b3JlIHBhcnNpbmcgdGhlDQpmZWF0dXJlIHF1ZXJ5PyBJdCBjYXN0cyBhbmQgcmVhZHMgZnRfcXVl
cnkgZmllbGRzIHdpdGhvdXQgdmVyaWZ5aW5nIGlmDQpoc19pbmZvLT5ydF9kYXRhX2xlbiBpcyBs
YXJnZSBlbm91Z2ggdG8gaG9sZCBhIGZlYXR1cmVfcXVlcnkgc3RydWN0dXJlLg0KDQogIFRoZSBT
S0IgaXMgcmVjZWl2ZWQgZnJvbSB0aGUgQ0xETUEgUlggcGF0aCB3aXRoIHZhbGlkYXRlZCBsZW5n
dGguDQogIEFmdGVyIHNrYl9wdWxsLCB0aGUgcmVtYWluaW5nIGRhdGEgaXMgdGhlIGZlYXR1cmUg
cXVlcnkgcGF5bG9hZC4NCiAgVGhlIGhlYWQvdGFpbCBwYXR0ZXJuIGNoZWNrIGltbWVkaWF0ZWx5
IGZvbGxvd2luZyB0aGlzIGNhc3QNCiAgdmFsaWRhdGVzIHRoZSBtZXNzYWdlIGludGVncml0eS4g
QSB0cnVuY2F0ZWQgbWVzc2FnZSB3b3VsZCBmYWlsIHRoZQ0KICBwYXR0ZXJuIGNoZWNrIGFuZCB0
YWtlIHRoZSBlcnJvciBwYXRoLg0KDQpRNjogSXMgdGhlcmUgYSByaXNrIG9mIGFjY2Vzc2luZyB1
bmluaXRpYWxpemVkIG1lbW9yeSBoZXJlPyBJZiB0aGUgc2tiIGlzDQpmcmFnbWVudGVkLCBjaGVj
a2luZyBza2ItPmxlbiBpcyBub3Qgc3VmZmljaWVudC4gV2Ugc2hvdWxkIHVzZQ0KcHNrYl9tYXlf
cHVsbCgpIGJlZm9yZSBjYXN0aW5nIGFuZCBhY2Nlc3Npbmcgc2tiLT5kYXRhLg0KDQogIFRoZSBS
WCBTS0JzIGFyZSBhbGxvY2F0ZWQgaW50ZXJuYWxseSBieSB0aGUgQ0xETUEgZHJpdmVyIHVzaW5n
DQogIF9fZGV2X2FsbG9jX3NrYiB3aXRoIGxpbmVhciBidWZmZXJzLiBUaGUgQ0NDSSBoZWFkZXIg
YW5kIGNvbnRyb2wNCiAgbWVzc2FnZSBkYXRhIGFsd2F5cyByZXNpZGUgaW4gdGhlIGNvbnRpZ3Vv
dXMgbGluZWFyIGRhdGEgcmVnaW9uLg0KICBUaGVzZSBTS0JzIGFyZSBub3QgcmVjZWl2ZWQgZnJv
bSB0aGUgbmV0d29yayBzdGFjayBhbmQgYXJlIGFsd2F5cw0KICBsaW5lYXIsIHNvIHBza2JfbWF5
X3B1bGwgaXMgbm90IG5lZWRlZC4NCg0KUTc6IERvZXMgdGhpcyBpbnRyb2R1Y2UgYSBsZWFrIGlm
IHRoZSBkZXZpY2Ugc2VuZHMgbXVsdGlwbGUgbWVzc2FnZXMNCnJhcGlkbHk/IE92ZXJ3cml0aW5n
IGhzX2luZm8tPnJ0X2RhdGEgZGlzY2FyZHMgdGhlIHByZXZpb3VzIHNrYiBwb2ludGVyDQp3aXRo
b3V0IGZyZWVpbmcgaXQuDQoNCiAgU2FtZSBhcyBRMi4gVGhlIGhhbmRzaGFrZSBpcyBhIHN0cmlj
dCBIUzEgLT4gSFMyIC0+IEhTMyBzZXF1ZW5jZQ0KICB3aXRoIHRoZSBNSENDSUYgY2hhbm5lbCBt
YXNrZWQgYWZ0ZXIgSFMxLiBPbmx5IG9uZSBIUzIgbWVzc2FnZQ0KICBhcnJpdmVzIHBlciBoYW5k
c2hha2UgY3ljbGUuIE5vIG92ZXJ3cml0ZSBjYW4gb2NjdXIuDQoNClE4OiBEb2VzIHRoaXMgcGVy
bWFuZW50bHkgaGFuZyB0aGUgZGV2aWNlIGluaXRpYWxpemF0aW9uPyBUaGUgaW50ZXJydXB0IGlz
DQptYXNrZWQgYW5kIGNsZWFyZWQgYXQgdGhlIGJlZ2lubmluZy4gSWYgdGhlIGRldmljZSBzdGFn
ZSBpcyBub3QNCkRFVl9TVEFHRV9JRExFLCB3ZSByZXR1cm4gd2l0aG91dCB1bm1hc2tpbmcuDQoN
CiAgVGhlIGVhcmx5X2Jvb3R1cF9oYW5kbGVyIGlzIHJlZ2lzdGVyZWQgZm9yIHRoZSBCT09UX0ZM
T1dfU1lOQw0KICBNSENDSUYgZXZlbnQuIFRoZSBNVEsgbW9kZW0gZmlybXdhcmUgc2VuZHMgdGhp
cyBldmVudCBvbmNlLCBvbmx5DQogIHdoZW4gdGhlIG1vZGVtIHJlYWNoZXMgSURMRSBzdGFnZS4g
VGhlIG5vbi1JRExFIGNvZGUgcGF0aCBoYW5kbGVzDQogIHVuZXhwZWN0ZWQgc3RhdGVzIGRlZmVu
c2l2ZWx5IKFYIG1hc2tpbmcgcHJldmVudHMgc3B1cmlvdXMgaW50ZXJydXB0cw0KICBmcm9tIGFu
IGVycm9yIHN0YXRlLiBUaGUgbm9ybWFsIGJvb3QgZmxvdyBhbHdheXMgcmVhY2hlcyBJRExFDQog
IGJlZm9yZSBzZW5kaW5nIEJPT1RfRkxPV19TWU5DLg0KDQpROTogQ2FuIGNvbmN1cnJlbnQgbW9k
aWZpY2F0aW9ucyBjb3JydXB0IHRoZSBsaXN0IHRyYXZlcnNhbD8gRXh0ZXJuYWwNCm1vZHVsZXMg
Y2FuIGNhbGwgbXRrX2ZzbV9ub3RpZmllcl9yZWdpc3RlcigpIHRvIG1vZGlmeSB0aGVzZSBsaXN0
cw0KY29uY3VycmVudGx5IHdpdGggRlNNIHRocmVhZCBpdGVyYXRpb24uDQoNCiAgVGhlIG5vdGlm
aWVyIHJlZ2lzdHJhdGlvbiBhbmQgdW5yZWdpc3RyYXRpb24gYXJlIG9ubHkgY2FsbGVkIGR1cmlu
Zw0KICBkcml2ZXIgcHJvYmUgYW5kIHJlbW92ZSBwYXRocywgd2hpY2ggYXJlIHNlcmlhbGl6ZWQg
YnkgdGhlIGRyaXZlcg0KICBtb2RlbC4gVGhlIEZTTSBrdGhyZWFkIGRvZXMgbm90IHN0YXJ0IHBy
b2Nlc3NpbmcgZXZlbnRzIHVudGlsIHByb2JlDQogIGNvbXBsZXRlcywgc28gdGhlcmUgaXMgbm8g
Y29uY3VycmVudCBhY2Nlc3MgdG8gdGhlIG5vdGlmaWVyIGxpc3RzDQogIGJldHdlZW4gcmVnaXN0
cmF0aW9uIGFuZCB0cmF2ZXJzYWwuDQoNClExMDogVGhlc2UgbGlzdHMgYXJlIG1vZGlmaWVkIHdp
dGhvdXQgYW55IGxvY2tpbmcgbWVjaGFuaXNtLCBtZWFuaW5nDQpjb25jdXJyZW50IHJlZ2lzdHJh
dGlvbnMgb3IgaXRlcmF0aW9ucyBjb3VsZCBjcmFzaCB0aGUga2VybmVsLg0KDQogIFNhbWUgYXMg
UTkuIG10a19mc21fbm90aWZpZXJfcmVnaXN0ZXIvdW5yZWdpc3RlciBhcmUgb25seSBjYWxsZWQN
CiAgZnJvbSBwcm9iZS9yZW1vdmUgcGF0aHMsIHNlcmlhbGl6ZWQgYnkgdGhlIGRyaXZlciBtb2Rl
bC4NCg0KUTExOiBJcyBpdCBzYWZlIHRvIGd1ZXNzIHRoZSBjYWxsZXIncyBjb250ZXh0IGxpa2Ug
dGhpcz8gVGhlIGNoZWNrcyBkbyBub3QNCmNhdGNoIGNvbnRleHRzIHdoZXJlIHByZWVtcHRpb24g
aXMgZGlzYWJsZWQgYnkgYSBzdGFuZGFyZCBzcGluX2xvY2soKS4NCg0KICBUaGUgaGV1cmlzdGlj
IGlzIHN1ZmZpY2llbnQgZm9yIGFsbCBjdXJyZW50IGNhbGxlcnMuDQogIG10a19mc21fZXZ0X3N1
Ym1pdCBpcyBjYWxsZWQgZnJvbSBGU00ga3RocmVhZCwgTUhDQ0lGIHdvcmtxdWV1ZQ0KICBjYWxs
YmFjaywgcHJvYmUvcmVtb3ZlIHBhdGhzLCBhbmQgQ0xETUEgd29ya3F1ZXVlIGNhbGxiYWNrcyCh
WCBhbGwNCiAgcHJvY2VzcyBjb250ZXh0LCBub25lIGhvbGRpbmcgc3BpbmxvY2tzLiBUaGUgaW5f
aGFyZGlycS9pbl9zb2Z0aXJxLw0KICBpcnFzX2Rpc2FibGVkIGNoZWNrcyBjb3ZlciB0aGUgYWN0
dWFsIGNhbGxpbmcgY29udGV4dHMuDQoNClExMjogQ291bGQgdGhpcyBsZWFkIHRvIGEgTlVMTCBw
b2ludGVyIGRlcmVmZXJlbmNlPyB3YWtlX3VwX3Byb2Nlc3MoKSBpcw0KcGVyZm9ybWVkIG91dHNp
ZGUgdGhlIGxvY2suIElmIG10a19mc21fZXhpdCgpIHN0b3BzIHRoZSB0aHJlYWQgYW5kIHNldHMN
CmZzbS0+ZnNtX2hhbmRsZXIgdG8gTlVMTCBjb25jdXJyZW50bHkuDQoNCiAgVGhpcyByYWNlIGNh
bm5vdCBvY2N1ci4gbXRrX2ZzbV9leGl0KCkgaXMgY2FsbGVkIGR1cmluZyB0aGUgZGV2aWNlDQog
IHJlbW92ZSBzZXF1ZW5jZSwgd2hpY2ggZmlyc3Qgc3VibWl0cyBhIEZTTV9FVlRfREVWX1JNIGV2
ZW50LiBUaGUNCiAgRlNNIGt0aHJlYWQgcHJvY2Vzc2VzIHRoaXMgZXZlbnQgdmlhIG10a19mc21f
ZGV2X3JtX2FjdCgpLCB3aGljaA0KICBzZXRzIEVWVF9URl9HQVRFQ0xPU0VEIHVuZGVyIGV2dHFf
bG9jay4gT25seSBhZnRlciB0aGUga3RocmVhZA0KICBmaW5pc2hlcyBkb2VzIG10a19mc21fZXhp
dCgpIHByb2NlZWQgdG8gY2FsbCBrdGhyZWFkX3N0b3AoKSBhbmQNCiAgc2V0IGZzbV9oYW5kbGVy
IHRvIE5VTEwuIFRoZSBFVlRfVEZfR0FURUNMT1NFRCBjaGVjayBpbnNpZGUgdGhlDQogIHNwaW5s
b2NrIHByb3ZpZGVzIG9yZGVyaW5nIGd1YXJhbnRlZS4NCg0KUTEzOiBDYW4gdGhpcyBsb29wIGVu
ZGxlc3NseSBpZiBhIHNpZ25hbCBpcyBjb250aW51b3VzbHkgZGVsaXZlcmVkPyBTaW5jZQ0KdGhp
cyByZXNldHMgdGhlIHRpbWVyIHRvIHRoZSBmdWxsIE1US19ERkxUX1RSQl9USU1FT1VUIGV2ZXJ5
IHRpbWUsIGENCnN0cmVhbSBvZiBzaWduYWxzIG1pZ2h0IHRyYXAgdGhlIHRhc2sgaW4gYW4gaW5m
aW5pdGUgbG9vcC4NCg0KICBUaGlzIGlzIGludGVudGlvbmFsLiBDaGFubmVsIGVuYWJsZS9kaXNh
YmxlIGFyZSBjb250cm9sIHBsYW5lDQogIG9wZXJhdGlvbnMgdGhhdCBtdXN0IGNvbXBsZXRlIG9y
IHRpbWVvdXQuIEVhY2ggaXRlcmF0aW9uIHNsZWVwcyBpbg0KICB3YWl0X2V2ZW50X2ludGVycnVw
dGlibGVfdGltZW91dCChWCBub3QgYSBidXN5IGxvb3AuIFRoZSB0aW1lb3V0DQogIGd1YXJhbnRl
ZXMgYm91bmRlZCBwZXItaXRlcmF0aW9uIGV4ZWN1dGlvbi4gVGhlIHRvdGFsIHdhaXQgdGltZSBt
YXkNCiAgZXhjZWVkIGEgc2luZ2xlIHRpbWVvdXQgd2l0aCBjb250aW51b3VzIHNpZ25hbHMsIGJ1
dCB0aGUgb3BlcmF0aW9uDQogIGV2ZW50dWFsbHkgY29tcGxldGVzIG9yIHRpbWVzIG91dC4NCg0K
UTE0OiBEb2VzIHRoaXMgY29kZSBzaWxlbnRseSBpZ25vcmUgaW50ZXJydXB0IHJlZ2lzdHJhdGlv
biBmYWlsdXJlcz8gVGhlDQpyZXR1cm4gdmFsdWUgb2YgbXRrX3BjaV9yZWdpc3Rlcl9pcnEoKSBp
cyBub3QgY2hlY2tlZCwgYW5kIHRoZSBjbGVhbnVwDQpvcGVyYXRpb25zIGJlbG93IHRoZSByZXR1
cm4gc3RhdGVtZW50IGFyZSB1bnJlYWNoYWJsZSBkZWFkIGNvZGUuDQoNCiAgVmFsaWQuIEZpeGVk
IGluIHYzIGJ5IGNoZWNraW5nIHRoZSByZXR1cm4gdmFsdWUgYW5kIGFkZGluZyBhbg0KICBlcnJf
ZGVzdHJveV93cSBlcnJvciBsYWJlbC4gQWxzbyBwcm9wYWdhdGVkIHNwZWNpZmljIGVycm9yIGNv
ZGVzDQogIGZyb20gYWxsIGVycm9yIHBhdGhzLg0KDQpRMTU6IERvZXMgdGhpcyBsZWFrIHRoZSBo
ZWFkIFNLQiB3aGVuIG9wZXJhdGluZyBpbiBzY2F0dGVyLWdhdGhlciBtb2RlPyBJZg0KcnhxLT5u
cl9iZHMgPiAwLCB0aGUgZnJhZ19saXN0IGlzIGRldGFjaGVkIGJ1dCB0aGUgaGVhZCBTS0IgaXRz
ZWxmIGlzDQpuZXZlciBmcmVlZCBiZWNhdXNlIGRldl9rZnJlZV9za2JfYW55KHJlcS0+c2tiKSBp
cyBpbnNpZGUgdGhlIGVsc2UgYmxvY2suDQoNCiAgVmFsaWQuIEZpeGVkIGluIHYzIGJ5IGFkZGlu
ZyBkZXZfa2ZyZWVfc2tiX2FueShyZXEtPnNrYikgYWZ0ZXINCiAgZGV0YWNoaW5nIGZyYWdfbGlz
dCBpbiBTRyBtb2RlLg0KDQpUaGFua3MuDQoNCg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
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

