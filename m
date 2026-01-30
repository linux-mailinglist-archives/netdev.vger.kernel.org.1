Return-Path: <netdev+bounces-254975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLduE0cWfGkeKgIAu9opvQ
	(envelope-from <netdev+bounces-254975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:24:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFF6B6646
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F0CF30059B4
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E810309EFF;
	Fri, 30 Jan 2026 02:24:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34A28750A;
	Fri, 30 Jan 2026 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769739844; cv=none; b=gAXlypxTSuIvp3xPHQUqk3qy9iPiVJvu4WgB58zgc+c+V6FphwK+uZM86X2Iy/lXDW2+kp2jOSjmJe6qLVEtU3A4VHtsAfGOQzhwNguyFgXPWGADMqzA9OlTItHmCZ8pbE6Ea5wgzy7VblIUvxFbVrt6VvwqiP2HXlNNONac7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769739844; c=relaxed/simple;
	bh=jf/RBGXHlw1fH394VTvjOKslnicC+u5E8BFY30ps4e8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=BOXMJajlpbbcspAQ+wovRT9kvjbiqPJmYkI8tVgk3AFndnWwu/A7dECESx+ibNWwQ21+AHA3T2ijiHItSe/c1E1GPNjar6xt6gnK98kpaoupEr09eY2XT6bPGo9T2JQlGO8AEW5alQdLF9gdc/0/f+rrkQRznWjBfCHgYhUNCu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.5274864|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0688948-0.0276571-0.903448;FP=4752486971615204742|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=sam.chen@nebula-matrix.com;NM=1;PH=DW;RN=23;RT=23;SR=0;TI=W4_0.2.3_2125062F_1769739830224_o7001c211g;
Received: from WS-web (sam.chen@nebula-matrix.com[W4_0.2.3_2125062F_1769739830224_o7001c211g] cluster:ay29) at Fri, 30 Jan 2026 10:23:50 +0800
Date: Fri, 30 Jan 2026 10:23:50 +0800
From: "Sam" <sam.chen@nebula-matrix.com>
To: "Andrew Lunn" <andrew@lunn.ch>,
  "Illusion Wang" <illusion.wang@nebula-matrix.com>
Cc: "y" <y@lunn.ch>,
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
Message-ID: <152750cb-ab8c-4f08-9c6a-6b69ec185f30.sam.chen@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77ya5Zue5aSN77yaW1BBVENIIHYzIG5ldC1uZXh0IDAxLzE1XSBuZXQvbmVidWxh?=
  =?UTF-8?B?LW1hdHJpeDogYWRkIG1pbmltdW0gbmJsIGJ1aWxkIGZyYW1ld29yaw==?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com> <20260123011804.31263-2-illusion.wang@nebula-matrix.com> <88c7e349-f941-4216-89ca-70a49e82b378@lunn.ch> <ad0a6f0f-3ce3-4f38-b27d-2f121511d6e3.illusion.wang@nebula-matrix.com>,<c1536b51-f441-45ca-8bfb-d5f7d8230713@lunn.ch>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4yLjUtUmVsZWFzZS4yNjAxMTMwMDYpIE1vam8vMS4wLjAgTmF0aXZlIEFwcFR5cGUocmVsZWFzZSkgQ2hhbm5lbC8yMDEyMDAgQXJjaGl0ZWN0dXJlL3g4Nl82NCB3ZWJEdC9QQw==uL
In-Reply-To: <c1536b51-f441-45ca-8bfb-d5f7d8230713@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-254975-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,iogearbox.net:email,lwn.net:email,fomichev.me:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[sam.chen@nebula-matrix.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.chen@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,nebula-matrix.com,vger.kernel.org,lwn.net,kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: CCFF6B6646
X-Rspamd-Action: no action

VGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrLiBJIHVuZGVyc3RhbmQgd2hhdCB5b3UgbWVhbi5U
aGUgcmVhc29ucyB3aHkKd2UgY2Fubm90IGNoYW5nZSB0aGUgbW9kdWxlIG5hbWUgbm93IGFyZSBh
cyBmb2xsb3dzOgpPdXIgZHJpdmVyIGhhcyBhbHJlYWR5IGJlZW4gaW50ZWdyYXRlZCBpbnRvIG11
bHRpcGxlIGNvbW11bml0aWVzLCBhbmQKdGhlIG1vZHVsZSBuYW1lIGlzIG5ibF9jb3JlLiBNYW55
IGN1c3RvbWVycyBoYXZlIGFscmVhZHkgZGVwbG95ZWQgaXQuIElmCndlIGNoYW5nZSB0aGUgbmFt
ZSwgdGhlcmUgd2lsbCBiZSBhIGNyaXRpY2FsIHByb2JsZW0gb2YgY29uZmxpY3QgYmV0d2Vlbgp0
aGUgdHdvIG1vZHVsZXMgZHVyaW5nIHN1YnNlcXVlbnQgb25saW5lIGRyaXZlciB1cGdyYWRlcy4K
ClBTOiBPdXIgY2FyZCdzIGZ1bmN0aW9uYWxpdHkgaXMgY29tcGFyYWJsZSB0byBNZWxsYW5veCBD
WCwgYW5kIHRoZSBkZXNpZ24Kb2YgbmJsX2NvcmUgd2FzIGluaXRpYWxseSBiYXNlZCBvbiB0aGVp
ciBkZXNpZ24gcHJpbmNpcGxlcy4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCuWPkeS7tuS6uu+8mkFuZHJldyBMdW5uIDxh
bmRyZXdAbHVubi5jaD4K5Y+R6YCB5pe26Ze077yaMjAyNuW5tDHmnIgyOeaXpSjlkajlm5spIDIx
OjE4CuaUtuS7tuS6uu+8mklsbHVzaW9uIFdhbmc8aWxsdXNpb24ud2FuZ0BuZWJ1bGEtbWF0cml4
LmNvbT4K5oqE44CA6YCB77yaeTx5QGx1bm4uY2g+OyBEaW1vbjxkaW1vbi56aGFvQG5lYnVsYS1t
YXRyaXguY29tPjsgQWx2aW48YWx2aW4ud2FuZ0BuZWJ1bGEtbWF0cml4LmNvbT47IFNhbTxzYW0u
Y2hlbkBuZWJ1bGEtbWF0cml4LmNvbT47IG5ldGRldjxuZXRkZXZAdmdlci5rZXJuZWwub3JnPjsg
ImFuZHJldytuZXRkZXYiPGFuZHJldytuZXRkZXZAbHVubi5jaD47IGNvcmJldDxjb3JiZXRAbHdu
Lm5ldD47IGt1YmE8a3ViYUBrZXJuZWwub3JnPjsgImxpbnV4LWRvYyI8bGludXgtZG9jQHZnZXIu
a2VybmVsLm9yZz47IGxvcmVuem88bG9yZW56b0BrZXJuZWwub3JnPjsgcGFiZW5pPHBhYmVuaUBy
ZWRoYXQuY29tPjsgaG9ybXM8aG9ybXNAa2VybmVsLm9yZz47ICJ2YWRpbS5mZWRvcmVua28iPHZh
ZGltLmZlZG9yZW5rb0BsaW51eC5kZXY+OyAibHVrYXMuYnVsd2FobiI8bHVrYXMuYnVsd2FobkBy
ZWRoYXQuY29tPjsgaGF3azxoYXdrQGtlcm5lbC5vcmc+OyBhc3Q8YXN0QGtlcm5lbC5vcmc+OyBi
cGY8YnBmQHZnZXIua2VybmVsLm9yZz47IHNkZjxzZGZAZm9taWNoZXYubWU+OyBkYW5pZWw8ZGFu
aWVsQGlvZ2VhcmJveC5uZXQ+OyAiam9obi5mYXN0YWJlbmQiPGpvaG4uZmFzdGFiZW5kQGdtYWls
LmNvbT47IGVkdW1hemV0PGVkdW1hemV0QGdvb2dsZS5jb20+OyBvcGVuIGxpc3Q8bGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZz4K5Li744CA6aKY77yaUmU6IOWbnuWkje+8mltQQVRDSCB2MyBu
ZXQtbmV4dCAwMS8xNV0gbmV0L25lYnVsYS1tYXRyaXg6IGFkZCBtaW5pbXVtIG5ibCBidWlsZCBm
cmFtZXdvcmsKCgpPbiBNb24sIEphbiAyNiwgMjAyNiBhdCAxMDoxODo1MkFNICswODAwLCBJbGx1
c2lvbiBXYW5nIHdyb3RlOgo+IAo+ID5fQ09SRSBpcyBhIGJpdCB1bnVzdWFsIGZvciBhIGRyaXZl
ci4gQ09SRSBpcyBnZW5lcmFsbHkgYSBsaWJyYXJ5IHdoaWNoCj4gPmlzIHNoYXJlZCBieSBhIG51
bWJlciBvZiBkcml2ZXJzLiBJdCBkb2VzIG5vdCBoYXZlIGEgdHJpc3RhdGUgc3RyaW5nLAo+ID5p
dCBpcyBqdXN0IHNlbGVjdGVkIGJ5IHRoZSBkcml2ZXJzIHdoaWNoIG5lZWQgaXQuCj4gCj4gVGhh
bmsgeW91IGZvciB5b3VyIGZlZWRiYWNrIG9uIHRoZSBOQkxfQ09SRSBjb25maWd1cmF0aW9uIG9w
dGlvbi4gV2UgYXBwcmVjaWF0ZQo+IHlvdXIgZ3VpZGFuY2Ugb24gYWRoZXJpbmcgdG8gTGludXgg
a2VybmVsIG5hbWluZyBjb252ZW50aW9ucy4KPiAKPiBXaHkgTkJMX0NPUkU/Cj4gVGhlIGRyaXZl
ciBpcyBkZXNpZ25lZCB0byBzdXBwb3J0IHR3byBkaXN0aW5jdCBmdW5jdGlvbmFsaXRpZXMgZm9y
IHRoZQo+IE5lYnVsYS1tYXRyaXggbTE4MTAwIEV0aGVybmV0IGNvbnRyb2xsZXI6Cj4gCj4gMS5T
dGFuZGFyZCBFdGhlcm5ldC9OSUMgZnVuY3Rpb25hbGl0eSAodmlhIHRoZSBtYWluIGRyaXZlciBt
b2R1bGUpLgo+IDIuQXV4aWxpYXJ5IGRldmljZSAoYXV4aWxpYXJ5IGRyaXZlcikgZm9yIFJETUEg
KGV4cG9zZWQgdGhyb3VnaAo+IGF1eGlsaWFyeV9kZXZpY2UpLgo+IDQuTURFVi1iYXNlZCBTUi1J
T1YvVkYgZW11bGF0aW9uIChmb3IgbmF0aXZlIGRldmljZSBzcGxpdHRpbmcpLgo+IFNpbmNlIHNo
YXJlZCBsb2dpYyAoZS5nLiwgUENJZSByZXNvdXJjZSBtYW5hZ2VtZW50LCBNTUlPIGFjY2Vzcywg
aW50ZXJydXB0Cj4gaGFuZGxpbmcsIGFuZCBjb21tb24gaGFyZHdhcmUgYWJzdHJhY3Rpb25zKSBp
cyByZXF1aXJlZCBhY3Jvc3MgYm90aCB0aGUgbWFpbgo+IGRyaXZlciBhbmQgYXV4aWxpYXJ5L1JE
TUEgZHJpdmVyLCB3ZSBvcHRlZCBmb3IgYSBfQ09SRSBzdWZmaXggdG8gaW5kaWNhdGU6CgpZb3Ug
Y2FuIHNwbGl0IHRoaXMgdHdvIHdheXM6CgpBIHRydWUgY29yZSwgd2hpY2ggZG9lcyBub3QgcHJv
dmlkZSBhbnkgZGV2aWNlcywganVzdCBjb3JlIGZ1bmN0aW9ucwp0byBhY2Nlc3MgdGhlIGhhcmR3
YXJlLiBUaGVuIGxheWVyZWQgb24gdG9wIGlmIHRoaXMgeW91IGhhdmUga2VybmVsCm1vZHVsZXMg
d2l0aCBwcm92aWRlIEV0aGVybmV0LCBSRE1BLCBNREVWIGV0Yy4gU3VjaCBrZXJuZWwgbW9kdWxl
cwp3b3VsZCB0aGVuIGRlcGVuZCBvbiB0aGUgY29yZSwgdXNpbmcgS2NvbmZpZyBwcmltaXRpdmVz
LiBBbmQgdGhlIGNvcmUKaXRzZWxmIHdvdWxkIG5vdCBoYXZlIGEgdHJpLXN0YXRlIHN0cmluZywg
c2luY2Ugb24gaXRzIG93biBpdCBpcwp1c2VsZXNzLgoKT3IKCklmIHRoZSBjb3JlIGFsd2F5cyBw
cm92aWRlcyBFdGhlcm5ldCwgY2FsbCBpdCBhbiBFdGhlcm5ldCBkcml2ZXIsIG5vdApjb3JlLiBU
aGUgb3RoZXIga2VybmVsIG1vZHVsZXMgd291bGQgdGhlbiBkZXBlbmRzIG9uIGhhdmluZyB0aGUK
RXRoZXJuZXQgZHJpdmVyLCB1c2luZyBLY29uZmlnIHByaW1pdGl2ZXMuCgpUaGlzIGFsbCBhYm91
dCBuYW1pbmcsIG5vdCBhcmNoaXRlY3R1cmUuIFNwbGl0dGluZyBpdCB1cCBpbnRvIG11bHRpcGxl
Cmtlcm5lbCBtb2R1bGVzIGlzIGdvb2QsIGJ1dCB5b3VyIG5hbWluZyBhbmQgZGVzY3JpcHRpb25z
IG9mIHdoYXQgdGhlc2UKbW9kdWxlcyBkbyBtYXR0ZXJzLgoKIEFuZHJldwo=

