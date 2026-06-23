Return-Path: <netdev+bounces-301268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5YltCeMkOmpF2gcAu9opvQ
	(envelope-from <netdev+bounces-301268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:17:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 430C26B469C
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:17:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=qAHEaxx+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301268-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301268-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98876301E5BF
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 06:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ACA3A1E7E;
	Tue, 23 Jun 2026 06:16:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2633B3886
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 06:16:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195403; cv=none; b=Snnv1NEnpeN9ZBh5UDapbBxaWBCkQhNrGl5sa907hBc5CXTzP10A4lQIYumwbmCcDewIgV/pC3OdmJsaNfTvWk/ZUjmbhrgemUjoZ5AHAJUThjAfzXAAoWPHrGeuC8FH6KAIsHcuGDmKgPW05aPDcEncsK2KQb4zH59FzxY7HAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195403; c=relaxed/simple;
	bh=X9dgzPQkPR/WzJG1gYliaHW0D30DGQO+Teb/mqC/Xwc=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=RT6rpNGKOZDFluGrsPhA0SuqYOBZHxIpKwQpTP4ZAXLwlY9xLcUd1X/HtBcaxCR6UgRKhqD8d6md+YUnvYqSVUNN0ppV30KFshoqHWJvkNwdimskADdOiI7pvrSwKHgmQTCFkkhvtqJ+TQTmE57xvcwww0Su0ladiUTGK1gE9kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=qAHEaxx+; arc=none smtp.client-ip=54.92.39.34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782195389;
	bh=X9dgzPQkPR/WzJG1gYliaHW0D30DGQO+Teb/mqC/Xwc=;
	h=Date:From:To:Subject:Mime-Version:Message-ID;
	b=qAHEaxx+rD3/vvR8aPVCZlhhRwD30lq8NmnqGhWXVr83c6nNNA1ws00wYOZjuHcnp
	 OSwqiXJuF/Eqi+RvmL/9ziZX+y5RHr66iPwC2XiJRBf1sLZNUg7d88QRT1Xk1pqol3
	 qzcdGo2mZjIItXukVZXYZmPeNuIZXXhyDBzfxIVw=
X-QQ-mid: esmtpgz14t1782195387t55a32ba9
X-QQ-Originating-IP: 3di29PrDKUE7Z105d40SDr0nuQRnDiVPFmC6KB9yb+c=
Received: from PEN002676 ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Jun 2026 14:16:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 287044382852501160
Date: Tue, 23 Jun 2026 14:16:25 +0800
From: =?GB2312?B?1dS98MP3?= <zhaojinming@uniontech.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: horms <horms@kernel.org>, 
	andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, 
	edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	madalin.bucur <madalin.bucur@nxp.com>, 
	netdev <netdev@vger.kernel.org>, 
	pabeni <pabeni@redhat.com>, 
	sean.anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH v2 2/2] net: fman: use devm_kzalloc() for fman and rely on devres
References: <20260619121328.922138-3-horms@kernel.org>, 
	<20260622090505.2418478-1-zhaojinming@uniontech.com>, 
	<20260622090505.2418478-2-zhaojinming@uniontech.com>, 
	<4692dda4-657a-4c00-9e65-cff4b79d19be@lunn.ch>
X-Priority: 3
X-GUID: 50A79983-525D-472D-9306-2C00D6640FE1
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.375[cn]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <823580887DE24145+2026062314162397367012@uniontech.com>
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: base64
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OUC5DGN0mB58LQVcoNVdoWs9ODNc9vFvN+lKVN8ReQzCe2Xvw++6w0gI
	agb6tw/LZnaZ+4dGXojR7PVnJPI8gchLXAJyi4kczOIhTk6cjkD0h1/rKwsUMKTEAU+OGfj
	z5XeNhfnm7xNCr1Xrm+DrWNiAPKnbIf1OkMESJCB0dlTKVOPOQiuMoWkU5J7wLZ6MRlIMXG
	3YLk49MZErVDrNfhSLLnHwo/3JSbbIWMJJq2PFua4NgTevIUR9dtI+AsTYKaP0WKDcGOG3u
	i5Mag98q0mRI/3BNYMcYPxhUndWOSOet6PliCQC3X+5grJiyfwUR9ItrzAOya6yamGgLs4x
	RKkW5vKWBXts3gek3nh+qa82l4bxwh/BieT3MFgTjueqjuNwJ88TKdXxMcNAhEVr3jnmJIU
	wL/keUPWBAE8s4CLoawy92/PsJBZ2c8kO+H1PpoWNOKBxzu88lbOISbSVwuu96dXBAX8xqD
	cb9Gp0lHxtp7tz1pmjgfin7rBU+hdtyMvRngn3bzOLNhJ4Bjx66HEpd8/+j4iU2v0NHim6A
	AHzTvs1mSBsH2WuPIyAJxv6kFZzZ4JeRhm62SU2LWuUuXBtQz8MuORXMwQbat9JE9Dc9LrC
	Ncg2qdVCbg63+BdkCOV0ZWV0nhZMx2FZ5HQF2qylf1cFbTcLkAm3dN3OipTqOpuNP+j4+KI
	uGfBqgiHQ32g4UdUpx9nv13Efr2jpK0a83Kwou4wmGVdTwfVeRmz1LcwVyk1j2j53aUUhBA
	z1hKLFytenya4IALK7E68cRKl1054UPU5yu/o2Df71rwA0Yd388UVAI33k9V/uamkUrjwLd
	DDEw+oZzkTnnnmZYSOYlXtsVfXGz3jSLrAlbzWNBq3HwvtzMUyF/X+JI1w4I7G8kbXTXSxL
	LunU+w50EokzFR33jpbSMoDYnVYRVflNehbJzQiqHVFMkQujaFOus9/4xppQG26s6jav4rz
	ovlvINyULb1XowIwmBqqBYorMYMmhVz+bpeoW8ASVYW62xq5dsLiktTuAKuBwFdOvV2cjDr
	kocFXJgaHMVcmbSwgEwTz0+yeOCW10xOwx+873aLyZUFM4Z/Qr
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-301268-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:madalin.bucur@nxp.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sean.anderson@linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 430C26B469C

SGkgQW5kcmV3LAoKVGhhbmsgeW91IGZvciBwb2ludGluZyBtZSB0byB0aGUgbmV0ZGV2IG1haW50
YWluZXIgZG9jdW1lbnRhdGlvbi4gSSBoYXZlCnJlYWQgc2VjdGlvbiAxLjcuNCBhbmQgSSB1bmRl
cnN0YW5kIHRoZSBjb25jZXJuIGFib3V0IHN0YW5kYWxvbmUKY2xlYW51cCBjb252ZXJzaW9ucy4K
Ckkgd291bGQgbGlrZSB0byBjbGFyaWZ5IHRoZSBhY3R1YWwgbW90aXZhdGlvbiBiZWhpbmQgdGhl
CmRldm1fa3phbGxvYygpIGNoYW5nZS4gV2hpbGUgaXQgbWF5IGFwcGVhciB0byBiZSBhIHNpbXBs
ZSBkZXZtXwpjb252ZXJzaW9uIG9uIHRoZSBzdXJmYWNlLCBpdCBpcyBpbiBmYWN0IGZpeGluZyBh
IHVzZS1hZnRlci1mcmVlIHJhY2UKY29uZGl0aW9uIGluIHRoZSBJUlFGX1NIQVJFRCBlcnJvciBw
YXRocy4gTGV0IG1lIGV4cGxhaW4gdGhlIHByb2JsZW0KaW4gZGV0YWlsLgoKUFJPQkxFTQo9PT09
PT09CgpJbiByZWFkX2R0c19ub2RlKCksIHRoZSBkcml2ZXIgYWxsb2NhdGVzIGZtYW4gd2l0aCBr
emFsbG9jX29iaigpIGFuZAp0aGVuIHJlZ2lzdGVycyBzaGFyZWQgaW50ZXJydXB0IGhhbmRsZXJz
IHZpYSBkZXZtX3JlcXVlc3RfaXJxKCksIHdpdGgKZm1hbiBwYXNzZWQgYXMgdGhlIGRldl9pZDoK
CglMMjcwMDogZm1hbiA9IGt6YWxsb2Nfb2JqKCpmbWFuKTsKCS4uLgoJTDI3NzQ6IGRldm1fcmVx
dWVzdF9pcnEoJm9mX2Rldi0+ZGV2LCBpcnEsIGZtYW5faXJxLAoJICAgICAgICAgICAgICAgICAg
ICAgICAgIElSUUZfU0hBUkVELCAiZm1hbiIsIGZtYW4pOwoJTDI3ODM6IGRldm1fcmVxdWVzdF9p
cnEoJm9mX2Rldi0+ZGV2LCBlcnJfaXJxLCBmbWFuX2Vycl9pcnEsCgkgICAgICAgICAgICAgICAg
ICAgICAgICAgSVJRRl9TSEFSRUQsICJmbWFuLWVyciIsIGZtYW4pOwoKVGhlIGRldnJlcyBsaXN0
IGFmdGVyIHN1Y2Nlc3NmdWwgcmVnaXN0cmF0aW9uIG9mIHRoZXNlIHJlc291cmNlcyBpczoKCglb
Zm1hbiAobWFudWFsKV0gLT4gW21haW5faXJxIGhhbmRsZXJdIC0+IFtlcnJfaXJxIGhhbmRsZXJd
IC0+IFtpb3JlbWFwXQoKVGhlcmUgYXJlIHRocmVlIGVycm9yIHBhdGhzIGFmdGVyIG1haW5faXJx
IGhhcyBiZWVuIHJlZ2lzdGVyZWQgdGhhdApoaXQgdGhlIGZtYW5fZnJlZSBsYWJlbCBhbmQgY2Fs
bCBrZnJlZShmbWFuKToKCgktIGRldm1fcmVxdWVzdF9pcnEoZXJyX2lycSkgZmFpbHMgICAgICAg
ICAoTDI3NzkpICAtLSBtYWluX2lycSBzdGlsbCByZWdpc3RlcmVkCgktIGRldm1fcGxhdGZvcm1f
Z2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKCkgZmFpbHMgKEwyNzk3KSAgLS0gYm90aCBJUlFzIHJl
Z2lzdGVyZWQKCS0gb2ZfcGxhdGZvcm1fcG9wdWxhdGUoKSBmYWlscyAgICAgICAgICAgIChMMjgw
OSkgIC0tIGJvdGggSVJRcyByZWdpc3RlcmVkCgpOb3RlIHRoYXQgb24gdGhlIGVycl9pcnEgZmFp
bHVyZSBwYXRoIChMMjc3OSksIGVycl9pcnEgd2FzIG5vdApzdWNjZXNzZnVsbHkgcmVnaXN0ZXJl
ZCwgc28gb25seSBtYWluX2lycSByZW1haW5zIGluIHRoZSBkZXZyZXMgbGlzdC4KT24gdGhlIG90
aGVyIHR3byBwYXRocywgYm90aCBJUlEgaGFuZGxlcnMgYXJlIHJlZ2lzdGVyZWQuCgpUYWtpbmcg
b2ZfcGxhdGZvcm1fcG9wdWxhdGUoKSBmYWlsdXJlIGFzIGFuIGV4YW1wbGUsIHRoZSBmdWxsIGVy
cm9yCmNsZWFudXAgc2VxdWVuY2UgaXM6CgogIDEuIG9mX3BsYXRmb3JtX3BvcHVsYXRlKCkgZmFp
bHMKICAyLiBnb3RvIGZtYW5fZnJlZQogIDMuIGtmcmVlKGZtYW4pICAgICAgICAgICAgICAgICAg
ICAgICAgICAtLSBmbWFuIGlzIGZyZWVkLCBidXQgZGV2X2lkCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RpbGwgcG9pbnRzIHRvIHRoaXMgbWVtb3J5CiAgNC4g
cmVhZF9kdHNfbm9kZSgpIHJldHVybnMgRVJSX1BUUihlcnIpCiAgNS4gZm1hbl9wcm9iZSgpIHJl
dHVybnMgZXJyb3IgY29kZQogIDYuIERyaXZlciBjb3JlIGNhbGxzIGRldmljZV91bmJpbmRfY2xl
YW51cCgpIC0+IGRldnJlc19yZWxlYXNlX2FsbCgpLAogICAgIHdoaWNoIHJlbGVhc2VzIGRldnJl
cyByZXNvdXJjZXMgaW4gTElGTyBvcmRlcjoKICAgICAtIFN0ZXAgNmE6IGZyZWUgaW9yZW1hcAog
ICAgIC0gU3RlcCA2YjogZGV2bV9mcmVlX2lycShlcnJfaXJxKSAgICAgICAtLSBlcnJfaXJxIGhh
bmRsZXIgdW5yZWdpc3RlcmVkCiAgICAgLSBTdGVwIDZjOiBkZXZtX2ZyZWVfaXJxKG1haW5faXJx
KSAgICAgIC0tIG1haW5faXJxIGhhbmRsZXIgdW5yZWdpc3RlcmVkCgogICAgIFVudGlsIHN0ZXAg
NmMgY29tcGxldGVzLCBhdCBsZWFzdCBvbmUgSVJRIGhhbmRsZXIgcmVtYWlucyByZWdpc3RlcmVk
CiAgICAgd2l0aCB0aGUgaW50ZXJydXB0IHN1YnN5c3RlbS4gRHVyaW5nIHRoZSB3aW5kb3cgYmV0
d2VlbiBzdGVwIDMKICAgICAoa2ZyZWUpIGFuZCBzdGVwIDZjLCBhIHNoYXJlZCBJUlEgbWF5IGZp
cmUgYW5kIHRoZSBoYW5kbGVyIHdpbGwKICAgICBkZXJlZmVyZW5jZSB0aGUgYWxyZWFkeS1mcmVl
ZCBmbWFuLgoKQmVjYXVzZSB0aGUgaGFuZGxlcnMgYXJlIHJlZ2lzdGVyZWQgd2l0aCBJUlFGX1NI
QVJFRCwgdGhlIGtlcm5lbCB3aWxsCmNhbGwgZm1hbl9pcnEoKSBhbmQgZm1hbl9lcnJfaXJxKCkg
ZXZlbiB3aGVuIHRoZSBpbnRlcnJ1cHQgaXMgdHJpZ2dlcmVkCmJ5IGFub3RoZXIgZGV2aWNlIHNo
YXJpbmcgdGhlIHNhbWUgSVJRIGxpbmUuCgpCb3RoIGhhbmRsZXJzIGltbWVkaWF0ZWx5IGRlcmVm
ZXJlbmNlIHRoZSBmbWFuIHBvaW50ZXI6CgoJc3RhdGljIGlycXJldHVybl90IGZtYW5faXJxKGlu
dCBpcnEsIHZvaWQgKmhhbmRsZSkKCXsKCSAgICBzdHJ1Y3QgZm1hbiAqZm1hbiA9IChzdHJ1Y3Qg
Zm1hbiAqKWhhbmRsZTsKCSAgICBpZiAoIWlzX2luaXRfZG9uZShmbWFuLT5jZmcpKSAgICAgIC0t
IGRlcmVmZXJlbmNlcyBmcmVlZCBmbWFuCgkgICAgICAgIHJldHVybiBJUlFfTk9ORTsKCSAgICAu
Li4KCX0KClRoZSBzYW1lIGlzc3VlIGV4aXN0cyBpbiBmbWFuX2NvbmZpZygpLiBJdHMgZXJyX2Zt
X3N0YXRlIGVycm9yIHBhdGgKY2FsbHMga2ZyZWUoZm1hbikgd2hpbGUgdGhlIGRldm0gSVJRIGhh
bmRsZXJzIHJlZ2lzdGVyZWQgZWFybGllciBpbgpyZWFkX2R0c19ub2RlKCkgYXJlIHN0aWxsIGFj
dGl2ZToKCgllcnJfZm1fc3RhdGU6CgkgICAga2ZyZWUoZm1hbik7ICAgICAgICAgICAgICAgICAg
ICAgICAgLS0gZnJlZSBmbWFuCgkgICAgcmV0dXJuIC1FSU5WQUw7ICAgICAgICAgICAgICAgICAg
ICAgLS0gZGV2cmVzIGNsZWFudXAgcnVucyBhZnRlciByZXR1cm4KCldoZW4gZm1hbl9jb25maWco
KSBmYWlscywgZm1hbl9wcm9iZSgpIHJldHVybnMgLUVJTlZBTCBhdCBMMjg0MSB3aXRob3V0CmFu
eSBjbGVhbnVwLCBhbmQgdGhlIGRyaXZlciBjb3JlIHRoZW4gY2FsbHMgZGV2cmVzX3JlbGVhc2Vf
YWxsKCkgd2hpY2gKcmVsZWFzZXMgdGhlIElSUSBoYW5kbGVycyAtLSBhZ2FpbiBhZnRlciBmbWFu
IGhhcyBhbHJlYWR5IGJlZW4gZnJlZWQuCgpIT1cgZGV2bV9remFsbG9jKCkgRklYRVMgSVQKPT09
PT09PT09PT09PT09PT09PT09PT09PT09PQoKQnkgYWxsb2NhdGluZyBmbWFuIHdpdGggZGV2bV9r
emFsbG9jKCksIGl0IGJlY29tZXMgdGhlIGZpcnN0IGVudHJ5IGluCnRoZSBkZXZyZXMgbGlzdDoK
CglkZXZyZXMgbGlzdDogW2ZtYW5dIC0+IFttYWluX2lycV0gLT4gW2Vycl9pcnFdIC0+IFtpb3Jl
bWFwXQoKRGV2cmVzIHJlbGVhc2VzIHJlc291cmNlcyBpbiBMSUZPIG9yZGVyOgoKCTEuIGZyZWUg
aW9yZW1hcAoJMi4gZGV2bV9mcmVlX2lycShlcnJfaXJxKSAgICAgICAgICAgICAgIC0tIGhhbmRs
ZXJzIHVucmVnaXN0ZXJlZAoJMy4gZGV2bV9mcmVlX2lycShtYWluX2lycSkgICAgICAgICAgICAg
IC0tIGhhbmRsZXJzIHVucmVnaXN0ZXJlZAoJNC4gZGV2bV9rZnJlZShmbWFuKSAgICAgICAgICAg
ICAgICAgICAgIC0tIGZtYW4gZnJlZWQgbGFzdCwgbm8gVUFGCgpTaW5jZSBmbWFuIGlzIGZyZWVk
IG9ubHkgYWZ0ZXIgYWxsIElSUSBoYW5kbGVycyBoYXZlIGJlZW4gdW5yZWdpc3RlcmVkLAp0aGUg
dXNlLWFmdGVyLWZyZWUgd2luZG93IGlzIGNvbXBsZXRlbHkgZWxpbWluYXRlZC4KClRoZSBtYW51
YWwga2ZyZWUoZm1hbikgY2FsbHMgbXVzdCBhbHNvIGJlIHJlbW92ZWQgdG8gYXZvaWQgZG91Ymxl
LWZyZWUsCndoaWNoIGlzIHdoeSB0aGV5IGFyZSBkcm9wcGVkIGluIHRoaXMgcGF0Y2ggYWxvbmcg
d2l0aCB0aGUgYWxsb2NhdGlvbgpjaGFuZ2UuCgpJIHdpbGwgcmV3b3JrIHRoZSBwYXRjaCB3aXRo
IGEgY29tbWl0IG1lc3NhZ2UgdGhhdCBjbGVhcmx5IGRlc2NyaWJlcwp0aGlzIGFzIGEgVUFGIGZp
eCByYXRoZXIgdGhhbiBhIGNsZWFudXAgY29udmVyc2lvbi4gUGxlYXNlIGxldCBtZSBrbm93Cmlm
IHRoaXMgZXhwbGFuYXRpb24gYWRkcmVzc2VzIHRoZSBjb25jZXJuLgoKQmVzdCByZWdhcmRzLApa
aGFvSmlubWluZwoKCgoKPk9uIE1vbiwgSnVuIDIyLCAyMDI2IGF0IDA1OjA1OjA1UE0gKzA4MDAs
IFpoYW9KaW5taW5nIHdyb3RlOgoKCgo+PiBUaGUgZHJpdmVyIG5vdyBhbGxvY2F0ZXMgdGhlIHRv
cC1sZXZlbCBzdHJ1Y3QgZm1hbiB3aXRoIGRldm1fa3phbGxvYygpCgoKCj4+IHNvIHRoYXQgaXRz
IGxpZmV0aW1lIGlzIGJvdW5kIHRvIHRoZSBkZXZpY2UgYW5kIHJlc291cmNlcyBhcmUgcmVsZWFz
ZWQKCgoKPj4gYXV0b21hdGljYWxseSBieSB0aGUgZHJpdmVyIGNvcmUgb24gcHJvYmUgZmFpbHVy
ZSBvciBkZXZpY2UgcmVtb3ZhbC4KCgoKPj4gCgoKCj4+IFJlbW92ZSB0aGUgZXhwbGljaXQga2Zy
ZWUoZm1hbikgZnJvbSB0aGUgZXJyb3IgcGF0aHMgaW4gZm1hbl9jb25maWcoKQoKCgo+PiBhbmQg
cmVhZF9kdHNfbm9kZSgpIHRvIGF2b2lkIGRvdWJsZS1mcmVlL3VzZS1hZnRlci1mcmVlIGFuZCB0
byBmb2xsb3cKCgoKPj4gdGhlIGRldm1fIGFsbG9jYXRpb24gY29udmVudGlvbi4KCgoKPj4gCgoK
Cj4+IEFmdGVyIG9mX2ZpbmRfbWF0Y2hpbmdfbm9kZSgpIGNvbnN1bWVzIGZtX25vZGUncyByZWZl
cmVuY2UgdmlhCgoKCj4+IG9mX25vZGVfcHV0KGZyb20pLCB0aGUgcG9zdC1tdXJhbSBlcnJvciBw
YXRocyBubyBsb25nZXIgbmVlZCB0byBjbGVhbgoKCgo+PiB1cCBmbV9ub2RlLCBzbyByZXBsYWNl
IGdvdG8gZm1hbl9mcmVlIHdpdGggZGlyZWN0IHJldHVybiBFUlJfUFRSKGVycikuCgoKCj4+IAoK
Cgo+PiBUaGlzIGNoYW5nZSBjb21wbGVtZW50cyB0aGUgZXhpc3RpbmcgdXNlIG9mIGRldm1fKiBy
ZXNvdXJjZXMgKGlycSwKCgoKPj4gaW9yZW1hcCwgZXRjLikgYW5kIHNpbXBsaWZpZXMgdGhlIGVy
cm9yIGhhbmRsaW5nIHBhdGhzLgoKCgo+PiAKCgoKPj4gU2lnbmVkLW9mZi1ieTogWmhhb0ppbm1p
bmcgPHpoYW9qaW5taW5nQHVuaW9udGVjaC5jb20+CgoKCj4KCgoKPlBsZWFzZSB0YWtlIGEgcmVh
ZCBvZjoKCgoKPgoKCgo+aHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJv
Y2Vzcy9tYWludGFpbmVyLW5ldGRldi5odG1sCgoKCj4KCgoKPlBsZWFzZSByZWFkIGl0IGFsbCwg
YnV0IHNlZSBzZWN0aW9uIDEuNy40LgoKCgo+CgoKCj4/Pz8gQW5kcmV3CgoKCj4KCgoKPi0tLQoK
Cgo+cHctYm90OiBjcgoKCgo+CgoK


