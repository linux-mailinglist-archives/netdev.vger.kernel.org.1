Return-Path: <netdev+bounces-304528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rSgOJbCqR2rLdAAAu9opvQ
	(envelope-from <netdev+bounces-304528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 14:27:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F87702561
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 14:27:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=SG1nvMnb;
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304528-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304528-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F7CC3023FB0
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 12:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042CF3CC7EA;
	Fri,  3 Jul 2026 12:20:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m32106.qiye.163.com (mail-m32106.qiye.163.com [220.197.32.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851773093CF
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 12:20:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081258; cv=none; b=axfWlXp1mRFx+GZaGI9T/Q16df8y6J+L3wW6H+XqQy2/SBh/4RDO4GFMbkz7dx3u40aK0PXnfqxoSM0U4QmZzdOaKjbsb/fQcooSjhYyhZir5nPw3/ArqfJis6YwjMY8ivNrr9nGa6Ur0f7eC8tS6P8dMXSOyT+SalyLdRcbAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081258; c=relaxed/simple;
	bh=Sh5U0WcktPrQRWf8YbANFZWk8ylWwf5JVctQoftyaZg=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=fIEfWkFTEb2lngu3sih7vcNsS3shyFsILEmIUACG3o1G5wL4gKWX9vdC0xeVB8kfyWG8yNBz22S1ReT+cIK+TKzsENwYEwsgMmLX0Vv9dr8UEz55PPWwbGjyRo6BKNJJEYGntmK1GyGqwESEwWvCm5In2sSkwNbLgxDseoPh3Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=SG1nvMnb; arc=none smtp.client-ip=220.197.32.106
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AMAAoQBgKr7QFadsWSye64o0.3.1783052662261.Hmail.220255722@seu.edu.cn>
To: Ido Schimmel  <idosch@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bridge <bridge@lists.linux.dev>, netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	"jianhao.xu" <jianhao.xu@seu.edu.cn>
Subject: =?UTF-8?B?UmU6IFF1ZXN0aW9uOiBicmlkZ2U6IGNsYXJpZnkgTVNUIFZMQU4gbGlzdCBSQ1UgdHJhdmVyc2FsIGNvbnRyYWN0?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_WIN_1.64.1
In-Reply-To: <20260628174900.GA400397@shredder>
References: <20260627132539.3701630-1-runyu.xiao@seu.edu.cn> <20260628174900.GA400397@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 220255722@seu.edu.cn( [223.112.146.162] ) by ajax-webmail ( [127.0.0.1] ) ; Fri, 3 Jul 2026 12:24:22 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Fri, 3 Jul 2026 12:24:22 +0800 (GMT+08:00)
X-HM-Tid: 0a9f2637f1c502f2kunm7fae1f9f1e2d
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMTUS6Y2fHkyPT6dc03QDwVaZPGiA09TnwhbhTj
	hLfuFZO94YXwX6xgvkjGVFFRKj5GfO5Omku9T/6BrnRlHEXAyMQMJfF4WZB3hWdN6nWl6ZDg+w6i
	lWlQw5QgNCmEIDvyS+/0arsuJXQe751UCzPTg=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGhlCVksYGBgdQx5KSk5MT1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVU
	pLSEpOT0xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SG1nvMnbdVqOumlMHvWJTqP29odvDs4GTCRb3wjINsxAXsurgkxo5RQzamY8z42iw2Ilqn7757anXkaC+4npOvBR6GqkJPaS41lhw1YKrHy7t87IF8r65VUP3mVJ6ZLk9rBPaOimMaCBZpnvEQqltN/VlCzK3jP1vqmP2MVllbc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=Sh5U0WcktPrQRWf8YbANFZWk8ylWwf5JVctQoftyaZg=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUBJ_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304528-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:razor@blackwall.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,seu.edu.cn:from_mime,seu.edu.cn:dkim,seu.edu.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94F87702561

SGkgSWRvLAoKT24gU3VuLCAyOCBKdW4gMjAyNiAyMDo0OTowMCArMDMwMCwgSWRvIFNjaGltbWVs
IHdyb3RlOgomZ3Q7IEkgZG9uJ3QgdGhpbmsgYW55dGhpbmcgbmVlZHMgdG8gY2hhbmdlLiBBRkFJ
Q1QsIGJyX21zdF9pbmZvX3NpemUoKSBpcwomZ3Q7IG9ubHkgcmVhY2hhYmxlIHZpYSB0aGUgZ2V0
X2xpbmtfYWZfc2l6ZSgpIGNhbGxiYWNrIGFuZAomZ3Q7IHJ0bmxfbGlua19nZXRfYWZfc2l6ZSgp
IGFsd2F5cyBpbnZva2VzIGl0IGZyb20gYW4gUkNVIHJlYWQtc2lkZSBjcml0aWNhbAomZ3Q7IHNl
Y3Rpb24uCiZndDsKJmd0OyBEaWQgeW91IHNlZSBhIHNwbGF0IHdpdGggQ09ORklHX1BST1ZFX1JD
VV9MSVNUPwpUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLgoKTm8sIEkgZGlkIG5vdCBzZWUg
YW4gaW4ta2VybmVsIHNwbGF0IGZyb20gdGhlIGFjdHVhbCBydG5ldGxpbmsgcGF0aC4KVGhlIHdh
cm5pbmcgSSBoYWQgd2FzIGZyb20gdGhlIHJldmlld2VkIG91dC1vZi10cmVlIHJlcHJvZHVjZXIg
dXNlZCBmb3IKb3VyIENPTkZJR19QUk9WRV9SQ1VfTElTVCB0cmlhZ2UsIG5vdCBmcm9tIGEgcmVh
bCBicmlkZ2UgbmV0bGluayBjYWxsCnBhdGguCgpHaXZlbiB5b3VyIGV4cGxhbmF0aW9uIHRoYXQg
cnRubF9saW5rX2dldF9hZl9zaXplKCkgYWxyZWFkeSBpbnZva2VzCnRoaXMgZnJvbSBhbiBSQ1Ug
cmVhZC1zaWRlIGNyaXRpY2FsIHNlY3Rpb24sIEkgd2lsbCB0cmVhdCB0aGlzIGFzIGFuCmludGVu
ZGVkIGNvbnRyYWN0IGFuZCBJIHdpbGwgbm90IHB1cnN1ZSBhIHBhdGNoIGZvciBpdCBiYXNlZCBv
biB0aGUKY3VycmVudCBldmlkZW5jZS4KClRoYW5rcywKUnVueXUKCg==

