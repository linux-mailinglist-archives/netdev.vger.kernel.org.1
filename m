Return-Path: <netdev+bounces-22864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57A4769A9F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA421C20C2A
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BC618C28;
	Mon, 31 Jul 2023 15:16:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670763C3F
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:16:58 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F811703
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HtZw09ZfN/qm3cJW6/ew7Q7QbvBXAckrD8yQ+RvhMTo=; b=QTS+m2u8id7jB2S6mrkds4VPFA
	5gXjpbyK69idLB7B+LJwi87EgqnP9HSwu4RX8DLTNOJh6C7xvWTHG7BLyzNUtWki5WFxtpKgo1W/X
	wxbZkzIRcbGsK21An6kdFCRpd62LrTUh8w/hhw/r2TdozTf3HLfsRYkS58UZlNTzul+poer2ykloD
	Fsa4TeLl7V6sDZ2Fdvcu+bM4EvWEUMlvZoKJAF8dhPqkhLE7Vs4jxcPZqkOwBTrb1C7zzcSWRKOyF
	F5bB4NMLzfOSIAupFcl2gCqAlRxKdAqge0AR0yJsnLOBZ7c0/1Cao1AkemuLXtTo1ZNRAR3VpQ9Wu
	OSkDeFcg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48650)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qQUdQ-0002kM-1d;
	Mon, 31 Jul 2023 16:16:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qQUdM-00089X-8X; Mon, 31 Jul 2023 16:16:32 +0100
Date: Mon, 31 Jul 2023 16:16:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Feiyang Chen <chris.chenfeiyang@gmail.com>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, andrew@lunn.ch,
	hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn, dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v2 06/10] net: stmmac: Add Loongson HWIF entry
Message-ID: <ZMfQUI1BOd1RWM4u@shell.armlinux.org.uk>
References: <cover.1690439335.git.chenfeiyang@loongson.cn>
 <7cae63ede2792cb2a7189f251b282aecbb0945b1.1690439335.git.chenfeiyang@loongson.cn>
 <ZMOJNtClcAlWwZpP@shell.armlinux.org.uk>
 <CACWXhKmcFCHQsjc-7BU5VkNyJ70v6iEg2iQ11i-qS3VchvKCJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACWXhKmcFCHQsjc-7BU5VkNyJ70v6iEg2iQ11i-qS3VchvKCJA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 05:46:57PM +0800, Feiyang Chen wrote:
> On Fri, Jul 28, 2023 at 5:24 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, Jul 27, 2023 at 03:18:06PM +0800, Feiyang Chen wrote:
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > index e8619853b6d6..829de274e75d 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > @@ -3505,17 +3505,21 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
> > >  {
> > >       struct stmmac_priv *priv = netdev_priv(dev);
> > >       enum request_irq_err irq_err;
> > > +     unsigned long flags = 0;
> > >       cpumask_t cpu_mask;
> > >       int irq_idx = 0;
> > >       char *int_name;
> > >       int ret;
> > >       int i;
> > >
> > > +     if (priv->plat->has_lgmac)
> > > +             flags |= IRQF_TRIGGER_RISING;
> >
> > Can this be described in firmware?
> >
> 
> Hi, Russell,
> 
> I'm not sure, could you explain what you mean?

Modern systems describe the IRQ triggering in firmware for the OS
such as DT. Does your implementation have any firmware that can
do this kind of description for you (e.g. DT, ACPI?)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

