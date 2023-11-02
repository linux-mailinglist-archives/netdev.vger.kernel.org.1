Return-Path: <netdev+bounces-45677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC397DEF95
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 11:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63000281ACB
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 10:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92436134BD;
	Thu,  2 Nov 2023 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+e+i4BS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A1312B87
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 10:14:23 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AF7186
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 03:14:18 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7c011e113so9533647b3.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 03:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698920057; x=1699524857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwDe9fsL87Ls6Q4UOgKsDQdYTGCFqy9zRmLmRJFb/aM=;
        b=s+e+i4BScolJYyKIjaN8R3JJ+VzXB0ddIrV/Sgf9/ZtDqKWiudLKbmaUm+zO7hOxlf
         A7ij7Z3SiLh0AnJTyUp6YI6drnWxB4tfp5mW+8pK/eNKRLUJqL8bBZ5I0bN1DWxZqncm
         Dn61+XoJwIhMNcbpsW2LhUkT33vleBLj7h2tDueMg09nvz2+kvjCZ73SDPHj2s6FouXt
         /k3AGbJ4ipAFIbBkiwF6XOQo3rkR+ZicXCBQaodRWxEZb4GkLQ2FzwMprbXcJJMcoAdx
         dtB/nu3H0Eyk8UkmHRLawhR2vmvnq3hnIKTdpWapFZvfJJCrTtQL5r5gr53BCmUbJ6u7
         v1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698920057; x=1699524857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwDe9fsL87Ls6Q4UOgKsDQdYTGCFqy9zRmLmRJFb/aM=;
        b=TlEZSdUkajuZ3SOr/E8NUYllkN5ODK0hF9EqKLFdGfk3Mm/BbHldVOwvh3hgNylCgd
         iwijbq9hnZln+7Ug4Xuk+ukf1hQ6/PiCYsriMqyr1lSua5mkLt6ldnba7DOyVLmZf6Jg
         1C3j6IcXM2GjFC79VKwdwzxEVFLp++5X346MiRagKuLlm6SatMk92hNQssf6rK2G4JU0
         ljTBI4e7MfHT5iyw1xdEJt8fj0C5cw+8EY4hW8tDdXB6r6euK/XMx0Pp3whxkiM0PIi8
         FXEHo+ovwUxW9q9v0em3WfLK+EJX7olAdum46hKaa9lyOsjqiL2zog+nXv0Hprw80op0
         JN9w==
X-Gm-Message-State: AOJu0Yw865CGA0SwbfLlZLACjNAqkv5tPfZZOQorDalIuDvep4K7MIcc
	6w7MQWBU0u/NttCssRdI3fnWCdGHGva1pPQElv+5NQ==
X-Google-Smtp-Source: AGHT+IFqfHggtSWNAF92oR5g1rWyIQUYU7gQrs4X7ZCuG2a0fFwh4yUFs3SFGimnPQ1Yk0lumzhl3n6lsXbw44txMaY=
X-Received: by 2002:a81:cf09:0:b0:5a7:b036:360c with SMTP id
 u9-20020a81cf09000000b005a7b036360cmr18364826ywi.23.1698920057708; Thu, 02
 Nov 2023 03:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231029111807.19261-1-balejk@matfyz.cz> <20231029111807.19261-3-balejk@matfyz.cz>
In-Reply-To: <20231029111807.19261-3-balejk@matfyz.cz>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 2 Nov 2023 11:13:41 +0100
Message-ID: <CAPDyKFrRwRaZoypeTzuJrrA5__HSti14Amnq46ht=0Dy3UQPNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: mwifiex: add support for the SD8777 chipset
To: Karel Balej <balejk@matfyz.cz>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 29 Oct 2023 at 12:19, Karel Balej <balejk@matfyz.cz> wrote:
>
> Marvell SD8777 is a wireless chipset used for instance in the PXA1908
> SoC found for example in the samsung,coreprimevelte smartphone, with
> which this was tested. The driver seems to be compatible with this
> chipset so enable this support by adding the necessary information based
> on the downstream code.
>
> Signed-off-by: Karel Balej <balejk@matfyz.cz>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC

Kind regards
Uffe

> ---
>  drivers/net/wireless/marvell/mwifiex/Kconfig |  4 ++--
>  drivers/net/wireless/marvell/mwifiex/sdio.c  | 19 +++++++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/sdio.h  |  1 +
>  include/linux/mmc/sdio_ids.h                 |  1 +
>  4 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/Kconfig b/drivers/net/wireless/marvell/mwifiex/Kconfig
> index b182f7155d66..a7bd2c5735f6 100644
> --- a/drivers/net/wireless/marvell/mwifiex/Kconfig
> +++ b/drivers/net/wireless/marvell/mwifiex/Kconfig
> @@ -10,13 +10,13 @@ config MWIFIEX
>           mwifiex.
>
>  config MWIFIEX_SDIO
> -       tristate "Marvell WiFi-Ex Driver for SD8786/SD8787/SD8797/SD8887/SD8897/SD8977/SD8978/SD8987/SD8997"
> +       tristate "Marvell WiFi-Ex Driver for SD8777/SD8786/SD8787/SD8797/SD8887/SD8897/SD8977/SD8978/SD8987/SD8997"
>         depends on MWIFIEX && MMC
>         select FW_LOADER
>         select WANT_DEV_COREDUMP
>         help
>           This adds support for wireless adapters based on Marvell
> -         8786/8787/8797/8887/8897/8977/8978/8987/8997 chipsets with
> +         8777/8786/8787/8797/8887/8897/8977/8978/8987/8997 chipsets with
>           SDIO interface. SD8978 is also known as NXP IW416.
>
>           If you choose to build it as a module, it will be called
> diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> index 774858cfe86f..c55f1f5669cb 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> @@ -318,6 +318,21 @@ static const struct mwifiex_sdio_card_reg mwifiex_reg_sd89xx = {
>                                  0x68, 0x69, 0x6a},
>  };
>
> +static const struct mwifiex_sdio_device mwifiex_sdio_sd8777 = {
> +       .firmware = SD8777_DEFAULT_FW_NAME,
> +       .reg = &mwifiex_reg_sd87xx,
> +       .max_ports = 16,
> +       .mp_agg_pkt_limit = 8,
> +       .tx_buf_size = MWIFIEX_TX_DATA_BUF_SIZE_2K,
> +       .mp_tx_agg_buf_size = MWIFIEX_MP_AGGR_BUF_SIZE_16K,
> +       .mp_rx_agg_buf_size = MWIFIEX_MP_AGGR_BUF_SIZE_16K,
> +       .supports_sdio_new_mode = false,
> +       .has_control_mask = true,
> +       .can_dump_fw = false,
> +       .can_auto_tdls = false,
> +       .can_ext_scan = true,
> +};
> +
>  static const struct mwifiex_sdio_device mwifiex_sdio_sd8786 = {
>         .firmware = SD8786_DEFAULT_FW_NAME,
>         .reg = &mwifiex_reg_sd87xx,
> @@ -496,6 +511,7 @@ static struct memory_type_mapping mem_type_mapping_tbl[] = {
>  };
>
>  static const struct of_device_id mwifiex_sdio_of_match_table[] __maybe_unused = {
> +       { .compatible = "marvell,sd8777" },
>         { .compatible = "marvell,sd8787" },
>         { .compatible = "marvell,sd8897" },
>         { .compatible = "marvell,sd8978" },
> @@ -924,6 +940,8 @@ static void mwifiex_sdio_coredump(struct device *dev)
>
>  /* WLAN IDs */
>  static const struct sdio_device_id mwifiex_ids[] = {
> +       {SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8777_WLAN),
> +               .driver_data = (unsigned long)&mwifiex_sdio_sd8777},
>         {SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8786_WLAN),
>                 .driver_data = (unsigned long) &mwifiex_sdio_sd8786},
>         {SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8787_WLAN),
> @@ -3180,6 +3198,7 @@ MODULE_AUTHOR("Marvell International Ltd.");
>  MODULE_DESCRIPTION("Marvell WiFi-Ex SDIO Driver version " SDIO_VERSION);
>  MODULE_VERSION(SDIO_VERSION);
>  MODULE_LICENSE("GPL v2");
> +MODULE_FIRMWARE(SD8777_DEFAULT_FW_NAME);
>  MODULE_FIRMWARE(SD8786_DEFAULT_FW_NAME);
>  MODULE_FIRMWARE(SD8787_DEFAULT_FW_NAME);
>  MODULE_FIRMWARE(SD8797_DEFAULT_FW_NAME);
> diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
> index ae94c172310f..ed92256b2302 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.h
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
> @@ -18,6 +18,7 @@
>
>  #include "main.h"
>
> +#define SD8777_DEFAULT_FW_NAME "mrvl/sd8777_uapsta.bin"
>  #define SD8786_DEFAULT_FW_NAME "mrvl/sd8786_uapsta.bin"
>  #define SD8787_DEFAULT_FW_NAME "mrvl/sd8787_uapsta.bin"
>  #define SD8797_DEFAULT_FW_NAME "mrvl/sd8797_uapsta.bin"
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 7fada7a714fe..c46ab35ceb20 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -94,6 +94,7 @@
>  #define SDIO_DEVICE_ID_MARVELL_8797_BT         0x912a
>  #define SDIO_DEVICE_ID_MARVELL_8897_WLAN       0x912d
>  #define SDIO_DEVICE_ID_MARVELL_8897_BT         0x912e
> +#define SDIO_DEVICE_ID_MARVELL_8777_WLAN       0x9131
>  #define SDIO_DEVICE_ID_MARVELL_8887_F0         0x9134
>  #define SDIO_DEVICE_ID_MARVELL_8887_WLAN       0x9135
>  #define SDIO_DEVICE_ID_MARVELL_8887_BT         0x9136
> --
> 2.42.0
>

