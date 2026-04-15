Return-Path: <netdev+bounces-278816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BiyNEao32nQXQAAu9opvQ
	(envelope-from <netdev+bounces-278816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:01:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C019F4059DF
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 261FA300D34E
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1903D666A;
	Wed, 15 Apr 2026 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="L0vVzx7I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m1973177.qiye.163.com (mail-m1973177.qiye.163.com [220.197.31.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4547353EEB;
	Wed, 15 Apr 2026 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265277; cv=none; b=KvHAuoBGOxR1t7Xx7GI+IduWjfUVpxoOBstSM39WBsWVKJ5QDSQNI3CPD7qZQSTjKT88/LKy5EkXXYJq1UngDa1Yh3U4shm4jgz4bI1W07u7bddaTtUDendls0bKFKdzWcP0Ge2VEF57K2H/qqrQh3qCCR6YMSm5hBR5RYXWkpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265277; c=relaxed/simple;
	bh=nvftEtc9RsnQR9DUdcramA0LR3H66zMAH7MxWhPxcR8=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=ZmIBxB5kzvzjGRSC0XIKNsjMwf4Nuq+H/jrDSiTFmovLjJ56INBavn8R/6wRrJNdBqgMBwEzmvoMaOi+tmRntZnYkSlhzT47IuPTJcod/3Ujl5KLQHcb0yj3JvYjyP3IoG6Hx96cRHmoQ1JGzkVW8AriDqWa84FOXKHKPhD2JpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=L0vVzx7I; arc=none smtp.client-ip=220.197.31.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AF6AxgB-KF5*XoYukJCGZKoD.3.1776265264920.Hmail.2023000929@ruc.edu.cn>
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, fujita.tomonori@gmail.com, linux@armlinux.org.uk, 
	tmgross@umich.edu, ojeda@kernel.org, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IHJ1c3Q6IG5ldDogcGh5OiBpbnRlbnQgZm9yIE1BRTA2MjFBIChvdXQtb2YtdHJlZSBDIC0+IFJ1c3QpLCByZXF1ZXN0IGZvciB0YXJnZXQgZ3VpZGFuY2U=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
In-Reply-To: <f57bb151-bc84-4c67-ae43-8901b09de884@lunn.ch>
References: <AFkAcAA-KLHz8L2oAyS3qqrb.1.1776247198201.Hmail.2023000929@ruc.edu.cn> <AN6AigCwKNz*0oYAjaS2aKqr.3.1776262694321.Hmail.2023000929@ruc.edu.cn> <f57bb151-bc84-4c67-ae43-8901b09de884@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 2023000929@ruc.edu.cn( [43.207.144.59] ) by ajax-webmail ( [127.0.0.1] ) ; Wed, 15 Apr 2026 23:01:04 +0800 (GMT+08:00)
From: wenzhaoliao <wenzhaoliao@ruc.edu.cn>
Date: Wed, 15 Apr 2026 23:01:04 +0800 (GMT+08:00)
X-HM-Tid: 0a9d91a8d7f409bdkunma7530ad04c36
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMf2U5gprSpllrVBCJYClE3duRf49djg1aYGfsM
	uZDiMwFBdTJxBR/CBA9axB2+j/YevN4rDy63IR3fNO5mDs84V8o7GxtZZZREUhHQIYYzvyFmqF8I
	lPljIT/Tajz47js0uWxVBaR/AKTYFMShDXN+Q=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHkJLVhpITR0dSB0fT0lMGVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlPSFVJS0xVSk9PVU5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUtKVUpLS1
	VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=L0vVzx7IJj51rulAEMerO9Z2VCcxN1Oe1GbTaEbhUKTiGFZDHIiRq7F9uB57j+8sukVxIMEiJu95aqmnSN2LyMsmGl4hPF1ztDbHjzwBhymC3VRgA0NmCZIra6SHQO96VqLG/EXzDs5+YZNeNliK0mkOu8Ffpm5BUX8ep6wPEGk=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=nvftEtc9RsnQR9DUdcramA0LR3H66zMAH7MxWhPxcR8=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ruc.edu.cn,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[ruc.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-278816-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,umich.edu,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenzhaoliao@ruc.edu.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ruc.edu.cn:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RSPAMD_EMAILBL_FAIL(0.00)[andrew.lunn.ch:query timed out,hkallweit1.gmail.com:query timed out,gmail.com,linux.armlinux.org.uk:query timed out];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ruc.edu.cn:email,ruc.edu.cn:dkim,ruc.edu.cn:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C019F4059DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CkhlbGxvIEFuZHJldywKCgpUaGFuayB5b3UsIHRoaXMgaXMgdmVyeSBoZWxwZnVsLgoKCldlIGFn
cmVlIHdpdGggeW91ciBwb2ludCB0aGF0IGZvciBhIGRyaXZlciB0byBiZSBtZXJnZWQsIGl0IG5l
ZWRzIHRvIGJlIHRlc3RlZApvbiByZWFsIGhhcmR3YXJlLiBTbyB3ZSB3aWxsIG5vdCBwdXNoIHRo
ZSBkcml2ZXItUkZDIGRpcmVjdGlvbiBmdXJ0aGVyIHdpdGhvdXQKZ2V0dGluZyBoYXJkd2FyZSBp
bnRvIHRoZSBsb29wIGZpcnN0LgoKCldlIHdpbGwgbm93IGxvb2sgaW50byBvYnRhaW5pbmcgb25l
IG9mIHRoZSBzdWdnZXN0ZWQgYm9hcmRzIGFuZCBjaGVjayB3aGF0IGl0CnRha2VzIHRvIGdldCBh
IG5lYXItbWFpbmxpbmUgb3IgbWFpbmxpbmUga2VybmVsIHJ1bm5pbmcgb24gaXQuIEJhc2VkIG9u
IHRoYXQsCndlIHdpbGwgZGVjaWRlIHdoZXRoZXIgdGhpcyBpcyBhIHJlYWxpc3RpYyBmaXJzdCB0
YXJnZXQgYmVmb3JlIGludmVzdGluZyBtb3JlCnRpbWUgaW4gdGhlIFJ1c3QgZHJpdmVyIHdvcmsg
aXRzZWxmLgoKCkF0IHRoZSBtb21lbnQsIFJhZHhhIEE1RSBsb29rcyBsaWtlIHRoZSBtb3JlIGNv
bmNyZXRlIG9wdGlvbiBmcm9tIG91ciBzaWRlLAptYWlubHkgYmVjYXVzZSB0aGVyZSBzZWVtcyB0
byBiZSB2aXNpYmxlIHB1YmxpYyBkaXNjdXNzaW9uIGFyb3VuZCBNQUUwNjIxQSBvbgp0aGF0IGJv
YXJkLiBCdXQgd2UgYXJlIHN0aWxsIGNoZWNraW5nIHRoZSBwcmFjdGljYWwgc2lkZSBvZiBib2Fy
ZCBhdmFpbGFiaWxpdHkKYW5kIHNvZnR3YXJlIHN1cHBvcnQuCgoKSWYgeW91IGhhdmUgYSBwcmVm
ZXJlbmNlIGJldHdlZW4gVHJ1c3RPblggUGxheWVyIChUT1gzKSBhbmQgUmFkeGEgQTVFIGFzIGEK
Zmlyc3QgYm9hcmQgdG8gdHJ5LCB0aGF0IHdvdWxkIGJlIHZlcnkgaGVscGZ1bC4gT3RoZXJ3aXNl
LCB3ZSB3aWxsIGludmVzdGlnYXRlCnRoZSBBNUUgcGF0aCBmaXJzdCBhbmQgY29tZSBiYWNrIG9u
Y2Ugd2UgaGF2ZSBhIGNsZWFyZXIgaGFyZHdhcmUvdGVzdGluZyBwbGFuLgoKClRoYW5rIHlvdSBh
Z2FpbiBmb3IgdGhlIGd1aWRhbmNlLgoKCkJlc3QgcmVnYXJkcywKTGlhbyBXZW56aGFvCgoKCgoK
CgoKCuWPkeS7tuS6uu+8mkFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4K5Y+R6YCB5pel5pyf
77yaMjAyNi0wNC0xNSAyMjo1MzoxNwrmlLbku7bkurrvvJp3ZW56aGFvbGlhbyA8d2Vuemhhb2xp
YW9AcnVjLmVkdS5jbj4K5oqE6YCB5Lq677yaaGthbGx3ZWl0MUBnbWFpbC5jb20sZnVqaXRhLnRv
bW9ub3JpQGdtYWlsLmNvbSxsaW51eEBhcm1saW51eC5vcmcudWssdG1ncm9zc0B1bWljaC5lZHUs
b2plZGFAa2VybmVsLm9yZyxuZXRkZXZAdmdlci5rZXJuZWwub3JnLHJ1c3QtZm9yLWxpbnV4QHZn
ZXIua2VybmVsLm9yZwrkuLvpopjvvJpSZTogcnVzdDogbmV0OiBwaHk6IGludGVudCBmb3IgTUFF
MDYyMUEgKG91dC1vZi10cmVlIEMgLT4gUnVzdCksIHJlcXVlc3QgZm9yIHRhcmdldCBndWlkYW5j
ZT4+IC0gcGFnZWQgcmVnaXN0ZXIgYWNjZXNzIGlzIG9wZW4tY29kZWQgYW5kIGRvZXMgbm90IHJv
YnVzdGx5IHByb3BhZ2F0ZSBvcgo+PiDCoCByZXN0b3JlIGVycm9yczsKPj4gLSBzZXZlcmFsIHZl
bmRvciBzZXF1ZW5jZXMgdXNlIG1hZ2ljIHBhZ2UvcmVnaXN0ZXIgdmFsdWVzIHdpdGggbm8gZG9j
dW1lbnRlZAo+PiDCoCByYXRpb25hbGUgaW4gdGhlIGRyaXZlcjsKPj4gLSB0aGVyZSBhcmUgdW5j
b25kaXRpb25hbCByZXNldHMgYW5kIGZpeGVkIGBtZGVsYXlgL2Btc2xlZXBgIGRlbGF5cyB3aXRo
b3V0IGEKPj4gwqAgY2xlYXIgY29tcGxldGlvbiBjaGVjayBvciBqdXN0aWZpY2F0aW9uOwo+PiAt
IGRlYnVnZ2luZyB1c2VzIHJhdyBgcHJpbnRrKClgIGNhbGxzOwo+PiAtIHNvbWUgaGVscGVyIHJl
dHVybiB2YWx1ZXMgYXJlIGlnbm9yZWQsIGFuZCBgcmV0IHw9IC4uLmAgaXMgbm90IGEgZ29vZCBm
aXQKPj4gwqAgZm9yIG1haW5saW5lLXN0eWxlIGVycm9yIGhhbmRsaW5nOwo+PiAtIHRoZSBNTUQg
LyBFRUUgaGFuZGxpbmcgbG9va3MgbmFycm93bHkgc3BlY2lhbC1jYXNlZCBhbmQgd291bGQgbmVl
ZCB0byBiZQo+PiDCoCByZS1jaGVja2VkIGFnYWluc3QgcGh5bGliIGNvbnZlbnRpb25zIGFuZCBw
cm9wZXIgZG9jdW1lbnRhdGlvbi4KPgo+TmljZSwgeW91IHNwb3R0ZWQgbWFueSBvZiB0aGUgaXNz
dWVzIGluIHRoYXQgY29kZS4gVGhhdCBnaXZlcyBtZSBhCj5iZXR0ZXIgZmVlbGluZywgeW91IGhh
dmUgc29tZSB1bmRlcnN0YW5kaW5nIG9mIEV0aGVybmV0IFBIWXMuCj4KPj4gQXQgdGhlIHNhbWUg
dGltZSwgd2Ugc2hvdWxkIGFsc28gYmUgZXhwbGljaXQgdGhhdCB3ZSBkbyBub3QgY3VycmVudGx5
IGhhdmUKPj4gTUFFMDYyMUEgaGFyZHdhcmUgaW4gaGFuZCwgbm9yIHN1ZmZpY2llbnQgcHVibGlj
IGRvY3VtZW50YXRpb24gdG8gY2xhaW0gdGhhdAo+PiBpdCBpcyBhbHJlYWR5IGEgd2VsbC1ncm91
bmRlZCBmaXJzdCB0YXJnZXQuIE91ciBjdXJyZW50IGxvY2FsIHNldHVwIGlzIHVzZWZ1bAo+PiBm
b3IgUnVzdC1mb3ItTGludXggYnVpbGQvdG9vbGluZyB2YWxpZGF0aW9uIGFuZCBsaW1pdGVkIG5v
bi1oYXJkd2FyZSBjaGVja3MsCj4+IGJ1dCBub3QgZm9yIHJlYWwgaGFyZHdhcmUtYmFja2VkIFBI
WSB2YWxpZGF0aW9uLgo+Cj5NeSBwZXJzb25hbCBleHBlcmllbmNlIGlzIHRoYXQgYW55dGhpbmcg
d2hpY2ggaXMgbm90IHRlc3RlZCBpcwo+YnJva2VuLiBGb3IgYSBkcml2ZXIgdG8gYmUgbWVyZ2Vk
LCBpdCBuZWVkcyB0byBiZSB0ZXN0ZWQgb24gcmVhbAo+aGFyZHdhcmUuCj4KPkNhbiB5b3UgZ2V0
IG9uZSBvZiB0aGUgYW1sb2dpYyBib2FyZHM/IFRydXN0T25YIFBsYXllciAoVE9YMyk/IFJhZHhh
Cj5BNUU/IEkndmUgbm8gaWRlYSBob3cgZWFzeSBpdCBpcyB0byBnZXQgTWFpbmxpbmUgcnVubmlu
ZyBvbiB0aGVzZQo+Ym9hcmRzLgo+Cj4JQW5kcmV3Cj4K

