Return-Path: <netdev+bounces-22203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9AB76678B
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EAB1C217DD
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3C4101FD;
	Fri, 28 Jul 2023 08:44:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD628F7
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:44:49 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC16422B
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=7l1L0DzPaYUG7cf3Y+rT+swgjxvZ9R90FK9OXM4Kwqg=; b=rl
	vdE9usUg4R8FxcnzoisOFXHBAYFclZTLad/iG8qtpTJ94yzRL9KkABal+JfuFE/WwwCsKITJyXRB0
	hkBUt29dEcch7FLfflnjpVtG0c1CpKH9dVIH6Wds3gyyKmrp3ekxtab5Zuoaagj7W55Q7pEzUH+07
	VsIZKbPICi99eng=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qPJ5D-002WDD-1L; Fri, 28 Jul 2023 10:44:23 +0200
Date: Fri, 28 Jul 2023 10:44:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chris.chenfeiyang@gmail.com>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
	dongbiao@loongson.cn, loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v2 05/10] net: stmmac: dwmac1000: Add Loongson register
 definitions
Message-ID: <64ebd141-87ee-4186-9b4d-0705402c9e89@lunn.ch>
References: <cover.1690439335.git.chenfeiyang@loongson.cn>
 <a752f67c6cfe481a2329f1f4b477ff962c46f515.1690439335.git.chenfeiyang@loongson.cn>
 <30e8518e-4862-4aa5-afda-2f511dde2b44@lunn.ch>
 <CACWXhKkYY_g6Eo3G3TVT-AzGRa-HP2fTu9biQ6OtpPh7_hh5HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACWXhKkYY_g6Eo3G3TVT-AzGRa-HP2fTu9biQ6OtpPh7_hh5HQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 09:45:42AM +0800, Feiyang Chen wrote:
> On Thu, Jul 27, 2023 at 5:13 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > >  /* GMAC HW ADDR regs */
> > > -#define GMAC_ADDR_HIGH(reg)  ((reg > 15) ? 0x00000800 + (reg - 16) * 8 : \
> > > +#define GMAC_ADDR_HIGH(reg, x)       ((reg > 15) ? 0x00000800 + (reg - 16) * 8 * (x) : \
> > >                                0x00000040 + (reg * 8))
> >
> > please give x a more descriptive name.
> >
> 
> Hi, Andrew,
> 
> The x is now related to the dwmac_is_loongson flag. I'll try to use
> another method.

Rather than 'dwmac_is_longson', make it represent a feature of the
MAC.

	Andrew

