Return-Path: <netdev+bounces-25393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D18773DA3
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C710A1C203BB
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE4A1400A;
	Tue,  8 Aug 2023 16:18:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14563C37
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:18:44 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD61F238FF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:18:29 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bd092cba5dso3276a34.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511470; x=1692116270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kb4epZ0hVQjvrS5RqNy38MOhVst2cqtQlkC7YBmZyjc=;
        b=qPiSpphU1nGWmLAMPSpg56ArnaGieug80cZl14oqXoQvdmJ1mUTgiwlF3TfND7UmS3
         fKUosktLSZH36oc5h2PS1CT4B9IvplOi5toAhdX3Ap0C5nPZH4e/TGPS8QpU5FeOuK0U
         BpaT9BYqbURFphBrX7orqubjlq1X7442TD5RQI6m4qyQl5BYyvqbG2t+sxP3jmpoZoYG
         Eyu5FQnwa3GWBMIwMUTW52tah6rpkfNRTB/72Vb/FobjOAiAnigMJwqlPDZ28OXnQIUZ
         MMZ2yr1705c4JQmS2btsXjwpvhqwjzMoE2YjBR7LXSegtsGITupnI+L0tdDCp1M4nYmE
         FgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511470; x=1692116270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kb4epZ0hVQjvrS5RqNy38MOhVst2cqtQlkC7YBmZyjc=;
        b=OymqgkT0rli0FTe80rJHmRxXH1PLerKcLr6wRDOTCqxcpOdWTmw42vy7+tuiyBlt9P
         6Mph2XEq2QSjEG/e9brezLWmZQWEf+OcKoX/ZpfzcM0l9CFWa6lkD0Tl2OHo7yO5Hgc7
         p6HtiOeYdnnS6BBnut0qk8KtKN1Ni+NDc8wa1kc3p72ba50ns2aeXflNHBB1+iOkKoRd
         edaciGH9sYmY5TYsXWh1kj9CbgyfSeEuWlcVduWDqitjVV1HWLB8qRzkvV3D9Jz/sawl
         A4F7KUivvcKqe2rFaHRBi2iZ8KLvU7+ZMZeiiY95Cnhy+qZ7eA0vry27zUfAl5Gwlq7e
         CY6A==
X-Gm-Message-State: AOJu0YwnWHPjk1aNgS0fMV069kMiLGGq3DT6fp8woPuXqy8bwKE6c1C2
	ni1AcjWLAIzxk0vBnTl4E05jBw+xjckW4dcAkwhYNimgO9H+dWR5
X-Google-Smtp-Source: AGHT+IF66ZIg71BsvfIXpCtaWYgCcZU8SNpF3fi8QtXBlp/Ozl2bOkN0RcX0VeXVj4YAJiEXbN2H1G1ZyCw5KxmnN8o=
X-Received: by 2002:a25:aa21:0:b0:d15:3761:3513 with SMTP id
 s30-20020a25aa21000000b00d1537613513mr9704045ybi.19.1691486159218; Tue, 08
 Aug 2023 02:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801173544.1929519-1-hch@lst.de> <20230801173544.1929519-3-hch@lst.de>
In-Reply-To: <20230801173544.1929519-3-hch@lst.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Aug 2023 11:15:23 +0200
Message-ID: <CAPDyKForXd2GFVmXXM8hsnAYSQcKhp84t1aOunppUY+MFe0qag@mail.gmail.com>
Subject: Re: [PATCH 2/5] mmc: au1xmmc: force non-modular build and remove
 symbol_get usage
To: Christoph Hellwig <hch@lst.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Manuel Lauss <manuel.lauss@gmail.com>, 
	Yangbo Lu <yangbo.lu@nxp.com>, Joshua Kinard <kumba@gentoo.org>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arm-kernel@lists.infradead.org, 
	open list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 1 Aug 2023 at 19:36, Christoph Hellwig <hch@lst.de> wrote:
>
> au1xmmc is split somewhat awkwardly into the main mmc subsystem driver,
> and callbacks in platform_data that sit under arch/mips/ and are
> always built in.  The latter than call mmc_detect_change through
> symbol_get.  Remove the use of symbol_get by requiring the driver
> to be built in.  In the future the interrupt handlers for card
> insert/eject detection should probably be moved into the main driver,
> and which point it can be built modular again.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

If not too late, feel free to add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  arch/mips/alchemy/devboards/db1000.c |  8 +-------
>  arch/mips/alchemy/devboards/db1200.c | 19 ++-----------------
>  arch/mips/alchemy/devboards/db1300.c | 10 +---------
>  drivers/mmc/host/Kconfig             |  4 ++--
>  4 files changed, 6 insertions(+), 35 deletions(-)
>
> diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
> index 79d66faa84828d..012da042d0a4f7 100644
> --- a/arch/mips/alchemy/devboards/db1000.c
> +++ b/arch/mips/alchemy/devboards/db1000.c
> @@ -14,7 +14,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/leds.h>
>  #include <linux/mmc/host.h>
> -#include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/spi/spi.h>
> @@ -167,12 +166,7 @@ static struct platform_device db1x00_audio_dev = {
>
>  static irqreturn_t db1100_mmc_cd(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -       /* link against CONFIG_MMC=m */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       mmc_cd(ptr, msecs_to_jiffies(500));
> -       symbol_put(mmc_detect_change);
> -
> +       mmc_detect_change(ptr, msecs_to_jiffies(500));
>         return IRQ_HANDLED;
>  }
>
> diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
> index 1864eb935ca57f..76080c71a2a7b6 100644
> --- a/arch/mips/alchemy/devboards/db1200.c
> +++ b/arch/mips/alchemy/devboards/db1200.c
> @@ -10,7 +10,6 @@
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> -#include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/leds.h>
> @@ -340,14 +339,7 @@ static irqreturn_t db1200_mmc_cd(int irq, void *ptr)
>
>  static irqreturn_t db1200_mmc_cdfn(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -
> -       /* link against CONFIG_MMC=m */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       if (mmc_cd) {
> -               mmc_cd(ptr, msecs_to_jiffies(200));
> -               symbol_put(mmc_detect_change);
> -       }
> +       mmc_detect_change(ptr, msecs_to_jiffies(200));
>
>         msleep(100);    /* debounce */
>         if (irq == DB1200_SD0_INSERT_INT)
> @@ -431,14 +423,7 @@ static irqreturn_t pb1200_mmc1_cd(int irq, void *ptr)
>
>  static irqreturn_t pb1200_mmc1_cdfn(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -
> -       /* link against CONFIG_MMC=m */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       if (mmc_cd) {
> -               mmc_cd(ptr, msecs_to_jiffies(200));
> -               symbol_put(mmc_detect_change);
> -       }
> +       mmc_detect_change(ptr, msecs_to_jiffies(200));
>
>         msleep(100);    /* debounce */
>         if (irq == PB1200_SD1_INSERT_INT)
> diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
> index e70e529ddd914d..ff61901329c626 100644
> --- a/arch/mips/alchemy/devboards/db1300.c
> +++ b/arch/mips/alchemy/devboards/db1300.c
> @@ -17,7 +17,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/ata_platform.h>
>  #include <linux/mmc/host.h>
> -#include <linux/module.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/platnand.h>
>  #include <linux/platform_device.h>
> @@ -459,14 +458,7 @@ static irqreturn_t db1300_mmc_cd(int irq, void *ptr)
>
>  static irqreturn_t db1300_mmc_cdfn(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -
> -       /* link against CONFIG_MMC=m.  We can only be called once MMC core has
> -        * initialized the controller, so symbol_get() should always succeed.
> -        */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       mmc_cd(ptr, msecs_to_jiffies(200));
> -       symbol_put(mmc_detect_change);
> +       mmc_detect_change(ptr, msecs_to_jiffies(200));
>
>         msleep(100);    /* debounce */
>         if (irq == DB1300_SD1_INSERT_INT)
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 159a3e9490aed8..f7afd179dd10bf 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -526,11 +526,11 @@ config MMC_ALCOR
>           of Alcor Micro PCI-E card reader
>
>  config MMC_AU1X
> -       tristate "Alchemy AU1XX0 MMC Card Interface support"
> +       bool "Alchemy AU1XX0 MMC Card Interface support"
>         depends on MIPS_ALCHEMY
>         help
>           This selects the AMD Alchemy(R) Multimedia card interface.
> -         If you have a Alchemy platform with a MMC slot, say Y or M here.
> +         If you have a Alchemy platform with a MMC slot, say Y here.
>
>           If unsure, say N.
>
> --
> 2.39.2
>

