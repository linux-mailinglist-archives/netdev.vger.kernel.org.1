Return-Path: <netdev+bounces-295127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C5suCqg/IWqtBwEAu9opvQ
	(envelope-from <netdev+bounces-295127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:04:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 207B763E4FD
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:04:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=mkjbyrCG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295127-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295127-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 208BF3093D9D
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DA33F6C27;
	Thu,  4 Jun 2026 09:01:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D83FC5BA
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 09:01:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563715; cv=none; b=uaJTUI2oS8WIRRQQQj3XzMVmmAh9PhYOVDzZkbMGublp2vEUAeK6bDBeV3J26i7lwlPiCl31DY/qMm4c1r5Q4pZ8khEaC3slgGNpvtG7McKjrdd7BzRSpu/h82xnO22w8jGNt9lysz9X8uxaprgVX123GEuPUCuxMt1OMt6JePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563715; c=relaxed/simple;
	bh=gwCofHGH6vZXW/4XECc2TxwWRgvTc5wmCwaHLRqs2kw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FMV/5LYLoDtOA4RcvaSnqVwBURB5JQ+SbAljEuz5iYON3VAfvtguAHgbSNCxrJycA44Rt0x4n8kahUhAugcgCjL2hVMzc7sthrjcv1iiu+/g8jJDLqNEFTXETa3I9QJ4bFHa/s1fi/z7mUVKFcyRWOFsJG0lkZz+lNVgz2kNCcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=mkjbyrCG; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65491cCeA241584, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780563699;
	bh=gwCofHGH6vZXW/4XECc2TxwWRgvTc5wmCwaHLRqs2kw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mkjbyrCGX/PxBk9Z0Ayt2iDsqNA5tey9mF2RQ1Dj2+s7Fxie4/A1wxjGdwS3rb6DT
	 tUzby9y3Ux7bqXvFxOtx++asOx8n5Szj4kRrduGqlZ3/pRWDrAkfXjKMxxMQvrF3Pg
	 wp+GHcru0ILLT9oHPYFZcXJC2rZLThqo3FnoBg1Plx8py/4OxYXHqShQsSzd6Mqw5P
	 C8Futs0WH64CbdzfvQlKP+lJrqPuROid5td5uyz9r1QYEvkrSHYccaPvljE2kz8pUJ
	 5SogGPSXlTewbPqnHoRyCZ1mrvjhutuGXyUytK+9PGryd5KzPSSgFGfY2vIImR3zQy
	 usYWdDdl029AQ==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 65491cCeA241584
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 17:01:39 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 17:01:38 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Thu,
 4 Jun 2026 17:01:38 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Heiner Kallweit <hkallweit1@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "lasse@lgb.dk"
	<lasse@lgb.dk>
Subject: RE: [Bug 221606] r8169: PCIe AER errors and recovery failure after
 recent driver changes
Thread-Topic: [Bug 221606] r8169: PCIe AER errors and recovery failure after
 recent driver changes
Thread-Index: AQHc85gwkGNesnqGQkCQ9QthIRv61LYuEfCw
Date: Thu, 4 Jun 2026 09:01:38 +0000
Message-ID: <9b206f58d93b48d194980374cf0da7b1@realsil.com.cn>
References: <bug-221606-201211@https.bugzilla.kernel.org/>
 <bug-221606-201211-LMiiKJhHhg@https.bugzilla.kernel.org/>
 <b1bda1da-8231-4f05-94a7-7511041ae489@gmail.com>
In-Reply-To: <b1bda1da-8231-4f05-94a7-7511041ae489@gmail.com>
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
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:lasse@lgb.dk,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295127-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lgb.dk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 207B763E4FD

Pk9uIDAzLjA2LjIwMjYgMDk6NDQsIGJ1Z3ppbGxhLWRhZW1vbkBrZXJuZWwub3JnIHdyb3RlOg0K
Pj4gaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMjE2MDYNCj4+
DQo+PiAtLS0gQ29tbWVudCAjMiBmcm9tIGxhc3NlQGxnYi5kayAtLS0NCj4+IENvbW1pdCA5YWI5
NGEzMmFmNzA0ZmE5Yzg3MzA5NDI4M2FlODc0NGEwN2JhZjI1IChyODE2OTogZW5hYmxlIExUUg0K
Pj4gc3VwcG9ydCkgc2VlbXMgdG8gYmUgdGhlIGlzc3VlLiBSdW5uaW5nIHRoZSBjb21taXQgYmVm
b3JlIHRoaXMgZG9lc24ndA0KPj4gZ2l2ZSBtZSBhbnkgQUVSIGVycm9ycyBhbmQgZXZlcnl0aGlu
ZyBzZWVtcyB0byBiZWhhdmUgbm9ybWFsbHkuDQo+Pg0KPkJpc2VjdGluZyB0aGUgcmVwb3J0ZWQg
aXNzdWUgcG9pbnRzIHRvIG9uZSBvZiB5b3VyIGNvbW1pdHMuDQo+Q291bGQgeW91IHBsZWFzZSBj
aGVjayB3aXRoIHRoZSB1c2VyPw0KDQpIaSwgSGVpbmVyLCBMYXNzZQ0KDQpUaGFua3MgZm9yIHJl
cG9ydGluZyB0aGlzIGlzc3VlLg0KDQpDdXJyZW50bHksIHdlIGhhdmVuJ3QgcmVjZWl2ZWQgYW55
IHNpbWlsYXIgcmVwb3J0cyBmcm9tIG91ciBjdXN0b21lcnMsIGFuZCBJIGFtIHVuYWJsZSB0byBy
ZXByb2R1Y2UgdGhpcyBBRVIgZXJyb3Igb24gbXkgbG9jYWwgdGVzdCBwbGF0Zm9ybXMuDQoNCkNv
dWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBzb21lIG1vcmUgZGV0YWlsZWQgaW5mb3JtYXRpb24/IFRo
ZSBmdWxsIGRtZXNnIGxvZyB3aWxsIGhlbHAgbWUgY2hlY2sgdGhlIGV4YWN0IEFFUiBlcnJvciBt
ZXNzYWdlcyBhbmQgdGhlIGJvb3QgY29udGV4dC4gQWxzbyB0aGUgb3V0cHV0IG9mIHN1ZG8gbHNw
Y2kgLXZ2di4gSSBuZWVkIHRoaXMgdG8gY2hlY2sgdGhlIGV4YWN0IHBsYXRmb3JtIGluZm9ybWF0
aW9uLCBQQ0llIHRvcG9sb2d5LCBhbmQgdGhlIExUUi9BU1BNIGNhcGFiaWxpdGllcyBvZiBib3Ro
IHlvdXIgUm9vdCBQb3J0IGFuZCB0aGUgUmVhbHRlayBOSUMuDQoNCldoaWxlIHJldmlld2luZyB0
aGUgaW5pdGlhbGl6YXRpb24gZmxvdywgSSBub3RpY2VkIGEgcG90ZW50aWFsIGxvZ2ljIGNvbnRy
YWRpY3Rpb24uIElmIHJ0bF9hc3BtX2lzX3NhZmUodHApIHJldHVybnMgZmFsc2UsIHRoZSBkcml2
ZXIgZGlzYWJsZXMgTDEgYXQgdGhlIFBDSWUgY29yZSBsZXZlbCwgYnV0IHRwLT5hc3BtX21hbmFn
ZWFibGUgbWlnaHQgc3RpbGwgYmUgc2V0IHRvIHRydWUuIFRoaXMgY291bGQgY2F1c2UgdGhlIGRy
aXZlciB0byBpbmNvcnJlY3RseSBlbmFibGUgQVNQTS9MVFIgaW4gdGhlIE1BQyByZWdpc3RlcnMg
bGF0ZXIsIGNyZWF0aW5nIGEgaGFyZHdhcmUgc3RhdGUgbWlzbWF0Y2ggKFBDSWUgTDEgZGlzYWJs
ZWQsIGJ1dCBNQUMgTFRSIGVuYWJsZWQpIHdoaWNoIHVzdWFsbHkgbGVhZHMgdG8gQUVSLg0KDQpD
b3VsZCB5b3UgcGxlYXNlIHRlc3QgaWYgdGhlIGZvbGxvd2luZyBwYXRjaCBmaXhlcyB0aGUgQUVS
IGVycm9yIG9uIHlvdXIgc2lkZT8NCg0KLQlpZiAoZW5hYmxlICYmIHRwLT5hc3BtX21hbmFnZWFi
bGUpIHsNCisJaWYgKGVuYWJsZSAmJiB0cC0+YXNwbV9tYW5hZ2VhYmxlICYmIHJ0bF9hc3BtX2lz
X3NhZmUodHApKSB7DQoNClRoYW5rcywNCkJScywNCkphdmVuDQo=

