Return-Path: <netdev+bounces-13054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1020173A0C6
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD06A281956
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36F71E530;
	Thu, 22 Jun 2023 12:23:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F91E525
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:23:47 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E704199E
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:23:44 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f9b4bf99c2so40019515e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687436622; x=1690028622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZTvColTzRsoYYuXx98QVc9rgM+Sp5furEz7cmDxQqk=;
        b=FrdrBAh1oY9rhtVQjUyUaFAaGqRpbvPQjKnSFRgHkGPfttcKiwR+y/3oj436ntxKTD
         akF4OCyeqLPrY7j5rbRe2fiEkXmNPxKauFkmwgwqZeMjpiF5n5YJqff1Q6TZhOOVLufZ
         JepgQ/bIl1KkLeJWfzYlgsMk4BvnDZqp6fC1hLEVn4+8SKF94e+LSm3LhepY8fUQRc7q
         lGUC/S/Nj1OHp766ZJBxQxTdF5Nf/uRZ7jhrKyPyiVlH0u1Z3LWflIhvxkuZdqxJJYXe
         8qMkkWX2jB9wG1MEBKsvnOlSsV/eYQNUlxHECwjqMJiWC+/gTV4X0NyH70KlVJKfTDCG
         aepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687436622; x=1690028622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZTvColTzRsoYYuXx98QVc9rgM+Sp5furEz7cmDxQqk=;
        b=exusJPAvq0ONgax15E7jsJXn6o5wOua3bX3xHwW1QB8EdjSVnUlYTxaMq1mVHYPYmr
         PZWlO58+kqI7b3UbH2PocAdLX/NLTDCmZ6V8JnG98qeD3M2ANK2+LpyqU4vVrgj9ytOF
         vI1JZ1BIQvsgUtEnrExj1CtmOldb0znge55udKxKl7DEl0Vrt9RbfG8k5lbQtYGzHWw4
         5wQP5tLWaKCrdlMJkAFbQcdGxb5dPW416I6jw+wi1N9ildD+QOCxJtVYFhUaV2ZAFdcI
         wsikDx7M2Imp0WXMFVHbO5F8uptgk0uczj3ouXdb6fS+BX3c84Ewt4weMII6DYLAr7cr
         IAew==
X-Gm-Message-State: AC+VfDxCKn0C1Wyc5nBuXWgzfNu+c7vZpuLy+WKM3yLkiuh0OgPEMeV/
	TlifFoZyxsJPfk9ROExPriEukQ==
X-Google-Smtp-Source: ACHHUZ49yPhRB3Bsa6UwNftE5A3qbasCqFJ2m3h6OWnmPw2gcLquyHRYJ35Gq1sHi5pE0z7HxWfdwg==
X-Received: by 2002:a1c:7209:0:b0:3f9:a10:10d0 with SMTP id n9-20020a1c7209000000b003f90a1010d0mr10666150wmc.17.1687436621924;
        Thu, 22 Jun 2023 05:23:41 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id c25-20020a7bc859000000b003f90ab2fff9sm7600746wml.9.2023.06.22.05.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:23:41 -0700 (PDT)
Date: Thu, 22 Jun 2023 14:23:39 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Vivek Yadav <vivek.2311@samsung.com>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v2 5/6] can: tcan4x5x: Add support for tcan4552/4553
Message-ID: <20230622122339.6tkajdcenj5r3vdm@blmsp>
References: <20230621093103.3134655-1-msp@baylibre.com>
 <20230621093103.3134655-6-msp@baylibre.com>
 <32557326-650c-192d-9a82-ca5451b01f70@linaro.org>
 <20230621123158.fd3pd6i7aefawobf@blmsp>
 <21f12495-ffa9-a0bf-190a-11b6ae30ca45@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21f12495-ffa9-a0bf-190a-11b6ae30ca45@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Krzysztof,

On Wed, Jun 21, 2023 at 03:00:39PM +0200, Krzysztof Kozlowski wrote:
> On 21/06/2023 14:31, Markus Schneider-Pargmann wrote:
> > Hi Krzysztof,
> > 
> > On Wed, Jun 21, 2023 at 12:28:34PM +0200, Krzysztof Kozlowski wrote:
> >> On 21/06/2023 11:31, Markus Schneider-Pargmann wrote:
> >>> tcan4552 and tcan4553 do not have wake or state pins, so they are
> >>> currently not compatible with the generic driver. The generic driver
> >>> uses tcan4x5x_disable_state() and tcan4x5x_disable_wake() if the gpios
> >>> are not defined. These functions use register bits that are not
> >>> available in tcan4552/4553.
> >>>
> >>> This patch adds support by introducing version information to reflect if
> >>> the chip has wake and state pins. Also the version is now checked.
> >>>
> >>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> >>> ---
> >>>  drivers/net/can/m_can/tcan4x5x-core.c | 128 +++++++++++++++++++++-----
> >>>  1 file changed, 104 insertions(+), 24 deletions(-)
> >>>
> >>> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> >>> index fb9375fa20ec..756acd122075 100644
> >>> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> >>> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> >>> @@ -7,6 +7,7 @@
> >>>  #define TCAN4X5X_EXT_CLK_DEF 40000000
> >>>  
> >>>  #define TCAN4X5X_DEV_ID1 0x00
> >>> +#define TCAN4X5X_DEV_ID1_TCAN 0x4e414354 /* ASCII TCAN */
> >>>  #define TCAN4X5X_DEV_ID2 0x04
> >>>  #define TCAN4X5X_REV 0x08
> >>>  #define TCAN4X5X_STATUS 0x0C
> >>> @@ -103,6 +104,13 @@
> >>>  #define TCAN4X5X_WD_3_S_TIMER BIT(29)
> >>>  #define TCAN4X5X_WD_6_S_TIMER (BIT(28) | BIT(29))
> >>>  
> >>> +struct tcan4x5x_version_info {
> >>> +	u32 id2_register;
> >>> +
> >>> +	bool has_wake_pin;
> >>> +	bool has_state_pin;
> >>> +};
> >>> +
> >>>  static inline struct tcan4x5x_priv *cdev_to_priv(struct m_can_classdev *cdev)
> >>>  {
> >>>  	return container_of(cdev, struct tcan4x5x_priv, cdev);
> >>> @@ -254,18 +262,68 @@ static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
> >>>  				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
> >>>  }
> >>>  
> >>> -static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
> >>> +static const struct tcan4x5x_version_info tcan4x5x_generic;
> >>> +static const struct of_device_id tcan4x5x_of_match[];
> >>> +
> >>> +static const struct tcan4x5x_version_info
> >>> +*tcan4x5x_find_version_info(struct tcan4x5x_priv *priv, u32 id2_value)
> >>> +{
> >>> +	for (int i = 0; tcan4x5x_of_match[i].data; ++i) {
> >>> +		const struct tcan4x5x_version_info *vinfo =
> >>> +			tcan4x5x_of_match[i].data;
> >>> +		if (!vinfo->id2_register || id2_value == vinfo->id2_register) {
> >>> +			dev_warn(&priv->spi->dev, "TCAN device is %s, please use it in DT\n",
> >>> +				 tcan4x5x_of_match[i].compatible);
> >>> +			return vinfo;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	return &tcan4x5x_generic;
> >>
> >> I don't understand what do you want to achieve here. Kernel job is not
> >> to validate DTB, so if DTB says you have 4552, there is no need to
> >> double check. On the other hand, you have Id register so entire idea of
> >> custom compatibles can be dropped and instead you should detect the
> >> variant based on the ID.
> > 
> > I can read the ID register but tcan4552 and 4553 do not have two
> > devicetree properties that tcan4550 has, namely state and wake gpios.
> 
> Does not matter, you don't use OF matching to then differentiate
> handling of GPIOs to then read the register. You first read registers,
> so everything is auto-detectable.
> 
> > See v1 discussion about that [1].
> 
> Yeah, but your code is different, although maybe we just misunderstood
> each other. You wrote that you cannot use the GPIOs, so I assumed you
> need to know the variant before using the GPIOs. Then you need
> compatibles. It's not the case here. You can read the variant and based
> on this skip entirely GPIOs as they are entirely missing.

The version information is always readable for that chip, regardless of
state and wake GPIOs as far as I know. So yes it is possible to setup
the GPIOs based on the content of the ID register.

I personally would prefer separate compatibles. The binding
documentation needs to address that wake and state GPIOs are not
available for tcan4552/4553. I think having compatibles that are for
these chips would make sense then. However this is my opinion, you are
the maintainer.

Best,
Markus

> 
> > 
> > In v1 Marc pointed out that mcp251xfd is using an autodetection and warn
> > mechanism which I implemented here as well. [2]
> 
> But why? Just read the ID and detect the variant based on this. Your DT
> still can have separate compatibles followed by fallback, that's not a
> problem.
> 
> 
> Best regards,
> Krzysztof
> 

