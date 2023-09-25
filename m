Return-Path: <netdev+bounces-36184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C71B7AE1EF
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 00:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id BB4191C2083E
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 22:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48530219E6;
	Mon, 25 Sep 2023 22:53:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883414010
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 22:53:25 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC041101;
	Mon, 25 Sep 2023 15:53:24 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c131ddfeb8so113976821fa.3;
        Mon, 25 Sep 2023 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695682402; x=1696287202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTFA7XirNBxx9izY+xP7nJZlF6f4Z4aS9x4DgH10L+w=;
        b=JOqkatnus5ajmrCEQEebjMr7QGKo3cOwW0b4FGF29eNiGmEPdFlLRKhkzC+XRXfNhk
         45bWyGKGjHKmMYV6FgV9Vzmy6suYK9SnT23absVd2mn4mHB1Ure4rU7ZjN8R8zape8/n
         A5kuhKElwwC/9sJm4BDZLCZp5tjOCnWgTtTo5+YpwOMCroEAtnZ565iIDyv5cQx7pFag
         D/oyJR2B7NoDkcz/Chp7B8qUGDWbscI+GDokeOOayD90dZUTBlD9PIDleN4jLg/KS3hF
         ygdNg93ID9TOB9HC+qd6vtika5h6HCkzhqx1OGb/cl6zyskAOHbUC6sMHhQfvvmJyln5
         t69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695682402; x=1696287202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTFA7XirNBxx9izY+xP7nJZlF6f4Z4aS9x4DgH10L+w=;
        b=q2So6PGqkdPQ3P8h2X7V2GOCiT5xynajPQntX8a3fB+DQoTvLTx3xYuc0nnFRKTGeW
         Uxs8Sfby5USfMjbknuDILIB+x7pyKugVNgioTw2nD7IN2m1Rku6CZoRxpcv5pnsQKZDC
         yRFuYnCMoc2Zdr/FIMO5UGIqyYr1mv29Yo+38cxQNZ0+n0+PlkyoGnB4fC7qO8yVgNpV
         IGcal4wGvINThT5qJdVXmkDlnR29923WjoPugVOQBPXXT0LdEIhIuJI/Ih0nqaUItjpH
         /lNucCcAYCOX4zbNgVKU1V+HymH6BUoiFINoADe5cxU9N6KFfKK+7Omlui2skuO88bI4
         NnNw==
X-Gm-Message-State: AOJu0Yyzo4X921sK5k5Bjw+hKJNqh5wBKgh+taJOrkxe3UqtZLqqPSE4
	hm/w3Ni2gQrtvSld5NDGsEIomC5p5GLnV3pqNv8=
X-Google-Smtp-Source: AGHT+IE3p/Ug53ilumG37rIY9wsCWRONmji0077f8KgSsK8jFRtg3RQHJxRz6SpWKAfhT9zEh+9HLkp9rVeABMCd5hg=
X-Received: by 2002:a2e:960e:0:b0:2c0:21b6:e80c with SMTP id
 v14-20020a2e960e000000b002c021b6e80cmr5797194ljh.35.1695682401626; Mon, 25
 Sep 2023 15:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925020528.777578-1-yury.norov@gmail.com> <20230925020528.777578-5-yury.norov@gmail.com>
 <dbfd06ab-26f3-7b32-6025-2c55e223c576@intel.com>
In-Reply-To: <dbfd06ab-26f3-7b32-6025-2c55e223c576@intel.com>
From: Yury Norov <yury.norov@gmail.com>
Date: Mon, 25 Sep 2023 15:53:10 -0700
Message-ID: <CAAH8bW9azQv=bB0yGVTsMb0icboqsEZhig50d2YFdq0Qmo4g5Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] lib/cpumask: don't mention for_each_numa_hop_mask in cpumask_local_spread()"
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Tariq Toukan <ttoukan.linux@gmail.com>, 
	Valentin Schneider <vschneid@redhat.com>, Maher Sanalla <msanalla@nvidia.com>, 
	Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Pawel Chmielewski <pawel.chmielewski@intel.com>, 
	Yury Norov <ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 3:48=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
>
>
> On 9/24/2023 7:05 PM, Yury Norov wrote:
> > Now that for_each_numa_hop_mask() is reverted, also revert reference to
> > it in the comment to cpumask_local_spread().
> >
> > This partially reverts commit 2ac4980c57f5 ("lib/cpumask: update commen=
t
> > for cpumask_local_spread()")
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
>
> Interesting to see both sign-offs here. Not sure what that implies here
> since both represent you :)
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks for the review, Jacob. The 2nd sign-off is nothing interesting,
just bureaucracy.

