Return-Path: <netdev+bounces-278736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAtTEepi32mKSQAAu9opvQ
	(envelope-from <netdev+bounces-278736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:05:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 974F24031CC
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83E3A3077E19
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C5D33F8B7;
	Wed, 15 Apr 2026 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="OQpLPh3z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m3271.qiye.163.com (mail-m3271.qiye.163.com [220.197.32.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE00833B6D0;
	Wed, 15 Apr 2026 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247212; cv=none; b=hG490IdPUeraG5nupTwNH8mk0qmQvgwqabfpaaJikbs9lHTi6a7Z2TucnDY/8CNvOZWI934uBkj1tWZL7V4NZl3EZMcWbJlNijFM9g6Ocs0KP5Bls+oB+1KObckTbctw8aLZYBXB4pezysHd73j6AKiH+oRhOjS9dAcb2zn4nR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247212; c=relaxed/simple;
	bh=O6IvF4GwgYA4+wYZIFFKHdwmCG9gbbqj+oKdjbBxl0c=;
	h=Content-Type:Message-ID:To:Cc:Subject:MIME-Version:From:Date; b=BWl70gWem884kH7ZnykkdgRRrdLKTY7JVPqBRmbmVGWfIgK/BPvQ0OF/g4MMkT1mbY0MIvivsAeW6VJAuFtZG4ikSSdNvwfAeMt0NXIU37q301haChfBXB5eeozLM++5rCZezDAOQNvJev2K1WALdZ/p+Id+lKDKgTp+ceNKxPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=OQpLPh3z; arc=none smtp.client-ip=220.197.32.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AFkAcAA-KLHz8L2oAyS3qqrb.1.1776247198201.Hmail.2023000929@ruc.edu.cn>
To: andrew@lunn.ch, hkallweit1@gmail.com, fujita.tomonori@gmail.com
Cc: linux@armlinux.org.uk, tmgross@umich.edu, ojeda@kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: =?UTF-8?B?cnVzdDogbmV0OiBwaHk6IGludGVudCBmb3IgTUFFMDYyMUEgKG91dC1vZi10cmVlIEMgLT4gUnVzdCksIHJlcXVlc3QgZm9yIHRhcmdldCBndWlkYW5jZQ==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 2023000929@ruc.edu.cn( [43.207.144.59] ) by ajax-webmail ( [127.0.0.1] ) ; Wed, 15 Apr 2026 17:59:58 +0800 (GMT+08:00)
From: wenzhaoliao <wenzhaoliao@ruc.edu.cn>
Date: Wed, 15 Apr 2026 17:59:58 +0800 (GMT+08:00)
X-HM-Tid: 0a9d9094db9f09bdkunm82eff6e44396
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMf2U5gprSpllrVBCJYClE3duRf49djg1aYGfsM
	uZDiMwIZbJJzEITi5UpU1qCUKJBAcnLOrwmhWBBKk+LmmRmQaEx1IEpHrbZMNjdVF3W8j9rAe932
	Nl8EjSkm0izNSNpUuWxVBaR/AKTYFMShDXN+Q=
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUxIVkxCQx5NSU9OTx5LHlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlPSFVJS0xVSk9PVU5CWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=OQpLPh3zKEOMUgVDKIlypldlJkN/dIICu8DrkQjmDilhHfcZ9R/RfBXyGI77NmeQI4F6EPLxRqeRXNnYjuj+puWgt97pBwKD34ynB0e8LemEZxljyodCcFsM1iR2d0fIfR3sC4PA7wJc9IHSHkaXuRGhI/39TSG/L/2Eu3xcG0Y=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=O6IvF4GwgYA4+wYZIFFKHdwmCG9gbbqj+oKdjbBxl0c=;
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
	TAGGED_FROM(0.00)[bounces-278736-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 974F24031CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CkhlbGxvIFBIWSBhbmQgUnVzdCBtYWludGFpbmVycywKCgpJIGFtIGEgUGhEIHN0dWRlbnQgd29y
a2luZyBvbiBhIEMtdG8tUnVzdCBtaWdyYXRpb24gdG9vbCBmb3Igc3lzdGVtcyBjb2RlLgpXZSB3
b3VsZCBsaWtlIHRvIHZhbGlkYXRlIGl0IGluIExpbnV4IHdpdGggb25lIGNvbmNyZXRlIFBIWSB0
YXJnZXQgYW5kIHdvdWxkCmxpa2UgdG8gY29uZmlybSBkaXJlY3Rpb24gYmVmb3JlIHBvc3Rpbmcg
YSBsYXJnZXIgUkZDIHNlcmllcy4KCgpTY29wZSBvZiB0aGlzIGludGVudDoKLSBJbml0aWFsIHRh
cmdldDogTUFFMDYyMUEgKGN1cnJlbnRseSBvdXQtb2YtdHJlZSBDIGRyaXZlcikuCi0gV2UgZG8g
Tk9UIGludGVuZCB0byBzdWJtaXQgYSBkdXBsaWNhdGUgUnVzdCByZXdyaXRlIG9mIGFuIGV4aXN0
aW5nIGluLXRyZWUgQyBQSFkgZHJpdmVyLgotIEdvYWw6IGV2YWx1YXRlIGEgc2VtaS1hdXRvbWF0
aWMgYWJzdHJhY3Rpb24gY29tcGxldGlvbiB3b3JrZmxvdzoKwqAgcmV1c2UgZXhpc3RpbmcgUnVz
dCBQSFkgYWJzdHJhY3Rpb25zIHdoZXJlIHBvc3NpYmxlLCBhbmQgYWRkIG9ubHkgbWluaW1hbCBt
aXNzaW5nIGFic3RyYWN0aW9ucy4KCgpQbGFubmVkIGRlbGl2ZXJhYmxlczoKLSBBIGdhcCBhbmFs
eXNpcyBiZXR3ZWVuIE1BRTA2MjFBIEMgY2FsbGJhY2tzIGFuZCBjdXJyZW50IHJ1c3Qva2VybmVs
L25ldC9waHkucnMgY292ZXJhZ2UuCi0gQSBzbWFsbCBSRkMgcGF0Y2ggc2VyaWVzIHdpdGggbWlu
aW1hbCBhYnN0cmFjdGlvbiBhZGRpdGlvbnMgKGlmIG5lZWRlZCkuCi0gQSBNQUUwNjIxQSBSdXN0
IGRyaXZlciBwcm90b3R5cGUgb24gdG9wIG9mIHRob3NlIGFic3RyYWN0aW9ucyBmb3IgbGludXgt
bmV4dC9ydXN0LW5leHQgZXZhbHVhdGlvbi4KCgpRdWFsaXR5IGFuZCBwcm9jZXNzIGNvbW1pdG1l
bnRzOgotIEZ1bGwgaHVtYW4gcmV2aWV3IGJ5IHN1Ym1pdHRlcnM7IHdlIGNhbiBleHBsYWluIGFs
bCBzdWJtaXR0ZWQgY29kZS4KLSBUcmFuc3BhcmVudCBkaXNjbG9zdXJlIG9mIHRvb2wgYXNzaXN0
YW5jZSBpbiBjb3ZlciBsZXR0ZXJzL2NoYW5nZWxvZ3MuCi0gSGFyZHdhcmUtYmFja2VkIHRlc3Qg
cmVzdWx0cyBhbmQgZXhwbGljaXQgbGltaXRhdGlvbnMgaW4gZWFjaCBwb3N0aW5nLgoKClF1ZXN0
aW9uczoKMS4gSXMgTUFFMDYyMUEgYW4gYWNjZXB0YWJsZSBmaXJzdCB0YXJnZXQgZm9yIHRoaXMg
ZGlyZWN0aW9uPwoyLiBJZiBNQUUwNjIxQSBpcyBub3Qgc3VpdGFibGUsIGNvdWxkIHlvdSByZWNv
bW1lbmQgb25lIG9yIHR3byBiZXR0ZXIgb3V0LW9mLXRyZWUgUEhZIGRyaXZlcnMgZm9yIGEgZmly
c3QgUnVzdCBzdWJtaXNzaW9uPwozLiBGb3IgcmV2aWV3IGZsb3csIGRvIHlvdSBwcmVmZXI6CsKg
IMKgKGEpIGFic3RyYWN0aW9ucy1maXJzdCBSRkMsIHRoZW4gZHJpdmVyLCBvcgrCoCDCoChiKSBt
aW5pbWFsIGFic3RyYWN0aW9ucyArIGNvbmNyZXRlIGRyaXZlciBpbiBvbmUgUkZDIHNlcmllcz8K
CgpJZiB0aGVyZSBhcmUgbm8gb2JqZWN0aW9ucywgd2UgcGxhbiB0byBwb3N0IGFuIFJGQyAwL04g
aW4gYWJvdXQgMiB3ZWVrcy4KCgpUaGFua3MgZm9yIHlvdXIgZ3VpZGFuY2UuCgoKQmVzdCByZWdh
cmRzLApMaWFvIFdlbnpoYW8KUmVubWluIFVuaXZlcnNpdHkgb2YgQ2hpbmEKCg==

