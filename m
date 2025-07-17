Return-Path: <netdev+bounces-207678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDABCB082C4
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 04:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B9F7A4F4A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 02:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D769C1C8633;
	Thu, 17 Jul 2025 02:13:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E3155A59;
	Thu, 17 Jul 2025 02:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752718384; cv=none; b=AdtGn4+MIeK5ZFm7q5K6EwxmhUOz5JRA1u7RVq9VG0PzkkIMV2SQzPdNw2CVmLaus8WCYdFauNUvs1+4hHlErAEiQA4zHe/NRLWTjrthvpU9nrXlvzQrDxi7u4YfXrJqOYrFtZISrVl4wh2CgjMQ65DHGjbQrndNIiWUt46BHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752718384; c=relaxed/simple;
	bh=9NhBKwyrzpmtVxgSk23CnQtxjPIyKvPPzUT0pV/3PCE=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=Vpuiofq04j3QUfSVLWXanAbYAdRwNqByffC3lv+ZmBALiHXxuJSrwZHb8m+L8Dx/o9enZtv9pdmvyWx+mHqj7A7Plp5pOt+60v13D75zR1eUIarAZysJhyd65tfnvvbDkPB5QURey1hauVMYlX73nVhBjBUHtlEe2/vQdPuqeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bjGfX523rz6Fy5l;
	Thu, 17 Jul 2025 10:12:52 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 56H2CeDM090833;
	Thu, 17 Jul 2025 10:12:40 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 17 Jul 2025 10:12:41 +0800 (CST)
Date: Thu, 17 Jul 2025 10:12:41 +0800 (CST)
X-Zmail-TransId: 2afa68785c19ffffffffe26-47038
X-Mailer: Zmail v1.0
Message-ID: <20250717101241665SpBGi_zaErkDSM2Rgmx3o@zte.com.cn>
In-Reply-To: <CAAVpQUCDJOnwRhjcwFke2vTZQ8rymopC3hpyPteLA3cRgXFz9Q@mail.gmail.com>
References: 20250716100006458kPWBPIJB6IdzWuUKlv4tF@zte.com.cn,CAAVpQUCDJOnwRhjcwFke2vTZQ8rymopC3hpyPteLA3cRgXFz9Q@mail.gmail.com
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
        <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <jiang.kun2@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <he.peilin@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXQtbmV4dCB2Nl0gdGNwOiB0cmFjZSByZXRyYW5zbWl0IGZhaWx1cmVzIGluIHRjcF9yZXRyYW5zbWl0X3NrYg==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl2.zte.com.cn 56H2CeDM090833
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 17 Jul 2025 10:12:52 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68785C24.001/4bjGfX523rz6Fy5l



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

PiA+IHByaW50IGZtdDogInNrYmFkZHI9JXAgc2thZGRyPSVwIGZhbWlseT0lcyBzcG9ydD0laHUg
ZHBvcnQ9JWh1IHNhZGRyPSVwSTQgZGFkZHI9JXBJNCBzYWRkcnY2PSVwSTZjIGRhZGRydjY9JXBJ
NmMgc3RhdGU9JXMgZXJyPSVkIg0KPiA+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBLdW5peXVraUl3YXNo
aW1hIDxrdW5peXVAZ29vZ2xlLmNvbT4NCj4gDQo+IEkgZG9uJ3QgZGVzZXJ2ZSB0aGlzIHRhZy4g
IChBbHNvLCBhIHNwYWNlIGJldHdlZW4gZmlyc3QvbGFzdCBuYW1lIGlzIG1pc3NpbmcuKQ0KPiAN
Cj4gU3VnZ2VzdGVkLWJ5IGNhbiBiZSB1c2VkIHdoZW4gdGhlIGNvcmUgaWRlYSBpcyBwcm92aWRl
ZCBieSBzb21lb25lLA0KPiBidXQgbm90IHdoZW4gc29tZW9uZSBqdXN0IHJldmlld3MgdGhlIHBh
dGNoIGFuZCBwb2ludHMgb3V0IHNvbWV0aGluZw0KPiB3cm9uZy4NCj4gDQo+IEJ1dCBjb2RlLXdp
c2UsIHRoZSBjaGFuZ2UgbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IFJldmlld2VkLWJ5OiBLdW5p
eXVraSBJd2FzaGltYSA8a3VuaXl1QGdvb2dsZS5jb20+DQpIaSBLdW5peXVraSwNCg0KVGhhbmsg
eW91IGZvciB5b3VyIHRob3JvdWdoIHJldmlldyBhbmQgZ3VpZGFuY2UgLSBpdCdzIGdyZWF0bHkg
YXBwcmVjaWF0ZWQuDQpJJ2xsIHN1Ym1pdCB2NyB3aXRoIGNvcnJlY3RlZCB0YWdzIDopLg==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPiZndDsgJmd0OyBwcmludCBmbXQ6ICJza2JhZGRy
PSVwIHNrYWRkcj0lcCBmYW1pbHk9JXMgc3BvcnQ9JWh1IGRwb3J0PSVodSBzYWRkcj0lcEk0IGRh
ZGRyPSVwSTQgc2FkZHJ2Nj0lcEk2YyBkYWRkcnY2PSVwSTZjIHN0YXRlPSVzIGVycj0lZCI8L3A+
PHA+Jmd0OyAmZ3Q7PC9wPjxwPiZndDsgJmd0OyBTdWdnZXN0ZWQtYnk6IEt1bml5dWtpSXdhc2hp
bWEgJmx0O2t1bml5dUBnb29nbGUuY29tJmd0OzwvcD48cD4mZ3Q7Jm5ic3A7PC9wPjxwPiZndDsg
SSBkb24ndCBkZXNlcnZlIHRoaXMgdGFnLiZuYnNwOyAoQWxzbywgYSBzcGFjZSBiZXR3ZWVuIGZp
cnN0L2xhc3QgbmFtZSBpcyBtaXNzaW5nLik8L3A+PHA+Jmd0OyZuYnNwOzwvcD48cD4mZ3Q7IFN1
Z2dlc3RlZC1ieSBjYW4gYmUgdXNlZCB3aGVuIHRoZSBjb3JlIGlkZWEgaXMgcHJvdmlkZWQgYnkg
c29tZW9uZSw8L3A+PHA+Jmd0OyBidXQgbm90IHdoZW4gc29tZW9uZSBqdXN0IHJldmlld3MgdGhl
IHBhdGNoIGFuZCBwb2ludHMgb3V0IHNvbWV0aGluZzwvcD48cD4mZ3Q7IHdyb25nLjwvcD48cD4m
Z3Q7Jm5ic3A7PC9wPjxwPiZndDsgQnV0IGNvZGUtd2lzZSwgdGhlIGNoYW5nZSBsb29rcyBnb29k
IHRvIG1lLjwvcD48cD4mZ3Q7Jm5ic3A7PC9wPjxwPiZndDsgUmV2aWV3ZWQtYnk6IEt1bml5dWtp
IEl3YXNoaW1hICZsdDtrdW5peXVAZ29vZ2xlLmNvbSZndDs8L3A+PHA+SGkgS3VuaXl1a2ksPC9w
PjxwPjxicj48L3A+PHA+VGhhbmsgeW91IGZvciB5b3VyIHRob3JvdWdoIHJldmlldyBhbmQgZ3Vp
ZGFuY2UgLSBpdCdzIGdyZWF0bHkgYXBwcmVjaWF0ZWQuPC9wPjxwPkknbGwgc3VibWl0IHY3IHdp
dGggY29ycmVjdGVkIHRhZ3MgOikuPGJyPjwvcD48L2Rpdj4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


