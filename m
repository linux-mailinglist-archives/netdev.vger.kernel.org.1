Return-Path: <netdev+bounces-49996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C2E7F4373
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB0D281464
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B697922083;
	Wed, 22 Nov 2023 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwxK35OS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C27F97
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 02:17:03 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so12325a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 02:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700648222; x=1701253022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uy8nHgBcWA0HxTAc9O5ykdmdK44AesluH2NTJUbD/lQ=;
        b=XwxK35OSxvA32TpqmJJXP63O607AD33rP587BZSEuHvx4OPZH1QEa317OH9RbxTNC1
         y0C0uOzhehrRMok/019DMPCg3ysz7QXpIOmWWSR+n0erYTZsMZU7VsoCKAWcdccVxEeF
         BSKwT7Z64AW+5MfMTjhvE2T8uhHQ+rCO+YZu38GFli4Yia3xqHxYXi99RvL4VZbcSACv
         WxKOjrbsTzKYFt+dgyD/oCoT46r+XxpI1uKIxNVc3v6XTYuUfq4ntWfy8KFGWGhh5fph
         lMjLTDT36iYbHqN30GkBvhCPMWInDiGCqtkK4Ml+fd5rfbNtBsFY918r0iLzfLlZ2bzo
         /dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700648222; x=1701253022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uy8nHgBcWA0HxTAc9O5ykdmdK44AesluH2NTJUbD/lQ=;
        b=kPvigKF7MBrNpr68HvqLjbeWn6axpg7/KORpGB5MZnuL+HTgAh+tny2HOVt3DEbG3K
         YiVGICDYQ6vFlI/wrN42iM9KVZ6JXIFy4ceBYZH94xt81JX7ytM2ciKJXXjE2PuxFxkH
         FwRgJz4wD+PVhAW9A5TYrBcAZ+TNOiKKByqUbGLLxi8zMX9UuTwGWbPBOrH8TTTd/o1m
         CxrgAK1x2Fy55is5thjq65SfRTRPV0kQLsjj6oJn3B1NE+vM9F0NflLnjOOTgmPkcad9
         Gq3pmCpJcMYD5TaiLeLueuAIdw/iimBJgs876ld6W+gb1LtEzhxMWi+h7nad/mAqvRfk
         PYEQ==
X-Gm-Message-State: AOJu0Yx5YM+iefxFPoHkD/jM6jAZ+AGsrD5rWOkP2vr70XwtJfpGDiRe
	cNC882hPwX88DMPco4oKi5ZmwdwZsbdENYYqTGHFuA==
X-Google-Smtp-Source: AGHT+IHdlgzQ5LI38TeQtEuThW1h2VhhY4jWs3zF1UZsraczEqdO+JOdHqH0L4YTFtZj1ZLJrIz9juEPfII5GRTTUvw=
X-Received: by 2002:a05:6402:d67:b0:548:c1b1:96b2 with SMTP id
 ec39-20020a0564020d6700b00548c1b196b2mr110346edb.6.1700648221861; Wed, 22 Nov
 2023 02:17:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122034420.1158898-1-kuba@kernel.org> <20231122034420.1158898-10-kuba@kernel.org>
In-Reply-To: <20231122034420.1158898-10-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 11:16:48 +0100
Message-ID: <CANn89i+YXf=Qnjw5HVSwTm3ySj-CK15-k14D2G_uFgmrBD7mXA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 09/13] net: page_pool: report amount of memory
 held by page pools
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Advanced deployments need the ability to check memory use
> of various system components. It makes it possible to make informed
> decisions about memory allocation and to find regressions and leaks.
>
> Report memory use of page pools. Report both number of references
> and bytes held.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml | 13 +++++++++++++
>  include/uapi/linux/netdev.h             |  2 ++
>  net/core/page_pool.c                    | 13 +++++++++----
>  net/core/page_pool_priv.h               |  2 ++
>  net/core/page_pool_user.c               |  8 ++++++++
>  5 files changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
> index 82fbe81f7a49..85209e19dca9 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -114,6 +114,17 @@ name: netdev
>          checks:
>            min: 1
>            max: u32-max
> +      -
> +        name: inflight
> +        type: uint
> +        doc: |
> +          Number of outstanding references to this page pool (allocated
> +          but yet to be freed pages).
> +      -
> +        name: inflight-mem
> +        type: uint

4GB limit seems small, should not we make this 64bit right away ?

> +        doc: |
> +          Amount of memory held by inflight pages.
>

Thanks.

