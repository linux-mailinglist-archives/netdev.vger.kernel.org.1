Return-Path: <netdev+bounces-26306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B275777771
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9262282075
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06671F958;
	Thu, 10 Aug 2023 11:43:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DDC1DDF0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:43:45 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C6B83
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 04:43:44 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ccc462deca6so757526276.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 04:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691667824; x=1692272624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oL36QLiViprzn+D+ZWCkWvBnqNCptB0lN73iKQuirFQ=;
        b=y7kCnI69HxExw+MxsiCIfcA49blmdcjUyl5SS0/8bRbzfkNopPZTw4lvFNhr7Jr9VT
         QIudvkr6xe24/0japmubXLvd4/OmMJuTl1bb9UsZAQHDmrKizjE34aYrbYPXdGGCGllY
         0J6lqmp58uUGSJM9uqiLjO2sr0MWS2M7bdc7VHcdzGTtUYllOvtLCWDUwO+NrXgllXxo
         RaIC8utmFE2Wzzkl0AYpSJjhBa2GveWIUstkLFW/4NWchwSU4bSAzWvCdkggyxEIVDpn
         WhcGue46u/fi1AoMhC1mUVMQ0saQoFncgBSqRSUG5kKsgJPyj15Oda5qM1RkkkaWBT+V
         v4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691667824; x=1692272624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oL36QLiViprzn+D+ZWCkWvBnqNCptB0lN73iKQuirFQ=;
        b=fKM02rShf5zAmxYD+yVbgZRB3i0sNix1mxYGlPMRFFcmvN49XABXNHgFwe5OURaxK4
         qj4C83AcjhVl/UVZO0sovwIE9kwQBW6WzBcp6PJw1zMKamlU6Rvj67294+3WHoj3uwPt
         VWN3glorBuTiRAAqs7hSNgjzxDbQxcw5kiCHcqfJgUh0dShbVicw6E1YfCSj9Wf9/qok
         XkD3TeWyCD7NnRJIqOyZe3VFuFdo48Q/GXJrBCSfqM7BEe51ttcCvpq/QK0PIbLSRBJf
         cVdS+6TT9x3dOks+DTaPbYTIJuGdWTDZ4ZEOfoA/y1EV3iqyBo517o7364rzSTqHrzuB
         jc8Q==
X-Gm-Message-State: AOJu0YwrY9VJQhqzoksQwAy/F/lJ6SexoxzklKXKMMNN7+YraebW/2NJ
	r/mh/zWiZ0Vw/9+K7urg/qNcQtey+XDlCNRmakedKg==
X-Google-Smtp-Source: AGHT+IGWqccxb4eaBa7viDsBH2qiuOr+FG9TqsbGIftGtcqIE8Z07l9Awkx2SSQ1v2jf3lFLrsuig7uobLg7jc9ceaU=
X-Received: by 2002:a25:3786:0:b0:d1c:77de:cf7a with SMTP id
 e128-20020a253786000000b00d1c77decf7amr2082342yba.64.1691667824245; Thu, 10
 Aug 2023 04:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810081102.2981505-1-ruanjinjie@huawei.com> <20230810081102.2981505-4-ruanjinjie@huawei.com>
In-Reply-To: <20230810081102.2981505-4-ruanjinjie@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Aug 2023 13:43:33 +0200
Message-ID: <CACRpkda_9jKvew2EzqHJa9Bs7cbV4TAZx9s5AoxTdbbV=0g1CQ@mail.gmail.com>
Subject: Re: [patch net-next 3/5] net: gemini: Remove redundant of_match_ptr()
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, clement.leger@bootlin.com, ulli.kroll@googlemail.com, 
	kvalo@kernel.org, bhupesh.sharma@linaro.org, robh@kernel.org, 
	elder@linaro.org, wei.fang@nxp.com, nicolas.ferre@microchip.com, 
	simon.horman@corigine.com, romieu@fr.zoreil.com, dmitry.torokhov@gmail.com, 
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 10:12=E2=80=AFAM Ruan Jinjie <ruanjinjie@huawei.com=
> wrote:

> The driver depends on CONFIG_OF, it is not necessary to use
> of_match_ptr() here.
>
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

