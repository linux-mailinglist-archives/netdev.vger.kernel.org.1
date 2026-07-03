Return-Path: <netdev+bounces-304439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4nt8E2luR2rEYAAAu9opvQ
	(envelope-from <netdev+bounces-304439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:10:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3CE6FFEAC
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:10:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=XcQIVDBp;
	dmarc=pass (policy=none) header.from=uniontech.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304439-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304439-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 519B43052C2D
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7DE3446AF;
	Fri,  3 Jul 2026 07:55:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A23433E7F
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 07:55:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065309; cv=none; b=L4MasKqHXKAI29qpCyt2qa8CYKS/7sQxWTUZENU/S8u3vZiyK0wwM6rC1bd32cmVRM6/wyhLpHHkr/atvZWRCp4UkGwqIF1Wp1NM8Mfkv8GJfWPAGCRJbKVBrwQofz8vNDNuO0CS/20V67WUgjDQhDeWXFpvTmLHEA5PKQfXxpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065309; c=relaxed/simple;
	bh=QaVWn22VydkXdS83pct4954mPdIgVJoOiSQm3J0x1N0=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=ptWeut8oJFdqS7Qmo5ctpJq8ItgnAFZ/LZO0zyfhX3djlLzxUN/LHEFCd07KZlygBjQ9bLcvUNGg3ddw3YkbQZK+M5Rg8BpMnf1Xc1lkewWk1ElwgoRLnbWpOpb/bO8GOQC6xu7QTPTLBAen7jCBtAJBGaim6HhqL0PkPsf9JFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XcQIVDBp; arc=none smtp.client-ip=54.207.22.56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783065299;
	bh=QaVWn22VydkXdS83pct4954mPdIgVJoOiSQm3J0x1N0=;
	h=Date:From:To:Subject:Mime-Version:Message-ID;
	b=XcQIVDBpNKqf/BLChGW9wYx7yHSVgx1dz2QWXv7sEHtJttKg1GuJIwbNlcXFgPq3g
	 OZwEwzi/CHxIxeJuOtoitvjbMVNCeTCySQ8L4SD01eK21/C0ODphxd10SRyvwOv+lj
	 8PWMSGxmbdMCwCbqmxwhOsJOnz/XEV62WzZ0DxI4=
X-QQ-mid: zesmtpsz9t1783065297t675ce5b2
X-QQ-Originating-IP: Ymad5GS6m4RFAaSMcSWg3yzCRlS/EfyP/h6KQZEe6OQ=
Received: from PEN002676 ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 03 Jul 2026 15:54:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8049732622286881734
Date: Fri, 3 Jul 2026 15:54:55 +0800
From: =?GB2312?B?1dS98MP3?= <zhaojinming@uniontech.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: pabeni <pabeni@redhat.com>, 
	andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, 
	edumazet <edumazet@google.com>, 
	horms <horms@kernel.org>, 
	kuba <kuba@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	madalin.bucur <madalin.bucur@nxp.com>, 
	netdev <netdev@vger.kernel.org>, 
	sean.anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH v2 1/2] net: fman: move IRQ registration after init to prevent NULL deref and UAF
References: <e1f8aec9-751b-4a51-ab09-ca3c37522e30@redhat.com>, 
	<20260702092815.1206704-1-zhaojinming@uniontech.com>, 
	<20260702092815.1206704-2-zhaojinming@uniontech.com>, 
	<19877366-38df-4598-9892-3b295a5238f1@lunn.ch>
X-Priority: 3
X-GUID: 8AFFE19C-C4C5-4F24-8668-705885A5585E
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.375[cn]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <5CF599A1AAB00763+2026070315545441192614@uniontech.com>
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: base64
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N8nNIaELF1sdSXdXuUDuDAIVb5ZK6jxj3/LNSgP1bRozZwFtV0N4zjiO
	dukggVyFdHTDHW9o95+hw1xk2VfuScfF3aAJHpeKJVfnMJX7Scmc5dyZ2bChMRSoJ6RTaVh
	fDBPbZ7zNQTOIu/E2NDgY8lGWDJlKj9gFnbg8uSQSW8CKiTO6psiiNB3/ONnb5t1nzwNg96
	AfE9Wvflhau+ReostpZ/DKmfPAFysD7IEiTXHv2m6MQtY4DScLgFm/TxvBGxPlsQ+V2Gugh
	VmOcxgBUiMtBDOT+QiAXUey29nL7mqGQU+ByvBGCEikOm3akJJCnKwJf5f9w8zAR1cWw7EL
	YN/bZwKCLEi94Tafb+aFytfRPV3Tw318dcLMGHJRSbXz3g9pzI45ndh20WpU6eJLrjsgq+X
	mkof6xIzvlKD+72ZjFqe1JL9Sj0qbv8/JyF7NB2kudRUcMfiSTgAbwJTspIzq5P1HL/cq1X
	LBzJa09OxQmSsI1eqy8CcCEWdAiiwiv6189owEcIj0TcSKXGk6uSz4VYEIgM2vVQHftwykj
	+tgPZxuGCFTTOhCcpZSraVwAhhOyZ0rVT+XsP0PqY6otPUHjrRSzWkzLowKiKE5MRsL+0Kx
	W9iLICV04f3+K33COvN4CAzxQNeIAhC+zk4zftgasaswskpXyCyaVQN6FMmyxOFnur5ca6C
	3tlN/ZO4zERS1JYDd7V3lnzjzQ4Xbwy0b1F3tLQwUwdotMuLHK5eFMhDWdUBql22XUXgL5j
	jVpqtsoMg/tchUiDV3J5+QAkhO/oSG/Ge9aVkezIBOx0Shm9SPZAOmqyMA5VnDc/smEK2XT
	T0nXBC172q12jqMNF6UrCFrEDh95iWL3Rb1RPuRbnHFMFcXkm0rrxoyC3aYJJG4f8QdFtcA
	iDxu0m/553/wWuSw/NVukmj9A6evKrMTsV4cmNFqFTY+vK3mO5ym6IPgjcrKWo4sXOytkAN
	qXMmQkS5T/W35sYLHGAnuLuZXDlHONHqZBEcI7bDKpRQBHfatep98rpbwG97HCJU1CZwsyN
	/5NabhB3XO/Isw/nSeBdCfJa9CkKfup1OgwXjA38Ebou+dH8QabQWpQ5hBeaDyEYA+XsFlE
	jbPQ9Ef33jlGwgOnsTz+sg=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-304439-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:madalin.bucur@nxp.com,m:netdev@vger.kernel.org,m:sean.anderson@linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,uniontech.com:from_mime,uniontech.com:dkim,uniontech.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F3CE6FFEAC

CgoKCj5PbiBUaHUsIEp1bCAwMiwgMjAyNiBhdCAwNToyODoxNVBNICswODAwLCBaaGFvSmlubWlu
ZyB3cm90ZToKCgoKPj4gcmVhZF9kdHNfbm9kZSgpIHJlZ2lzdGVycyBzaGFyZWQgaW50ZXJydXB0
IGhhbmRsZXJzIHZpYQoKCgo+PiBkZXZtX3JlcXVlc3RfaXJxKCkgd2l0aCBmbWFuIGFzIGRldl9p
ZC4gVHdvIGJ1Z3MgZXhpc3QgaW4gdGhlCgoKCj4+IGN1cnJlbnQgY29kZToKCgoKPgoKCgo+UGxl
YXNlIHN0YXJ0IGEgbmV3IHRocmVhZCB3aXRoIGEgbmV3IHZlcnNpb24gb2YgdGhlIHBhdGNoLiBU
aGUgQ0kKCgoKPnN5c3RlbSBqdXN0IHRoaW5rcyB0aGlzIGlzIHBhcnQgb2YgdGhlIGRpc2N1c3Np
b24sIG5vdCBzb21ldGhpbmcgaXQKCgoKPm11c3QgdGVzdC4KCgoKPgoKCgo+UGxlYXNlIGFsc28g
cmVhZDoKCgoKPgoKCgo+aHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJv
Y2Vzcy9tYWludGFpbmVyLW5ldGRldi5odG1sCgoKCj4KCgoKPmFuZCBzZXQgdGhlIFN1YmplY3Q6
IGxpbmUgY29ycmVjdGx5LCBldGMuCgoKCj4KCgoKPj8/Pz8gQW5kcmV3CgoKCj4KCgpTdGFydGVk
IGEgbmV3IHRocmVhZCwgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjYwNzAzMDc0
MzI0LjkwNzI5NC0xLXpoYW9qaW5taW5nQHVuaW9udGVjaC5jb20vVC8jdCAKCgpUaGFua3MsCkpp
bm1pbmc=


