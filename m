Return-Path: <netdev+bounces-21835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7969764F01
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DA828223F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E54FC10;
	Thu, 27 Jul 2023 09:13:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49351FC0C
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:13:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC1572B7
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 02:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H8yStCZrx/lPZS6tsaEFybt2+EVVkMybFAlOQ91jDoE=; b=Z4x+FFyPXgCvwsOF+td+pWAJLJ
	GHr20HwRaLmsrd4PyVYQzscCdgESqzIO0Ag6u6ZEHD7SKeFtAlJS6+Jn+kdh9JcfwMMKETKWGbaFD
	kpwb51kvR1oFS0hmrRSMd4Sdisu/mHAAMdm3zG/Zun8nUJpvkj6mLyDmfgw5r0bYiHGw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qOx3y-002RCE-RU; Thu, 27 Jul 2023 11:13:38 +0200
Date: Thu, 27 Jul 2023 11:13:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v2 05/10] net: stmmac: dwmac1000: Add Loongson register
 definitions
Message-ID: <30e8518e-4862-4aa5-afda-2f511dde2b44@lunn.ch>
References: <cover.1690439335.git.chenfeiyang@loongson.cn>
 <a752f67c6cfe481a2329f1f4b477ff962c46f515.1690439335.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a752f67c6cfe481a2329f1f4b477ff962c46f515.1690439335.git.chenfeiyang@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>  /* GMAC HW ADDR regs */
> -#define GMAC_ADDR_HIGH(reg)	((reg > 15) ? 0x00000800 + (reg - 16) * 8 : \
> +#define GMAC_ADDR_HIGH(reg, x)	((reg > 15) ? 0x00000800 + (reg - 16) * 8 * (x) : \
>  				 0x00000040 + (reg * 8))

please give x a more descriptive name.

       Andrew

