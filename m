Return-Path: <netdev+bounces-13929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECBC73E09D
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 15:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835F01C208D6
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 13:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829B49474;
	Mon, 26 Jun 2023 13:27:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752EB8F6A
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 13:27:10 +0000 (UTC)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8131AC
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 06:27:09 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3459a62fd29so176395ab.0
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687786028; x=1690378028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSZHpIGj9wwkIa9hVVPRK76zK+0CMnJhqGyhyWSAmH0=;
        b=QU4ktPnXPtrQ92+3m0NNpOS4TkW9tT8cF2/6OaqIvDumeqYRw1chYYeWj+qFv3ZZic
         633YwIC/xGZ8YUufw/n14aRWQHKHl9mv8zsizHuo3QKfoOoDmXOGHcXb8b6eC1G88uT5
         R2EzLBjalpwcH5/4zbymHE2aGsJ5LYu+3bi4xERIwMYTIUK/Hr4aork0TQtEMa/cEGan
         GUjoYvLBntTEZhNhpTE5PrSHQw87xRk4mOpCg83icdiafcTfKR2eH9XxJc+Nv71hiWr3
         /cnTZkQqepl1NzAjv6ze7VVWzWiZfV+kECbHO+K6OJtLlUlCfIlOOgwXn9rKxIQzAL7J
         3RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687786028; x=1690378028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSZHpIGj9wwkIa9hVVPRK76zK+0CMnJhqGyhyWSAmH0=;
        b=hWo+cDiHRj7BYT/KKHcicFUkKMIZtTOGHGyd+E2qL5VnVFEiLYOKZETJjWsOTvM2SZ
         5lo9vhfi2TlyiwUVMtKdq5DBWDgDyzP/ch90UbvXj+02hRaaeOuSULWRtfR1KT5oS/nT
         5gJxtgPueTSnto4XSEYA20SCq+c1COsg4FZl3Wa3AOS0d2/J3xnqgzRWAQstY8dle0re
         0+Hgdt6j9ezXiv7cPNcyFWefPojZLvKu1mirPOeucrjsslJeCPuC1oGEvhzhxbsw2fLk
         ixVUsLoeIZE+I5HjJYQzFQUGXH5/k2L0duCNO9PoigTWQypVISMYxl7PpYAEaFO++s8Z
         7+0Q==
X-Gm-Message-State: AC+VfDyY9h+ZRif061hP1c1LY0pf5VCIYWIIx3X4kbo2oQlaEFWuiR23
	FQDgDuhTjzYBiPgpvbRfJKZVE7pYuBJj8PiOR31q4tG38kD4Nn0AYNQ=
X-Google-Smtp-Source: ACHHUZ7tqs35ui6sqUKq3bHPizstRYS1nwRSk/Hqeqy7U1a2le2mFRC6yXGJ+/38BAUVTwK+xygXVymA05bBPBNXUHI=
X-Received: by 2002:a05:6e02:1b09:b0:33b:5343:c1d6 with SMTP id
 i9-20020a056e021b0900b0033b5343c1d6mr346378ilv.21.1687786028373; Mon, 26 Jun
 2023 06:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230626100107.4102329-1-imagedong@tencent.com>
In-Reply-To: <20230626100107.4102329-1-imagedong@tencent.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jun 2023 15:26:57 +0200
Message-ID: <CANn89iKHfAWj_e6aqWiNQJfe2LOeaX3-Grx3w0LpxoKH9i86Cg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp: support to probe tcp receiver OOM
To: menglong8.dong@gmail.com
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, corbet@lwn.net, dsahern@kernel.org, kuniyu@amazon.com, 
	morleyd@google.com, imagedong@tencent.com, mfreemon@cloudflare.com, 
	mubashirq@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 12:01=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> For now, skb will be dropped directly if rmem schedule fails, which means
> tcp_try_rmem_schedule() returns an error. This can happen on following
> cases:
>
> 1. The total memory allocated for TCP protocol is up to tcp_mem[2], and
>    the receive queue of the tcp socket is not empty.
> 2. The receive buffer of the tcp socket is full, which can happen on smal=
l
>    packet cases.
>
> If the user hangs and doesn't take away the packet in the receive queue
> with recv() or read() for a long time, the sender will keep
> retransmitting until timeout, and the tcp connection will break.
>
> In order to handle such case, we introduce the tcp protocol OOM detection
> in following steps, as Neal Cardwell suggested:

net-next is closed.

I think I suggested something much simpler, and not intrusive like your pat=
ch.
(Your patch adds code in the fast path, and yet another sysctl)

If we can not queue an incoming packet because we are under memory stress,
simply send an ACK with WIN 0

