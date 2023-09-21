Return-Path: <netdev+bounces-35510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1DF7A9BAC
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1EF1C21425
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2802D41E2A;
	Thu, 21 Sep 2023 17:53:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C448F41E28
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:53:20 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FB98808D
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:51:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50302e8fca8so387e87.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695318688; x=1695923488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO90/SExc0oTX0O0aeWO2jyaKGwjPD4PiqUA5E92yi0=;
        b=4Q+HsUtvdcaPgxiJLOcLmO8xuJKr3Psc+yzfMSYw2ZAE/0QOWiQnGj2cBfvMhITW9E
         aBQmc+cbrPY4JRpYrPTOhqWFokYZmRY0qrt4BUdnOMEAFDPUJRzWDQ+RA0bD268UTa9B
         rr3aBPl0Vzb/wJB3DJevHUiojgLuo/48Lk46MAdJQtb85REo5koGyQAT/uMUrdnlWaYU
         nVZ6d/k34x/zyb8XdHUWYpY+PWwlmyijj0TbdTOe6JbNwVTW/IfD4wktDqtbNmj5+uvK
         K9vvuHJ/dnY1QMU5H4LWsaWiMsfFPRJ4K+TS5lJHkLkXbSg92AXEyrzj+1uCfkyj+6wb
         HCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318688; x=1695923488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IO90/SExc0oTX0O0aeWO2jyaKGwjPD4PiqUA5E92yi0=;
        b=c9zFKzjX07UbfGFLPDQPJrccVZpnQQLgevjfmp82I/Lp1xCE5HSphGnnDTj/EKGMfP
         q3RlBWX6yeXsJuNxXgnYcfu9ZPEKyFupNNflZmS2L0pEiuQlY9pA0/qRnNUAtyQTh4SB
         XmQS/9svUwsE/b+PErULd3aJBqYSwtwnGlzcrU/B8NW5BZhxbfJ6rcZrcwyl0RjklT9+
         HSW5Tgj/IZkUf8dJCuWxjPkR6YogI3t9TP4h226d3wtY/wg1IocEGQaaGycuOjV0coqk
         9R5UEfiQwertOgg6j7QB2w5VpimEWH4sHQDgtkvxC7EgdfFLttvvSwj+Q397DddYlHOW
         MnuQ==
X-Gm-Message-State: AOJu0Yy2CAP2+gZHhYc1yFxH7K5wIpG3Pfc0OyNe0rDtTTQ4xWq6vYKq
	Qrd0xT8yPFTlB5bn5jFmhXijE1I2VCHKd119cNGa1MlEUL6WxkPVCg5KPg==
X-Google-Smtp-Source: AGHT+IHU52YYBbqB5xCUZFtwCy03xAHmyLyiIVgO45+xvJhFoI+pScK3xotauD/T5JmJPIWOH5DTn2xmq2PqGRdJb7c=
X-Received: by 2002:ac2:46cb:0:b0:4fd:d759:a47 with SMTP id
 p11-20020ac246cb000000b004fdd7590a47mr19210lfo.3.1695278865542; Wed, 20 Sep
 2023 23:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916010625.2771731-1-lixiaoyan@google.com> <942de224-f18b-474d-b75b-6f08f66541c9@lunn.ch>
In-Reply-To: <942de224-f18b-474d-b75b-6f08f66541c9@lunn.ch>
From: Coco Li <lixiaoyan@google.com>
Date: Wed, 20 Sep 2023 23:47:34 -0700
Message-ID: <CADjXwjjP_8mM8y6KRF6_VQDpM7-UAXKDW02gRKf3FeJijnjSPA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As replied in the other patch, we have arm64 platform in our testbeds
with smaller L3 cache (1.375MB vs 256Mb on AMD), but its L1/L2 cache
is similar or even bigger than our AMD platform cache. We will send
results with this platform in the next update.

Thank you for your suggestions.


On Sat, Sep 16, 2023 at 7:23=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Sep 16, 2023 at 01:06:20AM +0000, Coco Li wrote:
> > Currently, variable-heavy structs in the networking stack is organized
> > chronologically, logically and sometimes by cache line access.
> >
> > This patch series attempts to reorganize the core networking stack
> > variables to minimize cacheline consumption during the phase of data
> > transfer. Specifically, we looked at the TCP/IP stack and the fast
> > path definition in TCP.
> >
> > For documentation purposes, we also added new files for each core data
> > structure we considered, although not all ended up being modified due
> > to the amount of existing cache line they span in the fast path. In
> > the documentation, we recorded all variables we identified on the
> > fast path and the reasons. We also hope that in the future when
> > variables are added/modified, the document can be referred to and
> > updated accordingly to reflect the latest variable organization.
> >
> > Tested:
> > Our tests were run with neper tcp_rr using tcp traffic. The tests have =
$cpu
> > number of threads and variable number of flows (see below).
> >
> > Tests were run on 6.5-rc1
> >
> > Efficiency is computed as cpu seconds / throughput (one tcp_rr round tr=
ip).
> > The following result shows Efficiency delta before and after the patch
> > series is applied.
> >
> > On AMD platforms with 100Gb/s NIC and 256Mb L3 cache:
>
> Would it be possible to run the same tests on a small ARM, MIPS or
> RISC-V machine?  Something with small L1 and L2 cache, and no L3
> cache. You sometimes hear that the Linux network stack has become too
> big for small embedded systems, it is thrashing the caches. I suspect
> this change will help such machine. But i suppose it could also be bad
> for them. We won't know until it is tested.
>
>     Andrew
>

