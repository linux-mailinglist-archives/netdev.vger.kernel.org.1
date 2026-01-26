Return-Path: <netdev+bounces-253313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J9QGEzedmmhYAEAu9opvQ
	(envelope-from <netdev+bounces-253313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 04:23:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DDA83A4B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 04:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E93F30056C1
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 03:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FE4238C1B;
	Mon, 26 Jan 2026 03:23:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-2.us.a.mail.aliyun.com (out198-2.us.a.mail.aliyun.com [47.90.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED8A3EBF12;
	Mon, 26 Jan 2026 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769397828; cv=none; b=ev7Ujss0JxGnrsQVK99yscGARLc6ioKAYtlj5UWG+wX9mbb0O5kBECYLYnh+TOa9lKScKF9rQLpd+yptI60goE9HRt+CAPBluvI4OkbVgXwKNZJWh2EAjVsLzYKgSyNmsZboa25Xk6/a6lx5AWu/lttT74GH91G4unqVhmEdLuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769397828; c=relaxed/simple;
	bh=7N2OSSOuKF3XC+SJajbm8YcWi4VvdwRLZ2yRwPBDs+c=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=QQ9YI4PsaA1jN0HatBYiGk2aHZtyBelqas52L8l624xcHgplQYWTQNQ/ObZ1QaOT2dwbjwtX82k9OnNhI5DRpKUI3FZVFfVtwFG6U2cq5QIbsy9ffmqwy7G6ZnsRRB2B4milYDPbDk3kpD46NY27IB0mymu5f3JkUUcrp+MhUDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1177522|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0162329-0.0207456-0.963022;FP=4933475177643793028|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=23;RT=23;SR=0;TI=W4_0.2.3_21250492_1769397801808_o7001c144k;
Received: from WS-web (illusion.wang@nebula-matrix.com[W4_0.2.3_21250492_1769397801808_o7001c144k] cluster:ay29) at Mon, 26 Jan 2026 11:23:22 +0800
Date: Mon, 26 Jan 2026 11:23:22 +0800
From: "Illusion Wang" <illusion.wang@nebula-matrix.com>
To: "Andrew Lunn" <andrew@lunn.ch>,
  "y" <y@lunn.ch>
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
  "hawk" <hawk@kernel.org>,
  "ast" <ast@kernel.org>,
  "bpf" <bpf@vger.kernel.org>,
  "sdf" <sdf@fomichev.me>,
  "daniel" <daniel@iogearbox.net>,
  "john.fastabend" <john.fastabend@gmail.com>,
  "edumazet" <edumazet@google.com>,
  "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Illusion Wang" <illusion.wang@nebula-matrix.com>
Message-ID: <20139df8-ccd9-4417-9b48-4815743a4e1e.illusion.wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHYzIG5ldC1uZXh0IDAxLzE1XSBuZXQvbmVidWxhLW1hdHJpeDog?=
  =?UTF-8?B?YWRkIG1pbmltdW0gbmJsIGJ1aWxkIGZyYW1ld29yaw==?=
X-Mailer: [Alimail-Mailagent revision 24734][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com> <20260123011804.31263-2-illusion.wang@nebula-matrix.com>,<88c7e349-f941-4216-89ca-70a49e82b378@lunn.ch>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4yLjAtUmVsZWFzZS4yNTEyMjIwMTkpIE1vam8vMS4wLjAgTmF0aXZlIEFwcFR5cGUocmVsZWFzZSkgQ2hhbm5lbC8yMDEyMDAgQXJjaGl0ZWN0dXJlL3g4Nl82NCB3ZWJEdC9QQw==uL
In-Reply-To: <88c7e349-f941-4216-89ca-70a49e82b378@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[nebula-matrix.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253313-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,illusion.wang:url,lwn.net:email,nebula-matrix.com:replyto,nebula-matrix.com:email,nebula-matrix.com:mid,lunn.ch:email,iogearbox.net:email,linux.dev:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[illusion.wang@nebula-matrix.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: D8DDA83A4B
X-Rspamd-Action: no action

Cgo+X0NPUkUgaXMgYSBiaXQgdW51c3VhbCBmb3IgYSBkcml2ZXIuIENPUkUgaXMgZ2VuZXJhbGx5
IGEgbGlicmFyeSB3aGljaAo+aXMgc2hhcmVkIGJ5IGEgbnVtYmVyIG9mIGRyaXZlcnMuIEl0IGRv
ZXMgbm90IGhhdmUgYSB0cmlzdGF0ZSBzdHJpbmcsCj5pdCBpcyBqdXN0IHNlbGVjdGVkIGJ5IHRo
ZSBkcml2ZXJzIHdoaWNoIG5lZWQgaXQuCgpUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2sgb24g
dGhlIE5CTF9DT1JFIGNvbmZpZ3VyYXRpb24gb3B0aW9uLiBXZSBhcHByZWNpYXRlCnlvdXIgZ3Vp
ZGFuY2Ugb24gYWRoZXJpbmcgdG8gTGludXgga2VybmVsIG5hbWluZyBjb252ZW50aW9ucy4KCldo
eSBOQkxfQ09SRT8KVGhlIGRyaXZlciBpcyBkZXNpZ25lZCB0byBzdXBwb3J0IHR3byBkaXN0aW5j
dCBmdW5jdGlvbmFsaXRpZXMgZm9yIHRoZQpOZWJ1bGEtbWF0cml4IG0xODEwMCBFdGhlcm5ldCBj
b250cm9sbGVyOgoKMS5TdGFuZGFyZCBFdGhlcm5ldC9OSUMgZnVuY3Rpb25hbGl0eSAodmlhIHRo
ZSBtYWluIGRyaXZlciBtb2R1bGUpLgoyLkF1eGlsaWFyeSBkZXZpY2UgKGF1eGlsaWFyeSBkcml2
ZXIpIGZvciBSRE1BIChleHBvc2VkIHRocm91Z2ggYXV4aWxpYXJ5X2RldmljZSkuCjQuTURFVi1i
YXNlZCBTUi1JT1YvVkYgZW11bGF0aW9uIChmb3IgbmF0aXZlIGRldmljZSBzcGxpdHRpbmcpLgpT
aW5jZSBzaGFyZWQgbG9naWMgKGUuZy4sIFBDSWUgcmVzb3VyY2UgbWFuYWdlbWVudCwgTU1JTyBh
Y2Nlc3MsIGludGVycnVwdApoYW5kbGluZywgYW5kIGNvbW1vbiBoYXJkd2FyZSBhYnN0cmFjdGlv
bnMpIGlzIHJlcXVpcmVkIGFjcm9zcyBib3RoIHRoZSBtYWluCmRyaXZlciBhbmQgYXV4aWxpYXJ5
L1JETUEgZHJpdmVyLCB3ZSBvcHRlZCBmb3IgYSBfQ09SRSBzdWZmaXggdG8gaW5kaWNhdGU6CgpS
ZXVzYWJpbGl0eTogVGhlIG1vZHVsZSBwcm92aWRlcyBmb3VuZGF0aW9uYWwgY29kZSB1c2VkIGJ5
IG11bHRpcGxlIHN1Yi1kcml2ZXJzCihtYWluIE5JQyArIGF1eGlsaWFyeSBSRE1BKS4KTW9kdWxh
cml0eTogRnV0dXJlIGV4dGVuc2lvbnMgKGUuZy4sIGFkZGl0aW9uYWwgYXV4aWxpYXJ5IGRldmlj
ZXMpIGNhbiByZXVzZSB0aGUKc2FtZSBjb3JlIGluZnJhc3RydWN0dXJlLgpTbyBpdCBzZXJ2ZXMg
YSBzaW1pbGFyIHB1cnBvc2UgdG8gbWx4NV9jb3JlIChNZWxsYW5veCksIHdoZXJlIGEgY2VudHJh
bCBtb2R1bGUKaGFuZGxlcyBoYXJkd2FyZS1zcGVjaWZpYyBvcGVyYXRpb25zIGZvciBtdWx0aXBs
ZSBzdWItZHJpdmVycy4KCmlsbHVzaW9uLndhbmcKCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCuWPkeS7tuS6uu+8mkFu
ZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4K5Y+R6YCB5pe26Ze077yaMjAyNuW5tDHmnIgyM+aX
pSjlkajkupQpIDExOjI3CuaUtuS7tuS6uu+8mklsbHVzaW9uIFdhbmc8aWxsdXNpb24ud2FuZ0Bu
ZWJ1bGEtbWF0cml4LmNvbT47IHk8eUBsdW5uLmNoPgrmioTjgIDpgIHvvJpEaW1vbjxkaW1vbi56
aGFvQG5lYnVsYS1tYXRyaXguY29tPjsgQWx2aW48YWx2aW4ud2FuZ0BuZWJ1bGEtbWF0cml4LmNv
bT47IFNhbTxzYW0uY2hlbkBuZWJ1bGEtbWF0cml4LmNvbT47IG5ldGRldjxuZXRkZXZAdmdlci5r
ZXJuZWwub3JnPjsgImFuZHJldytuZXRkZXYiPGFuZHJldytuZXRkZXZAbHVubi5jaD47IGNvcmJl
dDxjb3JiZXRAbHduLm5ldD47IGt1YmE8a3ViYUBrZXJuZWwub3JnPjsgImxpbnV4LWRvYyI8bGlu
dXgtZG9jQHZnZXIua2VybmVsLm9yZz47IGxvcmVuem88bG9yZW56b0BrZXJuZWwub3JnPjsgcGFi
ZW5pPHBhYmVuaUByZWRoYXQuY29tPjsgaG9ybXM8aG9ybXNAa2VybmVsLm9yZz47ICJ2YWRpbS5m
ZWRvcmVua28iPHZhZGltLmZlZG9yZW5rb0BsaW51eC5kZXY+OyAibHVrYXMuYnVsd2FobiI8bHVr
YXMuYnVsd2FobkByZWRoYXQuY29tPjsgaGF3azxoYXdrQGtlcm5lbC5vcmc+OyBhc3Q8YXN0QGtl
cm5lbC5vcmc+OyBicGY8YnBmQHZnZXIua2VybmVsLm9yZz47IHNkZjxzZGZAZm9taWNoZXYubWU+
OyBkYW5pZWw8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+OyAiam9obi5mYXN0YWJlbmQiPGpvaG4uZmFz
dGFiZW5kQGdtYWlsLmNvbT47IGVkdW1hemV0PGVkdW1hemV0QGdvb2dsZS5jb20+OyBvcGVuIGxp
c3Q8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4K5Li744CA6aKY77yaUmU6IFtQQVRDSCB2
MyBuZXQtbmV4dCAwMS8xNV0gbmV0L25lYnVsYS1tYXRyaXg6IGFkZCBtaW5pbXVtIG5ibCBidWls
ZCBmcmFtZXdvcmsKCgo+ICtjb25maWcgTkJMX0NPUkUKPiArwqAgwqAgdHJpc3RhdGUgIk5lYnVs
YS1tYXRyaXggRXRoZXJuZXQgQ29udHJvbGxlciBtMTgxMDAgRmFtaWx5IHN1cHBvcnQiCj4gK8Kg
IMKgIGRlcGVuZHMgb24gNjRCSVQgJiYgUENJCj4gK8KgIMKgIGRlZmF1bHQgbQo+ICvCoCDCoCBz
ZWxlY3QgUEFHRV9QT09MCj4gK8KgIMKgIGhlbHAKPiArwqAgwqAgwqAgVGhpcyBkcml2ZXIgc3Vw
cG9ydHMgTmVidWxhLW1hdHJpeCBFdGhlcm5ldCBDb250cm9sbGVyIG0xODEwMCBGYW1pbHkgb2YK
PiArwqAgwqAgwqAgZGV2aWNlcy7CoCBGb3IgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCB0aGlzIHBy
b2R1Y3QsIGdvIHRvIHRoZSBwcm9kdWN0Cj4gK8KgIMKgIMKgIGRlc2NyaXB0aW9uIHdpdGggc21h
cnQgTklDOgoKX0NPUkUgaXMgYSBiaXQgdW51c3VhbCBmb3IgYSBkcml2ZXIuIENPUkUgaXMgZ2Vu
ZXJhbGx5IGEgbGlicmFyeSB3aGljaAppcyBzaGFyZWQgYnkgYSBudW1iZXIgb2YgZHJpdmVycy4g
SXQgZG9lcyBub3QgaGF2ZSBhIHRyaXN0YXRlIHN0cmluZywKaXQgaXMganVzdCBzZWxlY3RlZCBi
eSB0aGUgZHJpdmVycyB3aGljaCBuZWVkIGl0LgoKPiArc3RhdGljIGludCBuYmxfcHJvYmUoc3Ry
dWN0IHBjaV9kZXYgKnBkZXYsCj4gKyDCoCDCoCDCoCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9p
ZCBfX2Fsd2F5c191bnVzZWQgKmlkKQo+ICt7Cj4gKyBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRl
di0+ZGV2Owo+ICsKPiArIGRldl9kYmcoZGV2LCAibmJsIHByb2JlIG9rIVxuIik7CgpQbGVhc2Ug
ZG9uJ3QgaGF2ZSBwb2ludGxlc3MgZGVidWcgbWVzc2FnZXMuIElmIHlvdXIgZHJpdmVyIGRvZXMg
bm90CmV2ZW4gcHJvYmUsIHlvdSBzaG91bGQgbm90IGJlIHN1Ym1pdHRpbmcgaXQuCgo+ICsgcmV0
dXJuIDA7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIG5ibF9yZW1vdmUoc3RydWN0IHBjaV9kZXYg
KnBkZXYpCj4gK3sKPiArIGRldl9kYmcoJnBkZXYtPmRldiwgIm5ibCByZW1vdmUgT0shXG4iKTsK
PiArfQo+ICsKPiArI2RlZmluZSBOQkxfVkVORE9SX0lEIMKgICgweDFGMEYpCgrCoCDCoCBBbmRy
ZXcKCi0tLQpwdy1ib3Q6IGNyCg==

