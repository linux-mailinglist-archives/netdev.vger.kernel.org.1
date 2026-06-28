Return-Path: <netdev+bounces-302380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OBd4GsLMQGr2iAkAu9opvQ
	(envelope-from <netdev+bounces-302380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 09:26:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E74A26D3582
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 09:26:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=PxQ+6usg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302380-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302380-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F5413005994
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 07:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC739218845;
	Sun, 28 Jun 2026 07:26:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49228.qiye.163.com (mail-m49228.qiye.163.com [45.254.49.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5CF2F872
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 07:26:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782631613; cv=none; b=Df4mTf48pFBFdtvDZBWhajhhnrw6XZ7yCpc0spQTqIYY0lm3+Fj5MoQoBLFQLmHGoYdClkdWNQeGLi6NWt1DgZUUIA4zC2Ylqp41GTOdtbL/DB5vgik7LFRsHB+X0kl2aRZsPJ17MRL26CAHBBdcWGS5WIHuQWnH4pEU3HEJpkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782631613; c=relaxed/simple;
	bh=yns7EYALhF6S1Qn2UCp2deAXK5Ibk5U2WE4Q5prGCGk=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=XT6vzE9yaojbmvocWTH158GeFwGZ78gHsuOD2pt6rk3y0JEaRrSqxD9h/bf7AcYrZ6Qes4j6uBR+0aQdNESTm8l94vAmotOVibWnk6K2Rz/yQc6AbAtDv7OrDu/Pn67E9Amq5U3WamSNa1kcEYJFe+qFS5nF1lJby23Gt/cQ+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=PxQ+6usg; arc=none smtp.client-ip=45.254.49.228
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AFEAtADoKs22QyipHhKwe4op.3.1782623057057.Hmail.220255722@seu.edu.cn>
To: Jakub Kicinski  <kuba@kernel.org>
Cc: davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, horms <horms@kernel.org>, 
	leitao <leitao@debian.org>, sashal <sashal@kernel.org>, 
	bigeasy <bigeasy@linutronix.de>, netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	"jianhao.xu" <jianhao.xu@seu.edu.cn>
Subject: =?UTF-8?B?UmU6IFtSRkMgUEFUQ0ggbmV0LW5leHRdIG5ldHBvbGw6IGhvbGQgUkNVIHdoaWxlIHdhbGtpbmcgbmFwaV9saXN0?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_WIN_1.64.1
In-Reply-To: <20260627142105.29f1322c@kernel.org>
References: <20260627101228.1191586-1-runyu.xiao@seu.edu.cn> <20260627142105.29f1322c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 220255722@seu.edu.cn( [223.112.146.162] ) by ajax-webmail ( [127.0.0.1] ) ; Sun, 28 Jun 2026 13:04:17 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Sun, 28 Jun 2026 13:04:17 +0800 (GMT+08:00)
X-HM-Tid: 0a9f0c9a86ef02f2kunm8623471ff3b0
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMTUS6Y2fHkyPT6dc03QDwVaZPGiA09TnwhbhTj
	hLfuFZO94YXwX6xgvkjGVFFRKj5KLe6NS1CGiyhuD0RcZHIxcyljU39+n1YnYQfUuQJf73cLjTIU
	yq9bpWVPXKN3Z9gsEIaThAzp9eqY0COUUIz5A=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTh0ZVh9JGUoYGRpCTR1MS1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVU
	pLSEpOT0xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PxQ+6usgxK/4JU6RU1m4g+jF/+WEdvEYwuupMmevs0a7vOnPsKYoxLvhGqY0D6X4NinUWzEym1cbXCibQzneeCrQjpi6+D1V7vk8lrblROwcQyslemabgl5ZOctpMmu7prHWHhftsrRQMxcFVorotFXzjFdNLS46msBHYcp4Gcg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=yns7EYALhF6S1Qn2UCp2deAXK5Ibk5U2WE4Q5prGCGk=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUBJ_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-302380-lists,netdev=lfdr.de];
	HAS_X_PRIO_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:leitao@debian.org,m:sashal@kernel.org,m:bigeasy@linutronix.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,seu.edu.cn:dkim,seu.edu.cn:mid,seu.edu.cn:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E74A26D3582

SGksCgpPbiBTYXQsIDI3IEp1biAyMDI2IDE0OjIxOjA1IC0wNzAwIEpha3ViIEtpY2luc2tpIHdy
b3RlOgomZ3Q7IFBsZWFzZSBwcm92aWRlIHRoZSBzdGFjayB0cmFjZSBmcm9tIHRoZSByZXBvcnQs
IHJhdGhlciB0aGFuIGp1c3Qgc2F5aW5nCiZndDsgdGhhdCB5b3UgY2FuIHRyaWdnZXIgaXQuCgpT
dXJlLCBzb3JyeSBmb3Igbm90IGluY2x1ZGluZyBpdCBpbiB0aGUgUkZDLiAgVGhlIHdhcm5pbmcg
d2FzIGZyb20gdGhlCnJldmlld2VkIHJlcHJvZHVjZXIgdXNlZCBmb3IgdGhlIENPTkZJR19QUk9W
RV9SQ1VfTElTVCB0cmlhZ2UsIG5vdCBmcm9tCmEgcHJvZHVjdGlvbiBjcmFzaC4gIFRoZSByZWxl
dmFudCBwYXJ0IG9mIHRoZSBkbWVzZyBpczoKCiAgV0FSTklORzogc3VzcGljaW91cyBSQ1UgdXNh
Z2UKICA2LjEuNjYgIzMgVGFpbnRlZDogRyAgICAgICAgICAgTwogIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCiAgL2hvbWUvdWJ1bnR1MjIvbXN2X3dvcmtzcGFjZS9zaGFyZWQvdnVsbl9t
c3YuYzo0NSBSQ1UtbGlzdCB0cmF2ZXJzZWQgaW4gbm9uLXJlYWRlciBzZWN0aW9uISEKCiAgb3Ro
ZXIgaW5mbyB0aGF0IG1pZ2h0IGhlbHAgdXMgZGVidWcgdGhpczoKCiAgcmN1X3NjaGVkdWxlcl9h
Y3RpdmUgPSAyLCBkZWJ1Z19sb2NrcyA9IDEKICBubyBsb2NrcyBoZWxkIGJ5IGluc21vZC8xOTAu
CgogIHN0YWNrIGJhY2t0cmFjZToKICBDUFU6IDEgUElEOiAxOTAgQ29tbTogaW5zbW9kIFRhaW50
ZWQ6IEcgICAgICAgICAgIE8gICAgICAgNi4xLjY2ICMzCiAgSGFyZHdhcmUgbmFtZTogUUVNVSBT
dGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xNS4wLTEgMDQvMDEvMjAx
NAogIENhbGwgVHJhY2U6CiAgIDx0YXNrPgogICBkdW1wX3N0YWNrX2x2bCsweDQ1LzB4NWQKICAg
bG9ja2RlcF9yY3Vfc3VzcGljaW91cy5jb2xkKzB4MmQvMHg2NAogICBwb2xsX25hcGkuY29uc3Rw
cm9wLjArMHg0My8weDcxIFt2dWxuX21zdl0KICAgbmV0cG9sbF9wb2xsX2Rldi5jb25zdHByb3Au
MCsweDI3LzB4MzYgW3Z1bG5fbXN2XQogICA/IDB4ZmZmZmZmZmZjMDAwNTAwMAogICByY3VfbGlz
dF9tc3ZfaW5pdCsweGUyLzB4MTAwMCBbdnVsbl9tc3ZdCiAgIGRvX29uZV9pbml0Y2FsbCsweDU2
LzB4MjUwCiAgIGRvX2luaXRfbW9kdWxlKzB4NDcvMHgxYzAKICAgX19kb19zeXNfZmluaXRfbW9k
dWxlKzB4YTYvMHgxMDAKICAgZG9fc3lzY2FsbF82NCsweDNiLzB4OTAKICAgZW50cnlfU1lTQ0FM
TF82NF9hZnRlcl9od2ZyYW1lKzB4NjQvMHhjZQogICA8L3Rhc2s+CgpUaGUgcmVwcm9kdWNlciBr
ZWVwcyB0aGUgc2hhcGUgaW50ZW50aW9uYWxseSBzbWFsbDogbmV0cG9sbF9wb2xsX2RldigpCmlz
IGV4ZXJjaXNlZCBkaXJlY3RseSBhbmQgY2FsbHMgcG9sbF9uYXBpKCksIHdoaWNoIHdhbGtzIGRl
di0mZ3Q7bmFwaV9saXN0CndpdGggbGlzdF9mb3JfZWFjaF9lbnRyeV9yY3UoKSBvdXRzaWRlIGFu
IGV4cGxpY2l0IFJDVSByZWFkLXNpZGUgc2VjdGlvbi4KSXQgZG9lcyBub3QgbW9kZWwgYSBjb25j
dXJyZW50IE5BUEkgZnJlZS4KClRoYW5rcy4K

