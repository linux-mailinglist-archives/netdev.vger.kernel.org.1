Return-Path: <netdev+bounces-20723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314C9760C57
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C8F28180B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CF4125A7;
	Tue, 25 Jul 2023 07:49:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29549134C1
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:49:03 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD607DB
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iwGge301CCBYPDB62wuletPDpNmbgJlwCnwXEv+Ng4w=; b=Zfz2Uz+UXqBh75Da/mQq90dM0b
	19aH4k+yzGQ2Q0KafHXqOKeBCMQxDM36spWP62obYx+WWBWa+ULZ1Ce0aOtHu3NfjKazNQx7KMiBN
	N+rSucPXpqFArZtsDrsHPSaSlgRQujCdK4XuaX+7/FwIUY7UmyWIShu0sDvxho5LlmATLcjJzoV/Y
	SlyY/0YPFoWA9JuCCayjK5uOZjEbQ/rPj3C0V+dMmRARTurOhEux4JzT39G577cJPqXIJaNwgcd1y
	Teh+pacGGyqxNdxXKbPHnTk9IXHMbN3zdMqDX6N5lX2HfYQ5Q9Qm9t2jaPYhQ1AezmC2+xnRMwHsR
	BLTHjcrw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48434)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qOCmq-0001eF-0x;
	Tue, 25 Jul 2023 08:48:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qOCmj-0001du-RF; Tue, 25 Jul 2023 08:48:45 +0100
Date: Tue, 25 Jul 2023 08:48:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	Jose.Abreu@synopsys.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for
 SGMII mode
Message-ID: <ZL9+XZA8t1vaSVmG@shell.armlinux.org.uk>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
 <20230724102341.10401-5-jiawenwu@trustnetic.com>
 <ZL5TujWbCDuFUXb2@shell.armlinux.org.uk>
 <03cc01d9be9c$6e51cad0$4af56070$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03cc01d9be9c$6e51cad0$4af56070$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 10:05:05AM +0800, Jiawen Wu wrote:
> On Monday, July 24, 2023 6:35 PM, Russell King (Oracle) wrote:
> > On Mon, Jul 24, 2023 at 06:23:38PM +0800, Jiawen Wu wrote:
> > > Wangxun NICs support the connection with SFP to RJ45 module. In this case,
> > > PCS need to be configured in SGMII mode.
> > >
> > > Accroding to chapter 6.11.1 "SGMII Auto-Negitiation" of DesignWare Cores
> > > Ethernet PCS (version 3.20a) and custom design manual, do the following
> > > configuration when the interface mode is SGMII.
> > >
> > > 1. program VR_MII_AN_CTRL bit(3) [TX_CONFIG] = 1b (PHY side SGMII)
> > > 2. program VR_MII_AN_CTRL bit(8) [MII_CTRL] = 1b (8-bit MII)
> > > 3. program VR_MII_DIG_CTRL1 bit(0) [PHY_MODE_CTRL] = 1b
> > 
> > I'm confused by "PHY side SGMII" - what does this mean for the
> > transmitted 16-bit configuration word? Does it mean that _this_ side
> > is acting as if it were a PHY?
> 
> I'm not sure, because the datasheet doesn't explicitly describe it. In this
> case, the PHY is integrated in the SFP to RJ45 module. From my point of
> view, TX control occurs on the PHY side. So program it as PHY side SGMII.

Let me ask the question a different way. Would you use "PHY side SGMII"
if the PHY was directly connected to the PCS with SGMII?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

