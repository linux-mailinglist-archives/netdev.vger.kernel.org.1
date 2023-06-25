Return-Path: <netdev+bounces-13807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A493E73D0BD
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 14:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822601C208FE
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 12:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7493FEC;
	Sun, 25 Jun 2023 11:59:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909512109
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 11:59:58 +0000 (UTC)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EAFDD
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 04:59:57 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-4718bc88afdso1817188e0c.0
        for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687694396; x=1690286396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqK8AlIXPu2XJBYa0seEiu0k2STeyrU+nnU7R790jtc=;
        b=JCfFsPVKB2dru+BO+ne35Cgh7f7dmWZ8I9lPttynsHQrPE2KXUYTZbM0Jqso/MPc5m
         nX3kyuGlaoViQkt8V0rNgkDE/01AaCKFhX/k14yfkarPtGVJSe9h82Ze6E9oZiIjDGCG
         irVlA539knPnmhX/hgAD0InOk7wgy2KBmFPTjscm1sDiOW9mrfjIUA8Z8uBN147sF1wc
         qbwIEgO4gr4y5xHvhoGoth/87UlWnn/2nfLcTyOn4y38vzMVgZCQuJvV4dC1yCzaxlvS
         COSNwOI56jPDtO9mK3QYCf3X2yZ0DQPq1gDDn5pVufzuFLJa5Mo9ZNl9uYcCq9g/8EXO
         i2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687694396; x=1690286396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqK8AlIXPu2XJBYa0seEiu0k2STeyrU+nnU7R790jtc=;
        b=ZFRVw4byL7IIrNXCmWci9NM8REGuvwxcR6gXBzht7Pi7LZSk6P3KZSycbOiXt/mbjv
         AF9hOsbYxAfkQwLmpFR5A1eaM04ztZ0bD1ZJx4QjodMetzzxtF1UYSTTLkGXc5Bp9/Bm
         zriWUXKbjF66JMPpQ28q/iapjpCLzvjKcFxj57F2NlVoHtaYC2xwY1paJj2VMkRdChXN
         13DdMMQRCA4chjmpWVvdFGwW/SGfgVSrQDGTDb1Cn+0Swq55Zy/aYyacnooFTZ6HtczY
         M/8s0x4bWrL1vEbg/kKUfNBQsr+oNe8Yg9c0A4AOAWwrjKNQD65yd2ezSwKx4joFYWZg
         Rjhw==
X-Gm-Message-State: AC+VfDzrMddBIbchOwv2gODvi8/6Jxn41j9z4N5QL1e73eEbThe2GDeC
	JVD0rlHXsPF6cjr1M8D38bB8qd6YpjZtBOsL5htwxaVjcwDzVg==
X-Google-Smtp-Source: ACHHUZ5zFuLpOqElZq163rkzTbszHl8yY6oULKmpi1OEJWqOQK029r5x7LI+wHA7uNpBTBYR9r+Nw2V8tFQ9ZFRtNaA=
X-Received: by 2002:a05:6122:10dc:b0:47c:e74d:876b with SMTP id
 l28-20020a05612210dc00b0047ce74d876bmr23118vko.5.1687694396337; Sun, 25 Jun
 2023 04:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com> <20230621191302.1405623-7-paweldembicki@gmail.com>
In-Reply-To: <20230621191302.1405623-7-paweldembicki@gmail.com>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Sun, 25 Jun 2023 13:59:45 +0200
Message-ID: <CAJN1Kkx74f=61fi-QOVs+jT3fLQVUUU=sJaTm5e0BBn--QnPig@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] net: dsa: vsc73xx: Make vsc73xx usable
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, Russell King <linux@armlinux.org.uk>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

=C5=9Br., 21 cze 2023 o 21:14 Pawel Dembicki <paweldembicki@gmail.com> napi=
sa=C5=82(a):
>
> This patch series is focused on getting vsc73xx usable.
>
> First patch is simple convert to phylink, because adjust_link won't work
> anymore.
>
> Patches 2-5 are basic implementation of tag8021q funcionality with QinQ
> support without vlan filtering in bridge and simple vlan aware in vlan
> filtering mode.
>
> STP frames isn't forwarded at this moment. BPDU frames are forwarded
> only from to PI/SI interface. For more info see chapter
> 2.7.1 (CPU Forwarding) in datasheet.
>
> Last patch fix wrong MTU configuration.
>
> Pawel Dembicki (6):
>   net: dsa: vsc73xx: convert to PHYLINK
>   net: dsa: vsc73xx: add port_stp_state_set function
>   net: dsa: vsc73xx: Add dsa tagging based on 8021q
>   net: dsa: vsc73xx: Add bridge support
>   net: dsa: vsc73xx: Add vlan filtering
>   net: dsa: vsc73xx: fix MTU configuration
>
>  drivers/net/dsa/Kconfig                |   2 +-
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 928 ++++++++++++++++++++-----
>  drivers/net/dsa/vitesse-vsc73xx.h      |   1 +
>  include/net/dsa.h                      |   2 +
>  net/dsa/Kconfig                        |   6 +
>  net/dsa/Makefile                       |   1 +
>  net/dsa/tag_vsc73xx_8021q.c            |  87 +++
>  7 files changed, 857 insertions(+), 170 deletions(-)
>  create mode 100644 net/dsa/tag_vsc73xx_8021q.c
>
> --
> 2.34.1
>

I pushed v2. Thank Russell, Jakub, Simon and other people for helping me.

--
Pawel Dembicki

