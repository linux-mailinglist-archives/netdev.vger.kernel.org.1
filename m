Return-Path: <netdev+bounces-37318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6727B4BA7
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 08:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 5C6EB1C20757
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 06:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D0D9CA44;
	Mon,  2 Oct 2023 06:49:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FE97FB
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 06:48:59 +0000 (UTC)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7FAA4
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 23:48:57 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-4526b9404b0so1985527137.0
        for <netdev@vger.kernel.org>; Sun, 01 Oct 2023 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696229337; x=1696834137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPk6iXEPIHTQeqzKN1mmWx6ZDZMpHOnXSJXF5+ry+v4=;
        b=ZK9dP9bBRdcs7wiprItPCDHqYvzXC3ahcgpTffoCblS9lcMbNGqjrQYWXR7F5VTbky
         KfZnUeYTJ9dBzMx35Y5EzebGhhq5g6rfbm0KvY+laOYpvLzFeKL1Rp83WV89+gQJQJ39
         ZW1nxHPDv6KXEeGl2jSrYDBLq7tNXAsaHQbw/trE2IiR12CsaJ514w9lyotevcrplGn2
         C3u7sH1w+bJeSqCU2ldATBSvgvu4hH3lUDfckropFh89cNCnmlpnzENYPGtvalR4+54e
         yL+lcXXzevU2fimkveUEVZWOK0zo6u+QnrZbmbmRMgJ86sF7Ejt58fl0jk1CcB8EF/Ah
         RgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696229337; x=1696834137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPk6iXEPIHTQeqzKN1mmWx6ZDZMpHOnXSJXF5+ry+v4=;
        b=USvMHLnHGcuWTCZ0i/o3BXuTRLiIdu7euHAT2GLtBKj1GWLgB6qFNQeES71tZ3bRq4
         6DRoRFWQAwk57uyMqi5lzZaOfHRroXx/OHzGp/1xKy7/K/uQJHhnGrVN4eRsaJCsdU+J
         MZjpeh4Zr0k+EDy53zbnZvIUqU+Mqgr8B1obp9ibjTfVqgQRrQcpIT/xL6mG0XAG06oR
         Eu0gMCJnKPu/Oq0ZIRHpMTodsvT5zp8Kw+Gw2+f2foC/Ve1YDT2AsaVRbvltFo4R3Ymd
         yse3VCRXNznmTI7/wrMlqZazHyq6vrLiUSo3Yy27bLjRZuw+t35WQ7eArPUKvsG1OR1c
         jZbA==
X-Gm-Message-State: AOJu0Yx38SgC3RKknOku+w3eRKuJu+D7lozVkff1JKlYServ7RItEqSi
	rKCqCNvL0xjob+lWAoqDJg0sqY1QKVAkjdIV2iTChkekhxw=
X-Google-Smtp-Source: AGHT+IF4XMhSLRhn05RxFeTLAFU+XUPW6OPhpruHYBuTwkUKyz08eSSwuJ2brzJBk1kNQNC56ZU5XuZM4swLrFXDYQs=
X-Received: by 2002:a05:6102:440e:b0:452:79da:94a with SMTP id
 df14-20020a056102440e00b0045279da094amr5208139vsb.4.1696229336826; Sun, 01
 Oct 2023 23:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231001145102.733450-1-edumazet@google.com>
In-Reply-To: <20231001145102.733450-1-edumazet@google.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 2 Oct 2023 08:48:21 +0200
Message-ID: <CAF=yD-JrggCg9NQ3MKDHx9rzKtJqhuoFD3kbSVsUH8n8553VKg@mail.gmail.com>
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

On Sun, Oct 1, 2023 at 4:51=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
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

For the series:

Reviewed-by: Willem de Bruijn <willemb@google.com>

