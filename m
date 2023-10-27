Return-Path: <netdev+bounces-44666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D75437D9082
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129071C20E9B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25F8111A5;
	Fri, 27 Oct 2023 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wap7/LDR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4FCB66D
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:01:46 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5DD111
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:01:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53f98cbcd76so6627a12.1
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698393703; x=1698998503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Irzuq7oTHJy3AZh7I/wZEugeALg+bhMSSpYQflfzJC0=;
        b=Wap7/LDR+Va+NST9SwX+H6dyCfNf/Oc09xGYWwE+09upgJLkU99/fI6ahcMw642y31
         JCasG/NPcaQfqNKF59uYhrLLKcqOxOffD9gKyOEY++PrKYKv8MMFiksGuJBeeW7zoJIa
         hrDowHqjC6Sj18pcaswWOq8PeTO6FhsjvhVY42/+ZQcRwYBXBdxwNB/34ViMiqVB47xf
         2sNYoi9YS36uRozjAzvqKn0ghNWHs/3Su/e0CrNWwiyhTpGGCiMhLc+9giSbJGnkEVLN
         mCP5y9uzSkgyhjW8SM1pXckstd/ycnE2GyWuu1G6y1rHlKKMJpuu1QwhUYuz/IGCnPot
         tMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393703; x=1698998503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Irzuq7oTHJy3AZh7I/wZEugeALg+bhMSSpYQflfzJC0=;
        b=gqe55uzqIBHy3++CEbxyKn6ZTeVPOb6DL9TcLENHPCui7LDM70deLdQMAMxHohlNt6
         de0qMUvo0hnf0wCL+0P4dfo2InH6e8xh+QuOkOiGPAV6XK/LDQnMpLH6VvxJv1c0Ch6J
         quxU5n6yExKT/gaxUI0773OcgMv52jUud6/KtP8b+NJQCFMW16YEKlqF1+htu0k9AtQd
         kyXvPfwNfEuJXbBKz9/CFX5sGHwcC7h+nAGD+KFoxr7Rd+LQYuat5rRix7vs9qBXoDZT
         9SM8lFAbGyrqDtwDM5PzR3qOaKaSsTf8jMunFAGAPGDrKn6MWjjjM/5EquCf1NVo3icw
         6mpg==
X-Gm-Message-State: AOJu0Yyo5wVHM/gu1TUTa7NvFdQ273pQl0AGNF0WGIE8LhkqFzzv6R6n
	1yhHYGK4hz4JjzOoCUD9dolTK7Q1G7R1qc9rPbTqYg==
X-Google-Smtp-Source: AGHT+IGM0QM+0RyCgajqVpu2/xc85WjBZGJBiHg6YFZl9qqukZ2SbNDpYJg4wuUhWBj7hRkIMFQum7o1fDQJ+usvaPQ=
X-Received: by 2002:a50:c34e:0:b0:540:9f5c:9a0d with SMTP id
 q14-20020a50c34e000000b005409f5c9a0dmr59764edb.1.1698393703071; Fri, 27 Oct
 2023 01:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026071701.62237118@kernel.org> <20231026233914.57439-1-kuniyu@amazon.com>
In-Reply-To: <20231026233914.57439-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Oct 2023 10:01:32 +0200
Message-ID: <CANn89iLNF4jTqFUvP0zmJirLzo0CzbWs5wRPLmAtvghgNL2PGg@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 2/6] cache: enforce cache groups
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: kuba@kernel.org, andrew@lunn.ch, corbet@lwn.net, daniel@iogearbox.net, 
	dsahern@kernel.org, lixiaoyan@google.com, mubashirq@google.com, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	pnemavat@google.com, weiwan@google.com, wwchao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 1:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Thu, 26 Oct 2023 07:17:01 -0700
> > On Thu, 26 Oct 2023 08:19:55 +0000 Coco Li wrote:
> > > Set up build time warnings to safegaurd against future header changes
> > > of organized structs.
> >
> > TBH I had some doubts about the value of these asserts, I thought
> > it was just me but I was talking to Vadim F and he brought up
> > the same question.
> >
> > IIUC these markings will protect us from people moving the members
> > out of the cache lines. Does that actually happen?
> >
> > It'd be less typing to assert the _size_ of each group, which protects
> > from both moving out, and adding stuff haphazardly, which I'd guess is
> > more common. Perhaps we should do that in addition?
>
> Also, we could assert the size of the struct itself and further
> add ____cacheline_aligned_in_smp to __cacheline_group_begin() ?

Nope, automatically adding  ____cacheline_aligned_in_smp to each group
is not beneficial.

We ran a lot of experiments and concluded that grouping was the best strate=
gy.

Adding  ____cacheline_aligned_in_smp adds holes and TX + RX traffic (RPC)
would use more cache lines than necessary.


>
> If someone adds/removes a member before __cacheline_group_begin(),
> two groups could share the same cacheline.
>
>

