Return-Path: <netdev+bounces-32096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F8979233B
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 16:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27611C209B8
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610E8D527;
	Tue,  5 Sep 2023 14:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51ED51F
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 14:01:00 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB206197
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MkGH9dqOj1JGHR8MKUGPeijOi4+2Yf0aUnPnT6G1g/4=; b=SbtMkLevzN/6/riyAImnTLElA8
	Wc5WRpeOdB0f1ZKmtVDR7F0PA5F3DRo5eIr1vOvfkRwVavNpLPWlPHIjzMebLm9gi7XaAoKlI7zFg
	HW1mvLWLWj9danrFJ9lFWeWuN/B+LKs7E23cgxOugnf/x95Sr1qZsGxjK6I7pOh5OycCqG2vmwDKs
	mhaV1x/50W6smXp91lv3emHHL24weJKpLJSWzFpoO0tSv7pRmHCxqHqdPsASgvGmnQZ7UTBxkpGWe
	mXUyUfTJwwRvV1N/PeUoPkg5l7draiY6N8i94e68CnwQEUNIjST0Xid584sVg+PjKDKGyYZpTEapx
	xyNPQCyg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54536)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qdWbo-0007w6-21;
	Tue, 05 Sep 2023 15:00:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qdWbo-0003jZ-LM; Tue, 05 Sep 2023 15:00:48 +0100
Date: Tue, 5 Sep 2023 15:00:48 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jijie Shao <shaojijie@huawei.com>, f.fainelli@gmail.com,
	davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	"shenjian15@huawei.com" <shenjian15@huawei.com>,
	"liuyonglong@huawei.com" <liuyonglong@huawei.com>,
	wangjie125@huawei.com, chenhao418@huawei.com,
	Hao Lan <lanhao@huawei.com>,
	"wangpeiyang1@huawei.com" <wangpeiyang1@huawei.com>
Subject: Re: [PATCH net-next] net: phy: avoid kernel warning dump when
 stopping an errored PHY
Message-ID: <ZPc0kHHMrNr0cgp/@shell.armlinux.org.uk>
References: <aed0bc3b-2d48-2fd9-9587-5910ad68c180@gmail.com>
 <8e7e02d8-2b2a-8619-e607-fbac50706252@huawei.com>
 <fd08a80d-c70b-4943-8cca-b038f54f8eaa@lunn.ch>
 <29917acb-bd80-10e5-b1ae-c844ea0e9cbb@huawei.com>
 <99eade9d-a580-4519-8399-832e196d335a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99eade9d-a580-4519-8399-832e196d335a@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 02:09:29PM +0200, Andrew Lunn wrote:
> > When we do a phy_stop(), hardware might be error and we can't access to
> > mdio.And our process is read/write mdio failed first, then do phy_stop(),
> > reset hardware and call phy_start() finally.
> 
> If the hardware/fimrware is already dead, you have to expect a stack
> trace, because the once a second poll can happen, before you notice
> the hardware/firmware is dead and call phy_stop().
> 
> You might want to also disconnect the PHY and reconnect it after the
> reset.

Andrew,

I think that's what is being tried here, but there's a race between
phy_stop() and phy_state_machine() which is screwing up phydev->state.

Honestly, the locking in phy_state_machine() is insane, allows this
race to happen, and really needs fixing... and I think that the
phydev->lock usage has become really insane over the years. We have
some driver methods now which are always called with the lock held,
others where the lock may or may not be held, and others where the
lock isn't held - and none of this is documented.

Please can you have a look at the four patches I've just posted as
attached to my previous email. I think we need to start sorting out
some of this crazyness and santising the locking.

My four patches address most of it, except the call to phy_suspend().
If that can be solved, then we can improve the locking more, and
eliminate the race entirely.

If we held the lock over the entire state machine function, then the
problem that has been reported here would not exist - phy_stop()
would not be able to "nip in" during the middle of the PHY state
machine running, and thus we would not see the PHY_HALTED state
overwritten by PHY_ERROR unexpectedly.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

