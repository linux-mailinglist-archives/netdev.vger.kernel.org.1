Return-Path: <netdev+bounces-26771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD754778E9C
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 14:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9886028218C
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6B979CB;
	Fri, 11 Aug 2023 12:02:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4481868
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 12:02:45 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D44010F
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 05:02:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so29094761fa.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 05:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691755362; x=1692360162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abU1jCBZrBBnvA/Bs7m9ndnIzmtzBJufjXqmzVczVX8=;
        b=DnZZMtTxD8Z2bQu41AZe5mj7c4/7khDfUVUsEUfR/p4iFn3Se3vhli4FraR1+9JvbN
         UtWrCy8/HYEWg4KtemN1ScLHKFf71CG1nzVapOivL6f2wxOM43XFadrvLISpzmTe5WtJ
         qOJ9JAP5VmglXwZ5OiToX/8AiJsIUj0kmpACI1r+MONIWk/nI4fQQfX+4Ky89NjVL1rg
         bRNrrUD3hUEe0Ldb92EOH0s4R+zuAJQ9AGxEWKDUTRnfEaI9STm2BwwLUoopm80UKgn7
         XToAdVjkuLOmDXOg7vNLH514HDrV7sXTiaPAuUlxTF2ffZQLVWcYMnsrzo7h3sMq+PMO
         RbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691755362; x=1692360162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abU1jCBZrBBnvA/Bs7m9ndnIzmtzBJufjXqmzVczVX8=;
        b=la+j/aTwAlz85fP3VhS/Hi9uFjqifKLWC8tH80ZQrt4TPXNNzJjUqrKC7OW0WZZd9o
         daW2M69t7n+Fa7Ob0cYAaj8IewjKaKjCafdCQ8GruhJJZK1lZLXPYzFfrFQ7HbjoWBPz
         XyDXUF5VRe4px4lTU/NR8RJK3wyGhtn/WgtgxgSwobUV3z6n0RNyXGx9Gzairv60mIoj
         aAyq9CwFu5jd7pfUsqlBEKbNH12YRP4tbm5Htv/k+Tt30GEuF0Q1KGvUGCVCoM4Sh++6
         b5NLcXssaI4xws2fZYfg8+ZfXcL6hdJyIyIXX7qArCPhu1Gfh4b7EGEbJcoqyE8bqCDT
         LmlQ==
X-Gm-Message-State: AOJu0YwOmypNJOwfbHQY74cB/7dMyAkzgFuuRSQV23iKaEEd6HyiZFdg
	QA9sG5K6pWXoGv+DSrYtZBT+EDdmCHIJ98DvRYc=
X-Google-Smtp-Source: AGHT+IEiSXbqkNDAqZik5VEmLyaRVX7WxAtxGsXA8GNAM3ZxyUOznMqynL1Pv0nnkZ60bfp/OqcVQ+pnbYJoJyVCWJ4=
X-Received: by 2002:a2e:9783:0:b0:2b9:d7b7:36de with SMTP id
 y3-20020a2e9783000000b002b9d7b736demr1508394lji.20.1691755362252; Fri, 11 Aug
 2023 05:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801061932.10335-1-liangchen.linux@gmail.com> <f586f586-5a24-4a01-7ac6-6e75b8738b49@kernel.org>
In-Reply-To: <f586f586-5a24-4a01-7ac6-6e75b8738b49@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Fri, 11 Aug 2023 20:02:30 +0800
Message-ID: <CAKhg4tJs-6HGOtyHP7KWpPjAAQy6BkbRf5LQvDzCwmLAkJXOwQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2 1/2] net: veth: Page pool creation error
 handling for existing pools only
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linyunsheng@huawei.com, ilias.apalodimas@linaro.org, 
	daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 4:56=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
>
>
> On 01/08/2023 08.19, Liang Chen wrote:
> > The failure handling procedure destroys page pools for all queues,
> > including those that haven't had their page pool created yet. this patc=
h
> > introduces necessary adjustments to prevent potential risks and
> > inconsistency with the error handling behavior.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >   drivers/net/veth.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 614f3e3efab0..509e901da41d 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -1081,8 +1081,9 @@ static int __veth_napi_enable_range(struct net_de=
vice *dev, int start, int end)
> >   err_xdp_ring:
> >       for (i--; i >=3D start; i--)
> >               ptr_ring_cleanup(&priv->rq[i].xdp_ring, veth_ptr_free);
> > +     i =3D end;
> >   err_page_pool:
> > -     for (i =3D start; i < end; i++) {
> > +     for (i--; i >=3D start; i--) {
>
> I'm not a fan of this coding style, that iterates backwards, but I can
> see you just inherited the existing style in this function.
>
> >               page_pool_destroy(priv->rq[i].page_pool);
> >               priv->rq[i].page_pool =3D NULL;
> >       }
>
> The page_pool_destroy() call handles(exits) if called with NULL.
> So, I don't think this incorrect walking all (start to end) can trigger
> an actual bug.
>
> Anyhow, I do think this is more correct, so you can append my ACK for
> the real submission.
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>

Thanks! I will separate this patch out and make a real submission,
since it's a small fix and not really coupled with the optimization
patch which still needs some further work after receiving feedback
from Yunsheng.

Thanks,
Liang

