Return-Path: <netdev+bounces-22075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D5F765DD9
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 23:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A8A2824D3
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 21:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E3E1CA02;
	Thu, 27 Jul 2023 21:17:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D022714B
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 21:17:02 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A132030EA
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 14:16:56 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d07c535377fso1385131276.1
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 14:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690492616; x=1691097416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uGRhmfCXLxN6YU1cWESg55BRtPox1xD8u6NHDhwMzU=;
        b=wswgZlkJ4NBe7/FtnWso7C3R/rqxZSJUmuWg9QHSi9JMGr8w9D2uQzTwgYsequJulq
         is/1hwyg+1vqmZ9shtq1fLohk50d+i8QBH94zB9Ej1yzYbUEOx8Q8l3bt0oVwirfr+xh
         AcGAad0J9UQ+W6bzboUyHjcJsZi+WSrDF+7OkvzGWimEu22FXf1MLJ5EWwQk8FgWWRli
         5nuxAenh9aEGSFI3R+2Wy25KS6nV9YXFHtJMJgUjRnHRAdpCMvCEBYpGfAgwwEMdv3tk
         6JayWaqklc5v3KEH7PSXfzGTJ/CMqnzNShHlNUjbz1y94StJOZzcLCOnavQ4iCJKf8+F
         iyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690492616; x=1691097416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uGRhmfCXLxN6YU1cWESg55BRtPox1xD8u6NHDhwMzU=;
        b=N4WL2zR7IDv2ujvovpzYk2CCi/pvvZwhpZ5gr+A48VIefGdm3LtGEjksz1s+c+Yuzu
         3XuFWuo+C9jd2tWPY6qmHt5sdD+sMj+RIXQ/Nu7JTfVOvUIxytcZTaKb3zju41lFRwLG
         aEewF+eZO9f17kSvgrYlGgFCeWHhe/S63G0uhoCo3/NlW8HFh9zCf4QSY31kkuFKaIzW
         m2v5BH3JjxOwjqPwBGvvMu96nq3+PPZ4rcm1qce67zkw0EYes9RJoqCE9FLupWR64I7x
         E/bs3a6E43YoJM4+XK4s2MJGlwOUz4pOy5utzECb78UxvMy36YTWwBCJdbGDbfYIZy3Q
         9y+Q==
X-Gm-Message-State: ABy/qLadzIeXI9/SEDDM6BEeMQbyQGxmXKxXIpZHHmMQeiyFQ5UF8OzL
	9myIdr/1EY8+io6FY0jfOmKQr2jcd9TuYbPsxn9TcA==
X-Google-Smtp-Source: APBJJlF/WP9UF5vhbN5Eh27rtP31+QJ0KngVSCOWM/D/823cWc4t3dHqdkGuZ+k5czJWqkSh0GU74FyljZsGrCSOQus=
X-Received: by 2002:a25:fe0f:0:b0:cfa:f7cb:be16 with SMTP id
 k15-20020a25fe0f000000b00cfaf7cbbe16mr513279ybe.49.1690492615774; Thu, 27 Jul
 2023 14:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com> <20230623123820.42850-8-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20230623123820.42850-8-arkadiusz.kubalewski@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Jul 2023 23:16:42 +0200
Message-ID: <CACRpkdar39x8nd5cWEDiFDHwLqHghUQZqkR0rEcv2-sZOZZ0KQ@mail.gmail.com>
Subject: Re: [RFC PATCH v9 07/10] ice: add admin commands to access cgu configuration
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: kuba@kernel.org, jiri@resnulli.us, vadfed@meta.com, 
	jonathan.lemon@gmail.com, pabeni@redhat.com, corbet@lwn.net, 
	davem@davemloft.net, edumazet@google.com, vadfed@fb.com, 
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, saeedm@nvidia.com, 
	leon@kernel.org, richardcochran@gmail.com, sj@kernel.org, javierm@redhat.com, 
	ricardo.canuelo@collabora.com, mst@redhat.com, tzimmermann@suse.de, 
	michal.michalik@intel.com, gregkh@linuxfoundation.org, 
	jacek.lawrynowicz@linux.intel.com, airlied@redhat.com, ogabbay@kernel.org, 
	arnd@arndb.de, nipun.gupta@amd.com, axboe@kernel.dk, linux@zary.sk, 
	masahiroy@kernel.org, benjamin.tissoires@redhat.com, geert+renesas@glider.be, 
	milena.olech@intel.com, kuniyu@amazon.com, liuhangbin@gmail.com, 
	hkallweit1@gmail.com, andy.ren@getcruise.com, razor@blackwall.org, 
	idosch@nvidia.com, lucien.xin@gmail.com, nicolas.dichtel@6wind.com, 
	phil@nwl.cc, claudiajkang@gmail.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, poros@redhat.com, mschmidt@redhat.com, 
	linux-clk@vger.kernel.org, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Arkadiusz,

On Fri, Jun 23, 2023 at 2:45=E2=80=AFPM Arkadiusz Kubalewski
<arkadiusz.kubalewski@intel.com> wrote:

> +/**
> + * convert_s48_to_s64 - convert 48 bit value to 64 bit value
> + * @signed_48: signed 64 bit variable storing signed 48 bit value
> + *
> + * Convert signed 48 bit value to its 64 bit representation.
> + *
> + * Return: signed 64 bit representation of signed 48 bit value.
> + */
> +static s64 convert_s48_to_s64(s64 signed_48)
> +{
> +       return signed_48 & BIT_ULL(47) ?
> +               GENMASK_ULL(63, 48) | signed_48 : signed_48;
> +}

Can't you just use sign_extend64() from <linux/bitops.h>
passing bit 48 as sign bit istead of inventing this?

Yours,
Linus Walleij

