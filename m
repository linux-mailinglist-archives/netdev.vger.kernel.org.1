Return-Path: <netdev+bounces-35446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1B97A9895
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798D528185A
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB7219BB8;
	Thu, 21 Sep 2023 17:22:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9003418C32
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:22:33 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137674BBCC;
	Thu, 21 Sep 2023 10:16:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c56bc62351so1040675ad.0;
        Thu, 21 Sep 2023 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316587; x=1695921387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHAAa/gf3HGuegRT5iGO1X/UDqUCnuMi0knFAFkXKOk=;
        b=CTJKSzI5GibbGvoI0aDOFnejz6Rygibm90Q/C+96PosqsgKckVxmNhKZgqbAvfNxZd
         lsgmDs2BV1Fbs32MYcSa/CjjnsSoG3xideKD+zyif5SZ/5OMe5TQGhi4XsmGVdkaTRoq
         EUAIzRPBwHU+A94R9kwU+TDOcGtsRYdVHv1SZyFihLR4Q3d3JxYPOPePxm7uAoPgkulb
         AKZD/INRBtGRuQLxSTOqSrvFA8NIKqfGcIz/2jP0Fsm1dawgLr+uT7CxZhaX8OYJoe9s
         QOQd0MUuXSAJh+42MpW8d3UC/fEoh+Ri4apq9l9LE/Di9mJUcPv5Uz/ry9+xZf+eMGCL
         UxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316587; x=1695921387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHAAa/gf3HGuegRT5iGO1X/UDqUCnuMi0knFAFkXKOk=;
        b=cOh2gFI7J/cPkuzDaOLA0JmOetIyBo48bx3fWNmDf8BwyaqMy4vEtj+3Ns/Y6jEdGT
         0sBMW+L2Pe7jT+J5nRrenxSOWHuUbNDPy/nGtjBRydWOoFGbDE+uSvvUCiwVTxbMUMS/
         Tw6TS1pZZnRrDQsR/IXMiCrU82aCSW0/50lyXXHMQltRJKCC/hjQ4/bowV6sbu1R3XWQ
         bHbaU+qdcan4d+KHgGxWNJw8NXmt3gV6L4LUGE0sD503Fyb499gbBcvZlyqGipkIstmg
         Q8/oKzZWG7vFOt0qS+hLIRKjuo2hq/3hnakJu9Tdxu6OxHOyRqFR3eHbPhrUpNrHZsq1
         BUQA==
X-Gm-Message-State: AOJu0YyNLfE3/LCzqg7ES88n2tfuLblF0pLQxuTL+WLvmNJ1YfcTuW+r
	odaefg+0dOeMN6fUoPNAe+SKiV7wd0lXh6yTCRgU0Or8Wck=
X-Google-Smtp-Source: AGHT+IEEAoTieOt7JBo611DbKMEQLNIQHeQKET+XBzRN4TEZwZCj6f9gZGsvGxet3THq3IAnB4Z9vjjCYPpbv0Ffs8g=
X-Received: by 2002:a17:90a:130c:b0:26d:1eff:619f with SMTP id
 h12-20020a17090a130c00b0026d1eff619fmr5078989pja.2.1695301138803; Thu, 21 Sep
 2023 05:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920184647.84316-1-festevam@gmail.com>
In-Reply-To: <20230920184647.84316-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 21 Sep 2023 09:58:47 -0300
Message-ID: <CAOMZO5AjMGA5TtTJH2b7Fs_C3bj84UZr378FVsp5S+ver8_WpQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: dsa: mv88e6xxx: Avoid EEPROM timeout when
 EEPROM is absent
To: kuba@kernel.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	l00g33k@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>, Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 3:47=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -3012,14 +3012,16 @@ static void mv88e6xxx_hardware_reset(struct mv88e=
6xxx_chip *chip)
>                  * from the wrong location resulting in the switch bootin=
g
>                  * to wrong mode and inoperable.
>                  */
> -               mv88e6xxx_g1_wait_eeprom_done(chip);
> +               if (chip->info->ops->get_eeprom)
> +                       mv88e6xxx_g2_eeprom_wait(chip);

Just realized that I should also remove the
mv88e6xxx_g1_wait_eeprom_done() definition, as it becomes unused now.

I will send a v3 with such a change, but will wait for more comments first.

