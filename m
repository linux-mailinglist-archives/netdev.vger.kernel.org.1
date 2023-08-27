Return-Path: <netdev+bounces-30945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5042D78A07D
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 19:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C2C1C20928
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF0A111BB;
	Sun, 27 Aug 2023 17:33:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08B11189
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 17:33:24 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8D0F4;
	Sun, 27 Aug 2023 10:33:22 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-58fc4d319d2so29073747b3.1;
        Sun, 27 Aug 2023 10:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693157602; x=1693762402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXRQ29Kd0gz5Nx/WOSU5Qc0o5kViYnspMVCSG/2JHCQ=;
        b=E5Hp7n2sdYxjRNM03PKKlICyOXfK495FmV5ZKOOPFM1sa9NTw0OvT5ZuBzzrHSVCiN
         wAkaIV9HJskBYmxjfSRmNGe6GfTus4Q+EcIaTy0LKjtBgalWSmRiqaAPepcIMowiFJrG
         LiY3zBSsMb5ISOFY/HhVM2v8dcJar4qmqzJ0USgrigvRPbbIC3FYrbD4DFy1ga4IZ8zg
         hW2+XRWULQ5xEOnqCwdXEIDLE04ml25cnC6GHAcaHqgCZ4vc0DsTivgl2N+iIKZnZ5i1
         s44+6k9dXmHajDca1kyeLTxqOejKGR5/oL8/jRTT6z+0CM406ZtDWDkbLucgo7llTxoL
         1Xzw==
X-Gm-Message-State: AOJu0Yxnqhw6AN8hOX+IJG/dG2qKc/RFeBEsb0JM4h5O6YfDogQRYjSb
	5vhsWsSeCYZ+r3LAbWY0mj2dQyrs4wxio46eTYhCd2SN
X-Google-Smtp-Source: AGHT+IFeGyy/bOxlt/AopeThQo710RCsTrK7BUhmNx2WxxR/Zx+G5YbigEwuQUWlQAo8X0U6SjRSRv2LcPeHqj5YXsk=
X-Received: by 2002:a05:690c:2d85:b0:593:47ff:bd7 with SMTP id
 er5-20020a05690c2d8500b0059347ff0bd7mr4875229ywb.46.1693157601831; Sun, 27
 Aug 2023 10:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230827134150.2918-1-jszhang@kernel.org> <20230827134150.2918-3-jszhang@kernel.org>
In-Reply-To: <20230827134150.2918-3-jszhang@kernel.org>
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Sun, 27 Aug 2023 19:33:10 +0200
Message-ID: <CANBLGcwFW_Y4PC1hxJ7OQN-h025e5wwoCNwnk8OXh3ALFQPcXg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac-starfive: remove
 unnecessary clk_get_rate()
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Samin Guo <samin.guo@starfivetech.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 27 Aug 2023 at 15:53, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> In starfive_dwmac_fix_mac_speed(), the rate gotten by clk_get_rate()
> is not necessary, remove the clk_get_rate() calling.

Thanks. I suggested this change during the initial review, but someone
wanted the code as it is. I must admit I don't understand why, so
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> index b68f42795eaa..422138ef565e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> @@ -30,8 +30,6 @@ static void starfive_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigne
>         unsigned long rate;
>         int err;
>
> -       rate = clk_get_rate(dwmac->clk_tx);
> -
>         switch (speed) {
>         case SPEED_1000:
>                 rate = 125000000;
> @@ -44,7 +42,7 @@ static void starfive_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigne
>                 break;
>         default:
>                 dev_err(dwmac->dev, "invalid speed %u\n", speed);
> -               break;
> +               return;
>         }
>
>         err = clk_set_rate(dwmac->clk_tx, rate);
> --
> 2.40.1
>

