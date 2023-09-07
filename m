Return-Path: <netdev+bounces-32408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24FF797564
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131E61C20ABE
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB82A12B89;
	Thu,  7 Sep 2023 15:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE95E12B76
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:50:27 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3A14EE2
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 08:50:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52c96d5df86so12507a12.1
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694101726; x=1694706526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vDQ1wXiHskm+OSxYpIJ2JCVVWJYCq27DHQm2pL7xMk=;
        b=pVQgF/935rcqFillY0P+NnJyyJoWSf6mNG3RzwW64nHp3yAVrkpPT64405qND14i+i
         KPYozfNcoAY/7/H4koViz+B00knwPD1sWXkwwoLmAezn/OAhxjwc8QkXe2lbDUOhzRWj
         dSpioUi8RKcMrBtO9edc08UW+hMty5okhwBX/yFaCyaUkOyW1KVHZsU3O2pUctQCgAPx
         Q56F45m3XgAdL5XAe9mLmGYiEzOvPsmVGiZdcUgvsWKlxSHSGXSyPUcxBijvlX7eNEsb
         6p+9Ziz8xrszrVdyzyWz8HIVBeBb28mTdb96Z8cojP34K8MkzBfFtaJ2omoQ+0A8qakr
         9vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101726; x=1694706526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vDQ1wXiHskm+OSxYpIJ2JCVVWJYCq27DHQm2pL7xMk=;
        b=b/MfghKUYFab4WCCNGJ7KTk28zVSJzsOVlQ9fjlzaPlxQ0DaYdEbapgbc42s2GOuwM
         BLFnm/84rrbSGFkezqpSaKXxIH8uhEfdDcNVwvk9FTsogmVZtxpk0isZubqPcKvCy5YO
         x9flwLyYWswg8ix0w1morcrYpo2dsKP3+r0tNSIur0CZ9vd7H5O6FtxLeWGanhOL1/Xu
         6Tt+9S9dDeO4pwNrYwQu+VDjgeuNENY6k6VumkihoZJRn4HOUdvHMOLT42Fk3BefYLoP
         iDA5XSD5vLMECXoC8+0MbLhQIHuv0uqqxHUe2THM9ObRWHnx0iSaE+wdzrU4Yjq2rWcw
         gbkw==
X-Gm-Message-State: AOJu0Yy6FhbeaTx4ZsSyu+Gov3hfZbvIvC8IbPzgDSPRMwRS97Z8K0ej
	PvTs27leUikB0EM9HVjDZqhOP+vQKdgsnyuyn2LQcm2cBSqIiNILC1tLCQ==
X-Google-Smtp-Source: AGHT+IHFMJ7D78TBzCyYpluA068LKLFhSpPLr7bM1ES0kdUqZOVfldXnzjvkh9vnENwQ/s5NEgTUZJFqNFzD92eSRrI=
X-Received: by 2002:a05:600c:17c5:b0:3fe:d691:7d63 with SMTP id
 y5-20020a05600c17c500b003fed6917d63mr129002wmo.6.1694097377745; Thu, 07 Sep
 2023 07:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906201046.463236-1-edumazet@google.com> <20230906201046.463236-5-edumazet@google.com>
 <CADVnQynzDw6JK7CTtyTrNWiYENmOi12i9XXpEQ-+eB-dEg3fvQ@mail.gmail.com>
In-Reply-To: <CADVnQynzDw6JK7CTtyTrNWiYENmOi12i9XXpEQ-+eB-dEg3fvQ@mail.gmail.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Thu, 7 Sep 2023 10:35:41 -0400
Message-ID: <CACSApvaDEvRFdvd7X_-Jcw+uUHD775uM2TyVg383ecLE2CMV8g@mail.gmail.com>
Subject: Re: [RFC net-next 4/4] tcp: defer regular ACK while processing socket backlog
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 10:08=E2=80=AFAM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Wed, Sep 6, 2023 at 4:10=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > This idea came after a particular workload requested
> > the quickack attribute set on routes, and a performance
> > drop was noticed for large bulk transfers.
> >
> > For high throughput flows, it is best to use one cpu
> > running the user thread issuing socket system calls,
> > and a separate cpu to process incoming packets from BH context.
> > (With TSO/GRO, bottleneck is usually the 'user' cpu)
> >
> > Problem is the user thread can spend a lot of time while holding
> > the socket lock, forcing BH handler to queue most of incoming
> > packets in the socket backlog.
> >
> > Whenever the user thread releases the socket lock, it must first
> > process all accumulated packets in the backlog, potentially
> > adding latency spikes. Due to flood mitigation, having too many
> > packets in the backlog increases chance of unexpected drops.
> >
> > Backlog processing unfortunately shifts a fair amount of cpu cycles
> > from the BH cpu to the 'user' cpu, thus reducing max throughput.
> >
> > This patch takes advantage of the backlog processing,
> > and the fact that ACK are mostly cumulative.
> >
> > The idea is to detect we are in the backlog processing
> > and defer all eligible ACK into a single one,
> > sent from tcp_release_cb().
> >
> > This saves cpu cycles on both sides, and network resources.
> >
> > Performance of a single TCP flow on a 200Gbit NIC:
> >
> > - Throughput is increased by 20% (100Gbit -> 120Gbit).
> > - Number of generated ACK per second shrinks from 240,000 to 40,000.
> > - Number of backlog drops per second shrinks from 230 to 0.
> >
> > Benchmark context:
> >  - Regular netperf TCP_STREAM (no zerocopy)
> >  - Intel(R) Xeon(R) Platinum 8481C (Saphire Rapids)
> >  - MAX_SKB_FRAGS =3D 17 (~60KB per GRO packet)
> >
> > This feature is guarded by a new sysctl, and enabled by default:
> >  /proc/sys/net/ipv4/tcp_backlog_ack_defer
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Acked-by: Neal Cardwell <ncardwell@google.com>
>
> Yet another fantastic optimization. Thanks, Eric!

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

This is really superb!  Thank you, Eric!


> neal

