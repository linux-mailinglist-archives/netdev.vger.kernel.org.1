Return-Path: <netdev+bounces-252147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L3WEWuMcWkLJAAAu9opvQ
	(envelope-from <netdev+bounces-252147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:33:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AEC60F81
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BC7B4E5052
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6A735B155;
	Thu, 22 Jan 2026 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hUr6CDqw"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DFE30DD25;
	Thu, 22 Jan 2026 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769049178; cv=none; b=FWXd9/rkIMXj1AfbHMIOqQd/mnY3GHikFoza0E558zBzBXn4WPfsW5S9fIKwYmO370DL2Fom2FJxB+OlXnywXIj6/MR67sErr3aVB6iafJXf6gHcRXQWyPGkjuLzQQZN4LYm/pl1WKI0uJCOsssnnFy2bazowTJCtitZwC+1zd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769049178; c=relaxed/simple;
	bh=KGBFWEt0D6J/5UcQujUtAPnMR1m79IO8XyARl2iL4YQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=H6+nBn4XmQwAwZ3DIP1TpLRJ7YvE/8CMkVd7der4gyDF2hniaVF2x86L6kZt5WibMRpncSitWmdohKX+qEu3/cxs/5CsoS4kzEY5fQ07V2Z4DX5Y/EoKrZG//g8K1Z+RV+EY4QEPe9o8Au7o4z1JEA/ODZrV7vOcDjtsIumC7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hUr6CDqw; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=KGBFWEt0D6J/5UcQujUtAPnMR1m79IO8XyARl2iL4YQ=; b=h
	Ur6CDqw43b5yWigCWkeA9FtMQWvZ7Z0krp/HVc1NtZYZg+VIHtbStoLZAC20USvI
	HgSQZb4MQqJPtJVWNxtwSyfoF3JZ9cfi2G/GKdQjj3kalVzJ/v/N7n5BF0gAgx1O
	4OCOa8FToC0ieM9wbuyq8CcftoZb4tcQY2BbPv8bAQ=
Received: from slark_xiao$163.com (
 [2409:895b:3874:c9a2:e8a9:6c3d:52dc:d224] ) by ajax-webmail-wmsvr-40-135
 (Coremail) ; Thu, 22 Jan 2026 10:31:55 +0800 (CST)
Date: Thu, 22 Jan 2026 10:31:55 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>,
	"Sergey Ryazanov" <ryazanov.s.a@gmail.com>
Cc: quic_qianyu@quicinc.com, davem@davemloft.net,
	loic.poulain@oss.qualcomm.com, johannes@sipsolutions.net,
	netdev@vger.kernel.org, zaihan@unrealasia.net, johan@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	linux-kernel@vger.kernel.org, dnlplm@gmail.com,
	manivannan.sadhasivam@linaro.org, pabeni@redhat.com, mani@kernel.org
Subject: Re:Re:Re: [net-next,v7,3/8] net: wwan: core: split port creation
 and registration
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <55195fd2.3367.19bc4d5a71f.Coremail.slark_xiao@163.com>
References: <20260115114625.46991-4-slark_xiao@163.com>
 <20260116024435.347774-1-kuba@kernel.org>
 <55195fd2.3367.19bc4d5a71f.Coremail.slark_xiao@163.com>
X-NTES-SC: AL_Qu2dC/yftkkq4yKQYukfmk8Sg+84W8K3v/0v1YVQOpF8jB7owS0ObV9oIlruycGEACW+qQmsdD9S5M5TbZBxQYUoSQFgX5y6gM3GtWHYlbv3Ww==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <22e8939e.239f.19be38b4aa0.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hygvCgD3_5MbjHFpAlVcAA--.12895W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCwBvfRGlxjBsltwAA3d
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
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-252147-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[quicinc.com,davemloft.net,oss.qualcomm.com,sipsolutions.net,vger.kernel.org,unrealasia.net,kernel.org,lunn.ch,google.com,gmail.com,linaro.org,redhat.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slark_xiao@163.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	DMARC_POLICY_ALLOW(0.00)[163.com,none];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 85AEC60F81
X-Rspamd-Action: no action

CgpBdCAyMDI2LTAxLTE2IDExOjI0OjU0LCAiU2xhcmsgWGlhbyIgPHNsYXJrX3hpYW9AMTYzLmNv
bT4gd3JvdGU6Cj4KPgo+QXQgMjAyNi0wMS0xNiAxMDo0NDozNSwgIkpha3ViIEtpY2luc2tpIiA8
a3ViYUBrZXJuZWwub3JnPiB3cm90ZToKPj5UaGlzIGlzIGFuIEFJLWdlbmVyYXRlZCByZXZpZXcg
b2YgeW91ciBwYXRjaC4gVGhlIGh1bWFuIHNlbmRpbmcgdGhpcwo+PmVtYWlsIGhhcyBjb25zaWRl
cmVkIHRoZSBBSSByZXZpZXcgdmFsaWQsIG9yIGF0IGxlYXN0IHBsYXVzaWJsZS4KPj4KPj5Gb3Ig
bG9jYWwgcmVwcm9kdWN0aW9uIHN0ZXBzIHNlZSBodHRwczovL25ldGRldi1haS5ib3RzLmxpbnV4
LmRldi9haS1sb2NhbC5odG1sCj4+LS0tCj4+bmV0OiB3d2FuOiBjb3JlOiBzcGxpdCBwb3J0IGNy
ZWF0aW9uIGFuZCByZWdpc3RyYXRpb24KPj4KPj5UaGlzIHBhdGNoIHNwbGl0cyB0aGUgcG9ydCBj
cmVhdGlvbiBmdW5jdGlvbiB0byBwcmVwYXJlIGZvciB1cGNvbWluZyBHTlNTCj4+cG9ydCB0eXBl
IHN1cHBvcnQuIEl0IHNlcGFyYXRlcyBkZXZpY2VfcmVnaXN0ZXIoKSBpbnRvIGRldmljZV9pbml0
aWFsaXplKCkKPj5hbmQgZGV2aWNlX2FkZCgpLCBhbmQgbW92ZXMgbWlub3IgbnVtYmVyIGFsbG9j
YXRpb24gaW50byB0aGUgbmV3Cj4+d3dhbl9wb3J0X3JlZ2lzdGVyX3d3YW4oKSBmdW5jdGlvbi4K
Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93d2FuL3d3YW5fY29yZS5jIGIvZHJpdmVy
cy9uZXQvd3dhbi93d2FuX2NvcmUuYwo+Pj4gaW5kZXggMWRhOTM1ZTg0MDA4Li4xYTlhNzdkNTk3
ZTYgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL25ldC93d2FuL3d3YW5fY29yZS5jCj4+PiArKysg
Yi9kcml2ZXJzL25ldC93d2FuL3d3YW5fY29yZS5jCj4+PiBAQCAtMzU3LDcgKzM1Nyw4IEBAIHN0
YXRpYyB2b2lkIHd3YW5fcG9ydF9kZXN0cm95KHN0cnVjdCBkZXZpY2UgKmRldikKPj4+ICB7Cj4+
PiAgCXN0cnVjdCB3d2FuX3BvcnQgKnBvcnQgPSB0b193d2FuX3BvcnQoZGV2KTsKPj4+Cj4+PiAt
CWlkYV9mcmVlKCZtaW5vcnMsIE1JTk9SKHBvcnQtPmRldi5kZXZ0KSk7Cj4+PiArCWlmIChkZXYt
PmNsYXNzID09ICZ3d2FuX2NsYXNzKQo+Pj4gKwkJaWRhX2ZyZWUoJm1pbm9ycywgTUlOT1IoZGV2
LT5kZXZ0KSk7Cj4+PiAgCW11dGV4X2Rlc3Ryb3koJnBvcnQtPmRhdGFfbG9jayk7Cj4+PiAgCW11
dGV4X2Rlc3Ryb3koJnBvcnQtPm9wc19sb2NrKTsKPj4+ICAJa2ZyZWUocG9ydCk7Cj4+Cj4+WyAu
Li4gXQo+Pgo+Pj4gKy8qIFJlZ2lzdGVyIGEgcmVndWxhciBXV0FOIHBvcnQgZGV2aWNlIChlLmcu
IEFULCBNQklNLCBldGMuKSAqLwo+Pj4gK3N0YXRpYyBpbnQgd3dhbl9wb3J0X3JlZ2lzdGVyX3d3
YW4oc3RydWN0IHd3YW5fcG9ydCAqcG9ydCkKPj4+ICt7Cj4+PiArCXN0cnVjdCB3d2FuX2Rldmlj
ZSAqd3dhbmRldiA9IHRvX3d3YW5fZGV2KHBvcnQtPmRldi5wYXJlbnQpOwo+Pj4gKwljaGFyIG5h
bWVmbXRbMHgyMF07Cj4+PiArCWludCBtaW5vciwgZXJyOwo+Pj4gKwo+Pj4gKwkvKiBBIHBvcnQg
aXMgZXhwb3NlZCBhcyBjaGFyYWN0ZXIgZGV2aWNlLCBnZXQgYSBtaW5vciAqLwo+Pj4gKwltaW5v
ciA9IGlkYV9hbGxvY19yYW5nZSgmbWlub3JzLCAwLCBXV0FOX01BWF9NSU5PUlMgLSAxLCBHRlBf
S0VSTkVMKTsKPj4+ICsJaWYgKG1pbm9yIDwgMCkKPj4+ICsJCXJldHVybiBtaW5vcjsKPj4+ICsK
Pj4+ICsJcG9ydC0+ZGV2LmNsYXNzID0gJnd3YW5fY2xhc3M7Cj4+PiArCXBvcnQtPmRldi5kZXZ0
ID0gTUtERVYod3dhbl9tYWpvciwgbWlub3IpOwo+Pgo+PlsgLi4uIF0KPj4KPj4+ICsJZXJyID0g
ZGV2aWNlX2FkZCgmcG9ydC0+ZGV2KTsKPj4+ICsKPj4+ICsJbXV0ZXhfdW5sb2NrKCZ3d2FuX3Jl
Z2lzdGVyX2xvY2spOwo+Pj4gKwo+Pj4gKwlpZiAoZXJyKSB7Cj4+PiArCQlpZGFfZnJlZSgmbWlu
b3JzLCBtaW5vcik7Cj4+ICAgICAgICAgICAgICAgIF5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXgoK
Pj4KSGkgU2VyZ2V5LApDYW4gd2UgbW9kaWZ5IGl0IGxpa2UgdGhpcz8KCisJaWYgKGVycikgewor
CQlpZGFfZnJlZSgmbWlub3JzLCBtaW5vcik7CisJCXBvcnQtPmRldi5jbGFzcyA9IE5VTEw7CgpU
aGlzIHNoYWxsIGJlIGFibGUgdG8gYXZvaWQgdGhlIGRvdWJsZSBmcmVlIGlzc3VlLgoKPj5XaGVu
IGRldmljZV9hZGQoKSBmYWlscywgdGhpcyBmcmVlcyB0aGUgbWlub3IuIEhvd2V2ZXIsIHBvcnQt
PmRldi5jbGFzcwo+PndhcyBhbHJlYWR5IHNldCB0byB3d2FuX2NsYXNzIGFib3ZlLCBhbmQgcG9y
dC0+ZGV2LmRldnQgY29udGFpbnMgdGhlIG1pbm9yCj4+bnVtYmVyLiBUaGUgY2FsbGVyICh3d2Fu
X2NyZWF0ZV9wb3J0KSB0aGVuIGNhbGxzIHB1dF9kZXZpY2UoKSB3aGljaAo+PnRyaWdnZXJzIHd3
YW5fcG9ydF9kZXN0cm95KCkuIFNpbmNlIGRldi0+Y2xhc3MgPT0gJnd3YW5fY2xhc3MgaXMgdHJ1
ZSwKPj53d2FuX3BvcnRfZGVzdHJveSgpIGNhbGxzIGlkYV9mcmVlKCkgYWdhaW4gb24gdGhlIHNh
bWUgbWlub3IuCj4+Cj4+V291bGRuJ3QgdGhpcyBjYXVzZSBhIGRvdWJsZSBpZGFfZnJlZSB3aGVu
IGRldmljZV9hZGQoKSBmYWlscz8gVGhlIGNhbGwKPj5jaGFpbiBpczogd3dhbl9wb3J0X3JlZ2lz
dGVyX3d3YW4oKSBmYWlscyAtPiBpZGFfZnJlZShtaW5vcikgLT4gcmV0dXJuCj4+ZXJyb3IgLT4g
d3dhbl9jcmVhdGVfcG9ydCgpIC0+IHB1dF9kZXZpY2UoKSAtPiB3d2FuX3BvcnRfZGVzdHJveSgp
IC0+Cj4+aWRhX2ZyZWUobWlub3IpIGFnYWluLgo+Pgo+Pk1heWJlIHRoZSBjbGFzcyBzaG91bGQg
YmUgY2xlYXJlZCBvbiBlcnJvciBiZWZvcmUgcmV0dXJuaW5nLCBvciB0aGUKPj5pZGFfZnJlZSBp
biB0aGUgZXJyb3IgcGF0aCBzaG91bGQgYmUgcmVtb3ZlZCBzaW5jZSB3d2FuX3BvcnRfZGVzdHJv
eSgpCj4+d2lsbCBoYW5kbGUgaXQ/Cj4+Cj5IaSBTZXJnZXksCj5XZSBuZWVkIHRvIHJldmlldyB0
aGlzIGNoYW5nZXMgYWdhaW4uCj4KPj4+ICsJCXJldHVybiBlcnI7Cj4+PiArCX0KPj4+ICsKPj4+
ICsJZGV2X2luZm8oJnd3YW5kZXYtPmRldiwgInBvcnQgJXMgYXR0YWNoZWRcbiIsIGRldl9uYW1l
KCZwb3J0LT5kZXYpKTsKPj4+ICsKPj4+ICsJcmV0dXJuIDA7Cj4+PiArfQo+Pgo+PlsgLi4uIF0K
Pj4KPj4+ICsJZGV2aWNlX2luaXRpYWxpemUoJnBvcnQtPmRldik7Cj4+PiArCj4+PiArCWVyciA9
IHd3YW5fcG9ydF9yZWdpc3Rlcl93d2FuKHBvcnQpOwo+Pj4gIAlpZiAoZXJyKQo+Pj4gIAkJZ290
byBlcnJvcl9wdXRfZGV2aWNlOwo+Pj4gKwo+Pj4gIAlyZXR1cm4gcG9ydDsKPj4+Cj4+PiAgZXJy
b3JfcHV0X2RldmljZToKPj4+ICsJcHV0X2RldmljZSgmcG9ydC0+ZGV2KTsKPj4tLSAKPj5wdy1i
b3Q6IGNyCg==

