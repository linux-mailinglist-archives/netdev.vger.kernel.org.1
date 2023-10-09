Return-Path: <netdev+bounces-38974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF0B7BD4F1
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 10:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9521C208F1
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 08:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0FC14AB2;
	Mon,  9 Oct 2023 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edj7kbWB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D38A14F7A
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:13:18 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F028F
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 01:13:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso12197a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696839195; x=1697443995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrQH2umOsfloZIlYa52ZdXA/6E97E3SVvBabAKsxLhk=;
        b=edj7kbWBwOqtecyb6sKWYwQqa6IlamXXE1nVaJGzlu3ZvjXaYoZS2mirp3IoGMVdxF
         aZYh/CVsf9RxYv3MFlHkSofOAPT8QuFDJPv4v3LsallQJRKwTEudcrJN/CogkiAK8NFZ
         eRqX6gXclw3fC6NDUiN/TjZs2yxBFPiwmk7rYq98V359KNOnV/My4S1mR5CK8+9JWnfx
         ac0V4IZlRcjrJNPRfXwHkN4G8q741OmzHFMH5M15xldpemkcX0fVBRXGZ4iXDof+jA5K
         XWw7408MlS2uqO+jMwbi/1x43DglM2ltkZsL+8l+3OhipTOsYT3St+nmMT7cFRHICJii
         CbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696839195; x=1697443995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrQH2umOsfloZIlYa52ZdXA/6E97E3SVvBabAKsxLhk=;
        b=EdhTT/N7+s32SNi3ugg8pRAOhHoAzpY777PPzNwQUuf1V7kTASJndd9xASm7GgtdBY
         a4aRO/Rl5CSN/XMWojc9xE8kd7R0AA9XfmtKofaQ9irn5e50NJ6xxf/EycGcOkO+XS5V
         NIdWJOXiFqTKTP/EiJSYthHQmhw8uqwUi+5nig/Ot5axy1DYHNzXsYrx1ILHUyF524R9
         P/HvEsP7NZXu2yX9gMS1cklARxFtvJ5T1nxQwzkEsF+0TvjptEd/ZVXYV4xVbl0+Pr0W
         7Dac0RmKDGWA78GrDAp+iKRTcexjF4J44oNPHDGPkt1R5+eb8bsEWoYp3+T+NzTsHXgT
         Ue1g==
X-Gm-Message-State: AOJu0YwHHTOjLLUJuw76C7no2AXOBTLqIgLpNEq0jOtpMLGHCdEI8oKt
	pVJaMFMhTmUfWt/kJ9NjWKT2JJpB2ToEyznyOAWLsA==
X-Google-Smtp-Source: AGHT+IEv25SUagBUFABpuy2Mwr+UEIQdTi718GmwSCOW+Vw9IW955LVtVvKZiDIPV8BnYjEg0aR5LOV9ksJ5xJK9pzk=
X-Received: by 2002:a50:d0d7:0:b0:538:1d3b:172f with SMTP id
 g23-20020a50d0d7000000b005381d3b172fmr340882edf.3.1696839194850; Mon, 09 Oct
 2023 01:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <29c4b0e67dc1bf3571df3982de87df90cae9b631.1696837310.git.jk@codeconstruct.com.au>
In-Reply-To: <29c4b0e67dc1bf3571df3982de87df90cae9b631.1696837310.git.jk@codeconstruct.com.au>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Oct 2023 10:13:03 +0200
Message-ID: <CANn89iKgw+z6RhXr6eJF0aGOzgC69NJCbZvaf3=EkxmPnL4MEw@mail.gmail.com>
Subject: Re: [PATCH net] mctp: perform route lookups under a RCU read-side lock
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, rootlab@huawei.com, 
	Matt Johnston <matt@codeconstruct.com.au>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 9:57=E2=80=AFAM Jeremy Kerr <jk@codeconstruct.com.au=
> wrote:
>
> Our current route lookups (mctp_route_lookup and mctp_route_lookup_null)
> traverse the net's route list without the RCU read lock held. This means
> the route lookup is subject to preemption, resulting in an potential
> grace period expiry, and so an eventual kfree() while we still have the
> route pointer.
>
> Add the proper read-side critical section locks around the route
> lookups, preventing premption and a possible parallel kfree.
>
> The remaining net->mctp.routes accesses are already under a
> rcu_read_lock, or protected by the RTNL for updates.
>
> Based on an analysis from Sili Luo <rootlab@huawei.com>, where
> introducing a delay in the route lookup could cause a UAF on
> simultaneous sendmsg() and route deletion.
>
> Reported-by: Sili Luo <rootlab@huawei.com>
> Fixes: 889b7da23abf ("mctp: Add initial routing framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

