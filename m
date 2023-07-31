Return-Path: <netdev+bounces-22688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 697C8768C0C
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D061C20A0A
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 06:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4560A2C;
	Mon, 31 Jul 2023 06:33:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DF7E3
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 06:33:13 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106C01A5
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 23:33:09 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4036bd4fff1so416071cf.0
        for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 23:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690785188; x=1691389988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hF2HEe0+qJoM+NbKNI8XGqSl9fJ84u2rvglgtgrk3F8=;
        b=Co+BfdH4q5lblFrRuoa0AM7x0se3HGi2su6UQbqk0WSMUV4zyUI+872ReyiE397ITB
         kNDv2ilpt0e5axL10ACol9h179as3VS7GeTyD87LPGfuqClcVkiFURGUO6/NBz8iUOeA
         5LoUfxsCyI+vfl4tPQinQGpTJQKDPsh7Fu6hTcVQMoqCzKPUMp6w4vyO3fNrZRRP/CZM
         vLqu6jWZsYoDd1MRjAgL10URSIO0US2A30QyREZC6dg+rY0D1NO1dYYtj6FiOjsVKdcg
         PFwUGOTjzQfgrWKD6jbOTWFLOf/He7fpui28uRnjijNEZoI3fGKjCCeplbFXB3Wnxc12
         8gMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690785188; x=1691389988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hF2HEe0+qJoM+NbKNI8XGqSl9fJ84u2rvglgtgrk3F8=;
        b=hPY+E2a8wgZTGz5K6jNb5g9qubWZdTa5hWcn/C4bPbkLhL5VqaiOMwVHT9e/Plyzul
         hvPbnzflQ7S6cdZHEA5/2hhsWcJ0Vc7oSKAmYe6VbzFdmH5RAYIsoVyrxZEhzigqhNHA
         q8Ibza1zeiDT6fvPS+lbAbvtVtwIp9bq25Z11yl3MmmYBVxgvIs0P2CUSZK2Kv07PBHa
         FqD08DIIPXEU1NzOhcOYrf3dsr02oy9JzLzFrJ3MLlHJu6Xe288BlTcWFxw5tCYFze/m
         Oru8As1otfVvQNRoAXBMoJmx7meBi2ZZXBOUhGcQXsRo7msVfea/XCS/DIj4h7juaa3C
         XPsg==
X-Gm-Message-State: ABy/qLYKnvZ0TKsEg9M4RPmFJDQhcvAwM68pP9dJn328SWvbKoybiSBd
	gZlziJrkVYtC3CxEbgbRmYye04aTLiPR1rhvpscldQ==
X-Google-Smtp-Source: APBJJlG6gGK/GOUaULJUu6HL4W5EnyaRMlBrlreYMuM0pj3LOGzquxHx00Sx5hWjTAE2X2GDa7DLsUVncxQDYNYhCmM=
X-Received: by 2002:a05:622a:1006:b0:3f9:ab2c:88b9 with SMTP id
 d6-20020a05622a100600b003f9ab2c88b9mr384460qte.25.1690785188057; Sun, 30 Jul
 2023 23:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230729122644.10648-1-yuehaibing@huawei.com>
In-Reply-To: <20230729122644.10648-1-yuehaibing@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 31 Jul 2023 08:32:56 +0200
Message-ID: <CANn89iLhasFL-8iTUmKFkL4QczvkHsZ9LxGeu_ffaJT7h7oeOA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Remove unused function declarations
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 29, 2023 at 2:27=E2=80=AFPM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> commit 8a59f9d1e3d4 ("sock: Introduce sk->sk_prot->psock_update_sk_prot()=
")
> left behind tcp_bpf_get_proto() declaration. And tcp_v4_tw_remember_stamp=
()
> function is remove in ccb7c410ddc0 ("timewait_sock: Create and use getpee=
r op.").
> Since commit 686989700cab ("tcp: simplify tcp_mark_skb_lost")
> tcp_skb_mark_lost_uncond_verify() declaration is not used anymore.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

SGTM, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>

