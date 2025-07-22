Return-Path: <netdev+bounces-208779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8640BB0D1B6
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7AA5468B5
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 06:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E405428C873;
	Tue, 22 Jul 2025 06:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C01CF7AF;
	Tue, 22 Jul 2025 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164628; cv=none; b=jvQykfDaId5L+e+AejgEu/Ru9YFC1rsH3gv4u/T0HO2lFEOPEiGOS6N3qmmkb/iUcrAIHannmbEye1qfbzzPAyRJzGdsElbieyeZwd/DxncNCMthsyr6kd5mU5T3ibM+ZVN/ruPEAG1LgpC2jxxqS0+o2HyGUlqsauE05N88VkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164628; c=relaxed/simple;
	bh=X3m0bEDpzyejvM3oMqRL6s6ZB4rqOd4i/z4KryWrKS4=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=pzc9ruLSgKcFu8BL1mhAM58Dry9kGLFJHYQwrRqY7LXE5ryxbQVGFnFz2vwf9lFUsflpqsy0yMkzpdvy4+ziY8t0Zx4HRGm/cjPMso7PP3nXmKhAJ3J3SKuwgOaewb2nq0pRt2NZK7bZl+L0AHi6gCo3Y8bLhM393EwotOoKOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bmRh63sV3z6FyBr;
	Tue, 22 Jul 2025 14:10:14 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 56M6A2Th040888;
	Tue, 22 Jul 2025 14:10:02 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 22 Jul 2025 14:10:04 +0800 (CST)
Date: Tue, 22 Jul 2025 14:10:04 +0800 (CST)
X-Zmail-TransId: 2af9687f2b3c7ca-68dd4
X-Mailer: Zmail v1.0
Message-ID: <20250722141004103ZDPniL4wEAkAUVVhyyQMW@zte.com.cn>
In-Reply-To: <CAAVpQUDaSccbmOC0sgihBYPTdtSE2OsFOJXC6s58QS81a+8nkA@mail.gmail.com>
References: 20250721171333.6caced4f@kernel.org,20250722094808945ENOLvzY108YsJFz4CqbaI@zte.com.cn,CAAVpQUDaSccbmOC0sgihBYPTdtSE2OsFOJXC6s58QS81a+8nkA@mail.gmail.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <kuniyu@google.com>
Cc: <kuba@kernel.org>, <edumazet@google.com>, <ncardwell@google.com>,
        <davem@davemloft.net>, <dsahern@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <jiang.kun2@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <he.peilin@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXQtbmV4dCB2NyBSRVNFTkRdIHRjcDogdHJhY2UgcmV0cmFuc21pdCBmYWlsdXJlcyBpbiB0Y3BfcmV0cmFuc21pdF9za2I=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl2.zte.com.cn 56M6A2Th040888
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 22 Jul 2025 14:10:14 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 687F2B46.001/4bmRh63sV3z6FyBr



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

PiA+IFRoYW5rcyBmb3IgY2hlY2tpbmchIEkganVzdCB3YW50ZWQgdG8gZW5zdXJlIHRoZSB2NyBw
YXRjaCB3YXNu4oCZdCBtaXNzZWQg4oCUIGl04oCZcyBpZGVudGljYWwgdG8gdGhlIG9yaWdpbmFs
Lg0KPiANCj4gWW91IGNhbiBjaGVjayB0aGUgcGF0Y2ggc3RhdHVzIGluIHBhdGNod29yaywgYW5k
IGFjdHVhbGx5IHRoaXMgdjcNCj4gbWFya2VkIHRoZSBwcmV2aW91cyB2NyBhcyBTdXBlcnNlZGVk
LCBzbyB5b3UgZGlkbid0IG5lZWQgdG8gcmVzZW5kIDopDQo+IA0KPiBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBmL2xpc3QvP3N1Ym1pdHRlcj0yMTc1NDkmc3Rh
dGU9Kg0KDQpIaSBLdW5peXVraSwNCg0KVGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbiEgSeKA
mXZlIGNoZWNrZWQgdGhlIFBhdGNod29yayBsaW5rIGFuZCBub3cNCnNlZSB0aGUgdjcgc3RhdHVz
KCJOZXciKS4gTXkgYXBvbG9naWVzIGZvciB0aGUgcmVkdW5kYW50IHJlc2VuZCDigJQgSeKAmWxs
DQphdm9pZCB0aGlzIGluIHRoZSBmdXR1cmUuDQoNCkFwcHJlY2lhdGUgeW91ciBwYXRpZW5jZSBh
bmQgZ3VpZGFuY2UhDQoNCkJlc3QgcmVnYXJkcywNCkZhbiBZdQ==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPiZndDsgJmd0OyBUaGFua3MgZm9yIGNoZWNraW5n
ISBJIGp1c3Qgd2FudGVkIHRvIGVuc3VyZSB0aGUgdjcgcGF0Y2ggd2FzbuKAmXQgbWlzc2VkIOKA
lCBpdOKAmXMgaWRlbnRpY2FsIHRvIHRoZSBvcmlnaW5hbC48L3A+PHA+Jmd0OyZuYnNwOzwvcD48
cD4mZ3Q7IFlvdSBjYW4gY2hlY2sgdGhlIHBhdGNoIHN0YXR1cyBpbiBwYXRjaHdvcmssIGFuZCBh
Y3R1YWxseSB0aGlzIHY3PC9wPjxwPiZndDsgbWFya2VkIHRoZSBwcmV2aW91cyB2NyBhcyBTdXBl
cnNlZGVkLCBzbyB5b3UgZGlkbid0IG5lZWQgdG8gcmVzZW5kIDopPC9wPjxwPiZndDsmbmJzcDs8
L3A+PHA+Jmd0OyBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBm
L2xpc3QvP3N1Ym1pdHRlcj0yMTc1NDkmYW1wO3N0YXRlPSo8L3A+PHA+PGJyPjwvcD48cD5IaSBL
dW5peXVraSw8L3A+PHA+PGJyPjwvcD48cD5UaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uISBJ
4oCZdmUgY2hlY2tlZCB0aGUgUGF0Y2h3b3JrIGxpbmsgYW5kIG5vdzwvcD48cD5zZWUgdGhlIHY3
IHN0YXR1cygiTmV3IikuIE15IGFwb2xvZ2llcyBmb3IgdGhlIHJlZHVuZGFudCByZXNlbmQg4oCU
IEnigJlsbDwvcD48cD5hdm9pZCB0aGlzIGluIHRoZSBmdXR1cmUuPC9wPjxwPjxicj48L3A+PHA+
QXBwcmVjaWF0ZSB5b3VyIHBhdGllbmNlIGFuZCBndWlkYW5jZSE8L3A+PHA+PGJyPjwvcD48cD5C
ZXN0IHJlZ2FyZHMsPC9wPjxwPkZhbiBZdTwvcD48L2Rpdj4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


