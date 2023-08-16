Return-Path: <netdev+bounces-28149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA2C77E641
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3621C21134
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AB116430;
	Wed, 16 Aug 2023 16:23:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99205156E8
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:23:16 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615E51B4
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:23:15 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40a47e8e38dso320271cf.1
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692202994; x=1692807794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEUQJmCPLmerzzrEwbFkonmpbNVXBI0EafuTDjuODgI=;
        b=ViELFEs4iBXiNl3oyvsbvdWS5sMvhkvVRHTlOkbbnxutaEVMirOD70fgY7xfQ4wJ1h
         KSjnLDNvFp0ye7FCxUP7ANGfmKsApFxQCBCnuEMV7/VYu5Tdy+ltAX3ClcRERG6pp6th
         QJ0JdXgq4CILXXcUFylC+H3p68cZ5hc5ZLMFjOZPJhBBWPDesgLX1Z4jB/UyOHkAdnZT
         UZMOEfmzrFfUQsFltUxx0R1yk+v27RhmyWgZqY0+vpL/OuLtn696eS90SLulEUtjJj7c
         Hoa8FE6DIZ0hfbouvDlJZneuVHxYCNWiRJFO0zb6NZodteTO+k0ZprJcXvov0cx520zP
         b3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692202994; x=1692807794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEUQJmCPLmerzzrEwbFkonmpbNVXBI0EafuTDjuODgI=;
        b=TVf9brcdkF29CpCu0v6x2hYVB4/6BC9Y4JDE2idt38CUwsOQ4MdQk0YfQ7AspnbgW6
         ipJ6xDe3eudf8LZ+EKPLcPapoli55uPDy+0r3RWrcudY5sn6iW/s+qv9zFpgP0lxBXER
         +R2yf02c4XrIt/sYmmA6RQqM8upjjyfJNalK3fyBq+Yzyusav9LW7a9c8xUmyS7Uvp+K
         N1kjrodY4Qudjp/FOY+agTPwCkZzlvSi9QoDPLzkzKWHwwuW8gG5IH2pnUhiAq0o8LYF
         e8mtluJKOBkRFSUKkquq02cF/z6TaO9Iz/MaR89WSuKGD6V2OIIUq4T37ek1NdCOYr4D
         TpUQ==
X-Gm-Message-State: AOJu0YyDmDCVnu0xxbwrQjZ7hbIyXHx1uhGmVKUPexQqe1jHx/lZZxry
	w340EsP19HK6OJezLFR9q1J+74xhdXLRW+MZA7UhVQ==
X-Google-Smtp-Source: AGHT+IFyEVVKy/asOtDpBVx6rfWd7O9n3x5WJT4ImKg1bBFkt9Uz1iwi+ExO1c/wLNJE3vcz/vlSiIeyMRplniQ3NoY=
X-Received: by 2002:a05:622a:110:b0:3fa:3c8f:3435 with SMTP id
 u16-20020a05622a011000b003fa3c8f3435mr240089qtw.27.1692202994422; Wed, 16 Aug
 2023 09:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816091226.1542-1-wuyun.abel@bytedance.com>
In-Reply-To: <20230816091226.1542-1-wuyun.abel@bytedance.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 16 Aug 2023 09:23:02 -0700
Message-ID: <CALvZod7WrDF8he9djE6i5DyteR5Bz=w35r1q882QDuYb6dWSRg@mail.gmail.com>
Subject: Re: [PATCH net] sock: Fix misuse of sk_under_memory_pressure()
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, David Howells <dhowells@redhat.com>, 
	Jason Xing <kernelxing@tencent.com>, Glauber Costa <glommer@parallels.com>, 
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujtsu.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 2:12=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> The status of global socket memory pressure is updated when:
>
>   a) __sk_mem_raise_allocated():
>
>         enter: sk_memory_allocated(sk) >  sysctl_mem[1]
>         leave: sk_memory_allocated(sk) <=3D sysctl_mem[0]
>
>   b) __sk_mem_reduce_allocated():
>
>         leave: sk_under_memory_pressure(sk) &&
>                 sk_memory_allocated(sk) < sysctl_mem[0]
>
> So the conditions of leaving global pressure are inconstant, which
> may lead to the situation that one pressured net-memcg prevents the
> global pressure from being cleared when there is indeed no global
> pressure, thus the global constrains are still in effect unexpectedly
> on the other sockets.
>
> This patch fixes this by ignoring the net-memcg's pressure when
> deciding whether should leave global memory pressure.
>
> Fixes: e1aab161e013 ("socket: initial cgroup code.")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

