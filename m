Return-Path: <netdev+bounces-20796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3601E761044
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5301C20DF2
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4627E15AF7;
	Tue, 25 Jul 2023 10:08:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF5015AC5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:08:28 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BD310CB
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZTG07ih6maDURnxD42sPRSsHT7XH4z+cZ7kTvarUF80=; b=YyUQ1kCc4XyZkxZHY5tochrYWX
	wd7k2n56PBb4rrqmV6iM7OFmUQliLVXyTzcduqi3WE46LGjiZErWkLnzz4jdq3HieZOQrEtpmSuCV
	kd4M9p42e3/7fvqrFq0E9brzjbn4Obw85b91putqfXJ7nCKXfiP4VcC+hXq1wSTs9mpL83ccaYOyq
	WJXfaDkJWFGklkuMsxztJHf+rk3QAWJAJ/YIQ5HDlGMjQNDE02DeS2E26mIx/rddpveivfPafJGau
	68JsG9qISFoRrdo2KPSGhP9Uzg+2EhBuDEf53YJ5GyyWVAXQ6b8SkUD6x26s4e/VX923XnJGZP3k/
	y4EN2GUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42108)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qOExs-0001sk-0V;
	Tue, 25 Jul 2023 11:08:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qOExr-0001jA-8A; Tue, 25 Jul 2023 11:08:23 +0100
Date: Tue, 25 Jul 2023 11:08:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	Jose.Abreu@synopsys.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for
 SGMII mode
Message-ID: <ZL+fF4365f0Q9QDD@shell.armlinux.org.uk>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
 <20230724102341.10401-5-jiawenwu@trustnetic.com>
 <ZL5TujWbCDuFUXb2@shell.armlinux.org.uk>
 <03cc01d9be9c$6e51cad0$4af56070$@trustnetic.com>
 <ZL9+XZA8t1vaSVmG@shell.armlinux.org.uk>
 <03f101d9bedd$763b06d0$62b11470$@trustnetic.com>
 <ZL+cwbCd6eTU4sC8@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL+cwbCd6eTU4sC8@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 10:58:25AM +0100, Russell King (Oracle) wrote:
> > The information obtained from the IC designer is that "PHY/MAC side SGMII"
> > is configured by experimentation. For these different kinds of NICs:
> > 1) fiber + SFP-RJ45 module: PHY side SGMII
> > 2) copper (pcs + external PHY): MAC side SGMII
> 
> This makes no sense. a PHY on a RJ45 SFP module is just the same as a
> PHY integrated into a board with the MAC.


MAC ---- PCS <----- sgmii -----> PHY (whether on a board or SFP)

Control word flow:
             <------------------ link, speed, duplex
	     ------------------> acknowledge (value = 0x4001)

Sometimes, it's possible to connect two MACs/PCSs together:

MAC ---- PCS <----- sgmii -----> PCS ---- MAC

and in this case, one PCS would need to be configured in "MAC" mode
and the other would need to be configured in "PHY" mode because SGMII
is fundamentally asymmetric.

Here is the definition of the control word sent by either end:

Bit	MAC->PHY	PHY->MAC
15	0: Reserved	Link status, 1 = link up
14	1: Acknowledge	Reserved for AN acknowledge
13	0: Reserved	0: Reserved
12	0: Reserved	Duplex mode 1 = full, 0 = half
11:10	0: Reserved	Speed 11 = Reserved 10=1G, 01=100M, 00=10M
9:1	0: Reserved	0: Reserved
0	1		1

So my guess would be that "PHY side SGMII" means the device generates
the "PHY->MAC" format word whereas "MAC side SGMII" generates the
"MAC->PHY" format word - and it's the latter that you want to be using
both for Copper SFPs, which are no different from PHYs integrated onto
the board connected with SGMII.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

