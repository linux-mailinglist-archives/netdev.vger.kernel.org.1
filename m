Return-Path: <netdev+bounces-258701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE8lNytvkGk8ZgEAu9opvQ
	(envelope-from <netdev+bounces-258701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:48:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2721713BF64
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40B50301ECF3
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 12:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA71C1A3166;
	Sat, 14 Feb 2026 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="mCXOmw+t"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D441DFF0;
	Sat, 14 Feb 2026 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771073305; cv=none; b=s1IUMD0Hc+rBxdbzqraE7L8TxABU2gKCFAAqUxJV35f2YuVWQZRXkGTfory2XbPJ0m38oCEIYZjL27JLz8gvxm8RP3wegjMvF+9WSzApHxElaBdPEvSWz4tXhB2pwHxrmxVt475VEFSnvhbL/KnjmU+/UE+E5l6IcBnQ1zzAK+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771073305; c=relaxed/simple;
	bh=jIGZJ7iO+1Zv2oo0BKUYzYFa8I1ANZ+4XSUTzXvaZrE=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=d1D61q3uqeQQlXpWPhMzV1j5DNKThBpIG9aInOSdQS7nSmz+U1ndSaVTOaFXhEc/UAl4J8ERCZXkWpaExgRU5AXRIhexPzSLowAnDj9050XdW3J5BkfGnceEwNi/7xj3e5D1Bn7IrG76BKaFdoiC15rSaecbehwJXiQM5WjoQU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=mCXOmw+t; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1771073265;
	bh=jIGZJ7iO+1Zv2oo0BKUYzYFa8I1ANZ+4XSUTzXvaZrE=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=mCXOmw+t4CN+x9ypoRPNMAovtWnbeDwY0YK385Mwv+NhEvNj7Deb/+VsfIkhJvPrQ
	 yIJLMtLr21rorCWrN+DKMfk3Oup7Vtl/JweMLcRitNj2I6B1NboRdHrCNdZQYooiKl
	 j3WLbqYYN2wKYLVRYjUHSlJZT2GyzMcE164jGiUU=
EX-QQ-RecipientCnt: 7
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqTSsxwgbpkr0LCSZa5nmih4aWEFJau9uz8=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: vmURUJTSK9IshxV5uilEpoM9Z9Nw00BZad7D+QH3YCc=
X-QQ-STYLE: 
X-QQ-mid: lv3gz6b-1t1771073259t9a99ad35
From: "=?utf-8?B?5Yav5ZiJ5Luq?=" <23210240148@m.fudan.edu.cn>
To: "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>
Cc: "=?utf-8?B?ZHNhaGVybg==?=" <dsahern@kernel.org>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: [BUG] Potential Null Pointer Dereference in udp_gro_receive_segment Function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 14 Feb 2026 20:47:38 +0800
X-Priority: 3
Message-ID: <tencent_5F0CA7F84A4F08C62E08F769@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 14860153300059240389
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 14 Feb 2026 20:47:39 +0800 (CST)
Feedback-ID: lv:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N8WrbzObJSkE5HSqKRmqBXn6j8wziwIs7uifF7Zel/h0ByS85rXx9DOU
	yT7Uwmh+ZqrZ2R1mgkqH0oaL25cRerKDFK7Qfw0ui+GGxCU7aI9GXxxeD5LDuU2InYhh3bz
	qMtfQCgkrRr2aT2tS6zJ7P02wKRJuQwOoO44HCt4Xc7cU1eB2YhRC2BUT/hRsd9g7ul6ZD/
	dE6s7p/wMaGTHSoxZ3R24KnVLwZb/FDvdYHOR3J2nGWfHgu9YXtVyOi6/5S0Q4Pg2uy2TTV
	LICrXaW2cz1iw5iREfyXMADst0xK9icKO0W8szgVwKnY42ppIQl7WHhl6wBwTZr7FBEHfgb
	oNQ2N+SdV0YorfEbbz7coztoY9cxgf4l5XibuGGZlq9sw9kH6bP0VXrv9ZFY/L3hYVb9qmX
	VFPME3UssBPxmkmR7C+ulhoK6/qxYbqjJwoy+Y8/beV7lNyuu4wzb7xM+w9GotDA0MDJqaS
	BR50x3sLEAi69u6DhLRXDvHB4CwvXV67aTaYfqYGIZR/j/wnmAdlXgVLnoHX/JRmcRvc6BG
	ipQJYVcuPl/zZF3ejV1PT3RXly8JK/xwHk+Zor5H6mUm1A2ycoehrUEx1Jq1e+GqIliwpf6
	24Nb3dvWiRxC6AZbR9KwSojKxtlAO6ddgXMssnUJbriDCl8wEcfQtpZs6roa8UjVjqGtwdE
	8daJuYLDU5RzPX/e8m3s6sf1Jh0/LpZhNw2I+m8rNEnqt/Zjtaff68URD5PY4O+QTVGXoLB
	ANbfvpeD3/RVOzFwNycaUoRBELTbmFRUR4LqbNgv1lYycNQrplkzYRjdGlZ9S128qfmrxeI
	LaBSD10P3Vc2K9qbybPy3Q4ZE3tG3POYOuoDlj+xv2kKCO9u+CJKpa/Yc/Elv4B5rLDxc2y
	FpryZLh7UNTb9wmrQSvX94kkB4qm8+Hq+8jH/N2JCcbrCEeTd/5Iv50d/uRX6BKwtXm1Og9
	vwOiw2Imd/KlajNoZIkDx+FERhMI9eLQHlf0UkUAgWJst060FV+etw+oaW9eL3AQYjVW1H1
	lCTkU9QNUafTMKWqGo
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[m.fudan.edu.cn,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[m.fudan.edu.cn:s=sorc2401];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258701-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[m.fudan.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[23210240148@m.fudan.edu.cn,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,m.fudan.edu.cn:dkim,qq.com:mid]
X-Rspamd-Queue-Id: 2721713BF64
X-Rspamd-Action: no action

RGVhciBNYWludGFpbmVyLA0KDQpPdXIgdGVhbSByZWNlbnRseSBkZXZlbG9wZWQgYSBudWxs
LXBvaW50ZXItZGVyZWZlcmVuY2UgKE5QRCkgdnVsbmVyYWJpbGl0eSBkZXRlY3Rpb24gdG9v
bCwgYW5kIHdlIHVzZWQgaXQgdG8gc2NhbiB0aGUgTGludXggS2VybmVsICh2ZXJzaW9uIDYu
OS42KS4gQWZ0ZXIgbWFudWFsIHJldmlldywgd2UgaWRlbnRpZmllZCBhIHBvdGVudGlhbGx5
IHZ1bG5lcmFibGUgY29kZSBzbmlwcGV0IHRoYXQgY291bGQgbGVhZCB0byBhIG51bGwtcG9p
bnRlciBkZXJlZmVyZW5jZSBidWcuIFdlIHdvdWxkIGFwcHJlY2lhdGUgeW91ciBleHBlcnQg
aW5zaWdodCB0byBjb25maXJtIHdoZXRoZXIgdGhpcyB2dWxuZXJhYmlsaXR5IGNvdWxkIGlu
ZGVlZCBwb3NlIGEgcmlzayB0byB0aGUgc3lzdGVtLg0KDQpWdWxuZXJhYmlsaXR5IERlc2Ny
aXB0aW9uOg0KRmlsZTogIG5ldC9pcHY0L3VkcF9vZmZsb2FkLmMNCkluIHRoZSBmdW5jdGlv
biB1ZHBfZ3JvX3JlY2VpdmVfc2VnbWVudCwgd2UgZm91bmQgdGhlIGZvbGxvd2luZyBsaW5l
IG9mIGNvZGU6DQoNCmlmICghdWgtPmNoZWNrKSB7DQoNClRoZSBpc3N1ZSBhcmlzZXMgYmVj
YXVzZSB0aGUgdWggcG9pbnRlciBtYXkgYmUgcGFzc2VkIGFzIE5VTEwgaW4gY2VydGFpbiBz
aXR1YXRpb25zLiBTaW5jZSB1aCBpcyBOVUxMLCBhY2Nlc3NpbmcgdWgtPmNoZWNrIGluIHRo
ZSBzdGF0ZW1lbnQgY291bGQgcmVzdWx0IGluIGEgbnVsbC1wb2ludGVyIGRlcmVmZXJlbmNl
Lg0KDQpQcm9wb3NlZCBGaXg6DQpUbyBwcmV2ZW50IHRoZSBwb3RlbnRpYWwgbnVsbC1wb2lu
dGVyIGRlcmVmZXJlbmNlLCB3ZSBzdWdnZXN0IGFkZGluZyBhIE5VTEwgY2hlY2sgZm9yIHRo
ZSB1aCBwb2ludGVyIGJlZm9yZSBhdHRlbXB0aW5nIHRvIGRlcmVmZXJlbmNlIHVoLT5jaGVj
ayBpbiB0aGUgbGluZS4NCg0KUmVxdWVzdCBmb3IgUmV2aWV3Og0KV2Ugd291bGQgYXBwcmVj
aWF0ZSB5b3VyIGV4cGVydCBpbnNpZ2h0IHRvIGNvbmZpcm0gd2hldGhlciB0aGlzIHZ1bG5l
cmFiaWxpdHkgaW5kZWVkIHBvc2VzIGEgcmlzayB0byB0aGUgc3lzdGVtLCBhbmQgaWYgdGhl
IHByb3Bvc2VkIGZpeCBpcyBhcHByb3ByaWF0ZS4gSWYgdGhlcmUgYXJlIHJlYXNvbnMgd2h5
IHRoaXMgaXNzdWUgZG9lcyBub3QgcHJlc2VudCBhIHJlYWwgcmlzayAoZS5nLiwgdGhlIE5V
TEwgY2hlY2sgaXMgcmVkdW5kYW50IG9yIHVubmVjZXNzYXJ5KSwgd2Ugd291bGQgYmUgZ3Jh
dGVmdWwgZm9yIGNsYXJpZmljYXRpb24uDQoNClRoYW5rIHlvdSBmb3IgeW91ciB0aW1lIGFu
ZCBjb25zaWRlcmF0aW9uLg==


