Return-Path: <netdev+bounces-258697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLOvDzdokGk7ZQEAu9opvQ
	(envelope-from <netdev+bounces-258697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:19:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E40013BD35
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 895C83001FD1
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 12:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E622FFF89;
	Sat, 14 Feb 2026 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="Jq3PVJql"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7609654758;
	Sat, 14 Feb 2026 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771071539; cv=none; b=IlwB/958gb2fYaXRhm4CZfZfRVqq8Ktepa4liF3eIu1JFAAMkCScXNeYjGy60FCS9QZmdTuUYm0M4U/SlDSaL1pwvWd+1ikfaXsmLmlmfy9MLBRs0WW3q/pcsiTD6KEDNFynBsmk3T2bQsYAQfWfGKPxz/5d+JKzwCA7lHfOBWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771071539; c=relaxed/simple;
	bh=Pr63MeFRXsNlhMExsxDqhDjQEG1jqVI7YHXsDt25dHA=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=Iwo6HqElHTY1WB0BAm/rQGBCjpr54mo1RjoeFpZOr3rzuSVb7iJ5hHsf1Or7jhjlwMwk2Duoa0B29chBTzJRxYnPxkJF00AF3DWpLTSyCGowW6eCHHcgfiZIeVzAdc/EGHdiGpoz3dgmXBS9Q5yHwKpcuDgNPZulcb8Sk+rvgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=Jq3PVJql; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1771071469;
	bh=Pr63MeFRXsNlhMExsxDqhDjQEG1jqVI7YHXsDt25dHA=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=Jq3PVJql7u389K0LQA8SpFyAE9O9eu2EDCR341GLEMN6c47s1blyo5aC9MeCbkQDP
	 u6tir8I/G353cgjvr6/hhiBGTa8/mbFeldfGPatNYu4xxv9jDWZ8zgMGu0eZA32TzI
	 s2fen8IEViaCqa5XiwxKlLcrziLFl7RwIecX1IQQ=
EX-QQ-RecipientCnt: 7
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqSLhR1udr7El38hsqP75oNJnfS6o7szs44=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: qqTASKJVjn+p99mq+3BZArJQqMA03LUtlIl29VdFMfo=
X-QQ-STYLE: 
X-QQ-mid: lv3gz6b-1t1771071462teb8a41fb
From: "=?utf-8?B?5Yav5ZiJ5Luq?=" <23210240148@m.fudan.edu.cn>
To: "=?utf-8?B?ZHNhaGVybg==?=" <dsahern@kernel.org>
Cc: "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: [BUG] Potential Null Pointer Dereference in nexthop_create_group Function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 14 Feb 2026 20:17:42 +0800
X-Priority: 3
Message-ID: <tencent_5E937E37585390AB0DB7DEE4@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 6074213619220883086
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 14 Feb 2026 20:17:43 +0800 (CST)
Feedback-ID: lv:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MtrCxSnAE68rVcK5PTSu42suEW+hTa7SWxgjINpEH2xbySirjMXmbJKn
	0UMQyl7EFrGi0ddJIago61Vf8tVPi8ifivRRYQM8r1bZKSMmfneIju1ZShTbh417EG8+XWt
	/ewMd2lAZdEXHMAIQWJDXiZnAGOZdFz/hlpJhG/FZFddpmp2zbxfEPBQUbTcyf2azsPKqmN
	FXObCelbL/rcJdHHJ5joQo1DQdbABr/tPGvsRVqs6uIpvenqjxj6Zx+GSMusj0lMxi03Ehc
	Y8ciLhErnS/GsEg8SErQaI0Mw2kkcO7m6a0bdjAMnStw4Q1MYavaBLzzSBbhj74MmsIQdvq
	CFbL2imkzAKz1W4xjy0pMvOuzTvZqfbEApQpUWsU/LYKkrWKHIg+inyBUKG+4jaHtPmxKZR
	w1CSvD1YujWc1st3fkVqoAL764yIF+cR6A905mQuOFyxaY9XXuP7x13ZkZYszdhMhhzkXmF
	EhJEpSfENrJWzYwcUIp9M/fA+fpZCVVr/VzqieKwRrIMlE+Avi7rNIWBFhEcwct7yq6GtH3
	77BgMMqXOKOpkHYw/bp+27g8g1BT7DcqCo/XtBLSGTROATtI1MRYQpKnreXg7QxWm7ueFhD
	/igtw2UQ5hAIdlrqdqJtodDovjCri0jnsxvHMyJwgkcpF42X7+c8j56z/J4h8fWpSMSXAGk
	AhYg7vSj5zftRgi7UtzLNjEOWOmNeG9zJ1nDCLxqWMSu464de2ZUJHDZmqsZHmU8Y2n6tBo
	R/Jk7QB/8UBUDkyLdqTGpt6tOpxKgoPNmAWqMWz4Xnncr8GvfXR4+sRzPmxS3KVbLrfbjqz
	H1QPhfCdbqzYVQa4h8CcPcpEEmgmwGmLCtQ64fbmcBfZ808nunWA52hAG0C/f2GpHLEerRp
	MVZw6XxXKMiZstv9ccsBsHDSXTpREUw22UTfEnClLGmIdmVjxKiRvRfJEttH+jsBAo2RRyx
	GfJlQ95VzkCUnXp1W2IUhau21WYTaWFFBcewvrl2dT4XVAMkWxP0MMZG4X7c3HROALMOoIe
	TNNfuc14RFY4PuQ0J/32CbopewjvPzthMy9Po6mg==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[m.fudan.edu.cn,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-258697-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[m.fudan.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[23210240148@m.fudan.edu.cn,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E40013BD35
X-Rspamd-Action: no action

RGVhciBNYWludGFpbmVyLA0KDQpPdXIgdGVhbSByZWNlbnRseSBkZXZlbG9wZWQgYSBudWxs
LXBvaW50ZXItZGVyZWZlcmVuY2UgKE5QRCkgdnVsbmVyYWJpbGl0eSBkZXRlY3Rpb24gdG9v
bCwgYW5kIHdlIHVzZWQgaXQgdG8gc2NhbiB0aGUgTGludXggS2VybmVsICh2ZXJzaW9uIDYu
OS42KS4gQWZ0ZXIgbWFudWFsIHJldmlldywgd2UgaWRlbnRpZmllZCBhIHBvdGVudGlhbGx5
IHZ1bG5lcmFibGUgY29kZSBzbmlwcGV0IHRoYXQgY291bGQgbGVhZCB0byBhIG51bGwtcG9p
bnRlciBkZXJlZmVyZW5jZSBidWcuIFdlIHdvdWxkIGFwcHJlY2lhdGUgeW91ciBleHBlcnQg
aW5zaWdodCB0byBjb25maXJtIHdoZXRoZXIgdGhpcyB2dWxuZXJhYmlsaXR5IGNvdWxkIGlu
ZGVlZCBwb3NlIGEgcmlzayB0byB0aGUgc3lzdGVtLg0KDQpWdWxuZXJhYmlsaXR5IERlc2Ny
aXB0aW9uOg0KRmlsZTogIG5ldC9pcHY0L25leHRob3AuYw0KSW4gdGhlIGZ1bmN0aW9uIG5l
eHRob3BfY3JlYXRlX2dyb3VwLCB3ZSBmb3VuZCB0aGUgZm9sbG93aW5nIGxpbmUgb2YgY29k
ZToNCg0KaWYgKCFuZXh0aG9wX2dldChuaGUpKSB7DQoNClRoZSBpc3N1ZSBhcmlzZXMgYmVj
YXVzZSB0aGUgbmhlIHBvaW50ZXIgbWF5IGJlIHBhc3NlZCBhcyBOVUxMIGluIGNlcnRhaW4g
c2l0dWF0aW9ucy4gVGhlIHN0YXRlbWVudCBwYXNzZXMgdGhlIG5oZSBwb2ludGVyIHRvIG5l
eHRob3BfZ2V0IHdpdGhvdXQgYW55IGNoZWNrLCBidXQgbmV4dGhvcF9nZXQgbWlnaHQgY29u
dGFpbiBhIGRlcmVmZXJlbmNlIG9wZXJhdGlvbiBvbiB0aGUgbmhlIHBvaW50ZXIsIHdoaWNo
IGNvdWxkIHJlc3VsdCBpbiBhIG51bGwtcG9pbnRlciBkZXJlZmVyZW5jZS4NCg0KUHJvcG9z
ZWQgRml4Og0KVG8gcHJldmVudCB0aGUgcG90ZW50aWFsIG51bGwtcG9pbnRlciBkZXJlZmVy
ZW5jZSwgd2Ugc3VnZ2VzdCBhZGRpbmcgYSBOVUxMIGNoZWNrIGZvciB0aGUgbmhlIHBvaW50
ZXIgYmVmb3JlIGF0dGVtcHRpbmcgdG8gcGFzcyB0aGUgcG9pbnRlciB0byBuZXh0aG9wX2dl
dC4NCg0KUmVxdWVzdCBmb3IgUmV2aWV3Og0KV2Ugd291bGQgYXBwcmVjaWF0ZSB5b3VyIGV4
cGVydCBpbnNpZ2h0IHRvIGNvbmZpcm0gd2hldGhlciB0aGlzIHZ1bG5lcmFiaWxpdHkgaW5k
ZWVkIHBvc2VzIGEgcmlzayB0byB0aGUgc3lzdGVtLCBhbmQgaWYgdGhlIHByb3Bvc2VkIGZp
eCBpcyBhcHByb3ByaWF0ZS4gSWYgdGhlcmUgYXJlIHJlYXNvbnMgd2h5IHRoaXMgaXNzdWUg
ZG9lcyBub3QgcHJlc2VudCBhIHJlYWwgcmlzayAoZS5nLiwgdGhlIE5VTEwgY2hlY2sgaXMg
cmVkdW5kYW50IG9yIHVubmVjZXNzYXJ5KSwgd2Ugd291bGQgYmUgZ3JhdGVmdWwgZm9yIGNs
YXJpZmljYXRpb24uDQoNClRoYW5rIHlvdSBmb3IgeW91ciB0aW1lIGFuZCBjb25zaWRlcmF0
aW9uLg==


