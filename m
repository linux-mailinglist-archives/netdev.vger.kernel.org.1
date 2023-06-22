Return-Path: <netdev+bounces-13076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD39373A185
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FA9281953
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416681ED2E;
	Thu, 22 Jun 2023 13:10:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BCF1ED29
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:10:56 +0000 (UTC)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D07184
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:10:54 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-471b1ba1a7dso1905908e0c.2
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687439453; x=1690031453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2ExnUNvm4puj2j+jBwDuVgUcMJgNpTHsaeUbPYv1HA=;
        b=yGJPcTf5yJ0LAQHbCs0//5u7zTlviWAP4S4kkO82hHeGqqVnJDo/C15mxkMnjVBse6
         sfzsKQg/tJSVZGfVAk+tv2ZXymwjUI5lj9RIwv2zgWtET1Lze47M1HqsNjk9drvIftQ0
         pVzHirWFhN1bcVZtplp/G3rDRFkBvIk7Ohha7vbGdSWN68j99aBXZCkf8V4jrhPnbTP+
         nhOe8iYPriWxHdLafESB8L8s6g/NsqEs7txzboyYTOG09Qzhiu6TWoV4V1fLyW2wxBud
         pWUKDeA7HjpbY62da6LVs0OiSI+2C/hOb/HcR/1eqFf7XNA9+3dGBuxxi6RAqth1l4dS
         18Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687439453; x=1690031453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2ExnUNvm4puj2j+jBwDuVgUcMJgNpTHsaeUbPYv1HA=;
        b=b2YMMeyXttxs4FiR8+16NaBN1Wky2J9w+vOYLkyUzy55JtHaGZzEzwBOZQrRE3XUc+
         x8+Bb3nwKfoAgi5blRcKhXWEsYp3ntT+xXF5E+JcRAVn5KTJYO4dkjnGNOYyoaAAU5Mg
         eMWw4oMOj2LTtkvJR1lZ1nqxh3zRm/NiaYjuoAVZFeyb8m6Yu7krZr4R2eCD5chFOrCW
         ibp/C5+WkxCPdedy/LpMj9tAhhM8HRpvOMmUlWhX7l6w4GmciB7VnVnCnbt9upmIAtGm
         Y6iUALF8dB9h59mlcdbJpOCTL+xdG0U5aCqPSsLx1vjUP3JjNW6tHe3eyQusFyXv8vLk
         U2uA==
X-Gm-Message-State: AC+VfDyV8O22bt24ey9q4+fmENSl22YBveZJh7e8O5E6orrl56FWhREr
	7dNANJuboc/dXJgs2o5F1pr+zsU9A57Gko3DIV8SZg==
X-Google-Smtp-Source: ACHHUZ51ts75wkyfRCqdLOdLzUY3leYxdAIzn0un4E/YRo60Xqah11aqcikjs7PUlI+S5vg4oKw+3YC6Mm8RyX4xhqs=
X-Received: by 2002:a1f:e784:0:b0:471:6119:95cc with SMTP id
 e126-20020a1fe784000000b00471611995ccmr7694191vkh.14.1687439453218; Thu, 22
 Jun 2023 06:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621182558.544417-11-brgl@bgdev.pl> <202306220657.ikVUl0zU-lkp@intel.com>
In-Reply-To: <202306220657.ikVUl0zU-lkp@intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Jun 2023 15:10:42 +0200
Message-ID: <CAMRc=McU+eo3TSFmpR71mak08qJsA19hz8rZo5qk=rMbxoKOzQ@mail.gmail.com>
Subject: Re: [PATCH net-next 10/12] net: stmmac: replace the int_snapshot_en
 field with a flag
To: kernel test robot <lkp@intel.com>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Richard Cochran <richardcochran@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 1:31=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Bartosz,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewsk=
i/net-stmmac-replace-has_integrated_pcs-field-with-a-flag/20230622-022944
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20230621182558.544417-11-brgl%40=
bgdev.pl
> patch subject: [PATCH net-next 10/12] net: stmmac: replace the int_snapsh=
ot_en field with a flag
> config: i386-randconfig-i012-20230621 (https://download.01.org/0day-ci/ar=
chive/20230622/202306220657.ikVUl0zU-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git =
8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce: (https://download.01.org/0day-ci/archive/20230622/202306220657=
.ikVUl0zU-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306220657.ikVUl0zU-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c:612:2: error: use of=
 undeclared identifier 'priv'
>            priv->plat->flags &=3D ~STMMAC_FLAG_INT_SNAPSHOT_EN;
>            ^
>    1 error generated.
>

Eek, must have disabled this driver in my config by accident. Now fixed for=
 v2.

Bart

