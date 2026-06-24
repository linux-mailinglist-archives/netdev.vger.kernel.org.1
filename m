Return-Path: <netdev+bounces-301590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j8eSHDmkO2r8aggAu9opvQ
	(envelope-from <netdev+bounces-301590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:32:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4D86BCF83
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:32:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=compal.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301590-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301590-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5B253002D44
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945563A6407;
	Wed, 24 Jun 2026 09:30:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from tpecef22.compal.com (exmail3.compal.com [59.120.207.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7EA3A1690;
	Wed, 24 Jun 2026 09:30:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293444; cv=none; b=frmiNw6q/7C3z8k/eR/0ijua5srbAXk5qiJb285nevYDbH2NS5AeOnJXL2R/EgNN35odGZXQZiTcITp5BZawq8G3tBL3Pn1CUCjjfcbtB4OeW46KC52EmBMOZj2Q/6b3Wo4Owxue9XkDxPvceZ9blGlmM2Ds3fjxlqeolBkw5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293444; c=relaxed/simple;
	bh=ZZdtNcnDDlKi9QHrunch6tAKD2Nv7CxfhvHfQhf+rfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iOIRK9YIvWA8bEnZcX1X6J9tDEP3OvDdSExqvN6wNAh1gDb6ZmZO6PKYt4NhQQKW9DLtodcNy0Mp4LOC8eTD9WrePOpqtaD0iMoEoPb1kIq3U9kGuKv2j7rDyNVtF0S5ddnlQVNBvlyPWhTkWhyJg4d4lOe6k8GfKB8xZHOlFVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.com; spf=pass smtp.mailfrom=compal.com; arc=none smtp.client-ip=59.120.207.196
X-UUID: 3b5187e06fad11f1a87c2323a98e90a4-20260624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:77f45f54-fe48-4f3c-b870-6b1d88069d30,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e276073,CLOUDID:8087a93c-489f-48c4-98f5-32539a8b9e49,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|110|111|836|865|888|898
	,TC:-5,Content:0|15|50,EDM:1,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3b5187e06fad11f1a87c2323a98e90a4-20260624
Received: from sdmg11.sdbg.compal.com [(10.113.168.9)] by tpecef22.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 92006216; Wed, 24 Jun 2026 17:15:24 +0800
X-UUID: 3939e8c66fad11f1b328fd8a884f4420-20260624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:4f772978-ab14-4765-ae49-3b5c50cea5dc,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e276073,CLOUDID:50997045-d8c0-4c26-a341-e1551eb7b06d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|110|111|836|865|888|898
	,TC:-5,Content:0|15|50,EDM:1,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3939e8c66fad11f1b328fd8a884f4420-20260624
Received: from sdbmbx11.tpe.compalcomm.com [(10.113.2.135)] by sdmg11.sdbg.compal.com
	(envelope-from <jackbb_wu@compal.com>)
	(Compal Mail Service with TLSv1.2 ECDHE-RSA-AES128-SHA 128/128)
	with ESMTP id 1836422378; Wed, 24 Jun 2026 17:15:20 +0800
Received: from SDBMBX13.tpe.compalcomm.com (10.113.2.137) by
 SDBMBX11.tpe.compalcomm.com (10.113.2.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 24 Jun 2026 17:15:18 +0800
Received: from SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69]) by
 SDBMBX13.tpe.compalcomm.com ([fe80::ea2a:c2b2:8475:8d69%11]) with mapi id
 15.02.2562.029; Wed, 24 Jun 2026 17:15:18 +0800
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
Subject: RE: [External Mail] [PATCH v2 1/7] net: wwan: t9xx: Add PCIe core
Thread-Topic: [External Mail] [PATCH v2 1/7] net: wwan: t9xx: Add PCIe core
Thread-Index: AQHc+MXFozjJprHF60KverIH13pi1LZNgc4V
Date: Wed, 24 Jun 2026 09:15:17 +0000
Message-ID: <b02c0e1e9f0449f2b819197e4329373b@compal.com>
References: <20260610-t9xx_driver_v1-v2-0-c65addf23b3f@compal.com>,<20260610-t9xx_driver_v1-v2-1-c65addf23b3f@compal.com>
In-Reply-To: <20260610-t9xx_driver_v1-v2-1-c65addf23b3f@compal.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30026.005
x-tm-as-result: No-10--10.690100-8.000000
x-tmase-matchedrid: HSR30PgxbmQuv++HU7VXryRFbfQbCufdN0X64jGy2dZJTOxleK2tZnw0
	UcwaiWo2OEjNu/JAa11YsTeqDGqRggCyCXo9mCokAszeqtinEnuUiGLkY8AZ4/+BG7h50oI0Tyj
	cK4KOwYF0pj0BHBZZFrFpMGHx+l5tvP/YNhe09fYsOe36I+IhIefShpTpYz77WCpaeflZJKfVsV
	Z8VII5g1ehjsG69UoBTO6FsqkfPmdkX/UqzfjXHMm2jIZUTQ3wqByXFHB7WqrLwjc+A9vVfYrOC
	FHYUxG59XuNqVIcQil9NGchVJAEwOGiQtsRkA4vQfEHsmyy6QJihlE+FG3PUsaGZ3GOeK8WXEYE
	jVITdFfRgviTYfYmE3a2bWpAUyGmd2vfd3FvH+yq5lUH4/wnRg1CgLnmrwpx0qeVmp5uDF6Vov6
	RUIffFGaB4VbTxx2vdStdKywjutsUm1NPF16gQjxp6GTLsQ5HyiAijCjuVj2jIT1TJ6FKjDIRGZ
	eHNrCPeUwOC8iOD52mbDaBQ1J1xoGPgF12Yg5X/SFb4+LsKiwpSViUCNYhMKIysjVZlzq7P+b5W
	SKqJ6ssee3t7Xiv0XiEq6UJihBeEF7zEdad4202eDSq/07Mx+9t4soC0O2GnShaEOK0qMs2Uc0K
	Mx9WkQgT89EVEGIQi7tz6ILeijWZd6OkvSXQQyT5U3lJ4T8KOfEmq6feyfMX6nfwyd2cmu6xG0H
	9n3ROfKBhG2JWA1PYCpWcHAZE3neSbCanzbx1NvN4wScFNxSHIC6C8y53Bw==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--10.690100-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30026.005
x-tm-snts-smtp: 6852C78FF14D99A072C89397F28863BA4AC0A3522082490C7F4D0766E9CD781D2000:8
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
	TAGGED_FROM(0.00)[bounces-301590-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:JackBB_Wu@compal.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org,compal.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[JackBB_Wu@compal.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[compal.com:mid,compal.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF4D86BCF83

SGkgSmFrdWIsDQoNCkFkZHJlc3Npbmcgc2FzaGlrbyBBSSBjb2RlIHJldmlldyBjb21tZW50cyBm
b3IgdGhpcyBwYXRjaCwgYXMNCnJlcXVlc3RlZCBieSB5b3UgaW4gdGhlIHBhdGNoIDMvNyByZXZp
ZXc6DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBmL3BhdGNo
LzIwMjYwNjEwLXQ5eHhfZHJpdmVyX3YxLXYyLTMtYzY1YWRkZjIzYjNmQGNvbXBhbC5jb20vIzI3
MDA2MDg4DQoNClExOiBEb2VzIHRoaXMgY29kZSBwZXJmb3JtIGFuIGluY29ycmVjdCBkb3VibGUg
Ynl0ZS1zd2FwIG9uIGJpZy1lbmRpYW4NCmFyY2hpdGVjdHVyZXM/IFRoZSBoYXJkd2FyZSBiaXRz
IGFyZSBtYW51YWxseSBzd2FwcGVkIHVzaW5nIGNwdV90b19sZTMyKCkNCmFuZCBjYXN0IGJhY2sg
dG8gdTMyLiBUaGlzIHZhbHVlIGlzIGxhdGVyIHBhc3NlZCB0byBtdGtfcGNpX3dyaXRlMzIoKSwN
CndoaWNoIHV0aWxpemVzIGlvd3JpdGUzMigpLiBTaW5jZSBpb3dyaXRlMzIoKSBpbnRlcm5hbGx5
IGhhbmRsZXMNCmhvc3QtdG8tbGl0dGxlLWVuZGlhbiBjb252ZXJzaW9uLCBzd2FwcGluZyB0aGUg
dmFsdWUgYmVmb3JlaGFuZCB3aWxsIGNhdXNlDQphIGRvdWJsZSBzd2FwIG9uIGJpZy1lbmRpYW4g
cGxhdGZvcm1zLg0KDQogIFRoaXMgZHJpdmVyIHRhcmdldHMgTWVkaWFUZWsgVDl4eCBQQ0llIFdX
QU4gbW9kZW1zLCB3aGljaCBleGlzdA0KICBleGNsdXNpdmVseSBvbiB4ODYgcGxhdGZvcm1zIChs
aXR0bGUtZW5kaWFuKS4gT24gbGl0dGxlLWVuZGlhbiwNCiAgY3B1X3RvX2xlMzIoKSBpcyBhIG5v
LW9wIGFuZCBMRTMyX1RPX1UzMigpIGlzIGEgc2ltcGxlIGNhc3QsIHNvDQogIG5vIGJ5dGUtc3dh
cCBvY2N1cnMuIFRoZSBoYXJkd2FyZSByZWdpc3RlciBsYXlvdXQgYXNzdW1lcyBMRSBob3N0DQog
IG9yZGVyaW5nLiBXaGlsZSB0aGUgcGF0dGVybiBpcyB0ZWNobmljYWxseSBpbmNvcnJlY3QgZm9y
IGJpZy1lbmRpYW4sDQogIHRoaXMgaGFyZHdhcmUgaXMgbm90IGF2YWlsYWJsZSBvbiBCRSBwbGF0
Zm9ybXMgYW5kIHRoZSBLY29uZmlnDQogIGRlcGVuZGVuY3kgKGRlcGVuZHMgb24gUENJKSBjb21i
aW5lZCB3aXRoIHRoZSBkZXZpY2UncyBQQ0llLW9ubHkNCiAgbmF0dXJlIGVmZmVjdGl2ZWx5IHJl
c3RyaWN0cyB0aGlzIHRvIHg4Ni9BUk02NC1MRS4NCg0KUTI6IERvZXMgdGhpcyBjYWxsIHRvIGZm
cygpIHlpZWxkIHRoZSB3cm9uZyBjaGFubmVsIGluZGV4IG9uIGJpZy1lbmRpYW4NCnN5c3RlbXM/
IGh3X2JpdHMgaGFzIGFscmVhZHkgYmVlbiBlbmRpYW4tc3dhcHBlZCBpbg0KbXRrX3BjaV9leHRf
aDJkX2V2dF9od19iaXRzKCkuIFVzaW5nIGZmcygpIG9uIGFuIGVuZGlhbi1zd2FwcGVkIHZhbHVl
DQpwcm9kdWNlcyBhIGNvbXBsZXRlbHkgaW5jb3JyZWN0IGJpdCBpbmRleC4NCg0KICBTYW1lIGFz
IFExIKFYIG9uIGxpdHRsZS1lbmRpYW4gcGxhdGZvcm1zLCBubyBzd2FwIG9jY3Vycywgc28gZmZz
KCkNCiAgb3BlcmF0ZXMgb24gdGhlIGNvcnJlY3QgdmFsdWUuIEFkZGl0aW9uYWxseSwgYWxsIGNh
bGxlcnMgb2YNCiAgbXRrX3BjaV9zZW5kX2V4dF9ldnQoKSBwYXNzIGtub3duLXZhbGlkIGNoYW5u
ZWwgdmFsdWVzIHRocm91Z2ggdGhlDQogIGlzX3Bvd2VyX29mXzIoY2gpIGNoZWNrLCBhbmQgdGhl
IFNFVF9IV19CSVRTIG1hcHBpbmcgY292ZXJzIGFsbA0KICB2YWxpZCBjaGFubmVscy4NCg0KUTM6
IERvZXMgY2xlYXJpbmcgdGhlIHRvcC1sZXZlbCBpbnRlcnJ1cHQgc3RhdHVzIGF0IHRoZSBlbmQg
b2YgdGhlIGhhbmRsZXINCndpdGhvdXQgYSBzdWJzZXF1ZW50IHJlYWQgbG9vcCBsZWFkIHRvIHBl
cm1hbmVudGx5IGxvc3QgaGFyZHdhcmUgZXZlbnRzPw0KSWYgYSBuZXcgaGFyZHdhcmUgZXZlbnQg
dHJpZ2dlcnMgZHVyaW5nIHRoZSB3b3JrZXIncyBleGVjdXRpb24sIGNsZWFyaW5nDQp0aGUgd3Jp
dGUtMS10by1jbGVhciAoVzFDKSBpbnRlcnJ1cHQgc3RhdHVzIGFmdGVyIHRoZSBoYXJkd2FyZSBl
dmVudA0Kc3RhdHVzZXMgd2VyZSByZWFkIGF0IHRoZSBzdGFydCB3aWxsIGRpc2NhcmQgdGhlIG5l
d2x5IGFzc2VydGVkIGV2ZW50cy4NCg0KICBObyBldmVudHMgYXJlIGxvc3QuIG10a19wY2lfY2xl
YXJfaXJxKCkgY2xlYXJzIHRoZSBNU0ktWCBpbnRlcnJ1cHQNCiAgc3RhdHVzIHJlZ2lzdGVyIChC
SVQoaXJxX2lkKSBpbiBSRUdfTVNJWF9JU1RBVFVTX0hPU1RfR1JQMF8wKSwgTk9UDQogIHRoZSBN
SENDSUYgZXZlbnQgcmVnaXN0ZXJzLiBUaGUgTUhDQ0lGIGV2ZW50cyBhcmUgbGV2ZWwtdHJpZ2dl
cmVkDQogIGZyb20gdGhlIG1vZGVtJ3MgRVAyUkMgcmVnaXN0ZXJzIKFYIHRoZSBtb2RlbSBzZXRz
IGV2ZW50IGJpdHMgYW5kDQogIHRoZXkgcmVtYWluIHNldCB1bnRpbCB0aGUgbW9kZW0gY2xlYXJz
IHRoZW0gb3IgdGhlIGhvc3QgYWNrbm93bGVkZ2VzLg0KDQogIFRoZSBmbG93IGlzOg0KICAgIDEu
IEhhcmR3YXJlOiBtb2RlbSBzZXRzIEVQMlJDIGV2ZW50IGJpdHMgLT4gTVNJLVggaW50ZXJydXB0
IGZpcmVzDQogICAgMi4gSVNSOiBtYXNrcyBNU0ktWCBiaXQsIHNjaGVkdWxlcyB3b3JrDQogICAg
My4gV29ya2VyOiByZWFkcyBFUDJSQyBldmVudCBzdGF0dXMsIGRpc3BhdGNoZXMgY2FsbGJhY2tz
DQogICAgNC4gV29ya2VyOiBjbGVhcnMgTVNJLVggc3RhdHVzIChCSVQoaXJxX2lkKSksIHVubWFz
a3MgTVNJLVgNCg0KICBJZiBhIG5ldyBNSENDSUYgZXZlbnQgYXJyaXZlcyBkdXJpbmcgc3RlcCAz
LCB0aGUgRVAyUkMgcmVnaXN0ZXINCiAgZ2V0cyB0aGUgbmV3IGJpdCBzZXQuIFRoZSBNU0ktWCBj
bGVhciBpbiBzdGVwIDQgb25seSBjbGVhcnMgdGhlDQogIE1TSS1YIHBlbmRpbmcgYml0LCBub3Qg
dGhlIE1IQ0NJRiBzb3VyY2UuIEFmdGVyIHVubWFzaywgdGhlIE1IQ0NJRg0KICBldmVudCBzb3Vy
Y2UgcmUtYXNzZXJ0cyB0aGUgTVNJLVggaW50ZXJydXB0IGJlY2F1c2UgdGhlIEVQMlJDIGJpdHMN
CiAgYXJlIHN0aWxsIHNldCwgdHJpZ2dlcmluZyBhIG5ldyBJU1IgLT4gbmV3IHdvcmsgLT4gbmV3
IHJlYWQgb2YgdGhlDQogIHVwZGF0ZWQgRVAyUkMgcmVnaXN0ZXIuDQoNClE0OiBEb2VzIHRoaXMg
Y29kZSBpbmNvcnJlY3RseSBhdHRlbXB0IHRvIHVubWFwIGEgYml0bWFzayBpbnN0ZWFkIG9mIGEN
CnNpbmdsZSBCQVIgaW5kZXg/IE1US19SRVFVRVNURURfQkFSUyBpcyBkZWZpbmVkIGFzIGEgYml0
bWFzaywgYnV0DQpwY2ltX2lvdW5tYXBfcmVnaW9uKCkgZXhwZWN0cyBhIHNwZWNpZmljIEJBUiBp
bmRleC4gRnVydGhlcm1vcmUsIGlzDQp0aGlzIG1hbnVhbCB1bm1hcHBpbmcgcmVkdW5kYW50IHNp
bmNlIHRoZSBtZW1vcnkgd2FzIG1hcHBlZCB3aXRoDQpwY2ltX2lvbWFwX3JlZ2lvbnMoKSBhbmQg
d2lsbCBhdXRvbWF0aWNhbGx5IGJlIGNsZWFuZWQgdXAgYnkgZGV2cmVzPw0KDQogIFZhbGlkIG9u
IGJvdGggcG9pbnRzLiBGaXhlZCBpbiB2MyBieSByZW1vdmluZyBtdGtfcGNpX2Jhcl9leGl0KCkN
CiAgZW50aXJlbHkuIHBjaW1faW9tYXBfcmVnaW9ucygpIGlzIGRldnJlcy1tYW5hZ2VkIHNvIG1h
bnVhbCB1bm1hcA0KICBpcyByZWR1bmRhbnQuDQoNClE1OiBEb2VzIHRoaXMgbG9naWMgbWlzdGFr
ZW5seSBkcm9wIGhhcmR3YXJlIGludGVycnVwdHMgd2hlbiBmZXdlciB0aGFuIDMyDQpNU0ktWCB2
ZWN0b3JzIGFyZSBhbGxvY2F0ZWQ/IElmIGZld2VyIHRoYW4gMzIgdmVjdG9ycyBhcmUgYWxsb2Nh
dGVkDQooZm9yIGV4YW1wbGUsIGlycV9jbnQgPSAxKSwgR0VOTUFTSygwLCAwKSBldmFsdWF0ZXMg
dG8gQklUKDApLiBBDQpoYXJkd2FyZSBpbnRlcnJ1cHQgc291cmNlIGxpa2UgTUhDQ0lGIChiaXQg
MjgpIHdpbGwgcmVzdWx0IGluDQpCSVQoMjgpICYgQklUKDApID09IDAuIENvdWxkIHRoaXMgbGVh
ZCB0byBhIGNvbXBsZXRlIGxvc3Mgb2YgY3JpdGljYWwNCmRldmljZSBldmVudHM/DQoNCiAgTm8g
aXNzdWUuIFRoaXMgaXMgdGhlIE1TSS1YIG1lcmdlZCBtb2RlIGRlc2lnbi4gV2hlbiBmZXdlciB2
ZWN0b3JzDQogIGFyZSBhbGxvY2F0ZWQgdGhhbiBpbnRlcnJ1cHQgc291cmNlcywgbXRrX3BjaV9z
ZXRfbXNpeF9tZXJnZWQoKQ0KICBjb25maWd1cmVzIHRoZSBoYXJkd2FyZSB0byBtZXJnZSBtdWx0
aXBsZSBpbnRlcnJ1cHQgc291cmNlcyBpbnRvDQogIHRoZSBhdmFpbGFibGUgdmVjdG9ycy4gV2l0
aCBpcnFfY250PTEsIHRoZSBoYXJkd2FyZSBtYXBzIEFMTA0KICBpbnRlcnJ1cHQgc291cmNlcyB0
byB2ZWN0b3IgMC4gVGhlIEdFTk1BU0sgZmlsdGVycyB0aGUgaXJxX3N0YXRlDQogIHRvIG9ubHkg
dGhlIGFsbG9jYXRlZCB2ZWN0b3IgYml0cywgdGhlbiBjaGVja3MgaWYgdGhlIGN1cnJlbnQNCiAg
aGFuZGxlcidzIHZlY3RvciBiaXQgaXMgc2V0LiBUaGlzIGNvcnJlY3RseSBoYW5kbGVzIGJvdGgg
ZnVsbA0KICBhbGxvY2F0aW9uICgzMiB2ZWN0b3JzLCAxOjEgbWFwcGluZykgYW5kIG1lcmdlZCBt
b2RlIChmZXdlcg0KICB2ZWN0b3JzLCBOOjEgbWFwcGluZykuDQoNClE2OiBXaWxsIHRoaXMgbWFu
dWFsIHBjaV9kaXNhYmxlX2RldmljZSgpIGNhbGwgdHJpZ2dlciBhbiBhdG9taWMgdW5kZXJmbG93
Pw0KU2luY2UgdGhlIGRldmljZSB3YXMgaW5pdGlhbGl6ZWQgdXNpbmcgcGNpbV9lbmFibGVfZGV2
aWNlKCksIGRldnJlcyB3aWxsDQphdXRvbWF0aWNhbGx5IGRpc2FibGUgdGhlIGRldmljZSBkdXJp
bmcgY2xlYW51cC4gTWFudWFsbHkgY2FsbGluZw0KcGNpX2Rpc2FibGVfZGV2aWNlKCkgZHJvcHMg
dGhlIGVuYWJsZV9jbnQgdG8gemVyby4gV2hlbiBkZXZyZXMgZXhlY3V0ZXMNCml0cyBjbGVhbnVw
LCBpdCB3aWxsIGNhbGwgcGNpX2Rpc2FibGVfZGV2aWNlKCkgYWdhaW4sIGxlYWRpbmcgdG8gYW4N
CnVuZGVyZmxvdyBhbmQgYSBrZXJuZWwgd2FybmluZy4NCg0KICBWYWxpZC4gRml4ZWQgaW4gdjMg
YnkgcmVtb3ZpbmcgcGNpX2Rpc2FibGVfZGV2aWNlKCkgZnJvbSBib3RoIHRoZQ0KICBwcm9iZSBl
cnJvciBwYXRoIGFuZCBtdGtfcGNpX3JlbW92ZSgpLiBwY2ltX2VuYWJsZV9kZXZpY2UoKSBoYW5k
bGVzDQogIGNsZWFudXAgdmlhIGRldnJlcy4NCg0KUTc6IERvZXMgcGVyZm9ybWluZyBhIFBDSWUg
TGluayBEb3duIFJlc2V0IChQTERSKSBiZWZvcmUgZnJlZWluZyBJUlFzIGNhdXNlDQpQQ0llIFVu
c3VwcG9ydGVkIFJlcXVlc3QgKFVSKSBmYXVsdHM/IG10a19wY2lfcGxkcigpIHBvd2VyLWN5Y2xl
cyB0aGUNCmRldmljZSBhbmQgY2xlYXJzIGl0cyBCQVJzLiBEaXJlY3RseSBhZnRlciB0aGlzLCBt
dGtfcGNpX2ZyZWVfaXJxKCkgaXMNCmNhbGxlZCwgd2hpY2ggYXR0ZW1wdHMgdG8gYWNjZXNzIHRo
ZSBkZXZpY2UncyBNU0ktWCBNTUlPIHRhYmxlLg0KDQogIE5vIFVSIGZhdWx0cy4gbXRrX3BjaV9w
bGRyKCkgY2FsbHMgQUNQSSBQWFAuX09GRiB0aGVuIFBYUC5fT04uDQogIFRoZSBfT04gY2FsbCBy
ZXN0b3JlcyBwb3dlciB0byB0aGUgZGV2aWNlLCBicmluZ2luZyB0aGUgUENJZSBsaW5rDQogIGJh
Y2sgdXAgd2l0aCBCQVJzIGFjY2Vzc2libGUuIHBjaV9mcmVlX2lycV92ZWN0b3JzKCkgd3JpdGVz
IHRvIFBDSQ0KICBjb25maWcgc3BhY2UgKE1TSS1YIGNhcGFiaWxpdHkgZW5hYmxlIGJpdCkgd2hp
Y2ggaXMgYWx3YXlzDQogIGFjY2Vzc2libGUgd2hpbGUgdGhlIGRldmljZSBpcyBvbiB0aGUgYnVz
LiBUaGUgTVNJLVggdGFibGUgTU1JTw0KICBhY2Nlc3MgZm9yIG1hc2tpbmcgaW5kaXZpZHVhbCBl
bnRyaWVzIGdvZXMgdGhyb3VnaCB0aGUNCiAgcmUtZXN0YWJsaXNoZWQgQkFSIG1hcHBpbmcuDQoN
ClE4OiBXaWxsIHRoaXMgbWFudWFsIHBjaV9kaXNhYmxlX2RldmljZSgpIGNhbGwgaW4gbXRrX3Bj
aV9yZW1vdmUoKSB0cmlnZ2VyDQphbiBhdG9taWMgdW5kZXJmbG93IGZvciB0aGUgc2FtZSByZWFz
b24gYXMgaW4gbXRrX3BjaV9wcm9iZSgpPw0KSXMgYSBjYWxsIHRvIG10a19wY2lfZGV2X2V4aXQo
KSBtaXNzaW5nIGZyb20gdGhlIHJlbW92ZSBwYXRoPw0KDQogIFR3byBpc3N1ZXMsIGJvdGggdmFs
aWQgYW5kIGZpeGVkIGluIHYzOg0KICAxLiBwY2lfZGlzYWJsZV9kZXZpY2UoKSB1bmRlcmZsb3c6
IHNhbWUgYXMgUTYsIHJlbW92ZWQuDQogIDIuIE1pc3NpbmcgbXRrX3BjaV9kZXZfZXhpdCgpOiBh
ZGRlZCBpbiBwYXRjaCAzLzcgdjMgKHdoZXJlDQogICAgIG10a19wY2lfZGV2X2luaXQgaXMgaW50
cm9kdWNlZCkuDQoNClRoYW5rcy4NCg0KDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQpUaGlzIG1lc3NhZ2UgbWF5IGNvbnRhaW4gaW5mb3JtYXRpb24gd2hp
Y2ggaXMgcHJpdmF0ZSwgcHJpdmlsZWdlZCBvciBjb25maWRlbnRpYWwgb2YgQ29tcGFsIEVsZWN0
cm9uaWNzLCBJbmMuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQgb2YgdGhp
cyBtZXNzYWdlLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYW5kIGRlc3Ryb3kvZGVsZXRlIHRo
ZSBtZXNzYWdlLiBBbnkgcmV2aWV3LCByZXRyYW5zbWlzc2lvbiwgZGlzc2VtaW5hdGlvbiBvciBv
dGhlciB1c2Ugb2YsIG9yIHRha2luZyBvZiBhbnkgYWN0aW9uIGluIHJlbGlhbmNlIHVwb24gdGhp
cyBpbmZvcm1hdGlvbiwgYnkgcGVyc29ucyBvciBlbnRpdGllcyBvdGhlciB0aGFuIHRoZSBpbnRl
bmRlZCByZWNpcGllbnQgaXMgcHJvaGliaXRlZC4NCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCg==

