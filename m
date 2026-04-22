Return-Path: <netdev+bounces-280449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC0nOifo6Gl4RgIAu9opvQ
	(envelope-from <netdev+bounces-280449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:24:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7EE447DC0
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41B4E303C618
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB8E331203;
	Wed, 22 Apr 2026 15:19:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C0331F9BA
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871151; cv=none; b=h2GO22OlVsiSvJJewM+Z2p/CmxbkayjpMcgYH45Y04gIAc513MP6Uw/6Qxq2PomVX2xFUU151P1HscyKQv8IC1jN73JZhgz86fOf0mjGJUhCBeSQ4hNgv9+S7tf/dcInUbr+S/FD3OcqXyC1nnf+28p5aaLTibH7Ol5KGSm5crY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871151; c=relaxed/simple;
	bh=KcOM09OAYeH2X06YbRC5Fn+9HUrY0c5Om8BKRboIL5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S6ineSitWruZ3hRmE0vNCru8Sr/loZK81vZBaXemJ8/qSvbZLUxr75lTpBIIgwBJCuPOjqEPW6QBHSeLiMfwwvyy00pQ7rR0jcghAYNVyLm5fma3kBiME6Qii9aKfl66O7HXE72h3O/b2j8wlIbHpm+0nZF1s+yP4NUPa8dYNHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4g12ty3pvQz51SWQ;
	Wed, 22 Apr 2026 23:19:06 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
	by mse-fl1.zte.com.cn with SMTP id 63MFItNp036168;
	Wed, 22 Apr 2026 23:18:55 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
	by smtp (Zmail) with SMTP;
	Wed, 22 Apr 2026 23:18:59 +0800
X-Zmail-TransId: 3e8169e8e6cf007-7605c
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: han.junyang@zte.com.cn
From: Junyang Han <han.junyang@zte.com.cn>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, han.junyang@zte.com.cn,
        ran.ming@zte.com.cn, han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn
Subject: [PATCH net-next v2 0/3] Add ZTE DingHai Ethernet PF driver
Date: Wed, 22 Apr 2026 22:48:58 +0800
Message-ID: <20260422144901.2403456-1-han.junyang@zte.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 63MFItNp036168
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 22 Apr 2026 23:19:06 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69E8E6EA.001/4g12ty3pvQz51SWQ
X-Spamd-Result: default: False [3.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/related,multipart/alternative,text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[zte.com.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280449-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[han.junyang@zte.com.cn,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.923];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zte.com.cn:mid]
X-Rspamd-Queue-Id: 4E7EE447DC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VGhpcyBzZXJpZXMgYWRkcyBpbml0aWFsIHN1cHBvcnQgZm9yIHRoZSBaVEUgRGluZ0hhaSBFdGhl
cm5ldCBjb250cm9sbGVyLA0KYSBoaWdoLXBlcmZvcm1hbmNlIFBDSWUgRXRoZXJuZXQgZGV2aWNl
IHN1cHBvcnRpbmcgU1ItSU9WLCBoYXJkd2FyZQ0Kb2ZmbG9hZGluZywgYW5kIGFkdmFuY2VkIHZp
cnR1YWxpemF0aW9uIGZlYXR1cmVzLg0KDQpDaGFuZ2VzIGZyb20gdjEgKGFkZHJlc3NpbmcgZmVl
ZGJhY2sgZnJvbSBBbmRyZXdMdW5uKToNCi0gVXBkYXRlIGNvcHlyaWdodCB5ZWFycyB0byAyMDIy
LTIwMjYNCi0gUmVtb3ZlIERSVl9WRVJTSU9OLCBNT0RVTEVfVkVSU0lPTiBhbmQgcmVsYXRlZCBi
b2lsZXJwbGF0ZQ0KLSBGaXggTU9EVUxFX0FVVEhPUiB0byB1c2UgcGVyc29uIHdpdGggZW1haWwg
YWRkcmVzcw0KLSBVc2UgbW9kdWxlX3BjaV9kcml2ZXIoKSBpbnN0ZWFkIG9mIG1hbnVhbCBpbml0
L2V4aXQNCi0gUmVtb3ZlIGVtcHR5IHN1c3BlbmQvcmVzdW1lIGNhbGxiYWNrcw0KLSBSZXBsYWNl
IGNoYXIgcHJpdltdIGZsZXhpYmxlIGFycmF5IHdpdGggdm9pZCAqcHJpdiArIGt6YWxsb2MNCi0g
U3dpdGNoIGxvZ2dpbmcgZnJvbSBwcmludGsgd3JhcHBlcnMgdG8gZGV2XyooKSBiYXNlZCBtYWNy
b3MNCi0gUmVtb3ZlIGRoX2hlbHBlci5oIGFuZCBkaF9sb2cuYywgc2ltcGxpZnkgdG8gZGhfbG9n
Lmggb25seQ0KLSBGaXggdmFyaWFibGUgZGVjbGFyYXRpb24gb3JkZXJpbmcgKHJldmVyc2UgQ2hy
aXN0bWFzIHRyZWUpDQotIFJlbW92ZSB1bm5lY2Vzc2FyeSBOVUxMIGNoZWNrIGluIHJlbW92ZSBh
bmQgcGZfZGV2PU5VTEwgaW4gcHJvYmUNCi0gRml4IGluZGVudGF0aW9uIGFuZCByZW1vdmUgdW5u
ZWNlc3NhcnkgdHlwZSBjYXN0cw0KLSBVc2Uga2VybmVsIGlkaW9tYXRpYyAiaWYgKHJldCkiIHN0
eWxlDQoNClRoaXMgcGF0Y2ggc2VyaWVzIGlzIG9yZ2FuaXplZCBhcyBmb2xsb3dzOg0KLSBQYXRj
aCAxOiBBZGQgYmFzaWMgZHJpdmVyIGZyYW1ld29yayAoS2NvbmZpZy9NYWtlZmlsZSwgcHJvYmUv
cmVtb3ZlIHNrZWxldG9uKQ0KLSBQYXRjaCAyOiBBZGQgbG9nZ2luZyBpbmZyYXN0cnVjdHVyZSB1
c2luZyBrZXJuZWwgc3RhbmRhcmQgZGV2XyogbWFjcm9zDQotIFBhdGNoIDM6IEFkZCBoYXJkd2Fy
ZSByZWdpc3RlciBhY2Nlc3MgYW5kIFBDSSBjYXBhYmlsaXR5IHNjYW5uaW5nDQoNClRoaXMgaXMg
dGhlIGluaXRpYWwgc3VibWlzc2lvbiBhbmQgb25seSBpbmNsdWRlcyB0aGUgUEYgKFBoeXNpY2Fs
IEZ1bmN0aW9uKQ0KZHJpdmVyLiBUaGUgVkYgKFZpcnR1YWwgRnVuY3Rpb24pIGRyaXZlciB3aWxs
IGJlIHN1Ym1pdHRlZCBzZXBhcmF0ZWx5Lg0KDQpKdW55YW5nIEhhbiAoMyk6DQogIG5ldC9ldGhl
cm5ldDogYWRkIFpURSBuZXR3b3JrIGRyaXZlciBzdXBwb3J0DQogIG5ldC9ldGhlcm5ldC96dGUv
ZGluZ2hhaTogYWRkIGxvZ2dpbmcgaW5mcmFzdHJ1Y3R1cmUNCiAgbmV0L2V0aGVybmV0L3p0ZS9k
aW5naGFpOiBhZGQgaGFyZHdhcmUgcmVnaXN0ZXIgYWNjZXNzIGFuZCBQQ0kNCiAgICBjYXBhYmls
aXR5IHNjYW5uaW5nDQoNCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICA2ICsNCiBkcml2ZXJzL25ldC9ldGhlcm5ldC9LY29uZmlnICAgICAgICAgICAgICAg
IHwgICAxICsNCiBkcml2ZXJzL25ldC9ldGhlcm5ldC9NYWtlZmlsZSAgICAgICAgICAgICAgIHwg
ICAxICsNCiBkcml2ZXJzL25ldC9ldGhlcm5ldC96dGUvS2NvbmZpZyAgICAgICAgICAgIHwgIDIw
ICsNCiBkcml2ZXJzL25ldC9ldGhlcm5ldC96dGUvTWFrZWZpbGUgICAgICAgICAgIHwgICA2ICsN
CiBkcml2ZXJzL25ldC9ldGhlcm5ldC96dGUvZGluZ2hhaS9LY29uZmlnICAgIHwgIDM0ICsrDQog
ZHJpdmVycy9uZXQvZXRoZXJuZXQvenRlL2RpbmdoYWkvTWFrZWZpbGUgICB8ICAxMCArDQogZHJp
dmVycy9uZXQvZXRoZXJuZXQvenRlL2RpbmdoYWkvZGhfbG9nLmggICB8ICA2MCArKw0KIGRyaXZl
cnMvbmV0L2V0aGVybmV0L3p0ZS9kaW5naGFpL2RoX3F1ZXVlLmggfCAgNzEgKysrDQogZHJpdmVy
cy9uZXQvZXRoZXJuZXQvenRlL2RpbmdoYWkvZW5fcGYuYyAgICB8IDYwNSArKysrKysrKysrKysr
KysrKysrKw0KIGRyaXZlcnMvbmV0L2V0aGVybmV0L3p0ZS9kaW5naGFpL2VuX3BmLmggICAgfCAx
MDAgKysrKw0KIDExIGZpbGVzIGNoYW5nZWQsIDkxNCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L2V0aGVybmV0L3p0ZS9LY29uZmlnDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvbmV0L2V0aGVybmV0L3p0ZS9NYWtlZmlsZQ0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL25ldC9ldGhlcm5ldC96dGUvZGluZ2hhaS9LY29uZmlnDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L2V0aGVybmV0L3p0ZS9kaW5naGFpL01ha2VmaWxlDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L2V0aGVybmV0L3p0ZS9kaW5naGFpL2RoX2xvZy5o
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L2V0aGVybmV0L3p0ZS9kaW5naGFpL2Ro
X3F1ZXVlLmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvZXRoZXJuZXQvenRlL2Rp
bmdoYWkvZW5fcGYuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9ldGhlcm5ldC96
dGUvZGluZ2hhaS9lbl9wZi5oDQoNCi0tIA0KMi4yNy4w


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VGhpcyZuYnNwO3NlcmllcyZuYnNwO2FkZHMmbmJzcDtpbml0aWFsJm5ic3A7c3VwcG9ydCZuYnNw
O2ZvciZuYnNwO3RoZSZuYnNwO1pURSZuYnNwO0RpbmdIYWkmbmJzcDtFdGhlcm5ldCZuYnNwO2Nv
bnRyb2xsZXIsPGJyIC8+YSZuYnNwO2hpZ2gtcGVyZm9ybWFuY2UmbmJzcDtQQ0llJm5ic3A7RXRo
ZXJuZXQmbmJzcDtkZXZpY2UmbmJzcDtzdXBwb3J0aW5nJm5ic3A7U1ItSU9WLCZuYnNwO2hhcmR3
YXJlPGJyIC8+b2ZmbG9hZGluZywmbmJzcDthbmQmbmJzcDthZHZhbmNlZCZuYnNwO3ZpcnR1YWxp
emF0aW9uJm5ic3A7ZmVhdHVyZXMuPGJyIC8+DTxiciAvPkNoYW5nZXMmbmJzcDtmcm9tJm5ic3A7
djEmbmJzcDsoYWRkcmVzc2luZyZuYnNwO2ZlZWRiYWNrJm5ic3A7ZnJvbSZuYnNwO0FuZHJld0x1
bm4pOjxiciAvPi0mbmJzcDtVcGRhdGUmbmJzcDtjb3B5cmlnaHQmbmJzcDt5ZWFycyZuYnNwO3Rv
Jm5ic3A7MjAyMi0yMDI2PGJyIC8+LSZuYnNwO1JlbW92ZSZuYnNwO0RSVl9WRVJTSU9OLCZuYnNw
O01PRFVMRV9WRVJTSU9OJm5ic3A7YW5kJm5ic3A7cmVsYXRlZCZuYnNwO2JvaWxlcnBsYXRlPGJy
IC8+LSZuYnNwO0ZpeCZuYnNwO01PRFVMRV9BVVRIT1ImbmJzcDt0byZuYnNwO3VzZSZuYnNwO3Bl
cnNvbiZuYnNwO3dpdGgmbmJzcDtlbWFpbCZuYnNwO2FkZHJlc3M8YnIgLz4tJm5ic3A7VXNlJm5i
c3A7bW9kdWxlX3BjaV9kcml2ZXIoKSZuYnNwO2luc3RlYWQmbmJzcDtvZiZuYnNwO21hbnVhbCZu
YnNwO2luaXQvZXhpdDxiciAvPi0mbmJzcDtSZW1vdmUmbmJzcDtlbXB0eSZuYnNwO3N1c3BlbmQv
cmVzdW1lJm5ic3A7Y2FsbGJhY2tzPGJyIC8+LSZuYnNwO1JlcGxhY2UmbmJzcDtjaGFyJm5ic3A7
cHJpdltdJm5ic3A7ZmxleGlibGUmbmJzcDthcnJheSZuYnNwO3dpdGgmbmJzcDt2b2lkJm5ic3A7
KnByaXYmbmJzcDsrJm5ic3A7a3phbGxvYzxiciAvPi0mbmJzcDtTd2l0Y2gmbmJzcDtsb2dnaW5n
Jm5ic3A7ZnJvbSZuYnNwO3ByaW50ayZuYnNwO3dyYXBwZXJzJm5ic3A7dG8mbmJzcDtkZXZfKigp
Jm5ic3A7YmFzZWQmbmJzcDttYWNyb3M8YnIgLz4tJm5ic3A7UmVtb3ZlJm5ic3A7ZGhfaGVscGVy
LmgmbmJzcDthbmQmbmJzcDtkaF9sb2cuYywmbmJzcDtzaW1wbGlmeSZuYnNwO3RvJm5ic3A7ZGhf
bG9nLmgmbmJzcDtvbmx5PGJyIC8+LSZuYnNwO0ZpeCZuYnNwO3ZhcmlhYmxlJm5ic3A7ZGVjbGFy
YXRpb24mbmJzcDtvcmRlcmluZyZuYnNwOyhyZXZlcnNlJm5ic3A7Q2hyaXN0bWFzJm5ic3A7dHJl
ZSk8YnIgLz4tJm5ic3A7UmVtb3ZlJm5ic3A7dW5uZWNlc3NhcnkmbmJzcDtOVUxMJm5ic3A7Y2hl
Y2smbmJzcDtpbiZuYnNwO3JlbW92ZSZuYnNwO2FuZCZuYnNwO3BmX2Rldj1OVUxMJm5ic3A7aW4m
bmJzcDtwcm9iZTxiciAvPi0mbmJzcDtGaXgmbmJzcDtpbmRlbnRhdGlvbiZuYnNwO2FuZCZuYnNw
O3JlbW92ZSZuYnNwO3VubmVjZXNzYXJ5Jm5ic3A7dHlwZSZuYnNwO2Nhc3RzPGJyIC8+LSZuYnNw
O1VzZSZuYnNwO2tlcm5lbCZuYnNwO2lkaW9tYXRpYyZuYnNwOyZxdW90O2lmJm5ic3A7KHJldCkm
cXVvdDsmbmJzcDtzdHlsZTxiciAvPg08YnIgLz5UaGlzJm5ic3A7cGF0Y2gmbmJzcDtzZXJpZXMm
bmJzcDtpcyZuYnNwO29yZ2FuaXplZCZuYnNwO2FzJm5ic3A7Zm9sbG93czo8YnIgLz4tJm5ic3A7
UGF0Y2gmbmJzcDsxOiZuYnNwO0FkZCZuYnNwO2Jhc2ljJm5ic3A7ZHJpdmVyJm5ic3A7ZnJhbWV3
b3JrJm5ic3A7KEtjb25maWcvTWFrZWZpbGUsJm5ic3A7cHJvYmUvcmVtb3ZlJm5ic3A7c2tlbGV0
b24pPGJyIC8+LSZuYnNwO1BhdGNoJm5ic3A7MjombmJzcDtBZGQmbmJzcDtsb2dnaW5nJm5ic3A7
aW5mcmFzdHJ1Y3R1cmUmbmJzcDt1c2luZyZuYnNwO2tlcm5lbCZuYnNwO3N0YW5kYXJkJm5ic3A7
ZGV2XyombmJzcDttYWNyb3M8YnIgLz4tJm5ic3A7UGF0Y2gmbmJzcDszOiZuYnNwO0FkZCZuYnNw
O2hhcmR3YXJlJm5ic3A7cmVnaXN0ZXImbmJzcDthY2Nlc3MmbmJzcDthbmQmbmJzcDtQQ0kmbmJz
cDtjYXBhYmlsaXR5Jm5ic3A7c2Nhbm5pbmc8YnIgLz4NPGJyIC8+VGhpcyZuYnNwO2lzJm5ic3A7
dGhlJm5ic3A7aW5pdGlhbCZuYnNwO3N1Ym1pc3Npb24mbmJzcDthbmQmbmJzcDtvbmx5Jm5ic3A7
aW5jbHVkZXMmbmJzcDt0aGUmbmJzcDtQRiZuYnNwOyhQaHlzaWNhbCZuYnNwO0Z1bmN0aW9uKTxi
ciAvPmRyaXZlci4mbmJzcDtUaGUmbmJzcDtWRiZuYnNwOyhWaXJ0dWFsJm5ic3A7RnVuY3Rpb24p
Jm5ic3A7ZHJpdmVyJm5ic3A7d2lsbCZuYnNwO2JlJm5ic3A7c3VibWl0dGVkJm5ic3A7c2VwYXJh
dGVseS48YnIgLz4NPGJyIC8+SnVueWFuZyZuYnNwO0hhbiZuYnNwOygzKTo8YnIgLz4mbmJzcDsm
bmJzcDtuZXQvZXRoZXJuZXQ6Jm5ic3A7YWRkJm5ic3A7WlRFJm5ic3A7bmV0d29yayZuYnNwO2Ry
aXZlciZuYnNwO3N1cHBvcnQ8YnIgLz4mbmJzcDsmbmJzcDtuZXQvZXRoZXJuZXQvenRlL2Rpbmdo
YWk6Jm5ic3A7YWRkJm5ic3A7bG9nZ2luZyZuYnNwO2luZnJhc3RydWN0dXJlPGJyIC8+Jm5ic3A7
Jm5ic3A7bmV0L2V0aGVybmV0L3p0ZS9kaW5naGFpOiZuYnNwO2FkZCZuYnNwO2hhcmR3YXJlJm5i
c3A7cmVnaXN0ZXImbmJzcDthY2Nlc3MmbmJzcDthbmQmbmJzcDtQQ0k8YnIgLz4mbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDtjYXBhYmlsaXR5Jm5ic3A7c2Nhbm5pbmc8YnIgLz4NPGJyIC8+Jm5ic3A7
TUFJTlRBSU5FUlMmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7
NiZuYnNwOys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC9ldGhlcm5ldC9LY29uZmlnJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOzEmbmJzcDsr
PGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvZXRoZXJuZXQvTWFrZWZpbGUmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7MSZuYnNwOys8YnIgLz4mbmJzcDtk
cml2ZXJzL25ldC9ldGhlcm5ldC96dGUvS2NvbmZpZyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJz
cDsyMCZuYnNwOys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC9ldGhlcm5ldC96dGUvTWFrZWZpbGUm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7NiZuYnNwOys8YnIgLz4mbmJzcDtkcml2ZXJzL25l
dC9ldGhlcm5ldC96dGUvZGluZ2hhaS9LY29uZmlnJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZu
YnNwOyZuYnNwOzM0Jm5ic3A7Kys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC9ldGhlcm5ldC96dGUv
ZGluZ2hhaS9NYWtlZmlsZSZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsxMCZuYnNwOys8
YnIgLz4mbmJzcDtkcml2ZXJzL25ldC9ldGhlcm5ldC96dGUvZGluZ2hhaS9kaF9sb2cuaCZuYnNw
OyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDs2MCZuYnNwOysrPGJyIC8+Jm5ic3A7ZHJpdmVycy9u
ZXQvZXRoZXJuZXQvenRlL2RpbmdoYWkvZGhfcXVldWUuaCZuYnNwO3wmbmJzcDsmbmJzcDs3MSZu
YnNwOysrKzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L2V0aGVybmV0L3p0ZS9kaW5naGFpL2VuX3Bm
LmMmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7NjA1Jm5ic3A7KysrKysrKysrKysrKysr
KysrKys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC9ldGhlcm5ldC96dGUvZGluZ2hhaS9lbl9wZi5o
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOzEwMCZuYnNwOysrKys8YnIgLz4mbmJzcDsx
MSZuYnNwO2ZpbGVzJm5ic3A7Y2hhbmdlZCwmbmJzcDs5MTQmbmJzcDtpbnNlcnRpb25zKCspPGJy
IC8+Jm5ic3A7Y3JlYXRlJm5ic3A7bW9kZSZuYnNwOzEwMDY0NCZuYnNwO2RyaXZlcnMvbmV0L2V0
aGVybmV0L3p0ZS9LY29uZmlnPGJyIC8+Jm5ic3A7Y3JlYXRlJm5ic3A7bW9kZSZuYnNwOzEwMDY0
NCZuYnNwO2RyaXZlcnMvbmV0L2V0aGVybmV0L3p0ZS9NYWtlZmlsZTxiciAvPiZuYnNwO2NyZWF0
ZSZuYnNwO21vZGUmbmJzcDsxMDA2NDQmbmJzcDtkcml2ZXJzL25ldC9ldGhlcm5ldC96dGUvZGlu
Z2hhaS9LY29uZmlnPGJyIC8+Jm5ic3A7Y3JlYXRlJm5ic3A7bW9kZSZuYnNwOzEwMDY0NCZuYnNw
O2RyaXZlcnMvbmV0L2V0aGVybmV0L3p0ZS9kaW5naGFpL01ha2VmaWxlPGJyIC8+Jm5ic3A7Y3Jl
YXRlJm5ic3A7bW9kZSZuYnNwOzEwMDY0NCZuYnNwO2RyaXZlcnMvbmV0L2V0aGVybmV0L3p0ZS9k
aW5naGFpL2RoX2xvZy5oPGJyIC8+Jm5ic3A7Y3JlYXRlJm5ic3A7bW9kZSZuYnNwOzEwMDY0NCZu
YnNwO2RyaXZlcnMvbmV0L2V0aGVybmV0L3p0ZS9kaW5naGFpL2RoX3F1ZXVlLmg8YnIgLz4mbmJz
cDtjcmVhdGUmbmJzcDttb2RlJm5ic3A7MTAwNjQ0Jm5ic3A7ZHJpdmVycy9uZXQvZXRoZXJuZXQv
enRlL2RpbmdoYWkvZW5fcGYuYzxiciAvPiZuYnNwO2NyZWF0ZSZuYnNwO21vZGUmbmJzcDsxMDA2
NDQmbmJzcDtkcml2ZXJzL25ldC9ldGhlcm5ldC96dGUvZGluZ2hhaS9lbl9wZi5oPGJyIC8+DTxi
ciAvPi0tJm5ic3A7DTxiciAvPjIuMjcuMDxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


