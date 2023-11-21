Return-Path: <netdev+bounces-49488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92217F2312
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149101C20748
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 01:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B4C6FA4;
	Tue, 21 Nov 2023 01:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rOdNLa5+"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421C6AC
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 17:31:52 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231121013148epoutp038c60e6e2dc84761e04fe5f0ed16e2d77~Zf041D_IP2829428294epoutp03Y
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 01:31:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231121013148epoutp038c60e6e2dc84761e04fe5f0ed16e2d77~Zf041D_IP2829428294epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1700530308;
	bh=r7FUgwAb5MWY8DmPizGyFQBrKuzR2qlvMD2L01WpRUU=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=rOdNLa5+qmIMPep1oXJSbiw4L7VJfSwZ2d2Y2DIJhS1qp/B2//B0BMctafTNqp/rx
	 iMyk+Q/1tAjmAyiuKAMQQq5HEQCJjkzwcwqC3pleGLYQapJ2Ug1cDUmd2vRTEW3kkk
	 XljQMOOcTxw/o520eqX9gCCdlOcD/ZxkkJhDPXqA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20231121013147epcas2p4287f4c07f8f51285a02e63583d91304d~Zf04b9Buo1419714197epcas2p4V;
	Tue, 21 Nov 2023 01:31:47 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SZ6Kv1LX2z4x9QH; Tue, 21 Nov
	2023 01:31:47 +0000 (GMT)
X-AuditID: b6c32a48-bcdfd70000002587-cc-655c08834f57
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.23.09607.3880C556; Tue, 21 Nov 2023 10:31:47 +0900 (KST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] nfc: virtual_ncidev: Add variable to check if ndev is
 running
Reply-To: bongsu.jeon@samsung.com
Sender: Bongsu Jeon <bongsu.jeon@samsung.com>
From: Bongsu Jeon <bongsu.jeon@samsung.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Nguyen Dinh Phi
	<phind.uet@gmail.com>, Bongsu Jeon <bongsu.jeon@samsung.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com"
	<syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <b2bd6689-5161-483a-a05c-811927831082@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231121013146epcms2p1587bebc341f17406625e8b0490b6ab1a@epcms2p1>
Date: Tue, 21 Nov 2023 10:31:46 +0900
X-CMS-MailID: 20231121013146epcms2p1587bebc341f17406625e8b0490b6ab1a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmhW4zR0yqwdarnBZbmiexW+x9vZXd
	4vKuOWwWxxaIWcx78ZrJYvOcO0wObB47Z91l97hzbQ+bR9+WVYweM9+qeXzeJBfAGpVtk5Ga
	mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0X0mhLDGnFCgU
	kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnbH/31mm
	gh1sFe+/qjYwzmDtYuTkkBAwkZi5aBJzFyMXh5DADkaJI9+Ws3cxcnDwCghK/N0hDFIjLBAi
	MWP/YxYQW0hAUeJ/xzk2iLiuxIu/R8FsNgFtibVHG5lA5ogIdDBKbNj0DcxhFnjNKHGu5Rwz
	xDZeiRntT1kgbGmJ7cu3MoIs4xSwk7iyTQYirCHxY1kvVLmoxM3Vb9lh7PfH5jNC2CISrffO
	QtUISjz4uRsqLiXx6eEZVpCREgLZEt/72EBOkBBoYJS48/Yu1Fp9iWn3FoDZvAK+Eu82LgOb
	wyKgKjH35gYmiBoXifnvXoLNZBaQl9j+dg4zyExmAU2J9bv0IcYrSxy5xQJRwSfRcfgvO8yD
	O+Y9gZqiKtHb/IUJ5tnJs1ugrvSQWLptAdsERsVZiICehWTXLIRdCxiZVzGKpRYU56anFhsV
	mMCjNjk/dxMjOCFqeexgnP32g94hRiYOxkOMEhzMSiK8W9hjUoV4UxIrq1KL8uOLSnNSiw8x
	mgJ9OZFZSjQ5H5iS80riDU0sDUzMzAzNjUwNzJXEee+1zk0REkhPLEnNTk0tSC2C6WPi4JRq
	YAoTb9JIunzx0VkrPq23bzayVjeGG56Xub9A1fzc5et/2JkzGmQC7fMPTlx6JOP5Zw45x1tL
	3WavTbyp65q/2PaR3u2ejckrBJSeVh9q0P06I4/v9Lf3rg81lpskLD8u8O15f/imsOB+04OV
	q/8u+K+wd88O7R7dNZoHfzLdeFooPv2ptX6NxvL4OL4J+6UKrzl3TQgJ0SnUqb6Rdn1+R5Dy
	Pa/LP7/71EhNnuD+3Dme5dO7z/wdscvYgn54393X+lHT6HBe0/1DlUcrmw5ez5WVeDwnzca4
	w0JfM+92m56oON+8NDO3uwXCO19vytrMknFwgX95m3PldF+G896xBuo/Uq69jmjXsXv5Ytms
	eiWW4oxEQy3mouJEALyijjMRBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231120184433epcas2p23e9f5db776d46ad8dd77a16dd326c1bc
References: <b2bd6689-5161-483a-a05c-811927831082@linaro.org>
	<20231119164705.1991375-1-phind.uet@gmail.com>
	<CGME20231120184433epcas2p23e9f5db776d46ad8dd77a16dd326c1bc@epcms2p1>

On 20/11/2023 19:23, Phi Nguyen wrote:

> The issue arises when an skb is added to the send_buff after invoking 
> ndev->ops->close() but before unregistering the device. In such cases, 
> the virtual device will generate a copy of skb, but with no consumer 
> thereafter. Consequently, this object persists indefinitely.
> 
> This problem seems to stem from the existence of time gaps between 
> ops->close() and the destruction of the workqueue. During this interval, 
> incoming requests continue to trigger the send function.

Dear Krzysztof,

Even though i agree on this patch, i think that NFC subsystem could handle this scenario not to trigger the send function after close.
Do you think it would be better that each nci driver has the responsibility to handle this scenario?

Best regards,
Bongsu

