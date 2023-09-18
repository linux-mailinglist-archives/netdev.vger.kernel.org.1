Return-Path: <netdev+bounces-34552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9367A49BA
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 14:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C52281F4A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0361BDE0;
	Mon, 18 Sep 2023 12:33:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1F156F5
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:33:21 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA45AFF
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 05:33:06 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230918123305euoutp02f5ae7ca4587140d13da7382154075fe9~F-kAHTiTW1271812718euoutp02y
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:33:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230918123305euoutp02f5ae7ca4587140d13da7382154075fe9~F-kAHTiTW1271812718euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1695040385;
	bh=ERRZZ7lMvjKGlIdPVTkKEOOaxiO1vD75Vy+B41jIH0Y=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=b5VsiW913FZFEIP+H+aCTMcmejRWWBgOGgDEv1ZwUCafXhtZNvMggZ+JMyNmXetAp
	 ARJvHoBJ0ykBkOFD9gP8wc3Bb94AVGZ9947ZPy9Aqx332xAbarzPjeCJ8046LRbzqB
	 FhVgQEQU2R7mMK8/aRJL6iGRUugAtHz0T0rS9iCc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230918123305eucas1p161be5bdd034cc6a0dbc6df3041e71cef~F-j-oe75l2539125391eucas1p17;
	Mon, 18 Sep 2023 12:33:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 2E.8B.37758.18348056; Mon, 18
	Sep 2023 13:33:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230918123304eucas1p2b628f00ed8df536372f1f2b445706021~F-j-JbSNx0900109001eucas1p2G;
	Mon, 18 Sep 2023 12:33:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230918123304eusmtrp2e49f30f5cf6ba6ddaced5bd8afcfc549~F-j-Iq4rF0784807848eusmtrp2G;
	Mon, 18 Sep 2023 12:33:04 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-53-650843816ea1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 5D.F5.14344.08348056; Mon, 18
	Sep 2023 13:33:04 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230918123303eusmtip2deb74bf0e53a45346b69fbd4a7a4eade~F-j_XXNh12424624246eusmtip2C;
	Mon, 18 Sep 2023 12:33:03 +0000 (GMT)
Message-ID: <42ef8c8f-2fc0-a210-969b-7b0d648d8226@samsung.com>
Date: Mon, 18 Sep 2023 14:33:04 +0200
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
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: chenhao418@huawei.com, "David S. Miller" <davem@davemloft.net>, Eric
	Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jijie Shao
	<shaojijie@huawei.com>, lanhao@huawei.com, liuyonglong@huawei.com,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	shenjian15@huawei.com, wangjie125@huawei.com, wangpeiyang1@huawei.com
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <E1qgoNP-007a46-Mj@rmk-PC.armlinux.org.uk>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7djPc7qNzhypBje62S3O3z3EbDG5/xGb
	xZzzLSwWT489YrdY9H4Gq8WFbX2sFoenfWe1+HL6HqPFsQViFt9Ov2G0uNQ/kcli3y2gsoYf
	vcwWx/6tZrVY92oRowO/x+VrF5k9tqy8yeSxc9Zddo8Fm0o9Wo68ZfXYtKqTzWPnjs9MHu/3
	XWXz+LxJLoAzissmJTUnsyy1SN8ugSvj74mFrAWH5Su23p7G2MB4W6qLkZNDQsBEovXPN9Yu
	Ri4OIYEVjBIznvVBOV8YJTatvccO4XxmlDj57wETTMu/DXfAbCGB5YwSq08JQxR9ZJT4PKGZ
	ESTBK2An8WTja2YQm0VAVeLw1CksEHFBiZMzn4DZogKpEs1vzrOD2MIC8RIX3j8FizMLiEvc
	ejKfCWSoiEADo8T+7lWMIA6zwD0mieaV18E62AQMJbredrF1MXJwcAqYS6xpt4dolpdo3jqb
	GaReQmAzp8TFLR+ZIc52kXixZBMLhC0s8er4FnYIW0bi/06IbRIC7YwSC37fh3ImMEo0PL/F
	CFFlLXHn3C+wbcwCmhLrd+lDhB0lFh+4zAQSlhDgk7jxVhDiCD6JSdumM0OEeSU62oQgqtUk
	Zh1fB7f24IVLzBMYlWYhhcssJP/PQvLOLIS9CxhZVjGKp5YW56anFhvnpZbrFSfmFpfmpesl
	5+duYgSmvtP/jn/dwbji1Ue9Q4xMHIyHGCU4mJVEeGcasqUK8aYkVlalFuXHF5XmpBYfYpTm
	YFES59W2PZksJJCeWJKanZpakFoEk2Xi4JRqYDJ9Xf+4bWvH302dvtfvLbM6VN1X1rJ9pfsB
	Tge+tH7eQ4KuTuIxIe1rfIPeL5dMFV1ecWKp4fQT7Vb6B46L9oRHavC5rovYYLLwkXKs96N/
	K9fMyn6r5lJ/Vf3Cgg26UsoPV0obNtZ7K3eemPK2XuI4l4k1x9aJewLf+qT9iz/iaRr2db2f
	0qG0nGNODClSm82boi5tFp9owJdVe+P4B81t6wO2WM28fmSt4Ta2hX2vZ4rfsc9Xdqz8vzlx
	EaOL30qBvr4ZUjk3KwrDGgUtczcafyv0Nqhvmrxr+dqDPLZu4WXa/e+XHG2c3f4/vHrT62Nv
	tfytrl89ddfP02T+EU/fuz03HylWXL3Bm9k7U4mlOCPRUIu5qDgRAHn+GQzsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsVy+t/xe7oNzhypBm8/K1mcv3uI2WJy/yM2
	iznnW1gsnh57xG6x6P0MVosL2/pYLQ5P+85q8eX0PUaLYwvELL6dfsNocal/IpPFvltAZQ0/
	epktjv1bzWqx7tUiRgd+j8vXLjJ7bFl5k8lj56y77B4LNpV6tBx5y+qxaVUnm8fOHZ+ZPN7v
	u8rm8XmTXABnlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllq
	kb5dgl7G3xMLWQsOy1dsvT2NsYHxtlQXIyeHhICJxL8Nd5i6GLk4hASWMkpMPv+IBSIhI3Fy
	WgMrhC0s8edaFxtE0XtGiR+LrrKBJHgF7CSebHzNDGKzCKhKHJ46hQUiLihxcuYTMFtUIFXi
	9LRNjCC2sEC8xIX3T8HizALiEreezAfbLCLQwCixYsIFMIdZ4AGTxLwtG8CqhAQSJVp+XQLr
	ZhMwlOh6C3IGBwengLnEmnZ7iEFmEl1buxghbHmJ5q2zmScwCs1CcscsJPtmIWmZhaRlASPL
	KkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMBY33bs55YdjCtffdQ7xMjEwXiIUYKDWUmEd6Yh
	W6oQb0piZVVqUX58UWlOavEhRlNgYExklhJNzgcmm7ySeEMzA1NDEzNLA1NLM2MlcV7Pgo5E
	IYH0xJLU7NTUgtQimD4mDk6pBqbV/BPmCbgkxbwJvq5RVBp3jaPnl/DtYsb/U+XWsG0oC34q
	ZnG5dof9hY5TU8RPi93g2pneFB3r9HLvBw/5jP0c3m7c8Q+02mq498l4rNm13i1auX3LaafT
	bdKTIpJ7nLeuq4/4dW1Zm4LmyhkGBwOkVK7Oers+8H9vI8fyKOfUjZ/6Fh7WlEm+uTPw88cF
	0kvqH+gttF9lm8Vw2y+bSdPmzVZD34Mri098mibh8LYicsbW+zvNWnP45sq43/67YYrjDbOF
	u0Kqz0zf7repX49X7+GSGUlhJrYMa7Zv/zPN7//RHTH6iVsurNZis7f5c5nrAGdWa3Dwtb9L
	N3pqurptK397ds1dOxub69sltm1QYinOSDTUYi4qTgQAPXsqK34DAAA=
X-CMS-MailID: 20230918123304eucas1p2b628f00ed8df536372f1f2b445706021
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230918123304eucas1p2b628f00ed8df536372f1f2b445706021
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230918123304eucas1p2b628f00ed8df536372f1f2b445706021
References: <ZQMn+Wkvod10vdLd@shell.armlinux.org.uk>
	<E1qgoNP-007a46-Mj@rmk-PC.armlinux.org.uk>
	<CGME20230918123304eucas1p2b628f00ed8df536372f1f2b445706021@eucas1p2.samsung.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Russell,

On 14.09.2023 17:35, Russell King (Oracle) wrote:
> phy_stop() calls phy_process_state_change() while holding the phydev
> lock, so also arrange for phy_state_machine() to do the same, so that
> this function is called with consistent locking.
>
> Tested-by: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

This change, merged to linux-next as commit 8da77df649c4 ("net: phy: 
always call phy_process_state_change() under lock") introduces the 
following deadlock with ASIX AX8817X USB driver:

--->8---

asix 1-1.4:1.0 (unnamed net_device) (uninitialized): PHY 
[usb-001:003:10] driver [Asix Electronics AX88772A] (irq=POLL)
Asix Electronics AX88772A usb-001:003:10: attached PHY driver 
(mii_bus:phy_addr=usb-001:003:10, irq=POLL)
asix 1-1.4:1.0 eth0: register 'asix' at usb-12110000.usb-1.4, ASIX 
AX88772 USB 2.0 Ethernet, a2:99:b6:cd:11:eb

asix 1-1.4:1.0 eth0: configuring for phy/internal link mode

============================================
WARNING: possible recursive locking detected
6.6.0-rc1-00239-g8da77df649c4-dirty #13949 Not tainted
--------------------------------------------
kworker/3:3/71 is trying to acquire lock:
c6c704cc (&dev->lock){+.+.}-{3:3}, at: phy_start_aneg+0x1c/0x38

but task is already holding lock:
c6c704cc (&dev->lock){+.+.}-{3:3}, at: phy_state_machine+0x100/0x2b8

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&dev->lock);
   lock(&dev->lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

3 locks held by kworker/3:3/71:
  #0: c1c090a8 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: 
process_one_work+0x148/0x608
  #1: f0bddf20 
((work_completion)(&(&dev->state_queue)->work)){+.+.}-{0:0}, at: 
process_one_work+0x148/0x608
  #2: c6c704cc (&dev->lock){+.+.}-{3:3}, at: phy_state_machine+0x100/0x2b8

stack backtrace:
CPU: 3 PID: 71 Comm: kworker/3:3 Not tainted 
6.6.0-rc1-00239-g8da77df649c4-dirty #13949
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_power_efficient phy_state_machine
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x58/0x70
  dump_stack_lvl from __lock_acquire+0x1300/0x2984
  __lock_acquire from lock_acquire+0x130/0x37c
  lock_acquire from __mutex_lock+0x94/0x94c
  __mutex_lock from mutex_lock_nested+0x1c/0x24
  mutex_lock_nested from phy_start_aneg+0x1c/0x38
  phy_start_aneg from phy_state_machine+0x10c/0x2b8
  phy_state_machine from process_one_work+0x204/0x608
  process_one_work from worker_thread+0x1e0/0x498
  worker_thread from kthread+0x104/0x138
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xf0bddfb0 to 0xf0bddff8)
...

-------

This probably need to be fixed somewhere in drivers/net/usb/asix* but at 
the first glance I don't see any obvious place that need a fix.

> ---
>   drivers/net/phy/phy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index df54c137c5f5..1e5218935eb3 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1506,6 +1506,7 @@ void phy_state_machine(struct work_struct *work)
>   	if (err < 0)
>   		phy_error_precise(phydev, func, err);
>   
> +	mutex_lock(&phydev->lock);
>   	phy_process_state_change(phydev, old_state);
>   
>   	/* Only re-schedule a PHY state machine change if we are polling the
> @@ -1516,7 +1517,6 @@ void phy_state_machine(struct work_struct *work)
>   	 * state machine would be pointless and possibly error prone when
>   	 * called from phy_disconnect() synchronously.
>   	 */
> -	mutex_lock(&phydev->lock);
>   	if (phy_polling_mode(phydev) && phy_is_started(phydev))
>   		phy_queue_state_machine(phydev, PHY_STATE_TIME);
>   	mutex_unlock(&phydev->lock);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


