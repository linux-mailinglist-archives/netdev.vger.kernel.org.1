Return-Path: <netdev+bounces-257499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EVOOcu0hWmbFQQAu9opvQ
	(envelope-from <netdev+bounces-257499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:30:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48254FC0B4
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89B1A30075C0
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 09:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768A035C1A5;
	Fri,  6 Feb 2026 09:26:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-23.us.a.mail.aliyun.com (out198-23.us.a.mail.aliyun.com [47.90.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B94A30CD87;
	Fri,  6 Feb 2026 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370018; cv=none; b=IgyA9Fbl0wDXNrqTLHC5DfNdmW9saIwyt6okemA5jvJDMwAfKIeIiG2WnS54J6YhiIpCrDoJurE0HK5dUqy3cGRNVt/G0ukDNf0u5SUFy6e/Y3cEWWRtUwH2GUx4sVV4BIsRgqDPk2Zrm62QrzLqO8wgNGYtXtDBQPtPADq2TMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370018; c=relaxed/simple;
	bh=bzTXrU9PhqXto/ujJXWTB+KV/DqfHECrd3UQSYaAg4k=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=Rz45Bcisyqdd+goMTdgR4uvMdScym97jrUnMP02msVr507tYKhyO0iuIM9dliGckgo2/1AbrRCoM5SBdU/vTurWQ8YLLs1410VshDfkbJQ6azKyAmM5+ja0MT7vqf1kul2Wp6ciwtetoYOHwn8qr9iU6pcgUT8wGza/+97OJMMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07386666|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.449088-0.00324481-0.547667;FP=16291042166976419330|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021130;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=16;RT=16;SR=0;TI=W4_0.2.3_212858CE_1770368875700_o7001c697;
Received: from WS-web (illusion.wang@nebula-matrix.com[W4_0.2.3_212858CE_1770368875700_o7001c697] cluster:ay29) at Fri, 06 Feb 2026 17:26:35 +0800
Date: Fri, 06 Feb 2026 17:26:35 +0800
From: "Illusion Wang" <illusion.wang@nebula-matrix.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "Sam" <sam.chen@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>,
  "andrew+netdev" <andrew+netdev@lunn.ch>,
  "corbet" <corbet@lwn.net>,
  "kuba" <kuba@kernel.org>,
  "linux-doc" <linux-doc@vger.kernel.org>,
  "lorenzo" <lorenzo@kernel.org>,
  "pabeni" <pabeni@redhat.com>,
  "horms" <horms@kernel.org>,
  "vadim.fedorenko" <vadim.fedorenko@linux.dev>,
  "lukas.bulwahn" <lukas.bulwahn@redhat.com>,
  "edumazet" <edumazet@google.com>,
  "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Illusion Wang" <illusion.wang@nebula-matrix.com>
Message-ID: <8641f978-76d5-464f-a312-414bd913c918.illusion.wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHY0IG5ldC1uZXh0IDAyLzExXSBuZXQvbmVidWxhLW1hdHJpeDog?=
  =?UTF-8?B?YWRkIG91ciBkcml2ZXIgYXJjaGl0ZWN0dXJl?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260206021608.85381-1-illusion.wang@nebula-matrix.com> <20260206021608.85381-3-illusion.wang@nebula-matrix.com>,<769fbfa8-a881-403f-bc65-56c60c389185@lunn.ch>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4yLjAtUmVsZWFzZS4yNTEyMjIwMTkpIE1vam8vMS4wLjAgTmF0aXZlIEFwcFR5cGUocmVsZWFzZSkgQ2hhbm5lbC8yMDEyMDAgQXJjaGl0ZWN0dXJlL3g4Nl82NCB3ZWJEdC9QQw==uL
In-Reply-To: <769fbfa8-a881-403f-bc65-56c60c389185@lunn.ch>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebula-matrix.com:replyto,nebula-matrix.com:email,nebula-matrix.com:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lwn.net:email];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[nebula-matrix.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257499-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[illusion.wang@nebula-matrix.com];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 48254FC0B4
X-Rspamd-Action: no action

TGFzdCB0aW1lIHNhbSBoYWQgYSBxdWVzdGlvbgoiClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFj
ay4gWW91IG1pZ2h0IGhhdmUgbWlzdW5kZXJzdG9vZCBtZS4KT3VyIGRpZmZpY3VsdGllcyBsaWUg
aW4gdGhlIGZvbGxvd2luZzoKMS4gQXNzdW1pbmcgb25seSB0aGUgbWFpbmxpbmUgdmVyc2lvbiBj
aGFuZ2VzIHRoZSBuYW1lIChBc3N1bWUgbmFtZSAibmJsIiksCiAgIGFuZCBvdXIgcmVndWxhcmx5
IHJlbGVhc2VkIGRyaXZlciBkb2Vzbid0IGNoYW5nZSBpdHMgbmFtZSwgdGhlbiB3aGVuCiAgIGN1
c3RvbWVycyB1cGdyYWRlIHRvIGEgbmV3IGtlcm5lbCAoY29udGFpbmluZyB0aGUgIm5ibCIgZHJp
dmVyKSwKICAgYW5kIHRoZW4gd2FudCB0byB1cGRhdGUgb3VyIHJlZ3VsYXJseSByZWxlYXNlZCBk
cml2ZXIgKG5hbWVkICJuYmxfY29yZSIpLAogICB0aGUgbW9kdWxlIChrbykgY29uZmxpY3Qgd2ls
bCBvY2N1ci4KMi4gSWYgYm90aCBvdXIgbWFpbmxpbmUgYW5kIHJlZ3VsYXJseSByZWxlYXNlZCBk
cml2ZXJzIGNoYW5nZSB0aGVpciBuYW1lcywKICAgdGhlbiBjdXN0b21lcnMgd2hvIGFyZSBhbHJl
YWR5IHVzaW5nIHRoZSAibmJsX2NvcmUiIGRyaXZlciB3aWxsIGFsc28KICAgZW5jb3VudGVyIGNv
bmZsaWN0IGlzc3VlcyB3aGVuIHVwZGF0aW5nIHRvIHRoZSBuZXcgZHJpdmVyICJuYmwiLgoKSXMg
aXQgcG9zc2libGUgdG8gZG8gdGhpczogb3VyIG5ldCBkcml2ZXIgaXMgYWxzbyBtb2RpZmllZCB0
byBiZSBhIGRyaXZlciBiYXNlZApvbiB0aGUgYXV4aWxpYXJ5IGJ1cywgd2hpbGUgdGhlIFBDSWUg
ZHJpdmVyIG9ubHkgaGFuZGxlcyBQQ0llLXJlbGF0ZWQgcHJvY2Vzc2luZywKYW5kIHRoZXNlIHR3
byBkcml2ZXJzIHNoYXJlIGEgc2luZ2xlIGtlcm5lbCBtb2R1bGUgKGtvKSwgbmFtZWx5ICJuYmxf
Y29yZSI/IgoKVGhlcmUncyBubyBjb25jbHVzaW9uIHRvIHRoaXMgaXNzdWUgeWV0LCBzbyBJIGhh
dmVuJ3QgbW9kaWZpZWQgdGhlICdjb3JlJyBwYXJ0cyBmb3Igbm93CihhcyBtZW50aW9uZWQgaW4g
cGF0Y2gwKQotLWlsbHVzaW9uLndhbmcKCgo+ICsjZGVmaW5lIE5CTF9BREFQX1RPX0hXX01HVChh
ZGFwdGVyKSAoKGFkYXB0ZXIpLT5jb3JlLmh3X21ndCkKPiArI2RlZmluZSBOQkxfQURBUF9UT19S
RVNfTUdUKGFkYXB0ZXIpICgoYWRhcHRlciktPmNvcmUucmVzX21ndCkKPiArI2RlZmluZSBOQkxf
QURBUF9UT19ESVNQX01HVChhZGFwdGVyKSAoKGFkYXB0ZXIpLT5jb3JlLmRpc3BfbWd0KQo+ICsj
ZGVmaW5lIE5CTF9BREFQX1RPX0RFVl9NR1QoYWRhcHRlcikgKChhZGFwdGVyKS0+Y29yZS5kZXZf
bWd0KQo+ICsjZGVmaW5lIE5CTF9BREFQX1RPX0NIQU5fTUdUKGFkYXB0ZXIpICgoYWRhcHRlcikt
PmNvcmUuY2hhbl9tZ3QpCgpJIHdvdWxkIHN1Z2dlc3QgcmVtb3ZpbmcgdGhlc2UuIEp1c3QgdXNl
IGFkYXB0ZXItPmNvcmUuY2hhbl9tZ3QKZGlyZWN0bHkgaW4gdGhlIGNvZGUuIFVzaW5nIG1hY3Jv
cyBub3JtYWxseSBtZWFucyB0aGVyZSBpcyBzb21lIG1hZ2ljCmludm9sdmVkLCBidXQgdGhpcyBp
cyBqdXN0IHBsYWluIHBvaW50ZXJzLCBub3RoaW5nIG1hZ2ljYWwuCgoKCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQrlj5Hk
u7bkurrvvJpBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+CuWPkemAgeaXtumXtO+8mjIwMjbl
ubQy5pyINuaXpSjlkajkupQpIDExOjM5CuaUtuS7tuS6uu+8mklsbHVzaW9uIFdhbmc8aWxsdXNp
b24ud2FuZ0BuZWJ1bGEtbWF0cml4LmNvbT4K5oqE44CA6YCB77yaRGltb248ZGltb24uemhhb0Bu
ZWJ1bGEtbWF0cml4LmNvbT47IEFsdmluPGFsdmluLndhbmdAbmVidWxhLW1hdHJpeC5jb20+OyBT
YW08c2FtLmNoZW5AbmVidWxhLW1hdHJpeC5jb20+OyBuZXRkZXY8bmV0ZGV2QHZnZXIua2VybmVs
Lm9yZz47ICJhbmRyZXcrbmV0ZGV2IjxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBjb3JiZXQ8Y29y
YmV0QGx3bi5uZXQ+OyBrdWJhPGt1YmFAa2VybmVsLm9yZz47ICJsaW51eC1kb2MiPGxpbnV4LWRv
Y0B2Z2VyLmtlcm5lbC5vcmc+OyBsb3JlbnpvPGxvcmVuem9Aa2VybmVsLm9yZz47IHBhYmVuaTxw
YWJlbmlAcmVkaGF0LmNvbT47IGhvcm1zPGhvcm1zQGtlcm5lbC5vcmc+OyAidmFkaW0uZmVkb3Jl
bmtvIjx2YWRpbS5mZWRvcmVua29AbGludXguZGV2PjsgImx1a2FzLmJ1bHdhaG4iPGx1a2FzLmJ1
bHdhaG5AcmVkaGF0LmNvbT47IGVkdW1hemV0PGVkdW1hemV0QGdvb2dsZS5jb20+OyBvcGVuIGxp
c3Q8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4K5Li744CA6aKY77yaUmU6IFtQQVRDSCB2
NCBuZXQtbmV4dCAwMi8xMV0gbmV0L25lYnVsYS1tYXRyaXg6IGFkZCBvdXIgZHJpdmVyIGFyY2hp
dGVjdHVyZQoKCj4gK3N0YXRpYyBpbnQKPiArbmJsX2NoYW5fc2V0dXBfY2hhbl9tZ3Qoc3RydWN0
IG5ibF9hZGFwdGVyICphZGFwdGVyLAo+ICsgwqAgc3RydWN0IG5ibF9pbml0X3BhcmFtICpwYXJh
bSwKPiArIMKgIHN0cnVjdCBuYmxfY2hhbm5lbF9tZ3RfbGVvbmlzICoqY2hhbl9tZ3RfbGVvbmlz
KQoKSXQgaXMgcHJldHR5IHVudXN1YWwgdG8gcGFzcyAqKiBwb2ludGVycy4gTW9yZSBub3JtYWwg
d291bGQgYmUgCgoKPiArc3RhdGljIHN0cnVjdCBuYmxfY2hhbm5lbF9tZ3RfbGVvbmlzICoKPiAr
bmJsX2NoYW5fc2V0dXBfY2hhbl9tZ3Qoc3RydWN0IG5ibF9hZGFwdGVyICphZGFwdGVyLAo+ICsg
wqAgc3RydWN0IG5ibF9pbml0X3BhcmFtICpwYXJhbSkKCj4gK3sKPiArIHN0cnVjdCBuYmxfaHdf
b3BzX3RibCAqaHdfb3BzX3RibCA9IGFkYXB0ZXItPmludGYuaHdfb3BzX3RibDsKPiArIHN0cnVj
dCBuYmxfY29tbW9uX2luZm8gKmNvbW1vbiA9ICZhZGFwdGVyLT5jb21tb247CiBzdHJ1Y3QgbmJs
X2NoYW5uZWxfbWd0X2xlb25pcyAqY2hhbl9tZ3RfbGVvbmlzOwo+ICsgc3RydWN0IGRldmljZSAq
ZGV2ID0gJmFkYXB0ZXItPnBkZXYtPmRldjsKPiArIHN0cnVjdCBuYmxfY2hhbl9pbmZvICptYWls
Ym94Owo+ICsKPiArIGNoYW5fbWd0X2xlb25pcyA9IGRldm1fa3phbGxvYyhkZXYsCj4gKyDCoCDC
oCBzaXplb2Yoc3RydWN0IG5ibF9jaGFubmVsX21ndF9sZW9uaXMpLAo+ICsgwqAgwqAgR0ZQX0tF
Uk5FTCk7Cj4gKyBpZiAoIWNoYW5fbWd0X2xlb25pcykKPiArwqAgZ290byBhbGxvY19jaGFubmVs
X21ndF9sZW9uaXNfZmFpbDsKPiArCj4gKyBjaGFuX21ndF9sZW9uaXMtPmNoYW5fbWd0LT5jb21t
b24gPSBjb21tb247Cj4gKyBjaGFuX21ndF9sZW9uaXMtPmNoYW5fbWd0Lmh3X29wc190YmwgPSBo
d19vcHNfdGJsOwo+ICsKPiArIG1haWxib3ggPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2Yoc3Ry
dWN0IG5ibF9jaGFuX2luZm8pLCBHRlBfS0VSTkVMKTsKPiArIGlmICghbWFpbGJveCkKPiArwqAg
Z290byBhbGxvY19tYWlsYm94X2ZhaWw7Cj4gKyBtYWlsYm94LT5jaGFuX3R5cGUgPSBOQkxfQ0hB
Tl9UWVBFX01BSUxCT1g7Cj4gKyBjaGFuX21ndF9sZW9uaXMtPmNoYW5fbWd0LT5jaGFuX2luZm9b
TkJMX0NIQU5fVFlQRV9NQUlMQk9YXSA9Cj4gK8KgIG1haWxib3g7Cj4gKwogcmV0dXJuIGNoYW5f
bWd0X2xlb25pczsKIAo+ICthbGxvY19tYWlsYm94X2ZhaWw6Cj4gK2FsbG9jX2NoYW5uZWxfbWd0
X2xlb25pc19mYWlsOgo+ICsgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7CgpUaGlzIGlzIHN0YXJ0
aW5nIHRvIGxvb2sgbGlrZSBMaW51eCBkcml2ZXIgY29kZSBub3cuIExvdHMgb2YgKCkgaGF2ZQpi
ZWVuIHJlbW92ZWQuIFlvdXIgYWltIGlzIHRvIG1ha2UgdGhlIGRyaXZlciBsb29rIGxpa2UgYWxs
IG90aGVyCmRyaXZlcnMgaW4gbGludXgsIGJ5IGNvcHlpbmcgdGhlIGNvbW1vbiBwYXR0ZXJucy4K
Ckkgd291bGQgcHJvYmFibHkgYWxzbyByZW1vdmUgdGhlIHR3byBsYWJlbHMsIGFuZCBqdXN0IGR1
ZSB0aGUgcmV0dXJuCkVSUl9QVFIoKSBpbmxpbmUuCgpQbGVhc2Ugc3BlbmQgc29tZSB0aW1lIHJl
YWRpbmcgb3RoZXIgZHJpdmVycy4gTGVhcm4gZnJvbSB0aGVtLCBhbmQKbWFrZSB5b3VyIGRyaXZl
ciBsb29rIGxpa2UgdGhlbS4KCj4gKyNkZWZpbmUgTkJMX0FEQVBfVE9fSFdfTUdUKGFkYXB0ZXIp
ICgoYWRhcHRlciktPmNvcmUuaHdfbWd0KQo+ICsjZGVmaW5lIE5CTF9BREFQX1RPX1JFU19NR1Qo
YWRhcHRlcikgKChhZGFwdGVyKS0+Y29yZS5yZXNfbWd0KQo+ICsjZGVmaW5lIE5CTF9BREFQX1RP
X0RJU1BfTUdUKGFkYXB0ZXIpICgoYWRhcHRlciktPmNvcmUuZGlzcF9tZ3QpCj4gKyNkZWZpbmUg
TkJMX0FEQVBfVE9fREVWX01HVChhZGFwdGVyKSAoKGFkYXB0ZXIpLT5jb3JlLmRldl9tZ3QpCj4g
KyNkZWZpbmUgTkJMX0FEQVBfVE9fQ0hBTl9NR1QoYWRhcHRlcikgKChhZGFwdGVyKS0+Y29yZS5j
aGFuX21ndCkKCkkgd291bGQgc3VnZ2VzdCByZW1vdmluZyB0aGVzZS4gSnVzdCB1c2UgYWRhcHRl
ci0+Y29yZS5jaGFuX21ndApkaXJlY3RseSBpbiB0aGUgY29kZS4gVXNpbmcgbWFjcm9zIG5vcm1h
bGx5IG1lYW5zIHRoZXJlIGlzIHNvbWUgbWFnaWMKaW52b2x2ZWQsIGJ1dCB0aGlzIGlzIGp1c3Qg
cGxhaW4gcG9pbnRlcnMsIG5vdGhpbmcgbWFnaWNhbC4KCj4gK2ludCBuYmxfaHdfaW5pdF9sZW9u
aXMoc3RydWN0IG5ibF9hZGFwdGVyICphZGFwdGVyLAo+ICsgwqAgwqAgwqAgwqAgc3RydWN0IG5i
bF9pbml0X3BhcmFtICpwYXJhbSkKPiArewo+ICsgc3RydWN0IG5ibF9od19vcHNfdGJsICoqaHdf
b3BzX3RibCA9ICZhZGFwdGVyLT5pbnRmLmh3X29wc190Ymw7Cj4gKyBzdHJ1Y3QgbmJsX2NvbW1v
bl9pbmZvICpjb21tb24gPSAmYWRhcHRlci0+Y29tbW9uOwo+ICsgc3RydWN0IG5ibF9od19tZ3Rf
bGVvbmlzICoqaHdfbWd0X2xlb25pczsKPiArIHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gY29tbW9u
LT5wZGV2Owo+ICsgc3RydWN0IG5ibF9od19tZ3QgKmh3X21ndDsKPiArIGludCBiYXJfbWFzazsK
PiArIGludCByZXQgPSAwOwo+ICsKPiArIGh3X21ndF9sZW9uaXMgPQo+ICvCoCAoc3RydWN0IG5i
bF9od19tZ3RfbGVvbmlzICoqKSZOQkxfQURBUF9UT19IV19NR1QoYWRhcHRlcik7CgpXaHkgdGhl
IGNhc3Q/IENhc3QgbGlrZSB0aGlzIHN1Z2dlc3QgeW91ciBkYXRhIHN0cnVjdHVyZSBkZXNpZ24g
aXMgbm90CmNvcnJlY3QuCgo+ICtzdGF0aWMgaW5saW5lIHUzMiByZDMyKHU4IF9faW9tZW0gKmFk
ZHIsIHU2NCByZWcpCj4gK3sKPiArIHJldHVybiByZWFkbChhZGRyICsgKHJlZykpOwo+ICt9Cj4g
Kwo+ICtzdGF0aWMgaW5saW5lIHZvaWQgd3IzMl9iYXJyaWVyKHU4IF9faW9tZW0gKmFkZHIsIHU2
NCByZWcsIHUzMiB2YWx1ZSkKPiArewo+ICsgd3JpdGVsKCh2YWx1ZSksIChhZGRyICsgKHJlZykp
KTsKPiArfQoKV2h5IF9iYXJyaWVyIGhlcmUgZm9yIHdyaXRlLCBidXQgbm90IGZvciByZDMyKCk/
IHJlYWRsKCkgaGFzIGEgYmFycmllcgpzYW1lIGFzIHdyaXRlbCgpPyBTaG91bGQgcmQzMiBhY3R1
YWxseSBiZSB1c2luZyByZWFkbF9yZWxheGVkKCk/Cgo+ICtzdGF0aWMgaW5saW5lIHZvaWQgbmJs
X2h3X3JkX3JlZ3Moc3RydWN0IG5ibF9od19tZ3QgKmh3X21ndCwgdTY0IHJlZywgdTggKmRhdGEs
Cj4gK8KgIMKgIMKgIHUzMiBsZW4pCj4gK3sKPiArIHUzMiBzaXplID0gbGVuIC8gNDsKPiArIHUz
MiBpID0gMDsKPiArCj4gKyBpZiAobGVuICUgNCkKPiArwqAgcmV0dXJuOwoKSXQgaXMgYWN0dWFs
bHkgYSBidWc/Cgo+ICsKPiArIHNwaW5fbG9jaygmaHdfbWd0LT5yZWdfbG9jayk7Cj4gKwo+ICsg
Zm9yIChpID0gMDsgaSA8IHNpemU7IGkrKykKPiArwqAgKih1MzIgKikoZGF0YSArIGkgKiBzaXpl
b2YodTMyKSkgPQo+ICsgwqAgcmQzMihod19tZ3QtPmh3X2FkZHIsIHJlZyArIGkgKiBzaXplb2Yo
dTMyKSk7Cj4gKyBzcGluX3VubG9jaygmaHdfbWd0LT5yZWdfbG9jayk7Cj4gK30KClRoaXMgZnVu
Y3Rpb24gaXMgYSBiaXQgYmlnIGZvciBpbmxpbmUuIEhhdmUgeW91IHVzZWQgYmxvYXQtby1tZXRl
ciB0bwpsb29rIGF0IHRoZSBzaXplIHdpdGggdGhpcyBhbmQgdGhlIG5leHQgYXMgZnVuY3Rpb25z
IHZzIGlubGluZT8KCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBuYmxfaHdfd3JfcmVncyhzdHJ1Y3Qg
bmJsX2h3X21ndCAqaHdfbWd0LCB1NjQgcmVnLAo+ICvCoCDCoCDCoCBjb25zdCB1OCAqZGF0YSwg
dTMyIGxlbikKPiArewo+ICsgdTMyIHNpemUgPSBsZW4gLyA0Owo+ICsgdTMyIGkgPSAwOwo+ICsK
PiArIGlmIChsZW4gJSA0KQo+ICvCoCByZXR1cm47Cj4gKyBzcGluX2xvY2soJmh3X21ndC0+cmVn
X2xvY2spOwo+ICsgZm9yIChpID0gMDsgaSA8IHNpemU7IGkrKykKPiArwqAgLyogVXNlZCBmb3Ig
ZW11LCBtYWtlIHN1cmUgdGhhdCB3ZSB3b24ndCB3cml0ZSB0b28gZnJlcXVlbnRseSAqLwo+ICvC
oCB3cjMyX2JhcnJpZXIoaHdfbWd0LT5od19hZGRyLCByZWcgKyBpICogc2l6ZW9mKHUzMiksCj4g
K8KgIMKgIMKgIMKgICoodTMyICopKGRhdGEgKyBpICogc2l6ZW9mKHUzMikpKTsKPiArIHNwaW5f
dW5sb2NrKCZod19tZ3QtPnJlZ19sb2NrKTsKPiArfQoKIEFuZHJldwo=

