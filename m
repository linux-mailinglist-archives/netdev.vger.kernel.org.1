Return-Path: <netdev+bounces-35350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3D77A8FCD
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 01:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C03CCB20AC0
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 23:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05013F4BC;
	Wed, 20 Sep 2023 23:22:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6FA15AC9
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 23:22:21 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C61C9
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 16:22:19 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59c0281d72dso4824807b3.0
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 16:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1695252139; x=1695856939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8qQvoFEwJjcliex4vMLGhTunOMyRRTsSP0dimRTA7I=;
        b=bPh1rMrPwaYTeEZgMuRlI8p894ehWg/6HBGJUs+8nFkEXcvDLxPgzL31EZZ9fenL7I
         01rFmEvYg+k4pOJmlkCGUCieg3ytorKbFkBgI++QG6hHhJ2+wa8G/kEDvp4eStL5qs7h
         jyBbJAC9nbysLQdbEGtYD8HUzSjthh+TgQeWC7Zixuo8+hHqO6GBCYV6jvJ06hCI3ugh
         2YXwHW8NKQxu9nrxtOuBVcXDMFXmSOfNBX8i3eUFHCVfJjx873ILXyHZgXcbAN7/D1Mb
         SzsVb+06YaE1dIn8MB6clihqmC4ctlc9tqkTQHUYU182Z8LR1pnPypQ4rrlksqr0ps/G
         h+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695252139; x=1695856939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8qQvoFEwJjcliex4vMLGhTunOMyRRTsSP0dimRTA7I=;
        b=j1WuE0U//bdO3c0dgbUEu5riQHKfoklZAkNpdqGYSUsNOw1cL+p3aEk5Gb+4WULqWG
         e3kpXKAumB8vfB9KoFt+nO6p3Y7gFSGBPriFgyK9q9SVPZMUtnkA9s6eRWhzcdfgI2eu
         e/ZCegh8YBOlJr+4ZA2oBrzCTYYPt10PyfZjLsnFeT15yTHwE07ug8rLfW58W7lcB2Li
         7nQa84OgMo9zQogC3o9dgXvvQeHJNMTNAYDf1mXALzNOrKgUaYGfjqGiOMdBdzU+XGs3
         E/yO1gs/FjZlJjacFS4fSyiQMxLes6pBVAs+/MsUJu4xZrlXSFfHDmZeqRpI0jT8HsAs
         ijeg==
X-Gm-Message-State: AOJu0YwAv5lu+UtRsyVFT/UiZhbAJDn1G+QGXr6yHjgvDK1k085RdSZ6
	4Sc249J6XnhHqixgup54U6fFEBpZtzpU8qOMOoLEHQ==
X-Google-Smtp-Source: AGHT+IGzQ61tmLdncC8+awXjmhcHp9kUMZTk8lcyKG9OXHo1DHhVXm7Zxsiqef74bwjeajGhGOjItn12aavuBrQX3Uk=
X-Received: by 2002:a81:6c43:0:b0:584:33c:31f2 with SMTP id
 h64-20020a816c43000000b00584033c31f2mr3418997ywc.17.1695252138811; Wed, 20
 Sep 2023 16:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920201715.418491-1-edumazet@google.com>
In-Reply-To: <20230920201715.418491-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 20 Sep 2023 19:22:07 -0400
Message-ID: <CAM0EoMm87U7sGESCtcekr-Avsx4+WMnOS7HuNztJdE=G8VFs+g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/5] net_sched: sch_fq: round of improvements
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 4:17=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> For FQ tenth anniversary, it was time for making it faster.
>
> The FQ part (as in Fair Queue) is rather expensive, because
> we have to classify packets and store them in a per-flow structure,
> and add this per-flow structure in a hash table. Then the RR lists
> also add cache line misses.
>
> Most fq qdisc are almost idle. Trying to share NIC bandwidth has
> no benefits, thus the qdisc could behave like a FIFO.
>
> This series brings a 5 % throughput increase in intensive
> tcp_rr workload, and 13 % increase for (unpaced) UDP packets.
>
> v2: removed an extra label (build bot).
>     Fix an accidental increase of stat_internal_packets counter
>     in fast path.
>     Added "constify qdisc_priv()" patch to allow fq_fastpath_check()
>     first parameter to be const.
>     typo on 'eligible' (Willem)

For the patchset:
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> Eric Dumazet (5):
>   net_sched: constify qdisc_priv()
>   net_sched: sch_fq: struct sched_data reorg
>   net_sched: sch_fq: change how @inactive is tracked
>   net_sched: sch_fq: add fast path for mostly idle qdisc
>   net_sched: sch_fq: always garbage collect
>
>  include/net/pkt_sched.h        |   8 +-
>  include/uapi/linux/pkt_sched.h |   1 +
>  net/sched/sch_fq.c             | 148 +++++++++++++++++++++++----------
>  3 files changed, 110 insertions(+), 47 deletions(-)
>
> --
> 2.42.0.459.ge4e396fd5e-goog
>

