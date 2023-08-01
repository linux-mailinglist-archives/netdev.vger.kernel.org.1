Return-Path: <netdev+bounces-23131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D476B15C
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D97281818
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D858A20F87;
	Tue,  1 Aug 2023 10:17:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C830E1DDFF
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:17:15 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4DE2D79
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 03:16:44 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40c72caec5cso260561cf.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 03:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690884994; x=1691489794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZN9Ev39oJk78sdD2xFuDOdMnPsbmSFEY0jGkX/TZfs=;
        b=73nIOlxPptDV21sESWCVMAR6SLbm5k0LKaJiE3ztg54DmwekJLjblbGBqzm3h09QHu
         AcWJk4qzGieKWCBWLUremGY0iLXzASSMapZ+ZaDzkS1QkzfpTFlRVJR7dwDBrxR3ZFvJ
         Ayq7XHl9VVuT1b1B0GCU7vv6BOqPiXRFbnpvUC37LxYz2afVSi4xkasF8rxGFDVJfHpK
         XU09LcibSGYjS+FHcB6FeQKd+mqS/i29Kud5Dt8MaQX6gYpJk16rSOjk7CpNo40Mv8Wy
         oet01eHTcf7iSo8CQF7LMVoKKHW3uRnbv5YnCdi5znln1GS2hMvU8q0ZlF1T7rDMEIZl
         kb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690884994; x=1691489794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZN9Ev39oJk78sdD2xFuDOdMnPsbmSFEY0jGkX/TZfs=;
        b=S2IapnuQmbGjnYwIJyazWLANMnUSj6pwdmkbzzvkifUmNpqSNGDxJNLodmusYyQGoD
         lA3dJILYVH5laTpM/ss4wPt8gSPZZlEqqmwWnrlkD83g8MZru7/xqtccEXoPHxwitQLT
         dQTtIX3cBr4/OJo+iqkt0QXRWRTaVR4jAvLhx6OlylJfmhyuPWMNmJFkga581qtSEWDO
         ic3pmoQ+D8WrVgLdbyiP530PkvkMZfnVrgdFsxMvFcUjrklwYE8BSa1PY6bvdH7GiQpr
         U82181+a5nBTNou9tMZ6qEwMZ9UoEbwA5zoHM/jDlrze31/P8Dr7L68QJFbu/x7itRB7
         kHnw==
X-Gm-Message-State: ABy/qLZBGVY2oXtN70NK1SuBb9V0Lt0gguyNMncTpcAXxSmd4UO6Kj7h
	MZy8DDKEe4UZyW3hPz3Fom7hh+hr252lhILtWuCjRQ==
X-Google-Smtp-Source: APBJJlHkfcuesWAMGBbcUdF5JPr/MxcZAjwXVj1t5i3BfLfeO0MddaAxywCAexaR5x9uibEQV/Y/qpX2KAXoZIKo3vI=
X-Received: by 2002:a05:622a:1493:b0:404:8218:83da with SMTP id
 t19-20020a05622a149300b00404821883damr731987qtx.1.1690884994354; Tue, 01 Aug
 2023 03:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230731230736.109216-1-trdgn@amazon.com> <CANn89iLV0iEeQy19wn+Vfmhpgr6srVpf3L+oBvuDyLRQXfoMug@mail.gmail.com>
In-Reply-To: <CANn89iLV0iEeQy19wn+Vfmhpgr6srVpf3L+oBvuDyLRQXfoMug@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Aug 2023 12:16:23 +0200
Message-ID: <CANn89iLghUDUSbNv-QOgyJ4dv5DhXGL60caeuVMnHW4HZQVJmg@mail.gmail.com>
Subject: Re: [PATCH v2] tun: avoid high-order page allocation for packet header
To: Tahsin Erdogan <trdgn@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 11:37=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Aug 1, 2023 at 1:07=E2=80=AFAM Tahsin Erdogan <trdgn@amazon.com> =
wrote:
> >
> > When GSO is not enabled and a packet is transmitted via writev(), all
> > payload is treated as header which requires a contiguous memory allocat=
ion.
> > This allocation request is harder to satisfy, and may even fail if ther=
e is
> > enough fragmentation.
> >
> > Note that sendmsg() code path limits the linear copy length, so this ch=
ange
> > makes writev() and sendmsg() more consistent.
> >
> > Signed-off-by: Tahsin Erdogan <trdgn@amazon.com>
> > ---
>
> I will have to tweak one existing packetdrill test, nothing major.
>
> Tested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

I have to take this back, sorry.

We need to change alloc_skb_with_frags() and tun.c to attempt
high-order allocations,
otherwise tun users sending very large buffers will regress.
(Even if this _could_ fail as you pointed out if memory is tight/fragmented=
)

I am working to make the change in alloc_skb_with_frags() and in tun,
we can apply your patch after this prereq.

