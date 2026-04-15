Return-Path: <netdev+bounces-278791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLiWIg6f32kEWwAAu9opvQ
	(envelope-from <netdev+bounces-278791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:22:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8AF405384
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A52EA300DE07
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0613D3CE0;
	Wed, 15 Apr 2026 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="m8T0NlWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49205.qiye.163.com (mail-m49205.qiye.163.com [45.254.49.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EFA2EDD62;
	Wed, 15 Apr 2026 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262708; cv=none; b=l0HEA9eWS3FCPaI6ISyf4UA2B0Jl0rhn7WTEbYx58ttmwfy6QFi9KicwcCz1A8PtBL5k14BWOgduqvRD0k7qflUHSsv9SrXK0exDmO+WrQu3tb8vs5DMwyRHl4GovJcCaojsQQOSxJI0wEliHiVnTu2ZGh97pWtMqDTkFj0efyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262708; c=relaxed/simple;
	bh=RF0il2kl1CAWI5TgF2quAW9HfQQyfb3u8u9/k+VwHfw=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=BmXMB4G5LidxiOA+T2xKdf0fVvp7iqLXP+eQebVYqo2mXAtH8PI7LASbXoxYb/zlhT3U6RgrlreSObPy91aAluCV88MIaDSlUec2s7JJbg4nkONM3zfzLp8t0f9vkjGjv1utT6e1wqYLycVU8G7Wl+pSbheG9yp+Fx7NfniQw+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=m8T0NlWv; arc=none smtp.client-ip=45.254.49.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AN6AigCwKNz*0oYAjaS2aKqr.3.1776262694321.Hmail.2023000929@ruc.edu.cn>
To: andrew@lunn.ch, hkallweit1@gmail.com, fujita.tomonori@gmail.com
Cc: linux@armlinux.org.uk, tmgross@umich.edu, ojeda@kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: =?UTF-8?B?UmU6cnVzdDogbmV0OiBwaHk6IGludGVudCBmb3IgTUFFMDYyMUEgKG91dC1vZi10cmVlIEMgLT4gUnVzdCksIHJlcXVlc3QgZm9yIHRhcmdldCBndWlkYW5jZQ==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
In-Reply-To: <AFkAcAA-KLHz8L2oAyS3qqrb.1.1776247198201.Hmail.2023000929@ruc.edu.cn>
References: <AFkAcAA-KLHz8L2oAyS3qqrb.1.1776247198201.Hmail.2023000929@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 2023000929@ruc.edu.cn( [43.207.144.59] ) by ajax-webmail ( [127.0.0.1] ) ; Wed, 15 Apr 2026 22:18:14 +0800 (GMT+08:00)
From: wenzhaoliao <wenzhaoliao@ruc.edu.cn>
Date: Wed, 15 Apr 2026 22:18:14 +0800 (GMT+08:00)
X-HM-Tid: 0a9d918195e209bdkunm40bc64dd4b9f
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMf2U5gprSpllrVBCJYClE3duRf49djg1aYGfsM
	uZDiMwFBdTJxBR/CBA9axB2+j/YevN4rDy63IR3fNO5mDs84V8o7GxtZZZREUhHQIYYzvy+62Q5l
	BmSyBK7d7XwyGcj0uWxVBaR/AKTYFMShDXN+Q=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaT0hKVk1OHhhITEJPGEwYT1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlPSFVJS0xVSk9PVU5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUtKVUpLS1
	VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=m8T0NlWvB61ZyskUzH/pffRMOyDeUNHCac9dvT3vblKR3caqSoqv9YCPuQWFq/Mq6wcdD/fWe0RHMYwIc0aElNN5rz6yDS3unqpGzDDFGLSLT7n21izbJY38C7WN51SP+PiQmUUGRRztwTKhI/f0h/KsYugfxjNRMTCDWrlNhMo=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=RF0il2kl1CAWI5TgF2quAW9HfQQyfb3u8u9/k+VwHfw=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [0.94 / 15.00];
	SUBJ_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ruc.edu.cn,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ruc.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-278791-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenzhaoliao@ruc.edu.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ruc.edu.cn:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,umich.edu:email]
X-Rspamd-Queue-Id: 9C8AF405384
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CgpIZWxsbyBBbmRyZXcsCgoKVGhhbmsgeW91IGZvciB0aGUgY29uY3JldGUgcXVlc3Rpb25zLiBU
aGV5IHdlcmUgdmVyeSBoZWxwZnVsLgoKCldlIGFncmVlIHdpdGggeW91ciBtYWluIGNvbmNlcm46
IHVzaW5nIGEgbG93LXF1YWxpdHkgb3V0LW9mLXRyZWUgQyBkcml2ZXIgYXMgYQptZWNoYW5pY2Fs
IHRyYW5zbGF0aW9uIGJhc2VsaW5lIHdvdWxkIG5vdCBwcm9kdWNlIHNvbWV0aGluZyBhY2NlcHRh
YmxlCnVwc3RyZWFtLiBJZiB3ZSBjb250aW51ZSB3aXRoIE1BRTA2MjFBLCB0aGUgZXhpc3Rpbmcg
b3V0LW9mLXRyZWUgQyBjb2RlIHdvdWxkCm9ubHkgYmUgb25lIGlucHV0IGZvciBiZWhhdmlvciBk
aXNjb3ZlcnksIG5vdCB0aGUgcXVhbGl0eSBiYXNlbGluZSBmb3IgdGhlCnN1Ym1pdHRlZCBkcml2
ZXIuCgoKQWZ0ZXIgeW91ciByZXBseSwgd2UgcmV2aWV3ZWQgdGhlIHB1YmxpYyBgbWF4aW8uY2Ag
ZHJpdmVyIHlvdSBwb2ludGVkIHRvLCBhbmQKd2UgYWdyZWUgdGhhdCBpdCBoYXMgYSBudW1iZXIg
b2YgaXNzdWVzIHRoYXQgd291bGQgbmVlZCB0byBiZSBmaXhlZCBiZWZvcmUgYW55CnVwc3RyZWFt
YWJsZSBSdXN0IGRyaXZlciBjb3VsZCBiZSBqdXN0aWZpZWQuIEZvciBleGFtcGxlOgoKCi0gcGFn
ZWQgcmVnaXN0ZXIgYWNjZXNzIGlzIG9wZW4tY29kZWQgYW5kIGRvZXMgbm90IHJvYnVzdGx5IHBy
b3BhZ2F0ZSBvcgrCoCByZXN0b3JlIGVycm9yczsKLSBzZXZlcmFsIHZlbmRvciBzZXF1ZW5jZXMg
dXNlIG1hZ2ljIHBhZ2UvcmVnaXN0ZXIgdmFsdWVzIHdpdGggbm8gZG9jdW1lbnRlZArCoCByYXRp
b25hbGUgaW4gdGhlIGRyaXZlcjsKLSB0aGVyZSBhcmUgdW5jb25kaXRpb25hbCByZXNldHMgYW5k
IGZpeGVkIGBtZGVsYXlgL2Btc2xlZXBgIGRlbGF5cyB3aXRob3V0IGEKwqAgY2xlYXIgY29tcGxl
dGlvbiBjaGVjayBvciBqdXN0aWZpY2F0aW9uOwotIGRlYnVnZ2luZyB1c2VzIHJhdyBgcHJpbnRr
KClgIGNhbGxzOwotIHNvbWUgaGVscGVyIHJldHVybiB2YWx1ZXMgYXJlIGlnbm9yZWQsIGFuZCBg
cmV0IHw9IC4uLmAgaXMgbm90IGEgZ29vZCBmaXQKwqAgZm9yIG1haW5saW5lLXN0eWxlIGVycm9y
IGhhbmRsaW5nOwotIHRoZSBNTUQgLyBFRUUgaGFuZGxpbmcgbG9va3MgbmFycm93bHkgc3BlY2lh
bC1jYXNlZCBhbmQgd291bGQgbmVlZCB0byBiZQrCoCByZS1jaGVja2VkIGFnYWluc3QgcGh5bGli
IGNvbnZlbnRpb25zIGFuZCBwcm9wZXIgZG9jdW1lbnRhdGlvbi4KCgpTbyBvdXIgcGxhbiwgaWYg
d2UgY29udGludWUgd2l0aCB0aGlzIGRpcmVjdGlvbiwgd291bGQgYmUgdG8gdHJlYXQgaXQgYXMg
YQpjbGVhbi1yb29tLCBtYWlubGluZS1xdWFsaXR5IGRyaXZlciBlZmZvcnQgaW5mb3JtZWQgYnkg
ZG9jdW1lbnRhdGlvbiwgcGh5bGliCmNvbnZlbnRpb25zLCBhbmQgYm9hcmQtbGV2ZWwgcmVxdWly
ZW1lbnRzLCBhbmQgb25seSBzZWNvbmRhcmlseSBieSB0aGUKZXhpc3Rpbmcgb3V0LW9mLXRyZWUg
Y29kZS4KCgpBdCB0aGUgc2FtZSB0aW1lLCB3ZSBzaG91bGQgYWxzbyBiZSBleHBsaWNpdCB0aGF0
IHdlIGRvIG5vdCBjdXJyZW50bHkgaGF2ZQpNQUUwNjIxQSBoYXJkd2FyZSBpbiBoYW5kLCBub3Ig
c3VmZmljaWVudCBwdWJsaWMgZG9jdW1lbnRhdGlvbiB0byBjbGFpbSB0aGF0Cml0IGlzIGFscmVh
ZHkgYSB3ZWxsLWdyb3VuZGVkIGZpcnN0IHRhcmdldC4gT3VyIGN1cnJlbnQgbG9jYWwgc2V0dXAg
aXMgdXNlZnVsCmZvciBSdXN0LWZvci1MaW51eCBidWlsZC90b29saW5nIHZhbGlkYXRpb24gYW5k
IGxpbWl0ZWQgbm9uLWhhcmR3YXJlIGNoZWNrcywKYnV0IG5vdCBmb3IgcmVhbCBoYXJkd2FyZS1i
YWNrZWQgUEhZIHZhbGlkYXRpb24uCgoKVGhhdCBpcyBleGFjdGx5IHdoeSB3ZSB3YW50ZWQgdG8g
YXNrIGVhcmx5LCBiZWZvcmUgaW52ZXN0aW5nIHRvbyBtdWNoIHdvcmsgaW4KdGhlIHdyb25nIHRh
cmdldC4KCgpJZiB0aGVyZSBpcyBhIG1vcmUgc3VpdGFibGUgb3V0LW9mLXRyZWUgUEhZIHRhcmdl
dCwgUEhZIHZhcmlhbnQsIG9yIGJvYXJkL1BIWQpzZXR1cCBmb3IgYW4gaW5pdGlhbCBSdXN0IFBI
WSBzdWJtaXNzaW9uLCB3ZSB3b3VsZCBncmVhdGx5IGFwcHJlY2lhdGUgeW91cgpndWlkYW5jZS4g
V2UgYXJlIHNwZWNpZmljYWxseSB0cnlpbmcgdG8gYXZvaWQgZHVwbGljYXRpbmcgYW4gZXhpc3Rp
bmcgaW4tdHJlZQpDIFBIWSBkcml2ZXIsIGFuZCBpZiBhIHJlYWxpc3RpYyBhbmQgdXNlZnVsIHRh
cmdldCByZXF1aXJlcyBidXlpbmcgc3VpdGFibGUKaGFyZHdhcmUsIHdlIGFyZSB3aWxsaW5nIHRv
IGRvIHRoYXQuCgoKTGlrZXdpc2UsIGlmIHRoZXJlIGlzIHNvbWUgUEhZLXNpZGUgUnVzdCB0YXNr
IHRoYXQgd291bGQgYmUgbW9yZSB1c2VmdWwgdGhhbiBhCmRldmljZS1zcGVjaWZpYyBSdXN0IHBv
cnQsIHdlIHdvdWxkIGFsc28gYXBwcmVjaWF0ZSB0aGF0IGd1aWRhbmNlLiBXZSBkbyBub3QKd2Fu
dCB0byBmb3JjZSBhIEMtdG8tUnVzdCBtaWdyYXRpb24gdGFyZ2V0IHdoZXJlIG1haW50YWluZXJz
IHdvdWxkIHByZWZlciBhCmRpZmZlcmVudCBraW5kIG9mIGNvbnRyaWJ1dGlvbi4KCgpJZiByZWNv
bW1lbmRpbmcgYSB0YXJnZXQgaXMgbm90IHByYWN0aWNhbCwgb3VyIGZhbGxiYWNrIHdvdWxkIGJl
IHRvIHN0YXkgYXQKdGhlIGFuYWx5c2lzIHN0YWdlIGZvciBub3c6CgoKLSB3cml0ZSB1cCBhIHNo
b3J0IHJldmlldyBvZiB0aGUgcHVibGljIE1BRTA2MjFBIEMgZHJpdmVyIGFuZCB0aGUgaXNzdWVz
IHRoYXQKwqAgd291bGQgbmVlZCB0byBiZSBmaXhlZCBmb3IgbWFpbmxpbmUgcXVhbGl0eTsgYW5k
Ci0gbWFwIHRob3NlIHJlcXVpcmVtZW50cyBhZ2FpbnN0IHRoZSBjdXJyZW50IFJ1c3QgUEhZIGFi
c3RyYWN0aW9uIHN1cmZhY2UsCsKgIHdpdGhvdXQgY2xhaW1pbmcgaGFyZHdhcmUtYmFja2VkIHZh
bGlkYXRpb24geWV0LgoKCldvdWxkIHRoYXQgbGltaXRlZCBhbmFseXNpcy1maXJzdCBzdGVwIHN0
aWxsIGJlIHVzZWZ1bCwgb3Igd291bGQgeW91IHByZWZlcgp0aGF0IHdlIHBhdXNlIHRoZSBkcml2
ZXItUkZDIGRpcmVjdGlvbiB1bnRpbCB3ZSBoYXZlIGEgYmV0dGVyIHRhcmdldCBhbmQKaGFyZHdh
cmUgc2V0dXA/CgoKVGhhbmsgeW91IGFnYWluIGZvciB0aGUgZ3VpZGFuY2UuCgoKQmVzdCByZWdh
cmRzLApMaWFvIFdlbnpoYW8KCgoKCgoK5Y+R5Lu25Lq677yad2Vuemhhb2xpYW8gPHdlbnpoYW9s
aWFvQHJ1Yy5lZHUuY24+CuWPkemAgeaXpeacn++8mjIwMjYtMDQtMTUgMTc6NTk6NTgK5pS25Lu2
5Lq677yaYW5kcmV3QGx1bm4uY2gsaGthbGx3ZWl0MUBnbWFpbC5jb20sZnVqaXRhLnRvbW9ub3Jp
QGdtYWlsLmNvbQrmioTpgIHkurrvvJpsaW51eEBhcm1saW51eC5vcmcudWssdG1ncm9zc0B1bWlj
aC5lZHUsb2plZGFAa2VybmVsLm9yZyxuZXRkZXZAdmdlci5rZXJuZWwub3JnLHJ1c3QtZm9yLWxp
bnV4QHZnZXIua2VybmVsLm9yZwrkuLvpopjvvJpydXN0OiBuZXQ6IHBoeTogaW50ZW50IGZvciBN
QUUwNjIxQSAob3V0LW9mLXRyZWUgQyAtPiBSdXN0KSwgcmVxdWVzdCBmb3IgdGFyZ2V0IGd1aWRh
bmNlPgo+SGVsbG8gUEhZIGFuZCBSdXN0IG1haW50YWluZXJzLAo+Cj4KPkkgYW0gYSBQaEQgc3R1
ZGVudCB3b3JraW5nIG9uIGEgQy10by1SdXN0IG1pZ3JhdGlvbiB0b29sIGZvciBzeXN0ZW1zIGNv
ZGUuCj5XZSB3b3VsZCBsaWtlIHRvIHZhbGlkYXRlIGl0IGluIExpbnV4IHdpdGggb25lIGNvbmNy
ZXRlIFBIWSB0YXJnZXQgYW5kIHdvdWxkCj5saWtlIHRvIGNvbmZpcm0gZGlyZWN0aW9uIGJlZm9y
ZSBwb3N0aW5nIGEgbGFyZ2VyIFJGQyBzZXJpZXMuCj4KPgo+U2NvcGUgb2YgdGhpcyBpbnRlbnQ6
Cj4tIEluaXRpYWwgdGFyZ2V0OiBNQUUwNjIxQSAoY3VycmVudGx5IG91dC1vZi10cmVlIEMgZHJp
dmVyKS4KPi0gV2UgZG8gTk9UIGludGVuZCB0byBzdWJtaXQgYSBkdXBsaWNhdGUgUnVzdCByZXdy
aXRlIG9mIGFuIGV4aXN0aW5nIGluLXRyZWUgQyBQSFkgZHJpdmVyLgo+LSBHb2FsOiBldmFsdWF0
ZSBhIHNlbWktYXV0b21hdGljIGFic3RyYWN0aW9uIGNvbXBsZXRpb24gd29ya2Zsb3c6Cj7CoCBy
ZXVzZSBleGlzdGluZyBSdXN0IFBIWSBhYnN0cmFjdGlvbnMgd2hlcmUgcG9zc2libGUsIGFuZCBh
ZGQgb25seSBtaW5pbWFsIG1pc3NpbmcgYWJzdHJhY3Rpb25zLgo+Cj4KPlBsYW5uZWQgZGVsaXZl
cmFibGVzOgo+LSBBIGdhcCBhbmFseXNpcyBiZXR3ZWVuIE1BRTA2MjFBIEMgY2FsbGJhY2tzIGFu
ZCBjdXJyZW50IHJ1c3Qva2VybmVsL25ldC9waHkucnMgY292ZXJhZ2UuCj4tIEEgc21hbGwgUkZD
IHBhdGNoIHNlcmllcyB3aXRoIG1pbmltYWwgYWJzdHJhY3Rpb24gYWRkaXRpb25zIChpZiBuZWVk
ZWQpLgo+LSBBIE1BRTA2MjFBIFJ1c3QgZHJpdmVyIHByb3RvdHlwZSBvbiB0b3Agb2YgdGhvc2Ug
YWJzdHJhY3Rpb25zIGZvciBsaW51eC1uZXh0L3J1c3QtbmV4dCBldmFsdWF0aW9uLgo+Cj4KPlF1
YWxpdHkgYW5kIHByb2Nlc3MgY29tbWl0bWVudHM6Cj4tIEZ1bGwgaHVtYW4gcmV2aWV3IGJ5IHN1
Ym1pdHRlcnM7IHdlIGNhbiBleHBsYWluIGFsbCBzdWJtaXR0ZWQgY29kZS4KPi0gVHJhbnNwYXJl
bnQgZGlzY2xvc3VyZSBvZiB0b29sIGFzc2lzdGFuY2UgaW4gY292ZXIgbGV0dGVycy9jaGFuZ2Vs
b2dzLgo+LSBIYXJkd2FyZS1iYWNrZWQgdGVzdCByZXN1bHRzIGFuZCBleHBsaWNpdCBsaW1pdGF0
aW9ucyBpbiBlYWNoIHBvc3RpbmcuCj4KPgo+UXVlc3Rpb25zOgo+MS4gSXMgTUFFMDYyMUEgYW4g
YWNjZXB0YWJsZSBmaXJzdCB0YXJnZXQgZm9yIHRoaXMgZGlyZWN0aW9uPwo+Mi4gSWYgTUFFMDYy
MUEgaXMgbm90IHN1aXRhYmxlLCBjb3VsZCB5b3UgcmVjb21tZW5kIG9uZSBvciB0d28gYmV0dGVy
IG91dC1vZi10cmVlIFBIWSBkcml2ZXJzIGZvciBhIGZpcnN0IFJ1c3Qgc3VibWlzc2lvbj8KPjMu
IEZvciByZXZpZXcgZmxvdywgZG8geW91IHByZWZlcjoKPsKgIMKgKGEpIGFic3RyYWN0aW9ucy1m
aXJzdCBSRkMsIHRoZW4gZHJpdmVyLCBvcgo+wqAgwqAoYikgbWluaW1hbCBhYnN0cmFjdGlvbnMg
KyBjb25jcmV0ZSBkcml2ZXIgaW4gb25lIFJGQyBzZXJpZXM/Cj4KPgo+SWYgdGhlcmUgYXJlIG5v
IG9iamVjdGlvbnMsIHdlIHBsYW4gdG8gcG9zdCBhbiBSRkMgMC9OIGluIGFib3V0IDIgd2Vla3Mu
Cj4KPgo+VGhhbmtzIGZvciB5b3VyIGd1aWRhbmNlLgo+Cj4KPkJlc3QgcmVnYXJkcywKPkxpYW8g
V2Vuemhhbwo+UmVubWluIFVuaXZlcnNpdHkgb2YgQ2hpbmEKPgo=

