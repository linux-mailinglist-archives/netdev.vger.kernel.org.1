Return-Path: <netdev+bounces-298447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gkRhFOJ7K2qo+QMAu9opvQ
	(envelope-from <netdev+bounces-298447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 05:24:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7514F6766B5
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 05:24:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=S6DonKga;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298447-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298447-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD179301FAEC
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FED318EC1;
	Fri, 12 Jun 2026 03:24:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E9303CAB;
	Fri, 12 Jun 2026 03:24:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781234653; cv=none; b=dlMNbQdK6Fhklah4vKABcgodBL5KwF/eeH5PCNnclsprcVQ+fkY487gzUeg1aQPb+Ba1yL1eSOh1aMFhllGMAPCPwG2EWNi2f7jSwjW/08Z8WSikTQLJapkzskfqYS7JEETFTIyf7APJcd9bxq3Olu/fo3qUrDDj75Lbs4UIboU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781234653; c=relaxed/simple;
	bh=6ZUrXfbikKw9NWFqshMo7VVmweeXUaGeNwjFwRL/0C0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sbiB79T5ofAkeU1okRse+eGA6hyPxmiS2OfMntByfaCDtO/HmqgeVr1KM4Iq0qs91kAh/aEx4O6egLeqQapSDDK+9Esr0SBY3NaiuMcVEiXgzd67aycCI8A11H3/opqVO2E3TlfnXSzx1IT+yH737f8fpnSMpyoMVTjrdBwIFPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=S6DonKga; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65C3NaUiA2429535, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781234616;
	bh=6ZUrXfbikKw9NWFqshMo7VVmweeXUaGeNwjFwRL/0C0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=S6DonKga7kzTx0IUDNTC4t3yY3nTxyzR/+B2hRr7/j2ecJ/YL8Bi9a+JrmeBV3QO7
	 TCghxbiB/dhPWc0BtE6z2qRhjOfd7dNDneM8zAyi8wbzSvGps0nEY0xYde2k99Tm1W
	 rPNZxEP4Cf5sSi3BIHD+2DPNiAuLwHtya20Z+jDa1c+omM5Y4m+nZi+e2XfOjSRTSL
	 jhmKGVY/IT8Uh9JRMTDnAOaPJPtBNphQuJGV29vdoUo6bShXfYYIAkKNflDYnByg3P
	 B8ako08BydbadO9kT+82kyCYcSKeXFXo6sNZZTtektTd5eqYQzK2uEzRID7GyskcIz
	 xRh9RfFopRNfg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65C3NaUiA2429535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jun 2026 11:23:36 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Jun 2026 11:23:36 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Fri,
 12 Jun 2026 11:23:36 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Javen <javen_xu@realsil.com.cn>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v7 0/7] r8169: add RSS support for RTL8127
Thread-Topic: [PATCH net-next v7 0/7] r8169: add RSS support for RTL8127
Thread-Index: AQHc9AzCHILrUkOa30eg1XOEvwovFLY6Rn7g
Date: Fri, 12 Jun 2026 03:23:36 +0000
Message-ID: <32c58b321f5c4ac883e53f1877c870d2@realsil.com.cn>
References: <20260604102733.1582-1-javen_xu@realsil.com.cn>
In-Reply-To: <20260604102733.1582-1-javen_xu@realsil.com.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298447-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,realsil.com.cn:dkim,realsil.com.cn:mid,realsil.com.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7514F6766B5

PlRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgUlNTIChSZWNlaXZlIFNpZGUgU2NhbGluZykgc3VwcG9y
dCBmb3IgdGhlIHI4MTY5DQo+ZXRoZXJuZXQgZHJpdmVyLCBzcGVjaWZpY2FsbHkgZm9yIFJUTDgx
MjcgKFJUTF9HSUdBX01BQ19WRVJfODApLg0KPg0KPlJTUyBlbmFibGVzIHBhY2tldCBkaXN0cmli
dXRpb24gYWNyb3NzIG11bHRpcGxlIHJlY2VpdmUgcXVldWVzLCB3aGljaCBjYW4NCj5zaWduaWZp
Y2FudGx5IGltcHJvdmUgbmV0d29yayB0aHJvdWdocHV0IG9uIG11bHRpLWNvcmUgc3lzdGVtcyBi
eSBhbGxvd2luZw0KPnBhcmFsbGVsIHByb2Nlc3Npbmcgb2YgaW5jb21pbmcgcGFja2V0cy4NCj4N
Cj5KYXZlbiBYdSAoNyk6DQo+ICByODE2OTogYWRkIHN1cHBvcnQgZm9yIG11bHRpIGlycXMNCj4g
IHI4MTY5OiBhZGQgc3VwcG9ydCBmb3IgbXVsdGkgcnggcXVldWVzDQo+ICByODE2OTogYWRkIHN1
cHBvcnQgZm9yIG5ldyBpbnRlcnJ1cHQgbWFwcGluZw0KPiAgcjgxNjk6IGVuYWJsZSBuZXcgaW50
ZXJydXB0IG1hcHBpbmcNCj4gIHI4MTY5OiBhZGQgc3VwcG9ydCBhbmQgZW5hYmxlIHJzcw0KPiAg
cjgxNjk6IG1vdmUgc3RydWN0IGV0aHRvb2xfb3BzDQo+ICByODE2OTogc3VwcG9ydCBzZXR0aW5n
IHJ4IHF1ZXVlIG51bWJlcnMgdmlhIGV0aHRvb2wNCj4NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQv
cmVhbHRlay9yODE2OV9tYWluLmMgfCAxMDk5ICsrKysrKysrKysrKysrKysrKy0tLQ0KPiAxIGZp
bGUgY2hhbmdlZCwgOTU1IGluc2VydGlvbnMoKyksIDE0NCBkZWxldGlvbnMoLSkNCj4NCj4tLQ0K
PjIuNDMuMA0KDQpIaQ0KDQpBIGdlbnRsZSBwaW5nIG9uIHRoaXMgdjcgcGF0Y2guDQoNCkkgaGF2
ZSByZWNlaXZlZCBzb21lIGZlZWRiYWNrIGZyb20gQUkgYm90IGR1cmluZyB0aGlzIHdlZWssIGFu
ZCBJIGhhdmUgYWxyZWFkeSBhZGRyZXNzZWQgdGhvc2UgY29tbWVudHMgbG9jYWxseS4NCg0KQmVm
b3JlIEkgc2VuZCBvdXQgdGhlIHY4IHBhdGNoc2V0LCBJIHdhbnRlZCB0byBraW5kbHkgY2hlY2sg
aWYgdGhlcmUgYXJlIGFueSBhZGRpdGlvbmFsIGNvbW1lbnRzIG9uIHRoaXMgdjc/DQoNClRoYW5r
cyBmb3IgeW91ciB0aW1lIGFuZCBoZWxwIQ0KDQpCZXN0IHJlZ2FyZHMsDQpKYXZlbg0KDQoNCg==

