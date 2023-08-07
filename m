Return-Path: <netdev+bounces-24968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24989772656
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016C21C20B6D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A7C10798;
	Mon,  7 Aug 2023 13:45:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E349101FE
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:45:23 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36E5198C
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 06:45:03 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d16639e16e6so3693171276.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 06:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691415901; x=1692020701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMUoL4hnGiYD5mlozK9nMbQkuwFZ1466myKRpxECfj8=;
        b=c2hxnScmXyOJNNEwoKxei8znJecQS2wtI3TXpVfWBeONeEnG4vwx3hpcJpNe2AayPO
         0AMVZyb/lJSbUeTXtOm1Pe21cRqHs/VtGvkHi8MJvRMFFglgz/80jxQAaCUUe/phOgl+
         Qpm4Uk9oDmcOpnq7mI7TqxH1yYgAW7W51OpmZaeTlrdOKGOZyz/gild0J8SldxlJ8Vm+
         tWG35Hf6tHY/F2mjV+O+qDQgjBmuR6DtLD7/o7uSnQ2NONh4YbEdfL1P+dwcdwJJnrKp
         JkELJca+1W2nV5dANEMwy59TbI68sZY5P+DSD2wmKU1l6My7Ng/g6H72CJmoUzsZZFWh
         6YCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691415901; x=1692020701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMUoL4hnGiYD5mlozK9nMbQkuwFZ1466myKRpxECfj8=;
        b=ZsuWYIt9lAzEFjM35aNMTvvE8guwoyIdT/Utj7mPo2qqMU6Tt9+VXXRRBSNYIQk30c
         FvMSrbL7iOL85GHPZSGWMgHyP8H5S0DWVBP4VdMOPa7bYFSKP/bW3OLUAGKFCBPhhrXj
         EQwSHx4Dg+JyVDj5HeRfI2lIvZrZggrbkc5Cxgz2FfaS+ipiuukj0cI5StlAwSLBjqN7
         uzZqBLiOOlCzD3c2ZneKIYyz0g6RxCMh+qaITDQrPYn4V4sm+9/HchjcTnvuCQ2wjgt+
         fALoiVohaKqmzQ8u9GcVGmqdUXuc/rBjakl1FKRyrGfKVi+7DfLm9aYC66UBT9W8uZJe
         Y7+w==
X-Gm-Message-State: AOJu0YxuCRRkBZub2Yh5SIzCd8K/BBYp514H+znjPuswQZGpgBjD8/q6
	D6/OMPL5hivb8FpQtEL2h7A+QiTFoZLTTGPCIBIpIw==
X-Google-Smtp-Source: AGHT+IHx1ajT83sKAnSY+O0ambUwFc4zjHyYjGAv1pUY5pxl3rdlLFD2APpbEZ6FIFnRNRDlCKdb6Khb5uVyVETW/uM=
X-Received: by 2002:a25:d70a:0:b0:d4c:a288:ef4 with SMTP id
 o10-20020a25d70a000000b00d4ca2880ef4mr4049416ybg.44.1691415901373; Mon, 07
 Aug 2023 06:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
 <20230630-topic-oxnas-upstream-remove-v2-9-fb6ab3dea87c@linaro.org> <a9074f2d-ffa2-477f-e3b5-2c7d213ec72c@linaro.org>
In-Reply-To: <a9074f2d-ffa2-477f-e3b5-2c7d213ec72c@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 7 Aug 2023 15:44:50 +0200
Message-ID: <CACRpkdbMy=JWAgybtimQXJRQ7jsVZ1g-DfqjryjP31JT9f=Prg@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] pinctrl: pinctrl-oxnas: remove obsolete pinctrl driver
To: neil.armstrong@linaro.org
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-oxnas@groups.io, 
	Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 4:44=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
> On 30/06/2023 18:58, Neil Armstrong wrote:
> > Due to lack of maintenance and stall of development for a few years now=
,
> > and since no new features will ever be added upstream, remove support
> > for OX810 and OX820 pinctrl & gpio.
>
> Do you plan to take patches 9, 10 & 11 or should I funnel them via a fina=
l SoC PR ?

I tried to apply them to the pinctrl tree but that fails ...
Could you rebase patches 9,10,11 onto my "devel" branch
and send separately? Then I will apply them right away.

Yours,
Linus Walleij

