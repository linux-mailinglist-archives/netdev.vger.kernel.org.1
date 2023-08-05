Return-Path: <netdev+bounces-24631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A142D770E47
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 09:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FE41C20FAB
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 07:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D673D82;
	Sat,  5 Aug 2023 07:10:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536DE5662
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 07:10:21 +0000 (UTC)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FFF4EC1
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 00:10:19 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-4475af775c7so1118718137.0
        for <netdev@vger.kernel.org>; Sat, 05 Aug 2023 00:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20221208.gappssmtp.com; s=20221208; t=1691219418; x=1691824218;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nF+ZgwACbRGT9LEYo55hMN6MiM10T9u+ZJOFJqYdrJ4=;
        b=LOmN7OPOKCvi4TvpUMgl8x5HiADRuWYZpJZu6yx7U9+hIBxRN+i3ou4dGk2DIPiXPl
         pV0Z4DO6w/zCQg7EkO0bs4tLgoCjsyVe0y5Vac+X7gC9cH6S+0nSQWLzvic9jE5UBLUN
         kZlyap98tTKmft+5s3hRsj5C6eZUjxVuUuVcXqUU6Mwodg461SPgWugCKQtIrk70IuhE
         3WJooQ16oq9SXN0Lcq1ZLolMdD3fo6UfgoAu691gRB9prMb0OFmjpeNR2AOXRPA2CMsp
         1JsUgWa1Tc1r3cZ23aShZyikwFIaQvTJb5wmbUPw7h/YEutKgiHmFqmCOTSRYl2wp3Sj
         z5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691219418; x=1691824218;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nF+ZgwACbRGT9LEYo55hMN6MiM10T9u+ZJOFJqYdrJ4=;
        b=WldzMFgL7hv3l/g2rBL0WfCZNFvR2mT6P7Gdpy/3VoUBQclnN515Urf0vCZ1qICO5x
         Zb/YnTIoJP6jtUpmyQWzt0ewOchdmOTjCAOLPPwScoFD0A01/W6/eDtKcxwENSdHikjH
         2M8LGWS5qgg76YA9jfnLsbU0ikIHmW+DOsBHELjV0QrFsAznGlpSdtC4fGicSHAZfgk1
         PBzUAbWMIbjostCxPoTasZRuVjnXtVj8eXqRBXv18WxcA73Gsptm44BAPLBU0I7in968
         6tlFK/2ZpdPYcRq8SvTCKIBWhwYo1c4nnQgB4fd6nFgzy07muaNuaHjVTdEUAh7pbyid
         0ziQ==
X-Gm-Message-State: AOJu0YxbhV0s1rPGh4VoX21vHgOWMs0ICpP2xdx0TGBsoEpFmOd8eC+i
	QLcLsXDa1SJToKVan3t5JnZUWgzOrmj7f7lx3FJomw==
X-Google-Smtp-Source: AGHT+IFx2XvOW48sXZOXPCjRq/0LFgizAkntyv+TimQK7R2a7O4TX4LTwY324ULJ3jxf/98xhu1if73Mreo4AFFMiQ0=
X-Received: by 2002:a67:e3c3:0:b0:443:83ac:52b4 with SMTP id
 k3-20020a67e3c3000000b0044383ac52b4mr2241120vsm.3.1691219418701; Sat, 05 Aug
 2023 00:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ab0:6209:0:b0:794:1113:bb24 with HTTP; Sat, 5 Aug 2023
 00:10:18 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <173b1b67-7f5a-4e74-a2e7-5c70e57ecae5@lunn.ch>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
 <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
 <CADyTPExgjcaUeKiR108geQhr0KwFC0A8qa_n_ST2RxhbSczomQ@mail.gmail.com>
 <CAL_Jsq+N2W0hVN7fUC1rxGL-Hw9B8eQvLgSwyQ3n41kqwDbxyg@mail.gmail.com>
 <CADyTPEyT4NJPrChtvtY=_GePZNeSDRAr9j3KRAk1hkjD=5+i8A@mail.gmail.com>
 <CAL_JsqKGAFtwB+TWc1yKAe_0M4BziEpFnApuWuR3h+Go_=djFg@mail.gmail.com>
 <CADyTPEwY4ydUKGtGNayf+iQSqRVBQncLiv0TpO9QivBVrmOc4g@mail.gmail.com> <173b1b67-7f5a-4e74-a2e7-5c70e57ecae5@lunn.ch>
From: Nick Bowler <nbowler@draconx.ca>
Date: Sat, 5 Aug 2023 03:10:18 -0400
Message-ID: <CADyTPExypWjMW2PF0EfSFc+vvdzRtNEi_H0p3S-mw1BNWyq6VQ@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 2023-08-05, Andrew Lunn <andrew@lunn.ch> wrote:
>> When I revert that commit, I can locate the phy device under all these
>> locations.
>
> Please do what Russell requested, but also try commenting out the PHY
> reset-gpios line in DT which was added by
> c720a1f5e6ee8cb39c28435efc0819cec84d6ee2.

Removing the reset-gpios line from the dts appears to be sufficient to
restore working behaviour.

> It was also commented out before that change. It could be that gpio
> controller is missing. Do you have the driver for the tca6416 in
> your kernel configuration?

I have CONFIG_GPIO_PCA953X=y which I think is the correct driver?

Thanks,
  Nick

