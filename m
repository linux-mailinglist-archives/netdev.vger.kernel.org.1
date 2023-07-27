Return-Path: <netdev+bounces-21831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A87764ECB
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C662821F3
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F243AFBF3;
	Thu, 27 Jul 2023 09:10:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7832FBE4
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:10:40 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526C9A826
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 02:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X/k/8uLCIMHfS1bCGkd3PvnH4U8zm3GAOxOGXyOeA6k=; b=AaFjLqdraeEC9g+wiI2LNdmRr/
	lPnSh1XJCI9NUSm8RT2bYxT9CDxnFo7N+B9grAYnZeUQaU3zluOlGjW3Pz/HJGkdNuNZH7DGXjEjZ
	vYP4N0hExAtnHHiGCGS6ZgS6/af6UkzqcNDV3JtkJrtC1hjcPqVrCCSjwQ6UTso4TQ/I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qOx0Z-002RAa-TD; Thu, 27 Jul 2023 11:10:07 +0200
Date: Thu, 27 Jul 2023 11:10:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v2 02/10] net: stmmac: dwmac1000: Allow platforms to
 choose some register offsets
Message-ID: <5b52d461-77e5-493a-a634-4c8a0637a0bc@lunn.ch>
References: <cover.1690439335.git.chenfeiyang@loongson.cn>
 <067f87d9785849c13f2f8733d457ffe8616a1aa0.1690439335.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <067f87d9785849c13f2f8733d457ffe8616a1aa0.1690439335.git.chenfeiyang@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +#define _REGS			(priv->plat->dwmac_regs)
>  
> -/* Rx watchdog register */
> +/* DMA CRS Control and Status Register Mapping */
> +#define DMA_CHAN_OFFSET		(_REGS->addrs->chan_offset)

It is thought to be bad practice for a macro to access things not
passed to it. Please try to make a cleaner solution.

       Andrew

