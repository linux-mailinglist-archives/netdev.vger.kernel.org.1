Return-Path: <netdev+bounces-18841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE8758CA1
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 06:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EEC28191B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 04:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4F0C8D5;
	Wed, 19 Jul 2023 04:31:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74EC8C1
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:31:04 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A23A1B6
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 21:31:02 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40371070eb7so489031cf.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 21:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689741061; x=1692333061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/BlqLIDfeuKqQi7Zyq/vs2odCOmYtAyzi0u6RkYKfs=;
        b=dI68NxHHDPUyAywUbAXEmQM3Upc11gKLIkXntAl/lJHTY5ai+xy0GTHHGZqpc4nS8F
         rqvFYfj8IvVcnidgCYdBV92k8CrS64TsVoT8ZpddkRjVTp7AOAj6Uxd2q/8hRtWS0U5B
         fsPdzm6dGKcliW6tql984pOxXVq6luozGGaZNvwHo7kKhxEr0UuLW40USscS2EyuOE5w
         3Qr7YoRiPhnMh71Etwwi6RiS+cnQdWJgpfJzYwoXZkMfNXCbpbpUqTADg2GlUP+Z/q95
         R2GK3Eyx9nmKyOozKjXy6sBnZn9iLc1Opq9gdmzCqcP6OIuFSsYrKx2VpxYVTHtH0j9X
         ZMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689741061; x=1692333061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/BlqLIDfeuKqQi7Zyq/vs2odCOmYtAyzi0u6RkYKfs=;
        b=gxS2nl8wJtXyrDhSRPmL5B+2OAvMY7oQBvvR5yajht7s614iEtxzBqjbp3XuwAMC5W
         5HVyMtHvnSKtdi1AMi+v9miPut2b+QEP6Qg1t/dgnIVjL60qNBK5Dw8LivQPm11+72rg
         8CKDzEAvSvOUnUFrzqEVeEOe8b5fy8zjsKwEOHfW9ioHkE8GrnmqSvW2N2bPrknRfrHD
         o/W0fpB5VATNQWlaDgglWewNpiQRSA419aOkGCS05ZYh77l1r4sqccrRXbnFOD2+S8Jt
         ZZB7j595vtfmEMN0fbhia0Ej5Bdg51dQeu+hS9Y+xgldaGYEXqGtzuwh4P0yZdt2KDqD
         NwXg==
X-Gm-Message-State: ABy/qLbU+w3zi+E7WasoIV6DSXXROl5aS2mz36H33joLmiRRmvEp+Qxa
	SUtonIVwvKJtPwecDYYKMPtnrs/oHOgGYI8Th+afHw==
X-Google-Smtp-Source: APBJJlGxHaQ7tsAAQLo5ly6nXmWgE4aWDs22NZHEvIHKyguQyYRgXJZGnKvgaVSSQYy2YpLZnuug+R9ZTYCGkPEfiwQ=
X-Received: by 2002:ac8:5905:0:b0:3f9:6930:1308 with SMTP id
 5-20020ac85905000000b003f969301308mr332660qty.13.1689741061559; Tue, 18 Jul
 2023 21:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717143443.163732-1-carlos.bilbao@amd.com>
 <20230717192403.96187-1-kuniyu@amazon.com> <c196f8f9-3d2c-27c6-6807-75a6e6e4d5a5@amd.com>
 <20230718195414.4c6f359f@kernel.org>
In-Reply-To: <20230718195414.4c6f359f@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Jul 2023 06:30:50 +0200
Message-ID: <CANn89i+wMUGHoMzeK9ZttJUeZj-acK4M6__tYL1_o4nEdPY5=g@mail.gmail.com>
Subject: Re: [PATCH] tg3: fix array subscript out of bounds compilation error
To: Jakub Kicinski <kuba@kernel.org>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, 
	linux-kernel@vger.kernel.org, mchan@broadcom.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, prashant@broadcom.com, siva.kallam@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 4:54=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 18 Jul 2023 10:52:39 -0500 Carlos Bilbao wrote:
> > >> Fix encountered compilation error in tg3.c where an array subscript =
was
> > >
> > > What is the error ?
> >
> > drivers/net/ethernet/broadcom/tg3.c: In function =E2=80=98tg3_init_one=
=E2=80=99:
>
> What compiler are you using? Any extra flags?
>
> I remember seeing this warning too, but I can't repro it now (gcc 13.1;
> clang 16).

Same here, I think I was seeing this 4 or 5 years ago.
I ignored the warning at that time because we were using an old compiler.

>
> > >> above the array bounds of 'struct tg3_napi[5]'. Add an additional ch=
eck in
> > >> the for loop to ensure that it does not exceed the bounds of
> > >> 'struct tg3_napi' (defined by TG3_IRQ_MAX_VECS).
> > >>
> > >> Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
>
> We need a sign-off tag
> --
> pw-bot: cr

