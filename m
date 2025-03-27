Return-Path: <netdev+bounces-177883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12266A728FD
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 04:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C43189A1AA
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 03:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE5E13C908;
	Thu, 27 Mar 2025 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JChE+cYy"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A585579D2;
	Thu, 27 Mar 2025 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743044738; cv=none; b=UGdepy9WlSLWqyXcpwAJLxn1BYqSlaQUtoXh2jxHDvflSpbRDmxFwN9yKRsN/uXB9+mRYgg2BMn3xxVSpVvPlU5xco3w+mPNYBCBcbyGkb+l5fndQK561E1qfEuZRDsDSeqzN3WI7TPQN1SnJ+wCWMrqArAOpvgKpPsS0xCh8OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743044738; c=relaxed/simple;
	bh=MCo8ZIxmGEDGSrPjvYiZIDrPNwkYgRNXm1IzE0Etl+o=;
	h=Date:From:To:Cc:Subject:Mime-Version:Message-ID:Content-Type; b=jsadKEigIseEoeS6wmP0HYYeFPbuzN9muEBKCMtoiaKGBPXo5RHG0Tkw/UAl7O5GYkCcnYPCL0ieeStGNaCgheZdd10gbzW0lh9B3U4cvXeypq4NxKVxZa5ZHe4S/rN8aQKMjyOu/rbOnN4NNK/HBRDKMxJ1E7VHpNZ7KS95XNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JChE+cYy; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Mime-Version:Message-ID:
	Content-Type; bh=MCo8ZIxmGEDGSrPjvYiZIDrPNwkYgRNXm1IzE0Etl+o=;
	b=JChE+cYy4NOqaoE6NmJ1/VmJQiNBMlnL2GAXCplQu6zz6AbEA92eS0Aea1+E9V
	9dCTtMcmKOcioIrl9Q9vrnZQedQYPjio6hWjxTvu6STYPpDkNpzI0Cq5UBcmR2in
	aW7QBCj/of8mL16i9gmAEJr9FYJFlXdIVBymY3hEteaAI=
Received: from WIN-S4QB3VCT165 (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXH21TwORn8CPxCA--.40412S2;
	Thu, 27 Mar 2025 11:04:52 +0800 (CST)
Date: Thu, 27 Mar 2025 11:04:53 +0800
From: "mowenroot@163.com" <mowenroot@163.com>
To: "Paul Moore" <paul@paul-moore.com>, 
	"Jakub Kicinski" <kuba@kernel.org>, 
	netdev <netdev@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	"Bitao  Ouyang" <1985755126@qq.com>
Subject: Fw:  [PATCH] netlabel: Fix NULL pointer exception caused by CALIPSO on IPv4 sockets
X-Priority: 3
X-GUID: 8EFA12FD-24E2-4484-8D4E-7B3A30F62036
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.331[cn]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <2025032711045196042914@163.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-CM-TRANSID:_____wDXH21TwORn8CPxCA--.40412S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW5AF1fWF1UXryxKFy3Jwb_yoW8GrW8pF
	Z8Kryjyw1kAa1xtr1vkF47Zwn0g34kJ3y3GFWfK34DZw45J3WxWF1xK3y0yFy7WrZagFW0
	qr4jqF9xWayjvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UljgsUUUUU=
X-CM-SenderInfo: pprzv0hurr3qqrwthudrp/1tbiXwAdlGfkvzknSgAAs+

T24gVGh1LCBNYXIgMjcsIDIwMjUgYXQgMzozOCBBTSBQYXVsIE1vb3JlIHBhdWxAcGF1bC1tb29y
ZS5jb20gd3JvdGU6Cgo+IEZvciBhbGwgdGhyZWUgZnVuY3Rpb24sIEknZCBwcm9iYWJseSBhZGQg
YSBzaW5nbGUgYmxhbmsgbGluZSBiZXR3ZWVuIHRoZSBsb2NhbCB2YXJpYWJsZSBkZWNsYXJhdGlv
bnMgYW5kIHRoZSBjb2RlIGJlbG93IGZvciB0aGUgc2FrZSBvZiByZWFkYWJpbGl0eS4gSSdkIHBy
b2JhYmx5IGFsc28gZHJvcCB0aGUgY29tbWVudCBhcyB0aGUgY29kZSBzZWVtcyByZWFzb25hYmx5
IG9idmlvdXMgKGluZXQ2X3NrKCkgY2FuIHJldHVybiBOVUxMLCB3ZSBjYW4ndCBkbyBhbnl0aGlu
ZyB3aXRoIGEgTlVMTCBwdHIgc28gYmFpbCksIGJ1dCBuZWl0aGVyIGFyZSByZWFzb25zIGZvciBu
b3QgYXBwbHlpbmcgdGhpcyBwYXRjaCwgaWYgYW55dGhpbmcgdGhleSBjYW4gYmUgZml4ZWQgdXAg
ZHVyaW5nIHRoZSBtZXJnZSBhc3N1bWluZyB0aGUgcGF0Y2ggYXV0aG9yIGFncmVlcy4KPgo+IEFu
eXdheSwgdGhpcyBsb29rcyBnb29kIHRvIG1lLCBKYWt1YiBhbmQvb3Igb3RoZXIgbmV0ZGV2IGZv
bGtzLCB3ZSBzaG91bGQgZ2V0IHRoaXMgbWFya2VkIGZvciBzdGFibGUgYW5kIHNlbnQgdXAgdG8g
TGludXMsIGRvIHlvdSB3YW50IHRvIGRvIHRoYXQgb3Igc2hvdWxkIEk/CgpUaGFuayB5b3UgZm9y
IHlvdXIgYWNrbm93bGVkZ21lbnQgYW5kIHN1Z2dlc3Rpb25zISBZb3VyIGluc2lnaHRzIGhhdmUg
YmVlbiB2ZXJ5IGhlbHBmdWwgdG8gdXMuCgpXZSBmdWxseSBhZ3JlZSB3aXRoIHlvdXIgc3VnZ2Vz
dGlvbnMgcmVnYXJkaW5nIGNvZGUgZm9ybWF0dGluZyBhbmQgY29tbWVudCBhZGp1c3RtZW50cy4g
U2luY2UgeW91IGFyZSBtb3JlIGZhbWlsaWFyIHdpdGggdGhlIGNvZGUsIHdlIHdvdWxkIGFwcHJl
Y2lhdGUgaXQgaWYgeW91IGNvdWxkIGhlbHAgaGFuZGxlIHRoZXNlIG1vZGlmaWNhdGlvbnMgYW5k
IGNvbXBsZXRlIHRoZSBtZXJnZS4gSWYgeW91IGFyZSB3aWxsaW5nIHRvIGRvIHNvLCB3ZSB3b3Vs
ZCBiZSB2ZXJ5IGdyYXRlZnVsIQoKUHJldmlvdXNseSwgdGhlIGVtYWlsIGZhaWxlZCB0byBiZSBk
ZWxpdmVyZWQgdG8gbmV0ZGV2QHZnZXIua2VybmVsLm9yZyBhbmQgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZyBkdWUgdG8gZm9ybWF0dGluZyBpc3N1ZXMuIFdlIHNpbmNlcmVseSBhcG9sb2dp
emUgZm9yIGFueSBpbmNvbnZlbmllbmNlIHRoaXMgbWF5IGhhdmUgY2F1c2VkLgoKVGhhbmsgeW91
IGFnYWluIGZvciB5b3VyIGd1aWRhbmNlIGFuZCBzdXBwb3J0LiBXZSBhcmUgZGVsaWdodGVkIHRv
IGxlYXJuIGZyb20geW91IQoKVGhhbmtzIGFnYWluLgogRGViaW4gWmh1ICYgQml0YW8gT3V5YW5n
Cg==


