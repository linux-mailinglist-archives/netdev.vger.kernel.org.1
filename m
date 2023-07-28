Return-Path: <netdev+bounces-22212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C287668B8
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 11:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C9B2826B0
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4441094D;
	Fri, 28 Jul 2023 09:24:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D72310946
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 09:24:29 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567A749C5
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 02:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OOpOWmhCbjr6DLFBLZM5epBTVAua+KkWnAWWHmmwNIQ=; b=T7rzbU9/C3bE7gmzAm3BpcASwu
	rRSGUd9Ajb+kDlNJ4Ci7nfa5EePHDDHNjAsrz2+57hhQpEkAmtTpXRsA0LK/tDpTJem+rnYF0l2mV
	gCyVxKVAUqLUq0Gf9nDkeYUzNyIAAGSsqf/PYzT8I3Ur9iau/qpB71MSUt5dTM+ExrqsqZaA+HnJV
	U4TnhaibMqeEioab07Es3Q7tqIJspfPbZY5A8Cv5qlqRvy+EDdOsHgndR/r1dyWO4pKRaL3rmZcJJ
	RtObWMe2vqJGUUzXug2bybsXPKgsFiHUXu83IaADi0XZmW9D3MT7XUZWn2Ns9ajH2Ar/Sifc0LFqz
	K8AWRZEg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38718)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qPJhi-0006yW-0B;
	Fri, 28 Jul 2023 10:24:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qPJhe-0004nh-OK; Fri, 28 Jul 2023 10:24:06 +0100
Date: Fri, 28 Jul 2023 10:24:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn, dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v2 06/10] net: stmmac: Add Loongson HWIF entry
Message-ID: <ZMOJNtClcAlWwZpP@shell.armlinux.org.uk>
References: <cover.1690439335.git.chenfeiyang@loongson.cn>
 <7cae63ede2792cb2a7189f251b282aecbb0945b1.1690439335.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cae63ede2792cb2a7189f251b282aecbb0945b1.1690439335.git.chenfeiyang@loongson.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 03:18:06PM +0800, Feiyang Chen wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index e8619853b6d6..829de274e75d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3505,17 +3505,21 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	enum request_irq_err irq_err;
> +	unsigned long flags = 0;
>  	cpumask_t cpu_mask;
>  	int irq_idx = 0;
>  	char *int_name;
>  	int ret;
>  	int i;
>  
> +	if (priv->plat->has_lgmac)
> +		flags |= IRQF_TRIGGER_RISING;

Can this be described in firmware?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

