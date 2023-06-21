Return-Path: <netdev+bounces-12844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866E673917C
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 23:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153492816F2
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F631C77D;
	Wed, 21 Jun 2023 21:28:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C7119E52
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 21:28:24 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B561BC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:28:23 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bff4f1e93caso986133276.0
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687382902; x=1689974902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I23QwpbRVC93I2xN0J8C9PPNt1nuyTNz6gUJBDkbm84=;
        b=copINrrPigwq5XhYM0SrXJMptbcqpEzn+RkQM4XMh3yKWGKY9ONl1YvTPhC3Z+Ikxp
         YQqob2hF6oFAB5uT1bjoNbOK4Q+vd1uk0a0mvxrjoULfEfq4ubxQBg258ewBeDabFQfp
         TJKjbcbMYiTJtrSlXGCDgCyl5FlfqU3K5Qf2Y3IgViEbAFAGET4dMKTuC3ivF8GmNl1D
         OzmWfUPRqYLq4g/f24oe5CkcEZwzlcYtqUSHVDU24tyK2iuSDszNSEfYI2uzXXqpNjoL
         ptR+ptbrjuZ8l22N0ShYP5Tp05IfhKVRGe+2yy1BOavGWypIoS7gQ81kpsd+zj6RJaM5
         cw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687382902; x=1689974902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I23QwpbRVC93I2xN0J8C9PPNt1nuyTNz6gUJBDkbm84=;
        b=f3pHquAgYeiofi1pxr/4jj5BzflwVJujcMGHl8UApfM3hZuoBWppCCcNhA2medrhos
         gIgrtm+Go4ELxi/J6hQU3a8+wLc6adUedTS7JVedF3FaC5dNzE3Wy3q3gPi15je1k9UJ
         ggkauKiCxZ0jZWJTgtqGNV0cGkCVjREU4Qli0Rsmudd1YBzydtaOH/qPTCSo3tTlHc8n
         835fTNmXSevqyfasEQlsiU1tgCZKHju4TuwsSRrhc9QsUKB+uTwGYTrP3SFxfEQSu268
         kPp5s/hPrr8hF+q9kwEZeHGGYfMOdq6BvPGaRdomTFlYjstGCYyrKrpRx/pRn7r32tjs
         apuw==
X-Gm-Message-State: AC+VfDy//aEdElskKddjL8EgW5yu5qpghBY95FpceGWcmnysPPWrNvx2
	8tBlZYXe3b77HeRivrZu/COx4umROQlU3Fji+r9EKQ==
X-Google-Smtp-Source: ACHHUZ4yERI5vFsl4RR99IkTQFRJT6kLO4bTKnqG2lAKzNozcmaIEuZz/O0vXYKegBPiwDcRHCIDPhtvjxixs6ZIqCc=
X-Received: by 2002:a25:df84:0:b0:bcc:f2cc:73e with SMTP id
 w126-20020a25df84000000b00bccf2cc073emr13862828ybg.22.1687382902657; Wed, 21
 Jun 2023 14:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com> <20230621191302.1405623-2-paweldembicki@gmail.com>
In-Reply-To: <20230621191302.1405623-2-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Jun 2023 23:28:11 +0200
Message-ID: <CACRpkdaAgW+ya50AHTi7QZqLe_HzFDZD7km5ieViruv-GCCHtQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/6] net: dsa: vsc73xx: add port_stp_state_set function
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 9:13=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This isn't fully functional implementation of 802.1D, but
> port_stp_state_set is required for future tag8021q operations.
>
> This implementation handle properly all states, but vsc 73xx don't
> forward STP packets.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

I think it is a best effort and should be merged.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

