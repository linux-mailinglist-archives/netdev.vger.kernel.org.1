Return-Path: <netdev+bounces-269358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rZl9Beu1u2lHmwIAu9opvQ
	(envelope-from <netdev+bounces-269358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:38:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E5E2C7F85
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B45B3048B39
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE693A9639;
	Thu, 19 Mar 2026 08:37:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B71821CC5A;
	Thu, 19 Mar 2026 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773909479; cv=none; b=Tcsj09qKE9hJQiAYRuOdhdGf1Oaf3VMcWBlDt4a5xVfU5djokyLWt9W1k0ik7Zraxt5wyvMhzdfUq0m7PFQzy5BHJLX2BTNbFhmDnYgmesdhvBz5CK81jbXWfmjqDnlQ36vR880/VCMN3CH2RXbeyprr3bQztVyb/rWNo7DresY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773909479; c=relaxed/simple;
	bh=iC1umSf8ropPvWoQl88m1gxvWREDHcACGoIHnX0oYsI=;
	h=From:Subject:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=jIThWUrqW33peP5yqEUWiBYw5mu6N6iHO+J3tw8ND6bRtkU0arnjIpTxR3FYc8CxJlMmLXl3qvRlSgo2o7CjaaLy2Gtwha3eH8mehVF8m+tsSdG0nSvWLQ5nWtC5C/wwxlgwr/lWh3aa8y/11bpjPuDED5P8xv1hn6a0G0/Ll7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e5bcc84c236e11f1a21c59e7364eecb8-20260319
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:1ebaab43-08f6-4df7-9870-e246267222d8,IP:0,U
	RL:0,TC:-9,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-9
X-CID-META: VersionHash:89c9d04,CLOUDID:aed3af5f1fe7e39b74645013a68278d2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|898,TC:1,Content:0|14|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: C2DA95B29297BAFC04FCF1C64F832005
X-UUID: e5bcc84c236e11f1a21c59e7364eecb8-20260319
Received: from node4 [(10.44.17.112)] by mailgw.kylinos.cn
	(envelope-from <fuqingshuang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1334760676; Thu, 19 Mar 2026 16:37:43 +0800
Received: from node4 (localhost [127.0.0.1])
	by node4 (NSMail) with SMTP id 327821200BD93;
	Thu, 19 Mar 2026 16:37:43 +0800 (CST)
Received: by node4 (NSMail, from userid 10001)
	id 28BF01200BD91; Thu, 19 Mar 2026 16:37:43 +0800 (CST)
From: =?UTF-8?B?5YKF5riF54i9?= <fuqingshuang@kylinos.cn>
Subject: =?UTF-8?B?W1BBVENIXSBzZWxmdGVzdHM6IG5ldDogYnJvYWRjYXN0X3BtdHU6IEZpeCBmYWxzZSBmYWlsdXJlIGZyb20gaW5jb3JyZWN0IHBpbmcgZXhpdCBjb2RlIGxvZ2lj?=
To: =?UTF-8?B?bmV0ZGV2?= <netdev@vger.kernel.org>
Cc: =?UTF-8?B?ZGF2ZW0=?= <davem@davemloft.net>,
	=?UTF-8?B?ZWR1bWF6ZXQ=?= <edumazet@google.com>,
	=?UTF-8?B?a3ViYQ==?= <kuba@kernel.org>,
	=?UTF-8?B?cGFiZW5p?= <pabeni@redhat.com>,
	=?UTF-8?B?aG9ybXM=?= <horms@kernel.org>,
	=?UTF-8?B?c2h1YWg=?= <shuah@kernel.org>,
	=?UTF-8?B?bGludXgta3NlbGZ0ZXN0?= <linux-kselftest@vger.kernel.org>,
	=?UTF-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>
Date: Thu, 19 Mar 2026 16:37:43 +0800
X-Mailer: NSMAIL 8.2
Message-ID: <bqo04b8x7xj-bqtbj7tmu08@nsmail8.2--kylin--1>
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Thu, 19 Mar 2026 16:37:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-e7rltiunzoq-e7uso2eak4r
X-ns-mid: webmail-69bbb5d7-cutvz1k9
X-ope-from: <fuqingshuang@kylinos.cn>
X-receipt: 0
X-Spamd-Result: default: False [3.84 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MIME_HTML_ONLY(0.20)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269358-lists,netdev=lfdr.de];
	SUBJ_EXCESS_BASE64(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:~];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fuqingshuang@kylinos.cn,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.941];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35E5E2C7F85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This message is in MIME format.

--nsmail-e7rltiunzoq-e7uso2eak4r
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6TWljcm9zb2Z0IFlhSGVpO2ZvbnQt
c2l6ZToxNHB4O2NvbG9yOiMwMDAwMDA7IiBjbGFzcz0ibF9ub2RlX2hhc19j
b2xvciI+PHA+RnJvbSA3ZWY3ZTU4NDAyN2RmYWIyYjk4NGYwYThiOWQ3NTY4
MmJhMjUwMzIyIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMTxicj5Gcm9tOiBR
aW5nc2h1YW5nIEZ1ICZsdDtmdXFpbmdzaHVhbmdAa3lsaW5vcy5jbiZndDs8
YnI+RGF0ZTogVGh1LCAxOSBNYXIgMjAyNiAxNjoxMzoyOSArMDgwMDxicj5T
dWJqZWN0OiBbUEFUQ0hdIHNlbGZ0ZXN0czogbmV0OiBicm9hZGNhc3RfcG10
dTogRml4IGZhbHNlIGZhaWx1cmUgZnJvbTxicj5pbmNvcnJlY3QgcGluZyBl
eGl0IGNvZGUgbG9naWM8L3A+CjxwPlRoZSBicm9hZGNhc3RfcG10dS5zaCB0
ZXN0IHZlcmlmaWVzIHRoYXQgYnJvYWRjYXN0IHJvdXRlIE1UVSBpcyByZXNw
ZWN0ZWQsPGJyPmJ1dCBpdCB1c2VzIGFuIGluY29ycmVjdCBjcml0ZXJpYSBm
b3IgdGVzdCBzdWNjZXNzOiBpdCByZWxpZXMgc29sZWx5IG9uPGJyPnRoZSBw
aW5nIGNvbW1hbmQncyBleGl0IGNvZGUsIHdoaWNoIGxlYWRzIHRvIGZhbHNl
IGZhaWx1cmVzLjwvcD4KPHA+V2hlbiB0aGUga2VybmVsIGNvcnJlY3RseSBi
bG9ja3Mgb3ZlcnNpemVkIGJyb2FkY2FzdCBwYWNrZXRzIGR1ZSB0byB0aGU8
YnI+Y29uZmlndXJlZCBNVFUgbGltaXQgKDE1MDApLCBwaW5nIGZhaWxzIHRv
IHRyYW5zbWl0IGFueSBwYWNrZXRzIGFuZCByZXR1cm5zPGJyPmV4aXQgY29k
ZSAxLiBUaGUgb3JpZ2luYWwgc2NyaXB0IGludGVycHJldHMgdGhpcyBhcyBh
IHRlc3QgZmFpbHVyZSwgZXZlbjxicj50aG91Z2ggdGhlIGtlcm5lbCBpcyBw
cm9wZXJseSBlbmZvcmNpbmcgdGhlIE1UVSAodGhlIGNvcmUgZ29hbCBvZiB0
aGUgdGVzdCkuPC9wPgo8cD5GaXggdGhpcyBieTo8YnI+MS4gQ2hlY2tpbmcg
cGluZydzIG91dHB1dCBmb3IgY2xlYXIgc2lnbnMgb2YgTVRVIGVuZm9yY2Vt
ZW50IChpbnN0ZWFkIG9mIGV4aXQgY29kZSk8YnI+LSBNYXRjaCAiMCBwYWNr
ZXRzIHRyYW5zbWl0dGVkIiAobm8gcGFja2V0cyBzZW50IGR1ZSB0byBNVFUg
bGltaXQpPGJyPi0gTWF0Y2ggIm1lc3NhZ2UgdG9vIGxvbmciIChrZXJuZWwg
cmVqZWN0cyBvdmVyc2l6ZWQgcGFja2V0cyk8YnI+Mi4gVXNlIGFuIGV4aXQg
Y29kZSB2YXJpYWJsZSB0byBhdm9pZCBlYXJseSBleGl0IGJyZWFraW5nIHRo
ZSBzY3JpcHQgZmxvdzxicj4zLiBNYWludGFpbiBmdWxsIGNvbXBhdGliaWxp
dHkgd2l0aCB0aGUgb3JpZ2luYWwgc2V0dXAvY2xlYW51cCBsb2dpYzwvcD4K
PHA+QWZ0ZXIgdGhpcyBmaXgsIHRoZSBzY3JpcHQgcmV0dXJucyAwIChzdWNj
ZXNzKSB3aGVuIHRoZSBrZXJuZWwgZW5mb3JjZXMgdGhlPGJyPmJyb2FkY2Fz
dCByb3V0ZSBNVFUgKHBhY2tldHMgYmxvY2tlZCksIGFuZCAxIChmYWlsdXJl
KSBvbmx5IHdoZW4gdGhlIGtlcm5lbDxicj5mYWlscyB0byBlbmZvcmNlIHRo
ZSBNVFUgKHBhY2tldHMgYXJlIHRyYW5zbWl0dGVkIGJ1dCBubyByZXNwb25z
ZSBpcyByZWNlaXZlZCkuPC9wPgo8cD5TaWduZWQtb2ZmLWJ5OiBRaW5nc2h1
YW5nIEZ1ICZsdDtmdXFpbmdzaHVhbmdAa3lsaW5vcy5jbiZndDs8YnI+LS0t
PGJyPnRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9icm9hZGNhc3RfcG10
dS5zaCB8IDEyICsrKysrKysrKy0tLTxicj4xIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKTwvcD4KPHA+ZGlmZiAtLWdp
dCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9icm9hZGNhc3RfcG10
dS5zaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9icm9hZGNhc3Rf
cG10dS5zaDxicj5pbmRleCA3MjZlYjVkMjU4MzkuLmE4ZDJhMjA1YzUxZCAx
MDA3NTU8YnI+LS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L2Jy
b2FkY2FzdF9wbXR1LnNoPGJyPisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL25ldC9icm9hZGNhc3RfcG10dS5zaDxicj5AQCAtNDEsNyArNDEsMTMg
QEAgdHJhcCBjbGVhbnVwIEVYSVQ8YnI+PGJyPnNldHVwICZhbXA7JmFtcDs8
YnI+ZWNobyAiVGVzdGluZyBmb3IgYnJvYWRjYXN0IHJvdXRlIE1UVSIgJmFt
cDsmYW1wOzxicj4tIGlwIG5ldCBleGVjICIke0NMSUVOVF9OU30iIHBpbmcg
LWYgLU0gd2FudCAtcSAtYyAxIC1zIDgwMDAgLXcgMSAtYiAiJHtDTElFTlRf
QlJPQURDQVNUX0FERFJFU1N9IiAmZ3Q7IC9kZXYvbnVsbCAyJmd0OyZhbXA7
MTxicj4tPGJyPi1leGl0ICQ/PGJyPisgcGluZ19vdXRwdXQ9JChpcCBuZXQg
ZXhlYyAiJHtDTElFTlRfTlN9IiBwaW5nIC1mIC1NIHdhbnQgLWMgMSAtcyA4
MDAwIC13IDEgLWIgXDxicj4rICIke0NMSUVOVF9CUk9BRENBU1RfQUREUkVT
U30iIDImZ3Q7JmFtcDsxKSAmYW1wOyZhbXA7PGJyPisgaWYgZWNobyAiJHtw
aW5nX291dHB1dH0iIHwgZ3JlcCAtcSAtRSAiMCBwYWNrZXRzIHRyYW5zbWl0
dGVkfG1lc3NhZ2UgdG9vIGxvbmciOyB0aGVuPGJyPisgZXhpdF9jb2RlPTA8
YnI+KyBlbHNlPGJyPisgZXhpdF9jb2RlPTE8YnI+KyBmaTxicj4rPGJyPitl
eGl0ICR7ZXhpdF9jb2RlfTxicj48YnI+LS0gPGJyPjIuMjUuMTwvcD48L2Rp
dj4=

--nsmail-e7rltiunzoq-e7uso2eak4r--

