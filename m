Return-Path: <netdev+bounces-17780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B1E753082
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E823C281D24
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4AF4C8A;
	Fri, 14 Jul 2023 04:22:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D34A2C
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:22:26 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873252699
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mbYPepi17uOpgEAVyis+G92QB7nvZZ8+bXPkemIXm+U=; b=AOm/KcmrK+JyRIRUKHBETllUtE
	78hUr0s84HP8a3ItvmTO/Yp+ngML0vbJtlYS6qe2yeiNsYRds3/gKstKX7SZinGIEqWygEwxSMsHD
	v7DOEqEYkp+7SiJnYAHYhoCH/C/ahN0Ty9tRMpb0kX9qoxExdCMe2hpF3BBScQzDmfdc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qKAJq-001JgI-So; Fri, 14 Jul 2023 06:22:14 +0200
Date: Fri, 14 Jul 2023 06:22:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chris.chenfeiyang@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, chenhuacai@loongson.cn, dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [RFC PATCH 10/10] net: stmmac: dwmac-loongson: Add GNET support
Message-ID: <7d4f2e43-bb38-44cf-91a0-dbe1116e6a87@lunn.ch>
References: <cover.1689215889.git.chenfeiyang@loongson.cn>
 <98b53d15bb983c309f79acf9619b88ea4fbb8f14.1689215889.git.chenfeiyang@loongson.cn>
 <ZK+wdvepjYPigfOh@shell.armlinux.org.uk>
 <CACWXhKmPgiPXKJiBJjcAtWbY6Agb55XjqwDKdgiJuP5Se4r4Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACWXhKmPgiPXKJiBJjcAtWbY6Agb55XjqwDKdgiJuP5Se4r4Yw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Hi, Russell,
> 
> There is an issue with the synchronization between the network card
> and the PHY.

Details. We need the details in order to tell you the best workaround
for your broken hardware.

I believe that I am unable to access certain bits of the
> network card's registers within the PHY driver.

The PHY driver and the MAC driver should never access each others
registers.

	Andrew

