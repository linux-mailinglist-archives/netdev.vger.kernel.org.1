Return-Path: <netdev+bounces-265452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOU0ME+ZrmnFGgIAu9opvQ
	(envelope-from <netdev+bounces-265452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:56:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6507E2369F7
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B28F9301A7AA
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 09:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6433876B8;
	Mon,  9 Mar 2026 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwE2ZpNc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAE83859D5
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050164; cv=pass; b=crOk3qY6Zj/x2FCjANI5FJtsiFzGozIw246recwTK65tQj2SnCbXnSldxeSbKSc+teDpysaukZqSWcQRo+zfZtNOWQeast3titmLKl2U7oLC/kemjbS6a7BwPbwZsQRo5UD9ezH82Qzgs2EOcJYPS6Q2xluj9O7WIfhkx3HPBUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050164; c=relaxed/simple;
	bh=IUQifikNwCfzBwgT+madxgPWfmOu/MElAtpmV+aTYrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwunhlYmpTBCsRyvt/IdSxNHQZrMEPe38BlvNGPH9sX+m0av2gc1CDBj7hrblLzx++giAqBiUmpxQyJFiJJng6GAOZ9QleMAmMiSkZ3klT5JCQ7gI8U3/V/ck8Hwm95yiyxNaQGVwGgdokLUWrMmrQk1LTq/Y8POwV/DSISNFsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YwE2ZpNc; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899f8c33c11so75850836d6.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 02:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773050160; cv=none;
        d=google.com; s=arc-20240605;
        b=GOQb4uUnyQe9uuiCsTkWCkbiP0q9RmmyzjUitAAptZtMfbwKsx2kY0QijG/49j0nYk
         RbVGBkZ3yZJo4m3bUeORCPC4NNQ8q3yQwqPkCcWqbHzxk6t9vpwQk7tr1EEyimvtV10R
         heYEVRgYCxkuL8nM6cYXCri6of7+Z4QLsss+iWYdgfFt9VmezmjjDiKkHAnJJz3dnzfF
         uhoRaH/3joEq+H6yqsKS0wQDLntyRs1UaSc4OGWFo1HQQmbsUdxiXRW4Zdi1aXBDxBlW
         3pOFlUxzr11A48/hr3StnFSYk9MMeLdSZcloi23jll0SJZdSD3TQRX2PqAydBJhmTR64
         A7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dOcd0tZdxtQ6/7FjgTRzIgVpvTNkyqLexbA3KkhpX2o=;
        fh=zQUkJUyDOfu4CGWYOTVvqlgpCgu13OAoYCTXex1TX2U=;
        b=U4ydCD+jcLslvoA9sCc9lLSZDVpqS8I1xK0nVuIapOy2GKX3KFHSUmJB8CjGUwFTet
         XjoDkz5y95nLJW5gpGFpcv23SQeOV9/kodqXT8BOr79oYwzhxUpzWlSOLTzH8M/tIDwY
         x25UeDXRiIwLFvrIYDABquIYrS0ww7/m29CNNtsey3Hd2wCnahtTUAWvlebbWMC7BymR
         p3IpyTtTEXciIfzXxqmVO+QttMAwR4JWhYX+hJL6Wbdks7xo6GbOU8iYcIRH/G1h/om5
         wY9G5XydKZG8lhQkEUlAw0CW6zGdzMJoH8+0VC+LG6h+hNSI5y7jZP6FzVt2Qi0gxtsO
         p2AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773050160; x=1773654960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOcd0tZdxtQ6/7FjgTRzIgVpvTNkyqLexbA3KkhpX2o=;
        b=YwE2ZpNcV6E+orVbtm26V6mw3dSDw+8oeToCs6k8EcyrPmocY9Pk1ybGqmqJRXnRpV
         ZfChbVMbmn7DHNg/fu/Ou8GXeI6w7QcZImhvav1qwCpW0iusqDOEHV5CZSzJXsv6vR9/
         NkKgDdIGiV5ywjiZyAJRMgKvpc7F3DtBs1GsreBeR7la2tPP4h0flECnzTsiauFKRGMt
         4yz0rQxL4VdOxyozZ4abMOELRV8JdGCiYW65xqsMK1RwXy+wCKzKAS1+eEavqSfUZYko
         oPjGFDTKbzaoQuChzHCwEnMK2DVhXHY4i6tbKs72mzjE8eFb6Ygw9udVtVt9bzl+9D71
         LG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773050160; x=1773654960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dOcd0tZdxtQ6/7FjgTRzIgVpvTNkyqLexbA3KkhpX2o=;
        b=se20yvQajdDU2KGJJkdzFn0SHT6NPLJrTwc8xfN3nn8/h2FE917C8s5Lu9/Q5N62jY
         z/cBQn6xmepJWrmtmBZun/XLRwEzZakXxcjC6cECVdkn/G37mU1VEZ795hlIi9ZE0hO8
         u6jmeIBxtFRl1+4xHp6yzt/J8b6g9aKizLRuE8c5giQboJUtN7eYAig1Gqrbydvq+Z6U
         zrK2L3+rNlKIBjb2v6M+0iUitV4lq09vtB9Z5vmqeXKIZ0mIUhIOoHvTe2ej6UH7QjzT
         lxTjgb9+HbM5fEo0/UivPVpcelxZss+7Y2tiVmaksSrHMiJRxdS55wazBcFoNXtdUscG
         WidA==
X-Forwarded-Encrypted: i=1; AJvYcCXrWSaxIrKFdqicbvLD4WAuF7Jy5EUufjz7J0BNASRQfhYvafpxKLxombXxiU74xSPyUX4JPg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6YoN7uATKEMm3T16z9Gwu/tDVMmVaqiLH6m+jXtbkUo2rU67f
	/p+Nk89H/iAvQhS0szVEUsLY0yBtQ5mcXpGbpf6QmCdrkLZud17oYk4FYC2N3NijZIUQjcCtKpw
	xUfwh4DULbBxthSj4wQCBrrmCmOYLz/A/6xlJp9/o
X-Gm-Gg: ATEYQzyFQLSzMkBlGNveEP8gCJiAJ6QN5puSAU8afkqpCE2Nv8LvOC/UL89zEsRUy97
	I6p+yLIPhVMjoubgucGAdrRnrcZwWOtClLv68KlBSBTbtp4sL9KM/nNS6eaRHdbxGCFuiv+rifJ
	6vmBcQq6HZzMKoRWMsduF2YkyX2ETaipdMItq/K6XHuk106dMxoAE2ShdN1rv/0V2uRL38b5URn
	JmHrZ/zLkQ2Z+Ydx3RBUKBBJ0HKjdHj6puqjqKirGu8lpt000bywoknuSnnkOdUeucRVud2y5IT
	p+XqYbA=
X-Received: by 2002:a05:6214:2a88:b0:896:fbdd:ef14 with SMTP id
 6a1803df08f44-89a30a2b091mr162782286d6.12.1773050159768; Mon, 09 Mar 2026
 02:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309093614.502094-1-kartikey406@gmail.com>
In-Reply-To: <20260309093614.502094-1-kartikey406@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 10:55:48 +0100
X-Gm-Features: AaiRm501A5W6pfW5PWifB9gyOd6-No7ONRkIwGIFtSJPbZ9d3b20Jwjt87YVUUU
Message-ID: <CANn89i+pYiuKdtqU-kBvD2e8BaDfYzAtzLZJ88SgSD_D9CDL+Q@mail.gmail.com>
Subject: Re: [PATCH] atm: lec: fix use-after-free in sock_def_readable()
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kees@kernel.org, mingo@kernel.org, tglx@kernel.org, jiayuan.chen@shopee.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6507E2369F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265452-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.984];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,f50072212ab792c86925];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 10:36=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> A race condition exists between lec_atm_close() setting priv->lecd =3D NU=
LL
> and concurrent access to priv->lecd in send_to_lecd(), lec_handle_bridge(=
),
> and lec_atm_send(). When the socket is freed via RCU while another thread
> is still using it, a use-after-free occurs in sock_def_readable() when
> accessing the socket's wait queue.
>
> The root cause is that lec_atm_close() clears priv->lecd without holding
> lec_arp_lock, while callers dereference priv->lecd without any protection
> against concurrent teardown.
>
> Fix this by:
> - Protecting priv->lecd =3D NULL in lec_atm_close() with lec_arp_lock to
>   synchronize with callers that already hold the lock (e.g. lec_arp_resol=
ve)
> - Using sock_hold/sock_put in send_to_lecd() to pin the socket while in
>   use. This is safe because send_to_lecd() is called under lec_arp_lock
>   by lec_arp_resolve(), preventing concurrent NULL assignment of lecd.
> - Using lec_arp_lock + sock_hold/sock_put in lec_handle_bridge() and
>   lec_atm_send() where the lock is not held by the caller, with proper
>   skb cleanup on early exit to avoid memory leaks.
>
> Note: Patch testing via syzbot was attempted but the test VM crashed
> due to a QEMU AHCI emulation assertion failure (hw/ide/core.c:934)
> unrelated to this fix. The QEMU crash is caused by syzbot's disk I/O
> fuzzing triggering a known QEMU NCQ emulation bug, not by this patch.
> Compile testing with "make W=3D1 net/atm/lec.o" passes cleanly.
>
> Reported-by: syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Df50072212ab792c86925
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  net/atm/lec.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/net/atm/lec.c b/net/atm/lec.c
> index fb93c6e1c329..7e051174a92b 100644
> --- a/net/atm/lec.c
> +++ b/net/atm/lec.c
> @@ -131,6 +131,7 @@ static void lec_handle_bridge(struct sk_buff *skb, st=
ruct net_device *dev)
>  {
>         char *buff;
>         struct lec_priv *priv;
> +       unsigned long flags;
>
>         /*
>          * Check if this is a BPDU. If so, ask zeppelin to send
> @@ -154,10 +155,19 @@ static void lec_handle_bridge(struct sk_buff *skb, =
struct net_device *dev)
>                                         /* 0x01 is topology change */
>
>                 priv =3D netdev_priv(dev);
> -               atm_force_charge(priv->lecd, skb2->truesize);
> +               spin_lock_irqsave(&priv->lec_arp_lock, flags);
> +               if (!priv->lecd) {
> +                       spin_unlock_irqrestore(&priv->lec_arp_lock, flags=
);
> +                       kfree_skb(skb2);
> +                       return;
> +               }
>                 sk =3D sk_atm(priv->lecd);
> +               sock_hold(sk);
> +               spin_unlock_irqrestore(&priv->lec_arp_lock, flags);

What prevents priv->lecd to be NULL after you released priv->lec_arp_lock ?


> +               atm_force_charge(priv->lecd, skb2->truesize);
>                 skb_queue_tail(&sk->sk_receive_queue, skb2);
>                 sk->sk_data_ready(sk);
> +               sock_put(sk);
>         }
>  }
>  #endif /* IS_ENABLED(CONFIG_BRIDGE) */
> @@ -441,7 +451,7 @@ static int lec_atm_send(struct atm_vcc *vcc, struct s=
k_buff *skb)
>                         /* hit from bridge table, send LE_ARP_RESPONSE */
>                         struct sk_buff *skb2;
>                         struct sock *sk;
> -
> +                       unsigned long flags;
>                         pr_debug("%s: entry found, responding to zeppelin=
\n",
>                                  dev->name);
>                         skb2 =3D alloc_skb(sizeof(struct atmlec_msg), GFP=
_ATOMIC);
> @@ -449,10 +459,19 @@ static int lec_atm_send(struct atm_vcc *vcc, struct=
 sk_buff *skb)
>                                 break;
>                         skb2->len =3D sizeof(struct atmlec_msg);
>                         skb_copy_to_linear_data(skb2, mesg, sizeof(*mesg)=
);
> -                       atm_force_charge(priv->lecd, skb2->truesize);
> +                       spin_lock_irqsave(&priv->lec_arp_lock, flags);
> +                       if (!priv->lecd) {
> +                               spin_unlock_irqrestore(&priv->lec_arp_loc=
k, flags);
> +                               kfree_skb(skb2);
> +                               break;
> +                       }
>                         sk =3D sk_atm(priv->lecd);
> +                       sock_hold(sk);
> +                       spin_unlock_irqrestore(&priv->lec_arp_lock, flags=
);
> +                       atm_force_charge(priv->lecd, skb2->truesize);
>                         skb_queue_tail(&sk->sk_receive_queue, skb2);
>                         sk->sk_data_ready(sk);
> +                       sock_put(sk);
>                 }
>         }
>  #endif /* IS_ENABLED(CONFIG_BRIDGE) */
> @@ -471,8 +490,11 @@ static void lec_atm_close(struct atm_vcc *vcc)
>         struct sk_buff *skb;
>         struct net_device *dev =3D (struct net_device *)vcc->proto_data;
>         struct lec_priv *priv =3D netdev_priv(dev);
> +       unsigned long flags;
>
> +       spin_lock_irqsave(&priv->lec_arp_lock, flags);
>         priv->lecd =3D NULL;
> +       spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
>         /* Do something needful? */
>
>         netif_stop_queue(dev);
> @@ -534,6 +556,7 @@ send_to_lecd(struct lec_priv *priv, atmlec_msg_type t=
ype,
>
>         atm_force_charge(priv->lecd, skb->truesize);
>         sk =3D sk_atm(priv->lecd);
> +       sock_hold(sk);
>         skb_queue_tail(&sk->sk_receive_queue, skb);
>         sk->sk_data_ready(sk);
>
> @@ -543,7 +566,7 @@ send_to_lecd(struct lec_priv *priv, atmlec_msg_type t=
ype,
>                 skb_queue_tail(&sk->sk_receive_queue, data);
>                 sk->sk_data_ready(sk);
>         }
> -
> +       sock_put(sk);
>         return 0;
>  }
>
> --
> 2.43.0
>

