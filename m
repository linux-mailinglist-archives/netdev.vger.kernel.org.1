Return-Path: <netdev+bounces-78613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EFB875E05
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95FA71C20C76
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 06:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099121DFC6;
	Fri,  8 Mar 2024 06:43:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483818E01
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709880179; cv=none; b=X8X2/n/Tnsd9mSNomdD+7oti+pmMgS4xctVJxzjxD9j7tzx5HDU+IKtyUcixYdvJHnAtvAeexOlqcrKAuxwbu17q0tXmdN2O8PpbyAbRs78lMogQKbF3ZhGx1ZaCJZBPBeMvmwtv/bs7vMJDZQ3NTqbBnk3k7X1upm4N/vkhJIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709880179; c=relaxed/simple;
	bh=5stAt59YGls7zMn74cgJa2r+rx2wRufjNvoLmeCRdRM=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=ncDv0ud7Lhwpcekxo2neqS8a3Eb5HMoagkiG+Y+q6N/odxRPXFidJIc9n1ldjDxmr9bTIc9LSqqK4WFSJGSohovMwdRPaEwtpeIANfBdZIf54Cu74pKTAbRnPe2zSZjS9G2O9kLNXkT6zHWgcc1YTZ4vdwXnDuzxHcLloX94UDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-GoodBg: 2
X-BAN-DOWNLOAD: 1
X-BAN-SHARE: 1
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-FEAT: zT6n3Y95oi2xquFErfnCkEp8VuRLP1VcUW2G0Wh9aCyZjlGIoceYdQdF3Vtnu
	Vf5hhl03TNVh75SrF8+K6VNeRYdXWHTgYJGAn8US6of9Z26G2Y20aJ2vX2+sNlV9BDp8lQA
	4npV8DSqDr29hFZZcxtVbN+r8odju2hwhHV7Kmx17AnMZfVVLGXtpTjWJHHDCveXmvKao//
	gw5Q4jlfNxAaZhZGpRz9idSkheGNifSDl+hZpzlI/c4pp/U1EYqllcNtzldg5NoTm0nunpC
	DJK+GTkyUTY72BVeZN4chc03pOn5cNU3Xg0XBVpJDNhlP5EZ9sP1uCD+y6gjPrDvqFifXND
	mjy6jwTeumye0sEKQvOROxwV9JaeunBTUDoEHwEptBMTOHV4flxbp1Tg3hsEQ==
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: 4jBzVGpm81IRMlxRDdKE1KQwjU3Z1dzII4Df080VjvU=
X-QQ-STYLE: 
X-QQ-mid: t7gz7a-0t1709880163t844016
From: "=?utf-8?B?6ZmI5ZiJ5piA?=" <jiayunchen@smail.nju.edu.cn>
To: "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>
Subject: puzzling features on ip change/replace
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 8 Mar 2024 14:42:42 +0800
X-Priority: 3
Message-ID: <tencent_35777FB65087C7C646A80431@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 354667509582755388
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Fri, 08 Mar 2024 14:42:44 +0800 (CST)
Feedback-ID: t:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

SGkgYWxsLA0KDQpJIGFtIHRlc3Rpbmcgc29tZSBiYXNpYyBmZWF0dXJlcyBmb3IgaXByb3V0
ZTIuIFdoZW4gSSB0ZXN0IHRoZSB1c2FnZSBvZiAnaXAgY2hhbmdlJywgdGhlIG1hbnVhbCBz
ZWVtcyBub3QgdG8gb2ZmZXIgZW5vdWdoIGluZm9ybWF0aW9uLg0KDQpUaGUgc3lub3BzaXMg
dGVsbHMgdGhhdDoNCg0KYGBgDQogaXAgYWRkcmVzcyB7IGFkZCB8IGNoYW5nZSB8IHJlcGxh
Y2UgfSBJRkFERFIgZGV2IElGTkFNRSBbDQogICAgICAgICAgICAgICBMSUZFVElNRSBdIFsg
Q09ORkZMQUctTElTVCBdDQpgYGANCg0KYW5kIElGQUREUiBjYW4gYmUgaW1wZWxlbWVudGVk
IGFzOg0KDQpgYGANCklGQUREUiA6PSBQUkVGSVggfCBBRERSIHBlZXIgUFJFRklYIFsgYnJv
YWRjYXN0IEFERFIgXSBbIGFueWNhc3QNCiAgICAgICAgICAgICAgIEFERFIgXSBbIGxhYmVs
IExBQkVMIF0gWyBzY29wZSBTQ09QRS1JRCBdIFsgcHJvdG8NCiAgICAgICAgICAgICAgIEFE
RFJQUk9UTyBdDQpgYGANCg0KU28gSSBhbSBjb25mdXNpbmcgYWJvdXQgd2hldGhlciBwYXJ0
cyBvZiBJRkFERFIgY2FuIGJlIGNoYW5nZWQgdGhyb3VnaCAnaXAgY2hhbmdlJyBjb21tYW5k
IG9yICdpcCBjaGFuZ2UnIGNvbW1hbmQgY2FuIG9ubHkgY2hhbmdlIHRoZSBMSUZFVElNRT8N
Cg0KSGVyZSBpcyBteSB0ZXN0IHNjZW5hcmlvOg0KDQpgYGANCmlwIGFkZHIgYWRkIDEuMS4x
LjEvMzIgZGV2IGV0aDAgbGFiZWwgZXRoMDpYICMgdGhpcyBjb21tYW5kIHdvcmtzLCBhZGRp
bmcgYSBuZXcgaXAgYWRkciB0byBldGgwIHdpdGggbGFiZWwgWCwgZXhpdGVkIHdpdGggMA0K
DQppcCBhZGRyIGFkZCAyLjIuMi4yLzMyIGRldiBldGgwIGxhYmVsIGV0aDA6WQ0KDQppcCBh
ZGRyIGNoYW5nZSAxLjEuMS4xLzMyIGRldiBldGgwIGxhYmVsIGV0aDA6WSAjIHRoaXMgY29t
bWFuZCBhbHNvIGV4aXRzIHdpdGggMCwgYnV0IGl0IHRha2VzIG5vIGVmZmVjdCBpbiBmYWN0
Lg0KYGBgDQoNCkFuZCB3aGVuIEkgdHJ5IHRvIGNoZWNrIHRoZSBpbmZvOg0KDQpgYGANCmlw
IGFkZHIgc2hvdyBkZXYgZXRoMCBsYWJlbCBldGgwOlkgIyBpdCBzaG93cyB0aGUgaXAgMi4y
LjIuMi8zMiBvbmx5Lg0KYGBgDQoNCkl0J3MgbmF0dXJhbCB0byBtYW5hZ2UgdGhlIGlwIGFk
ZHJlc3MgdGhyb3VnaCB0aGUgbGFiZWwgaW4gdGhlIHJlYWwgc2NlbmFyaW9zLCBidXQgdGhp
cyBiZWhhdmlvciByZWFsbHkgcHV6emxlcy4gQXQgbGVhc3QsIGl0IHNob3VsZCBkaXNwbGF5
IHNvbWUgZXJyb3IgbWVzc2FnZSBpZiB0aGUgY2hhbmdlIGNvbW1hbmQgaXMgZmFpbGVkLCBy
YXRoZXIgdGhhbiBwcmV0ZW5kIHRoYXQgbm90aGluZyBoYXBwZW5lZCBhbmQgZXhpdCAwIHNs
aWdodGx5Lg0KDQpNYXliZSBJIGNhbiBwdWxsIGEgcGF0Y2ggb24gZG9jdW1lbnRhdGlvbiB0
byBleHBsYWluIHRoaXM/IE9yIGZpeCB0aGUgcmV0dXJuIGNvZGUgZm9yIG15IHRoaXJkIGNv
bW1hbmQ/DQoNCg0KQ2hlZXJzLA0KQ2hlbiBKaWF5dW4=


