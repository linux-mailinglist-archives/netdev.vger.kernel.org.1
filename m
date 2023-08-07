Return-Path: <netdev+bounces-24820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34732771CC3
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 11:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42DA280F38
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 09:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9247495;
	Mon,  7 Aug 2023 09:01:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15EBC2DF
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 09:01:07 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196F5E70
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 02:01:06 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d1fb9107036so4717364276.0
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 02:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691398865; x=1692003665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmPeF2Yo4yjKKsdpscDMoUm9x/eDwRXj5nItZhzfM78=;
        b=xwjGnQ22TOvfWV9zTt168I4LV00sZqTUcBeX/cs7f9wHCm3yhi9zZk4HkInarayqdL
         hbFoARgGD3zyplYs2CQrzVSqenn1thDeAegEpu+5IzplQyIWIB2OkX8tBF7MVkC8TORu
         iT6ZOf6xxUr6x7TuJgla6W06am+pbwPo3ldOfNSJxr819tbF8oa17l3ZMA3uInqUfwCy
         Y6UTMaQ3OjzXlnqhp8Z/S8aCGSax4oQ2T5uUt9LzppuyXmMmegnntrPF6ADX/4CG2RAq
         P1dGrHIy9Ta9y3StKmvvWDFGYo8CfDm36rlsXMzL1P67db/om0PR4TmCtAEJmY0L/XnW
         OS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691398865; x=1692003665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmPeF2Yo4yjKKsdpscDMoUm9x/eDwRXj5nItZhzfM78=;
        b=IzsktqbBQCp5Y9YHnSqotZd4siCicJPsFOBX4jW9OI4SzVbTyD+7bfepaVvlbO/nb6
         dzatVJpCkN0mJR7YrEqcQA+vQraqqaEzvnUQ8Mc5jscdeJyvq0RKsjPBNZDnCFvY/yX3
         ze8XwvdKkuIiTwsNF0T48lddlvd42i7OIBPMR4kDfi79PtV8Zr7sLT5wCRkbIowN5Enb
         wwKp4F/1QixVe3IKhYj+yzuZxh5EafQ9WwZ7deQj4zSC5tAjNMN3APxIV7fX2+sVqQcV
         ZBpkPPHvACaaBPKjIS2LDc2k4uXN1PEmaZVfsw5yre3uDXMB7FlAvzKLbEYfqTa7EM8P
         AvAQ==
X-Gm-Message-State: AOJu0YxD3sf0ftyp45KeLFA4S/ySdBm9TqL/RtGqP54KBUDSNRIVI/bF
	3WlBgTbYV37mbpEoyuHU70ofD4EGo4fnMxqnKUkgrQ==
X-Google-Smtp-Source: AGHT+IGNz3qMrODq1LB5wqlhtqjoComq5pxU82VLl/izKto2p2jjd4gCjQ6Fb7pJkQbUsvyv5AUjgJJy55C7aN4ZuV4=
X-Received: by 2002:a5b:a8f:0:b0:d06:7e60:251a with SMTP id
 h15-20020a5b0a8f000000b00d067e60251amr8530675ybq.49.1691398865306; Mon, 07
 Aug 2023 02:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230712022250.2319557-1-colin.foster@in-advantage.com>
 <20230712022250.2319557-2-colin.foster@in-advantage.com> <CACRpkdYXeGq2LnD+bpAXm82Aa-Czob8afQSfjfMFweBLhdr9uw@mail.gmail.com>
 <ZLmSvkizdykGGpv6@MSI.localdomain> <20230724065957.a72yejua7us5e2s3@soft-dev3-1>
 <ZL7JJ2nLA27Z/VnR@colin-ia-desktop>
In-Reply-To: <ZL7JJ2nLA27Z/VnR@colin-ia-desktop>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 7 Aug 2023 11:00:54 +0200
Message-ID: <CACRpkdZBzEqAiztAjfQw7wymb6sjpx2Wwgn_RP4ZuO6EdDLMzQ@mail.gmail.com>
Subject: Re: [RFC RESEND v1 pinctrl-next 1/1] pinctrl: microchip-sgpio: add
 activity and blink functionality
To: Colin Foster <colin.foster@in-advantage.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	UNGLinuxDriver@microchip.com, Daniel Machon <daniel.machon@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 8:55=E2=80=AFPM Colin Foster
<colin.foster@in-advantage.com> wrote:

> Is there a tree I should test these patches against? I don't have any
> active development going on so I've been hopping along the latest RCs
> instead of keeping up with net-next, gpio-next, or otherwise...

Use the "devel" branch in the pinctrl tree:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/lo=
g/?h=3Ddevel

If you resend based on this branch I'll apply the patch, I think Horatiu's
reply counts as an Acked-by so record it as such.

Yours,
Linus Walleij

