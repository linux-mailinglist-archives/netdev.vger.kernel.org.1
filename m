Return-Path: <netdev+bounces-258703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FNPCsJwkGmkZgEAu9opvQ
	(envelope-from <netdev+bounces-258703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:55:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9609513BF99
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E5DB30073E7
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 12:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C442EBBAF;
	Sat, 14 Feb 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="oSxQY+GE"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F6726738B;
	Sat, 14 Feb 2026 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771073725; cv=none; b=oOZ8jqwofmm/BcZn72dfb22u6ovlXayvHoyl+bTYtOdENaV6ci2FCpDbDvinTpPVWpAeegDd64Bzk9tyeiyRRkricUxFRsS64BkV8764EDgM6m3fdX3Row3Ckz8BQHqHkGGqGjbY0EZJBPJl8rbSUSNeQmrsSC1wg87JkcClgnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771073725; c=relaxed/simple;
	bh=PAs8tdkNndH9RZt8UoR6jb2bfehFiS7yJjp7+z5PUo4=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=ngcJN+wBcgFGOwgVsbZPM2jYfw9WCtVXbZNOqPQE52UqkH2Cfk/cFReCVr6+KpoSGlSut0zeEx6k7QWMJEdU/yenCqaNxDF1McnB7flLHLCXsZV9pA/AkrDVp0z++r2iP6gbgMMMJaVjE4qTl9cj1sZAHg6JkiDrYCGrwYyVc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=oSxQY+GE; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1771073679;
	bh=PAs8tdkNndH9RZt8UoR6jb2bfehFiS7yJjp7+z5PUo4=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=oSxQY+GExHlIZImS4zR1yAPcADUUQatKHrgS3pdWEiBjcAfk9L7oPBQfwY/hZE33i
	 Z7Q00oCv0k7/iOcRsBs/c4PJFJe+sNStNto7q8Ihwohp2sv8HBVL8x3Jbngk3YMnoW
	 /WqB1WfelnJ9ff/3wD1u8Qvzok8BiV/tech1VYXw=
EX-QQ-RecipientCnt: 7
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqR3BzPw6xF2yYOMzhADaK1k6/GpcrrpT/I=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: rE8gP3cIA5yT6lo4KAraKBj2s1oDhBare5zpyeBVEr8=
X-QQ-STYLE: 
X-QQ-mid: lv3gz6b-1t1771073672t4cb12fa8
From: "=?utf-8?B?5Yav5ZiJ5Luq?=" <23210240148@m.fudan.edu.cn>
To: "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>
Cc: "=?utf-8?B?ZHNhaGVybg==?=" <dsahern@kernel.org>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: [BUG] Potential Null Pointer Dereference in rt6_device_match Function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 14 Feb 2026 20:54:32 +0800
X-Priority: 3
Message-ID: <tencent_2F0913D2570CEC3924A16713@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 13918336009448748458
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 14 Feb 2026 20:54:33 +0800 (CST)
Feedback-ID: lv:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MRiFTjyIbtS12lwrfaBq6uSweS1+4Du+muEhj6LrszbkTc/VDWv0Nsey
	IOnaGzy0YkL/ABgyZbpDNDZmDGAJcmLk9UaiHCKmqgPOFydzoBuDTk+9pcQfq/BAG7cFh/m
	0+TXU+iGvYRPmdgmQ5E/xFpgNyJAfRQlWU06PiZ0V+z2xOMsFbtf6w7DtcvA+1VSdEKUWBA
	k3wV4Dy30wbmxdxIuiLOMkcOVHGzYtauoBbxlvzEHyAvXrTRL8s3ydKXWH+egkDHMbu/ynI
	yOzeqJKBYbihrWc+c9OaGAS6wt+5YS+rERQA4DEnqv6SF1ij1zD0Gh7sOTGmAfRbT/5zmRn
	LliVrmcGfzqhuzuOtx21HcENiO1XbuzuoGUAtqclL+ZS8OMjUtO+UB+QJP7EEl4QKPm6bp5
	xY/Q4mL8fc4TGA/2gCkFBFMjnlem3WbusahgDZLn/iZ1aAY3/s95nI6VSh6Fx85QUj0FslU
	tBsKKXmBzLGFViRGp3vexeEiQzWg3ldhJ68Z21XeEuuxEpyNUj7HzoTzhTE9z4hh9XKY8Qa
	OI27JGNz1wGiorZ5qcCsIickNgmznNMG+OljLUW4e2WlyIlqQ7gMT6OxIUBELzUtwPr5NUG
	5QDGd0C6icpveiuOBZb1VCgNiTBbpQ3X5NZV5NHLbN5u3rFFc5TCr5ws+ty0F9B4uyugtpZ
	+7SWOEQ2B6mEgpbdNWK1GUskzZ0c9ZIAsH8xbXDtu8AlMnCukL7kiZBSM/DcKziUyxoHxMq
	fCKbOkOhgfLE8rMKnbi4XZXYF5ocSP+y3MYciAVCGZn8Pp1meRBVQzyrRz0GlXmSEBTMDzA
	SPVfDG6OiIa8RYkxWQmTf9J3GcMkpc96iSdaQfnRs7xE6FrM6eLB+6ue+tW0voqgnfBm8Dq
	QZuFdSr7RvZSGOKj3h3pJU7NF2kgauzpspnfCjMxoFZ7F/fqqRed572dPqkZ2OntztvdyWw
	SbHNz9tt43MotwcwwFEo9CjV3/0ywy1XXvTXRKjAFScv2O7MEP8sZpUjDCZ99h3Z8xpraQS
	O8t9q4j9dBtl9PtTp9tCbWCbKx6gqJcXXFf48oyg==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
	TAGGED_FROM(0.00)[bounces-258703-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[m.fudan.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[23210240148@m.fudan.edu.cn,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,m.fudan.edu.cn:dkim,qq.com:mid]
X-Rspamd-Queue-Id: 9609513BF99
X-Rspamd-Action: no action

RGVhciBNYWludGFpbmVyLA0KDQpPdXIgdGVhbSByZWNlbnRseSBkZXZlbG9wZWQgYSBudWxs
LXBvaW50ZXItZGVyZWZlcmVuY2UgKE5QRCkgdnVsbmVyYWJpbGl0eSBkZXRlY3Rpb24gdG9v
bCwgYW5kIHdlIHVzZWQgaXQgdG8gc2NhbiB0aGUgTGludXggS2VybmVsICh2ZXJzaW9uIDYu
OS42KS4gQWZ0ZXIgbWFudWFsIHJldmlldywgd2UgaWRlbnRpZmllZCBhIHBvdGVudGlhbGx5
IHZ1bG5lcmFibGUgY29kZSBzbmlwcGV0IHRoYXQgY291bGQgbGVhZCB0byBhIG51bGwtcG9p
bnRlciBkZXJlZmVyZW5jZSBidWcuIFdlIHdvdWxkIGFwcHJlY2lhdGUgeW91ciBleHBlcnQg
aW5zaWdodCB0byBjb25maXJtIHdoZXRoZXIgdGhpcyB2dWxuZXJhYmlsaXR5IGNvdWxkIGlu
ZGVlZCBwb3NlIGEgcmlzayB0byB0aGUgc3lzdGVtLg0KDQpWdWxuZXJhYmlsaXR5IERlc2Ny
aXB0aW9uOg0KRmlsZTogIG5ldC9pcHY2L3JvdXRlLmMNCkluIHRoZSBmdW5jdGlvbiBydDZf
ZGV2aWNlX21hdGNoLCB3ZSBmb3VuZCB0aGUgZm9sbG93aW5nIGxpbmUgb2YgY29kZToNCg0K
aWYgKCEobmgtPmZpYl9uaF9mbGFncyAmIFJUTkhfRl9ERUFEKSkNCg0KVGhlIGlzc3VlIGFy
aXNlcyBiZWNhdXNlIHRoZSBuaCBwb2ludGVyIG1heSBiZSBwYXNzZWQgYXMgTlVMTCBpbiBj
ZXJ0YWluIHNpdHVhdGlvbnMuIFNpbmNlIG5oIGlzIE5VTEwsIGFjY2Vzc2luZyBuaC0+Zmli
X25oX2ZsYWdzIGluIHRoZSBzdGF0ZW1lbnQgY291bGQgcmVzdWx0IGluIGEgbnVsbC1wb2lu
dGVyIGRlcmVmZXJlbmNlLg0KDQpQcm9wb3NlZCBGaXg6DQpUbyBwcmV2ZW50IHRoZSBwb3Rl
bnRpYWwgbnVsbC1wb2ludGVyIGRlcmVmZXJlbmNlLCB3ZSBzdWdnZXN0IGFkZGluZyBhIE5V
TEwgY2hlY2sgZm9yIHRoZSBuaCBwb2ludGVyIGJlZm9yZSBhdHRlbXB0aW5nIHRvIGRlcmVm
ZXJlbmNlIG5oLT5maWJfbmhfZmxhZ3MgaW4gdGhlIGxpbmUuDQoNClJlcXVlc3QgZm9yIFJl
dmlldzoNCldlIHdvdWxkIGFwcHJlY2lhdGUgeW91ciBleHBlcnQgaW5zaWdodCB0byBjb25m
aXJtIHdoZXRoZXIgdGhpcyB2dWxuZXJhYmlsaXR5IGluZGVlZCBwb3NlcyBhIHJpc2sgdG8g
dGhlIHN5c3RlbSwgYW5kIGlmIHRoZSBwcm9wb3NlZCBmaXggaXMgYXBwcm9wcmlhdGUuIElm
IHRoZXJlIGFyZSByZWFzb25zIHdoeSB0aGlzIGlzc3VlIGRvZXMgbm90IHByZXNlbnQgYSBy
ZWFsIHJpc2sgKGUuZy4sIHRoZSBOVUxMIGNoZWNrIGlzIHJlZHVuZGFudCBvciB1bm5lY2Vz
c2FyeSksIHdlIHdvdWxkIGJlIGdyYXRlZnVsIGZvciBjbGFyaWZpY2F0aW9uLg0KDQpUaGFu
ayB5b3UgZm9yIHlvdXIgdGltZSBhbmQgY29uc2lkZXJhdGlvbi4=


