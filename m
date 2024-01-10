Return-Path: <netdev+bounces-62947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AF982A061
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 19:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC341F22D81
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 18:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D03F4D586;
	Wed, 10 Jan 2024 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTVXsC5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8224CE05
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4298fa85baeso15291cf.1
        for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 10:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704912315; x=1705517115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3Eh3vWd3uLjS4vTvLciXZgkfWKFz3UWutS6XF/j3R4=;
        b=TTVXsC5Fh6eVl8Sh95GDMtjgMD/b2rBDi6chTfjGFBM6OoMekEw3KnEckkRXOgSj04
         O+wFZVM6JxT+fG2Tmzu6PvNOSnKShZ5rIyKEFTCXkn/eNEkfB7IL3L8bw0hM9rgbAyvB
         W+y+6hdkxb5jjeKNE1YSqlkuzaIa0NeRqbXSlSzOrmg/Q+XyJ5oiSU/YpLJDmpVwFd0X
         +8ByoXimM0g+s1rFOmurdfYS3lLgcWCgRQfW2O99Sp6sXjNv3Ohvoz3euXitGMaxWrLJ
         4naYTbQ5544BgX+D5Von5RRvZWBMRB82OcomWaLiNbJqxe+kt9KCOzFSNpRtHmvWujrM
         Qr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704912315; x=1705517115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3Eh3vWd3uLjS4vTvLciXZgkfWKFz3UWutS6XF/j3R4=;
        b=hcBVldxjBaZEBS5R+Xm2D0COhzPfcdtJiK7y2enVn1nyeLTCQo0tUu5IJ/qUDAqWaN
         HBeKxdOjhJ0NV19zZQemmpIbDc9Jklj4mGGlDrs3+oKTwx14KIuAbKT0wMun5n0f9LOZ
         Ta/Ncr68RmFdtQdQyEn4djJu33hbBQye35WKVrjR/01bnkDAZe/4NnQs6a7qNWIgdRFa
         SyTOMGyWCFzIk4NErmP71vqCPZ9c/ryl34Dz8IV+38nLa0DuIt+hnEV+6yZITCSfm4R1
         hsrQAUL2Yd3HfwT5HNRWmH1ECNgOwAqSxTH9wL8wjLzhMMaB10G80+5/ijxpZZyqaLu3
         BJ4g==
X-Gm-Message-State: AOJu0Yy6jYnNgtLrOA9mFw42A0VBZm2poW0EhncYSDcb8fC8jvfDH75k
	Kgp41WRPY7ZLPFrI+G97xgKwEbbmUe8x9vyLCy40nOGvbdno
X-Google-Smtp-Source: AGHT+IH1g5oAkA/mXv6S15A1WyjlDf9P6tGy0rPvYtU+BuRDJsscMQ1qY1dsO/ODnyLO6ERHe77CJ8mkYXE3Bk4LEFE=
X-Received: by 2002:ac8:5d4b:0:b0:429:8c96:3710 with SMTP id
 g11-20020ac85d4b000000b004298c963710mr14700qtx.9.1704912314663; Wed, 10 Jan
 2024 10:45:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109011455.1061529-1-almasrymina@google.com> <20240109011455.1061529-2-almasrymina@google.com>
In-Reply-To: <20240109011455.1061529-2-almasrymina@google.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 10 Jan 2024 10:45:00 -0800
Message-ID: <CALvZod4Ngqn0scEM9JhRCav88ZFB=LLmTiLj9fd_04moCLTsyg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v5 1/2] net: introduce abstraction for
 network memory
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 5:15=E2=80=AFPM Mina Almasry <almasrymina@google.com=
> wrote:
>
> Add the netmem_ref type, an abstraction for network memory.
>
> To add support for new memory types to the net stack, we must first
> abstract the current memory type. Currently parts of the net stack
> use struct page directly:
>
> - page_pool
> - drivers
> - skb_frag_t
>
> Originally the plan was to reuse struct page* for the new memory types,
> and to set the LSB on the page* to indicate it's not really a page.
> However, for compiler type checking we need to introduce a new type.
>
> netmem_ref is introduced to abstract the underlying memory type.
> Currently it's a no-op abstraction that is always a struct page
> underneath. In parallel there is an undergoing effort to add support
> for devmem to the net stack:
>
> https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@googl=
e.com/
>
> netmem_ref can be pointers to different underlying memory types, and the
> low bits are set to indicate the memory type. Helpers are provided
> to convert netmem pointers to the underlying memory type (currently only
> struct page). In the devmem series helpers are provided so that calling
> code can use netmem without worrying about the underlying memory type
> unless absolutely necessary.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

