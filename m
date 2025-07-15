Return-Path: <netdev+bounces-207195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B7B0628F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C0C3B5FEB
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7D820B800;
	Tue, 15 Jul 2025 15:13:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E054202C49;
	Tue, 15 Jul 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592423; cv=none; b=Cwndt3JnQZE3X6c39RP1XNW+O5pBoCLiD9JBdN9UHcFpy3fxHFOWt8dblxuQLKVboaj1z27pAVIcFAKMiROiH+IlJb7IiPcgWDAqBMqyaxVAhRbe1b3SsnYvUfLBCeh+p2J1F6FFIPk+UzmqkpjJyfz8plvbRqQdaml1Uivh0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592423; c=relaxed/simple;
	bh=kKxqrmLt4lcjaPEkskXnTFZjIxXnpmJGM1JM7tMvYNo=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=USS8lT/UhU6Mubzv8bYpIQ9QVCPY9/3fA36UvlgeVO0Yy5683Do5XMCFvyUedW1roMfzIXdsgAzrcaPX+2HHxiiB/Atr98Np3a2yZ7MyUekt5l/1Ll1ZAJfDnBLaPJb+UiFN75llYaqeFBdygh9QY7d7qVpVVN6fv8ILIXBgfJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bhN4700wSz8R039;
	Tue, 15 Jul 2025 23:13:27 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 56FFDLSd040471;
	Tue, 15 Jul 2025 23:13:21 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 15 Jul 2025 23:13:25 +0800 (CST)
Date: Tue, 15 Jul 2025 23:13:25 +0800 (CST)
X-Zmail-TransId: 2afa6876701553c-d3fb8
X-Mailer: Zmail v1.0
Message-ID: <20250715231325415aMAZWoPQiUJ2Fe-ongTRW@zte.com.cn>
In-Reply-To: <20250715072058.12f343bb@kernel.org>
References: 20250714164625.788f7044@kernel.org,20250715072058.12f343bb@kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <kuba@kernel.org>
Cc: <edumazet@google.com>, <kuniyu@amazon.com>, <ncardwell@google.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <jiang.kun2@zte.com.cn>, <pabeni@redhat.com>,
        <horms@kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXQtbmV4dCB2NF0gdGNwOiBleHRlbmQgdGNwX3JldHJhbnNtaXRfc2tiIHRyYWNlcG9pbnQgd2l0aCBmYWlsdXJlIHJlYXNvbnM=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 56FFDLSd040471
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68767016.000/4bhN4700wSz8R039



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PiA+IEkgYWdyZWUgdGhhdCBzb21lIG9mIHRoZSByZXN1bHQgdHlwZXMgKGUuZy4sIEVOT01FTSwg
RU5EX1NFUV9FUlJPUikNCj4gPiBtYXkgYmUgcmVkdW5kYW50IG9yIHVubGlrZWx5IGluIHByYWN0
aWNlLiBJZiB3ZSBmb2N1cyBvbmx5IG9uIHRoZSBtb3N0DQo+ID4gY3JpdGljYWwgY2FzZXMsIHdv
dWxkIHRoZSBmb2xsb3dpbmcgc3Vic2V0IGJlIG1vcmUgYWNjZXB0YWJsZT8NCj4gPiAtIFRDUF9S
RVRSQU5TX0ZBSUxfUVVFVUVEIChwYWNrZXQgc3R1Y2sgaW4gaG9zdC9kcml2ZXIgcXVldWUpDQo+
ID4gLSBUQ1BfUkVUUkFOU19GQUlMX1pFUk9fV0lORE9XIChyZWNlaXZlciB3aW5kb3cgY2xvc2Vk
KQ0KPiA+IC0gVENQX1JFVFJBTlNfRkFJTF9ST1VURSAocm91dGluZyBpc3N1ZXMpDQo+ID4gLSBU
Q1BfUkVUUkFOU19GQUlMX0RFRkFVTFQgKGNhdGNoLWFsbCBmb3IgdW5leHBlY3RlZCBmYWlsdXJl
cykNCj4gDQo+IElzbid0IGl0IGVub3VnaCB0byBhZGQgdGhlIHJldHZhbCB0byB0aGUgdHJhY2Vw
b2ludD8NCj4gQWxsIHRoZSBjYXNlcyB3ZSBjYXJlIGFib3V0IGFscmVhZHkgaGF2ZSBtZWFuaW5n
ZnVsIGFuZCBkaXN0aW5jdCBlcnJvcg0KPiBjb2Rlcy4NCkhpIEpha3ViLA0KSSBhZ3JlZSB0aGF0
IHVzaW5nIGV4aXN0aW5nIGVycm9yIGNvZGVzIChyZXR2YWwpIGluDQpjb3VsZCBiZSBhIHNpbXBs
ZXIgYW5kIG1vcmUgbWFpbnRhaW5hYmxlIGFwcHJvYWNoLg0KDQpJbnN0ZWFkIG9mIGludHJvZHVj
aW5nIG5ldyBUQ1BfUkVUUkFOU18qIGVudW1zLCBJ4oCZbGwgZGlyZWN0bHkNCnBhc3MgdGhlIHJl
dHZhbCB0byB0aGUgdHJhY2Vwb2ludCBpbiBwYXRjaCB2NS4=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPiZndDsgJmd0OyBJIGFncmVlIHRoYXQgc29tZSBv
ZiB0aGUgcmVzdWx0IHR5cGVzIChlLmcuLCBFTk9NRU0sIEVORF9TRVFfRVJST1IpPC9wPjxwPiZn
dDsgJmd0OyBtYXkgYmUgcmVkdW5kYW50IG9yIHVubGlrZWx5IGluIHByYWN0aWNlLiBJZiB3ZSBm
b2N1cyBvbmx5IG9uIHRoZSBtb3N0PC9wPjxwPiZndDsgJmd0OyBjcml0aWNhbCBjYXNlcywgd291
bGQgdGhlIGZvbGxvd2luZyBzdWJzZXQgYmUgbW9yZSBhY2NlcHRhYmxlPzwvcD48cD4mZ3Q7ICZn
dDsgLSBUQ1BfUkVUUkFOU19GQUlMX1FVRVVFRCAocGFja2V0IHN0dWNrIGluIGhvc3QvZHJpdmVy
IHF1ZXVlKTwvcD48cD4mZ3Q7ICZndDsgLSBUQ1BfUkVUUkFOU19GQUlMX1pFUk9fV0lORE9XIChy
ZWNlaXZlciB3aW5kb3cgY2xvc2VkKTwvcD48cD4mZ3Q7ICZndDsgLSBUQ1BfUkVUUkFOU19GQUlM
X1JPVVRFIChyb3V0aW5nIGlzc3Vlcyk8L3A+PHA+Jmd0OyAmZ3Q7IC0gVENQX1JFVFJBTlNfRkFJ
TF9ERUZBVUxUIChjYXRjaC1hbGwgZm9yIHVuZXhwZWN0ZWQgZmFpbHVyZXMpPC9wPjxwPiZndDsm
bmJzcDs8L3A+PHA+Jmd0OyBJc24ndCBpdCBlbm91Z2ggdG8gYWRkIHRoZSByZXR2YWwgdG8gdGhl
IHRyYWNlcG9pbnQ/PC9wPjxwPiZndDsgQWxsIHRoZSBjYXNlcyB3ZSBjYXJlIGFib3V0IGFscmVh
ZHkgaGF2ZSBtZWFuaW5nZnVsIGFuZCBkaXN0aW5jdCBlcnJvcjwvcD48cD4mZ3Q7IGNvZGVzLjwv
cD48cD5IaSBKYWt1Yiw8L3A+PHA+SSBhZ3JlZSB0aGF0IHVzaW5nIGV4aXN0aW5nIGVycm9yIGNv
ZGVzIChyZXR2YWwpIGluPC9wPjxwPmNvdWxkIGJlIGEgc2ltcGxlciBhbmQgbW9yZSBtYWludGFp
bmFibGUgYXBwcm9hY2guPC9wPjxwPjxicj48L3A+PHA+SW5zdGVhZCBvZiBpbnRyb2R1Y2luZyBu
ZXcgVENQX1JFVFJBTlNfKiBlbnVtcywgSeKAmWxsIGRpcmVjdGx5PC9wPjxwPnBhc3MgdGhlIHJl
dHZhbCB0byB0aGUgdHJhY2Vwb2ludCBpbiBwYXRjaCB2NS48L3A+PC9kaXY+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


