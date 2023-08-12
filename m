Return-Path: <netdev+bounces-26996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B0A779C89
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 04:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C16F1C20B97
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 02:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8C110B;
	Sat, 12 Aug 2023 02:16:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF507EDD
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 02:16:49 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718AAC5
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 19:16:48 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so40834161fa.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 19:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691806606; x=1692411406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckKOgJXTd+uraO3d31g3KNKCJn8l76TZ8xNuQLMcs/w=;
        b=kiVZ6ihU9tzCoegILbLCcaQDULYacS0bFcm+n50VqJy+4kIK7ZYccbyFk0rNDfrYsI
         qMJcMYp0TGp5MP7OqSxzGkl+qKuvRepR1IeSif4wavG6h7DEl5JhRtjBLS3u9l6p9ZdO
         NaAnyy6C56lOhSZKIUqgbisCFjNh7sahN7FAMSx3Rc2QQgKCQW8YbNMu9ngVoYD7s1tO
         yzba849nZqJtVcc+3omi9zOojDAgHpteIL+24JMwXRnFqOM8V65aUJupVrojZ2FVNU0e
         ah0ZGMJfUhFE6IvO2O/zfElVCtfHw3R8R/mvPuKn0Ty6Nd/iJ5+GbCduf3FYAUMWoXUi
         O+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691806606; x=1692411406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckKOgJXTd+uraO3d31g3KNKCJn8l76TZ8xNuQLMcs/w=;
        b=HGa0j33YJohtK/n7ldSZFTen2S9tpH/Vh41TuHEgG+URQKOQnp+ftT+/yMAf5rhoPv
         pm/dJ6m6RJMT7g7aei64HgxzZ8TdJs8Wi5ybzQRBQ61cRymnNEiSJ3uKmTJt9wtFkRMA
         Y8Bz1vWv1sWGv4I1BmhT0apcfzf0durazVbyFe0tq0DDbHpWA4vvpHRi9H9PyML1y8SF
         vJwkeKPDD6YpuRu4212vtaNKxwUXmJlFv3gwLxSeCVsvFiGgE39c1CogSbId9WBXjqHd
         PWcD/yBqwjV0K1hBBupgYjJ8Vi1qOe1vCg5OcRtV/LaWwzC89ryeEHurcuWaY4oRK34q
         Vt/A==
X-Gm-Message-State: AOJu0YwEp9F5LHpWlp3JbLVHRSmnzrhR+JdyEg2RQ6MlptMKiXK4XqlI
	SuDDk7rGoBzYL9Lr+Q/9sEs+ctL2r6bgKMTn/Xw=
X-Google-Smtp-Source: AGHT+IH2rnwjxTKPVMln2yjcCi7G7mCVrcbyj/UWnTYvlIOjwmFRg8JZLyYRBHmErgVWpAxUr1WiOCgrFe2gi6kFVxA=
X-Received: by 2002:a2e:9ec9:0:b0:2b6:a05a:c5c with SMTP id
 h9-20020a2e9ec9000000b002b6a05a0c5cmr2609803ljk.1.1691806606378; Fri, 11 Aug
 2023 19:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801061932.10335-1-liangchen.linux@gmail.com>
 <f586f586-5a24-4a01-7ac6-6e75b8738b49@kernel.org> <CAKhg4tJs-6HGOtyHP7KWpPjAAQy6BkbRf5LQvDzCwmLAkJXOwQ@mail.gmail.com>
 <b52b4aa0-ebae-f9a5-f3da-b0c9cc4ba75b@redhat.com>
In-Reply-To: <b52b4aa0-ebae-f9a5-f3da-b0c9cc4ba75b@redhat.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Sat, 12 Aug 2023 10:16:33 +0800
Message-ID: <CAKhg4t+Bqb19nsofFH50UJjTtF8YgLCuRWDKR1z6zmDyET+wkA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2 1/2] net: veth: Page pool creation error
 handling for existing pools only
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, brouer@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linyunsheng@huawei.com, ilias.apalodimas@linaro.org, daniel@iogearbox.net, 
	ast@kernel.org, netdev@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 12, 2023 at 12:35=E2=80=AFAM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
>
>
> On 11/08/2023 14.02, Liang Chen wrote:
> > On Wed, Aug 2, 2023 at 4:56=E2=80=AFPM Jesper Dangaard Brouer <hawk@ker=
nel.org> wrote:
> >>
> [...]
> >>>                page_pool_destroy(priv->rq[i].page_pool);
> >>>                priv->rq[i].page_pool =3D NULL;
> >>>        }
> >>
> >> The page_pool_destroy() call handles(exits) if called with NULL.
> >> So, I don't think this incorrect walking all (start to end) can trigge=
r
> >> an actual bug.
> >>
> >> Anyhow, I do think this is more correct, so you can append my ACK for
> >> the real submission.
> >>
> >> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> >>
> >
> > Thanks! I will separate this patch out and make a real submission,
> > since it's a small fix and not really coupled with the optimization
> > patch which still needs some further work after receiving feedback
> > from Yunsheng.
>
> Sure, send it as a fix commit.  Given it is not super critical i think
> it is okay to send for net-next, to avoid merge issues/conflicts with
> your 2/2 optimization patch.  And for good order we should add a Fixes
> tag, but IMHO net-next is still okay, given I don't think this can
> trigger a bug.
>
> That said, I do want to encourage you to work on 2/2 optimization patch.
> I think this is a very important optimization and actually a fix for
> then we introduced page_pool to veth. Well spotted! :-)
>
> In 2/2 I keep getting confused by use of kfree_skb_partial() and if the
> right conditions are meet.
>
> --Jesper
>

Thank you for the encouragement! The work for the optimization patch
is going on, and we will submit another version which hopefully will
give a further performance improvement.

