Return-Path: <netdev+bounces-13063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79DD73A122
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A96F2819F0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8271F1E536;
	Thu, 22 Jun 2023 12:45:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D901E527
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:45:31 +0000 (UTC)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28A119AF
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:45:29 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-471b1ba1a7dso1891521e0c.2
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687437929; x=1690029929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IAa9QbAg6mMlY1K9iZzo0KBKDVgETeE7PvH1uKY77A=;
        b=ncXLWJal2QgP96Sk787g47rL08o41YhaHQkUsKss+1kCC6ddUpEN3L55GGmCxBJq7F
         jhLgPPCkkFrxAovoz0yCGZOurSHBbjZJH7RTzW+o4/SBHJeLrmyEgvRhOG9c7vjH+l1f
         tIh2gE6ytKG8pXPhioIiUFU/Lkjy5DkK5Ql9cI5UUQry8f/0GwgCxeJXcG+HIFEJIayN
         pz139igKWI9WVrCMytz7bSK8HDx7gV5r0ezX23fP4R99kw9787UalhuapCb+AsqCn5mi
         WVQ8HPq8DJx0GHz5crnpzn51ahg5tzD/M6mR3ElNs3vw9LF8DwH8fy6plHGKinBHQH9V
         yanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687437929; x=1690029929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IAa9QbAg6mMlY1K9iZzo0KBKDVgETeE7PvH1uKY77A=;
        b=K5Hy8DMlIc4v5Uls5/icxQy1YxifAZblULZNpDtS9giFfdoucKuJiqIU6Ve/W/zVZM
         yjODc9FJ+/21SKyArDFzBvxbixp/EQzuZtbdz/NfYughq9H2YrkXdxTU6wZBM7gncIb7
         6peyRgdzDyPDRzqInLQTyR5kL/a/RRGnD4lwhLiv9+C46DcqIWdt9zc87EYocvfpAlpJ
         qeZunZbznqQSvk/277C6qYY/RZGkIH5OFJw8KYgOEUSYb1G2cVgzA7MOvjB/imjBatqL
         9atCMxB/aNBoxJq8Kvx2a96rhFoTKubE2rdqHNDbrPZH9zI3dLuLWmDoxHElsdZqR/hE
         M74g==
X-Gm-Message-State: AC+VfDyOvuhFNbOLfoyOghworKlH7yex/0kI9okmiZYvS7YKq69V/1ZV
	4LuXHv2yfhjwiVBxqPrfbjMqUKNg/bQXRBLXIilZJQ==
X-Google-Smtp-Source: ACHHUZ5/jzxo/ijO8rlAjptGql3tzGDgmPaiskSoOAANtplM754UorQOZnV5cX2QhyZ4FbjKszM2FRZhAFgxM5gtNns=
X-Received: by 2002:a1f:d103:0:b0:471:5cb5:11f8 with SMTP id
 i3-20020a1fd103000000b004715cb511f8mr7797350vkg.15.1687437928832; Thu, 22 Jun
 2023 05:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621153650.440350-9-brgl@bgdev.pl> <202306221025.K6fKRmj7-lkp@intel.com>
In-Reply-To: <202306221025.K6fKRmj7-lkp@intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Jun 2023 14:45:17 +0200
Message-ID: <CAMRc=MeWBh-uWDJTLwg5uzE=-Q2jTnSg4Gw9ogh-9N+WUntSwg@mail.gmail.com>
Subject: Re: [PATCH net-next 08/11] net: stmmac: platform: provide devm_stmmac_probe_config_dt()
To: kernel test robot <lkp@intel.com>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Junxiao Chang <junxiao.chang@intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 4:49=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Bartosz,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewsk=
i/net-stmmac-platform-provide-stmmac_pltfr_init/20230621-234133
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20230621153650.440350-9-brgl%40b=
gdev.pl
> patch subject: [PATCH net-next 08/11] net: stmmac: platform: provide devm=
_stmmac_probe_config_dt()
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20230622/20=
2306221025.K6fKRmj7-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230622/202306221025=
.K6fKRmj7-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306221025.K6fKRmj7-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    ld: vmlinux.o: in function `__ksymtab_devm_stmmac_probe_config_dt':
> >> stmmac_platform.c:(___ksymtab_gpl+devm_stmmac_probe_config_dt+0x0): un=
defined reference to `devm_stmmac_probe_config_dt'
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

I added the missing stub for !CONFIG_OF to v2.

Bart

