Return-Path: <netdev+bounces-20791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367E8760FFB
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 11:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316B41C20D2D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0652C15AD9;
	Tue, 25 Jul 2023 09:58:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAF415AD5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:58:49 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9251BCC
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 02:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oaoymqNN5F7RKeVZED25akK7U0MsO2FW6J7h4go8q30=; b=GK/7KDJzg8bMRSwKPqk12BNc+n
	QWEuDiyAf+9w3LtiT5cUp2zotO1SzUWlz/CqSZ0vekCWtcQzik3VKDbe831ZzNkwmrpv+Nh3C2Rkn
	o3RJpfkB791XJEuANmk5i5kqQMMRS69xlYXORKxjegHsFC+W6F4Qa1OnLeoAEZ367O/gnU+mFaPqo
	XeMrwRkafZDO37n66SgdnhFxQTnZ11O78WrzIlwHg1iKsLAfxjm6+EAwTH9z5yi620A+CW1TU5iyn
	sQQ63rjKtpvvmp+zD0A6Ax34SGazTSqxqarJzHSPeoPqOpkm2FplRB91lJiKDn8OOBZ2jEupb5BZh
	r+HlFtpQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56326)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qOEoE-0001rq-0s;
	Tue, 25 Jul 2023 10:58:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qOEoD-0001j0-5e; Tue, 25 Jul 2023 10:58:25 +0100
Date: Tue, 25 Jul 2023 10:58:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	Jose.Abreu@synopsys.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for
 SGMII mode
Message-ID: <ZL+cwbCd6eTU4sC8@shell.armlinux.org.uk>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
 <20230724102341.10401-5-jiawenwu@trustnetic.com>
 <ZL5TujWbCDuFUXb2@shell.armlinux.org.uk>
 <03cc01d9be9c$6e51cad0$4af56070$@trustnetic.com>
 <ZL9+XZA8t1vaSVmG@shell.armlinux.org.uk>
 <03f101d9bedd$763b06d0$62b11470$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f101d9bedd$763b06d0$62b11470$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 05:50:36PM +0800, Jiawen Wu wrote:
> On Tuesday, July 25, 2023 3:49 PM, Russell King (Oracle) wrote:
> > On Tue, Jul 25, 2023 at 10:05:05AM +0800, Jiawen Wu wrote:
> > > On Monday, July 24, 2023 6:35 PM, Russell King (Oracle) wrote:
> > > > On Mon, Jul 24, 2023 at 06:23:38PM +0800, Jiawen Wu wrote:
> > > > > Wangxun NICs support the connection with SFP to RJ45 module. In this case,
> > > > > PCS need to be configured in SGMII mode.
> > > > >
> > > > > Accroding to chapter 6.11.1 "SGMII Auto-Negitiation" of DesignWare Cores
> > > > > Ethernet PCS (version 3.20a) and custom design manual, do the following
> > > > > configuration when the interface mode is SGMII.
> > > > >
> > > > > 1. program VR_MII_AN_CTRL bit(3) [TX_CONFIG] = 1b (PHY side SGMII)
> > > > > 2. program VR_MII_AN_CTRL bit(8) [MII_CTRL] = 1b (8-bit MII)
> > > > > 3. program VR_MII_DIG_CTRL1 bit(0) [PHY_MODE_CTRL] = 1b
> > > >
> > > > I'm confused by "PHY side SGMII" - what does this mean for the
> > > > transmitted 16-bit configuration word? Does it mean that _this_ side
> > > > is acting as if it were a PHY?
> > >
> > > I'm not sure, because the datasheet doesn't explicitly describe it. In this
> > > case, the PHY is integrated in the SFP to RJ45 module. From my point of
> > > view, TX control occurs on the PHY side. So program it as PHY side SGMII.
> > 
> > Let me ask the question a different way. Would you use "PHY side SGMII"
> > if the PHY was directly connected to the PCS with SGMII?
> 
> The information obtained from the IC designer is that "PHY/MAC side SGMII"
> is configured by experimentation. For these different kinds of NICs:
> 1) fiber + SFP-RJ45 module: PHY side SGMII
> 2) copper (pcs + external PHY): MAC side SGMII

This makes no sense. a PHY on a RJ45 SFP module is just the same as a
PHY integrated into a board with the MAC.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

