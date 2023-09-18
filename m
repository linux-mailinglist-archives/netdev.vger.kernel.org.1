Return-Path: <netdev+bounces-34614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3698C7A4DA4
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3E91C2083E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A88E208C4;
	Mon, 18 Sep 2023 15:51:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38663CC
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:51:53 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3CECC8
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:49:03 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230918131546euoutp02685f148cb79305f3dec9f43cdb101929~GAJROQeKz3032230322euoutp02C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:15:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230918131546euoutp02685f148cb79305f3dec9f43cdb101929~GAJROQeKz3032230322euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1695042946;
	bh=ammtEltxr9y2oE2MIgO336Ttfbz9LypgwAdzmn/r1cs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=U7mMKXXKPXWN+153jpcTc/aQbW9Cu1M8Hedl5rVmOPCCPC5k/jOkq4qvQQmv7U38U
	 ZtNOFcfKh2vuvfX75KmjSmHn0YrpFSYHkdpe7kjkMrowpm4Ll1KoX9cPMlY056lH34
	 i+it9WumNsJye/Cz59pc8zXM0zFu4yMwsOsOkTHg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230918131546eucas1p1b19e77a93e99ff78365e3749afd5a48d~GAJQ512oq2182421824eucas1p1j;
	Mon, 18 Sep 2023 13:15:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 9F.D4.42423.28D48056; Mon, 18
	Sep 2023 14:15:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230918131545eucas1p2734ca56e5acd108f88e55565aa9e2750~GAJQShRJV2070820708eucas1p26;
	Mon, 18 Sep 2023 13:15:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230918131545eusmtrp2350a254f3ee460c593d3c7470807973a~GAJQRwupk3100331003eusmtrp2c;
	Mon, 18 Sep 2023 13:15:45 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-4c-65084d82c57e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id EB.9E.14344.18D48056; Mon, 18
	Sep 2023 14:15:45 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230918131544eusmtip2f526214293d4c808c8adb1f27d4ba44d~GAJPid8Z82481724817eusmtip2E;
	Mon, 18 Sep 2023 13:15:44 +0000 (GMT)
Message-ID: <b8aba366-b5e9-3563-5708-904f6aec617c@samsung.com>
Date: Mon, 18 Sep 2023 15:15:46 +0200
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
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	chenhao418@huawei.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jijie Shao
	<shaojijie@huawei.com>, lanhao@huawei.com, liuyonglong@huawei.com,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	shenjian15@huawei.com, wangjie125@huawei.com, wangpeiyang1@huawei.com
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZQhLUlw452Ewu7yi@shell.armlinux.org.uk>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djPc7pNvhypBtNahC3O3z3EbDG5/xGb
	xZzzLSwWT489YrdY9H4Gq8WFbX2sFoenfWe1ODR1L6PFl9P3GC2OLRCz+Hb6DaPFvltAZQ0/
	epktjv1bzWqx7tUiRgd+j8vXLjJ7bFl5k8lj56y77B4LNpV6tBx5y+qxaVUnm8fOHZ+ZPN7v
	u8rm8XmTXABnFJdNSmpOZllqkb5dAlfG0rebGAumilfMaJRqYOwR7mLk4JAQMJFomCXRxcjF
	ISSwglHix//XTBDOF0aJc38PMUM4nxklnl/vZuxi5ATr2LWzFyqxnFFi158+dgjnI6PE0QsT
	2EGqeAXsJFa8mQJmswioSvx62ccGEReUODnzCQuILSqQKtH85jxYjbBAvMSF90/B4swC4hK3
	nsxnArFFBIwl2l7vAVvALLCMWeLwgUtgCTYBQ4mut11sIE9wCphKfP1gD9ErL7H97Ryw6yQE
	1nNK7FjTxApxtovEqp/zmSFsYYlXx7ewQ9gyEv93zmeCaGhnlFjw+z6UM4FRouH5LainrSXu
	nPsFto1ZQFNi/S59iLCjxOIDl5kgIcknceOtIMQRfBKTtk1nhgjzSnS0CUFUq0nMOr4Obu3B
	C5eYJzAqzUIKlllI3p+F5J1ZCHsXMLKsYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECEx7
	p/8d/7SDce6rj3qHGJk4GA8xSnAwK4nwzjRkSxXiTUmsrEotyo8vKs1JLT7EKM3BoiTOq217
	MllIID2xJDU7NbUgtQgmy8TBKdXAJBtm9m/aRQaWVQy7l6xZZsvAY/Sbc2NjsMTnO/naNyZc
	Pnp32Y0Eo80nWqpn/ftWfjTJUqdkvWWC4KVXe/fYubJ5xX7UVvnnpym4d0mFeMjmqQ1uaWYm
	Dex2+YLvTztVet5Zcng7/924suSc7zI//kjwcXa+/H6Hp+2ZtVT8vzUxMz4cOCc9I/btFWnR
	tdHPE+tnrbi2WOCIJg8nX4323Wh13fmrsu79YT2qZOhqUuH5pm2t6mPRjH8hd4Iku9ed3+Hv
	GrRz2QVluzMHrvEJqmxhnmKyvWidDOu3mZGOeqGl2yOmHTg6KePNnbvShzjVLnAfeDPx3nW9
	HxEFN0pD5b6n3L4yI17ykvSrVu87EUosxRmJhlrMRcWJAHbrnYfqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsVy+t/xe7qNvhypBqc3qFqcv3uI2WJy/yM2
	iznnW1gsnh57xG6x6P0MVosL2/pYLQ5P+85qcWjqXkaLL6fvMVocWyBm8e30G0aLfbeAyhp+
	9DJbHPu3mtVi3atFjA78HpevXWT22LLyJpPHzll32T0WbCr1aDnyltVj06pONo+dOz4zebzf
	d5XN4/MmuQDOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
	In27BL2MpW83MRZMFa+Y0SjVwNgj3MXIySEhYCKxa2cvcxcjF4eQwFJGiRmrprNAJGQkTk5r
	YIWwhSX+XOtigyh6zyhx99xkNpAEr4CdxIo3U9hBbBYBVYlfL/ug4oISJ2c+ARskKpAqcXra
	JkYQW1ggXuLC+6dgcWYBcYlbT+YzgdgiAsYSba/3sIMsYBZYwSzxct0zJohtU5kkjkycCtbN
	JmAo0fUW5AwODk4BU4mvH+whBplJdG3tYoSw5SW2v53DPIFRaBaSO2Yh2TcLScssJC0LGFlW
	MYqklhbnpucWG+kVJ+YWl+al6yXn525iBEb6tmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8Mw3Z
	UoV4UxIrq1KL8uOLSnNSiw8xmgIDYyKzlGhyPjDV5JXEG5oZmBqamFkamFqaGSuJ83oWdCQK
	CaQnlqRmp6YWpBbB9DFxcEo1MOm2LzdrCDaNkjxfteD2jaqkzdHTruxNObpz0aSP9yX8YsUv
	/bhfqqKiPZnHl4Vjyc5/4vFnXf1ORLTnRue0lDbezAr+6/CX3TLCSuPz9cqq10fjbs/Oa4hb
	ohQkrWiiFaraskdevmW5E4vJ4tMbd7x1+i4YJvzo/rGw5deqa2/zaPAoydwT+/JIwthVyoQj
	c7ndwmWtMl+nh/4sSrq6RCE4+oBZm1jBi42JfpqxB6/s2ya7yeD3sqbYY1q7w6SClRu3bbya
	ldF6pebLlEUHTB8Kzyk2u+Ycf+Tp4Ut67v3bVZaeEry1yUd3z9k/f43sFVUlLbu2v1j0U+7b
	j8ob2ev6bzhrsau94xFoOvpljxJLcUaioRZzUXEiAAOx7O59AwAA
X-CMS-MailID: 20230918131545eucas1p2734ca56e5acd108f88e55565aa9e2750
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
	<ZQhLUlw452Ewu7yi@shell.armlinux.org.uk>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18.09.2023 15:06, Russell King (Oracle) wrote:
> On Mon, Sep 18, 2023 at 02:33:04PM +0200, Marek Szyprowski wrote:
>> Hi Russell,
>>
>> On 14.09.2023 17:35, Russell King (Oracle) wrote:
>>> phy_stop() calls phy_process_state_change() while holding the phydev
>>> lock, so also arrange for phy_state_machine() to do the same, so that
>>> this function is called with consistent locking.
>>>
>>> Tested-by: Jijie Shao <shaojijie@huawei.com>
>>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>> This change, merged to linux-next as commit 8da77df649c4 ("net: phy:
>> always call phy_process_state_change() under lock") introduces the
>> following deadlock with ASIX AX8817X USB driver:
> Yay, latent bug found...
>
> I guess this is asix_ax88772a_link_change_notify() which is causing
> the problem, and yes, that phy_start_aneg() needs to be the unlocked
> version (which we'll have to export.)
>
> This should fix it.

Thanks!

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> diff --git a/drivers/net/phy/ax88796b.c b/drivers/net/phy/ax88796b.c
> index 0f1e617a26c9..eb74a8cf8df1 100644
> --- a/drivers/net/phy/ax88796b.c
> +++ b/drivers/net/phy/ax88796b.c
> @@ -90,7 +90,7 @@ static void asix_ax88772a_link_change_notify(struct phy_device *phydev)
>   	 */
>   	if (phydev->state == PHY_NOLINK) {
>   		phy_init_hw(phydev);
> -		phy_start_aneg(phydev);
> +		_phy_start_aneg(phydev);
>   	}
>   }
>   
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 93a8676dd8d8..a5fa077650e8 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -981,7 +981,7 @@ static int phy_check_link_status(struct phy_device *phydev)
>    *   If the PHYCONTROL Layer is operating, we change the state to
>    *   reflect the beginning of Auto-negotiation or forcing.
>    */
> -static int _phy_start_aneg(struct phy_device *phydev)
> +int _phy_start_aneg(struct phy_device *phydev)
>   {
>   	int err;
>   
> @@ -1002,6 +1002,7 @@ static int _phy_start_aneg(struct phy_device *phydev)
>   
>   	return err;
>   }
> +EXPORT_SYMBOL(_phy_start_aneg);
>   
>   /**
>    * phy_start_aneg - start auto-negotiation for this PHY device
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 1351b802ffcf..3cc52826f18e 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1736,6 +1736,7 @@ void phy_detach(struct phy_device *phydev);
>   void phy_start(struct phy_device *phydev);
>   void phy_stop(struct phy_device *phydev);
>   int phy_config_aneg(struct phy_device *phydev);
> +int _phy_start_aneg(struct phy_device *phydev);
>   int phy_start_aneg(struct phy_device *phydev);
>   int phy_aneg_done(struct phy_device *phydev);
>   int phy_speed_down(struct phy_device *phydev, bool sync);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


