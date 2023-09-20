Return-Path: <netdev+bounces-35166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BED97A771B
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 11:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9791C2032E
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85981173F;
	Wed, 20 Sep 2023 09:21:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51831173C
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 09:21:07 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9C8F0
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 02:21:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d84acd6dbb1so993754276.1
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 02:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695201664; x=1695806464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnEAQ90o+f6DMdRJ6lr8keO7n5nDLjmeliz0Xh5jSU4=;
        b=Kbg8UFDhXeofaZuGsNMRS84qzHKv7e4SAiKE24/04EdLoi3efWp3h6F8W9W1aJl/Fw
         atX/rdW6CSZmgjzssIXzi1IKPWbqIzojgwFaGBM4UhM8axB4QYs73bCdRUXeh7BnpPoY
         ggGQb0NG+qdVC8JjBlbeLupGaGL0PvhXX/UqiC2Tarm6hCWOTYdiBc8fO8R42eTPj+95
         cRVVPa01hGDYelBWs3VX9o2TNkldukUxCyM2h+bF4m0GSvVa72sO24jWBWtCD2Pj8BNe
         6VcQLO+sxTaUSgEd7p5QhrGdb+FGyIM1R9ilFTdADAHVhIAxAjEgX+1lrDWjuhCj1twk
         Uh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695201664; x=1695806464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnEAQ90o+f6DMdRJ6lr8keO7n5nDLjmeliz0Xh5jSU4=;
        b=ddrT3FK1Ru8zm6QZWr0BrwZUMjs/wQGkaCEdcsLiKdEiUKIdZx+Cc/bPJb2gS/24Ui
         pFQTXfreqFr03YRWEbEs/IT0POrFoVal28QVujL8AADWW+Io/yUhBIEH+KVwa7CiPGqK
         rHU+amuAYqXflWLSLWJrxjlPoPr6bvXUmgYnvPgX+RUeIUHcFfS+OFCVigt4mfAlNuvk
         6bZNwx3mWUNupLE72tk6zIYPWSagM3aG9AgW2rt22rwvPiXO+5o7kaMMCBEcboUeFPRJ
         ekGA5/SMDOp3xRFQyCh1PX6OvEUqlaqDbUtWgsPSBD/ATG9NkJU1UfyD/qsBClMaBafM
         sBbg==
X-Gm-Message-State: AOJu0Yy1zyvt5fj6fYlBE+IQdjlyAANnIFgHje9lWRjyu+jc1HfTHL2d
	QvNB4U880BKcnoFsGBmKN3j5BJipAwZHhft/DhuUKg==
X-Google-Smtp-Source: AGHT+IHoQFswYaiTREno3Vnv3gvPlGWS0MbiYMIRPU6u43C2iHDW2s2r8vatUorM0+u6o/9CwaOk4hW7LeF2N5gk9Qw=
X-Received: by 2002:a25:acd0:0:b0:d78:414d:1910 with SMTP id
 x16-20020a25acd0000000b00d78414d1910mr5290712ybd.25.1695201664428; Wed, 20
 Sep 2023 02:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de>
 <20230918204227.1316886-55-u.kleine-koenig@pengutronix.de> <m3a5th1dtu.fsf@t19.piap.pl>
In-Reply-To: <m3a5th1dtu.fsf@t19.piap.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Sep 2023 11:20:53 +0200
Message-ID: <CACRpkdZAK1k1CZFn0MUQXMMK_k6fJeCU1t2rqV-HL568v0wYtw@mail.gmail.com>
Subject: Re: [PATCH net-next 54/54] net: ethernet: xscale: Convert to platform
 remove callback returning void
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>, 
	Deepak Saxena <dsaxena@plexity.net>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Linus Walleij <linusw@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 9:52=E2=80=AFAM Krzysztof Ha=C5=82asa <khalasa@piap=
.pl> wrote:

> BTW, Linus, this is a separate entry in MAINTAINERS (INTEL IXP4XX QMGR,
> NPE, ETHERNET and HSS SUPPORT). Perhaps you'd want it as well?

Indeed I guess I should move it all under the IXP4xx platform
simply.

Also Deepak is still listed as maintainer of the RNG
which is inside the NPE, I think he has basically retired
from maintenance as well because I think he mentioned that
he got rid of his IXP4xx hardware.

> While I still have access to IXP425 and IXP435 hw,

Are they supported by the DTS files I created?

> I haven't (literally)
> touched them in years, so I guess there is very little reason (or rather
> none at all) for me to linger as a maintainer of anything related to
> IPX4xx anymore. If you wish, I can prepare a MAINTAINERS patch, or
> something.

Could you group the network and the RNG (which is just below it
in MAINTAINERS) under the architecture (where you are BTW
still listed).

The devices mostly "just work" now though so if you touch them
I bet they will come online nicely. This fork of OpenWrt has all
that's needed to bring up devices:
https://github.com/linusw/openwrt/commits/ixp4xx-v6.1

Yours,
Linus Walleij

