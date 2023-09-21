Return-Path: <netdev+bounces-35357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3317A901F
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 02:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9A6281910
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 00:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F11C361;
	Thu, 21 Sep 2023 00:17:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F104F17E
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 00:17:09 +0000 (UTC)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58FACF
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:17:07 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7a8aec82539so163001241.2
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695255427; x=1695860227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVjqvKAKBEExCNM0G7YjTOPY1DzXNTD+n1Ka2Ltpgys=;
        b=RjRwsCEKaPM4fMeSfFFDTZvqW25ws+xJZkMBHb6MQSASbNgja+xsVDPN6ANIU2JCeM
         RTO+kfZqdr0Mg5lhO3PjKo+XAP+m4nBQKZiBXLcVMl9TYb66rd+z51chPgj2UOcyb0Mr
         UeQ8r4ZcLZW8eXj1fvbt9BGp3KI2abkHb25xQPHjpIdHOS4oyC5OxJhWLwyQoeWjB9rD
         MQvArTcMOa/dz9QRRan/+P0/UKklSaJE/Zog0FbJah+bBSjN0PXISu7H8Vw4X254vgP8
         V6fdNMEzPDTQXn13i0XdY/WQMUxNVLU0bcuwNzfdMxUFV5jI228IS/54BDikqXri2sGz
         CtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695255427; x=1695860227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVjqvKAKBEExCNM0G7YjTOPY1DzXNTD+n1Ka2Ltpgys=;
        b=U9DYSLe5T53vKOtZCD1WCaTzEJpLhUmfiw8Du9z9r8BDJD9xFPQ/D1hRCHAMifTfX6
         a6WTpuZfrTSzlI9OI9oDMQ6WOBXnhcTDAN9G3ukVGCI12fLsg5fCiB1lD2fC1dzQnS6i
         lnTW5JnaWuuhkD+31zHeJXjrwBdv5FXc/CUsa5tcRVneT7CafiQJIkgaQhTG++hLUtjR
         qRbOcxe4B4LLcAVteIEftMB/Ey5yNn8dNBLbiG2Du+y1Cwgm9N5oG/XYM6IrIuPoZ4rh
         VvEZoHH05Ht51J6NdXXBlUGH3RS6WemWxx05TjSwhYnDnfLD4rVKXAuH9FCg0XY8bu14
         Fp6Q==
X-Gm-Message-State: AOJu0YyZSl6foZEFI4HstTxndht0RKxEunsNsdeB4InSx4qjEIRLsx+A
	ls8hbAXSp4nbdaIzoD3x8InUIl9K8aYil7h/+JdBI9WW
X-Google-Smtp-Source: AGHT+IEDHojdvlRsR+KAIoLpQGm8zYvaTzhOuhDCyoMVStkDMOy3teeY8OmUnSXWbVVlseiPZMTr4DqN77w050Kx5eU=
X-Received: by 2002:a1f:c942:0:b0:48f:e2eb:6dd2 with SMTP id
 z63-20020a1fc942000000b0048fe2eb6dd2mr3860304vkf.9.1695255426773; Wed, 20 Sep
 2023 17:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920201715.418491-1-edumazet@google.com> <CAM0EoMm87U7sGESCtcekr-Avsx4+WMnOS7HuNztJdE=G8VFs+g@mail.gmail.com>
In-Reply-To: <CAM0EoMm87U7sGESCtcekr-Avsx4+WMnOS7HuNztJdE=G8VFs+g@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 20 Sep 2023 20:16:30 -0400
Message-ID: <CAF=yD-LZmJ-a0kO8UtKaj+NTwYaRFQfZkDVHTthz4gNYJfCN4w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/5] net_sched: sch_fq: round of improvements
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 7:22=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Sep 20, 2023 at 4:17=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > For FQ tenth anniversary, it was time for making it faster.
> >
> > The FQ part (as in Fair Queue) is rather expensive, because
> > we have to classify packets and store them in a per-flow structure,
> > and add this per-flow structure in a hash table. Then the RR lists
> > also add cache line misses.
> >
> > Most fq qdisc are almost idle. Trying to share NIC bandwidth has
> > no benefits, thus the qdisc could behave like a FIFO.
> >
> > This series brings a 5 % throughput increase in intensive
> > tcp_rr workload, and 13 % increase for (unpaced) UDP packets.
> >
> > v2: removed an extra label (build bot).
> >     Fix an accidental increase of stat_internal_packets counter
> >     in fast path.
> >     Added "constify qdisc_priv()" patch to allow fq_fastpath_check()
> >     first parameter to be const.
> >     typo on 'eligible' (Willem)
>
> For the patchset:
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

