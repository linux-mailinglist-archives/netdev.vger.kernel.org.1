Return-Path: <netdev+bounces-47240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D8A7E912E
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 15:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFA51C2032A
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379548495;
	Sun, 12 Nov 2023 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0yAZ4m+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFD512B8D
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 14:24:07 +0000 (UTC)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE72D56
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 06:24:06 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-45f3b583ce9so3096740137.0
        for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 06:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699799046; x=1700403846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/yY//VvOd8mFTHsi92TwWcLu1hFv0pg95WJeB4r85E=;
        b=F0yAZ4m+OA34KxfSd9DowI35aYimapDjcepyeyIeqtR3SDrBKyfTgyxmFH9nOdED07
         MKLeCrclTABLp1Ube9kbACoT0WSzu5BVJoVzoP68CY/MqVctD+0lu9fZjoi8HrXRTVMZ
         8wK1hGmFhc5Sqr1imkJ55oKcUFvDvsrLX7JDMDAas4I/8ac+xxITV2lgDgMXi8HdEhFF
         6gv/fKTgJOgIuQVC+7dm+PjZRyyqyLmbkyrS5C6HDnybeCLcdmjWkGYDgODR2ynPQYgE
         0srrLQ3k4AVv6nLHstrPiX7PbPTU9+v0XxLiZD8E3FrZ398GRNhwE6976Rczy/z7QbqC
         qx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699799046; x=1700403846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/yY//VvOd8mFTHsi92TwWcLu1hFv0pg95WJeB4r85E=;
        b=Gd/yGWkJXdsgCwev/ceMsEewoqIjPUDm09Lrhd6XTWqTgBno3/o44qIUEk9M62uZKQ
         fjng68kUIYdoXivMP0KmyUk3evTj6S68HkFnZBvGVgij7kYRiwVc8sSTX4sIqQqei25I
         pE3lA5cCtj+Uc1dXcty7kzQHQTsJaMATGaZ0ynixNntD3+ZHCBBrigeX0zrlq+Ew3jUQ
         me7RzvPfy6tWUSahAuTgHgiBu40XYs1PAEmsiRQ1Nh5mrQlpoKxP9+CpJ1i6kE1KS8JI
         btrbwQIDzEUpisjXwE5YZIlVsTtAxvi3tWchZeKOgcG3PbuUXwUFJ0T+X4U0FzjHAh58
         pntQ==
X-Gm-Message-State: AOJu0YyUHLrg4hiSckvaiuKGqfKj/r8FOR5AY7URMGCYd/byIYDV29SG
	BOGh5H9w1eE5PJGwWMfKmlGmnnj4+SpBRE10vmM=
X-Google-Smtp-Source: AGHT+IF0/VUOa7dYaDe+7d9VwwNQwCx/xjn6dCHHdpRzWoY1x7YH9Q8HYPQqM5tzOZ1F7U4Jj6/uJynsiQeIBxQ/8j4=
X-Received: by 2002:a05:6102:300f:b0:450:6ef1:e415 with SMTP id
 s15-20020a056102300f00b004506ef1e415mr3334737vsa.13.1699799044276; Sun, 12
 Nov 2023 06:24:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110153630.161171-1-willemdebruijn.kernel@gmail.com> <20231112101411.GI705326@kernel.org>
In-Reply-To: <20231112101411.GI705326@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 12 Nov 2023 09:23:27 -0500
Message-ID: <CAF=yD-Lzu+LHAah+dEM0doFZZnO+TfHPhQNWEy2UYS28o+4jsw@mail.gmail.com>
Subject: Re: [PATCH net] net: gso_test: support CONFIG_MAX_SKB_FRAGS up to 45
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 5:14=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Nov 10, 2023 at 10:36:00AM -0500, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> >
> > The test allocs a single page to hold all the frag_list skbs. This
> > is insufficient on kernels with CONFIG_MAX_SKB_FRAGS=3D45, due to the
> > increased skb_shared_info frags[] array length.
> >
> >         gso_test_func: ASSERTION FAILED at net/core/gso_test.c:210
> >         Expected alloc_size <=3D ((1UL) << 12), but
> >             alloc_size =3D=3D 5075 (0x13d3)
> >             ((1UL) << 12) =3D=3D 4096 (0x1000)
> >
> > Simplify the logic. Just allocate a page for each frag_list skb.
> >
> > Fixes: 4688ecb1385f ("net: expand skb_segment unit test with frag_list =
coverage")
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
>
> Thanks Willem,
>
> I agree that the logic does as described,
> that it should resolve the flagged problem,
> and that as a bonus it is a nice simplification.
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks for the review Simon.

One thing I did not mention in the commit message and should be clear
is that these kunit tests lack cleanup code on error paths. If an
assertion fails, previously allocated memory is leaked.

This seems to be common procedure, and keeps the tests simple.

It takes superuser privileges to insmod tests, and they are not loaded
in a production environment. Which I assume is the basis for finding
this acceptable. They're usually run in a UML process -- if not
necessarily: I discovered this issue when running on a real system
with a config I had not anticipated.

Long story short, leaks on error are not an oversight, and common in
tests. If anyone thinks this is wrong, I can certainly revisit.

