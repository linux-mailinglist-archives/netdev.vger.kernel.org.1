Return-Path: <netdev+bounces-191806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3B1ABD54E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 12:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36053AC76B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B819E26B94F;
	Tue, 20 May 2025 10:40:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E2F26A1D0;
	Tue, 20 May 2025 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737649; cv=none; b=nr7PygjZR/Kb7SSdLC8u3axRrm3bTFgxFNobpe3oZflnSK5o3DNqQWbm9+OlGPXMqkZg5CT0GMpcXewPhG84EHk0YOfDhBXHtbOFXvA+b7WiNwt6MsZ8HGz5tvsldrvCqLQUg4XMt3im3MBsGq5U98Re8+329H8tPe/YMKf9XGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737649; c=relaxed/simple;
	bh=LUfgGfl9gcNgXh9BKxUOpyUTpb7+YAa/WoD/VPDqX8g=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=DkVWjiuRBrA3d/hoOLCPno91YTbxYVS1S9RgXLe3YNyKM6wEkz1OYiQyjoiYx3wvI1dSyNvvxz/NNbglNRM2zWeefyznYnImXeUxI1ISU/PCkybFa0J7wzCs3veRbFUnoacLDKLdduxoh5vE4aKKjUZlPgxfMeMrPAEzQWa5uPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4b1rgJ0gYpz5B1K1;
	Tue, 20 May 2025 18:40:44 +0800 (CST)
Received: from njy2app08.zte.com.cn ([10.40.13.206])
	by mse-fl2.zte.com.cn with SMTP id 54KAeTlf060656;
	Tue, 20 May 2025 18:40:29 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njb2app06[null])
	by mapi (Zmail) with MAPI id mid204;
	Tue, 20 May 2025 18:40:32 +0800 (CST)
Date: Tue, 20 May 2025 18:40:32 +0800 (CST)
X-Zmail-TransId: 2afe682c5c20769-f36d0
X-Mailer: Zmail v1.0
Message-ID: <20250520184032009VEzfxkkFmbQjfs0qCJ5QB@zte.com.cn>
In-Reply-To: <20250520045922.34528-1-kuniyu@amazon.com>
References: 20250520104413538Q88ZB2XVWu1BthfQkFSuW@zte.com.cn,20250520045922.34528-1-kuniyu@amazon.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <kuniyu@amazon.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <fan.yu9@zte.com.cn>,
        <gnaaman@drivenets.com>, <he.peilin@zte.com.cn>, <horms@kernel.org>,
        <kuba@kernel.org>, <kuniyu@amazon.com>, <leitao@debian.org>,
        <linux-kernel@vger.kernel.org>, <lizetao1@huawei.com>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <qiu.yutan@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <ye.xingchen@zte.com.cn>, <zhang.yunkai@zte.com.cn>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCBsaW51eCBuZXh0XSBuZXQ6IG5laWdoOiB1c2Uga2ZyZWVfc2tiX3JlYXNvbigpIGluIG5laWdoX3Jlc29sdmVfb3V0cHV0KCk=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl2.zte.com.cn 54KAeTlf060656
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 682C5C2C.000/4b1rgJ0gYpz5B1K1



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

PklzIHRoZXJlIGFueSByZWFzb24geW91IGRvbid0IGNoYW5nZSBuZWlnaF9jb25uZWN0ZWRfb3V0
cHV0KCkgPw0KPg0KPg0KPklmIHlvdSByZXNwaW4sIHBsZWFzZSBzcGVjaWZ5IG5ldC1uZXh0IGFu
ZCB0aGUgcGF0Y2ggdmVyc2lvbiBpbg0KPg0KPlN1YmplY3Q6IFtQQVRDSCB2MiBuZXQtbmV4dF0g
bmV0OiBuZWlnaGJvdXI6IC4uLg0KPg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2suDQpJ
IG5vdGljZSB0aGF0IG1vc3QgY29tbWl0cyByZWxhdGVkIHRvIGtmcmVlX3NrYl9yZWFzb24oKSBp
bnZvbHZlIGNoYW5nZXMgDQp3aXRoaW4gdGhlIHNjb3BlIG9mIGEgc2luZ2xlIGZ1bmN0aW9uLCB3
aGljaCBhbGlnbnMgd2l0aCB0aGUgbWVhbmluZyBvZiANCnRoZSBjb21taXQgdGl0bGVzLiBJIGNv
bnNpZGVyIHRoaXMgYXBwcm9hY2ggYXBwcm9wcmlhdGUgYXMgaXQgZmFjaWxpdGF0ZXMgDQpib3Ro
IG1vZGlmaWNhdGlvbiBhbmQgdHJhY2VhYmlsaXR5LiBGb2xsb3dpbmcgdGhpcyBhcHByb2FjaCwg
SSB3aWxsIHN1Ym1pdCANCmFub3RoZXIgbmV3IHBhdGNoIHRvIHNwZWNpZmljYWxseSBtb2RpZnkg
bmVpZ2hfY29ubmVjdGVkX291dHB1dCgpLg==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQt
ZmFtaWx5OuW+rui9r+mbhem7kSxNaWNyb3NvZnQgWWFIZWk7bGluZS1oZWlnaHQ6MS41Ij48ZGl2
IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUiPiZndDtJcyB0aGVyZSBhbnkgcmVhc29uIHlvdSBkb24n
dCBjaGFuZ2UgbmVpZ2hfY29ubmVjdGVkX291dHB1dCgpID88L2Rpdj48ZGl2IHN0eWxlPSJsaW5l
LWhlaWdodDoxLjUiPiZndDs8L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUiPiZndDs8
L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUiPiZndDtJZiB5b3UgcmVzcGluLCBwbGVh
c2Ugc3BlY2lmeSBuZXQtbmV4dCBhbmQgdGhlIHBhdGNoIHZlcnNpb24gaW48L2Rpdj48ZGl2IHN0
eWxlPSJsaW5lLWhlaWdodDoxLjUiPiZndDs8L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDox
LjUiPiZndDtTdWJqZWN0OiBbUEFUQ0ggdjIgbmV0LW5leHRdIG5ldDogbmVpZ2hib3VyOiAuLi48
L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUiPiZndDs8L2Rpdj48ZGl2IHN0eWxlPSJs
aW5lLWhlaWdodDoxLjUiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUiPlRo
YW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay48L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDox
LjUiPkkgbm90aWNlIHRoYXQgbW9zdCBjb21taXRzIHJlbGF0ZWQgdG8ga2ZyZWVfc2tiX3JlYXNv
bigpIGludm9sdmUgY2hhbmdlcyZuYnNwOzwvZGl2PjxkaXYgc3R5bGU9ImxpbmUtaGVpZ2h0OjEu
NSI+d2l0aGluIHRoZSBzY29wZSBvZiBhIHNpbmdsZSBmdW5jdGlvbiwgd2hpY2ggYWxpZ25zIHdp
dGggdGhlIG1lYW5pbmcgb2YmbmJzcDs8L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUi
PnRoZSBjb21taXQgdGl0bGVzLiBJIGNvbnNpZGVyIHRoaXMgYXBwcm9hY2ggYXBwcm9wcmlhdGUg
YXMgaXQgZmFjaWxpdGF0ZXMmbmJzcDs8L2Rpdj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDoxLjUi
PmJvdGggbW9kaWZpY2F0aW9uIGFuZCB0cmFjZWFiaWxpdHkuIEZvbGxvd2luZyB0aGlzIGFwcHJv
YWNoLCBJIHdpbGwgc3VibWl0Jm5ic3A7PC9kaXY+PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS41
Ij5hbm90aGVyIG5ldyBwYXRjaCB0byBzcGVjaWZpY2FsbHkgbW9kaWZ5IG5laWdoX2Nvbm5lY3Rl
ZF9vdXRwdXQoKS48L2Rpdj48L2Rpdj48YnI+PGJyPjxicj48YnI+PGJyPjwvZGl2Pg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


