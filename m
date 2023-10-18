Return-Path: <netdev+bounces-42142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA397CD578
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 09:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA601C20A41
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 07:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C7B11715;
	Wed, 18 Oct 2023 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="itHVHO6q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6DE8F77
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 07:25:32 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C954AF7;
	Wed, 18 Oct 2023 00:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pfDXC/yC0D6NPEvRRuSAl/CZ8bNfgEG2WS3sXs6JgQI=; b=itHVHO6qdF0/oBOpNP2MkKT1WL
	1uP9xdCDFUbl9CFtGrTDBbdzdG76VR2w8LixuCBhUG4npS9LPnNSikeWkzBN6/DS0AMhtIVPMVCRv
	SDVsFN6B/qtqKeu3xfJhdlcnasMmlzDpuGXvDUoZXDKgb6H9v6PleaBcSXMlb1I03APmSACupT5rc
	bk+QPKs3P9s003vom8RzslevvNI6EK2RAa79YYSrH2xsvZWQk4i2wPv0kT5tmYPfMphtGTejsiXL1
	2mM9BDfOJ0lsP8rX36uSmCV1YCEK0IHgKdsHKLSnVM3voDNQo2XV8CtGs30VoaR1RZKnK7Ljf8Obr
	ENVCla3g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41020)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qt0vU-0004eT-2c;
	Wed, 18 Oct 2023 08:25:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qt0vS-0007bb-KT; Wed, 18 Oct 2023 08:25:06 +0100
Date: Wed, 18 Oct 2023 08:25:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Gan, Yi Fang" <yi.fang.gan@intel.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Looi Hong Aun <hong.aun.looi@intel.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>
Subject: Re: [PATCH net 1/1] net: stmmac: update MAC capabilities when tx
 queues are updated
Message-ID: <ZS+IUo5q/AnYm1Gb@shell.armlinux.org.uk>
References: <20231018023137.652132-1-yi.fang.gan@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018023137.652132-1-yi.fang.gan@intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 10:31:36AM +0800, Gan, Yi Fang wrote:
> From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
> 
> Upon boot up, the driver will configure the MAC capabilities based on
> the maximum number of tx and rx queues. When the user changes the
> tx queues to single queue, the MAC should be capable of supporting Half
> Duplex, but the driver does not update the MAC capabilities when it is
> configured so.
> 
> Using the stmmac_reinit_queues() to check the number of tx queues
> and set the MAC capabilities accordingly.

There is other setup elsewhere in the driver that fiddles with this in
stmmac_phy_setup(). Maybe provide a helper function so that this
decision making can be made in one function called from both these
locations, so if the decision making for HD support changes, only one
place needs changing?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

