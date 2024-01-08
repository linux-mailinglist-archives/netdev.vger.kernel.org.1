Return-Path: <netdev+bounces-62341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A4826B78
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 11:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A051F23021
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 10:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A57B134AC;
	Mon,  8 Jan 2024 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FN6gRA7m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4113AD8
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso12509a12.0
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 02:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704709109; x=1705313909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Qfly6nhl8jFfx0HUMf8kF4M5Jg9zmmCAg6MMJqYeTY=;
        b=FN6gRA7mALBe1fK1MNNMoNbqZ0Jq3PVgOBum/KdFHf/7817h+DQzTV6h6C5AjoZbg6
         CcVn8V1xzXT4CrOcdTmNwuQ00RgWg1wKny95A6aB20vZndsXz3tvp6w5veUUnCvTuDIe
         DnV2aZUtBdC62PikOHFYjjnzQPpmM7nS0UPFG8V4e9NSMci0Wm+q02N+VnYZr5coptA8
         WnIHZE5GFGU+HWdA1ysBVMgtLpjffa2Q96ZUXJ/iXdC4EJ9MOJNoMVYfZdxBFPVldboq
         chERDvKNAv0LIPvBxH5LUl3pRaIz1FJbXQ8KqK+5oB7PzM0gRrUZKiAHtvOSXN6152lD
         IvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704709109; x=1705313909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Qfly6nhl8jFfx0HUMf8kF4M5Jg9zmmCAg6MMJqYeTY=;
        b=NX+B7Ky2Xm/4ayBIlRqiKJc8YeiZ9PaeBeVfbZfg0MzaR5GF5G89n6bbqWHK26lqO3
         hYjvR0qmLc0ee+7rC6zGNQgHyxj/oQ8cmQZHUABm7x1RxfqUuMCSH2UyyaMoqWisAWtx
         PfUOBxAcyJ1XJbxkiHTLtNgX6djRX7X3n6QLZt3xULQsXr4m1AyrjsJjKstMLwkoJQXX
         TpRk7AgiwvDwT/hg7T66UWWD5edp6KVfuKxK0o1mU+J+kKs1AcVrymOdckJg03fJypan
         GUwV7O6pYwCIUpdwm20WgmHWkYVQfdI+J8D1nh5+O3M+piIMrZw1e/x9WxaRQUn8cSE6
         JlSQ==
X-Gm-Message-State: AOJu0YxUbLv0udlvZljfnL1a238ED8X4+ABeOtZOns5pDwL10z78T42d
	RyhvqXiELu8eY/JD/yWQyQ5TQevvOxeyUCkj1aAIuhbu3tc3
X-Google-Smtp-Source: AGHT+IFEWfYqZHIG+LUJ5EaJhMftBDDG9sJmw7KbKz3j+4Pc9Jto7FXpe22zDYZiLa6obmvd316Ar7V7fftFPa1Gtf8=
X-Received: by 2002:a50:cdd1:0:b0:557:1142:d5bb with SMTP id
 h17-20020a50cdd1000000b005571142d5bbmr268574edj.4.1704709108543; Mon, 08 Jan
 2024 02:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104232714.619657-1-xzou017@ucr.edu>
In-Reply-To: <20240104232714.619657-1-xzou017@ucr.edu>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jan 2024 11:18:15 +0100
Message-ID: <CANn89iLZKMW4ncpk2TAsGKo=t+fm=Jss9466zF5YQ0NN+M_K9A@mail.gmail.com>
Subject: Re: [PATCH] net: gre: complete lockless access to dev->needed_headroom
To: Xiaochen Zou <xzou017@ucr.edu>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 12:26=E2=80=AFAM Xiaochen Zou <xzou017@ucr.edu> wrot=
e:
>
> According to 4b397c06cb9 (net: tunnels: annotate lockless
> accesses to dev->needed_headroom), we need to use lockless
> access to protect dev->needed_headroom from data racing.
> This patch complete the changes in ip(6)_gre.
>
> More changes in other modules might be needed for completeness.
>
> Signed-off-by: Xiaochen Zou <xzou017@ucr.edu>
> ---
>  net/ipv4/ip_gre.c  | 12 ++++++------
>  net/ipv6/ip6_gre.c | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 5169c3c72cff..8c979c421d79 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -491,7 +491,7 @@ static void gre_fb_xmit(struct sk_buff *skb, struct n=
et_device *dev,
>         key =3D &tun_info->key;
>         tunnel_hlen =3D gre_calc_hlen(key->tun_flags);
>
> -       if (skb_cow_head(skb, dev->needed_headroom))
> +       if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom)))
>                 goto err_free_skb;
>
>         /* Push Tunnel header. */
> @@ -541,7 +541,7 @@ static void erspan_fb_xmit(struct sk_buff *skb, struc=
t net_device *dev)
>         version =3D md->version;
>         tunnel_hlen =3D 8 + erspan_hdr_len(version);
>
> -       if (skb_cow_head(skb, dev->needed_headroom))
> +       if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom)))
>                 goto err_free_skb;
>
>         if (gre_handle_offloads(skb, false))
> @@ -653,7 +653,7 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
>                     skb_checksum_start(skb) < skb->data)
>                         goto free_skb;
>         } else {
> -               if (skb_cow_head(skb, dev->needed_headroom))
> +               if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom)))
>                         goto free_skb;
>
>                 tnl_params =3D &tunnel->parms.iph;
> @@ -689,7 +689,7 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
>         if (gre_handle_offloads(skb, false))
>                 goto free_skb;
>
> -       if (skb_cow_head(skb, dev->needed_headroom))
> +       if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom)))
>                 goto free_skb;
>
>         if (skb->len > dev->mtu + dev->hard_header_len) {
> @@ -742,7 +742,7 @@ static netdev_tx_t gre_tap_xmit(struct sk_buff *skb,
>         if (gre_handle_offloads(skb, !!(tunnel->parms.o_flags & TUNNEL_CS=
UM)))
>                 goto free_skb;
>
> -       if (skb_cow_head(skb, dev->needed_headroom))
> +       if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom)))
>                 goto free_skb;
>
>         __gre_xmit(skb, dev, &tunnel->parms.iph, htons(ETH_P_TEB));
> @@ -768,7 +768,7 @@ static void ipgre_link_update(struct net_device *dev,=
 bool set_mtu)
>         if (dev->header_ops)
>                 dev->hard_header_len +=3D len;
>         else
> -               dev->needed_headroom +=3D len;
> +               WRITE_ONCE(dev->needed_headroom, dev->needed_headroom + l=
en);

Can the updates here happen while packets are in flight ?

ip6_tnl_xmit() updates definitely could happen while packets are in
flight, this is why we needed

if (max_headroom > READ_ONCE(dev->needed_headroom))
     WRITE_ONCE(dev->needed_headroom, max_headroom);

Do you have a KCSAN stack trace or something ?

Normally, dev->needed_headroom is only set at setup time,

Commit 8eb30be0352d ("ipv6: Create ip6_tnl_xmit") violated this rule.

