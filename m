Return-Path: <netdev+bounces-36047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6CA7ACAB4
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 18:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2700E2816F5
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03E7D518;
	Sun, 24 Sep 2023 16:09:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9269FD510
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 16:09:07 +0000 (UTC)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4084C83
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 09:09:06 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-452c0d60616so3216688137.1
        for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695571745; x=1696176545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SK3gOTBvtYkdgJJSi0KpkKHbgW4sZ89SISvqN0jWQVo=;
        b=TLF03bjDDSXgFy8SifD1E0ai1eaT+JYCi3Mek9n0O8hO4nyfLTY+PCRhl6mBq6vgm8
         hGvtvG44GjV+NYghQo3trWoLp8+0kKrCuMgljo03hnj50NBjwvj9pjAa98I1tv22qSP9
         a9NtIJoRz2ER2H2chpmUsKZ53jUIdn/0hw6neRVXpy1OX0jkpI75AVBQR0ieMsPC/ho2
         OlObo1C8ofs6Jm99X9qS0LiV1ly6GsI3c96slqZnANURuXBny6w6vGvT8TDvHlmCPD2Z
         3JApCLJSSdMegu996goCOrBxAOxkBAyqL9YH4a+8g1tqP5bDLUAydlcCvNDYs1e3fbk2
         irtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695571745; x=1696176545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK3gOTBvtYkdgJJSi0KpkKHbgW4sZ89SISvqN0jWQVo=;
        b=HPvjWDvR3xPd6GxCZqqKieTP2wqGem96Xusfr+OrDYjst7pJMazOAYBYAHgZ6EshCB
         po6FDu2+RqvmonxrhDzCOf+4kmQvjXX9FwQxd9ytVh21puntEgYeKsrzFA78eO85+tOf
         JOosROWaPpIk49aKCc7iz9C2dNLn7WONXmLaNui3Ixz+Ow7yGDjUYNL46wJje+1ugt28
         tVLLRd1PagGKzUKxb4GttUuUpTDtZitYeXvrLvDwpxZdvEswoqTLzNM9Sy+o2KNRf/5v
         2+HFI9VUyGuVVw25v1645dGecEBdNwHWcez4ya3Ee9BL3W/nN+x6PX4ANXRVCgoicGIt
         Vc6A==
X-Gm-Message-State: AOJu0YxeFul00odG7vTcg0Uoiv7sK06YYCcG/NaH075zdUlTh0Lz7erh
	0mXXolU4feqq9iwtclsKzo65CDqk7YVlOHC8IVR27g==
X-Google-Smtp-Source: AGHT+IFq4vb6QFOABfTLjtMbcY/ZRsW9317bEZJXY8rzUMTzcUkPZQR5d9vvqvcO3Cs6xHqy7vQunQy7ueLIeKF7JSA=
X-Received: by 2002:a67:f249:0:b0:452:75be:26a4 with SMTP id
 y9-20020a67f249000000b0045275be26a4mr2202886vsm.6.1695571745224; Sun, 24 Sep
 2023 09:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922220356.3739090-1-edumazet@google.com> <20230922220356.3739090-5-edumazet@google.com>
In-Reply-To: <20230922220356.3739090-5-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 24 Sep 2023 12:08:48 -0400
Message-ID: <CADVnQymE1cjkisOpT0235RbhxeH0PBD-Qu_5+BSLQQOHABx3jw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] tcp_metrics: optimize tcp_metrics_flush_all()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Yuchung Cheng <ycheng@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 6:04=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This is inspired by several syzbot reports where
> tcp_metrics_flush_all() was seen in the traces.
>
> We can avoid acquiring tcp_metrics_lock for empty buckets,
> and we should add one cond_resched() to break potential long loops.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Acked-by: Neal Cardwell <ncardwell@google.com>

neal

