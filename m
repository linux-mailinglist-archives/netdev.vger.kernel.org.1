Return-Path: <netdev+bounces-275873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AEjO6an1GmkwAcAu9opvQ
	(envelope-from <netdev+bounces-275873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 08:43:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 507473AA652
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 08:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13F90305932D
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 06:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801CE374170;
	Tue,  7 Apr 2026 06:41:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-14.us.a.mail.aliyun.com (out198-14.us.a.mail.aliyun.com [47.90.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6360733EAE6;
	Tue,  7 Apr 2026 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544064; cv=none; b=A0+c+GmOt3YEesYJhrhi0zDo+r0mZ9GeMK3LZ/4aUdOKCbiCWDf0mNp7SCrw5vzHSzaRbEPfNLsIt4d/SXikwkQ/TZ7D5ER3c5qDk4Dp5Qo+vlQ3XsVD1uBMdAqsAPZj8HVOUYWKDqW9HHSk0C1ZioO75UkWiPNc2nqoDgzau8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544064; c=relaxed/simple;
	bh=vZ/8AVlL5X/zdaP6ANerbdJJqiKgPl/c+ac8ekNqiCc=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=Hvxqkd+BkpRh39Y4TxgPfr5KSDKQsOn6rbEsmxia+g2FKN8ga2EGnJopnJbyd/m6xU3uPEpiDD/xh14eCzYrjbcOPv1CZroPoFzGCu05E/O7hgF8KP/Hlfs9Cb8Tl92+hPsSjHs8/qzTlGGtKAQA0+OEJoJA8GUDvBT33JvBrmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07357008|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0507587-0.000292431-0.948949;FP=4852584807228152790|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=20;RT=20;SR=0;TI=W4_0.2.3_212504DB_1775543914346_o7001c333c;
Received: from WS-web (Illusion.Wang@nebula-matrix.com[W4_0.2.3_212504DB_1775543914346_o7001c333c] cluster:ay29) at Tue, 07 Apr 2026 14:40:35 +0800
Date: Tue, 07 Apr 2026 14:40:35 +0800
From: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
To: "Mohsin Bashir" <mohsin.bashr@gmail.com>,
  "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "Sam" <sam.chen@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>
Cc: "andrew+netdev" <andrew+netdev@lunn.ch>,
  "corbet" <corbet@lwn.net>,
  "kuba" <kuba@kernel.org>,
  "linux-doc" <linux-doc@vger.kernel.org>,
  "lorenzo" <lorenzo@kernel.org>,
  "pabeni" <pabeni@redhat.com>,
  "horms" <horms@kernel.org>,
  "vadim.fedorenko" <vadim.fedorenko@linux.dev>,
  "lukas.bulwahn" <lukas.bulwahn@redhat.com>,
  "edumazet" <edumazet@google.com>,
  "enelsonmoore" <enelsonmoore@gmail.com>,
  "skhan" <skhan@linuxfoundation.org>,
  "hkallweit1" <hkallweit1@gmail.com>,
  "jani.nikula" <jani.nikula@intel.com>,
  "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
Message-ID: <acc4ce53-17bb-4bc4-a52c-d6f30b6fabc2.Illusion.Wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHYxMCBuZXQtbmV4dCAwMi8xMV0gbmV0L25lYnVsYS1tYXRyaXg6?=
  =?UTF-8?B?IGFkZCBvdXIgZHJpdmVyIGFyY2hpdGVjdHVyZQ==?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260401022318.28550-1-illusion.wang@nebula-matrix.com> <20260401022318.28550-3-illusion.wang@nebula-matrix.com>,<bf9f7c6f-8759-4f4f-8e35-2bd7c446d102@gmail.com>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4yLjE1LVJlbGVhc2UuMjYwMjI1MDAxKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAxMjAwIEFyY2hpdGVjdHVyZS94ODZfNjQgd2ViRHQvUEM=uL
In-Reply-To: <bf9f7c6f-8759-4f4f-8e35-2bd7c446d102@gmail.com>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275873-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,nebula-matrix.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nebula-matrix.com:replyto,nebula-matrix.com:mid];
	HAS_REPLYTO(0.00)[Illusion.Wang@nebula-matrix.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Illusion.Wang@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org,intel.com];
	NEURAL_HAM(-0.00)[-0.726];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 507473AA652
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pj4gKwo+PiArIGNoYW5fbWd0ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpjaGFuX21ndCks
IEdGUF9LRVJORUwpOwo+PiArIGlmICghY2hhbl9tZ3QpCj4+ICvCoCByZXR1cm4gRVJSX1BUUigt
RU5PTUVNKTsKPj4gKwo+PiArIGNoYW5fbWd0LT5jb21tb24gPSBjb21tb247Cj4+ICsgY2hhbl9t
Z3QtPmh3X29wc190YmwgPSBod19vcHNfdGJsOwo+PiArCj4+ICsgbWFpbGJveCA9IGRldm1fa3ph
bGxvYyhkZXYsIHNpemVvZigqbWFpbGJveCksIEdGUF9LRVJORUwpOwo+PiArIGlmICghbWFpbGJv
eCkKPj4gK8KgIHJldHVybiBFUlJfUFRSKC1FTk9NRU0pOwoKPkhlcmUsIGlmIG1haWxib3ggYWxs
b2NhdGlvbiBmYWlscywgd2UgcmV0dXJuIHdpdGhvdXQgZnJlZWluZyBjaGFuX21ndCAKPnJlc3Vs
dGluZyBpbiBhIGxlYWsuCgo+PiArIG1haWxib3gtPmNoYW5fdHlwZSA9IE5CTF9DSEFOX1RZUEVf
TUFJTEJPWDsKPj4gKyBjaGFuX21ndC0+Y2hhbl9pbmZvW05CTF9DSEFOX1RZUEVfTUFJTEJPWF0g
PSBtYWlsYm94Owo+PiArCj4+ICsgcmV0dXJuIGNoYW5fbWd0Owo+PiArfQoKClRoYW5rcyBmb3Ig
eW91ciBmZWVkYmFjay4KSSd2ZSBjYXJlZnVsbHkgY29uc2lkZXJlZCB5b3VyIGNvbW1lbnQgYWJv
dXQgdGhlIHBvdGVudGlhbAptZW1vcnkgbGVhayBpbiB0aGUgcHJvdmlkZWQgY29kZSBzbmlwcGV0
LApidXQgSSB1c2UgZGV2bV9remFsbG9jKCksIHRoZSBhcmVhIGlzIGd1YXJhbnRlZWQgdG8gYmUK
ZnJlZWQgd2hldGhlciBpbml0aWFsaXphdGlvbiBmYWlscyBoYWxmLXdheSBvciB0aGUgZGV2aWNl
CmdldHMgZGV0YWNoZWQuCnBzOkRvY3VtZW50YXRpb25cZHJpdmVyLWFwaVxkcml2ZXItbW9kZWxc
ZGV2cmVzLnRzdApteV9pbml0X29uZSgpCiAgewoJc3RydWN0IG15ZGV2ICpkOwoKCWQgPSBkZXZt
X2t6YWxsb2MoZGV2LCBzaXplb2YoKmQpLCBHRlBfS0VSTkVMKTsKCWlmICghZCkKCQlyZXR1cm4g
LUVOT01FTTsKCglkLT5yaW5nID0gZG1hbV9hbGxvY19jb2hlcmVudCguLi4pOwoJaWYgKCFkLT5y
aW5nKQoJCXJldHVybiAtRU5PTUVNOwoKCWlmIChjaGVjayBzb21ldGhpbmcpCgkJcmV0dXJuIC1F
SU5WQUw7CgkuLi4KfQotLWlsbHVzaW9uLndhbmcK

