Return-Path: <netdev+bounces-258702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KXZMOy1wkGmkZgEAu9opvQ
	(envelope-from <netdev+bounces-258702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:53:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD3913BF7F
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59A043014123
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 12:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F7E1E51E0;
	Sat, 14 Feb 2026 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="IzhqrfaB"
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF951A3166;
	Sat, 14 Feb 2026 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771073575; cv=none; b=R4q9J2uU9MjN267PGbZ4XxCotX6t0iJRyregn8XwR9VcIdiXU46SktRQDICCi3Tva3jiP43mLAV/UAeAlEj5o9pcLf+cmSXTdG9AbK8kxT7aH0kNbFWFnK3PNDb8/NNuQSfQ9CzkBTi1bLFpUMfIvnO4//rwb7vcShYiAsVBIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771073575; c=relaxed/simple;
	bh=VwJrVAfiy9kCDSTZ7XHcCpxzJkbVmXP/PETs7p5E0uM=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=nyl8rg1F8fcmp9dZD9R1jaFkSwq5yWX4ggs7gwFIswNqp7hhkgUbMnrSbVZwCAobDWEdUEuvW7WFpSNCfmHXR0wAwVQLA/9J7YrXLwfQcBi4Vn9jfBJbH5D0535LSZ0phZVwi3uUDjC1mhGG2Ow7WrGvrHwAaA1iC608kJf88+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=IzhqrfaB; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1771073526;
	bh=VwJrVAfiy9kCDSTZ7XHcCpxzJkbVmXP/PETs7p5E0uM=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=IzhqrfaB9I4fAFcX8KGMN1m/4nZ4x0JBKELP1bCXAtZTN0ouJtCMkXSnlLE/nDxSL
	 jSIIhnXJMQEDLvEPw/z1QLwqdGzsHmz4ASCg70j3wJLjUibFLxyutEnPP4GI5Vi/Eo
	 Wj6uj7isUTIck4sWmwPBND0rrg8sS8i7qmkUMo9U=
EX-QQ-RecipientCnt: 7
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqR3BzPw6xF2yYOMzhADaK1k6/GpcrrpT/I=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: zQxz3uRvsQv4OvYREDCA5C7bKQZyzVt2/GPUKeHLt+A=
X-QQ-STYLE: 
X-QQ-mid: lv3gz6b-1t1771073520t75c3c79d
From: "=?utf-8?B?5Yav5ZiJ5Luq?=" <23210240148@m.fudan.edu.cn>
To: "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>
Cc: "=?utf-8?B?ZHNhaGVybg==?=" <dsahern@kernel.org>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: [BUG] Potential Null Pointer Dereference in fib6_purge_rt Function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 14 Feb 2026 20:51:59 +0800
X-Priority: 3
Message-ID: <tencent_6071B97978D6B5C13EFB5B01@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 10229671259526440466
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 14 Feb 2026 20:52:01 +0800 (CST)
Feedback-ID: lv:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: M2GOzXfxLYLpm1eRUlSIoX7W+44QUwGOWVmmpXMC/Ru+/adYbtaaSYwT
	1uUhaGnX+XjbYQexms5fvk6Oz9xW4BOSf6OVZ5EoKuNdWnitzdOF9zLOH9M3ykNDXiBIU6I
	le1c7trVX5qlKZAsU3k/0viGMv7SnhtZXlicmHrwSB74IHECyFC4vqHd7j/QXdGQM31yLls
	TD1c8cD0Q7PwAsIF6n4JmvUKi7QCiPYl14PTTEZAyokZr7kQ99gwedlG6iEr8JVS1Lpg8TK
	/S9mZq24xN/tCmVWk3MeeHSyEKEWvdTJOpK23MmjSeg1HIfPoVUwNLQQDA5kwUGjQDdGFd4
	0baSmRzx9VBUSG4w73vZ5evYzIUPyoAO5T7dE+LDy2mh9qsFFpXS9Ah3yIuvCHFqTYWe6Da
	/VWHyz4MJujUDPl3Oij5NH3jEJ1pRPnIiBWkCTlAIwGN7INvs1yLs+7sg7Vn5HG8/ItzvJp
	AuxsfCHg6YfTj3Y3a2aHv3+hu9xDRDZ/YeJsYFjcNjmFx7qrrO9LlXzWlRX5qwcHEOiKueg
	TWBsdn53JXAreC4k56utasKqNj/ZzvYOdPTaBZ0lgEkbOK9kVrs2FvvpamO+XVCh3QdZhF4
	qtcFVuXciMVc1tMCQ7fJBGVbUziAp5MDrk2+ZERGIz9bfYl761Ku7I3r75DP+ouRAVHH6yC
	j3yzmxKpgrrfDtJsy6oejE4uN9rqNHfQezdZ9e7NVIw0EdhbvAK2uX1Rhqkh/VN1DiDd+ED
	lTTtwZP3vPlvru2kFghrf3YKjLooOjrGmVUvLdZzU23rUPwboXV3L5orGpK19Vgrq9Guy26
	9EfIizlx8CGaRpziashY0KVyQhxs3kJk42aYfvTHTuqbXVmt5Khm3jvFGx0g3KmCLXiebsl
	hls4bha57LHi3hRWPZRT+TdtEX0mvf7gonUOfs6Q0e8HvWEnGFYCBkRzJb8IqtafnbvcRYZ
	b3ClNDVGiQ5bN4hz205cyPyCqOZgxvgYzsTMgHP22aieDydqS5vzqD6VDI9kmmPqRz3TE3W
	gqFRx3I4Bo1/imJp+rbaQBRDkhEp6hpHXWqOVNTFR1+d3Bjg61
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[m.fudan.edu.cn,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-258702-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[m.fudan.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[23210240148@m.fudan.edu.cn,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[m.fudan.edu.cn:dkim,qq.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DD3913BF7F
X-Rspamd-Action: no action

RGVhciBNYWludGFpbmVyLA0KDQpPdXIgdGVhbSByZWNlbnRseSBkZXZlbG9wZWQgYSBudWxs
LXBvaW50ZXItZGVyZWZlcmVuY2UgKE5QRCkgdnVsbmVyYWJpbGl0eSBkZXRlY3Rpb24gdG9v
bCwgYW5kIHdlIHVzZWQgaXQgdG8gc2NhbiB0aGUgTGludXggS2VybmVsICh2ZXJzaW9uIDYu
OS42KS4gQWZ0ZXIgbWFudWFsIHJldmlldywgd2UgaWRlbnRpZmllZCBhIHBvdGVudGlhbGx5
IHZ1bG5lcmFibGUgY29kZSBzbmlwcGV0IHRoYXQgY291bGQgbGVhZCB0byBhIG51bGwtcG9p
bnRlciBkZXJlZmVyZW5jZSBidWcuIFdlIHdvdWxkIGFwcHJlY2lhdGUgeW91ciBleHBlcnQg
aW5zaWdodCB0byBjb25maXJtIHdoZXRoZXIgdGhpcyB2dWxuZXJhYmlsaXR5IGNvdWxkIGlu
ZGVlZCBwb3NlIGEgcmlzayB0byB0aGUgc3lzdGVtLg0KDQpWdWxuZXJhYmlsaXR5IERlc2Ny
aXB0aW9uOg0KRmlsZTogIG5ldC9pcHY2L2lwNl9maWIuYw0KSW4gdGhlIGZ1bmN0aW9uIGZp
YjZfcHVyZ2VfcnQsIHdlIGZvdW5kIHRoZSBmb2xsb3dpbmcgbGluZSBvZiBjb2RlOg0KDQpm
aWI2X2luZm9faG9sZChuZXdfbGVhZik7DQoNClRoZSBpc3N1ZSBhcmlzZXMgYmVjYXVzZSB0
aGUgbmV3X2xlYWYgcG9pbnRlciBtYXkgYmUgcGFzc2VkIGFzIE5VTEwgaW4gY2VydGFpbiBz
aXR1YXRpb25zLiBUaGUgc3RhdGVtZW50IHBhc3NlcyB0aGUgbmV3X2xlYWYgcG9pbnRlciB0
byBmaWI2X2luZm9faG9sZCB3aXRob3V0IGFueSBjaGVjaywgYnV0IGZpYjZfaW5mb19ob2xk
IG1pZ2h0IGNvbnRhaW4gYSBkZXJlZmVyZW5jZSBvcGVyYXRpb24gb24gdGhlIG5ld19sZWFm
IHBvaW50ZXIsIHdoaWNoIGNvdWxkIHJlc3VsdCBpbiBhIG51bGwtcG9pbnRlciBkZXJlZmVy
ZW5jZS4NCg0KUHJvcG9zZWQgRml4Og0KVG8gcHJldmVudCB0aGUgcG90ZW50aWFsIG51bGwt
cG9pbnRlciBkZXJlZmVyZW5jZSwgd2Ugc3VnZ2VzdCBhZGRpbmcgYSBOVUxMIGNoZWNrIGZv
ciB0aGUgbmV3X2xlYWYgcG9pbnRlciBiZWZvcmUgYXR0ZW1wdGluZyB0byBwYXNzIHRoZSBw
b2ludGVyIHRvIGZpYjZfaW5mb19ob2xkLg0KDQpSZXF1ZXN0IGZvciBSZXZpZXc6DQpXZSB3
b3VsZCBhcHByZWNpYXRlIHlvdXIgZXhwZXJ0IGluc2lnaHQgdG8gY29uZmlybSB3aGV0aGVy
IHRoaXMgdnVsbmVyYWJpbGl0eSBpbmRlZWQgcG9zZXMgYSByaXNrIHRvIHRoZSBzeXN0ZW0s
IGFuZCBpZiB0aGUgcHJvcG9zZWQgZml4IGlzIGFwcHJvcHJpYXRlLiBJZiB0aGVyZSBhcmUg
cmVhc29ucyB3aHkgdGhpcyBpc3N1ZSBkb2VzIG5vdCBwcmVzZW50IGEgcmVhbCByaXNrIChl
LmcuLCB0aGUgTlVMTCBjaGVjayBpcyByZWR1bmRhbnQgb3IgdW5uZWNlc3NhcnkpLCB3ZSB3
b3VsZCBiZSBncmF0ZWZ1bCBmb3IgY2xhcmlmaWNhdGlvbi4NCg0KVGhhbmsgeW91IGZvciB5
b3VyIHRpbWUgYW5kIGNvbnNpZGVyYXRpb24u


