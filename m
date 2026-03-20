Return-Path: <netdev+bounces-269776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEsPHyS+vGlz2gIAu9opvQ
	(envelope-from <netdev+bounces-269776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 04:25:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D30752D590C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 04:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C46A3005790
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 03:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA6F1C84A0;
	Fri, 20 Mar 2026 03:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="LTLRhfIV"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7DD233134
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 03:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773977010; cv=none; b=TnPy642GIrR6FdCvXFeF0/AsDY6SaK0hGjWPlR4ysgdKeFDfFtgYFihn872K63+h59+3R3kt67MupVg2IW7hFBA4kWO5A3VK7x0KgrkQfYSQJZif2QWlaCiNn2NIEwl1Nt582bZe60Xf+cIvr0WmTlJN3f6xRI/NGiF4aV3CMF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773977010; c=relaxed/simple;
	bh=U43YQCKyx3qzYXh+/asv44d6JAJ+q7AfA96CcJyGrpM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rWw4QVpSUkdWI5lkcTeYsalXHtpkK6bxsCYTMaNQEkthZJR85/CHfQikLSOCO54f8RVoPWf/5+7c5O/WvFvKhGH0T81DzW9oEbYBtcwjNYiCfcqMgEsXzznDIL+ktjceoqQ/oqkEUM92GmlLW9tXcy8XVsrvEqTy7knu72bp1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=LTLRhfIV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62K3Mqs06739091, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1773976972;
	bh=U43YQCKyx3qzYXh+/asv44d6JAJ+q7AfA96CcJyGrpM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LTLRhfIVO3HIgSuiB2FK9IfdPBLHCEyuBK5eO4rHfeaSRtcC+DzMLXAZZXbHo5T9a
	 CLRmUauzc1/ZRNYX8ju7PE/gMIoToV5b/9T8o5ScsQBK4Lz1WkcgeNbEJNnEInfRGN
	 Si8xajEdw/fAnrooxUaEBjUf8lWYPeS4qbt+zdYqwH3/RDXdpgjouP3IM5vBSFXBo1
	 MN7bMwWvEYcF4oMOJYdFdjrXiU+69ISLS+wYiZ1CT8vh7YRWZ9IbFitA0oMWjoQXM6
	 ix7zWMUTO+99XFQLFsH0NpL3zaQnfdBlcv/kj6p7tmil7VPYNYHeSOxibNi03dK5a1
	 i4g8uznClWKcg==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62K3Mqs06739091
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Mar 2026 11:22:52 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 20 Mar 2026 11:22:52 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Fri,
 20 Mar 2026 11:22:52 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Heiner Kallweit <hkallweit1@gmail.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: r8169: Discussion on implementing RSS support for r8169
Thread-Topic: r8169: Discussion on implementing RSS support for r8169
Thread-Index: Ady3flT6SLXoIWu3RPmeYPmtdnYmcQAGZGOAAB+EdyA=
Date: Fri, 20 Mar 2026 03:22:52 +0000
Message-ID: <86784e19c4504c3ba49a9299701a2c1f@realsil.com.cn>
References: <1ce3478d571f4d26a45e792c4c84c429@realsil.com.cn>
 <e063ce5f-1789-49d0-880c-e4b6a40da9e1@gmail.com>
In-Reply-To: <e063ce5f-1789-49d0-880c-e4b6a40da9e1@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269776-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: D30752D590C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pk9uIDE5LjAzLjIwMjYgMDk6NTYsIEphdmVuIHdyb3RlOg0KPj4gSGksIEhlaW5lcg0KPj4NCj4+
IFdlIGFyZSBub3cgcGxhbm5pbmcgdG8gaW1wbGVtZW50IFJTUyBzdXBwb3J0IG9uIHI4MTY5IGRy
aXZlci4gVGhpcyB3aWxsDQo+cmVxdWlyZSBzaWduaWZpY2FudCBjaGFuZ2VzIHRvIHRoZSBleGlz
dGluZyBkcml2ZXIgYXJjaGl0ZWN0dXJlLCBzbyB3ZSB3YW50IHRvDQo+ZGlzY3VzcyBpdCB3aXRo
IHlvdS4NCj4+DQo+VGhhbmtzIGZvciB0aGUgcXVlc3Rpb24uDQo+SSBhbHNvIG9uY2UgY29uc2lk
ZXJlZCB0aGlzLCBidXQgZGVjaWRlZCBhZ2FpbnN0IGl0LCBhcyBJIGRpZG4ndCBzZWUgZW5vdWdo
DQo+YmVuZWZpdCBqdXN0aWZ5aW5nIHRoZSBzaWduaWZpY2FudGx5IGluY3JlYXNlZCBjb21wbGV4
aXR5IG9mIHRoZSBkcml2ZXIuIEV2ZW4NCj53aXRoIGEgTjEwMC1iYXNlZCBtaW5pLXBjIEkgY2Fu
IGVhc2lseSBzYXR1cmF0ZSBhIDIuNUdicHMgbGluayB3aXRoIHRoZSBkcml2ZXINCj5hcy1pcy4N
Cj5Bbnkgc3BlY2lmaWMgcmVhc29uIHdoeSB5b3UgY29uc2lkZXIgYWRkaW5nIFJTUyBzdXBwb3J0
PyBXb3VsZCBiZSBnb29kIHRvDQo+c2VlIGEgcGVyZm9ybWFuY2UgY29tcGFyaXNvbiBhcyBiYXNp
cyBmb3IgYSBkZWNpc2lvbiBvbiBmb3Igd2hpY2ggY2hpcA0KPnZlcnNpb25zIFJTUyBtYXkgcHJv
dmlkZSBhIHNpZ25pZmljYW50IGJlbmVmaXQuDQo+DQoNClRoZSBwcmltYXJ5IGJlbmVmdCBvZiBh
ZGRpbmcgcnNzIGhlcmUgaXMgdG8gcmVkdWNlIGNwdSBsb2FkIHBlciBjb3JlLg0KDQpTaW5jZSBJ
IGN1cnJlbnRseSBvbmx5IGhhdmUgb25lIFJUTDgxMTFlcCBhbmQgb25lIFJUTDgxMjcsIEknbSBn
b2luZyB0byBkbyBhIHNpbXBsZSB0ZXN0Lg0KDQpCYXNlZCBvbiBteSBpcGVyZiB0ZXN0IGZyb20g
UlRMODExMWVwIHRvIFJUTDgxMjc6DQoJMS4gV2l0aCByc3M6IGNwdSBsb2FkIGlzIGRpc3RyaWJ1
dGVkIGFjcm9zcyA0IGNvcmVzKDElIH4gMiUgZWFjaCkNCgkyLiBXaXRob3V0IHJzczogY3B1IGxv
YWQgaXMgY29uY2VudHJhdGVkIG9uIGEgc2luZ2xlIGNvcmUoNyUgfiA4JSkNCg0KSWYgdGVzdCBm
cm9tIFJUTDgxMjcgdG8gUlRMODEyNywgZXNwZWNpYWxseSBvbiBwbGF0Zm9ybXMgd2l0aCB3ZWFr
ZXIgY3B1LCBkaXNhYmxpbmcgcnNzIHdpbGwgZWFzaWx5IGxlYWQgdG8gY3B1IG92ZXJsb2FkLiAN
ClRoYXQncyB0aGUgbWFpbiByZWFzb24gd2UgY29uc2lkZXIgYWRkaW5nIHJzcyBzdXBwb3J0IGZv
ciBSVEw4MTI3Lg0KDQpJIHdpbGwgc2hvdyB0aGUgcmVzdWx0IGZyb20gUlRMODEyNyB0byBSVEw4
MTI3IHdoZW4gSSBzdWJtaXQgcnNzIHBhdGNoLg0KDQpUaGFua3MsDQpKYXZlbiBYdQ0KDQo+PiBC
YXNlZCBvbiBvdXIgdmVuZG9yIGRyaXZlciB3aGljaCBjYW4gYmUgZmV0Y2hlZCBmcm9tIFJlYWx0
ZWssIHRoZSBrZXkNCj5tb2RpZmljYXRpb25zIHdpbGwgaW5jbHVkZToNCj4+DQo+PiAgICAgICAx
LiBFbmFibGUgbXNpeCBhbmQgdXBkYXRpbmcgdGhlIGlycSBhbGxvY2F0aW9uIG1lY2hhbmlzbQ0K
Pj4gICAgICAgMi4gU3VwcG9ydCBtdWx0aXBsZSByeC90eCBxdWV1ZXMNCj4+ICAgICAgIDMuIFJl
Z2lzdGVyIG11bHRpcGxlIG5hcGkgYW5kIHVwZGF0ZSBuZXcgaW50ZXJydXB0IG1hcHBpbmcoaXNy
L2ltcikgZm9yDQo+bXVsdGktcXVldWUNCj4+ICAgICAgIDQuIEltcGxlbWVudCByeCBtc2l4IHBv
bGwgYW5kIHJ4IGludGVycnVwdCBmdW5jdGlvbg0KPj4gICAgICAgNS4gSW1wbGVtZW50IGV0aHRv
b2wgY2FsbGJhY2tzIGZvciByc3MgY29uZmlndXJhdGlvbg0KPj4NCj4+IFNob3VsZCB3ZSBzdWJt
aXQgdGhlIGNoYW5nZXMgYWJvdmUgc2VwYXJhdGVseSBvciBzdWJtaXQgdGhlbSBhbGwgYXQgb25j
ZT8NCj5PciBkbyB5b3UgaGF2ZSBhbnkgb3RoZXIgc3VnZ2VzdGlvbnM/DQo+Pg0KPkFzIEFuZHJl
dyBhbHJlYWR5IHNhaWQsIHBsZWFzZSBzdWJtaXQgdGhlIHBhdGNoZXMgaW4gc21hbGxlciwgcmV2
aWV3YWJsZSwNCj5jaHVua3MuDQo+QmVzdCB0YWdnZWQgYXMgUkZDLg0KPg0KPj4gV2Ugd2FudCB0
byBhbGlnbiB3aXRoIHlvdSBvbiB0aGUgZGV2ZWxvcG1lbnQgYW5kIHN1Ym1pc3Npb24gYXBwcm9h
Y2guDQo+Pg0KPj4gQmVzdCByZWdhcmRzLA0KPj4NCj4+IEphdmVuIFh1DQo+DQo+SGVpbmVyDQo=

