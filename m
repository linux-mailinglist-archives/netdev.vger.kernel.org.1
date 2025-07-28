Return-Path: <netdev+bounces-210463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5528AB13751
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 11:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9817A5EBF
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7C221ABA2;
	Mon, 28 Jul 2025 09:11:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720E1D90DD;
	Mon, 28 Jul 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693915; cv=none; b=NvpO+vNRrELzCGeqsvtXLo1KSJt//aF5Z6YSW3rfy5QVT88BUPpcQ02yDiCdM5DHp/7sG3lxiU68XPg6pmfvC20Ne2047tKe18hPDXBjKntzyEffpSEOPJ6Cnu9rlZ/qsqyl8MZruyegTP26piSnGPldgu0w9dqiAb+1KZXAIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693915; c=relaxed/simple;
	bh=ojDcrEmvPgqQJN+tqQibo+gCjxqoqo5f/CEBGMRfMSc=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=Jk3t8XIrq8RU/v+6jXNPN57neGzQxWoZCSqCiyWW4zQeh2UI7tUwJNiVPp9zRdQE1gyfqTNHqPgMAyYZd1C4Gw2jjRXV3+sDQe5tA9wAGnKnG2iRhB7OryQrrhHdhdr/2PwbLqGuOOLjgUPWFPSKKxtb9rVZH4tcFwXmvvXQ+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4brCQp5DL9z8Xs71;
	Mon, 28 Jul 2025 17:11:46 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 56S9BZcg096074;
	Mon, 28 Jul 2025 17:11:35 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 28 Jul 2025 17:11:37 +0800 (CST)
Date: Mon, 28 Jul 2025 17:11:37 +0800 (CST)
X-Zmail-TransId: 2afa68873ec9ffffffffe1e-02525
X-Mailer: Zmail v1.0
Message-ID: <202507281711372379BW_PL4oZvcBoW5Xti7yO@zte.com.cn>
In-Reply-To: <aIO+CKQ/kvpX5lMo@pop-os.localdomain>
References: 20250724212837119BP9HOs0ibXDRWgsXMMir7@zte.com.cn,aIO+CKQ/kvpX5lMo@pop-os.localdomain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <xiyou.wangcong@gmail.com>
Cc: <dumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>, <davem@davemloft.net>, <jiri@resnulli.us>,
        <jhs@mojatatu.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <jiang.kun2@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <he.peilin@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXQtbmV4dF0gbmV0L3NjaGVkOiBBZGQgcHJlY2lzZSBkcm9wIHJlYXNvbiBmb3IgcGZpZm9fZmFzdCBxdWV1ZSBvdmVyZmxvd3M=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl2.zte.com.cn 56S9BZcg096074
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Mon, 28 Jul 2025 17:11:46 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68873ED2.000/4brCQp5DL9z8Xs71



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

PiBCVFcsIGl0IHNlZW1zIG5ldC1uZXh0IGlzIGNsb3NlZCwgeW91IG1heSBuZWVkIHRvIHJlc2Vu
ZCBpdCBhZnRlciBpdCBpcz4gcmUtb3Blbi4+PiBUaGFua3MuDQoNCkhpIENvbmcsICANClRoYW5r
IHlvdSBmb3IgeW91ciByZXZpZXcgYW5kIHRoZSBmZWVkYmFjayENCkNvdWxkIHlvdSBraW5kbHkg
c2hhcmUgaG93IHRvIHRyYWNrIHRoZSBzdGF0dXMgb2YgdGhlIG5ldC1uZXh0IG1lcmdlIHdpbmRv
dz8NClNob3VsZCBJIG1vbml0b3IgdGhlIGxpbnV4LW5ldGRldiBtYWlsaW5nIGxpc3QgZm9yIGFu
bm91bmNlbWVudHMsIG9yIGlzIHRoZXJlIGEgc3BlY2lmaWMgc2NoZWR1bGUgSSBjYW4gZm9sbG93
PyANCg0KQmVzdCBSZWdhcmRzLCAgDQpGYW4gWXU=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogQXJp
YWwsICZxdW90O01pY3Jvc29mdCBZYWhlaSZxdW90OywgJnF1b3Q7THVjaWRhIEdyYW5kZSZxdW90
OywgVmVyZGFuYSwgTHVjaWRhLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGJhY2tncm91bmQtY29s
b3I6IHJnYigyNTUsIDI1NSwgMjU1KTsiPiZndDsgQlRXLCZuYnNwO2l0Jm5ic3A7c2VlbXMmbmJz
cDtuZXQtbmV4dCZuYnNwO2lzJm5ic3A7Y2xvc2VkLCZuYnNwO3lvdSZuYnNwO21heSZuYnNwO25l
ZWQmbmJzcDt0byZuYnNwO3Jlc2VuZCZuYnNwO2l0Jm5ic3A7YWZ0ZXImbmJzcDtpdCZuYnNwO2lz
PC9zcGFuPjxiciBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsgb3V0bGluZTogMHB4OyBm
b250LWZhbWlseTogQXJpYWwsICZxdW90O01pY3Jvc29mdCBZYWhlaSZxdW90OywgJnF1b3Q7THVj
aWRhIEdyYW5kZSZxdW90OywgVmVyZGFuYSwgTHVjaWRhLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7
IHdoaXRlLXNwYWNlOiBub3JtYWw7IGJhY2tncm91bmQtY29sb3I6IHJnYigyNTUsIDI1NSwgMjU1
KTsiPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsICZxdW90O01pY3Jvc29mdCBZYWhl
aSZxdW90OywgJnF1b3Q7THVjaWRhIEdyYW5kZSZxdW90OywgVmVyZGFuYSwgTHVjaWRhLCBIZWx2
ZXRpY2EsIHNhbnMtc2VyaWY7IGJhY2tncm91bmQtY29sb3I6IHJnYigyNTUsIDI1NSwgMjU1KTsi
PiZndDsgcmUtb3Blbi48L3NwYW4+PGJyIHN0eWxlPSJib3gtc2l6aW5nOiBib3JkZXItYm94OyBv
dXRsaW5lOiAwcHg7IGZvbnQtZmFtaWx5OiBBcmlhbCwgJnF1b3Q7TWljcm9zb2Z0IFlhaGVpJnF1
b3Q7LCAmcXVvdDtMdWNpZGEgR3JhbmRlJnF1b3Q7LCBWZXJkYW5hLCBMdWNpZGEsIEhlbHZldGlj
YSwgc2Fucy1zZXJpZjsgd2hpdGUtc3BhY2U6IG5vcm1hbDsgYmFja2dyb3VuZC1jb2xvcjogcmdi
KDI1NSwgMjU1LCAyNTUpOyI+Jmd0OzxiciBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsg
b3V0bGluZTogMHB4OyBmb250LWZhbWlseTogQXJpYWwsICZxdW90O01pY3Jvc29mdCBZYWhlaSZx
dW90OywgJnF1b3Q7THVjaWRhIEdyYW5kZSZxdW90OywgVmVyZGFuYSwgTHVjaWRhLCBIZWx2ZXRp
Y2EsIHNhbnMtc2VyaWY7IHdoaXRlLXNwYWNlOiBub3JtYWw7IGJhY2tncm91bmQtY29sb3I6IHJn
YigyNTUsIDI1NSwgMjU1KTsiPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsICZxdW90
O01pY3Jvc29mdCBZYWhlaSZxdW90OywgJnF1b3Q7THVjaWRhIEdyYW5kZSZxdW90OywgVmVyZGFu
YSwgTHVjaWRhLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGJhY2tncm91bmQtY29sb3I6IHJnYigy
NTUsIDI1NSwgMjU1KTsiPiZndDsgVGhhbmtzLjwvc3Bhbj48L3A+PHA+PGJyPjwvcD48cD5IaSBD
b25nLCZuYnNwOyZuYnNwOzwvcD48cD5UaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3IGFuZCB0aGUg
ZmVlZGJhY2shPC9wPjxwPkNvdWxkIHlvdSBraW5kbHkgc2hhcmUgaG93IHRvIHRyYWNrIHRoZSBz
dGF0dXMgb2YgdGhlIG5ldC1uZXh0IG1lcmdlIHdpbmRvdz88L3A+PHA+U2hvdWxkIEkgbW9uaXRv
ciB0aGUgbGludXgtbmV0ZGV2IG1haWxpbmcgbGlzdCBmb3IgYW5ub3VuY2VtZW50cywgb3IgaXMg
dGhlcmUgYSBzcGVjaWZpYyBzY2hlZHVsZSBJIGNhbiBmb2xsb3c/Jm5ic3A7PC9wPjxwPjxicj48
L3A+PHA+QmVzdCBSZWdhcmRzLCZuYnNwOyZuYnNwOzwvcD48cD5GYW4gWXUmbmJzcDsmbmJzcDs8
L3A+PC9kaXY+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


