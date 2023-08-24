Return-Path: <netdev+bounces-30384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6631E78712D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3511C20E62
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBD71119E;
	Thu, 24 Aug 2023 14:09:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA3CA7D
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 14:09:45 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5521BC5
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:09:34 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d67869054bfso6617418276.3
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692886173; x=1693490973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsN4mlh6fi1TtfNRe83xT012iyObDZVKHQZXh5NHgCE=;
        b=KUTliXSsP7ypMR9lHQ3L/BAf8IIgT7oYQIapCcfigRJX/hBBBwVoY3EBt7FyOT9wCN
         +ov2fHa3PUbg0SUKQth8Q9vNq7Wr30qlbH3LwSQLYszuVPkmezcGB3Xl6B4XvaAfS2Yc
         4Azu/B4AhoZELEA+FsKD5CHVGsmihxYunTvMItC0lbF7poGvkxTnWnQRcjmDxC9Vp262
         /5jVA9kK5FH5U5sBSg5JBtLhNgZ7W5dGfFxbsjLQQNGCY5Yk6Ew2JjkrkpNSJQCU3rqx
         8fvOG/G2+sTRQPSvIjQZKfuC83Dt4AKsn1YBNCZWAQDdVdQlCbKXEkeKc7JXRsvUT/Iy
         MeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692886173; x=1693490973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsN4mlh6fi1TtfNRe83xT012iyObDZVKHQZXh5NHgCE=;
        b=QoczMdws67BGn0Jhgl2s06qrOMvm5e28Qhf4YF7vqM9kIVRA5dEOhLbLMUwqv4zjq3
         VfCcMq/ci/cjwgcmZKX1GRfH5gG//PVLi8M+fjVM6XJZKSvva+TV1SIDZ+iSPehapR9F
         HQYeh0CRaZoqIDdU8wcfUexHyMiNRIOXmd1BI18sAvf5LzKCB/o6d1gGrPHcrJRIybOD
         J/rG5MVcY6qYBgtzBMsHvFKpp5/vIlayhs9qOCUBql9oyJxE9KxBOAquWfawqbeawfDl
         t0gxZaTLocXvykmRiVys2Rmie4Irx6AzpZWqJt1cShbPMcQExCBaj8xo4tJ4lqcznF8G
         34ow==
X-Gm-Message-State: AOJu0YzhdTYrSV25Q8Qb8ftbPEcQaIRWB74pIZ8ysqdvuDG4rOVIIUDB
	5SQxCBjfUEJhIfI3Ied8DBxsuDhI9NICUvTJ7SdF2A==
X-Google-Smtp-Source: AGHT+IE3FTb6Y0OHar6ERw4DmNeJ31YJTPyBSDCfz0Z6m0Qy+uV+eMWMHWfhlWioDfzL7Oz0x+f9pOHnjDh+ewHzP5g=
X-Received: by 2002:a81:6d4f:0:b0:589:cf7c:d566 with SMTP id
 i76-20020a816d4f000000b00589cf7cd566mr14139333ywc.0.1692886173752; Thu, 24
 Aug 2023 07:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230819163515.2266246-1-victor@mojatatu.com> <20230819163515.2266246-3-victor@mojatatu.com>
 <CALnP8Zbq4puMU4-9EgTbJYn2MPiBc3Ygpaxnhmh-pqmDX7rXDA@mail.gmail.com>
In-Reply-To: <CALnP8Zbq4puMU4-9EgTbJYn2MPiBc3Ygpaxnhmh-pqmDX7rXDA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 24 Aug 2023 10:09:22 -0400
Message-ID: <CAM0EoMk3BhCF6c+_PZR=zSPfw9M63zoQ7s0-PXGrc5eje-S+mQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net/sched: cls_api: Expose tc block ports
 to the datapath
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, vladbu@nvidia.com, horms@kernel.org, 
	pctammela@mojatatu.com, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 1:33=E2=80=AFPM Marcelo Ricardo Leitner
<mleitner@redhat.com> wrote:
>
> On Sat, Aug 19, 2023 at 01:35:13PM -0300, Victor Nogueira wrote:
> > The datapath can now find the block of the port in which the packet arr=
ived
> > at. It can then use it for various activities.
>
> I think $subject needs a s/ports//. Because, well, the patch is
> exposing the block, which contains the ports.. The first sentence here
> goes along with this rationale.
>
> more below
>
> >
> > In the next patch we show a simple action that multicasts to all ports
> > excep for the port in which the packet arrived on.
>
> "except"
>

Thanks Marcelo. We'll fix both in the next version.

cheers,
jamal
> > Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > ---
> >  include/net/sch_generic.h |  4 ++++
> >  net/sched/cls_api.c       | 10 +++++++++-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index 824a0ecb5afc..c5defb166ef6 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -440,6 +440,8 @@ struct qdisc_skb_cb {
> >       };
> >  #define QDISC_CB_PRIV_LEN 20
> >       unsigned char           data[QDISC_CB_PRIV_LEN];
> > +     /* This should allow eBPF to continue to align */
>
> Not sure if this comment really belongs in here. Up to you but it
> seems better suited in the patch description. Hopefully the next one
> won't do something like:
>
>         /* This should allow eBPF to continue to align */
>         u32                     block_index;
> +       /* This one too */
> +       u32                     my_var;
>
> :-)
>
> > +     u32                     block_index;
> >  };
> >
> >  typedef void tcf_chain_head_change_t(struct tcf_proto *tp_head, void *=
priv);
>

