Return-Path: <netdev+bounces-252128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD16Lj1+cWk1IAAAu9opvQ
	(envelope-from <netdev+bounces-252128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:32:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14177605C7
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F30270709A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E983559E1;
	Thu, 22 Jan 2026 01:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FoEXNCLU"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62130EF69;
	Thu, 22 Jan 2026 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769045485; cv=none; b=sU9cHuujXkxeaPxhK2cr1gccZyw//4fpQr+4GOt+Ap/wu2iXJ/LdI0z8DnPJONt/XTVIGzCbnxFwBRtU0zWixUKKk8l12n1q2A0bXbkksdBjvSnZpl6eD8ZJtFPnhL5kI00pPrM3FkMlsGzXivuCUft2h/8hsg7haiwL+8E4/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769045485; c=relaxed/simple;
	bh=mXFy8hu8XBnQ0FuFBkZqtCsDRDtjzvZCDkkFYDCCxEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=WVX6SPJZJfpJ4a9u9hmzJpaabqNWdEGOXO38WxqA+bigxzcNvXEBTbjGnMxTvn9mdcmTvo/jiw2PMjfzVt5jvUe0CtaQ7n+2BlWjAGQ5fcdi8k3zEm1ZpDPEUmPZPj4/Oh3E8qJmRdVku1Ex7y+lGCNYpuAup8Yrm9PwUFKxc6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FoEXNCLU; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=mXFy8hu8XBnQ0FuFBkZqtCsDRDtjzvZCDkkFYDCCxEQ=; b=F
	oEXNCLUGfJVlMjqZrcmWVm+cH6opGfnbmbIZQh97yOhB2xAF+tZqHG4RZbCHuY0Z
	+QTH7/LyBVCBdLzJun6CK3hD3wlls2f43gkgpRklAQMQTr8Zymlt5PbsmIWtbmgL
	OJJPclMHk7r1XBuecer8EKmtyRUiq2ypq+SknApY7Q=
Received: from slark_xiao$163.com (
 [2409:895b:3874:c9a2:4382:eb49:e15c:f3a0] ) by ajax-webmail-wmsvr-40-135
 (Coremail) ; Thu, 22 Jan 2026 09:30:09 +0800 (CST)
Date: Thu, 22 Jan 2026 09:30:09 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, gustavoars@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re:Re: [net] Revert "net: wwan: mhi_wwan_mbim: Avoid
 -Wflex-array-member-not-at-end warning"
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <2fc0de60-6450-4ea3-957b-5de465a2313d@embeddedor.com>
References: <20260120072018.29375-1-slark_xiao@163.com>
 <1228d107-4a60-4c33-a763-1a199c0b0961@embeddedor.com>
 <5e012074.84f7.19bdab162e4.Coremail.slark_xiao@163.com>
 <2fc0de60-6450-4ea3-957b-5de465a2313d@embeddedor.com>
X-NTES-SC: AL_Qu2dC/yfukwr7yWbZukfmk8Sg+84W8K3v/0v1YVQOpF8jB7owS0ObV9oIlruycGEACW+qQmsdD9S5M5TbZBxQYUoEfOVT7ka/wFimezX3c5ong==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1eb019f4.1033.19be352bf0c.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hygvCgDneM2hfXFprjlcAA--.12701W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC5wE+omlxfaE8pAAA3m
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252128-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slark_xiao@163.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[163.com,none];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,embeddedor.com:email]
X-Rspamd-Queue-Id: 14177605C7
X-Rspamd-Action: no action

CgpBdCAyMDI2LTAxLTIwIDE3OjI4OjQyLCAiR3VzdGF2byBBLiBSLiBTaWx2YSIgPGd1c3Rhdm9A
ZW1iZWRkZWRvci5jb20+IHdyb3RlOgo+Cj4KPk9uIDEvMjAvMjYgMTg6MTYsIFNsYXJrIFhpYW8g
d3JvdGU6Cj4+IAo+PiAKPj4gQXQgMjAyNi0wMS0yMCAxNTo1MTo1NywgIkd1c3Rhdm8gQS4gUi4g
U2lsdmEiIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPiB3cm90ZToKPj4+IEhpIFNsYXJrLAo+Pj4K
Pj4+IE9uIDEvMjAvMjYgMTY6MjAsIFNsYXJrIFhpYW8gd3JvdGU6Cj4+Pj4gVGhpcyByZXZlcnRz
IGNvbW1pdCBlZWVjZjVkM2EzYTQ4NGNlZGZhM2YyZjg3ZTZkNTFhNzM5MGVkOTYwLgo+Pj4+Cj4+
Pj4gVGhpcyBjaGFuZ2UgbGVhZCB0byBNSEkgV1dBTiBkZXZpY2UgY2FuJ3QgY29ubmVjdCB0byBp
bnRlcm5ldC4KPj4+PiBJIGZvdW5kIGEgbmV0d3JvayBpc3N1ZSB3aXRoIGtlcm5lbCA2LjE5LXJj
NCwgYnV0IG5ldHdvcmsgd29ya3MKPj4+PiB3ZWxsIHdpdGgga2VybmVsIDYuMTgtcmMxLiBBZnRl
ciBjaGVja2luZywgdGhpcyBjb21taXQgaXMgdGhlCj4+Pj4gcm9vdCBjYXVzZS4KPj4+Cj4+PiBU
aGFua3MgZm9yIHRoZSByZXBvcnQuCj4+Pgo+Pj4gQ291bGQgeW91IHBsZWFzZSBhcHBseSB0aGUg
Zm9sbG93aW5nIHBhdGNoIG9uIHRvcCBvZiB0aGlzIHJldmVydCwKPj4+IGFuZCBsZXQgdXMga25v
dyBpZiB0aGUgcHJvYmxlbSBzdGlsbCBtYW5pZmVzdHM/IFRoYW5rIHlvdSEKPj4+Cj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd3dhbi9taGlfd3dhbl9tYmltLmMgYi9kcml2ZXJzL25ldC93
d2FuL21oaV93d2FuX21iaW0uYwo+Pj4gaW5kZXggMWQ3ZTNhZDkwMGMxLi5hMjcxYTcyZmVkNjMg
MTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL25ldC93d2FuL21oaV93d2FuX21iaW0uYwo+Pj4gKysr
IGIvZHJpdmVycy9uZXQvd3dhbi9taGlfd3dhbl9tYmltLmMKPj4+IEBAIC03OCw5ICs3OCwxMiBA
QCBzdHJ1Y3QgbWhpX21iaW1fY29udGV4dCB7Cj4+Pgo+Pj4gICBzdHJ1Y3QgbWJpbV90eF9oZHIg
ewo+Pj4gICAgICAgICAgc3RydWN0IHVzYl9jZGNfbmNtX250aDE2IG50aDE2Owo+Pj4gLSAgICAg
ICBzdHJ1Y3QgdXNiX2NkY19uY21fbmRwMTYgbmRwMTY7Cj4+PiAtICAgICAgIHN0cnVjdCB1c2Jf
Y2RjX25jbV9kcGUxNiBkcGUxNlsyXTsKPj4+ICsgICAgICAgX19UUkFJTElOR19PVkVSTEFQKHN0
cnVjdCB1c2JfY2RjX25jbV9uZHAxNiwgbmRwMTYsIGRwZTE2LCBfX3BhY2tlZCwKPj4+ICsgICAg
ICAgICAgICAgICBzdHJ1Y3QgdXNiX2NkY19uY21fZHBlMTYgZHBlMTZbMl07Cj4+PiArICAgICAg
ICk7Cj4+PiAgIH0gX19wYWNrZWQ7Cj4+PiArc3RhdGljX2Fzc2VydChvZmZzZXRvZihzdHJ1Y3Qg
bWJpbV90eF9oZHIsIG5kcDE2LmRwZTE2KSA9PQo+Pj4gKyAgICAgICAgICAgICBvZmZzZXRvZihz
dHJ1Y3QgbWJpbV90eF9oZHIsIGRwZTE2KSk7Cj4+Pgo+Pj4gICBzdGF0aWMgc3RydWN0IG1oaV9t
YmltX2xpbmsgKm1oaV9tYmltX2dldF9saW5rX3JjdShzdHJ1Y3QgbWhpX21iaW1fY29udGV4dCAq
bWJpbSwKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1bnNpZ25lZCBpbnQgc2Vzc2lvbikKPj4gVGhpcyBwYXRjaCB3b24ndCBpbnRyb2R1Y2Ug
cHJldmlvdXMgcHJvYmxlbS4KPj4gCj4KPlRoYW5rcyBmb3IgY29uZmlybWluZyB0aGlzLgo+Cj5J
J2xsIHR1cm4gaXQgaW50byBhIHByb3BlciBwYXRjaC4KPgo+LUd1c3Rhdm8KSGksCkFyZSB5b3Ug
cGxhbmluZyB0byBhZGQgdGhpcyByZXZlcnQgY29tbWl0IHRvIHlvdXIgY29taW5nIHBhdGNoPwpB
Y3R1YWxseSBpdCdzIHVyZ2VudCB0byByZXZlcnQgdGhpcyBjaGFuZ2Ugc2luY2UgdGhlIHJlbGVh
c2UgZGVhZGxpbmUgb2YgdjYuMTkgaXMgY29taW5nIHNvb24KYW5kIGFsbCBteSBNSEkgV1dBTiBk
ZXZpY2UgaGF2ZSBiZWVuIGltcGFjdGVkLgpJIGRvbid0IGtub3cgd2h5IHRoaXMgY29tbWl0IGhh
cyBiZWVuIHRhZ2dlZCBhcyAiTm90IEFwcGxpY2FibGUiIGFuZCB3aG8gZGlkIHRoaXMuCgpJIGhv
cGUgd2UgY2FuIGZpeCBpdCByZWdyZXNzaW9uIGJlZm9yZSB0aGUgb2ZmaWNpYWwgdjYuMTkgcmVs
ZWFzZS4KClRoYW5rcw==

