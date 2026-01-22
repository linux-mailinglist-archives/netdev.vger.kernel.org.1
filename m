Return-Path: <netdev+bounces-252133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDhTDq+AcWk1IAAAu9opvQ
	(envelope-from <netdev+bounces-252133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:43:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD960760
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74CC8500BC8
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFBA318EDB;
	Thu, 22 Jan 2026 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="dRHGLN65"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A231B111;
	Thu, 22 Jan 2026 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046184; cv=none; b=fK1F2kXEfIF64GrEfJXBFIITT6ywa1rJZliqCRQA2RD2v7YubAC3bfPSwhdzNTgdoKKxHRT/aqWY5BrwSo1zLqw8w82bpkCxDsFGHd4evlxuKUget8jlWBqXH34hVUFQdd1IUwl7pLPsqbpQqaDQ6O78VHXmrNDTwvYzy5qCbII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046184; c=relaxed/simple;
	bh=yX/pgTeLEJNMLqSowQfevzCnPKyRUCyOofWNfyZXEqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MpeuglepFQuqmkOFbHpwJCGhjX6S+wJm/OoytEhMfsBWy4dfjcGuQo+G6VWGlA9Fz1qn3CvucSDjlm21rI9vQyg2s5k14cPn1mC7pcpM8umSXQxn5bouOlfJhSmMgLhE+p+s6t3p/u5WuPvSEGFVeRR0tQ9/Hs7hcA3RsK1OCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=dRHGLN65; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60M1gRw05076378, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1769046148;
	bh=yX/pgTeLEJNMLqSowQfevzCnPKyRUCyOofWNfyZXEqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dRHGLN65oppRtuAh++8b1g/fQh9BL2AuX2VKLQZbMPtmnw/u3CPzjw5pLUQUJJX0T
	 tG/euIbk0Xo/Nsz0Nh5j6UIbOKkf7N9MqOvAibjhN+D8/72nUIOKNq3+IL371L9tRn
	 VHVZ0Qg6BzJS/JaYxt10ZLNyK4sds6rc1HkatfS06cNr7iQOvjjHKarAXo5Ha4n7PP
	 tdy8z4BQ0luYOKrs9fsC3BgNuaWnUVNvGpeGgcgswm7Hznptfrv/T4HFeCnSr5oYq3
	 lblLsGsbEfFmo19I3JNu1TgcaANhKJbHTAAl0KsVULsJ296QQFFb6+DmtQctFj/J+2
	 RNArb0wxG5q4g==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60M1gRw05076378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Jan 2026 09:42:28 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 22 Jan 2026 09:42:26 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.1748.039; Thu,
 22 Jan 2026 09:42:26 +0800
From: =?utf-8?B?6K645L+K5Lyf?= <javen_xu@realsil.com.cn>
To: Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH net-next v1 3/3] r8169: add support for chip RTL9151AS
Thread-Topic: [PATCH net-next v1 3/3] r8169: add support for chip RTL9151AS
Thread-Index: AQHcg22Mgr9mW4h6dk2B/0jlDikJ7bVOlnAAgAP2R4CACuncMA==
Date: Thu, 22 Jan 2026 01:42:26 +0000
Message-ID: <bffa03f0eb9f405388b5436882776111@realsil.com.cn>
References: <20260112024541.1847-1-javen_xu@realsil.com.cn>
 <20260112024541.1847-4-javen_xu@realsil.com.cn>
 <02c00a95-34c6-4b01-8f0a-7dbd113e26ba@gmail.com>
 <a244b2c5-b3d6-4150-b9ab-8be20d72bf23@redhat.com>
In-Reply-To: <a244b2c5-b3d6-4150-b9ab-8be20d72bf23@redhat.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-252133-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[realsil.com.cn,none];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 44CD960760
X-Rspamd-Action: no action

Pk9uIDEvMTIvMjYgMTE6MjAgUE0sIEhlaW5lciBLYWxsd2VpdCB3cm90ZToNCj4+IE9uIDEvMTIv
MjAyNiAzOjQ1IEFNLCBqYXZlbiB3cm90ZToNCj4+PiBGcm9tOiBKYXZlbiBYdSA8amF2ZW5feHVA
cmVhbHNpbC5jb20uY24+DQo+Pj4NCj4+PiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgY2hp
cCBSVEw5MTUxQVMuIFNpbmNlIGxhY2tpbmcgb2YgSGFyZHdhcmUNCj4+PiB2ZXJzaW9uIElEcywg
d2UgdXNlIFRYX0NPTkZJR19WMiB0byByZWNvZ25pemUgUlRMOTE1MUFTIGFuZCBjb21pbmcNCj5j
aGlwcy4NCj4+PiBydGxfY2hpcF9pbmZvc19leHRlbmQgaXMgdXNlZCB0byBzdG9yZSBJQyBpbmZv
cm1hdGlvbiBmb3IgUlRMOTE1MUFTDQo+Pj4gYW5kIGNvbWluZyBjaGlwcy4gVGhlIFR4Q29uZmln
IHZhbHVlIGJldHdlZW4gUlRMOTE1MUFTIGFuZCBSVEw5MTUxQQ0KPj4+IGlzDQo+Pj4NCj4+PiBk
aWZmZXJlbnQuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBKYXZlbiBYdSA8amF2ZW5feHVAcmVh
bHNpbC5jb20uY24+DQo+Pj4gLS0tDQo+Pj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsv
cjgxNjkuaCAgICAgIHwgIDMgKystDQo+Pj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsv
cjgxNjlfbWFpbi5jIHwgMjgNCj4+PiArKysrKysrKysrKysrKysrKysrKystLQ0KPj4+ICAyIGZp
bGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OS5oDQo+Pj4gYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5LmgNCj4+PiBpbmRleCAyYzFhMGMyMWFm
OGQuLmY2NmMyNzljYmVlNiAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9y
ZWFsdGVrL3I4MTY5LmgNCj4+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4
MTY5LmgNCj4+PiBAQCAtNzIsNyArNzIsOCBAQCBlbnVtIG1hY192ZXJzaW9uIHsNCj4+PiAgICAg
IFJUTF9HSUdBX01BQ19WRVJfNzAsDQo+Pj4gICAgICBSVExfR0lHQV9NQUNfVkVSXzgwLA0KPj4+
ICAgICAgUlRMX0dJR0FfTUFDX05PTkUsDQo+Pj4gLSAgICBSVExfR0lHQV9NQUNfVkVSX0xBU1Qg
PSBSVExfR0lHQV9NQUNfTk9ORSAtIDENCj4+PiArICAgIFJUTF9HSUdBX01BQ19WRVJfTEFTVCA9
IFJUTF9HSUdBX01BQ19OT05FIC0gMSwNCj4+PiArICAgIFJUTF9HSUdBX01BQ19WRVJfQ0hFQ0tf
RVhURU5EDQo+Pj4gIH07DQo+Pj4NCj4+PiAgc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZTsNCj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4+
PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+Pj4gaW5kZXgg
OWI4OWJiZjY3MTk4Li4xNjRhZDY1NzAwNTkgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4+PiArKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYw0KPj4+IEBAIC05NSw4ICs5NSw4IEBADQo+Pj4gICNk
ZWZpbmUgSlVNQk9fMTZLICAgKFNaXzE2SyAtIFZMQU5fRVRIX0hMRU4gLSBFVEhfRkNTX0xFTikN
Cj4+Pg0KPj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHJ0bF9jaGlwX2luZm8gew0KPj4+IC0gICAg
dTE2IG1hc2s7DQo+Pj4gLSAgICB1MTYgdmFsOw0KPj4+ICsgICAgdTMyIG1hc2s7DQo+Pj4gKyAg
ICB1MzIgdmFsOw0KPj4+ICAgICAgZW51bSBtYWNfdmVyc2lvbiBtYWNfdmVyc2lvbjsNCj4+PiAg
ICAgIGNvbnN0IGNoYXIgKm5hbWU7DQo+Pj4gICAgICBjb25zdCBjaGFyICpmd19uYW1lOw0KPj4+
IEBAIC0yMDUsMTAgKzIwNSwyMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJ0bF9jaGlwX2luZm8g
ew0KPj4+ICAgICAgeyAweGZjOCwgMHgwNDAsIFJUTF9HSUdBX01BQ19WRVJfMDMsICJSVEw4MTEw
cyIgfSwNCj4+PiAgICAgIHsgMHhmYzgsIDB4MDA4LCBSVExfR0lHQV9NQUNfVkVSXzAyLCAiUlRM
ODE2OXMiIH0sDQo+Pj4NCj4+PiArICAgIC8qIGV4dGVuZCBjaGlwIHZlcnNpb24qLw0KPj4+ICsg
ICAgeyAweDdjZiwgMHg3YzgsIFJUTF9HSUdBX01BQ19WRVJfQ0hFQ0tfRVhURU5EIH0sDQo+Pj4g
Kw0KPj4+ICAgICAgLyogQ2F0Y2gtYWxsICovDQo+Pj4gICAgICB7IDB4MDAwLCAweDAwMCwgUlRM
X0dJR0FfTUFDX05PTkUgfSAgfTsNCj4+Pg0KPj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHJ0bF9j
aGlwX2luZm8gcnRsX2NoaXBfaW5mb3NfZXh0ZW5kW10gPSB7DQo+Pj4gKyAgICB7IDB4N2ZmZmZm
ZmYsIDB4MDAwMDAwMDAsIFJUTF9HSUdBX01BQ19WRVJfNjQsICJSVEw5MTUxQVMiLA0KPj4+ICtG
SVJNV0FSRV85MTUxQV8xfSwNCj4+PiArDQo+Pg0KPj4gU2VlbXMgYWxsIGJpdHMgZXhjZXB0IGJp
dCAzMSBhcmUgdXNlZCBmb3IgY2hpcCBkZXRlY3Rpb24uIEhvd2V2ZXINCj4+IHJlZ2lzdGVyIGlz
IG5hbWVkIFRYX0NPTkZJR19WMiwgZXZlbiB0aG91Z2ggb25seSBiaXQgMzEgaXMgbGVmdCBmb3Ig
YWN0dWFsIHR4DQo+Y29uZmlndXJhdGlvbi4NCj4+IElzIHRoZSByZWdpc3RlciBuYW1lIG1pc2xl
YWRpbmcsIG9yIGlzIHRoZSBtYXNrIGluY29ycmVjdD8NCj4NCj5ASGVpbmVyIChkb3VibGUgY2hl
Y2tpbmcgdG8gYXZvaWQgbW9yZSBjb25mdXNpb24gb24gbXkgc2lkZSk6IGFyZSB5b3UgZmluZQ0K
PndpdGggdGhlIHJlZ2lzdGVyIG5hbWU/IEl0J3MgdW5jbGVhciB0byBtZSBpZiB5b3UgYXJlIGZp
bmUgd2l0aCBqdXN0IHRoZSAyDQo+bWVyZ2VkIHBhdGNoZXMgb3IgZXZlbiB3aXRoIHRoaXMgb25l
Lg0KPg0KPlRoYW5rcywNCj4NCj5QYW9sbw0KDQpIaSwgUGFvbG8gJiBIZWluZXINCg0KSXQgYXBw
ZWFycyB0aGF0IHRoaXMgcGF0Y2ggaGFzIG5vdCBiZWVuIGFjY2VwdGVkIHlldC4gU2hvdWxkIEkg
cmVzdWJtaXQgaXQgYXMgYSANCnNlcGFyYXRlICBwYXRjaD8NCg0KVGhhbmssDQpKYXZlbiBYdQ0K

