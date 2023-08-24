Return-Path: <netdev+bounces-30188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DA77864E8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 03:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6F3280D5D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 01:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143FC17D5;
	Thu, 24 Aug 2023 01:48:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D957F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 01:48:38 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066C6171E
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 18:48:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so9832928e87.3
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 18:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692841677; x=1693446477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBuu+H0+lIDFAFh6BV8P/GWalq0YHGG3/mASWuMo5lM=;
        b=SLNzeDUS72IJwAzeVreY3UuVxr5gwQM95fVyt9/ht8rypcjabC7IeDW11JlZECJRvO
         MxKLqLrXpEUNmzeCS+u0zAMXYck7wOgEJ6ZQWZkZeRDDnYaWKX2Smxfn0jhr7WErXCNQ
         23oTbin/VeYg+Iyns29z6GodXQD6Lp2FtNJgmYbC6rHrE/WQbpnXZVRnT7btKJpTEG72
         fv8MPiziafTzvzZ6IZUwfTH3hnZEMf1xBJkr9fV6ft1HhMOhpRSTcjxHdWaW29DFVk6X
         tt/gWZP0xFX7WXGCHfz6XgLQHyWhPxdK9ozMFMyOzbE8TXDRveKy0OTJinpXzzAQNRmZ
         iRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692841677; x=1693446477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBuu+H0+lIDFAFh6BV8P/GWalq0YHGG3/mASWuMo5lM=;
        b=R8bY0iHrYLR1umKLG6A9shOfVK2JaPghVBYfGKyZ/ox+iWD/25ZW4ipJqMvkHsI2bv
         1Rn1M1gyzOu2gyOvRlVndvfYl19+fB6eOajbLVNRg9Nr2Je1Ps96Dec1FYBJUdXS1/zK
         mM2XuN7DTMiuhAXGxnL/Or4SvAqXPyB5kEmlcfo+3/PMSMcehP/y3EhWXA8jytcSTcuA
         8Zn5ebcyTXCoVmUDrVz2/3X/dlpMor0YFxxjsJna4IpenhOAKIEI4z/wnSWdjadC6TkM
         b7ki/5BJoYE6YX5YeR3m6ipm1Ux7B9Rdgr1BAQOsOJowc4anVdYjb5a9Uk2qadZrHwHI
         IZOg==
X-Gm-Message-State: AOJu0YxkME4ZBO6FzkLX3I0pAeVUeDCOZ5imLuxpoqBiy+jNzLlQixj2
	HVpEgYxHxz/1XYt46if5h3Aroh/Qkig6pM6CTJA=
X-Google-Smtp-Source: AGHT+IF8L2cBx5w+0JhtIC9QktBFOsReLfkleqxiIlOoTbE8jd9B+m3RmNa0CfAZn0Fq2T1YOElaAG429oOIclobI8I=
X-Received: by 2002:a05:6512:32d0:b0:4f9:cd02:4aec with SMTP id
 f16-20020a05651232d000b004f9cd024aecmr11056801lfg.29.1692841677292; Wed, 23
 Aug 2023 18:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1692696115.git.chenfeiyang@loongson.cn>
In-Reply-To: <cover.1692696115.git.chenfeiyang@loongson.cn>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Thu, 24 Aug 2023 09:47:43 +0800
Message-ID: <CACWXhKkSxQ8WWPwup2GujCafhkDh-YFsB7PVrcuMVYa7ZVce+g@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] stmmac: Add Loongson platform support
To: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, chenhuacai@loongson.cn, 
	linux@armlinux.org.uk, dongbiao@loongson.cn, guyinggang@loongson.cn, 
	siyanteng@loongson.cn, loongson-kernel@lists.loongnix.cn, 
	netdev@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 5:40=E2=80=AFPM Feiyang Chen <chenfeiyang@loongson.=
cn> wrote:
>
> Add and extend stmmac functions and macros for Loongson DWMAC.
> Add LS7A support and GNET support for dwmac_loongson.
>
> Split the code for extended GMAC (dwegmac) from dwmac1000, try
> not to mix up registers and core id.
>
> Some features of Loongson platforms are bound to the GMAC_VERSION
> register. We have to read its value in dwmac-loongson in order to
> get the correct channel number and DMA configuration.
>
> The current usage of stmmac_request_irq_multi_msi() is limited to
> dwmac-intel. While it appears that setting irq_flags might not be
> necessary for dwmac-intel, it should be configured for other drivers
> like dwmac-loongson. I've observed many drivers directly setting
> irq_flags within their probe functions or data structures without
> referencing the DT. Since I'm unsure about the proper handling of
> irq_flags, I've chosen to retain the code as-is.
>
> Feiyang Chen (11):
>   net: stmmac: Pass stmmac_priv and chan in some callbacks
>   stmmac: dwmac1000: Add 64-bit DMA support
>   stmmac: Add extended GMAC support for Loongson platforms
>   net: stmmac: Allow platforms to set irq_flags
>   net: stmmac: dwmac-loongson: Refactor code for loongson_dwmac_probe()
>   net: stmmac: dwmac-loongson: Add LS7A support
>   net: stmmac: dwmac-loongson: Add 64-bit DMA and MSI support
>   net: stmmac: dwegmac: Fix channel numbers
>   net: stmmac: dwmac-loongson: Disable flow control for GMAC
>   net: stmmac: dwegmac: Disable coe
>   net: stmmac: dwmac-loongson: Add GNET support
>
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
>  .../net/ethernet/stmicro/stmmac/chain_mode.c  |  29 +-
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   3 +
>  drivers/net/ethernet/stmicro/stmmac/descs.h   |   7 +
>  .../net/ethernet/stmicro/stmmac/descs_com.h   |  47 +-
>  drivers/net/ethernet/stmicro/stmmac/dwegmac.h | 332 +++++++++++
>  .../ethernet/stmicro/stmmac/dwegmac_core.c    | 552 ++++++++++++++++++
>  .../net/ethernet/stmicro/stmmac/dwegmac_dma.c | 522 +++++++++++++++++
>  .../net/ethernet/stmicro/stmmac/dwegmac_dma.h | 190 ++++++
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 338 ++++++++---
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  22 +-
>  .../ethernet/stmicro/stmmac/dwmac1000_core.c  |   9 +-
>  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  54 +-
>  .../ethernet/stmicro/stmmac/dwmac100_core.c   |   9 +-
>  .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  11 +-
>  .../ethernet/stmicro/stmmac/dwmac4_descs.c    |  17 +-
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   8 +-
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  |   2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |   2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  22 +-
>  .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |   5 +-
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  11 +-
>  .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |  17 +-
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  10 +-
>  .../net/ethernet/stmicro/stmmac/enh_desc.c    |  38 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.c    |  66 ++-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  73 ++-
>  .../net/ethernet/stmicro/stmmac/norm_desc.c   |  17 +-
>  .../net/ethernet/stmicro/stmmac/ring_mode64.c | 158 +++++
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   8 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  34 +-
>  include/linux/stmmac.h                        |  11 +
>  33 files changed, 2410 insertions(+), 218 deletions(-)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwegmac.h
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwegmac_core.c
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwegmac_dma.c
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwegmac_dma.h
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/ring_mode64.c
>
> --
> 2.39.3
>

Due to some recent work adjustments, Yanteng will be taking over the
patch series.

Thanks,
Feiyang

