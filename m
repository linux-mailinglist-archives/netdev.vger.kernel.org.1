Return-Path: <netdev+bounces-257024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPnGE5NLhGm82QMAu9opvQ
	(envelope-from <netdev+bounces-257024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:49:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C04EF95F
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D89EA30028DD
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8319A35F8A3;
	Thu,  5 Feb 2026 07:49:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837743346A7;
	Thu,  5 Feb 2026 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277774; cv=none; b=aC/a2tqRzfwi4SLMaIBu8fshFQmOif5GSVWzHS4JZvzBBwGfZ4mltmtIphq95+p00HvZjcERqHZ9GriLZLl3WcJyiro/ImfK6JZVTCpXBNr76oUZjZ8IGzCo41I8dwNcFaFguoOrv2wGk0BOHukO/ubSOJgzjGSls6fUbiOeE3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277774; c=relaxed/simple;
	bh=sVG8Ff/Lzz8oJVmiWQHSi5Aqdd0DiXFtwU8U854bZmw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hj6I+K0jNeZUouIADgjfO7PRiViycBbxQor4BjMCmGNVbjcK0RtIVeHPELwMWWYOmNp3Vy8WzlnJIrfYDclY3VWLm8pwfWBh5q8tYmUuxHh3rrFYHeXMccBqrHtEmHwoCT31M7i6AnUjOc3ZO4ojFdX5AHRKkfuJFtzIwpmNnHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"oss-drivers@corigine.com" <oss-drivers@corigine.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXVtuZXQtbmV4dF0gbmZwOiBmbG93ZXI6IHVzZSBHRlBf?=
 =?gb2312?Q?KERNEL_in_idr=5Fpreload?=
Thread-Topic: [PATCH][net-next] nfp: flower: use GFP_KERNEL in idr_preload
Thread-Index: AQHclmSdzpkzvQ/0x0C34wLNFJ+O+bVzue0A
Date: Thu, 5 Feb 2026 07:48:56 +0000
Message-ID: <3a6e0cf4cd0e445ebd344537f80a1aff@baidu.com>
References: <20260205055933.3939-1-lirongqing@baidu.com>
In-Reply-To: <20260205055933.3939-1-lirongqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.3.14
X-FE-Policy-ID: 52:10:53:SYSTEM
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.64 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[baidu.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257024-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61C04EF95F
X-Rspamd-Action: no action

PiANCj4gRnJvbTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiANCj4gaWRy
X3ByZWxvYWQoKSBpcyBjYWxsZWQgaW4gYSBzbGVlcGFibGUgY29udGV4dCBiZWZvcmUgYWNxdWly
aW5nIGEgc3BpbmxvY2suIENoYW5nZQ0KPiB0aGUgYWxsb2NhdGlvbiBmbGFnIGZyb20gR0ZQX0FU
T01JQyB0byBHRlBfS0VSTkVMIHRvIGFsbG93IGRpcmVjdCByZWNsYWltDQo+IGFuZCBpbXByb3Zl
IGFsbG9jYXRpb24gc3VjY2VzcyByYXRlIHVuZGVyIG1lbW9yeSBwcmVzc3VyZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IExpIFJvbmdRaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9uZXRyb25vbWUvbmZwL2Zsb3dlci9tYWluLmMgfCAyICst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9uZXRyb25vbWUvbmZwL2Zsb3dlci9t
YWluLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9uZXRyb25vbWUvbmZwL2Zsb3dlci9tYWlu
LmMNCj4gaW5kZXggODNlYWE1YS4uOGYyMzJjNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbmV0cm9ub21lL25mcC9mbG93ZXIvbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L25ldHJvbm9tZS9uZnAvZmxvd2VyL21haW4uYw0KPiBAQCAtNjMsNyArNjMsNyBA
QCBuZnBfZmxvd2VyX2dldF9pbnRlcm5hbF9wb3J0X2lkKHN0cnVjdCBuZnBfYXBwICphcHAsDQo+
IHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYpDQo+ICAJaWYgKGlkID4gMCkNCj4gIAkJcmV0dXJu
IGlkOw0KPiANCj4gLQlpZHJfcHJlbG9hZChHRlBfQVRPTUlDKTsNCj4gKwlpZHJfcHJlbG9hZChH
RlBfS0VSTkVMKTsNCj4gIAlzcGluX2xvY2tfYmgoJnByaXYtPmludGVybmFsX3BvcnRzLmxvY2sp
Ow0KPiAgCWlkID0gaWRyX2FsbG9jKCZwcml2LT5pbnRlcm5hbF9wb3J0cy5wb3J0X2lkcywgbmV0
ZGV2LA0KPiAgCQkgICAgICAgTkZQX01JTl9JTlRfUE9SVF9JRCwgTkZQX01BWF9JTlRfUE9SVF9J
RCwNCj4gR0ZQX0FUT01JQyk7DQo+IC0tDQo+IDIuOS40DQoNCg0KU29ycnksIHBsZWFzZSBkcm9w
IHRoaXMgcGF0Y2gsOw0KDQpuZnBfZmxvd2VyX2dldF9pbnRlcm5hbF9wb3J0X2lkKCkgbWF5YmUg
YmUgY2FsbGVkIGluIHN5c3RlbV9oaWdocHJpX3dxIHdvcmtxdWV1ZSwgc28gR0ZQX0FUT01JQyBp
cyByaWdodA0KDQpbTGksUm9uZ3FpbmddDQoNCg==

