Return-Path: <netdev+bounces-208753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58844B0CF48
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 03:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3436C55FD
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1D1A256B;
	Tue, 22 Jul 2025 01:48:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6354A191493;
	Tue, 22 Jul 2025 01:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148904; cv=none; b=elOlVFHBHl+g1Qp4C+EBxZ88fydh+0ll+ecEAUwiAN2yUMcooS3Vggkgqy6J4JixRbvHDFQt/9Gwun9B8TReYddOvWPPZl+hVBwY1WOthxLZp6CBrYI1IrRkDlL03YJvB6aP307zZBhXy5UiLRV3RlZtHfD/mqhrrBzUTOaGDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148904; c=relaxed/simple;
	bh=bA+R9DffdAGIkPh6d0LbRL52OwjbyFaPjg4ZD3/c4z8=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=ZVys1zmIL5igJEiytTyXaiI9oheapP+Kt7mw6h14sKxceGIxCRxAGUbKzSz1EiKhgjprdXIHoW36suqweTX/20om5j/QbgTsW1epzzLfJAfe+9fgbKIAq/KiX9RN8g3gWaMZZwG/YfJ1fNjojHvZAbV5FpcxUXvaqrYcl2p5VkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4bmKsr2h3rz59ys5;
	Tue, 22 Jul 2025 09:48:16 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 56M1m88x055895;
	Tue, 22 Jul 2025 09:48:08 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 22 Jul 2025 09:48:08 +0800 (CST)
Date: Tue, 22 Jul 2025 09:48:08 +0800 (CST)
X-Zmail-TransId: 2af9687eedd8ffffffff9a6-f911e
X-Mailer: Zmail v1.0
Message-ID: <20250722094808945ENOLvzY108YsJFz4CqbaI@zte.com.cn>
In-Reply-To: <20250721171333.6caced4f@kernel.org>
References: 20250721111607626_BDnIJB0ywk6FghN63bor@zte.com.cn,20250721171333.6caced4f@kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <kuba@kernel.org>
Cc: <edumazet@google.com>, <ncardwell@google.com>, <davem@davemloft.net>,
        <dsahern@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuniyu@google.com>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <jiang.kun2@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <he.peilin@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXQtbmV4dCB2NyBSRVNFTkRdIHRjcDogdHJhY2UgcmV0cmFuc21pdCBmYWlsdXJlcyBpbiB0Y3BfcmV0cmFuc21pdF9za2I=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 56M1m88x055895
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 22 Jul 2025 09:48:16 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 687EEDE0.001/4bmKsr2h3rz59ys5



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

PiBPbiBNb24sIDIxIEp1bCAyMDI1IDExOjE2OjA3ICswODAwIChDU1QpIGZhbi55dTlAenRlLmNv
bS5jbiB3cm90ZToNCj4gPiBTdWJqZWN0OiBbUEFUQ0ggbmV0LW5leHQgdjcgUkVTRU5EXSB0Y3A6
IHRyYWNlIHJldHJhbnNtaXQgZmFpbHVyZXMgaW4gdGNwX3JldHJhbnNtaXRfc2tiDQo+IA0KPiBX
aHkgZGlkIHlvdSByZXNlbmQgdGhpcz8/DQoNCkhpIEpha3ViLA0KDQpUaGFua3MgZm9yIGNoZWNr
aW5nISBJIGp1c3Qgd2FudGVkIHRvIGVuc3VyZSB0aGUgdjcgcGF0Y2ggd2FzbuKAmXQgbWlzc2Vk
IOKAlCBpdOKAmXMgaWRlbnRpY2FsIHRvIHRoZSBvcmlnaW5hbC4NClBsZWFzZSBsZXQgbWUga25v
dyBpZiBhbnkgdXBkYXRlcyBhcmUgbmVlZGVkLiBBcHByZWNpYXRlIHlvdXIgdGltZSENCg0KQmVz
dCByZWdhcmRzLA0KRmFuIFl1


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPiZndDsgT24gTW9uLCAyMSBKdWwgMjAyNSAxMTox
NjowNyArMDgwMCAoQ1NUKSBmYW4ueXU5QHp0ZS5jb20uY24gd3JvdGU6PC9wPjxwPiZndDsgJmd0
OyBTdWJqZWN0OiBbUEFUQ0ggbmV0LW5leHQgdjcgUkVTRU5EXSB0Y3A6IHRyYWNlIHJldHJhbnNt
aXQgZmFpbHVyZXMgaW4gdGNwX3JldHJhbnNtaXRfc2tiPC9wPjxwPiZndDsmbmJzcDs8L3A+PHA+
Jmd0OyBXaHkgZGlkIHlvdSByZXNlbmQgdGhpcz8/PC9wPjxwPjxicj48L3A+PHA+SGkgSmFrdWIs
PC9wPjxwPjxicj48L3A+PHA+VGhhbmtzIGZvciBjaGVja2luZyEgSSBqdXN0IHdhbnRlZCB0byBl
bnN1cmUgdGhlIHY3IHBhdGNoIHdhc27igJl0IG1pc3NlZCDigJQgaXTigJlzIGlkZW50aWNhbCB0
byB0aGUgb3JpZ2luYWwuPC9wPjxwPlBsZWFzZSBsZXQgbWUga25vdyBpZiBhbnkgdXBkYXRlcyBh
cmUgbmVlZGVkLiBBcHByZWNpYXRlIHlvdXIgdGltZSE8L3A+PHA+PGJyPjwvcD48cD5CZXN0IHJl
Z2FyZHMsPC9wPjxwPkZhbiBZdTwvcD48L2Rpdj4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


