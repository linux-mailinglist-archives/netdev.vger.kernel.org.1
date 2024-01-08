Return-Path: <netdev+bounces-62324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 337B7826A52
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 10:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39FE1F2259C
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE19EAE6;
	Mon,  8 Jan 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYzS9hHJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F8812B93
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-557a615108eso4264a12.0
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 01:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704705036; x=1705309836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVeISqx1IYuB8q44TarP2V7Hig1f2BS8XZ7W6hewe98=;
        b=SYzS9hHJZAZYXEfLbNe/GUEIR7fGlAB1KRVPyh2zqVvagxsHiGmtlVQ0rfHfVIUqaB
         KTv3SZQ6wMfAJmLS7RvgLY8yZm9dKODchYna1eU88EMl4v7xqLoAPp5qKVrt1IzlKm6B
         CnG6SNPLBzeTKtbgP6q3THBYeZqwSeuk4FZW+umsTmH3XfHhqNHRllEjnVIRJ/Andmcf
         iuRDYqqyGON5NqnSw/icpG3EnYgIbIMdUPLNBskc5EqT4hPo8wRwofBFyVEf3TIYuCWi
         TxVe5w70RIycAu8onDmmL4JQUXaDI6Y6LoIbfmSMha2OPQyi/t4oo9wkKcemwEbe9QVb
         aqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705036; x=1705309836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVeISqx1IYuB8q44TarP2V7Hig1f2BS8XZ7W6hewe98=;
        b=ECxV8h8VxNkN8l1jRHwpi+AtdNHXOgLplAJKz8x2VJqgDFw8hZAwRWUwH2TkDvwrbH
         qU3m8QEerueKpYsJK6wfzlycf4cL7aFUkwbaZadN4wfcW9CUnL3oXiEU2Fdsz8J25y00
         XTu/hzuNWW8jouhFgNmO0RFVqM6Oa3G9/ZR2xQk4jJQHN79J0u7EbIxy9/vtrnfnnoCp
         safjFKK+q32y+/DyoH5XLCd+8FoNVZZPJ6MVv0crsPNzxJRhjg7fdVMR7T2CajdZnt7z
         4V06NfXdqIV+Fvlov7jazErH5AAPfVuytjLwKCUKltxjXh69kuo2O7chhDfwlZL2NTem
         l1Ww==
X-Gm-Message-State: AOJu0Yz570HiVyUgO+AlbyJRvWJDZJZNDG8YQU4ce4HyVy/oTnVkRp03
	fd+VCC1rZdTkM4KJTrFElx+Enh5Bf6bYmJ5ISjGcKio1OLkO
X-Google-Smtp-Source: AGHT+IHqPHz71QsG0pUS7Sxrs39ixb6yF9R+Cx8SM+f0nSa29nQo0T3GqFRg7JLq7IC1+zqp5TvF2GxZ9wD3A5XklD4=
X-Received: by 2002:a50:9b1e:0:b0:553:5578:2fc9 with SMTP id
 o30-20020a509b1e000000b0055355782fc9mr204336edi.5.1704705036396; Mon, 08 Jan
 2024 01:10:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108085232.95437-1-ptikhomirov@virtuozzo.com>
In-Reply-To: <20240108085232.95437-1-ptikhomirov@virtuozzo.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jan 2024 10:10:22 +0100
Message-ID: <CANn89iJv1RjbKrX2wbJKepg24a4t46kwuFV_fRYHpsPHJfi+KA@mail.gmail.com>
Subject: Re: [PATCH] neighbour: purge nf_bridged skb from foreign device neigh
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@openvz.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 9:52=E2=80=AFAM Pavel Tikhomirov
<ptikhomirov@virtuozzo.com> wrote:
>
> An skb can be added to a neigh->arp_queue while waiting for an arp
> reply. Where original skb's skb->dev can be different to neigh's
> neigh->dev. For instance in case of bridging dnated skb from one veth to
> another, the skb would be added to a neigh->arp_queue of the bridge.
>
> There is no explicit mechanism that prevents the original skb->dev link
> of such skb from being freed under us. For instance neigh_flush_dev does
> not cleanup skbs from different device's neigh queue. But that original
> link can be used and lead to crash on e.g. this stack:
>
> arp_process
>   neigh_update
>     skb =3D __skb_dequeue(&neigh->arp_queue)
>       neigh_resolve_output(..., skb)
>         ...
>           br_nf_dev_xmit
>             br_nf_pre_routing_finish_bridge_slow
>               skb->dev =3D nf_bridge->physindev
>               br_handle_frame_finish
>
> So let's improve neigh_flush_dev to also purge skbs when device
> equal to their skb->nf_bridge->physindev gets destroyed.
>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---
> I'm not fully sure, but likely it is:
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> ---
>  net/core/neighbour.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 552719c3bbc3d..47d2d52f17da3 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -39,6 +39,9 @@
>  #include <linux/inetdevice.h>
>  #include <net/addrconf.h>
>
> +#include <linux/skbuff.h>
> +#include <linux/netfilter_bridge.h>
> +
>  #include <trace/events/neigh.h>
>
>  #define NEIGH_DEBUG 1
> @@ -377,6 +380,28 @@ static void pneigh_queue_purge(struct sk_buff_head *=
list, struct net *net,
>         }
>  }
>
> +static void neigh_purge_nf_bridge_dev(struct neighbour *neigh, struct ne=
t_device *dev)
> +{
> +       struct sk_buff_head *list =3D &neigh->arp_queue;
> +       struct nf_bridge_info *nf_bridge;
> +       struct sk_buff *skb, *next;
> +
> +       write_lock(&neigh->lock);
> +       skb =3D skb_peek(list);
> +       while (skb) {
> +               nf_bridge =3D nf_bridge_info_get(skb);

This depends on CONFIG_BRIDGE_NETFILTER

Can we solve this issue without adding another layer violation ?

> +
> +               next =3D skb_peek_next(skb, list);
> +               if (nf_bridge && nf_bridge->physindev =3D=3D dev) {
> +                       __skb_unlink(skb, list);
> +                       neigh->arp_queue_len_bytes -=3D skb->truesize;
> +                       kfree_skb(skb);
> +               }
> +               skb =3D next;
> +       }
> +       write_unlock(&neigh->lock);
> +}
> +
>  static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *=
dev,
>                             bool skip_perm)
>  {
> @@ -393,6 +418,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, =
struct net_device *dev,
>                 while ((n =3D rcu_dereference_protected(*np,
>                                         lockdep_is_held(&tbl->lock))) !=
=3D NULL) {
>                         if (dev && n->dev !=3D dev) {
> +                               neigh_purge_nf_bridge_dev(n, dev);
>                                 np =3D &n->next;
>                                 continue;
>                         }
> --
> 2.43.0
>

