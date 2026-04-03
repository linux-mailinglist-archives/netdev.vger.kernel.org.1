Return-Path: <netdev+bounces-274949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGAnGY6Bz2mwwwYAu9opvQ
	(envelope-from <netdev+bounces-274949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:59:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B81D33927A0
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AB8A301051A
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 08:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5ED3793D0;
	Fri,  3 Apr 2026 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="dXPGUcXM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m15598.qiye.163.com (mail-m15598.qiye.163.com [101.71.155.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A370258ED5;
	Fri,  3 Apr 2026 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206387; cv=none; b=fkmmwxeE9iMHHihxKbDycC0FFTDAOmP0so8MfQlV/vNIU/s6roTekkOO+uNzFvQ+GEKYRx5WLjkjpgEzBGTvYPCURwQHTebqKIF7q4gSBcPi+uZekbCjT0LWRZxsYWlFH5NBEEgjvYArrLZpMNZiYFUb3e0CkkbUbWBdidm9gr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206387; c=relaxed/simple;
	bh=LlCHgrZz5eoqetpFDiMtgz8KEZCNIC1rPzD2KaRxZNs=;
	h=Content-Type:Message-ID:To:Cc:Subject:MIME-Version:From:Date; b=YmHsF+K20avbF0zCvNTQu1EZ/7zt02IhSg+MmuIEzXOSKgbaC+T4mNfzLHGp5+Mh0eub7rqILT/PV24IhYGltIsESXkJ+uXWrjdw42L8RR1qsDYKw1J9cfQX7IDr9YKOVSoQkmQ1MUPtmIcNQ8PZGHGZFyBZURXEW8+xDRj7S18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=dXPGUcXM; arc=none smtp.client-ip=101.71.155.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AEEA*QCTKNjE1V26ToUg*qop.1.1775206372647.Hmail.2023000929@ruc.edu.cn>
To: Andrew Lunn <andrew@lunn.ch>
Cc: rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ojeda@kernel.org, boqun@kernel.org, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: =?UTF-8?B?UmU6UmU6IFtSRkMgUEFUQ0ggMC82XSBydXN0OiBuZXQ6IGludHJvZHVjZSBtaW5pbWFsIHJ0bmwvbmV0ZGV2aWNlIGFic3RyYWN0aW9ucyBhbmQgbmxtb24gcmVmZXJlbmNlIGRyaXZlcg==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 2023000929@ruc.edu.cn( [13.158.35.89] ) by ajax-webmail ( [127.0.0.1] ) ; Fri, 3 Apr 2026 16:52:52 +0800 (GMT+08:00)
From: wenzhaoliao <wenzhaoliao@ruc.edu.cn>
Date: Fri, 3 Apr 2026 16:52:52 +0800 (GMT+08:00)
X-HM-Tid: 0a9d528b2bb709bdkunm8df244d54a905
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMf2U5gprSpllrVBCJYClE3duRf49djg1aYGfsM
	uZDiMw13rgupekfOvPAPf775DoKRV/qo9dby/TLvknqP0tEE2KldSlrG9pKU6xVEx7PTkNyj7YtV
	XptvzT+qAQgzvABkuWxVBaR/AKTYFMShDXN+Q=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSEofVhgeGk4dTBlIGBgdSlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSFVKTkNVSE5VQ0JZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dXPGUcXMcKwZIhJaqh/qJxtkyjMGqkcHL/3C8X2VjdboAbBUjcchRkU/wJlO/lKmzPtkI++DEA9L4Utu1DSQrrIoeRRLWpu3JY8IXyBaujpXNJ6NMJudTOz69Xt6Vio5UI+3LusGGWH79k7XHDGY1eew+VsV77NjfkSVbpHlwEA=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=LlCHgrZz5eoqetpFDiMtgz8KEZCNIC1rPzD2KaRxZNs=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ruc.edu.cn,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ruc.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-274949-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ruc.edu.cn:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,lunn.ch,davemloft.net,redhat.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenzhaoliao@ruc.edu.cn,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B81D33927A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CgpIaSBBbmRyZXcsClRoYW5rIHlvdSBmb3IgdGhlIGNhbmRpZCBmZWVkYmFjay4gSSBjb21wbGV0
ZWx5IHVuZGVyc3RhbmQgYW5kIGFncmVlIHdpdGggeW91ciBwb2ludC4gSW50cm9kdWNpbmcgUnVz
dCBqdXN0IGZvciB0aGUgc2FrZSBvZiByZXdyaXRpbmcgZXhpc3RpbmcsIHBlcmZlY3RseSB3b3Jr
aW5nIEMgY29kZSBpcyBub3QgdGhlIGdvYWwgaGVyZS4KVG8gY2xhcmlmeSwgbXkgcHJpbWFyeSBt
b3RpdmF0aW9uIGZvciBzdWJtaXR0aW5nIHRoZSBubG1vbiBkcml2ZXIgd2FzIG5vdCB0byByZXBs
YWNlIHRoZSBDIGltcGxlbWVudGF0aW9uLCBidXQgcmF0aGVyIHRvIHVzZSBpdCBhcyBhIG1pbmlt
YWwsIGlzb2xhdGVkIHRlc3RiZWQgdG8gdmFsaWRhdGUgdGhlIHByb3Bvc2VkIFJ1c3QgbmV0d29y
a2luZyBhYnN0cmFjdGlvbnMgKHRoZSBmaXJzdCBwYXJ0IG9mIHRoZSBwYXRjaCBzZXJpZXMpLiBJ
IHdhbnRlZCB0byBlbnN1cmUgdGhlIGFic3RyYWN0aW9ucyB3ZXJlIHNvbWV3aGF0IGdyb3VuZGVk
IGluIGEgcmVhbCB1c2UgY2FzZSBiZWZvcmUgYXR0ZW1wdGluZyB0byB3cml0ZSBhIGRyaXZlciBm
b3IgYSBjb21wbGV0ZWx5IG5ldyBkZXZpY2UuClNpbmNlIEkgYW0gdmVyeSBlYWdlciB0byBjb250
cmlidXRlIHRvIHRoZSBSdXN0IGZvciBMaW51eCBuZXR3b3JrIGluZnJhc3RydWN0dXJlIGluIHRo
ZSBsb25nIHJ1biwgSSB3b3VsZCBoaWdobHkgYXBwcmVjaWF0ZSBpdCBpZiB5b3UgKG9yIGFueW9u
ZSBvbiB0aGUgbGlzdCkgY291bGQgc3BhcmUgYSBmZXcgbWludXRlcyB0byBicmllZmx5IHJldmll
dyB0aGUgZGVzaWduIG9mIHRoZSBhYnN0cmFjdGlvbnMgYW5kIHRoZSBpZGlvbWF0aWMgUnVzdCB1
c2FnZSBpbiB0aGUgcGF0Y2gsIHB1cmVseSBmcm9tIGEgdGVjaG5pY2FsIGFuZCBhcmNoaXRlY3R1
cmFsIHBlcnNwZWN0aXZlLiBLbm93aW5nIHdoZXRoZXIgdGhlc2UgYWJzdHJhY3Rpb25zIGFyZSBv
biB0aGUgcmlnaHQgdHJhY2sgd291bGQgYmUgaW5jcmVkaWJseSBoZWxwZnVsIGZvciBtZSBiZWZv
cmUgSSBhcHBseSB0aGVtIHRvIGEgbmV3bHkgcmVxdWVzdGVkIGRyaXZlciBhcyB5b3Ugc3VnZ2Vz
dGVkLgpJZiB0aGUgbmV0ZGV2IG1haWxpbmcgbGlzdCBpcyBub3QgdGhlIGFwcHJvcHJpYXRlIHZl
bnVlIGZvciBkaXNjdXNzaW5nIGV4cGVyaW1lbnRhbCBSdXN0IGFic3RyYWN0aW9ucyBvciBzZWVr
aW5nIGRlc2lnbiBmZWVkYmFjayBvbiByZWZlcmVuY2UgY29kZSwgY291bGQgeW91IGtpbmRseSBw
b2ludCBtZSB0byB0aGUgcmlnaHQgcGxhY2U/IFdvdWxkIHRoZSBSdXN0LWZvci1MaW51eCBadWxp
cCBvciB0aGUgcnVzdC1mb3ItbGludXggbWFpbGluZyBsaXN0IGJlIGEgYmV0dGVyIGNoYW5uZWwg
dG8gZGlzY3VzcyBob3cgdG8gaW1wcm92ZSB0aGVzZSBhYnN0cmFjdGlvbnM/ClRoYW5rIHlvdSBh
Z2FpbiBmb3IgeW91ciB0aW1lIGFuZCBndWlkYW5jZS4KQmVzdCByZWdhcmRzLApXZW56aGFvIExp
YW8KCgoKCgoKCuWPkeS7tuS6uu+8mkFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4K5Y+R6YCB
5pel5pyf77yaMjAyNi0wNC0wMyAwNDowMDoyOArmlLbku7bkurrvvJpXZW56aGFvIExpYW8gPHdl
bnpoYW9saWFvQHJ1Yy5lZHUuY24+CuaKhOmAgeS6uu+8mnJ1c3QtZm9yLWxpbnV4QHZnZXIua2Vy
bmVsLm9yZyxuZXRkZXZAdmdlci5rZXJuZWwub3JnLGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcsb2plZGFAa2VybmVsLm9yZyxib3F1bkBrZXJuZWwub3JnLGdhcnlAZ2FyeWd1by5uZXQsYmpv
cm4zX2doQHByb3Rvbm1haWwuY29tLGxvc3NpbkBrZXJuZWwub3JnLGEuaGluZGJvcmdAa2VybmVs
Lm9yZyxhbGljZXJ5aGxAZ29vZ2xlLmNvbSx0bWdyb3NzQHVtaWNoLmVkdSxkYWtyQGtlcm5lbC5v
cmcsYW5kcmV3K25ldGRldkBsdW5uLmNoLGRhdmVtQGRhdmVtbG9mdC5uZXQsZWR1bWF6ZXRAZ29v
Z2xlLmNvbSxrdWJhQGtlcm5lbC5vcmcscGFiZW5pQHJlZGhhdC5jb20K5Li76aKY77yaUmU6IFtS
RkMgUEFUQ0ggMC82XSBydXN0OiBuZXQ6IGludHJvZHVjZSBtaW5pbWFsIHJ0bmwvbmV0ZGV2aWNl
IGFic3RyYWN0aW9ucyBhbmQgbmxtb24gcmVmZXJlbmNlIGRyaXZlcj5PbiBUaHUsIEFwciAwMiwg
MjAyNiBhdCAxMjozNjozNFBNIC0wNDAwLCBXZW56aGFvIExpYW8gd3JvdGU6Cj4+IEhpLAo+PiAK
Pj4gVGhpcyBSRkMgcHJvcG9zZXMgYSBtaW5pbWFsIHNldCBvZiBSdXN0IG5ldHdvcmtpbmcgYWJz
dHJhY3Rpb25zIGZvcgo+PiBsaW5rLXR5cGUgZHJpdmVycywgdG9nZXRoZXIgd2l0aCBhIFJ1c3Qg
aW1wbGVtZW50YXRpb24gb2Ygbmxtb24gYXMgYQo+PiByZWZlcmVuY2UgZHJpdmVyLgo+Cj5ubG1v
biBleGlzdHMuIFdoeSB3b3VsZCB3ZSB3YW50IGEgc2Vjb25kIGltcGxlbWVudGF0aW9uIGluIFJ1
c3Q/Cj4KPkl0IHNlZW1zIGxpa2Ugd2Uga2VlcCBnZXR0aW5nIFJ1c3Qgc3VibWlzc2lvbnMgZm9y
IHRoZSBzYWtlIG9mCj5zdWJtaXR0aW5nIFJ1c3QuIFdlIG5ldmVyIHNlZW0gdG8gZ2V0IFJ1c3Qg
Y29kZSBhZGRpbmcgc29tZXRoaW5nIG5ldywKPnNvbWV0aGluZyB3aGljaCBkb2VzIG5vdCBhbHJl
YWR5IGV4aXN0Lgo+Cj5QbGVhc2UsIGlmIHlvdSB3YW50IHRvIHN1Ym1pdCBSdXN0IGNvZGUsIGZp
bmQgYSBkZXZpY2Ugd2hpY2ggZG9lcyBub3QKPmhhdmUgYSBkcml2ZXIgYW5kIHdyaXRlIGEgZHJp
dmVyIGZvciBpdCwgaW4gUnVzdC4gT3IgZmluZCBhIHByb3RvY29sCj5kZXNjcmliZWQgaW4gYW4g
UkZDIHdoaWNoIHdlIGRvbid0IGltcGxlbWVudCwgYW5kIHdyaXRlIGEgUnVzdAo+aW1wbGVtZW50
YXRpb24uIE9yIGZpbmQgYSBuZXcgZmlyZXdhbGwgcnVsZSB3aGljaCBjYW5ub3QgYmUgZGVzY3Jp
YmVkCj51c2luZyB0aGUgY3VycmVudCBjb2RlLCBhbmQgaW1wbGVtZW50IGl0IGluIFJ1c3QuCj4K
PlVubGVzcyBpdCBpcyBzb21ldGhpbmcgbmV3LCBpIGRvdWJ0IGl0IHdpbGwgZ2V0IGFjY2VwdGVk
Lgo+Cj4gICAgICAgQW5kcmV3Cj4K

