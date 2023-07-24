Return-Path: <netdev+bounces-20374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C7775F367
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B571C204F7
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352C21871;
	Mon, 24 Jul 2023 10:34:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F2A8C00
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:34:45 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E435102
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JPaiL8+OD9Td5/aSJPDZVE5GPGnTtByI9aydDFSvE4E=; b=S29jOkXV5oiTnjT0FvqvyIZtNB
	LfVrAY8kEwzzMy6B0TQfKnA0M2hKYlqbL3cdcyE4ibktQrsYs/Xw+tlsKudpRnRM1tNR84F85b3LJ
	YFNBpjap/8wEH8OjJ5vsMjU0agXCfBggRO3prGMIOcGCDAwK8zZIA8WgTFsxHBpe9To3Yiw0l9hNS
	ZuvsSS9YrY1ySmmbqxpKQz9a/DCPJ1ljh3KFbQY5sDAPBSwWm2AdtaXRdmxuPe168eZZ3clwLBQq3
	APkzOCLR+vN2mpfeJhWUvax/MG21iltm8r/CQg1ZyfKg0nWT7lNcowi/Nsp4CoeLSgLBVeBG7pJfy
	u1Mm5LbA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57602)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qNsth-0008Jw-1Q;
	Mon, 24 Jul 2023 11:34:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qNste-0000iF-7R; Mon, 24 Jul 2023 11:34:34 +0100
Date: Mon, 24 Jul 2023 11:34:34 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	Jose.Abreu@synopsys.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for
 SGMII mode
Message-ID: <ZL5TujWbCDuFUXb2@shell.armlinux.org.uk>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
 <20230724102341.10401-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724102341.10401-5-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 06:23:38PM +0800, Jiawen Wu wrote:
> Wangxun NICs support the connection with SFP to RJ45 module. In this case,
> PCS need to be configured in SGMII mode.
> 
> Accroding to chapter 6.11.1 "SGMII Auto-Negitiation" of DesignWare Cores
> Ethernet PCS (version 3.20a) and custom design manual, do the following
> configuration when the interface mode is SGMII.
> 
> 1. program VR_MII_AN_CTRL bit(3) [TX_CONFIG] = 1b (PHY side SGMII)
> 2. program VR_MII_AN_CTRL bit(8) [MII_CTRL] = 1b (8-bit MII)
> 3. program VR_MII_DIG_CTRL1 bit(0) [PHY_MODE_CTRL] = 1b

I'm confused by "PHY side SGMII" - what does this mean for the
transmitted 16-bit configuration word? Does it mean that _this_ side
is acting as if it were a PHY?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

