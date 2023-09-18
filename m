Return-Path: <netdev+bounces-34583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E597A4CB4
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B52C1C21147
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21981D6AC;
	Mon, 18 Sep 2023 15:39:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268411D6A1
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:39:00 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54172133
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:35:22 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230918130542euoutp01bab547fe184a53602f9f84dd16febc15~GAAenc0wc0583805838euoutp019
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:05:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230918130542euoutp01bab547fe184a53602f9f84dd16febc15~GAAenc0wc0583805838euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1695042342;
	bh=NIL1CvYtONHcMU9vc2apqrnGSaeU6H2ARBYOyGMJevQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Qn9K7E+TT2ShQFrVuebNkFoUzJV3Bup9pDYJ+LMuUpxK7f91QGWH9iXyin1CDOI3b
	 00p1rcAUkP2WpFNozdF35/U42h7/x7R9N+qwKzAO3ERS49D2v8LOw82XP7ce2Mtfsr
	 tnfg74j9yc4zEgYjhNBRr6gnpUafZEX96Defeeks=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230918130542eucas1p21d5b3fe7d60b13f5dc2d2e7398bd5845~GAAeRpI2k0813108131eucas1p2_;
	Mon, 18 Sep 2023 13:05:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 91.12.42423.62B48056; Mon, 18
	Sep 2023 14:05:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230918130541eucas1p1d7c51dcf06d0f0862f8bb27d725455a6~GAAd2acOd3195731957eucas1p16;
	Mon, 18 Sep 2023 13:05:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230918130541eusmtrp15fbf406846d06ab6469f204746b9903f~GAAd0qVKQ0564905649eusmtrp1V;
	Mon, 18 Sep 2023 13:05:41 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-c3-65084b2694d0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 82.7C.14344.52B48056; Mon, 18
	Sep 2023 14:05:41 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230918130540eusmtip2e4db4d53a818a09f3fd847a62a82dabe~GAAdCiz0A1444414444eusmtip2J;
	Mon, 18 Sep 2023 13:05:40 +0000 (GMT)
Message-ID: <99667e5c-588d-1eea-dd42-a11384d286dd@samsung.com>
Date: Mon, 18 Sep 2023 15:05:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
	Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 1/7] net: phy: always call
 phy_process_state_change() under lock
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Heiner Kallweit
	<hkallweit1@gmail.com>, chenhao418@huawei.com, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Jijie Shao <shaojijie@huawei.com>, lanhao@huawei.com,
	liuyonglong@huawei.com, netdev@vger.kernel.org, Paolo Abeni
	<pabeni@redhat.com>, shenjian15@huawei.com, wangjie125@huawei.com,
	wangpeiyang1@huawei.com
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <b54eca90-93cb-40ed-8c18-23b196b4728b@lunn.ch>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHPffce3vbrfV6wXEEo6RGssHksdTtbk6Hr3CND3SJmKgZVr0C
	EaprLUNclibDUqsI4gubGhvwgZDAgg2KBoSKJaRgCwQ2EUQ76kYHaRGyKRAcl7sH/31+39/r
	fH85FGR+JsKpDM0xXqtRZypJGV7rfOteEbWZ4uNLyt5j3f0OyJ4v9JKs1Z2Hsz6nV8KWBkoI
	1lN7lmAfXfqLYMddzwHrtH3A/ukaBmxn4TmMbeidKTO8KYCsc7qSYKv8pSBxPtfV0wE5++2n
	GFdn6Zdwtho9l9c8QnA1FadIru7eGMYFGrpJbqxmyXbpbtmXB/nMjGxeG7dmnyz9pMsIj96U
	5HTaWqEBPCDMQEohWoW6i31QYIYuB8gzkGQGshkeB6in/S0pBmMAtRe8xs2Amu3wduSI+i2A
	+qqDQAxGAQr6C2dHyek1qOv5VUxowOnlyP1itygvQK1XBnGBF9I8+nHYLRE4hE5FnoBvVod0
	GOodvIYJHEpHogutU4QwH9KNELnHfyKFBEknIPOIeZal9CpkMokWIL0U3R2xQqEB0Xek6Pfh
	KVz0uQH9MTwtETkE+Vvs//Bi5Dp/Bhcb8gGyTQ5gYlAEkOG3XiBWrUJ9TyZIwQ6kP0LV9+NE
	eS0qa+zCxLMo0C8jC8RHKFBx7WUoynJkMjJidRSytFT9t7bJ0wmLgNIy5y6WOf4tc+xY/t9r
	A3gFCOP1uqw0Xpeg4b+L1amzdHpNWuyBI1k1YObvuaZbXt8DV/2jsQ6AUcABEAWVofIrCSTP
	yA+qj+fy2iOpWn0mr3OACApXhsljVrceYOg09TH+MM8f5bX/ZjFKGm7A1lVZml/tv/CZ9ftF
	S6L36HuDzSl77uS//5j6sLGt+1rTifTTn0Rj+1SjlV959f23f+2AsomYN1vzSoIutuekNLE+
	Y+Hxi5G6iPL7SX5ffDyzflc2sbTfYDRMrLRqnsFDt0ocr8JgtarpByYZm5fc3DaZTdtNilJF
	blT7joDza/taqizx7gSzvNh3I3ZvEsifv/jb1Z9uk8bEqaYeDtSVm564MmWw6KUkhmhLHbSo
	piVDoX2bK56Bz6dA1/WCodGhS8SJTXhy5Rdb6kMVxrbAVo92pz7olW8c3BRuD/k4J/pxd8PO
	qJUYMxm5LOJd7ru8b+rP9GCE5/IiY0pKoxUqcV26OiEaanXqvwGAE+St6gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsVy+t/xe7qq3hypBguvqFmcv3uI2WJy/yM2
	iznnW1gsnh57xG6x6P0MVosL2/pYLQ5P+85q8eX0PUaLYwvELL6dfsNocal/IpPFvltAZQ0/
	epktjv1bzWqx7tUiRgd+j8vXLjJ7bFl5k8lj56y77B4LNpV6tBx5y+qxaVUnm8fOHZ+ZPN7v
	u8rm8XmTXABnlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllq
	kb5dgl5G6+k25oJl7BWXFpxkbmDczdrFyMEhIWAi8ehiRRcjF4eQwFJGiR8vlzN2MXICxWUk
	Tk5rYIWwhSX+XOtigyh6zyjRP2ULWBGvgJ3E5XtzmUAGsQioSpx/EAURFpQ4OfMJC4gtKpAq
	cXraJrByYYF4iQvvn4LFmQXEJW49mc8EYosIKEhMOfmHFWQ+s8ABZonDv+5BLZvNJDHp9l+w
	bjYBQ4mutyBXcHJwClhLdHQ8ZYaYZCbRtbWLEcKWl9j+dg7zBEahWUgOmYVk4SwkLbOQtCxg
	ZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGOnbjv3csoNx5auPeocYmTgYDzFKcDArifDO
	NGRLFeJNSaysSi3Kjy8qzUktPsRoCgyMicxSosn5wFSTVxJvaGZgamhiZmlgamlmrCTO61nQ
	kSgkkJ5YkpqdmlqQWgTTx8TBKdXAtK+2QNQ3ceIlq5UnT+z2CarXcxJqMlpx7ISRpuYqxdkr
	prGe57/92aFm+dd3izRrJ8SeYGqQ2Jq985DKrr3KbZIOW02vbNid5rvDL/nz7aWBi9PyEzqm
	aszvWMwmqiaxnXGuX6KGlvMXz2QJwY/bazTuqgmZ/GV3vfQ1+7zxsk07NLtWBRqttNDoOiS5
	e536zSkc32Mu7rs6J3mB9/YlXx2Cnyp7FsgeZVPbqV/r12TI6rMvQ/bLGY4nEy6wOrdEOwiI
	1aw/d3GT7aRzK/mj5hkvnrqZZSb3zTuP9rTtcD38ZPZJxwiPhCMrZ5eJJ4QGRHAt/7O44eCO
	KXY73LWvdDNwKD4QChH5t/xTZq+dhBJLcUaioRZzUXEiAKPiXTd9AwAA
X-CMS-MailID: 20230918130541eucas1p1d7c51dcf06d0f0862f8bb27d725455a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230918123304eucas1p2b628f00ed8df536372f1f2b445706021
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230918123304eucas1p2b628f00ed8df536372f1f2b445706021
References: <ZQMn+Wkvod10vdLd@shell.armlinux.org.uk>
	<E1qgoNP-007a46-Mj@rmk-PC.armlinux.org.uk>
	<CGME20230918123304eucas1p2b628f00ed8df536372f1f2b445706021@eucas1p2.samsung.com>
	<42ef8c8f-2fc0-a210-969b-7b0d648d8226@samsung.com>
	<b54eca90-93cb-40ed-8c18-23b196b4728b@lunn.ch>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18.09.2023 14:55, Andrew Lunn wrote:
>> This probably need to be fixed somewhere in drivers/net/usb/asix* but at
>> the first glance I don't see any obvious place that need a fix.
> static int __asix_mdio_read(struct net_device *netdev, int phy_id, int loc,
>                              bool in_pm)
> {
>          struct usbnet *dev = netdev_priv(netdev);
>          __le16 res;
>          int ret;
>
>          mutex_lock(&dev->phy_mutex);
>
> Taking this lock here is the problem. Same for write.
>
> There is some funky stuff going on in asix_devices.c. It using both
> phylib and the much older mii code.

This must be something different. Removing those calls to phy_mutex from 
__asix_mdio_read/write doesn't fix this deadlock (I intentionally 
ignored the fact that some kind of synchronization is probably required 
there).

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


