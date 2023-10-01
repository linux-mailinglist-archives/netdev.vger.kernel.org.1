Return-Path: <netdev+bounces-37280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E650B7B484F
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 17:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 52DAEB20AC2
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03B3179B1;
	Sun,  1 Oct 2023 15:11:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A238FC06
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 15:11:10 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1DFD9
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 08:11:08 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3ae65e8eb45so4182439b6e.1
        for <netdev@vger.kernel.org>; Sun, 01 Oct 2023 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696173067; x=1696777867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nntja8YQby6W+vc27jOPsiJxnWEARcSoNUsssYiMeo=;
        b=Rk7xsCpr1M8T4Z9K8wYnc8mVmdgwEeBLoqWLPaT1iDE0EVwnKjcSTTFEVwo4LzHpON
         2Z8BptWUthNYWE2laVBbzQKoOSbrgj+PML40mUPZGivCCZXUq/79YzyRObPMPAOtjOrK
         AETw79ANo1y9LXIqrO/U3n20mzOQ5zRFs49n/Gsmvru0MxgL3JTe06uDHxQj0RYYSFfE
         wkSm3DBY6gqYCYVHrVgSnSoIUaGXIRN/8dHCUjsuaqX6NIjZUeWPCEpykUYFMrv3vPvS
         OBQea/ntscz23HK4HICPemiBlIuf+lsIohyPV9XEvE0sJ9P6LHamQeMeHI/fk9DYNCX4
         k28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696173067; x=1696777867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nntja8YQby6W+vc27jOPsiJxnWEARcSoNUsssYiMeo=;
        b=nEp4kiwJGUDMObXhLbb8gyQD0o+yLUGdiIQAyggPDRbIzqDsEcGbSj4bPs4BZ7w/1b
         PQzE6FEK0x1AQoqLFqAxBfgVemJJH4nPVoqQrC/HuIIWeSrL/p5DzclTJrhgMI/pgwGU
         ZYI0bqD1tRzjMF2fuj9aF4xsRg0W7g1+V/VcrG1Yk0grTID3AIFiusOoogfF+r8+sRkU
         FwN0h525DGw6M6wy6xQD6n5OjF/ZFpCp+o33aj1fn5GK3Kph39b0fGfDu9VrFkW/zJ+i
         VKOtm6ZMHvpDLWp0EE6957r03sxwb//5nMKIb09ljLuTanDkjbjXfLAkn60A0b2Yn/t/
         CoQg==
X-Gm-Message-State: AOJu0YxBOBCiPKr4SjYyM2Ns69SVPg6J6ob3EUgLUyzuaDZokbI1+DKc
	LeL86n6XtQM2LFedckuMb2qwmpyMshSxU0OaVhA=
X-Google-Smtp-Source: AGHT+IHYp7v524jqh836XN11c9rhr2lQID3XKWZOPWrYIsrzrnv8vCLEtUva9HawOFuxsHdkXRL2wwkq5V6YPNOE2Gw=
X-Received: by 2002:a05:6808:3084:b0:3ad:f86a:878e with SMTP id
 bl4-20020a056808308400b003adf86a878emr12653802oib.13.1696173067457; Sun, 01
 Oct 2023 08:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231001145102.733450-1-edumazet@google.com>
In-Reply-To: <20231001145102.733450-1-edumazet@google.com>
From: Dave Taht <dave.taht@gmail.com>
Date: Sun, 1 Oct 2023 08:10:55 -0700
Message-ID: <CAA93jw6uXa_RBG=HUhJsOQds-njZMYB-1MpfCnTGYFzU7gEVzg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] net_sched: sch_fq: add WRR scheduling and 3 bands
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 1, 2023 at 7:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> As discussed in Netconf 2023 in Paris last week, this series adds
> to FQ the possibility of replacing pfifo_fast for most setups.
>
> FQ provides fairness among flows, but malicious applications
> can cause problems by using thousands of sockets.
>
> Having 3 bands like pfifo_fast can make sure that applications
> using high prio packets (eg AF4) can get guaranteed throughput
> even if thousands of low priority flows are competing.
>
> Added complexity in FQ does not matter in many cases when/if
> fastpath added in the prior series is used.
>
> Eric Dumazet (4):
>   net_sched: sch_fq: remove q->ktime_cache
>   net_sched: export pfifo_fast prio2band[]
>   net_sched: sch_fq: add 3 bands and WRR scheduling
>   net_sched: sch_fq: add TCA_FQ_WEIGHTS attribute
>
>  include/net/sch_generic.h      |   1 +
>  include/uapi/linux/pkt_sched.h |  14 +-
>  net/sched/sch_fq.c             | 263 ++++++++++++++++++++++++++-------
>  net/sched/sch_generic.c        |   9 +-
>  4 files changed, 226 insertions(+), 61 deletions(-)
>
> --
> 2.42.0.582.g8ccd20d70d-goog
>
>

While I am delighted to see this, my concern is about udp traffic. I
have not paid much attention to how that is treated in sch_fq in
recent years, it was, originally, a second class citizen. I assume the
prio stuff here works on all protocols? Have similar pacing,
udp_notsent_lowat, etc things been added to that? (I really don=C2=B4t
know,
I am lagging 4 years behind on kernel developments)

If that is not the case I would like the commit message clarified to
say something like "most tcp-mainly servers and clients, and not
routers, or applications leveraging udp without backpressure, such as
vpns, or voip, or quic applications. =C2=A8 The confusion over the use
cases for sch_fq vs fq_codel or cake has been a PITA. I was very
pleased to see effective backpressure working on containers (circa
6.1)

Acked-By: Dave Taht <dave.taht@gmail.com>

--=20
Oct 30: https://netdevconf.info/0x17/news/the-maestro-and-the-music-bof.htm=
l
Dave T=C3=A4ht CSO, LibreQos

