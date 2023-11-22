Return-Path: <netdev+bounces-49949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 584B47F40A5
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBDBAB20C2E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 08:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E252BAEA;
	Wed, 22 Nov 2023 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w1OP+rmf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E04E7
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 00:55:47 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so10391a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 00:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700643346; x=1701248146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubcqzvXd/k53LrnkM7BqZVu71FTT3GmP018mj8qHk0Q=;
        b=w1OP+rmf9v43f2TsteogHfc72Gy0SyzM2w/WszNH/WLO4eo1/7C85ZkxbtQXSfHO6L
         JOVaw2CeqfM++tOJaR3+G6Q24s4TJPfoah2LJMjJi+FQ+nr41Dg0KdAaIH+dl+jUA1X7
         BKeiyHz8yVscvHx74Q2FZi5zMFDQ+IsPDnsZVkvFGXvb8m09IOseaNj5/1cdwDAFjyNr
         Uad4QR2D23FipBRs0byFamXoBMS+VoIwmWt7oC9JtncL/jFlWd+wcWP8DzHRPEV6mUFi
         tOFIGdNvxS6bSiQr+btbPNpjtsvOV++6o0V4OenBH9Z69oAGfXRm3Cp+DlV/VkuKyVlb
         z/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700643346; x=1701248146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubcqzvXd/k53LrnkM7BqZVu71FTT3GmP018mj8qHk0Q=;
        b=dN3OIkYb9D+g04L4NPF8CsCDEeVQ0Fg9vzYDddQpB3nxkcYMf0EDNqq70pAAU/8953
         xpRCtga3PmF/NFlV9i2obyMVYv0c0KI8KNNe6I4BSGBk8LmDJra7KRPNoKad4SXafdOe
         HkuilsO4SNGdHqhUWqvhX2/lLB6e4THQGys62KhE0khyx2KZ0k9TLvPj4IVkfI+Nrgyl
         PcuVOIMZ7g0vDS1P11WUEgPYov9mPlrNTFU46XcJ1U7ojEUrwuB9P+qi56J3Ru/oebKd
         PT+7g8WdmasMHOlU++Ac74/W3n7PTd8PecLdT62TpNAq3Ja+cP1JAejzbFBiJXOJx062
         QHHg==
X-Gm-Message-State: AOJu0Yy2N6T3eXNX8PLwxFI3TU3UodqZKETtgmD3/LSBEfsbgkugnJwg
	AvFdLvJ9aDKYeOxhhYBZH+0UIYVgucHRDsSKGcePCKSbS9IpZQm0ws6IFA==
X-Google-Smtp-Source: AGHT+IH032zj3SBMuSRUnXcOLcWmuKSb/8JOZIJqStMVirsgYOu3kg8zzg6eLIBZPHX/GTX3uVgtxevWJGYCICgETgA=
X-Received: by 2002:a05:6402:35ca:b0:544:24a8:ebd with SMTP id
 z10-20020a05640235ca00b0054424a80ebdmr125967edc.4.1700643345726; Wed, 22 Nov
 2023 00:55:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122034420.1158898-1-kuba@kernel.org> <20231122034420.1158898-4-kuba@kernel.org>
In-Reply-To: <20231122034420.1158898-4-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 09:55:34 +0100
Message-ID: <CANn89iKPhGtC6wgThpoe7DmMkowNSbOQehcpDVnOayF42Uqk2g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/13] net: page_pool: record pools per netdev
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Link the page pools with netdevs. This needs to be netns compatible
> so we have two options. Either we record the pools per netns and
> have to worry about moving them as the netdev gets moved.
> Or we record them directly on the netdev so they move with the netdev
> without any extra work.
>
> Implement the latter option. Since pools may outlast netdev we need
> a place to store orphans. In time honored tradition use loopback
> for this purpose.
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v1: fix race between page pool and netdev disappearing (Simon)
> ---
>  include/linux/list.h          | 20 ++++++++
>  include/linux/netdevice.h     |  4 ++
>  include/linux/poison.h        |  2 +
>  include/net/page_pool/types.h |  4 ++
>  net/core/page_pool_user.c     | 90 +++++++++++++++++++++++++++++++++++
>  5 files changed, 120 insertions(+)
>
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 1837caedf723..059aa1fff41e 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -1119,6 +1119,26 @@ static inline void hlist_move_list(struct hlist_he=
ad *old,
>         old->first =3D NULL;
>  }
>
>

> +static void page_pool_unreg_netdev(struct net_device *netdev)
> +{
> +       struct page_pool *pool, *last;
> +       struct net_device *lo;
> +
> +       lo =3D __dev_get_by_index(dev_net(netdev), 1);

Any reason for not using dev_net(netdev)->loopback_dev ?

> +       if (!lo) {
> +               netdev_err_once(netdev,
> +                               "can't get lo to store orphan page pools\=
n");
> +               page_pool_unreg_netdev_wipe(netdev);
> +               return;
> +       }
> +

Either way :

Reviewed-by: Eric Dumazet <edumazet@google.com>

