Return-Path: <netdev+bounces-266524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGYpGw0nsWkBrgIAu9opvQ
	(envelope-from <netdev+bounces-266524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:25:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E91925F2B9
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56CF5338ABA0
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A523B6349;
	Wed, 11 Mar 2026 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ncH7FfqZ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2E73B2FE3;
	Wed, 11 Mar 2026 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773216778; cv=none; b=HNZ/hRhoTlfgjTA6poomeTOfTDlF7hvQd0QT1SDuy20u3EtM6ftZ9swI5lKtc1JFlid39CS88FZa4qo99tULcOq2FFHyFj93L5SW8uYkHWGjCWFSvJ3h09CjCyOG+u8xxqk3k/tsHnjzlbEmZDkhvzImBPqFVqSnREQnxZ3LoOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773216778; c=relaxed/simple;
	bh=+28AbaM0l2llSpXWK3HnSybGAcgjB1fHNFeeA5L0FRY=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=P8a3UwoYYU433RPU49jl3El640XM4mb6RLSArXhveiN98TtoTGfP+I3NLEYUl4pHAySIuWk8DC0Q0vuqJZ0obc5Zv/s45Alw6QPXFvRT5KUf47L4RDVSIvFJCjGlhwqgexjnUPsqek6DIReywj7rAPN7TubY7+LZ2MsrA+wwFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ncH7FfqZ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=+28AbaM0l2llSpXWK3HnSybGAcgjB1fHNFeeA5L0FRY=; b=n
	cH7FfqZE2Cxhx1Myi1PO8ZPQLi3DSfumgw6OByZlp6QdItra040iEb2ng1rcRmUz
	Chf5CYOrnuWK7BkzjHiXo7gRIDQJVzxadyKJR2j3AF74rMWzdkpFXlgU9MX2hRu+
	pyhAVdb1E69BxFFRsI1T1Qw92/OdzLO6R5wwGGgewY=
Received: from luckd0g$163.com ( [183.205.138.18] ) by
 ajax-webmail-wmsvr-40-127 (Coremail) ; Wed, 11 Mar 2026 16:11:56 +0800
 (CST)
Date: Wed, 11 Mar 2026 16:11:56 +0800 (CST)
From: "Jianzhou Zhao" <luckd0g@163.com>
To: edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: BUG: unable to handle kernel NULL pointer dereference in
 __ethtool_get_link_ksettings
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2cAf6auU8q4CSYYOkfmU4Rhug7UMO3uf8n24JfPJ9wjA/p2yseUUF9NmPf88CwFTuXvxiGfTNO1/ZAU5BifrwxKbrooSbP2rWJsszDrrclvA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <a3fb1f.6f59.19cdbf3d67d.Coremail.luckd0g@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:fygvCgCXFbnMI7FpAcd2AA--.39000W
X-CM-SenderInfo: poxfyvkqj6il2tof0z/xtbC9gzCTWmxI8wh8wAA3Q
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Queue-Id: 5E91925F2B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266524-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luckd0g@163.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

CgpTdWJqZWN0OiBbQlVHXSBuZXQ6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4g
X19ldGh0b29sX2dldF9saW5rX2tzZXR0aW5ncwoKRGVhciBNYWludGFpbmVycywKCldlIGFyZSB3
cml0aW5nIHRvIHJlcG9ydCBhIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSB2dWxuZXJhYmlsaXR5
IHdpdGhpbiB0aGUgYF9fZXRodG9vbF9nZXRfbGlua19rc2V0dGluZ3MoKWAgZnVuY3Rpb24uIFRo
aXMgYnVnIHdhcyBmb3VuZCBieSBvdXIgY3VzdG9tIGZ1enppbmcgdG9vbCwgUmFjZVBpbG90LiBU
aGUgYnVnIG9jY3VycyB3aGVuIGFuIGludGVybmFsIHN1YnN5c3RlbSAoZS5nLiwgYHNtY2Agcm91
dGluZyBvciBgaW5maW5pYmFuZGAgcXVlcnlpbmcgYSBoYXJkd2FyZSBwb3J0KSBhdHRlbXB0cyB0
byByZXRyaWV2ZSB0aGUgbGluayBzcGVlZCBvZiBhbiBgaXB2bGFuYCBpbnRlcmZhY2UgdGhhdCBp
cyBsYXllcmVkIG9uIHRvcCBvZiBhIHZpcnR1YWwgb3IgZGV2aWNlIGhpZXJhcmNoeSBsYWNraW5n
IGBldGh0b29sX29wc2AuIFdlIG9ic2VydmVkIHRoaXMgYnVnIG9uIHRoZSBMaW51eCBrZXJuZWwg
dmVyc2lvbiA2LjE4LjAtMDg2OTEtZzIwNjFmMThhZDc2ZS1kaXJ0eS4KCkNhbGwgVHJhY2UgJiBD
b250ZXh0Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQpCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFk
ZHJlc3M6IDAwMDAwMDAwMDAwMDAxZjgKI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtl
cm5lbCBtb2RlCiNQRjogZXJyb3JfY29kZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQpQR0Qg
MCBQNEQgMCAKT29wczogT29wczogMDAwMCBbIzFdIFNNUCBOT1BUSQpDUFU6IDAgVUlEOiAwIFBJ
RDogODMyMiBDb21tOiBrd29ya2VyLzA6OSBOb3QgdGFpbnRlZCA2LjE4LjAtMDg2OTEtZzIwNjFm
MThhZDc2ZS1kaXJ0eSAjNTAgUFJFRU1QVCh2b2x1bnRhcnkpIApIYXJkd2FyZSBuYW1lOiBRRU1V
IFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyAxLjE1LjAtMSAwNC8wMS8y
MDE0CldvcmtxdWV1ZTogZXZlbnRzIHNtY19pYl9wb3J0X2V2ZW50X3dvcmsKUklQOiAwMDEwOl9f
ZXRodG9vbF9nZXRfbGlua19rc2V0dGluZ3MrMHg1Yy8weDE0MCBuZXQvZXRodG9vbC9pb2N0bC5j
OjQ0MwouLi4KQ2FsbCBUcmFjZToKIDxUQVNLPgogaXB2bGFuX2V0aHRvb2xfZ2V0X2xpbmtfa3Nl
dHRpbmdzKzB4MmMvMHg0MCBkcml2ZXJzL25ldC9pcHZsYW4vaXB2bGFuX21haW4uYzo0MTEKIF9f
ZXRodG9vbF9nZXRfbGlua19rc2V0dGluZ3MrMHgxMDcvMHgxNDAgbmV0L2V0aHRvb2wvaW9jdGwu
Yzo0NTAKIGliX2dldF9ldGhfc3BlZWQrMHhkMi8weDZkMCBkcml2ZXJzL2luZmluaWJhbmQvY29y
ZS92ZXJicy5jOjE5OTkKIHJ4ZV9xdWVyeV9wb3J0KzB4MTRhLzB4MjcwIGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmM6NjIKIF9faWJfcXVlcnlfcG9ydCBkcml2ZXJzL2luZmlu
aWJhbmQvY29yZS9kZXZpY2UuYzoyMTQ4IFtpbmxpbmVdCiBpYl9xdWVyeV9wb3J0IGRyaXZlcnMv
aW5maW5pYmFuZC9jb3JlL2RldmljZS5jOjIxODAgW2lubGluZV0KIGliX3F1ZXJ5X3BvcnQrMHgz
MTAvMHg0NDAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvZGV2aWNlLmM6MjE3MAogc21jX2liX3Jl
bWVtYmVyX3BvcnRfYXR0ciBuZXQvc21jL3NtY19pYi5jOjM2NCBbaW5saW5lXQogc21jX2liX3Bv
cnRfZXZlbnRfd29yaysweGZhLzB4NjkwIG5ldC9zbWMvc21jX2liLmM6Mzg4Ci4uLgo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KCkV4ZWN1dGlvbiBGbG93ICYgQ29kZSBDb250ZXh0CldoZW4gYmFja2VuZCBrZXJuZWwgc3lz
dGVtcyBsaWtlIGluZmluaWJhbmQgKGBpYl9nZXRfZXRoX3NwZWVkYCkgY2FsbCBgX19ldGh0b29s
X2dldF9saW5rX2tzZXR0aW5ncygpYCBvbiBhIHRvcC1sZXZlbCBgaXB2bGFuYCBkZXZpY2UgdG8g
ZXZhbHVhdGUgdW5kZXJseWluZyBldGhlcm5ldCBjYXBhYmlsaXRpZXMsIHRoZSBleGVjdXRpb24g
ZGVsZWdhdGVzIHN1Y2Nlc3NmdWxseSB0aHJvdWdoIHRoZSBkZXZpY2UncyBtYXBwZWQgcHJveHkg
cm91dGluZS4gSG93ZXZlciwgYGlwdmxhbmAgdHJpZ2dlcnMgYSBuZXN0ZWQgZmFsbGJhY2sgbG9v
a3VwIHRvIHRoZSBwaHlzaWNhbCBiYXNlbGluZSBjYXJyaWVyIHdpdGhvdXQgdmFsaWRhdGluZyB3
aGV0aGVyIHRoZSBjYXJyaWVyIGluaGVyZW50bHkgc3VwcG9ydHMgZXRodG9vbCBvcGVyYXRpb25z
OgpgYGBjCi8vIGRyaXZlcnMvbmV0L2lwdmxhbi9pcHZsYW5fbWFpbi5jCnN0YXRpYyBpbnQgaXB2
bGFuX2V0aHRvb2xfZ2V0X2xpbmtfa3NldHRpbmdzKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCgkJ
CQkJICAgICBzdHJ1Y3QgZXRodG9vbF9saW5rX2tzZXR0aW5ncyAqY21kKQp7Cgljb25zdCBzdHJ1
Y3QgaXB2bF9kZXYgKmlwdmxhbiA9IG5ldGRldl9wcml2KGRldik7CgoJcmV0dXJuIF9fZXRodG9v
bF9nZXRfbGlua19rc2V0dGluZ3MoaXB2bGFuLT5waHlfZGV2LCBjbWQpOyAvLyA8LS0gTmVzdGVk
IGZhbGxiYWNrIGNhbGwgb250byBwaHlfZGV2Cn0KYGBgCgpVbmZvcnR1bmF0ZWx5LCB0aGUgZXhw
b3J0ZWQgaGVscGVyIHJvdXRpbmUgYF9fZXRodG9vbF9nZXRfbGlua19rc2V0dGluZ3MoKWAgcmVs
aWVzIHN0cmljdGx5IG9uIGBkZXYtPmV0aHRvb2xfb3BzYCBiZWluZyBhIHZhbGlkIHBvcHVsYXRl
ZCBwb2ludGVyIGFuZCBtYWtlcyBubyBhc3NlcnRpb25zIGRlZmVuc2l2ZWx5IHByaW9yIHRvIGNh
bGxpbmcgdGhlIGNhbGxiYWNrIGxheW91dDoKYGBgYwovLyBuZXQvZXRodG9vbC9pb2N0bC5jCmlu
dCBfX2V0aHRvb2xfZ2V0X2xpbmtfa3NldHRpbmdzKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCgkJ
CQkgc3RydWN0IGV0aHRvb2xfbGlua19rc2V0dGluZ3MgKmxpbmtfa3NldHRpbmdzKQp7CglBU1NF
UlRfUlROTCgpOwoKCWlmICghZGV2LT5ldGh0b29sX29wcy0+Z2V0X2xpbmtfa3NldHRpbmdzKSAv
LyA8LS0gTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIChmYXVsdCBhdCArMHgxZjgpCgkJcmV0dXJu
IC1FT1BOT1RTVVBQOwoJLi4uCn0KYGBgCgpSb290IENhdXNlIEFuYWx5c2lzClRoZSBidWcgY29u
c3RpdHV0ZXMgYSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgZXhwbGljaXRseSB0cmlnZ2VyZWQg
d2l0aGluIGBfX2V0aHRvb2xfZ2V0X2xpbmtfa3NldHRpbmdzKClgLiBCZWNhdXNlIHRoZSBBUEkg
aXMgZXhwb3J0ZWQgZm9yIHRyYW5zcGFyZW50IGtlcm5lbC1jZW50cmljIGNvbnN1bXB0aW9uIChl
LmcuIGJ5IGBpYl9nZXRfZXRoX3NwZWVkYCksIGl0IGJ5cGFzc2VzIHRoZSByb2J1c3QgdmFsaWRh
dGlvbiBzdGFuZGFyZCB1c2Vyc3BhY2UgY2FsbHMgZXhwZXJpZW5jZSB2aWEgdGhlIGBldGh0b29s
X2lvY3RsYCBpb2N0bCB3cmFwcGVyLCBjb21wbGV0ZWx5IG92ZXJsb29raW5nIGVtcHR5L05VTEwg
YGRldi0+ZXRodG9vbF9vcHNgIGFycmF5cy4gCgpXaGVuIGBpcHZsYW5gIGJyaWRnZXMgdGhlIHJl
cXVlc3QgZG93biB0byBhbiB1bnlpZWxkaW5nIGJhY2tlbmQgaG9zdCAoYGlwdmxhbi0+cGh5X2Rl
dmApLCBhbmQgdGhlIGhvc3Qgb3BlcmF0ZXMgYXMgYSB2aXJ0dWFsIGxvb3Agb3IgZHVtbXkgbGFj
a2luZyBhbnkgcmVnaXN0ZXJlZCBgZXRodG9vbF9vcHNgLCB0aGUgZmV0Y2ggdGFyZ2V0cyBgZGV2
LT5ldGh0b29sX29wcy0+Z2V0X2xpbmtfa3NldHRpbmdzYC4gQmFzZWQgb24gdGhlIEFQSSdzIHBv
aW50ZXIgb2Zmc2V0IGluIGBpbmNsdWRlL2xpbnV4L2V0aHRvb2wuaGAsIHRoaXMgbGFuZHMgcHJl
Y2lzZWx5IGF0IHN0cnVjdHVyYWwgaW5kZXggYDB4MUY4YCwgY3VsbWluYXRpbmcgaW4gYSBmYXRh
bCBzdXBlcnZpc29yIHJlYWQgZmF1bHQuClVuZm9ydHVuYXRlbHksIHdlIHdlcmUgdW5hYmxlIHRv
IGdlbmVyYXRlIGEgcmVwcm9kdWNlciBmb3IgdGhpcyBidWcuCgpQb3RlbnRpYWwgSW1wYWN0ClRo
aXMgbWVtb3J5IG1hbmFnZW1lbnQgZ2FwIHByZXNlbnRzIGEgbG9jYWwga2VybmVsIHBhbmljL0Rl
bmlhbCBvZiBTZXJ2aWNlIChEb1MpLiBJdCBtYW5pZmVzdHMgc2lsZW50bHkgYW55dGltZSBuZXN0
ZWQgdmlydHVhbCBhYnN0cmFjdGlvbnMgcHJvY2VzcyBhc3luY2hyb25vdXMgdHJhZmZpYyBldmVu
dHMgcmVxdWlyaW5nIG5ldHdvcmsgc3BlZWQgY2FwYWJpbGl0aWVzIG92ZXIgbWlzc2luZyBoYW5k
bGVyIGFycmF5cywgcGFydGljdWxhcmx5IHRocm91Z2ggYXV0b21hdGVkIFJETUEvSUIgZGV2aWNl
IGluaXRpYWxpemF0aW9ucy4KClByb3Bvc2VkIEZpeApUbyB1bml2ZXJzYWxseSBpbnRlcmNlcHQg
dGhlIHZhbGlkYXRpb24gbGFwc2UgaW5zaWRlIHRoZSBleHBvcnRlZCBnZW5lcmljIGhhbmRsZXIs
IHdlIHN1Z2dlc3QgaW50cm9kdWNpbmcgYSBwcmVsaW1pbmFyeSBudWxsLWNoZWNrIHByb3RlY3Rp
bmcgdGhlIGludGVyZmFjZSBpbnZvY2F0aW9uczoKCmBgYGRpZmYKLS0tIGEvbmV0L2V0aHRvb2wv
aW9jdGwuYworKysgYi9uZXQvZXRodG9vbC9pb2N0bC5jCkBAIC00NDAsNyArNDQwLDcgQEAgaW50
IF9fZXRodG9vbF9nZXRfbGlua19rc2V0dGluZ3Moc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKIHsK
IAlBU1NFUlRfUlROTCgpOwogCi0JaWYgKCFkZXYtPmV0aHRvb2xfb3BzLT5nZXRfbGlua19rc2V0
dGluZ3MpCisJaWYgKCFkZXYtPmV0aHRvb2xfb3BzIHx8ICFkZXYtPmV0aHRvb2xfb3BzLT5nZXRf
bGlua19rc2V0dGluZ3MpCiAJCXJldHVybiAtRU9QTk9UU1VQUDsKIAogCWlmICghbmV0aWZfZGV2
aWNlX3ByZXNlbnQoZGV2KSkKYGBgCgpXZSB3b3VsZCBiZSBoaWdobHkgaG9ub3JlZCBpZiB0aGlz
IGNvdWxkIGJlIG9mIGFueSBoZWxwLgoKQmVzdCByZWdhcmRzLApSYWNlUGlsb3QgVGVhbQo=

