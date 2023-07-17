Return-Path: <netdev+bounces-18371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F4B7569FF
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2217281179
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53DC1FD7;
	Mon, 17 Jul 2023 17:17:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9728F253C2
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:17:52 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB0A10E3
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:17:47 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-401d1d967beso18291cf.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689614266; x=1692206266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQgB32vlEAp0YKx7e5vpNktuGTRwOsNBESkngdbAe/w=;
        b=ee+iPICB9P2e1hpGuPb2+8K8FFlWgKjGajXAG6SkMmXVazSD7nduVf7IElcuvL7bGo
         bhuw7F3CgZxs/V+Vo2TTq+hZKqV4P3PvjXgV+LewlDK/dwwuMPhHZLuxJtZNqAU2gYze
         BeiXAWPEDTCfP5hdHWotL+2fyH89wcFAIvLDg0uyqBhE32bK5qTeWXtU38FlFpjGYSdG
         UuDfhCvmFlIvwHdLv+zZJkJ3nv4QmKKBiBLAKekDu5EYD8D6DilI/ic9waQPf2TEAenQ
         4MOOyMycZD++newtCMtnhaDfvjF9bavhExwdMNfMA7zuYIcuAdqLwKhD2HxmbHhKzpiG
         ZZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689614266; x=1692206266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQgB32vlEAp0YKx7e5vpNktuGTRwOsNBESkngdbAe/w=;
        b=UKlipQ2m0GvZr8tWWdn4vkNJex3DSJYgbBqKBDWP31nLAwKYqIIKydddMOPOicnTNt
         N8enHULnvqCKC0jsKAK2wtq7vbj918NUeyxt3DG2qGTmwVyVfOzLtjvbWyDw7u2WGkc4
         Y8TYx8eXQadBVFfffZycdZ6teES+uvvqgMFDu3kO3lDsRM9cHGK+p3GsrIxcVIxUoK9t
         E4X6GQAajbSRFdCp8/Akh6FoXWunsxb1MxEPXJ8/HNDYHmwcFWL6oTmrkAKDpaHGnz/6
         jIpV0QdGoW1QODvhgkk9ck4jgxyEzwoOcyelkeT5n26fejLxh9+uLU3wmhDNrK633bDN
         0KDw==
X-Gm-Message-State: ABy/qLZGPQ8jWdvAc8cKVYGUYsc6x1iyzrv+yPb7VB/O5yB/87jbYpE0
	24gFbUPffgiQpolTRltdP7zWvz1tpT2Tws6nKgpgWw==
X-Google-Smtp-Source: APBJJlHdEMMos8u11EM2LaS1R5x/YCUWkbtJSf3SSEFWyouovy1SeMwokPghsA8OrZK8VZAM0BP7qMqexI9jSV4mGpY=
X-Received: by 2002:a05:622a:15d4:b0:3f8:5b2:aef5 with SMTP id
 d20-20020a05622a15d400b003f805b2aef5mr1047641qty.29.1689614266115; Mon, 17
 Jul 2023 10:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717152917.751987-1-edumazet@google.com> <CACSApvYwQah8Lxs_6ogBGigTSo=eK4YAVPahdU8oWmGjrujw3w@mail.gmail.com>
In-Reply-To: <CACSApvYwQah8Lxs_6ogBGigTSo=eK4YAVPahdU8oWmGjrujw3w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Jul 2023 19:17:32 +0200
Message-ID: <CANn89i+Z6RiTGjzxMkd13iy-mP6OaZxo_hOuxVEr0x=+N=0nxA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
To: Soheil Hassas Yeganeh <soheil@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 6:52=E2=80=AFPM Soheil Hassas Yeganeh <soheil@googl=
e.com> wrote:
>
>
> Should we use PAGE_SIZE instead of 4096?

Great question. I thought of using 50%, but used this formula to kind
of document the problem.

Using PAGE_SIZE would probably hurt arches with large pages, for the
initial round trip.

Given that TCP normally uses IW10, there is almost no risk of tcp collapsin=
g
for the first RTT.

