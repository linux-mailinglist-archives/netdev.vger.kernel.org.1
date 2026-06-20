Return-Path: <netdev+bounces-300795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JXtFLTVmNmoB/QYAu9opvQ
	(envelope-from <netdev+bounces-300795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 12:06:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A78A26A8B98
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 12:06:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=hEcr3ZnC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300795-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300795-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DAC33003BF9
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA14B2F8E98;
	Sat, 20 Jun 2026 10:06:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m1973182.qiye.163.com (mail-m1973182.qiye.163.com [220.197.31.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31A352012
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 10:06:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781949998; cv=none; b=LK4Lb5LnJMpZmtyGkGYRTQZWnH3rJvFiR9YQCpWIDrms+ZAXXfQ75ZM0b06pjefZdptDCO3rY/ed/b5faK/xJ+ZuLhljoZpL/DtRAwmrwcruN/9p7w0tpRTLoeSNQqZSp+M5k2okYbiEv2dhLDeOsylHKOUczmgzQEHbOx0p6X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781949998; c=relaxed/simple;
	bh=jKdUFOxSFfw2CIXMaNErLvEKlvwiKYMIWgbfx+3spL4=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=aEWjgVqUye3RCKOR8wShvXA3q/9KEt14d5HzPU5oRMyo6PCbyGAlgYf7pQuv20hC3xfg2w/jfNFd5sapxsFg+BK2wn3CK6dhjX0I6BAjIoJ6inrDLILLlW6nICM68z/4+iLi8s3bdTpa/ULDnX6xxAGwfmOq8cQGN2RmBvHrVQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hEcr3ZnC; arc=none smtp.client-ip=220.197.31.82
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AGUAvgD7KqAX5vkMllTuJarw.3.1781949676685.Hmail.220255722@seu.edu.cn>
To: David Laight  <david.laight.linux@gmail.com>
Cc: Taras Chornyi <taras.chornyi@plvision.eu>, netdev <netdev@vger.kernel.org>, 
	andrew+netdev <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	Oleksandr Mazur <oleksandr.mazur@plvision.eu>, 
	Andrii Savka <andrii.savka@plvision.eu>, 
	Vadym Kochan <vadym.kochan@plvision.eu>, 
	Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Jianhao Xu <jianhao.xu@seu.edu.cn>, stable <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXRdIG5ldDogbWFydmVsbDogcHJlc3RlcmE6IHVzZSB1bmFsaWduZWQgYWNjZXNzb3JzIGZvciBEU0EgdGFn?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_WIN_1.64.1
In-Reply-To: <20260620104750.5270a11c@pumpkin>
References: <20260620093739.2164921-1-runyu.xiao@seu.edu.cn> <20260620104750.5270a11c@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 220255722@seu.edu.cn( [223.112.146.162] ) by ajax-webmail ( [127.0.0.1] ) ; Sat, 20 Jun 2026 18:01:16 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Sat, 20 Jun 2026 18:01:16 +0800 (GMT+08:00)
X-HM-Tid: 0a9ee4735fdd02f2kunm2404b49df170
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMTUS6Y2fHkyPT6dc03QDwVaZPGiA09TnwhbhTj
	hLfuFZO94YXwX6xgvkjGVFFRKj5HlnR/0mP2qfaD/1op6Ml5grsg0dkSS+RAAMENcdXCRYIETeNg
	LD+KDgT/C0CF3MmlBs8v3Zl6+ZI2MBtOc/JNE=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGEtCVhlMGENOSBhIS0tMHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVU
	pLSEpOT0xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hEcr3ZnCWF18P65lRyf9OSWyUuCoSmyqXFiwp1pxx+EupSiG9sOXBgQioecYRkVJx6uG6NixUbEPDBEPGO2RMWmK56NpELwr732CUCl8HxHECEiKQzRLCWt2NW7v4PPWh7xhcK4Tsq1HOkcbZnjBQKJMi9Z+WxQvfXnuYMIhtao=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=jKdUFOxSFfw2CIXMaNErLvEKlvwiKYMIWgbfx+3spL4=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.94 / 15.00];
	SUBJ_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:taras.chornyi@plvision.eu,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:oleksandr.mazur@plvision.eu,m:andrii.savka@plvision.eu,m:vadym.kochan@plvision.eu,m:volodymyr.mytnyk@plvision.eu,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,m:davidlaightlinux@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300795-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:dkim,seu.edu.cn:mid,seu.edu.cn:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A78A26A8B98

T24gU2F0LCAyMCBKdW4gMjAyNiAxNzo0Nzo1MCArMDgwMCwgRGF2aWQgTGFpZ2h0IHdyb3RlOgom
Z3Q7IFN0b3Agc2VuZGluZyB0aGVzZSAnZml4ZXMnIHVubGVzcyB5b3UgY2FuIGRvIHByb3BlciBh
bmFseXNpcy4KJmd0OyBza2IgZGF0YSBpcyBndWFyYW50ZWVkIHRvIGJlIGFsaWduZWQgc28gdGhh
dCB0aGVzZSByZWFkcyAoYW5kIG9uZXMgb2YKJmd0OyB0aGUgSVAvVENQL1VEUCBoZWFkZXJzKSBh
cmUgYWxpZ25lZC4KCllvdSBhcmUgcmlnaHQuIEkgdHJlYXRlZCB0aGUgRFNBIHRhZyBidWZmZXIg
YXMgYSBnZW5lcmljIGJ5dGUgYnVmZmVyIGFuZApkaWQgbm90IGFjY291bnQgZm9yIHRoZSBza2Ig
ZGF0YSBhbGlnbm1lbnQgZ3VhcmFudGVlcyBpbiB0aGlzIHBhdGguCgpQbGVhc2UgZHJvcCB0aGlz
IHBhdGNoLiBJIHdpbGwgcmUtY2hlY2sgdGhlIHJlbWFpbmluZyByZXBvcnRzIGFnYWluc3QKdGhl
IHJlbGV2YW50IHN1YnN5c3RlbSBhbGlnbm1lbnQgY29udHJhY3RzIGJlZm9yZSBzZW5kaW5nIGFu
eXRoaW5nIGVsc2UuCgpwdy1ib3Q6IGNoYW5nZXMtcmVxdWVzdGVkCgpUaGFua3MsClJ1bnl1

