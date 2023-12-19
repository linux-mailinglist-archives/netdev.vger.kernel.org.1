Return-Path: <netdev+bounces-58892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76723818814
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B621F231CE
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6194518650;
	Tue, 19 Dec 2023 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQdZm6FN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14CF1B268
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cc5d9cf766so46964851fa.2
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 04:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702990558; x=1703595358; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ThEDF5X685my3aypVfpzyZJUTfRzfmqP6N9smgNetEs=;
        b=QQdZm6FNVRXtbBBvxADvWgEeI5m41AkZAJmlSQl5s1tHsfXtch8QGwgvzXk7rwYDUr
         skNepWlTkfi46ZeMfSzGOLRvnWeVf4Czb0JNc6QzsaXQuB25MJAsmC9ho1E8WyBE99ue
         qfFwC/zNCkzOPc8pOwXIDnqjwyKeCdzsQ49hwY0bZTJu8R4K6hNCixLTWTvvJhwJRfXg
         qyTe2x2McNml0eN5r1s6SnLmPrsyHUHOKoMxSQm/k2kisD7G245y0VpK7wUMC0rSepPK
         oAAH3qrYzeYfkc5vCyYC20gPttHE0kYxuua9TEMqj1XxOYWeRLhNppRzv/GFhpQ+U+oI
         5mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702990558; x=1703595358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThEDF5X685my3aypVfpzyZJUTfRzfmqP6N9smgNetEs=;
        b=rzjMr/tYN22VMnQXFyUUGgvT8o31OaRY+KDMz2Vm9Teau2IlIZ83H0p4/zPWm9ZUZi
         DIutCVHy8YrkKnrfmHoBQW55dnj8RfzDq3rQkVILe9+VCV7hlnfMlgE8HgPtoU6UFIVb
         vVzsLcqEVmv1bSehe0h2LBrLPWhXqcBtnW9/b6HCISKuSwehEvtlB7FkbR3dr5fWlIw3
         G8zWlsRYArz9DAvOnXEazOgm+zYyYDwRk6rhL1eT8pVENK5+hPxgUsLjD/ZcZEwILapf
         SufC3JhDlE04msvaATY67s+wWl8WryDIUJNxWjWdX3rXnCktg58GtkoV30IF+jaN5yRH
         BZrQ==
X-Gm-Message-State: AOJu0YyVSF9SfTNR4q2BU2G+DltnderF+jHBuUl27moZ4PhyrLcYrn+p
	gRjluGizukx99v0mNUU5Zn4CoN362iA=
X-Google-Smtp-Source: AGHT+IFiE6QYBiTcVUFS6P1GPo7wdMo2zGCwVwmOdTDn3J7xZZ8r673aujlJgzZpBUlksgfe9SC3dA==
X-Received: by 2002:a05:651c:54d:b0:2cb:2d09:791 with SMTP id q13-20020a05651c054d00b002cb2d090791mr9297539ljp.3.1702990557409;
        Tue, 19 Dec 2023 04:55:57 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w25-20020a2e9599000000b002cc8772c87bsm72314ljh.76.2023.12.19.04.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:55:56 -0800 (PST)
Date: Tue, 19 Dec 2023 15:55:53 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v6 0/9] stmmac: Add Loongson platform support
Message-ID: <hc7nrz7ppzm45v37hi7xuogmgaz2w3jnolmuesxsm6s5ta34rn@vc2mmp33zpu7>
References: <cover.1702458672.git.siyanteng@loongson.cn>
 <pwdr6mampxe33jpqdf6o5xczgd4qkdttqj4tvionxl7qbry2ek@hpadl7wi4zni>
 <885a8904-9412-411d-9995-7d3ff350f309@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <885a8904-9412-411d-9995-7d3ff350f309@loongson.cn>

On Tue, Dec 19, 2023 at 08:35:17PM +0800, Yanteng Si wrote:
> 
> 在 2023/12/14 23:15, Serge Semin 写道:
> > Hi Yanteng
> > 
> > On Wed, Dec 13, 2023 at 06:12:22PM +0800, Yanteng Si wrote:
> > > v6:
> > > 
> > > * Refer to Serge's suggestion:
> > >    - Add new platform feature flag:
> > >      include/linux/stmmac.h:
> > >      +#define STMMAC_FLAG_HAS_LGMAC			BIT(13)
> > > 
> > >    - Add the IRQs macros specific to the Loongson Multi-channels GMAC:
> > >       drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h:
> > >       +#define DMA_INTR_ENA_NIE_LOONGSON 0x00060000	/* Normal Loongson Tx/Rx Summary */
> > >       #define DMA_INTR_ENA_NIE 0x00010000	/* Normal Summary */
> > >       ...
> > > 
> > >    - Drop all of redundant changes that don't require the
> > >      prototypes being converted to accepting the stmmac_priv
> > >      pointer.
> > > 
> > > * Refer to andrew's suggestion:
> > >    - Drop white space changes.
> > >    - break patch up into lots of smaller parts.
> > >       Some small patches have been put into another series as a preparation
> > >       see <https://lore.kernel.org/loongarch/cover.1702289232.git.siyanteng@loongson.cn/T/#t>
> > >       *note* : This series of patches relies on the three small patches above.
> > > * others
> > >    - Drop irq_flags changes.
> > >    - Changed patch order.
> > Thanks for submitting the updated series. I'll have a closer look at
> > it on the next week.
> 

> I have prepared a new patch version and will CC you soon, so you can go
> straight
> 
> to the v7.

If you think you settled all the Andrew's comment, you can go ahead
and submit v7. I'll look at it tomorrow.

-Serge(y)

> 
> 
> Thank,
> 
> Yanteng
> 
> > 
> > -Serge(y)
> > 
> > > 
> > > 
> > > v4 -> v5:
> > > 
> > > * Remove an ugly and useless patch (fix channel number).
> > > * Remove the non-standard dma64 driver code, and also remove
> > >    the HWIF entries, since the associated custom callbacks no
> > >    longer exist.
> > > * Refer to Serge's suggestion: Update the dwmac1000_dma.c to
> > >    support the multi-DMA-channels controller setup.
> > > 
> > > See:
> > > v4: <https://lore.kernel.org/loongarch/cover.1692696115.git.chenfeiyang@loongson.cn/>
> > > v3: <https://lore.kernel.org/loongarch/cover.1691047285.git.chenfeiyang@loongson.cn/>
> > > v2: <https://lore.kernel.org/loongarch/cover.1690439335.git.chenfeiyang@loongson.cn/>
> > > v1: <https://lore.kernel.org/loongarch/cover.1689215889.git.chenfeiyang@loongson.cn/>
> > > 
> > > Yanteng Si (9):
> > >    net: stmmac: Pass stmmac_priv and chan in some callbacks
> > >    net: stmmac: dwmac-loongson: Refactor code for loongson_dwmac_probe()
> > >    net: stmmac: dwmac-loongson: Add full PCI support
> > >    net: stmmac: Add multi-channel supports
> > >    net: stmmac: Add Loongson-specific register definitions
> > >    net: stmmac: dwmac-loongson: Add MSI support
> > >    net: stmmac: dwmac-loongson: Add GNET support
> > >    net: stmmac: dwmac-loongson: Disable flow control for GMAC
> > >    net: stmmac: Disable coe for some Loongson GNET
> > > 
> > >   drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
> > >   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 296 ++++++++++++++----
> > >   .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   2 +-
> > >   .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  61 +++-
> > >   .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   2 +-
> > >   .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   2 +-
> > >   .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  47 ++-
> > >   .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  65 ++--
> > >   .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |   2 +-
> > >   drivers/net/ethernet/stmicro/stmmac/hwif.c    |   8 +-
> > >   drivers/net/ethernet/stmicro/stmmac/hwif.h    |  11 +-
> > >   .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +
> > >   .../net/ethernet/stmicro/stmmac/stmmac_main.c |  13 +-
> > >   include/linux/stmmac.h                        |   4 +
> > >   14 files changed, 413 insertions(+), 107 deletions(-)
> > > 
> > > -- 
> > > 2.31.4
> > > 
> 

