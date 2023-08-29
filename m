Return-Path: <netdev+bounces-31247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A52BA78C516
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 15:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01BF1C209CD
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 13:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DC215ACA;
	Tue, 29 Aug 2023 13:23:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4D156FC
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 13:23:15 +0000 (UTC)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88174198;
	Tue, 29 Aug 2023 06:23:10 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d7766072ba4so7237041276.1;
        Tue, 29 Aug 2023 06:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693315390; x=1693920190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1mNTuIoIgj8pBCMwK+VRPQwsHICrkdzH+QYvSfXFsY=;
        b=IYOM0kVBRTHj/zDxYkK5x8jURz2onyYSRihVUNDC9hnVJZNtTaiQ6fqEx3+XP6npgw
         15mL7SBq7Xufwye0ZdNHB2VytQfqe6GhfNq1AqXjXzuBfBeW9+VqJs+riZFC8ii9qLAn
         yNRqYGOs8TH4EGx7SHtl24MQQTftxYHM58Xoqjb6z7/2LpHiLiRyOT54GdzQ4eQAQ4qw
         aOEsm6sqJDVlQZsBHTeBv2B7qfK2CdKq7UC6y6WC8z+Zq0KwZZwq7qDJTKZf0Wmdy2Ys
         fKr3ndRaVD/okl7sSmbBRH5zmfiOJ3dt/CN5MevJNobAHnTEqEiYHnA+ZUqkDdvH7LgU
         e3VA==
X-Gm-Message-State: AOJu0YxbJ/fDiBy0BNiKbT8UCSCYKQ0QrPEva98s3hfRel72IRPMhsuX
	ODpGYQrp15KUcBfQfWJl4QtqQtbBGWFeb6dNeW8=
X-Google-Smtp-Source: AGHT+IF21/VkPQf/zjvB+O0XGVNYdgymDCKm5G0vPQ5fdMn/F0MsO/gJOlk3+/x9wzWRjYNm40tTJiuChxTEPABWsMc=
X-Received: by 2002:a25:a1ca:0:b0:d79:e08f:e9c2 with SMTP id
 a68-20020a25a1ca000000b00d79e08fe9c2mr2974886ybi.11.1693315389688; Tue, 29
 Aug 2023 06:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230829104033.955-1-jszhang@kernel.org> <ZO3UuY9jKz8VenGA@shell.armlinux.org.uk>
 <ZO3WsHH1GDWdcLAU@xhacker>
In-Reply-To: <ZO3WsHH1GDWdcLAU@xhacker>
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Tue, 29 Aug 2023 15:22:58 +0200
Message-ID: <CANBLGcwoiiA=ZOVenMZXM4pHSYn0dyGpzjm76i1Fin+8+NiqLA@mail.gmail.com>
Subject: Re: [PATCH net-next 00/22] convert to devm_stmmac_probe_config_dt
To: Jisheng Zhang <jszhang@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Vladimir Zapolskiy <vz@mleia.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Samin Guo <samin.guo@starfivetech.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 29 Aug 2023 at 13:41, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On Tue, Aug 29, 2023 at 12:21:29PM +0100, Russell King (Oracle) wrote:
> > On Tue, Aug 29, 2023 at 06:40:11PM +0800, Jisheng Zhang wrote:
> > > Russell pointed out there's a new devm_stmmac_probe_config_dt()
> > > helper now when reviewing my starfive gmac error handling patch[1].
> > > After greping the code, this nice helper was introduced by Bartosz in
> > > [2], I think it's time to convert all dwmac users to this helper and
> > > finally complete the TODO in [2] "but once all users of the old
> > > stmmac_pltfr_remove() are converted to the devres helper, it will be
> > > renamed back to stmmac_pltfr_remove() and the no_dt function removed."
> >
> > I think a useful final patch may be to make stmmac_probe_config_dt()
> > static so there aren't any new uses of stmmac_probe_config_dt().
>
> Good idea!

Once this is done are there any users of stmmac_pltfr_remove() left?
If not it would be great to remove that too and maybe even remove the
_no_dt from stmmac_pltfr_remove_no_dt().

> >
> > Also note that net-next is now closed, so please wait until after -rc1
> > for net-next to re-open, or post as RFC. Thanks.
>
> oops, I didn't notice this cycle of window is closed, I will wait for next
> development window.
>
> Thank you
> >
> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

