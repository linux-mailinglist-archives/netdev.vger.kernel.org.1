Return-Path: <netdev+bounces-254080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI0ZMMx4eWkSxQEAu9opvQ
	(envelope-from <netdev+bounces-254080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:47:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5DC9C66C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED36E300BD96
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226F52BE7BA;
	Wed, 28 Jan 2026 02:47:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7DF279917;
	Wed, 28 Jan 2026 02:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769568426; cv=none; b=Sv4tP42kUrL3wlgMJmUrZT2Rz83Mc3dlGLEFqNW++bMCuPt63SbwpBWNp1H5vUG4csGli4xvd+k9EGAG/mgF6eqEPaWK4PtiuGq57ELXKqgOjjes3V9H/7JqGGAOTkwkUnAIJcjNjKR60rjzcXauoKIdjvs7heF/rx/oId5BJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769568426; c=relaxed/simple;
	bh=P5BHOGekwZzlYDtEGgu0HdjH4GgUy82l02WJdkLG3Ik=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=kfwfdbDWQGc/M2/Ibj1LyEXl760YsDRTjUPXxlox0VfQBihzcEmrIazDW5fAMd2i1ytGltFYh3bVnKMSMKVaVMCBkQCusLBDguONS4eackP4p+a+1q+kkw5O6oQcsa+DDwlpqg2xxEk7v8T3X5JvCgIZWZNw/v0tl35B1FiPB1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07953744|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00691617-0.00073375-0.99235;FP=7305816914113108162|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=21;RT=21;SR=0;TI=W4_0.2.3_211683ED_1769567779326_o7001c1223;
Received: from WS-web (illusion.wang@nebula-matrix.com[W4_0.2.3_211683ED_1769567779326_o7001c1223] cluster:ay29) at Wed, 28 Jan 2026 10:46:51 +0800
Date: Wed, 28 Jan 2026 10:46:51 +0800
From: "Illusion Wang" <illusion.wang@nebula-matrix.com>
To: "Jakub Kicinski" <kuba@kernel.org>,
  "Simon Horman" <horms@kernel.org>
Cc: "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "Sam" <sam.chen@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>,
  "andrew+netdev" <andrew+netdev@lunn.ch>,
  "corbet" <corbet@lwn.net>,
  "linux-doc" <linux-doc@vger.kernel.org>,
  "lorenzo" <lorenzo@kernel.org>,
  "pabeni" <pabeni@redhat.com>,
  "vadim.fedorenko" <vadim.fedorenko@linux.dev>,
  "lukas.bulwahn" <lukas.bulwahn@redhat.com>,
  "hawk" <hawk@kernel.org>,
  "ast" <ast@kernel.org>,
  "bpf" <bpf@vger.kernel.org>,
  "sdf" <sdf@fomichev.me>,
  "daniel" <daniel@iogearbox.net>,
  "john.fastabend" <john.fastabend@gmail.com>,
  "edumazet" <edumazet@google.com>,
  "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Illusion Wang" <illusion.wang@nebula-matrix.com>
Message-ID: <17b1ca50-a9e4-499c-b84b-b8223c313491.illusion.wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHYzIG5ldC1uZXh0IDAwLzE1XSBuYmwgZHJpdmVyIGZvciBOZWJ1?=
  =?UTF-8?B?bGFtYXRyaXggTklDcw==?=
X-Mailer: [Alimail-Mailagent revision 24734][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>	<aXj-uam1HodC0851@horms.kernel.org>,<20260127105304.21279cc2@kernel.org>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4yLjAtUmVsZWFzZS4yNTEyMjIwMTkpIE1vam8vMS4wLjAgTmF0aXZlIEFwcFR5cGUocmVsZWFzZSkgQ2hhbm5lbC8yMDEyMDAgQXJjaGl0ZWN0dXJlL3g4Nl82NCB3ZWJEdC9QQw==uL
In-Reply-To: <20260127105304.21279cc2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[nebula-matrix.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254080-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,fomichev.me:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[illusion.wang@nebula-matrix.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 6C5DC9C66C
X-Rspamd-Action: no action

ClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjawoKcGF0Y2gzIHByaW1hcmlseSBpbmNsdWRlcyBj
b2RlIHRoYXQgZG9lcyBub3QgcmVxdWlyZSBleHRlbnNpdmUgcmV2aWV3LApzdWNoIGFzIHRoZSBt
ZXNzYWdlIGNvZGVzIGFuZCBtZXNzYWdlIGJvZHkgc3RydWN0dXJlcyBkZWZpbmVkIGluCm5ibF9k
ZWZfY2hhbm5lbC5oLiBUaGVzZSBjb21wb25lbnRzIGFyZSBnZW5lcmFsbHkgc3RhYmxlIGFuZAp1
c2VkIGZvciBQRi9WRiBjb21tdW5pY2F0aW9uLCB3aGljaCBpcyB3aHkgdGhleSB3ZXJlIGluaXRp
YWxseQppbmNsdWRlZCBpbiBQYXRjaCAzLiBIb3dldmVyLCBiYXNlZCBvbiByZXZpZXcgZmVlZGJh
Y2ssIEkgd2lsbApleHRyYWN0IHRoZXNlIG1hbnVhbGx5IHdyaXR0ZW4gY29tbXVuaWNhdGlvbiBw
cm90b2NvbCBkZWZpbml0aW9ucy4KCkFkZGl0aW9uYWxseSwgSSB3aWxsIG1ha2UgYW5vdGhlciBy
b3VuZCBvZiBjb21wcmVoZW5zaXZlIGNvZGUKcmVkdWN0aW9uIHRvIG1lZXQgdGhlIHN1Ym1pc3Np
b24gcmVxdWlyZW1lbnRzIGFzIG11Y2ggYXMgcG9zc2libGUuCgoKLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCuWPkeS7tuS6
uu+8mkpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+CuWPkemAgeaXtumXtO+8mjIwMjbl
ubQx5pyIMjjml6Uo5ZGo5LiJKSAwMjo1MwrmlLbku7bkurrvvJpTaW1vbiBIb3JtYW48aG9ybXNA
a2VybmVsLm9yZz47IElsbHVzaW9uIFdhbmc8aWxsdXNpb24ud2FuZ0BuZWJ1bGEtbWF0cml4LmNv
bT4K5oqE44CA6YCB77yaRGltb248ZGltb24uemhhb0BuZWJ1bGEtbWF0cml4LmNvbT47IEFsdmlu
PGFsdmluLndhbmdAbmVidWxhLW1hdHJpeC5jb20+OyBTYW08c2FtLmNoZW5AbmVidWxhLW1hdHJp
eC5jb20+OyBuZXRkZXY8bmV0ZGV2QHZnZXIua2VybmVsLm9yZz47ICJhbmRyZXcrbmV0ZGV2Ijxh
bmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBjb3JiZXQ8Y29yYmV0QGx3bi5uZXQ+OyAibGludXgtZG9j
IjxsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnPjsgbG9yZW56bzxsb3JlbnpvQGtlcm5lbC5vcmc+
OyBwYWJlbmk8cGFiZW5pQHJlZGhhdC5jb20+OyAidmFkaW0uZmVkb3JlbmtvIjx2YWRpbS5mZWRv
cmVua29AbGludXguZGV2PjsgImx1a2FzLmJ1bHdhaG4iPGx1a2FzLmJ1bHdhaG5AcmVkaGF0LmNv
bT47IGhhd2s8aGF3a0BrZXJuZWwub3JnPjsgYXN0PGFzdEBrZXJuZWwub3JnPjsgYnBmPGJwZkB2
Z2VyLmtlcm5lbC5vcmc+OyBzZGY8c2RmQGZvbWljaGV2Lm1lPjsgZGFuaWVsPGRhbmllbEBpb2dl
YXJib3gubmV0PjsgImpvaG4uZmFzdGFiZW5kIjxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+OyBl
ZHVtYXpldDxlZHVtYXpldEBnb29nbGUuY29tPjsgb3BlbiBsaXN0PGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc+CuS4u+OAgOmimO+8mlJlOiBbUEFUQ0ggdjMgbmV0LW5leHQgMDAvMTVdIG5i
bCBkcml2ZXIgZm9yIE5lYnVsYW1hdHJpeCBOSUNzCgoKT24gVHVlLCAyNyBKYW4gMjAyNiAxODow
Njo0OSArMDAwMCBTaW1vbiBIb3JtYW4gd3JvdGU6Cj4gQXMgcGVyIEpha3ViJ3MgYWR2aWNlIGlu
IGhpcyByZXZpZXcgb2YgdjEgWypdLAo+IFBsZWFzZSB0cnkgdG8gY3JlYXRlIGEgbWluaW1hbCBk
cml2ZXIgaW4gdGhlIG9yZGVyIG9mIH41a0xvQy4KClBlcmhhcHMgb3RoZXIgbWFpbnRhaW5lcnMg
d2lsbCBkaXNhZ3JlZSwgYnV0IGZvciBlYXNlIG9mIHJldmlldwphbmQgdG8gYXZvaWQgdGhlIGh1
Z2UgcmVwb3N0cyBwZXJoYXBzIHdlIHNob3VsZCBjb25zaWRlciBtZXJnaW5nCnNvbWV0aGluZyBs
aWtlIHBhdGNoZXMgMSBhbmQgMyogZmlyc3QsIGFzIHRoZSBpbml0aWFsIHNlcmllcy4KQW5kIHRo
ZW4geW91IGNhbiBidWlsZCB1cCB0aGUgZHJpdmVyIGZyb20gdGhlcmUgaW4gcmVhc29uYWJsZSwK
NWtMb0MtYXQtYS10aW1lIHNlcmllcz8KCiAqIHBhdGNoIDMgY3VycmVudGx5IGluY2x1ZGVzIHRo
aW5ncyB3aGljaCBkbyBub3Qgc2VlbSBtYWNoaW5lCiDCoCBnZW5lcmF0ZWQgLyBsaWtlIHJlZ2lz
dGVyIGRlc2NyaXB0b3JzIGxpa2Ugc3RydWN0cyBhZGRlZCB0bwogwqAgbmJsX2RlZl9jaGFubmVs
LmggYW5kIG5ibF9pbmNsdWRlLmgK

