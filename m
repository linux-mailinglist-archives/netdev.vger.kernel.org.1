Return-Path: <netdev+bounces-251702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FKSB3s1cGl9XAAAu9opvQ
	(envelope-from <netdev+bounces-251702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:10:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B634F8A2
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F179AEEEE3
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB33E946A;
	Wed, 21 Jan 2026 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZdUitdjl"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C43128CF52;
	Wed, 21 Jan 2026 02:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961377; cv=none; b=C9lKjzKKF2q5+Wi9AOTVEMbUAt5T2mkC6VUNCBqAdlc4aweQQVRCD5BDCm78JYR7g64XPrF99zZTqmWudsAAx2lr+apFHaRY5JsXt5e3vPzgJ59lPasZI3mTBqw+4+RnLG82LEd7kBudTPbU4BJDNFxLMzcfwQmauvFblgcCHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961377; c=relaxed/simple;
	bh=OWNTZIlZE9f+tn9v6o2zTPsSVk9i5tfDRlbe0/Jtx3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=B0lhk/zUgXRib/gOp25b0sG3MKKbShZOpNGs2BF3AnGj6GYnTmgw/yCfR9cXNdbOJJ3sMToxjwEHU2Wwo2y0JWt81vTVZt9mPe/L2d023AQx0Zmw8YFO21QT6wslu5knhaYsbdJ1tq9Nx3YyG1TPyMqx8obFIch+Cdb8npjiAkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZdUitdjl; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=OWNTZIlZE9f+tn9v6o2zTPsSVk9i5tfDRlbe0/Jtx3k=; b=Z
	dUitdjlV5lLWRoUZQK3N0Nx9czpwTyZAkR4vjfAZd3bLT7G8U44gWKRWVESSLFAB
	vqP6jfQiQFvDTbWZhP5Vnd+ZezA2RGM0LMj8Px8FmYpQ7zvFptwxHUELfo8mleAt
	inFWNJZJV7+1zAgiCoMTzdZ+lZ3IVykBt6rvvXeoz0=
Received: from slark_xiao$163.com (
 [2408:8459:3840:82a4:f990:b6bd:1c64:c7df] ) by ajax-webmail-wmsvr-40-120
 (Coremail) ; Wed, 21 Jan 2026 10:08:21 +0800 (CST)
Date: Wed, 21 Jan 2026 10:08:21 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Simon Horman" <horms@kernel.org>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mani@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Muhammad Nuzaihan" <zaihan@unrealasia.net>,
	"Qiang Yu" <quic_qianyu@quicinc.com>,
	"Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
	"Johan Hovold" <johan@kernel.org>
Subject: Re:Re: [net-next v7 5/8] net: wwan: add NMEA port support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <aW91bYu1ueczfGTh@horms.kernel.org>
References: <20260115114625.46991-1-slark_xiao@163.com>
 <20260115114625.46991-6-slark_xiao@163.com>
 <aW91bYu1ueczfGTh@horms.kernel.org>
X-NTES-SC: AL_Qu2dCvWdvksr5ySZZ+kfmk8Sg+84W8K3v/0v1YVQOpF8jDLp/iwdRVx8OHDJycufCiaXiRqcWxFU9ehwT4hITYgEajak00k/gCQLWFirSbEAww==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <386ee1ac.1e15.19bde4f5bac.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eCgvCgDnLzQVNXBpESdbAA--.49292W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC5xXILWlwNRXzSQAA3U
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TAGGED_FROM(0.00)[bounces-251702-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,unrealasia.net,quicinc.com,linaro.org];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slark_xiao@163.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[163.com,none];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A9B634F8A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CgpBdCAyMDI2LTAxLTIwIDIwOjMwOjM3LCAiU2ltb24gSG9ybWFuIiA8aG9ybXNAa2VybmVsLm9y
Zz4gd3JvdGU6Cj5PbiBUaHUsIEphbiAxNSwgMjAyNiBhdCAwNzo0NjoyMlBNICswODAwLCBTbGFy
ayBYaWFvIHdyb3RlOgo+Cj4uLi4KPgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd3dhbi93
d2FuX2NvcmUuYyBiL2RyaXZlcnMvbmV0L3d3YW4vd3dhbl9jb3JlLmMKPgo+Li4uCj4KPj4gKyNl
bHNlCj4+ICtzdGF0aWMgaW5saW5lIGludCB3d2FuX3BvcnRfcmVnaXN0ZXJfZ25zcyhzdHJ1Y3Qg
d3dhbl9wb3J0ICpwb3J0KQo+PiArewo+PiArCXJldHVybiAtRU9QTk9UU1VQUDsKPj4gK30KPj4g
Kwo+PiArc3RhdGljIGlubGluZSB2b2lkIHd3YW5fcG9ydF91bnJlZ2lzdGVyX2duc3Moc3RydWN0
IHd3YW5fcG9ydCAqcG9ydCkKPj4gK3sKPj4gKwlXQVJOX09OKDEpOwkvKiBUaGlzIGhhbmRsZXIg
Y2Fubm90IGJlIGNhbGxlZCAqLwo+PiArfQo+Cj5QbGVhc2UgZG9uJ3QgdXNlIHRoZSBpbmxpbmUg
a2V5d29yZCBpbiAuYyBmaWxlcyB1bmxlc3MgdGhlcmUgaXMgYQo+ZGVtb25zdHJhYmxlIC0gdXN1
YWxseSBwZXJmb3JtYW5jZSAtIHJlYXNvbiB0byBkbyBzby4gUmF0aGVyLCBsZXQgdGhlCj5jb21w
aWxlciBpbmxpbmUgY29kZSBhcyBpdCBzZWVzIGZpdC4KPgo+VXNpbmcgdGhlIGlubGluZSBrZXl3
b3JkIGluIC5oIGlzIG9mIGNvdXJzZSBmaW5lLgo+CkkgdGhpbmsgdGhpcyBzaGFsbCBiZSBhIG1p
c3Rha2UuCkZvciBhIEdOU1MgZGV2aWNlLCB0aGVzZSAyIEFQSSBzaGFsbCBub3QgYmUgY2FsbGVk
IGZyZXF1ZW50bHkuClNvIHRoZXJlIGlzIG5vIG5lY2Vzc2FyeSB0byBhZGQgImlubGluZSIgdG8g
aW1wcm92ZSBwZXJmb3JtYW5jZS4KSG93IGRvIHlvdSB0aGluaywgU2VyZ2V5PwoKPj4gKyNlbmRp
Zgo+PiArCj4KPi4uLgo=

