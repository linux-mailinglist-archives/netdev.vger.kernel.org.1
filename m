Return-Path: <netdev+bounces-193424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51009AC3ECF
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 13:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C4A3B0D5E
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB17A1FF1A0;
	Mon, 26 May 2025 11:46:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A581F7580;
	Mon, 26 May 2025 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748260005; cv=none; b=d9YDfj9H0dH0Pe4+uInXdS9BW4FoaU7XTS32bYxEfRyCKjpKdyqhk5aF4VPukYw8Ci/e26vBGh6rGtgbMLjDzB5YFxBu/k+BgMSlbHq1noXjUbizaFwvGUdp6NsbFhS8YMEoef6WpiPEfjd5/OG6+6sPhOJC5uqK+gMRbxGJA6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748260005; c=relaxed/simple;
	bh=ctdWOqVhw8PP7NozucmroMp+2QHGZHR7hJ6JgXHeR0k=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=U7/uLWGRMUxxYEV479NZJx/FLc3XVlkae/d6Zrx1kF1FuaEvs68Q7PM+8s/rxNnGp2TO12F4sF/S5MeaxB5L9q60TI2W6IXUo5yst3yk2BIDTV0ReMLupniEc0BQpT5XsLemudf7MVMYZd9dlooCRkBNBc5r6RVCRjGhZBzJdGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4b5YrK5YSBz51SW7;
	Mon, 26 May 2025 19:46:25 +0800 (CST)
Received: from njy2app08.zte.com.cn ([10.40.13.206])
	by mse-fl2.zte.com.cn with SMTP id 54QBkGU1075015;
	Mon, 26 May 2025 19:46:16 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njb2app05[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 26 May 2025 19:46:19 +0800 (CST)
Date: Mon, 26 May 2025 19:46:19 +0800 (CST)
X-Zmail-TransId: 2afd6834548b4f5-54aaa
X-Mailer: Zmail v1.0
Message-ID: <20250526194619126ArX868H3UosA7Jz31tRqF@zte.com.cn>
In-Reply-To: <CANn89i+C-qk-WhEanMS_tRiYJHHixH33MAO3u-wQVdWGJOjskw@mail.gmail.com>
References: 20250526162746319JPXpL0xRJ-n7onnZApOiV@zte.com.cn,CANn89i+C-qk-WhEanMS_tRiYJHHixH33MAO3u-wQVdWGJOjskw@mail.gmail.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <edumazet@google.com>
Cc: <davem@davemloft.net>, <kuba@kernel.org>, <dsahern@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <zhang.yunkai@zte.com.cn>,
        <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXQtbmV4dF0gbmV0OiBhcnA6IHVzZSBrZnJlZV9za2JfcmVhc29uKCkgaW4gYXJwX3Jjdigp?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl2.zte.com.cn 54QBkGU1075015
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68345491.000/4b5YrK5YSBz51SW7



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

PkFyZSB0aGVzZSBlcnJvcnMgY29tbW9uIGVub3VnaCB0byBnZXQgZGVkaWNhdGVkIGRyb3AgcmVh
c29ucyA/IE1vc3QNCj5zdGFja3MgaGF2ZSBpbXBsZW1lbnRlZCBBUlAgbW9yZSB0aGFuIDIwIHll
YXJzIGFnby4NCj4NCj5JIHRoaW5rIHRoYXQgZm9yIHJhcmUgZXZlbnRzIGxpa2UgdGhpcywgdGhl
IHN0YW5kYXJkIGNhbGwgZ3JhcGggc2hvdWxkDQo+YmUgcGxlbnR5IGVub3VnaC4gKHBlcmYgcmVj
b3JkIC1hZyAtZSBza2I6a2ZyZWVfc2tiKQ0KPg0KPk90aGVyd2lzZSB3ZSB3aWxsIGdldCAxMDAw
IGRyb3AgcmVhc29ucywgYW5kIHRoZSBwcm9mdXNpb24gb2YgbmFtZXMNCj5tYWtlcyB0aGVtIHVz
ZWxlc3MuDQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4NCg0KTWFsaWNpb3VzbHkgY3Jh
ZnRlZCBBUlAgcGFja2V0cyBvZnRlbiB0cmlnZ2VyIHRoZXNlIHR3byBzY2VuYXJpb3MuIA0KVXNp
bmcgcGVyZiBjYW5ub3QgZGlyZWN0bHkgZGlzdGluZ3Vpc2ggYmV0d2VlbiB0aGUgdHdvIGNhc2Vz
OyANCmFkZGl0aW9uYWxseSwgZW5hYmxpbmcgcGVyZiBpbiBlbWJlZGRlZCBlbnZpcm9ubWVudHMg
bWF5IGxlYWQgdG8gDQpub3RpY2VhYmxlIHBlcmZvcm1hbmNlIG92ZXJoZWFkLg0KDQpNb3JlIGlt
cG9ydGFudGx5LCBpbiB0aGlzIHBhdGNoLCBJIGJlbGlldmUgcmVwbGFjaW5nIHBza2JfbWF5X3B1
bGwgd2l0aCANCnBza2JfbWF5X3B1bGxfcmVhc29uIG1ha2VzIHNlbnNlLCBzbyB1c2luZyBrZnJl
ZV9za2JfcmVhc29uKCkgaW4gDQphcnBfcmN2KCkgaXMgbWVhbmluZ2Z1bC4=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQt
ZmFtaWx5OuW+rui9r+mbhem7kSxNaWNyb3NvZnQgWWFIZWk7bGluZS1oZWlnaHQ6MS41Ij48ZGl2
IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUiPiZndDtBcmUgdGhlc2UgZXJyb3JzIGNvbW1vbiBlbm91
Z2ggdG8gZ2V0IGRlZGljYXRlZCBkcm9wIHJlYXNvbnMgPyBNb3N0PC9kaXY+PGRpdiBzdHlsZT0i
bGluZS1oZWlnaHQ6MS41Ij4mZ3Q7c3RhY2tzIGhhdmUgaW1wbGVtZW50ZWQgQVJQIG1vcmUgdGhh
biAyMCB5ZWFycyBhZ28uPC9kaXY+PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS41Ij4mZ3Q7PC9k
aXY+PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS41Ij4mZ3Q7SSB0aGluayB0aGF0IGZvciByYXJl
IGV2ZW50cyBsaWtlIHRoaXMsIHRoZSBzdGFuZGFyZCBjYWxsIGdyYXBoIHNob3VsZDwvZGl2Pjxk
aXYgc3R5bGU9ImxpbmUtaGVpZ2h0OjEuNSI+Jmd0O2JlIHBsZW50eSBlbm91Z2guIChwZXJmIHJl
Y29yZCAtYWcgLWUgc2tiOmtmcmVlX3NrYik8L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDox
LjUiPiZndDs8L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUiPiZndDtPdGhlcndpc2Ug
d2Ugd2lsbCBnZXQgMTAwMCBkcm9wIHJlYXNvbnMsIGFuZCB0aGUgcHJvZnVzaW9uIG9mIG5hbWVz
PC9kaXY+PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS41Ij4mZ3Q7bWFrZXMgdGhlbSB1c2VsZXNz
LjwvZGl2PjxkaXYgc3R5bGU9ImxpbmUtaGVpZ2h0OjEuNSI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9
ImxpbmUtaGVpZ2h0OjEuNSI+VGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrLjwvZGl2PjxkaXYg
c3R5bGU9ImxpbmUtaGVpZ2h0OjEuNSI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9ImxpbmUtaGVpZ2h0
OjEuNSI+TWFsaWNpb3VzbHkgY3JhZnRlZCBBUlAgcGFja2V0cyBvZnRlbiB0cmlnZ2VyIHRoZXNl
IHR3byBzY2VuYXJpb3MuJm5ic3A7PC9kaXY+PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS41Ij5V
c2luZyBwZXJmIGNhbm5vdCBkaXJlY3RseSBkaXN0aW5ndWlzaCBiZXR3ZWVuIHRoZSB0d28gY2Fz
ZXM7Jm5ic3A7PC9kaXY+PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS41Ij5hZGRpdGlvbmFsbHks
IGVuYWJsaW5nIHBlcmYgaW4gZW1iZWRkZWQgZW52aXJvbm1lbnRzIG1heSBsZWFkIHRvJm5ic3A7
PC9kaXY+PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS41Ij5ub3RpY2VhYmxlIHBlcmZvcm1hbmNl
IG92ZXJoZWFkLjwvZGl2PjxkaXYgc3R5bGU9ImxpbmUtaGVpZ2h0OjEuNSI+PGJyPjwvZGl2Pjxk
aXYgc3R5bGU9ImxpbmUtaGVpZ2h0OjEuNSI+TW9yZSBpbXBvcnRhbnRseSwgaW4gdGhpcyBwYXRj
aCwgSSBiZWxpZXZlIHJlcGxhY2luZyBwc2tiX21heV9wdWxsIHdpdGgmbmJzcDs8L2Rpdj48ZGl2
IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUiPnBza2JfbWF5X3B1bGxfcmVhc29uIG1ha2VzIHNlbnNl
LCBzbyB1c2luZyBrZnJlZV9za2JfcmVhc29uKCkgaW4mbmJzcDs8L2Rpdj48ZGl2IHN0eWxlPSJs
aW5lLWhlaWdodDoxLjUiPmFycF9yY3YoKSBpcyBtZWFuaW5nZnVsLjwvZGl2PjwvZGl2Pjxicj48
YnI+PGJyPjxicj48L2Rpdj4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


