Return-Path: <netdev+bounces-246199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CABCE5B45
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 02:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC5B43000DE1
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 01:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A71118E02A;
	Mon, 29 Dec 2025 01:47:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-22.us.a.mail.aliyun.com (out198-22.us.a.mail.aliyun.com [47.90.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1463AC39;
	Mon, 29 Dec 2025 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766972876; cv=none; b=CMfoDxIJkQMPXzD4rduF6R9lWuYh7e5w94AXE5Rpu8qbNe4U20r5rDoHoXhVEq+qo+syOSsBECNgXx4iWJzwrhBea0b7FiUkfEZYYs9IZ2LjPuzKqyF3YYVHEq8xV6Q3DtTNvpSuisIQnVVVSrLdEoP6DQRPEkKjT4aUruAbt1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766972876; c=relaxed/simple;
	bh=P4TH/At6Mw0xsX2RP0St/9gslUkQnVTUQH6MxwZGj5s=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=VJpVHAfusQC55Bt2ROQ44RM3WOG4eGOGjqxqi//G9geq0Y0hllLQiBI3P9tZHq30ed+HMUXo6vj+yBmLG7rN6yEEdeIH+dje7koQ0iIwKAcB8ld+jQWzYZ4azbHZO4oftUAAGrorN2pbsXofnsIDydpHy3/altn9ptt0wn4KVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1026746|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0122457-0.00192133-0.985833;FP=428820079342831301|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=6;RT=6;SR=0;TI=W4_0.2.3_21251464_1766972851265_o7001c1725;
Received: from WS-web (illusion.wang@nebula-matrix.com[W4_0.2.3_21251464_1766972851265_o7001c1725] cluster:ay29) at Mon, 29 Dec 2025 09:47:31 +0800
Date: Mon, 29 Dec 2025 09:47:31 +0800
From: "Illusion Wang" <illusion.wang@nebula-matrix.com>
To: "Paolo Abeni" <pabeni@redhat.com>,
  "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "Sam" <sam.chen@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>
Cc: "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Illusion Wang" <illusion.wang@nebula-matrix.com>
Message-ID: <19aba6f7-acaf-45cb-985c-54be21592bdc.illusion.wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHYxIG5ldC1uZXh0IDAwLzE1XSBuYmwgZHJpdmVyIGZvciBOZWJ1?=
  =?UTF-8?B?bGFtYXRyaXggTklDcw==?=
X-Mailer: [Alimail-Mailagent revision 63][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>,<a9e7c86b-1a08-4ea4-bf41-75d406a13923@redhat.com>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4xLjEwLVJlbGVhc2UuMjUxMjAyMDEzKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAxMjAwIEFyY2hpdGVjdHVyZS94ODZfNjQgd2ViRHQvUEM=uL
In-Reply-To: <a9e7c86b-1a08-4ea4-bf41-75d406a13923@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

CgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQrlj5Hku7bkurrvvJpQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+
CuWPkemAgeaXtumXtO+8mjIwMjXlubQxMuaciDIz5pelKOWRqOS6jCkgMTU6MDgK5pS25Lu25Lq6
77yaSWxsdXNpb24gV2FuZzxpbGx1c2lvbi53YW5nQG5lYnVsYS1tYXRyaXguY29tPjsgRGltb248
ZGltb24uemhhb0BuZWJ1bGEtbWF0cml4LmNvbT47IEFsdmluPGFsdmluLndhbmdAbmVidWxhLW1h
dHJpeC5jb20+OyBTYW08c2FtLmNoZW5AbmVidWxhLW1hdHJpeC5jb20+OyBuZXRkZXY8bmV0ZGV2
QHZnZXIua2VybmVsLm9yZz4K5oqE44CA6YCB77yab3BlbiBsaXN0PGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc+CuS4u+OAgOmimO+8mlJlOiBbUEFUQ0ggdjEgbmV0LW5leHQgMDAvMTVdIG5i
bCBkcml2ZXIgZm9yIE5lYnVsYW1hdHJpeCBOSUNzCgoKT24gMTIvMjMvMjUgNDo1MCBBTSwgaWxs
dXNpb24ud2FuZyB3cm90ZToKPiBUaGUgcGF0Y2ggc2VyaWVzIGFkZCB0aGUgbmJsIGRyaXZlciwg
d2hpY2ggd2lsbCBzdXBwb3J0IHRoZSBuZWJ1bGEtbWF0cml4IDE4MTAwIGFuZCAxODExMCBzZXJp
ZXMgCj4gb2YgbmV0d29yayBjYXJkcy4KPiBUaGlzIHN1Ym1pc3Npb24gaXMgdGhlIGZpcnN0IHBo
YXNlLiB3aGljaCBpbmNsdWRlcyB0aGUgUEYtYmFzZWQgYW5kIFZGLWJhc2VkIEV0aGVybmV0IHRy
YW5zbWl0IAo+IGFuZCByZWNlaXZlIGZ1bmN0aW9uYWxpdHkuIE9uY2UgdGhpcyBpcyBtZXJnZWQu
IHdpbGwgc3VibWl0IGFkZGl0aW9uIHBhdGNoZXMgdG8gaW1wbGVtZW50IHN1cHBvcnQKPiBmb3Ig
b3RoZXIgZmVhdHVyZXMuIHN1Y2ggYXMgZXRodG9vbCBzdXBwb3J0LCBkZWJ1Z2ZzIHN1cHBvcnQg
YW5kIGV0Yy4KPiBPdXIgRHJpdmVyIGFyY2hpdGVjdHVyZcKgIHN1cHBvcnRzIEtlcm5lbCBNb2Rl
IGFuZCBDb2V4aXN0ZW5jZSBNb2RlKGtlcm5lbCBhbmQgZHBkaykKCk5vdCBhIHJlYWwgcmV2aWV3
LCBidXQgdGhpcyBzZXJpZXMgaGFzIHNldmVyYWwgYmFzaWMgaXNzdWVzOgoKLSBlYWNoIHBhdGNo
IHNob3VsZCBjb21waWxlIGFuZCBidWlsZCB3aXRob3V0IHdhcm5pbmdzIG9uIGFsbCBhcmNoZXMK
LSBkb24ndCB1c2UgaW5saW5lIGluIGMgY29kZQotIGF2b2lkIHVzaW5nICdtb2R1bGVfcGFyYW1z
JwotIHRoZSBwcmVmZXJyZWQgbGluZSB3aWR0aCBpcyBzdGlsbCA4MCBjaGFycwo+Pj4+PgoKVGhh
bmtzIGZvciB5b3VyIHF1aWNrIHJlcGx5IQpIb3dldmVyLCBJIG5vdGljZWQgdGhhdCBhdApodHRw
czovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvY29tbWl0L2JkYzQ4ZmExMWU0NmY4NjdlYTRk
NzVmYTU5ZWU4N2E3ZjQ4YmUxNDQsCkFuZCB0aGUgY2hlY2twYXRjaCB0b29sIGNoZWNrcyBmb3Ig
YSBsaW5lIHdpZHRoIG9mIDEwMCBjb2x1bW5zLiBJZiB3ZSBtYWtlIHRoZSBjaGFuZ2UgdG8gODAg
Y2hhcmFjdGVycywgaXQgbWlnaHQgcmVkdWNlIHJlYWRhYmlsaXR5LgpDb3VsZCBvdXIgZHJpdmVy
IHNldCB0aGUgbGltaXQgdG8gMTAwIGNvbHVtbnMgaW5zdGVhZD8KCj4+Pj4+Ci0gc3RyaXAgY2hh
bmdlZC1pZCBmcm9tIHRoZSBjb21taXQgbWVzc2FnZQotIHJlc3BlY3QgdGhlIHJldmVyc2UgY2hy
aXN0bWFzIHRyZWUgb3JkZXIgZm9yIHZhcmlhYmxlIGRlY2xhcmF0aW9uCi0gY29tbWl0IG1lc3Nh
Z2VzIGxpbmVzIHNob3VsZCBiZSB3cmFwcGVkIGF0IDcyIGNoYXJzCgpOb3RlIHRoYXQgeW91IGNh
biBjbG9uZSB0aGUgTklQQSByZXBvc2l0b3J5OgoKaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LW5l
dGRldi9uaXBhLwoKYW5kIHVzZSB0aGUgaW5nZXN0X21kaXIucHkgc2NyaXB0IHRvIHZhbGlkYXRl
IG1vc3Qgb2YgdGhlIGFib3ZlIGNoZWNrCmJlZm9yZSBzdWJtaXNzaW9uIChvdGhlcndpc2UgeW91
IHNob3VsZCBkbyB0aGF0IG1hbnVhbGx5KS4KCkhvd2V2ZXIuLi4KCiMjIEZvcm0gbGV0dGVyIC0g
bmV0LW5leHQtY2xvc2VkCgpUaGUgbmV0LW5leHQgdHJlZSBpcyBjbG9zZWQgZm9yIG5ldyBkcml2
ZXJzLCBmZWF0dXJlcywgY29kZSByZWZhY3RvcmluZwphbmQgb3B0aW1pemF0aW9ucyBkdWUgdG8g
dGhlIG1lcmdlIHdpbmRvdyBhbmQgdGhlIHdpbnRlciBicmVhay4gV2UgYXJlCmN1cnJlbnRseSBh
Y2NlcHRpbmcgYnVnIGZpeGVzIG9ubHkuCgpQbGVhc2UgcmVwb3N0IHdoZW4gbmV0LW5leHQgcmVv
cGVucyBhZnRlciBKYW4gMm5kLgoKUkZDIHBhdGNoZXMgc2VudCBmb3IgcmV2aWV3IG9ubHkgYXJl
IG9idmlvdXNseSB3ZWxjb21lIGF0IGFueSB0aW1lLgo=

