Return-Path: <netdev+bounces-30874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA8F789791
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 16:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68773281801
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69166DF4D;
	Sat, 26 Aug 2023 14:54:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D09137A
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 14:54:04 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E00AC9
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XvrmkOBIBL2yzNCs3oBH8eiEWLRpItGIKPxS8cClzPI=; b=Hi6eaxOMUvV63VLOFfxaiqREGf
	msmZdihLKwkrGyV4RClmbtvOyw3bM0RublCdxCaSME79MIEDc3SJahWzDxBG6Fef4zzjnq8vTHJKu
	z++P4nVjINb0nWM76nnwTKzHpmdG7YevzWkXTKpsSULAXMl3G6EE1cn1/NYEV4kqqat1S/ewJZJnZ
	DY/aueqAJjCUk2IdvFnncr1UjdqYs9c0GvvXN20e0QinPsL3FvbM2HYsCGu/ZsLMHYdCdrIfhhyTD
	UynclqsQAqK8tgK74vbVU2ChVo/OJA3hRzV+ttkilEwdvq+YIjJT4AMj3hnSmTsVahhAxIoysm/qg
	FQXH0Qnw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47450)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qZufg-0006I1-0w;
	Sat, 26 Aug 2023 15:53:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qZuff-0001Zw-En; Sat, 26 Aug 2023 15:53:51 +0100
Date: Sat, 26 Aug 2023 15:53:51 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 08/10] net: stmmac: move xgmac specific phylink
 caps to dwxgmac2 core
Message-ID: <ZOoR/3mssyKV+7Ef@shell.armlinux.org.uk>
References: <ZOddFH22PWmOmbT5@shell.armlinux.org.uk>
 <E1qZAXd-005pUP-JL@rmk-PC.armlinux.org.uk>
 <m6wo7hsk2wy2sgwjxlj37u5zg3iba7ecgjrvmhvkw7kdm7o6j7@ggcag6ziyk4c>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m6wo7hsk2wy2sgwjxlj37u5zg3iba7ecgjrvmhvkw7kdm7o6j7@ggcag6ziyk4c>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 26, 2023 at 04:36:46PM +0300, Serge Semin wrote:
> On Thu, Aug 24, 2023 at 02:38:29PM +0100, Russell King (Oracle) wrote:
> > Move the xgmac specific phylink capabilities to the dwxgmac2 support
> > core.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 10 ++++++++++
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 10 ----------
> >  2 files changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > index 34e1b0c3f346..f352be269deb 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > @@ -47,6 +47,14 @@ static void dwxgmac2_core_init(struct mac_device_info *hw,
> >  	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
> >  }
> >  
> 
> > +static void xgmac_phylink_get_caps(struct stmmac_priv *priv)
> 
> Also after splitting this method up into DW XGMAC v2.x and DW XLGMAC
> v2.x specific functions please preserve the local naming convention:
> use dwxgmac2_ and dwxlgmac2_ prefixes.

The only possibility I have would be to implement two functions with
different names but are functionally identical, since I have no further
information. The new code is functionally identical to the code it
replaces - as explained in my previous response.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

