Return-Path: <netdev+bounces-59321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4821C81A6C2
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 19:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367CE1C20B11
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 18:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C3D482D7;
	Wed, 20 Dec 2023 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTE36uwx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D803C482C2
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cc6121c113so53838861fa.0
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 10:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703096292; x=1703701092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MeeB/xK/zPv6GQemlooirzdq070QmxchE0mPNWXDszU=;
        b=TTE36uwxuPyzhJBwy5X0xfY5Vzr/VrnUQJFu0TCaRS2nspj3iWidM8tzPxdY/Uby3i
         pCOzHZrC0gEuxkkdpuxUTHqRn01FsQraQr1lScb44pzNnyfjt7gNjSyuaooatdgZNfwm
         DT500ayHAQL/hwfPG/YCyt/Z1D6xe/OkptT7giHZWE6W5MiCC4WHKG2Sy334zKam4gj8
         Qo+/WD/wLAKzPk1OvGQSN1bhQaYe4QVoe7xAS1muMocwxzQZiPuKh6Q3CW3KX7lO/xu7
         hSf0+e4Uj6oU3miDXdRstkDnYVnGNi5CKA24stozEwV4FSHWursQXePkxFlFUvvBdttv
         nu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703096292; x=1703701092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeeB/xK/zPv6GQemlooirzdq070QmxchE0mPNWXDszU=;
        b=S4klJ0tfV8a49UYZEPAOTSzVx6E9FUlG1xiuVEQe6ZncZlBMIjVxc2n4AA27tT56kL
         BJ8Ow0QkZXPhQ6Lx8vxtxk5BV2cuUXhWK1gWTZjsXIKbEQ9QBvJ4tA0ZP5EcPpPtlWB2
         r85+kSucJ0P5Bkj7hM5kuJxRRSQERLAQ6SvSEE1Q4pEfWyPkwbWvLfUh5QhnzFAldwLL
         hErhF7akOXpz2jzR/QZ0dcetthcW+rqgz+GklTrEHKsOF+DHiYpJGUG7pGiJDWnpnfxN
         bdNyIu/3PR+bWcwRZv7KcIcuB016U7vCm2gUYxjXq/I0IAZEu36axswLEI7NK9vLXtfz
         5uBw==
X-Gm-Message-State: AOJu0Yy3hcgse9NRsavaHPVGsLYvtF9ARU+y0oeL04xsamXWu0Jtpns8
	jBDWc1ZOmboz7mkJXatQEwY=
X-Google-Smtp-Source: AGHT+IH7jzUmE0UaB7AJHrYEzXysRdCV+J//NAWxiVt3DU87wQqXMTdY10CIQRDiGme0vB4DerFkcA==
X-Received: by 2002:a05:6512:20b:b0:50e:4fe8:b589 with SMTP id a11-20020a056512020b00b0050e4fe8b589mr419133lfo.229.1703096291473;
        Wed, 20 Dec 2023 10:18:11 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id be16-20020a056512251000b0050be242f50esm30363lfb.58.2023.12.20.10.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 10:18:10 -0800 (PST)
Date: Wed, 20 Dec 2023 21:18:07 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v7 1/9] net: stmmac: Pass stmmac_priv and chan
 in some callbacks
Message-ID: <zjyo2kibcrgirfc5pcvbeqbq2dmhpjkilvq3zwsmugee2gc3cf@e7dhxkrr3ha2>
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <8414049581ed11a2466dc75e0e1f2ef4be7d0fd9.1702990507.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8414049581ed11a2466dc75e0e1f2ef4be7d0fd9.1702990507.git.siyanteng@loongson.cn>

Hi Yanteng

On Tue, Dec 19, 2023 at 10:17:04PM +0800, Yanteng Si wrote:
> Loongson GMAC and GNET have some special features. To prepare for that,
> pass stmmac_priv and chan to more callbacks, and adjust the callbacks
> accordingly.
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c   |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c  |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c    |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h     |  3 ++-
>  drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c     |  3 ++-
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c  |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h          | 11 ++++++-----
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   |  6 +++---
>  9 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 137741b94122..7cdfa0bdb93a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -395,7 +395,7 @@ static void sun8i_dwmac_dma_start_tx(struct stmmac_priv *priv,
>  	writel(v, ioaddr + EMAC_TX_CTL1);
>  }
>  

> -static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
> +static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)

As Simon correctly noted this prototype is incomplete. Although AFAICS
you never use a pointer to stmmac_priv in this method. So I guess you
could fix the callback prototype instead.

>  {
>  	u32 v;
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> index daf79cdbd3ec..5e80d3eec9db 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> @@ -70,7 +70,7 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
>  	writel(value, ioaddr + DMA_AXI_BUS_MODE);
>  }
>  
> -static void dwmac1000_dma_init(void __iomem *ioaddr,
> +static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			       struct stmmac_dma_cfg *dma_cfg, int atds)
>  {
>  	u32 value = readl(ioaddr + DMA_BUS_MODE);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> index dea270f60cc3..105e7d4d798f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> @@ -18,7 +18,7 @@
>  #include "dwmac100.h"
>  #include "dwmac_dma.h"
>  
> -static void dwmac100_dma_init(void __iomem *ioaddr,
> +static void dwmac100_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			      struct stmmac_dma_cfg *dma_cfg, int atds)
>  {
>  	/* Enable Application Access by writing to DMA CSR0 */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index 84d3a8551b03..dc54c4e793fd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> @@ -152,7 +152,7 @@ static void dwmac410_dma_init_channel(struct stmmac_priv *priv,
>  	       ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
>  }
>  
> -static void dwmac4_dma_init(void __iomem *ioaddr,
> +static void dwmac4_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			    struct stmmac_dma_cfg *dma_cfg, int atds)
>  {
>  	u32 value = readl(ioaddr + DMA_SYS_BUS_MODE);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> index 72672391675f..e7aef136824b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> @@ -152,7 +152,8 @@
>  #define NUM_DWMAC1000_DMA_REGS	23
>  #define NUM_DWMAC4_DMA_REGS	27
>  
> -void dwmac_enable_dma_transmission(void __iomem *ioaddr);
> +void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
> +				   void __iomem *ioaddr, u32 chan);
>  void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			  u32 chan, bool rx, bool tx);
>  void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> index 7907d62d3437..2f0df16fb7e4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> @@ -28,7 +28,8 @@ int dwmac_dma_reset(void __iomem *ioaddr)
>  }
>  
>  /* CSR1 enables the transmit DMA to check for new descriptor */
> -void dwmac_enable_dma_transmission(void __iomem *ioaddr)
> +void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
> +				   void __iomem *ioaddr, u32 chan)
>  {
>  	writel(1, ioaddr + DMA_XMT_POLL_DEMAND);
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index 3cde695fec91..a06f9573876f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -19,7 +19,7 @@ static int dwxgmac2_dma_reset(void __iomem *ioaddr)
>  				  !(value & XGMAC_SWR), 0, 100000);
>  }
>  
> -static void dwxgmac2_dma_init(void __iomem *ioaddr,
> +static void dwxgmac2_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			      struct stmmac_dma_cfg *dma_cfg, int atds)
>  {
>  	u32 value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 7be04b54738b..a44aa3671fb8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -175,8 +175,8 @@ struct dma_features;
>  struct stmmac_dma_ops {
>  	/* DMA core initialization */
>  	int (*reset)(void __iomem *ioaddr);

> -	void (*init)(void __iomem *ioaddr, struct stmmac_dma_cfg *dma_cfg,
> -		     int atds);
> +	void (*init)(struct stmmac_priv *priv, void __iomem *ioaddr,
> +		     struct stmmac_dma_cfg *dma_cfg, int atds);

There is a good chance this change is also unnecessary. I'll post my
comment about that to Patch 4/9.

>  	void (*init_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			  struct stmmac_dma_cfg *dma_cfg, u32 chan);
>  	void (*init_rx_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
> @@ -198,7 +198,8 @@ struct stmmac_dma_ops {
>  	/* To track extra statistic (if supported) */
>  	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
>  				  void __iomem *ioaddr);


> -	void (*enable_dma_transmission) (void __iomem *ioaddr);
> +	void (*enable_dma_transmission)(struct stmmac_priv *priv,
> +					void __iomem *ioaddr, u32 chan);

Why do you need the pointer to the stmmac_priv structure instance
here? I failed to find a place you using it in the subsequent patches.

* Sigh, just a general note in case if somebody would wish to make
* things a bit more optimised and less complicated. The purpose of the
* enable_dma_transmission() callback is to re-activate the DMA-engine
* - exit from suspension and start poll-demanding the DMA descriptors.
* In QoS GMAC and XGMAC the same is done by updating the Tx tail
* pointer.  It's implemented in stmmac_set_tx_tail_ptr(). So basically
* both stmmac_enable_dma_transmission() and stmmac_set_tx_tail_ptr()
* should be almost always called side-by-side. Alas the current
* generic driver part doesn't do that. If it did in a some common way
* you wouldn't have needed the enable_dma_transmission() update
* because it would have already been updated to accept the
* channel/queue parameter.

-Serge(y)

>  	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			       u32 chan, bool rx, bool tx);
>  	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
> @@ -240,7 +241,7 @@ struct stmmac_dma_ops {
>  };
>  
>  #define stmmac_dma_init(__priv, __args...) \
> -	stmmac_do_void_callback(__priv, dma, init, __args)
> +	stmmac_do_void_callback(__priv, dma, init, __priv, __args)
>  #define stmmac_init_chan(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, dma, init_chan, __priv, __args)
>  #define stmmac_init_rx_chan(__priv, __args...) \
> @@ -258,7 +259,7 @@ struct stmmac_dma_ops {
>  #define stmmac_dma_diagnostic_fr(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, dma, dma_diagnostic_fr, __args)
>  #define stmmac_enable_dma_transmission(__priv, __args...) \
> -	stmmac_do_void_callback(__priv, dma, enable_dma_transmission, __args)
> +	stmmac_do_void_callback(__priv, dma, enable_dma_transmission, __priv, __args)
>  #define stmmac_enable_dma_irq(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, dma, enable_dma_irq, __priv, __args)
>  #define stmmac_disable_dma_irq(__priv, __args...) \
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 47de466e432c..d868eb8dafc5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2558,7 +2558,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  				       true, priv->mode, true, true,
>  				       xdp_desc.len);
>  
> -		stmmac_enable_dma_transmission(priv, priv->ioaddr);
> +		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>  
>  		xsk_tx_metadata_to_compl(meta,
>  					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
> @@ -4679,7 +4679,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
>  
> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>  
>  	stmmac_flush_tx_descriptors(priv, queue);
>  	stmmac_tx_timer_arm(priv, queue);
> @@ -4899,7 +4899,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  		u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
>  	}
>  
> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>  
>  	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
>  	tx_q->cur_tx = entry;
> -- 
> 2.31.4
> 

