Return-Path: <netdev+bounces-22771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A94B76921D
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0835281607
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8250817755;
	Mon, 31 Jul 2023 09:45:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E8B17AB5
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 09:45:12 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160301BFB
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:44:50 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9338e4695so62578321fa.2
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690796677; x=1691401477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaM8kWnl2WykqnkZDjP6826c5ZTSp7yXXFle28Xi1js=;
        b=UrXNBAAtzY4w3HnY2Lu6lMBIyh/IheF5YQdXaqF4lQD3vHw2i0B7RvPzE6rkvNbDIW
         TAB1GF/ayxrbE8N3vvalOpW5aDf9DZW9oTdDPdI01MbUH1kFP02MeCcTCqpp0mRzv+/7
         1+naUV0J8HQGE9ldFtWZQYHCC1eS2noaAmjlXnJXOQV3P3JC9Os0SrRB9CqJDIkxDku5
         5md5otx6AN2OcEvGw/MGR51exlUuNHw9dMPlIPGUqrDJFmpcQAPVLbCnJQNuwQEBjPOy
         GZvz3F/r8YQWyORH8Wn95FKG70QMf+E8GFi7vmzt1UDIVVy7LnO7CxSpMD05/5ObEJ8H
         hVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796677; x=1691401477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaM8kWnl2WykqnkZDjP6826c5ZTSp7yXXFle28Xi1js=;
        b=VoOKom67r+eDTs+pDq7lq+ELbZS/Do1NNvMABpthGkXsFIksXoWKL7GpxMiAHiE6IT
         4uD9eXCZfH3H1mknNG3PnfqJyJamBU3oeh+rmrZ5pr4ymMlUMqRURPV6xAWa7KCESeY6
         NlfwW8fFAhS11ZTwGVYB+h+n8CpSPWz0JYZCbFep+FHCByfysvIipuyrcVH1HpMOa9of
         Mmbp9d/mr0EuYKucaVJ/6zAZem4P8Gx8+EaJCEhTGUH/vLT73WojJcjZKswuDP77GLy8
         eHkOmTr9NURQTcG5FTxa4BE0SOYXts+vJ/TMPIyzu8cBMdfi/12poWH0wG+mY9r+//PP
         6ncg==
X-Gm-Message-State: ABy/qLav4zHV+R/7hNf3cC1zoXOClOMFfrSK7ImCQmU4AN476zTA4njj
	YE9d3AiE8MSBENQhdMmvXHyrShIwZ3QRhrx9Jgg=
X-Google-Smtp-Source: APBJJlFpWcDNMyy1HgRdEyHyryCsq8ABxAl6iDEaTnLxUsXBuiCah6p1KOTCM3ZRGcIqAB0PsclVX/r6NDdyGRbDkOo=
X-Received: by 2002:a2e:918d:0:b0:2b9:e93e:65e6 with SMTP id
 f13-20020a2e918d000000b002b9e93e65e6mr1524094ljg.35.1690796676875; Mon, 31
 Jul 2023 02:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690439335.git.chenfeiyang@loongson.cn> <7cae63ede2792cb2a7189f251b282aecbb0945b1.1690439335.git.chenfeiyang@loongson.cn>
 <81d9887c-cd0a-cb90-957e-eeaa2ae94967@ti.com>
In-Reply-To: <81d9887c-cd0a-cb90-957e-eeaa2ae94967@ti.com>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Mon, 31 Jul 2023 17:44:25 +0800
Message-ID: <CACWXhKkeuRNgQuUXx=Y3PyP5G5LOpo=KCCDdGV1-zfZp8SG-Jg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] net: stmmac: Add Loongson HWIF entry
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn, 
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 2:36=E2=80=AFPM Ravi Gunasekaran <r-gunasekaran@ti.=
com> wrote:
>
>
>
> On 7/27/23 12:48 PM, Feiyang Chen wrote:
> > Add a new entry to HWIF table for Loongson.
> >
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/common.h  |  3 ++
> >  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  6 +++
> >  drivers/net/ethernet/stmicro/stmmac/hwif.c    | 48 ++++++++++++++++++-
> >  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 25 ++++++----
> >  include/linux/stmmac.h                        |  1 +
> >  5 files changed, 73 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net=
/ethernet/stmicro/stmmac/common.h
> > index 16e67c18b6f7..267f9a7913ac 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> > @@ -29,11 +29,13 @@
> >  /* Synopsys Core versions */
> >  #define      DWMAC_CORE_3_40         0x34
> >  #define      DWMAC_CORE_3_50         0x35
> > +#define      DWMAC_CORE_3_70         0x37
> >  #define      DWMAC_CORE_4_00         0x40
> >  #define DWMAC_CORE_4_10              0x41
> >  #define DWMAC_CORE_5_00              0x50
> >  #define DWMAC_CORE_5_10              0x51
> >  #define DWMAC_CORE_5_20              0x52
> > +#define DWLGMAC_CORE_1_00    0x10
> >  #define DWXGMAC_CORE_2_10    0x21
> >  #define DWXLGMAC_CORE_2_00   0x20
> >
> > @@ -547,6 +549,7 @@ int dwmac1000_setup(struct stmmac_priv *priv);
> >  int dwmac4_setup(struct stmmac_priv *priv);
> >  int dwxgmac2_setup(struct stmmac_priv *priv);
> >  int dwxlgmac2_setup(struct stmmac_priv *priv);
> > +int dwmac_loongson_setup(struct stmmac_priv *priv);
> >
> >  void stmmac_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
> >                        unsigned int high, unsigned int low);
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/driv=
ers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> > index 7aa450d6a81a..5da5f111d7e0 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> > @@ -172,6 +172,12 @@ static void dwmac1000_dma_init_rx(struct stmmac_pr=
iv *priv,
> >                      chan * DMA_CHAN_OFFSET);
> >               writel(upper_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_A=
DDR_HI +
> >                      chan * DMA_CHAN_OFFSET);
> > +             if (priv->plat->has_lgmac) {
> > +                     writel(upper_32_bits(dma_rx_phy),
> > +                            ioaddr + DMA_RCV_BASE_ADDR_SHADOW1);
> > +                     writel(upper_32_bits(dma_rx_phy),
> > +                            ioaddr + DMA_RCV_BASE_ADDR_SHADOW2);
> > +             }
> >       } else {
> >               /* RX descriptor base address list must be written into D=
MA CSR3 */
> >               writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_A=
DDR +
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/e=
thernet/stmicro/stmmac/hwif.c
> > index b8ba8f2d8041..b376ac4f80d5 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > @@ -58,7 +58,8 @@ static int stmmac_dwmac1_quirks(struct stmmac_priv *p=
riv)
> >               dev_info(priv->device, "Enhanced/Alternate descriptors\n"=
);
> >
> >               /* GMAC older than 3.50 has no extended descriptors */
> > -             if (priv->synopsys_id >=3D DWMAC_CORE_3_50) {
> > +             if (priv->synopsys_id >=3D DWMAC_CORE_3_50 ||
> > +                 priv->plat->has_lgmac) {>                   dev_info(=
priv->device, "Enabled extended descriptors\n");
> >                       priv->extend_desc =3D 1;
> >               } else {
> > @@ -104,6 +105,7 @@ static const struct stmmac_hwif_entry {
> >       bool gmac;
> >       bool gmac4;
> >       bool xgmac;
> > +     bool lgmac;
>
> Similar to Andrew's comment on dwmac_is_loongson, can lgmac also be
> renamed to some other name?
>
> I believe the 'gmac' and 'xgmac' refer to 1Gbps and 10Gbps which sounds g=
eneric,
> while 'lgmac' sounds vendor specific.
>
> >       u32 min_id;
> >       u32 dev_id;
> >       const struct stmmac_regs_off regs;
>
>
> [...]
>
> > +     }, {
> > +             .gmac =3D true,
> > +             .gmac4 =3D false,
> > +             .xgmac =3D false,
> > +             .lgmac =3D true,
> > +             .min_id =3D DWLGMAC_CORE_1_00,
> > +             .regs =3D {
> > +                     .ptp_off =3D PTP_GMAC3_X_OFFSET,
> > +                     .mmc_off =3D MMC_GMAC3_X_OFFSET,
> > +             },
> > +             .desc =3D NULL,
> > +             .dma =3D &dwmac1000_dma_ops,
> > +             .mac =3D &dwmac1000_ops,
> > +             .hwtimestamp =3D &stmmac_ptp,
> > +             .mode =3D NULL,
> > +             .tc =3D NULL,
> > +             .setup =3D dwmac_loongson_setup,
> > +             .quirks =3D stmmac_dwmac1_quirks,
> > +     }, {
> > +             .gmac =3D true,
> > +             .gmac4 =3D false,
> > +             .xgmac =3D false,
> > +             .lgmac =3D true,
> > +             .min_id =3D DWMAC_CORE_3_50,
> > +             .regs =3D {
> > +                     .ptp_off =3D PTP_GMAC3_X_OFFSET,
> > +                     .mmc_off =3D MMC_GMAC3_X_OFFSET,
> > +             },
> > +             .desc =3D NULL,
> > +             .dma =3D &dwmac1000_dma_ops,
> > +             .mac =3D &dwmac1000_ops,
> > +             .hwtimestamp =3D &stmmac_ptp,
> > +             .mode =3D NULL,
> > +             .tc =3D NULL,
> > +             .setup =3D dwmac1000_setup,
> > +             .quirks =3D stmmac_dwmac1_quirks,
> >       },
> >  };
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index e8619853b6d6..829de274e75d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -3505,17 +3505,21 @@ static int stmmac_request_irq_multi_msi(struct =
net_device *dev)
> >  {
> >       struct stmmac_priv *priv =3D netdev_priv(dev);
> >       enum request_irq_err irq_err;
> > +     unsigned long flags =3D 0;
> >       cpumask_t cpu_mask;
> >       int irq_idx =3D 0;
> >       char *int_name;
> >       int ret;
> >       int i;
> >
> > +     if (priv->plat->has_lgmac)
> > +             flags |=3D IRQF_TRIGGER_RISING;
>
> How about introducing a struct member such as "irq_flags"?
>

Hi, Ravi,

OK.

Thanks,
Feiyang

> > +
> >       /* For common interrupt */
> >       int_name =3D priv->int_name_mac;
> >       sprintf(int_name, "%s:%s", dev->name, "mac");
> >       ret =3D request_irq(dev->irq, stmmac_mac_interrupt,
> > -                       0, int_name, dev);
> > +                       flags, int_name, dev);
>
> [...]
>
> > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > index 46bccc34814d..e21076f57205 100644
> > --- a/include/linux/stmmac.h
> > +++ b/include/linux/stmmac.h
> > @@ -344,5 +344,6 @@ struct plat_stmmacenet_data {
> >       bool has_integrated_pcs;
> >       const struct dwmac_regs *dwmac_regs;
> >       bool dwmac_is_loongson;
> > +     int has_lgmac;
> >  };
> >  #endif
>
> --
> Regards,
> Ravi

