Return-Path: <netdev+bounces-269271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOarBgdhu2lujQIAu9opvQ
	(envelope-from <netdev+bounces-269271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:35:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB372C506D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E886C302606B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE4736C58F;
	Thu, 19 Mar 2026 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="DqS7uWXm"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B20B340DAB
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773887716; cv=none; b=c7SgYDd7JIZcPeOWhIB/VQhlqnee4dOG9WdpM99Yre7uRTaRO0IMYNrSJdT3UoFEHBrNPMHeOy83+bQnS9r7yJLhwwT13IiG8r6wcXswf2ZSZSRLanHPjcRzGTkdwYz+RN8ml9kaHnR7XvlpIQKJB8QjWI8u5ygSavD3hhzTDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773887716; c=relaxed/simple;
	bh=q1m2iiyEZY8S79tebtT3rfyJX+JE/UBxPdvO6KQPnm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VShQyl7C/S0r0Zei8A/1z2vk8KbbC1rOiMuGHY8m5oyT2wFheUn38kzzi7LlTpJCCn7zMZHjbekYIAtm3WS7364nwtUfto07wGDxm+FuY+iPmv/Skz/ZAF1Zbu0TOfN0WRQAFNPhUdZg8lbYxGEB4hIChW9A872vu12AF1DEnYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=DqS7uWXm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62J2Z9PN02865011, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1773887710;
	bh=q1m2iiyEZY8S79tebtT3rfyJX+JE/UBxPdvO6KQPnm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DqS7uWXm3Z2zIt+4NRe+xLkPfVBP0rpXHEO1Y/pQ/mvqZ+xyNnIyw7xJVX26qsa8H
	 QKFmuclzXEx3NtLZsA0vpKe+4wVSb1U7FC+1jCTOsnTZ0u2GIpv+yKCvqpDxuxvfo7
	 5uw+uObdz/nl12s8yTMLO2Kco0+i7NJMzyi9kcH3N/FUbnStzzbqabgSFgyU6iYs4o
	 U/Y5dn3BgxLZbEuFxgVlEgDvTYCYXV56cYPMeZWq5MY9ir+Xl7FUMkZtjbjmbFmK+t
	 BfSY+uuXWDC+LNCEzRFxhtMvz/8KV6uVyrYrcPvWvLJl9dJpdvty1dbhsO2xoIdahH
	 kYLrUl1dpRSSA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62J2Z9PN02865011
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Mar 2026 10:35:10 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 19 Mar 2026 10:35:09 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Thu,
 19 Mar 2026 10:35:09 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Heiner Kallweit <hkallweit1@gmail.com>, Huan Zhao <ms.huan.zhao@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: r8169: RTL8125B restores default LEDSEL values on Link Up,
 preventing persistent LED configuration
Thread-Topic: r8169: RTL8125B restores default LEDSEL values on Link Up,
 preventing persistent LED configuration
Thread-Index: AQHctF6oK7ZLFDD22E6i3+8OA6HIObW1I4SQ
Date: Thu, 19 Mar 2026 02:35:09 +0000
Message-ID: <91926dc60d1145a79090a23b42a1653b@realsil.com.cn>
References: <20260315014636.30074-1-ms.huan.zhao@gmail.com>
 <322ac707-cb11-4543-bd56-d9f7cce4b52f@gmail.com>
In-Reply-To: <322ac707-cb11-4543-bd56-d9f7cce4b52f@gmail.com>
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
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269271-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 0DB372C506D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pk9uIDE1LjAzLjIwMjYgMDI6NDYsIEh1YW4gWmhhbyB3cm90ZToNCj4+IEhhcmR3YXJlOiBCZWVs
aW5rIFNFUjggbWluaSBQQw0KPj4gTklDOiBSZWFsdGVrIFJUTDgxMjVCIChYSUQgMHg2NDEsIFJU
TF9HSUdBX01BQ19WRVJfNjMsIHJldiAwNSkNCj4+IEtlcm5lbDogNi4xOS42LWFyY2gxLTENCj4+
IERyaXZlcjogcjgxNjkgKGluLXRyZWUpDQo+PiBDT05GSUdfUjgxNjlfTEVEUz15DQo+PiBDT05G
SUdfTEVEU19UUklHR0VSX05FVERFVj1tDQo+Pg0KPj4gUHJvYmxlbToNCj4+IFRoZSBSVEw4MTI1
QiBjaGlwIHJlc3RvcmVzIGl0cyBMRURTRUwgcmVnaXN0ZXJzIHRvIGhhcmR3YXJlIGRlZmF1bHQN
Cj4+IHZhbHVlcyBvbiBldmVyeSBMaW5rIFVwIGV2ZW50LiBUaGUgcjgxNjkgZHJpdmVyIGRvZXMg
bm90IHJlYXBwbHkgdGhlDQo+PiBMRUQgY29uZmlndXJhdGlvbiBhZnRlciBMaW5rIFVwLCBtYWtp
bmcgaXQgaW1wb3NzaWJsZSB0byBwZXJzaXN0ZW50bHkNCj4+IGNvbmZpZ3VyZSBMRURzIChlLmcu
IGRpc2FibGUgdGhlbSkgdGhyb3VnaCB0aGUgc3RhbmRhcmQga2VybmVsIExFRA0KPnN1YnN5c3Rl
bS4NCj4+DQo+PiBEZXRhaWxzOg0KPj4NCj4+IFRoZSBMaW5rIFVwIHBhdGggaW4gdGhlIGRyaXZl
ciBpczoNCj4+DQo+PiAgIHI4MTY5X3BoeWxpbmtfaGFuZGxlcigpICAgICAgIFtyODE2OV9tYWlu
LmM6NDc1N10NCj4+ICAgICAtPiBydGxfbGlua19jaGdfcGF0Y2goKSAgICAgW3I4MTY5X21haW4u
YzoxNTk3XQ0KPj4gICAgIC0+IHJ0bF9lbmFibGVfdHhfbHBpKCkNCj4+ICAgICAtPiBwbV9yZXF1
ZXN0X3Jlc3VtZSgpDQo+Pg0KPj4gcnRsX2xpbmtfY2hnX3BhdGNoKCkgaGFzIG5vIGhhbmRsaW5n
IGZvciBSVExfR0lHQV9NQUNfVkVSXzYzIGFuZCBkb2VzDQo+PiBub3QgdG91Y2ggdGhlIExFRFNF
TCByZWdpc3RlcnMuIFNpbWlsYXJseSwgcnRsX2h3X3N0YXJ0XzgxMjViKCkgYW5kDQo+PiBydGxf
aHdfc3RhcnRfODEyNV9jb21tb24oKSwgd2hpY2ggYXJlIGNhbGxlZCBvbiBoYXJkd2FyZQ0KPj4g
aW5pdGlhbGl6YXRpb24sIGRvIG5vdCB3cml0ZSB0byBhbnkgTEVEU0VMIHJlZ2lzdGVyIChMRURT
RUwwPTB4MTgsDQo+PiBMRURTRUwxPTB4ODYsIExFRFNFTDI9MHg4NCwgTEVEU0VMMz0weDk2KS4N
Cj4+DQo+PiBUaGUgb25seSBkcml2ZXIgY29kZSB0aGF0IHdyaXRlcyBMRURTRUwgcmVnaXN0ZXJz
IGlzDQo+PiBydGw4MTI1X3NldF9sZWRfbW9kZSgpIGluIHI4MTY5X2xlZHMuYywgY2FsbGVkIGV4
Y2x1c2l2ZWx5IGZyb20gdGhlDQo+PiBMRUQgY2xhc3NkZXYgaHdfY29udHJvbCBjYWxsYmFja3Mu
IFRoZXJlZm9yZSwgYW55IExFRCBjb25maWd1cmF0aW9uDQo+PiBhcHBsaWVkIHZpYSBzeXNmcyBp
cyBzaWxlbnRseSBvdmVyd3JpdHRlbiBieSB0aGUgaGFyZHdhcmUgY2hpcCdzIG93bg0KPj4gZmly
bXdhcmUgb24gZXZlcnkgTGluayBVcCBldmVudCwgYmVmb3JlIHRoZSBkcml2ZXIgaGFzIGEgY2hh
bmNlIHRvIHJlYXBwbHkNCj5pdC4NCj4+DQo+PiBUaGlzIHdhcyB2ZXJpZmllZCBieSBvYnNlcnZp
bmcgdGhhdDoNCj4+IDEuIFdyaXRpbmcgMHgwMDAwIHRvIGFsbCBMRURTRUwgcmVnaXN0ZXJzICh2
aWEgQkFSMCBNTUlPKSBiZWZvcmUgTGluayBVcA0KPj4gICAgc3VjY2Vzc2Z1bGx5IHR1cm5zIG9m
ZiBhbGwgTEVEcy4NCj4+IDIuIEFmdGVyIExpbmsgVXAgY29tcGxldGVzLCB0aGUgTEVEU0VMIHJl
Z2lzdGVycyByZXZlcnQgdG8gdGhlaXIgaGFyZHdhcmUNCj4+ICAgIGRlZmF1bHRzLCB0dXJuaW5n
IHRoZSBMRURzIGJhY2sgb24uDQo+PiAzLiBXcml0aW5nIDB4MDAwMCB0byBMRURTRUwgcmVnaXN0
ZXJzIGltbWVkaWF0ZWx5IGFmdGVyIExpbmsgVXAgKHZpYQ0KPj4gICAgTmV0d29ya01hbmFnZXIg
ZGlzcGF0Y2hlciB0cmlnZ2VyZWQgb24gZGhjcDQtY2hhbmdlKSBzdWNjZXNzZnVsbHkNCj5rZWVw
cw0KPj4gICAgdGhlIExFRHMgb2ZmIHBlcnNpc3RlbnRseS4NCj4+DQo+PiBPcmlnaW5hbCBMRURT
RUwgcmVnaXN0ZXIgdmFsdWVzIChoYXJkd2FyZSBkZWZhdWx0cykgb24gdGhpcyBtYWNoaW5lOg0K
Pj4gICBMRURTRUwwICgweDE4KSA9IDB4MDAwMiAgKExJTktfMTAwKQ0KPj4gICBMRURTRUwxICgw
eDg2KSA9IDB4MDAyOCAgKExJTktfMjUwMCArIExJTktfMTAwMCkNCj4+ICAgTEVEU0VMMiAoMHg4
NCkgPSAweDAyMmIgIChBQ1QgKyBMSU5LXzI1MDAgKyBMSU5LXzEwMDAgKyBMSU5LXzEwMCArDQo+
TElOS18xMCkNCj4+ICAgTEVEU0VMMyAoMHg5NikgPSAweDAwMjAgIChMSU5LXzI1MDApDQo+Pg0K
PlRoYW5rcyBmb3IgdGhlIHJlcG9ydC4gRm9yIHByZXBhcmF0aW9uIG9mIGEgZml4IGl0IHdvdWxk
IGJlIGhlbHBmdWwgdG8ga25vdw0KPndoZXRoZXIgdGhpcyBiZWhhdmlvciBpcyBzcGVjaWZpYyB0
byBSVEw4MTI1Qiwgb3Igd2hldGhlciB0aGlzIGFwcGxpZXMgdG8gYWxsDQo+Y2hpcCB2YXJpYW50
cyBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlci4NCj5BIHJlc2V0IHRvIGRlZmF1bHRzIGFmdGVyIGEg
ZGVlcCBwb3dlci1zYXZpbmcgc3RhdGUgSSdkIHVuZGVyc3RhbmQsIGJ1dCBhIHJlc2V0DQo+dG8g
cG93ZXItdXAgZGVmYXVsdHMgb24gbGluay11cCBzb3VuZHMgcXVpcmt5LiBCdXQgbWF5YmUgaXQn
cyBub3QgcG93ZXItdXANCj5kZWZhdWx0cywgYnV0IGxpbmsgc3BlZWQgc3BlY2lmaWMgZGVmYXVs
dHMuDQo+DQo+SGF1LCBKYXZlbjogQXMgSSBkb24ndCBoYXZlIGFjY2VzcyB0byBjaGlwIGRvY3Vt
ZW50YXRpb24sIEknZCBhcHByZWNpYXRlIGENCj5jb21tZW50IGZyb20geW91ciBzaWRlLiBUaGFu
a3MhDQoNCk15IHBsYXRmb3JtOg0KIEhhcmR3YXJlOiBBU1VTVGVrIFo4OTAtUExVUw0KIE5JQzog
UmVhbHRlayBSVEw4MTI1QiAoWElEIDB4NjQxLCBSVExfR0lHQV9NQUNfVkVSXzYzLCByZXYgMDQp
DQogS2VybmVsOiA3LjAuMC0wNzAwMDByYzEtZ2VuZXJpYw0KIERyaXZlcjogcjgxNjkgKGluLXRy
ZWUpDQoNCkkgdHJpZWQgdGhlIGZvbGxvd2luZyBzdGVwczoNCjEuIGxpbmsgdXAsIExFRHMgb24N
CjIuIGxpbmsgZG93biwgTEVEIG9mZg0KMy4gd3JpdGluZyAweDAwMDAgdG8gbW1pbyBhZGRyZXNz
IHRocm91Z2ggZGV2bWVtMiwgbGluayB1cCwgTEVEUyBhcmUgc3RpbGwgb2ZmDQoNCjEuIGxpbmsg
dXAsIExFRHMgb24NCjIuIGVjaG8gMCB8IHN1ZG8gdGVlIC9zeXMvY2xhc3MvbGVkcy9lbnAxMzBz
MC0yOjpsYW4vbGlua18xMDAwLCBMRURzIG9mZg0KMy4gbGluayBkb3duLCBsaW5rIHVwLCBMRURz
IGFyZSBzdGlsbCBvZmYNCg0KT3JpZ2luYWwgTEVEU0VMIHJlZ2lzdGVyIHZhbHVlcyDigIvigItv
biBteSBwYzogDQpMRURTRUwwICgweDE4KSA9IDB4MDIwMSANCkxFRFNFTDEgKDB4ODYpID0gMHgw
MjAyIA0KTEVEU0VMMiAoMHg4NCkgPSAweDAyMDggDQpMRURTRUwzICgweDk2KSA9IDB4MDIyMA0K
DQpJIGNhbid0IHNlZSB0aGUgcHJvYmxlbSBvbiBteSBwYy4gSSB3YW50IHRvIGtub3cgaWYgdGhl
cmUncyBhbnl0aGluZyB3cm9uZyB3aXRoIHRoZSBzdGVwcyBJIHRvb2sgdG8gcmVwcm9kdWNlIGl0
Lg0KDQpUaGFua3MNCg==

