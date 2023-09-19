Return-Path: <netdev+bounces-34874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB5E7A5A3F
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 08:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7202B282153
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 06:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3811B34CFB;
	Tue, 19 Sep 2023 06:58:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F521358
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 06:58:53 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28035102;
	Mon, 18 Sep 2023 23:58:52 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59ea6064e2eso18169767b3.2;
        Mon, 18 Sep 2023 23:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695106731; x=1695711531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAnwNv4LTWBR4Ub72qrwL23xsNOWF2IMjWOkMXFODAs=;
        b=YrvQK3Ksz8yiDjh/Yml4jR7cVVxlE8Uvsoen0vGesz81paE1JSBR0CHr+58dxnFYAc
         I564KAbHg7KSS56cEl8mX8/C71ZZJ6/jYhjGGd7QVamYM6+SsjEJp6gm3yqAdOiZyewv
         YoJ773slWjXJzYWeuhWktEJhNwiiXYs+mIhtB2TzlNd1GmztJvKTznmGgBUmEj0UjeJk
         9H96piMysSRXGOKTYn4WZUGm/0idOcOpiz40c0ylsRdL3o9YrsuKqD4VA+isKwm1524i
         DWlUc1NrzomUoxG9sgE3JPKpzvvGOPkEnD++zFHfNDhVKrioU+lV8JJS6B9VlFbTSXIr
         PGXA==
X-Gm-Message-State: AOJu0YzbMV4wU0U9dv6WLEc5v/3rtEIrnbKHNKIeI4NUlWBTcavj5VLE
	EcTabjzeS5Q0M0nyibWXgzccapNRDT4MsA==
X-Google-Smtp-Source: AGHT+IEn01WXbKJ4m4DKdyZJhmI+M2koekSD7nstvv6CL4+OxYHTvfSRZjws1Kg3AeV6dpKulfVDkw==
X-Received: by 2002:a0d:d9cc:0:b0:573:30c8:6e1d with SMTP id b195-20020a0dd9cc000000b0057330c86e1dmr11308608ywe.44.1695106730816;
        Mon, 18 Sep 2023 23:58:50 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id o8-20020a817308000000b00594fff48796sm3073650ywc.75.2023.09.18.23.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 23:58:49 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59bd2e19c95so56081097b3.0;
        Mon, 18 Sep 2023 23:58:49 -0700 (PDT)
X-Received: by 2002:a0d:ebc5:0:b0:58c:676c:b3ef with SMTP id
 u188-20020a0debc5000000b0058c676cb3efmr11413171ywe.6.1695106729710; Mon, 18
 Sep 2023 23:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de> <20230918204227.1316886-42-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230918204227.1316886-42-u.kleine-koenig@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Sep 2023 08:58:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWuq+=Ss1zgD-9-sAd32Fjz5zYjMYStay6gGDW7YdCi9A@mail.gmail.com>
Message-ID: <CAMuHMdWuq+=Ss1zgD-9-sAd32Fjz5zYjMYStay6gGDW7YdCi9A@mail.gmail.com>
Subject: Re: [PATCH net-next 41/54] net: ethernet: renesas: Convert to
 platform remove callback returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 10:42=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
>
> Trivially convert these drivers from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

