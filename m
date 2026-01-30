Return-Path: <netdev+bounces-255005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BSIOzEmfGkFKwIAu9opvQ
	(envelope-from <netdev+bounces-255005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:32:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E43BB6D8F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C47F30097F4
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B543C2857F1;
	Fri, 30 Jan 2026 03:31:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C7E18BBAE;
	Fri, 30 Jan 2026 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769743894; cv=none; b=tDr0nH89u4flSa1GZyVrcyRl+fQtEFSIq71me0h+KZy5MJGl8+zkeZruLw7M0yiZPA3SWfmP0ouvWJqbCMEEx0HOVHy5HJYwcOfIf3ByY1nEOYQnjSadQ5fTrYiwPWbacY/Ei9dm8/BEHa1oLIBd4KZB52j2Z+9xJ9M76m3d/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769743894; c=relaxed/simple;
	bh=27yybq+avVH2XtAjsD74kux4Qf/z/5pQwP4wOaT/gHo=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=tEuevrEk6Xsazrbyd5tTvifawWNHMldKPAH8GUWo/4e9/4S6x62fH+KrxLlUiFOtmB8x9xpnwJNS5LZYzPHnpe74pJxboHZ0Vm3AWpWoUS91xbjaUBUlG0BBhXtJs5gljuxZVK23OLb61JT5AXPsQJT205GtnLVx16MbnLY8urk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07416409|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.569133-0.00336644-0.427501;FP=5473539915353087302|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=sam.chen@nebula-matrix.com;NM=1;PH=DW;RN=22;RT=22;SR=0;TI=W4_0.2.3_212505AD_1769743879611_o7001c409;
Received: from WS-web (sam.chen@nebula-matrix.com[W4_0.2.3_212505AD_1769743879611_o7001c409] cluster:ay29) at Fri, 30 Jan 2026 11:31:27 +0800
Date: Fri, 30 Jan 2026 11:31:27 +0800
From: "Sam" <sam.chen@nebula-matrix.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: "Illusion Wang" <illusion.wang@nebula-matrix.com>,
  "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
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
  "hawk" <hawk@kernel.org>,
  "ast" <ast@kernel.org>,
  "bpf" <bpf@vger.kernel.org>,
  "sdf" <sdf@fomichev.me>,
  "daniel" <daniel@iogearbox.net>,
  "john.fastabend" <john.fastabend@gmail.com>,
  "edumazet" <edumazet@google.com>,
  "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Sam" <sam.chen@nebula-matrix.com>
Message-ID: <17d3aa72-23a8-4ea8-9721-bc20fe39fdf4.sam.chen@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77ya5Zue5aSN77ya5Zue5aSN77yaW1BBVENIIHYzIG5ldC1uZXh0IDAxLzE1XSBu?=
  =?UTF-8?B?ZXQvbmVidWxhLW1hdHJpeDogYWRkIG1pbmltdW0gbmJsIGJ1aWxkIGZyYW1ld29yaw==?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com> <20260123011804.31263-2-illusion.wang@nebula-matrix.com> <88c7e349-f941-4216-89ca-70a49e82b378@lunn.ch> <ad0a6f0f-3ce3-4f38-b27d-2f121511d6e3.illusion.wang@nebula-matrix.com> <c1536b51-f441-45ca-8bfb-d5f7d8230713@lunn.ch> <152750cb-ab8c-4f08-9c6a-6b69ec185f30.sam.chen@nebula-matrix.com>,<ecbf1ba5-6ef9-4d94-8240-518852050f03@lunn.ch>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4yLjUtUmVsZWFzZS4yNjAxMTMwMDYpIE1vam8vMS4wLjAgTmF0aXZlIEFwcFR5cGUocmVsZWFzZSkgQ2hhbm5lbC8yMDEyMDAgQXJjaGl0ZWN0dXJlL3g4Nl82NCB3ZWJEdC9QQw==uL
In-Reply-To: <ecbf1ba5-6ef9-4d94-8240-518852050f03@lunn.ch>
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
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[nebula-matrix.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255005-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebula-matrix.com:replyto,nebula-matrix.com:email,nebula-matrix.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,fomichev.me:email,lunn.ch:email,lwn.net:email,iogearbox.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[sam.chen@nebula-matrix.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.chen@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 4E43BB6D8F
X-Rspamd-Action: no action

VGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrLiBZb3UgbWlnaHQgaGF2ZSBtaXN1bmRlcnN0b29k
IG1lLgpPdXIgZGlmZmljdWx0aWVzIGxpZSBpbiB0aGUgZm9sbG93aW5nOgoxLiBBc3N1bWluZyBv
bmx5IHRoZSBtYWlubGluZSB2ZXJzaW9uIGNoYW5nZXMgdGhlIG5hbWUgKEFzc3VtZSBuYW1lICJu
YmwiKSwKIMKgIGFuZCBvdXIgcmVndWxhcmx5IHJlbGVhc2VkIGRyaXZlciBkb2Vzbid0IGNoYW5n
ZSBpdHMgbmFtZSwgdGhlbiB3aGVuCiDCoCBjdXN0b21lcnMgdXBncmFkZSB0byBhIG5ldyBrZXJu
ZWwgKGNvbnRhaW5pbmcgdGhlICJuYmwiIGRyaXZlciksCiDCoCBhbmQgdGhlbiB3YW50IHRvIHVw
ZGF0ZSBvdXIgcmVndWxhcmx5IHJlbGVhc2VkIGRyaXZlciAobmFtZWQgIm5ibF9jb3JlIiksCiDC
oCB0aGUgbW9kdWxlIChrbykgY29uZmxpY3Qgd2lsbCBvY2N1ci4KMi4gSWYgYm90aCBvdXIgbWFp
bmxpbmUgYW5kIHJlZ3VsYXJseSByZWxlYXNlZCBkcml2ZXJzIGNoYW5nZSB0aGVpciBuYW1lcywK
IMKgIHRoZW4gY3VzdG9tZXJzIHdobyBhcmUgYWxyZWFkeSB1c2luZyB0aGUgIm5ibF9jb3JlIiBk
cml2ZXIgd2lsbCBhbHNvCiDCoCBlbmNvdW50ZXIgY29uZmxpY3QgaXNzdWVzIHdoZW4gdXBkYXRp
bmcgdG8gdGhlIG5ldyBkcml2ZXIgIm5ibCIuCgpJcyBpdCBwb3NzaWJsZSB0byBkbyB0aGlzOiBv
dXIgbmV0IGRyaXZlciBpcyBhbHNvIG1vZGlmaWVkIHRvIGJlIGEgZHJpdmVyIGJhc2VkCm9uIHRo
ZSBhdXhpbGlhcnkgYnVzLCB3aGlsZSB0aGUgUENJZSBkcml2ZXIgb25seSBoYW5kbGVzIFBDSWUt
cmVsYXRlZCBwcm9jZXNzaW5nLAphbmQgdGhlc2UgdHdvIGRyaXZlcnMgc2hhcmUgYSBzaW5nbGUg
a2VybmVsIG1vZHVsZSAoa28pLCBuYW1lbHkgIm5ibF9jb3JlIj8KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCuWPkeS7tuS6
uu+8mkFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4K5Y+R6YCB5pe26Ze077yaMjAyNuW5tDHm
nIgzMOaXpSjlkajkupQpIDExOjA0CuaUtuS7tuS6uu+8mlNhbTxzYW0uY2hlbkBuZWJ1bGEtbWF0
cml4LmNvbT4K5oqE44CA6YCB77yaSWxsdXNpb24gV2FuZzxpbGx1c2lvbi53YW5nQG5lYnVsYS1t
YXRyaXguY29tPjsgRGltb248ZGltb24uemhhb0BuZWJ1bGEtbWF0cml4LmNvbT47IEFsdmluPGFs
dmluLndhbmdAbmVidWxhLW1hdHJpeC5jb20+OyBuZXRkZXY8bmV0ZGV2QHZnZXIua2VybmVsLm9y
Zz47ICJhbmRyZXcrbmV0ZGV2IjxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBjb3JiZXQ8Y29yYmV0
QGx3bi5uZXQ+OyBrdWJhPGt1YmFAa2VybmVsLm9yZz47ICJsaW51eC1kb2MiPGxpbnV4LWRvY0B2
Z2VyLmtlcm5lbC5vcmc+OyBsb3JlbnpvPGxvcmVuem9Aa2VybmVsLm9yZz47IHBhYmVuaTxwYWJl
bmlAcmVkaGF0LmNvbT47IGhvcm1zPGhvcm1zQGtlcm5lbC5vcmc+OyAidmFkaW0uZmVkb3Jlbmtv
Ijx2YWRpbS5mZWRvcmVua29AbGludXguZGV2PjsgImx1a2FzLmJ1bHdhaG4iPGx1a2FzLmJ1bHdh
aG5AcmVkaGF0LmNvbT47IGhhd2s8aGF3a0BrZXJuZWwub3JnPjsgYXN0PGFzdEBrZXJuZWwub3Jn
PjsgYnBmPGJwZkB2Z2VyLmtlcm5lbC5vcmc+OyBzZGY8c2RmQGZvbWljaGV2Lm1lPjsgZGFuaWVs
PGRhbmllbEBpb2dlYXJib3gubmV0PjsgImpvaG4uZmFzdGFiZW5kIjxqb2huLmZhc3RhYmVuZEBn
bWFpbC5jb20+OyBlZHVtYXpldDxlZHVtYXpldEBnb29nbGUuY29tPjsgb3BlbiBsaXN0PGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+CuS4u+OAgOmimO+8mlJlOiDlm57lpI3vvJrlm57lpI3v
vJpbUEFUQ0ggdjMgbmV0LW5leHQgMDEvMTVdIG5ldC9uZWJ1bGEtbWF0cml4OiBhZGQgbWluaW11
bSBuYmwgYnVpbGQgZnJhbWV3b3JrCgoKT24gRnJpLCBKYW4gMzAsIDIwMjYgYXQgMTA6MjM6NTBB
TSArMDgwMCwgU2FtIHdyb3RlOgo+IFRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4gSSB1bmRl
cnN0YW5kIHdoYXQgeW91IG1lYW4uVGhlIHJlYXNvbnMgd2h5Cj4gd2UgY2Fubm90IGNoYW5nZSB0
aGUgbW9kdWxlIG5hbWUgbm93IGFyZSBhcyBmb2xsb3dzOgo+IE91ciBkcml2ZXIgaGFzIGFscmVh
ZHkgYmVlbiBpbnRlZ3JhdGVkIGludG8gbXVsdGlwbGUgY29tbXVuaXRpZXMsIGFuZAo+IHRoZSBt
b2R1bGUgbmFtZSBpcyBuYmxfY29yZS4gTWFueSBjdXN0b21lcnMgaGF2ZSBhbHJlYWR5IGRlcGxv
eWVkIGl0LiBJZgo+IHdlIGNoYW5nZSB0aGUgbmFtZSwgdGhlcmUgd2lsbCBiZSBhIGNyaXRpY2Fs
IHByb2JsZW0gb2YgY29uZmxpY3QgYmV0d2Vlbgo+IHRoZSB0d28gbW9kdWxlcyBkdXJpbmcgc3Vi
c2VxdWVudCBvbmxpbmUgZHJpdmVyIHVwZ3JhZGVzLgoKVG8gYSBsYXJnZSBleHRlbnQsIG1haW5s
aW5lIGRvZXMgbm90IGNhcmUgYWJvdXQgeW91ciB2ZW5kb3IgZHJpdmVyLAphbmQgaXQgZG9lcyBu
b3QgY2FyZSBhYm91dCBhbnkgY29tcGF0aWJpbGl0eSBpc3N1ZXMgYmV0d2VlbiB5b3VyCnZlbmRv
ciBkcml2ZXIgYW5kIG1haW5saW5lLgoKSSd2ZSBub3QgbG9va2VkIGF0IHlvdXIgZHJpdmVyIGlu
IGRldGFpbCB5ZXQgc28gaSBjYW5ub3QgY29tbWVudCBvbgp5b3VyIGRyaXZlciBpbiBwYXJ0aWN1
bGFyLiBCdXQgd2Ugb2Z0ZW4gc2VlIHZlbmRvciBkcml2ZXJzIGRvIHRoaW5ncwptYWlubGluZSBk
b2VzIG5vdCBhbGxvdy4gQ3VzdG9tIGlvY3RsIGhhbmRsZXJzLCBmaWxlcyBpbiAvc3lzLCB3cml0
ZQpBUElzIGluIGRlYnVnZnMsIHN0YXRpc3RpYyBjb3VudGVycyB3cm9uZ2x5IGdyb3VwZWQsIGV0
Yy4gSW4gYSB2ZW5kb3IKZHJpdmVyIHRoaXMgaXMgTy5LLCB0aGlzIGlzIGFsbCBvcGVuIHNvdXJj
ZSwgeW91IGFyZSBmcmVlIHRvIGRvIHdoYXQKeW91IHdhbnQuIEJ1dCB3aGVuIGl0IGNvbWVzIHRv
IG1haW5saW5lLCB5b3UgaGF2ZSB0byBrZWVwIHRvIHRoZQptYWlubGluZSBydWxlcy4gU3VjaCBj
b2RlIHdpbGwgbmVlZCB0byBiZSByZW1vdmVkLCBvciByZXdvcmtlZCwKYnJlYWtpbmcgY29tcGF0
aWJpbGl0eSB3aXRoIHlvdXIgdmVuZG9yIGRyaXZlci4KClNvIGl0IGNhbiBiZSBhZHZhbnRhZ2Vz
IHRvIGhhdmUgZGlmZmVyZW50IG5hbWVzLCBpdCB0aGVuIGJlY29tZSBjbGVhcgppZiBhIGN1c3Rv
bWVyIGlzIHVzaW5nIHRoZSB2ZW5kb3IgZHJpdmVyLCBvciBpcyB1c2luZyBtYWlubGluZS4KCiDC
oCBBbmRyZXcKCgo=

