Return-Path: <netdev+bounces-41422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4948D7CAE3E
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65BAB20CCB
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B712C87E;
	Mon, 16 Oct 2023 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dICZq4t0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2B627EFB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 15:53:01 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6480EB4
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 08:53:00 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9c145bb5bso301705ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697471580; x=1698076380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TOWBV0+RIkpT8pcDO7Atd39X0kSbmghLXKRHM4kosQ=;
        b=dICZq4t0cexqn4kJRHeFjfmU8wr4q5lpjU0pU2PFdZ+erHfJQbHDqsdbV2XmVUEE7O
         PiZXmQnRWx4nswFMjqiKha+2rKxYr/6JxfTXIsqwT3BJYlO6n/Xv/2KEKIHWBD5KVeDW
         +2xqfM6xFudZ+vmwVtBXvuTzp50zCdb9pxit9r88PlJMUTvzVyCm2kMasaw/PuTkJJvZ
         U5DTPjiSO/vRpFY3qAarZbJk5QSk9JPhVBdxX7Iovxz++gU0rVB0mSQdqGEL3hrhsmEp
         jx6474ML2hj/1MQbwu6paHKbylqGSKPrPYvYfMosnDTeZhV3nJeLkM3R3ZkYbqnE9ZZE
         WoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697471580; x=1698076380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TOWBV0+RIkpT8pcDO7Atd39X0kSbmghLXKRHM4kosQ=;
        b=OIUkC+kA0tzwwB6yyQ03WmghU/6pqBuLRbQUDpY7KsUiwYiXzJQ1n0LQZWw9mAhdVM
         428k2uH2vlEUVR08hsrMhPLRLr5ngvOT3kax96Wc0SenSCRzT44/AhAmLaqAWS7iRQWP
         LEM/PUpPwnDLm3u2RtzIMY7Vjqm6Au0QH/C27WtES8842GfWIVdbVopOH2RESwiKYEMp
         zR7y4kq8oHvTnLTuMt8UHi6VUPGoW5ZzCLiBr+TC2QxPKzHHfbPirsLR+Oqsy1MUovRL
         qXgTvys4XOZOBapkyyFvidleF6wGWz13xxK606kHe5roeKJ05Ew1zIdre8E3sid0dAv9
         HTBg==
X-Gm-Message-State: AOJu0Yx4Boz6Rr530lsAelTf1SE72MwcloZQWCRRgTVeLKvxd42e+DuL
	bDcCDBmFxW/uHMn1QSbhdH0mKy3hC6EgHZ+s1+nJ/Q==
X-Google-Smtp-Source: AGHT+IEbEyhGEmjYoHfOOvp0Vt7UUlKejUZXs3gj8zZDD8hpTlCKeFfpkArI07dmgi5mznFED9mqXBEHa8/KQbXw238=
X-Received: by 2002:a17:902:f70b:b0:1c1:efe5:ccf8 with SMTP id
 h11-20020a170902f70b00b001c1efe5ccf8mr277015plo.17.1697471579647; Mon, 16 Oct
 2023 08:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016132812.63703-1-wuyun.abel@bytedance.com> <20231016132812.63703-3-wuyun.abel@bytedance.com>
In-Reply-To: <20231016132812.63703-3-wuyun.abel@bytedance.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Mon, 16 Oct 2023 08:52:48 -0700
Message-ID: <CALvZod6FRH2cp2D2uECeAesGY575+mE_iyFwaXVJMbfk1jvcgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] sock: Fix improper heuristic on raising memory
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 6:28=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> Before sockets became aware of net-memcg's memory pressure since
> commit e1aab161e013 ("socket: initial cgroup code."), the memory
> usage would be granted to raise if below average even when under
> protocol's pressure. This provides fairness among the sockets of
> same protocol.
>
> That commit changes this because the heuristic will also be
> effective when only memcg is under pressure which makes no sense.
> Fix this by reverting to the behavior before that commit.
>
> After this fix, __sk_mem_raise_allocated() no longer considers
> memcg's pressure. As memcgs are isolated from each other w.r.t.
> memory accounting, consuming one's budget won't affect others.
> So except the places where buffer sizes are needed to be tuned,
> allow workloads to use the memory they are provisioned.
>
> Fixes: e1aab161e013 ("socket: initial cgroup code.")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

