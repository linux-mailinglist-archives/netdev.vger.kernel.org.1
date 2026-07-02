Return-Path: <netdev+bounces-304032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FPXwHWMjRmpeKgsAu9opvQ
	(envelope-from <netdev+bounces-304032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:37:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A08DB6F4DDC
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:37:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=gqP9UK8s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304032-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304032-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1794F303ACFB
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 08:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B424935E93E;
	Thu,  2 Jul 2026 08:27:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m3292.qiye.163.com (mail-m3292.qiye.163.com [220.197.32.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D52390995
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 08:27:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980841; cv=none; b=WBYA9ps5tnvJprTqfvGJCueAUjwofGUjUm8NJDfgNDiNiLC5eTcfWkZIH+nBG/sumNH4R1JOkrQ1v/Q65amaxb/drVTLrYi0ygPl1fMVRljdYzFdlYEuZCra+V255yGma6t/zMSEB5AItUqo1Je57u+HqIrxvNiTEqidTbafiyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980841; c=relaxed/simple;
	bh=bPYyaPMVGXJ6fi2007K/Cro/FnneDqwZ1yi13CzKCrw=;
	h=Content-Type:Message-ID:To:Cc:Subject:References:MIME-Version:
	 From:Date; b=VEJGpKh+BXad2VBL1WX4umOlXvG+dItmW0L1DEF0wmhmK2wAAm4AeKZXpPh1R3lItOSP/x0ia1jvi1GRxM0AIHaW5LmWCpwLuAzJwB2muEC9rROXzVT3qObD99ndoU1bbIF9mU/IBPtgNrCfs0LqixIPMJ2D7qPIlc0lhcUH+SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=gqP9UK8s; arc=none smtp.client-ip=220.197.32.92
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AIIAMAAiKrVMQaBAPYx42arb.3.1782978704726.Hmail.220255722@seu.edu.cn>
To: Sidraya Jayagond  <sidraya@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	Simon Horman <horms@kernel.org>, 
	Karsten Graul <kgraul@linux.ibm.com>, 
	linux-rdma <linux-rdma@vger.kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	"jianhao.xu" <jianhao.xu@seu.edu.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXRdIG5ldC9zbWM6IGF2b2lkIHJlY3Vyc2l2ZSBza19jYWxsYmFja19sb2NrIGluIGxpc3RlbiBkYXRhX3JlYWR5?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_WIN_1.64.1
References: <20260617152855.1039151-1-runyu.xiao@seu.edu.cn> <17c1cbac-de30-4372-8c24-2acd755f503e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 220255722@seu.edu.cn( [223.112.146.162] ) by ajax-webmail ( [127.0.0.1] ) ; Thu, 2 Jul 2026 15:51:44 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Thu, 2 Jul 2026 15:51:44 +0800 (GMT+08:00)
X-HM-Tid: 0a9f21cf9b6e02f2kunmd5c2bf791f8cd
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMTUS6Y2fHkyPT6dc03QDwVaZPGiA09TnwhbhTj
	hLfuFZO94YXwX6xgvkjGVFFRKj5ODenkkczLo6qxkp6YADE5oPA+xgWdLLpCC0H84TwWSeGl6Gxd
	wNb5mLKCAhELViFYBc6UsltRrkd4duOKE4a1o=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTB5LVh0aSUofSkkeSkIaTlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVU
	pLSEpOT0xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gqP9UK8sz6mSaQSXwWUvX5IW1dCvOoLuzHheLSdx278rR0VZCmzeKQ+tZi/RiuVNKIzYmjvsiiKh3E2yVV1wA+FSjJRGHDbuUfYllhYz2Q+GWTO0qCqt/NhfA/mCQxFWWVdm+uvaLslyTHTIUaWGAPHcSoatnnArMxAxOhY6g+s=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=bPYyaPMVGXJ6fi2007K/Cro/FnneDqwZ1yi13CzKCrw=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUBJ_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:sidraya@linux.ibm.com,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:kgraul@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304032-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,seu.edu.cn:dkim,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A08DB6F4DDC

SGkgU2lkcmF5YSwKCk9uIFRodSwgSnVuIDI1LCAyMDI2IGF0IDAyOjAyOjI1UE0gKzA1MzAsIFNp
ZHJheWEgSmF5YWdvbmQgd3JvdGU6CiZndDsgSW4gc21jX2Nsb3NlX2FjdGl2ZSgpLCB0aGUgVENQ
IHNvY2tldCByZW1haW5zIGluIFRDUF9MSVNURU4gc3RhdGUgd2hpbGUKJmd0OyBob2xkaW5nIHdy
aXRlX2xvY2tfYmgoJmFtcDtzbWMtJmd0O2NsY3NvY2stJmd0O3NrLSZndDtza19jYWxsYmFja19s
b2NrKTsuIFRoZSBwYXRjaCdzCiZndDsgc3RhdGUgY2hlY2sgd291bGQgcGFzcyBkdXJpbmcgdGhp
cyB3aW5kb3csIG5vdCBwcmV2ZW50aW5nIHRoZSByZWN1cnNpdmUKJmd0OyBsb2NrIHNjZW5hcmlv
LgomZ3Q7IEl0J3MgdW5jbGVhciB3aGV0aGVyIGl0IGZ1bGx5IHByZXZlbnRzIHRoZSByZWN1cnNp
dmUgbG9ja2luZyBzY2VuYXJpbwomZ3Q7IGRlc2NyaWJlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ug
Zm9yIHRoZSBzcGVjaWZpYyBjb2RlIHBhdGggaW4KJmd0OyBzbWNfY2xvc2VfYWN0aXZlKCkuCiZn
dDsgQ291bGQgeW91IGNvbWUgdXAgd2l0aCBleGFjdCBkZWFkbG9jayBzY2VuYXJpbyBhbmQgaG93
IHRoZSBwYXRjaAomZ3Q7IGFkZHJlc3NlcyBpdD8KCllvdSBhcmUgcmlnaHQuIEkgZG8gbm90IGhh
dmUgYSBjb25maXJtZWQgY3VycmVudCBtYWlubGluZSBjYWxsIGNoYWluIHdoZXJlCnRoZSBjYWxs
YmFjayBpcyBpbnZva2VkIHVuZGVyIHNrX2NhbGxiYWNrX2xvY2ssIGFuZCB0aGUgVENQX0xJU1RF
TiBjaGVjawpkb2VzIG5vdCBjb3ZlciB0aGUgc21jX2Nsb3NlX2FjdGl2ZSgpIHdpbmRvdyB5b3Ug
cG9pbnRlZCBvdXQuCgpJIHdpbGwgZHJvcCB0aGlzIHBhdGNoIGZvciBub3cuIFRoYW5rcyBmb3Ig
cmV2aWV3aW5nIGl0LgoKUnVueXU=

