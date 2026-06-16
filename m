Return-Path: <netdev+bounces-299756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /DvbByPxMGpbZAUAu9opvQ
	(envelope-from <netdev+bounces-299756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:45:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 165A668C9F2
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:45:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299756-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299756-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FDE730072A9
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774A93FBB69;
	Tue, 16 Jun 2026 06:45:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BDD3F787C;
	Tue, 16 Jun 2026 06:45:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592334; cv=none; b=LRrFf5X53g1JSoDpO60iKFDxT96j/XmSqhSMiUJeIJS+UOSjN1YknScqTon/mZd81rlUOYn2UTbiVH380o5knSZiFFW60x2yn1HJHfjNxc0Snu7HYwVMGBqAJyDGzB7LJ1R3KLL5AI15yi+xFYH2dvCowb03KvlGJ2Vp0vAXSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592334; c=relaxed/simple;
	bh=7TS6lNgSK8P8+t23OkkxEFYws7AmwSLaSkRsvnyhy6o=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=f85pXXgtV22h4f4Kqf7ZG/i4rLD76OxU48EgPEiv/IZAprURZUbPfgWXzWSx5cvR3Btlltk5/LSUrugH1AGYlh5r6kaEDhva2ToF9xu/ZoOkiU2A07DJsV3fqOhxICcFxMLcbhX96Y82VaPn1yXMkMp3w80JGBERkaHs1Sq0cME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.50
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.8921427|0.5658601;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_alarm|0.16782-0.0169219-0.815259;FP=9331421445132668642|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=18;RT=18;SR=0;TI=W4_0.2.3_21449A8C_1781592290336_o7001c1357;
Received: from WS-web (Illusion.Wang@nebula-matrix.com[W4_0.2.3_21449A8C_1781592290336_o7001c1357] cluster:ay29) at Tue, 16 Jun 2026 14:45:11 +0800
Date: Tue, 16 Jun 2026 14:45:11 +0800
From: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
To: "Illusion Wang" <illusion.wang@nebula-matrix.com>,
  "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "Sam" <sam.chen@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>
Cc: "andrew+netdev" <andrew+netdev@lunn.ch>,
  "corbet" <corbet@lwn.net>,
  "kuba" <kuba@kernel.org>,
  "horms" <horms@kernel.org>,
  "linux-doc" <linux-doc@vger.kernel.org>,
  "pabeni" <pabeni@redhat.com>,
  "vadim.fedorenko" <vadim.fedorenko@linux.dev>,
  "lukas.bulwahn" <lukas.bulwahn@redhat.com>,
  "edumazet" <edumazet@google.com>,
  "enelsonmoore" <enelsonmoore@gmail.com>,
  "skhan" <skhan@linuxfoundation.org>,
  "hkallweit1" <hkallweit1@gmail.com>,
  "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
Message-ID: <1695f9bd-3fd6-400f-8491-abd82a8f4e3d.Illusion.Wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHYxOCBuZXQtbmV4dCAwNy8xMV0gbmV0L25lYnVsYS1tYXRyaXg6?=
  =?UTF-8?B?IGFkZCBpbnRyIHJlc291cmNlIGltcGxlbWVudGF0aW9u?=
X-Mailer: [Alimail-Mailagent revision 8813][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260611044916.2383-1-illusion.wang@nebula-matrix.com>,<20260611044916.2383-8-illusion.wang@nebula-matrix.com>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4zLjIwLVJlbGVhc2UuMjYwNTE0MDAyKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAxMjAwIEFyY2hpdGVjdHVyZS94ODZfNjQgd2ViRHQvUEM=uL
In-Reply-To: <20260611044916.2383-8-illusion.wang@nebula-matrix.com>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[nebula-matrix.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER(0.00)[Illusion.Wang@nebula-matrix.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:illusion.wang@nebula-matrix.com,m:dimon.zhao@nebula-matrix.com,m:alvin.wang@nebula-matrix.com,m:sam.chen@nebula-matrix.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-doc@vger.kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:lukas.bulwahn@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299756-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,illusion.wang:url];
	HAS_REPLYTO(0.00)[Illusion.Wang@nebula-matrix.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Illusion.Wang@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 165A668C9F2

PmNvbW1pdCA3YTMyY2E4MzM1YzkwNDFlYzAzYjgwZDMwNzE2YzQ3NGU4MTcyM2FkCj5BdXRob3I6
IGlsbHVzaW9uLndhbmcgPGlsbHVzaW9uLndhbmdAbmVidWxhLW1hdHJpeC5jb20+Cj5uZXQvbmVi
dWxhLW1hdHJpeDogYWRkIGludHIgcmVzb3VyY2UgaW1wbGVtZW50YXRpb24KPlRoaXMgcGF0Y2gg
YWRkcyB0aGUgbmJsX2ludGVycnVwdCBtb2R1bGUgZm9yIG1hbmFnZW1lbnQgb2YgZHJpdmVyLXBy
aXZhdGUKPk1TSS1YIGluZGljZXMsIHBsdXMgaHdfb3BzIGNhbGxiYWNrcyB0byBwcm9ncmFtIHRo
ZSBmdW5jdGlvbiBNU0ktWCBtYXBwaW5nCj5yZWdpc3RlcnMsIGNvbmZpZ3VyZSBNU0ktWCBpbmZv
LCBhbmQgZW5hYmxlIG1haWxib3ggaW50ZXJydXB0cy4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L25lYnVsYS1tYXRyaXgvbmJsL25ibF9ody9uYmxfaW50ZXJydXB0LmMgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9uZWJ1bGEtbWF0cml4L25ibC9uYmxfaHcvbmJsX2ludGVycnVw
dC5jCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+IGluZGV4IDAwMDAwMDAwMDAwMDAuLjZkNjky
NGU3ZDlhODIKPj4gLS0tIC9kZXYvbnVsbAo+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9u
ZWJ1bGEtbWF0cml4L25ibC9uYmxfaHcvbmJsX2ludGVycnVwdC5jCj5bIC4uLiBdCj4+ICtpbnQg
bmJsX3Jlc19pbnRyX2Rlc3Ryb3lfbXNpeF9tYXAoc3RydWN0IG5ibF9yZXNvdXJjZV9tZ3QgKnJl
c19tZ3QsCj4+ICsJCQkJICB1MTYgZnVuY19pZCkKPj4gK3sKPlsgLi4uIF0KPj4gKwkvKiB1c2Ug
Y3RybCBkZXYgYmRmICovCj4+ICsJaHdfb3BzLT5jb25maWd1cmVfbXNpeF9tYXAocmVzX21ndC0+
aHdfb3BzX3RibC0+cHJpdiwgZnVuY19pZCwgZmFsc2UsIDAsCj4+ICsJCQkJICAgMCwgMCwgMCk7
Cj4+ICsKPj4gKwlpbnRyX21ndC0+ZnVuY19pbnRyX3Jlc1tmdW5jX2lkXS5pbnRlcnJ1cHRzID0g
TlVMTDsKPj4gKwlpbnRyX21ndC0+ZnVuY19pbnRyX3Jlc1tmdW5jX2lkXS5udW1faW50ZXJydXB0
cyA9IDA7Cj4+ICsJaW50cl9tZ3QtPmZ1bmNfaW50cl9yZXNbZnVuY19pZF0ubnVtX25ldF9pbnRl
cnJ1cHRzID0gMDsKPj4gKwlod19vcHMtPmZsdXNoX3dyaXRlKHJlc19tZ3QtPmh3X29wc190Ymwt
PnByaXYpOwo+PiArCj4+ICsJcmV0dXJuIDA7Cj4+ICt9Cj5Eb2VzIHRoaXMgY29kZSBsZWFrIHRo
ZSBkZXZpY2UtbWFuYWdlZCBtZW1vcnk/IG5ibF9yZXNfaW50cl9jb25maWd1cmVfbXNpeF9tYXAo
KQo+YWxsb2NhdGVzIGludGVycnVwdHMgdmlhIGRldm1fa2NhbGxvYygpIGFuZCBtc2l4X21hcF90
YWJsZS0+YmFzZV9hZGRyIHZpYQo+ZG1hbV9hbGxvY19jb2hlcmVudCgpLiBTZXR0aW5nIHRoZSBw
b2ludGVyIHRvIE5VTEwgaGVyZSB3aXRob3V0IGNhbGxpbmcKPmRldm1fa2ZyZWUoKSBhbmQgZG1h
bV9mcmVlX2NvaGVyZW50KCkgbWVhbnMgdGhlIG1lbW9yeSB3b24ndCBiZSBmcmVlZCB1bnRpbAo+
dGhlIGRldmljZSBpcyBkZXRhY2hlZC4gSWYgdGhlIE1TSS1YIG1hcCBpcyByZXBlYXRlZGx5IHJl
Y29uZmlndXJlZCwgY291bGQKPnRoaXMgZXhoYXVzdCBtZW1vcnk/Cj5bIC4uLiBdCj4+ICtpbnQg
bmJsX3Jlc19pbnRyX2NvbmZpZ3VyZV9tc2l4X21hcChzdHJ1Y3QgbmJsX3Jlc291cmNlX21ndCAq
cmVzX21ndCwKPj4gKwkJCQkgICAgdTE2IGZ1bmNfaWQsIHUxNiBudW1fbmV0X21zaXgsCj4+ICsJ
CQkJICAgIHUxNiBudW1fb3RoZXJzX21zaXgsCj4+ICsJCQkJICAgIGJvb2wgbmV0X21zaXhfbWFz
a19lbikKPj4gK3sKWyAuLi4gXQo+PiArCW1zaXhfbWFwX3RhYmxlID0gJmludHJfbWd0LT5mdW5j
X2ludHJfcmVzW2Z1bmNfaWRdLm1zaXhfbWFwX3RhYmxlOwo+PiArCVdBUk5fT04obXNpeF9tYXBf
dGFibGUtPmJhc2VfYWRkcik7Cj4+ICsJbXNpeF9tYXBfdGFibGUtPnNpemUgPQo+PiArCQlzaXpl
b2Yoc3RydWN0IG5ibF9tc2l4X21hcCkgKiBOQkxfTVNJWF9NQVBfVEFCTEVfTUFYX0VOVFJJRVM7
Cj4+ICsJLyogSFcgaW5kZXhlcyB0aGUgTVNJLVggbWFwIHRhYmxlIHdpdGggYSBmaXhlZCBzdHJp
ZGUgb2YgMTAyNCBlbnRyaWVzLAo+PiArCSAqIHNvIHdlIG11c3QgYWxsb2NhdGUgdGhlIGZ1bGwg
dGFibGUgZXZlbiBpZiBmZXdlciB2ZWN0b3JzIGFyZSB1c2VkLgo+PiArCSAqLwo+PiArCW1zaXhf
bWFwX3RhYmxlLT5iYXNlX2FkZHIgPSBkbWFtX2FsbG9jX2NvaGVyZW50KGRldiwKPj4gKwkJCQkJ
CQltc2l4X21hcF90YWJsZS0+c2l6ZSwKPj4gKwkJCQkJCQkmbXNpeF9tYXBfdGFibGUtPmRtYSwK
Pj4gKwkJCQkJCQlHRlBfS0VSTkVMKTsKPj4gKwlpZiAoIW1zaXhfbWFwX3RhYmxlLT5iYXNlX2Fk
ZHIpIHsKPj4gKwkJZGV2X2VycihkZXYsICJBbGxvY2F0ZSBETUEgbWVtb3J5IGZvciBmdW5jdGlv
biBtc2l4IG1hcCB0YWJsZSBmYWlsZWRcbiIpOwo+PiArCQltc2l4X21hcF90YWJsZS0+c2l6ZSA9
IDA7Cj4+ICsJCXJldHVybiAtRU5PTUVNOwo+PiArCX0KPj4gKwo+PiArCWludGVycnVwdHMgPSBk
ZXZtX2tjYWxsb2MoZGV2LCByZXF1ZXN0ZWQsIHNpemVvZihpbnRlcnJ1cHRzWzBdKSwKPj4gKwkJ
CQkgIEdGUF9LRVJORUwpOwo+PiArCWlmICghaW50ZXJydXB0cykgewo+PiArCQlyZXQgPSAtRU5P
TUVNOwo+PiArCQlnb3RvIGFsbG9jX2ludGVycnVwdHNfZXJyOwo+PiArCX0KWyAuLi4gXQo+PiAr
Z2V0X2ludGVycnVwdF9lcnI6Cj4+ICsJd2hpbGUgKGktLSkgewo+PiArCQlpbnRyX2luZGV4ID0g
aW50ZXJydXB0c1tpXTsKPj4gKwkJaWYgKGludHJfaW5kZXggPj0gTkJMX05FVF9JTlRSX0JBU0Up
Cj4+ICsJCQljbGVhcl9iaXQoaW50cl9pbmRleCAtIE5CTF9ORVRfSU5UUl9CQVNFLAo+PiArCQkJ
CSAgaW50cl9tZ3QtPmludGVycnVwdF9uZXRfYml0bWFwKTsKPj4gKwkJZWxzZQo+PiArCQkJY2xl
YXJfYml0KGludHJfaW5kZXgsCj4+ICsJCQkJICBpbnRyX21ndC0+aW50ZXJydXB0X290aGVyc19i
aXRtYXApOwo+PiArCX0KPj4gKwo+PiArCWludHJfbWd0LT5mdW5jX2ludHJfcmVzW2Z1bmNfaWRd
Lm51bV9pbnRlcnJ1cHRzID0gMDsKPj4gKwlpbnRyX21ndC0+ZnVuY19pbnRyX3Jlc1tmdW5jX2lk
XS5pbnRlcnJ1cHRzID0gTlVMTDsKPj4gKwlpbnRyX21ndC0+ZnVuY19pbnRyX3Jlc1tmdW5jX2lk
XS5udW1fbmV0X2ludGVycnVwdHMgPSAwOwo+PiArYWxsb2NfaW50ZXJydXB0c19lcnI6Cj4+ICsK
Pj4gKwlyZXR1cm4gcmV0Owo+PiArfQo+SWYgYW4gZXJyb3Igb2NjdXJzIGFmdGVyIGFsbG9jYXRp
bmcgdGhlIG1lbW9yeSAoZS5nLiwganVtcGluZyB0bwo+Z2V0X2ludGVycnVwdF9lcnIgb3IgYWxs
b2NfaW50ZXJydXB0c19lcnIpLCBkb2VzIHRoaXMgZXJyb3IgcGF0aCBhbHNvIGxlYWsKPnRoZSBk
ZXZtX2tjYWxsb2MoKSBhbmQgZG1hbV9hbGxvY19jb2hlcmVudCgpIG1lbW9yeSBieSBzaW1wbHkg
cmV0dXJuaW5nCj53aXRob3V0IGZyZWVpbmcgaXQ/CgpCb3RoIHVzZSBkZXZtLW1hbmFnZWQgcmVz
b3VyY2VzLCBzbyBJIHRoaW5rIG5vIG1hbnVhbCBmcmVlIGlzIG5lZWRlZC4KCmRlc3Ryb3lfbXNp
eF9tYXA6IFRoZSBpbnRlcnJ1cHRzIGFycmF5IGlzIGFsbG9jYXRlZCB3aXRoIGRldm1fa2NhbGxv
YygpLCBhbmQKdGhlIE1TSS1YIG1hcCB0YWJsZSBpcyBhbGxvY2F0ZWQgd2l0aCBkbWFtX2FsbG9j
X2NvaGVyZW50KCkgb24gdGhlIGRldmljZSdzCkRNQSBwb29sLiBCb3RoIGFyZSB0aWVkIHRvIHRo
ZSBkZXZpY2UgbGlmZWN5Y2xlIOKAlCB0aGV5IGFyZSBhdXRvbWF0aWNhbGx5CnJlY2xhaW1lZCBv
biBkcml2ZXIgZGV0YWNoLiBTZXR0aW5nIHRoZSBwb2ludGVyIHRvIE5VTEwgaXMgZGVmZW5zaXZl
Owp0aGUgZGV2bSBmcmFtZXdvcmsgaGFuZGxlcyB0aGUgYWN0dWFsIGZyZWUuCmNvbmZpZ3VyZV9t
c2l4X21hcCBlcnJvciBwYXRoOiBTYW1lIHJlYXNvbmluZy4gaW50ZXJydXB0cyBpcyBkZXZtX2tj
YWxsb2MoKSwKYW5kIHRoZSBETUEgdGFibGUgaXMgZGV2aWNlLW1hbmFnZWQuIE9uIGFueSBlcnJv
ciwgdGhlIGZ1bmN0aW9uIHJldHVybnMgdG8KdGhlIGNhbGxlciwgd2hpY2ggd2lsbCBldmVudHVh
bGx5IHRyaWdnZXIgZHJpdmVyIHJlbW92ZSBhbmQgZGV2bSBjbGVhbnVwLgpUaGVyZSBpcyBubyBy
ZXBlYXRlZC1yZWNvbmZpZyBsb29wIGluIHRoZSBjdXJyZW50IGRlc2lnbiDigJQgY29uZmlndXJl
X21zaXhfbWFwCmlzIG9ubHkgY2FsbGVkIGR1cmluZyBwcm9iZS9yZWluaXQsIG5vdCBpbiBhIGhv
dCBwYXRoIOKAlCBzbyBleGhhdXN0aW9uIGlzIG5vdAphIHByYWN0aWNhbCBjb25jZXJuLiBBZGRp
bmcgbWFudWFsIGZyZWUgY2FsbHMgd291bGQgZHVwbGljYXRlIHdoYXQgZGV2bSBhbHJlYWR5CmRv
ZXMgYW5kIHJpc2sgZG91YmxlLWZyZWUu

