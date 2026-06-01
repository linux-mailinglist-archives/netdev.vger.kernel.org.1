Return-Path: <netdev+bounces-293494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DPmAjTrHGpWUAkAu9opvQ
	(envelope-from <netdev+bounces-293494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:15:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F80618C74
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A69F3004609
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 02:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33F2222582;
	Mon,  1 Jun 2026 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="YDhY5tCu"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55DC1A6835;
	Mon,  1 Jun 2026 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780280111; cv=none; b=IigtTbIYe8iyURIYnjkI4we6gGw+Qkk1u+CaLFrNiGq7Px1Wi7jRTZOcBh61zXVPi3AASFIcsVNQe4JhbgFlJcJa5j2br2xQmHnIM9V3nQjzKK6kHnn7i+Dsx9pRq5/OZv0xLi2V7yutarB146TUuaAwqEVfhsllJ1E0lGVQMAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780280111; c=relaxed/simple;
	bh=vBbaaEjFOnXhitNt7LzQ5hS8RgvQDadVLzxxzFUfcQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ziq0Vesz/PvoxVeKSGKPz7epZv+33DAqgs71ceuwksh/boYITWNupRfjJnFZfiMe5GED9L7PbLWDXpeA7xHDNmfAV4hTj0Ak6X0eWxJT9A21cJTWSDDVQsVt1hfmiQPTsfjaiezgwf6Jc9/jCGcD/QTNdIvCRW0UiyodD3fD9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=YDhY5tCu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6512EX9001735502, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780280073;
	bh=vBbaaEjFOnXhitNt7LzQ5hS8RgvQDadVLzxxzFUfcQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YDhY5tCu05Yd5lXlkCPiHnAcSZjgLQoBPRzW2uL1tXxqoAcVBfwC6z/utiZgzOkOr
	 NnljIkouQ0hKVmP48xtwerVMQsuDaaro5hQ7jzIgnje2Kb3YoU0xPj41MylDe24CoO
	 dQvS6aSBJVbQOSAosSYGbJ8CiV3Y1Oeh8DIPBfnuxIWZ452Zv37ZHbycRyTJzaSrYp
	 nJ9pIBUGgszDY7zXgYjXmLUqZzei8J3HIuPRBjBcW8O+n6KyNN9xvazvb/1k8E9SsB
	 sM0lvYyHg6zjnuc8nLpnQTkVbZUVz042aCgqndecrkCxeU6fTg4HdIvji0+JZIwYG0
	 ctQWTOSMN0hew==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6512EX9001735502
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jun 2026 10:14:33 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Jun 2026 10:14:32 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Mon,
 1 Jun 2026 10:14:32 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Javen <javen_xu@realsil.com.cn>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch net-next v6 0/7] r8169: add RSS support for RTL8127
Thread-Topic: [Patch net-next v6 0/7] r8169: add RSS support for RTL8127
Thread-Index: AQHc7Oc7b+/bcfnzn0W+sF0ogwBvf7Yo/aKA
Date: Mon, 1 Jun 2026 02:14:32 +0000
Message-ID: <afe8ebc060724eab9619fe237e703d96@realsil.com.cn>
References: <20260526081117.173-1-javen_xu@realsil.com.cn>
In-Reply-To: <20260526081117.173-1-javen_xu@realsil.com.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293494-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 65F80618C74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PlRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgUlNTIChSZWNlaXZlIFNpZGUgU2NhbGluZykgc3VwcG9y
dCBmb3IgdGhlIHI4MTY5DQo+ZXRoZXJuZXQgZHJpdmVyLCBzcGVjaWZpY2FsbHkgZm9yIFJUTDgx
MjcgKFJUTF9HSUdBX01BQ19WRVJfODApLg0KPg0KPlJTUyBlbmFibGVzIHBhY2tldCBkaXN0cmli
dXRpb24gYWNyb3NzIG11bHRpcGxlIHJlY2VpdmUgcXVldWVzLCB3aGljaCBjYW4NCj5zaWduaWZp
Y2FudGx5IGltcHJvdmUgbmV0d29yayB0aHJvdWdocHV0IG9uIG11bHRpLWNvcmUgc3lzdGVtcyBi
eSBhbGxvd2luZw0KPnBhcmFsbGVsIHByb2Nlc3Npbmcgb2YgaW5jb21pbmcgcGFja2V0cy4NCj4N
Cj5LZXkgZmVhdHVyZXM6DQo+LSBNdWx0aS1xdWV1ZSBSWCBzdXBwb3J0ICh1cCB0byA4IHF1ZXVl
cykNCj4tIE1TSS1YIGludGVycnVwdCB3aXRoIHZlY3RvciBtYXBwaW5nDQo+LSBEeW5hbWljIHF1
ZXVlIGNvbmZpZ3VyYXRpb24gdmlhIGV0aHRvb2wgKC1MKQ0KPi0gUlNTIGhhc2ggY29tcHV0YXRp
b24gZm9yIGZsb3cgY2xhc3NpZmljYXRpb24NCj4NCkhpLCBIZWluZXINCg0KQSBnZW50bGUgcGlu
ZyBvbiB0aGlzIHY2IHBhdGNoLg0KDQpJIGhhdmUgcmVjZWl2ZWQgc29tZSBmZWVkYmFjayBmcm9t
IG90aGVyIHJldmlld2VycyAoYW5kIEFJIGJvdCkgZHVyaW5nIHRoaXMgd2VlaywgYW5kIEkgaGF2
ZSBhbHJlYWR5IGFkZHJlc3NlZCB0aG9zZSBjb21tZW50cyBsb2NhbGx5Lg0KDQpCZWZvcmUgSSBz
ZW5kIG91dCB0aGUgdjcgcGF0Y2hzZXQsIEkgd2FudGVkIHRvIGtpbmRseSBjaGVjayBpZiB5b3Ug
aGF2ZSBhbnkgYWRkaXRpb25hbCBjb21tZW50cyBvbiB0aGlzIHY2PyBPciB3b3VsZCB5b3UgcHJl
ZmVyIG1lIHRvIHNlbmQgb3V0IHY3IGRpcmVjdGx5IHdpdGggdGhlIGN1cnJlbnQgZml4ZXMgc28g
eW91IGNhbiByZXZpZXcgdGhlIGxhdGVzdCB2ZXJzaW9uPw0KDQpUaGFua3MgZm9yIHlvdXIgdGlt
ZSBhbmQgaGVscCENCg0KQmVzdCByZWdhcmRzLA0KSmF2ZW4NCg==

