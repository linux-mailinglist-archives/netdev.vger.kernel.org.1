Return-Path: <netdev+bounces-267727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGjxGOpNtWmHzAAAu9opvQ
	(envelope-from <netdev+bounces-267727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 13:00:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAAB28CF7F
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 13:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10B45302F989
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662C62BEC5F;
	Sat, 14 Mar 2026 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3muLuS+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F5F1A256E
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489632; cv=pass; b=Ufm0pUjGMbafUOXWbh1/3rBSXZJzxCupMo7vLlNHYzUovAvuRh8f6TleeaGlLu7/0/A9+5Da87B00Xud2Zfb84lenAThu+umid8C7XWSrpOvjYDOeP7o97xfDq7zzXX/AV74uwfepikrNVZwmDHeF0Ov/x1+yA/0YoJgmlBxIjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489632; c=relaxed/simple;
	bh=Q2ek1cQSBGnSxStpxbeUAfhmZ6rQV759eIi2QdRx2jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WT7YoiV0bqOav5YTl5f2vhCySRDo0J2zk4tYFPcG0PMUqSVNE11a8xKG7U4KY3QzIw2eIWt/JW1gZQMOvHmCYrzvzu4wkZ+jr44KVKJXHb6WUCt/p60fUSYBPg/M4ICWHQxgQfGRgMHtjwgHyKE06IO44OqZhOq5eIWGPdX42aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3muLuS+; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79902e1fb71so31634947b3.3
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 05:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773489629; cv=none;
        d=google.com; s=arc-20240605;
        b=ETDhZ+zUh1a/kMLceuYNOVGQ86wRHaL1hjNHyweKx7TvMX4TZ5MhjgT98zEJdcW+zG
         H+E7P3HVit2fQpNqn9c06buFjl6WXZ59FJgEaKPAWYLo0ZCjH2b16ntl6nmcaC1paLl0
         b7xzKBH2PWqcX1z4j8umpMZwg3usoBJPBv2VL/ufEABMk+Sn3Ipdleclp4BONfk7YFdf
         aDH9Zjdw+uAACbgf3bIcV50NYYW96oVMolFYVWv9mL9hpZjA6qWUno05bBosRUG38fYm
         qmRaX/BEHvAPfcxsdZ8yqIBBHYHRcBxcwRgYOSNnfe8r/uQwggmRxKKs56LPZBi+aI2b
         35RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aRw+xGf1nKdZl3tqrmO9Bg5DWxX6iENeUrIC32RiYhI=;
        fh=0f+4JLvPZlKXWsm2JjAIqKvJodAQlApR3zrurewaQ+Q=;
        b=R7FLOhgDarVb6tLjnHGvyzl2PtttNbrD2WD0+d2VTjnQ387nrbhZyvix6MJed9xlBZ
         pI+4JxkbUsv+TNYuaMJ6DrMf73YWOnDM/HYNQYbqcDMTnKcClyjGrQIx2ujMzqRxrwo0
         ALF+a9N0UshiWM5Z1SCjD81TV3Hlfpr8598MTNZJEzdcUkTprXvaFb5x3s7/he1/X4pD
         nAOhIT62o1ixtwfbtuMzrTDU1k4OWfUsIZ0UZGIuLxpCDcITgcIIK23Yy59nYft+NsNI
         GRgHGffmKBtVl/XFnxboPUfJFZ1L0yzFliZgxCHhRnUDRYz1M3Pq4cnuh8z9Bosvd7ty
         CCnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773489629; x=1774094429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRw+xGf1nKdZl3tqrmO9Bg5DWxX6iENeUrIC32RiYhI=;
        b=F3muLuS+8SYaKzEULttyGMV6Ffs2E59McYSlmI/rWyYKYIA1m6JWLZqUDPs7ISsqRI
         H9WJCI9J342RU3yVLqdUqkz6+ZP+10LOp0z/46mVdfRRSzzEO86e2fNuaykUp+AG9OeG
         QyKxLqtmYUYE7EKZ1FT88m7sWtiXxo19OohiGYdyEvE8JAA1HyP3/laZuC5PELHh8f8W
         z1o2xfmXH76q/zbr8AU9fDdnQKosrQDIaXbYaSsup5E4s3RFo+0zSa+thjFBiCqCD57q
         1KxmtdM7xtVeqcPukFemNuuzlK4S7idEWsGAqiLlFKqz/BJ48rHTpyO938Idk77ZiMTt
         QRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773489629; x=1774094429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aRw+xGf1nKdZl3tqrmO9Bg5DWxX6iENeUrIC32RiYhI=;
        b=gKjQwt/8nasCIGsnWATjA/H9NuxjrnIsnq5AvNRjGaB4CQVAJCP67Uc11LCEWO/MCy
         2kP7+mGIEbYD9zjKG1xIV0QJlrb2OVbruTdGo4zQ1X0lNeWBjFuewr+6+4pVrdultq9T
         M/0PwtBRZUrS0pLX2wgpzvJ8DutJ7mgkmfjMhOzfg3i4yuV2dw8VeZY0JViwXkE4Gd5J
         i3i5/ab3Qop/Zq+bOhwvMlFKaDgHpkd8DpSFtpwXQzVYsTDgFaVXYAG78+vZXg90Pven
         e7nUB/QbwfeL385pPpWiXChqRmyklArD3b6ArsBqHc0NcnSgfbITz6dgmd8HbFWmawg1
         BWzg==
X-Forwarded-Encrypted: i=1; AJvYcCXVLHqC8Bnp4y2ha/QeqILw7RpSxlzt9g2IuL4EvHL6Z7X7QVG8aR52Kf5jxV3pAGYIa8WYEps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAwYFjmgu+bDoJCgIW7tzez21/XFxpV5dM8IJQw3p3Vho3BJKU
	1ww41sLQx7NLrgKlXVZC1LAXUzXHhhKSgatxwUpm0fdIA9ilQFyhINEHSpm3pVnznb0vi3cRnKn
	jGG6QYUeECo/YItirX3aUVBqmdC4ORHg=
X-Gm-Gg: ATEYQzxajYBH04JIbZRo8+nsjbOaoIa9utzU2Irf8gKPJHa1g41vfY0Imynx47+k7PQ
	653kzk4EaizIg6SC1AAAqiOx4jMuib9jVmTfW8NhR9Ojm4cxLpjjURsD6d+YH9z6n+R3T0VVJpJ
	wnnnhOQypMh8F7PoJ+/+6vQgfjYqJcAa9g6EzuPDBKjb4A+4nfNnjeEeDsCUkgp6cu4QTpL9NSI
	XakXUH264YCsumRzjD2wMZHpthShhpvz/d6keRiFBV/PCb3Sdx/7HT27yJdVoRHYnrSCr92Wrbm
	jt7tR0HRRSIXTO+t8VNtuA6LPPFOsytuVYDBGNxWJdxjdNM8bIaJfwWmU5GlwHVoO4eC1rE2
X-Received: by 2002:a05:690c:91:b0:798:58be:3251 with SMTP id
 00721157ae682-79a1c20cfb8mr69234117b3.58.1773489628565; Sat, 14 Mar 2026
 05:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155908.508768-1-kartikey406@gmail.com>
In-Reply-To: <20260309155908.508768-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sat, 14 Mar 2026 17:30:17 +0530
X-Gm-Features: AaiRm52fxEFqm7gz9xSiYpsf7u81HLWdn75TozcvGoN2JOhTZu5ctxxO4GUlN4Y
Message-ID: <CADhLXY7gQ=OgC1dVdRHF31CLww+J3-KePfvoKJMm8gxRZzrUmw@mail.gmail.com>
Subject: Re: [PATCH v2] atm: lec: fix use-after-free in sock_def_readable()
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Cc: mingo@kernel.org, tglx@kernel.org, jiayuan.chen@shopee.com, 
	kees@kernel.org, netdev@vger.kernel.org, dan.carpenter@linaro.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267727-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,f50072212ab792c86925];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EAAB28CF7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 9, 2026 at 9:29=E2=80=AFPM Deepanshu Kartikey <kartikey406@gmai=
l.com> wrote:
>
> A race condition exists between lec_atm_close() setting priv->lecd
> to NULL and concurrent access to priv->lecd in send_to_lecd(),
> lec_handle_bridge(), and lec_atm_send(). When the socket is freed
> via RCU while another thread is still using it, a use-after-free
> occurs in sock_def_readable() when accessing the socket's wait queue.
>
> The root cause is that lec_atm_close() clears priv->lecd without
> any synchronization, while callers dereference priv->lecd without
> any protection against concurrent teardown.
>
> Fix this by converting priv->lecd to an RCU-protected pointer:
> - Mark priv->lecd as __rcu in lec.h
> - Use rcu_assign_pointer() in lec_atm_close() and lecd_attach()
>   for safe pointer assignment
> - Use rcu_access_pointer() for NULL checks that do not dereference
>   the pointer in lec_start_xmit(), lec_push(), send_to_lecd() and
>   lecd_attach()
> - Use rcu_read_lock/rcu_dereference/rcu_read_unlock in send_to_lecd(),
>   lec_handle_bridge() and lec_atm_send() to safely access lecd
> - Use rcu_assign_pointer() followed by synchronize_rcu() in
>   lec_atm_close() to ensure all readers have completed before
>   proceeding. This is safe since lec_atm_close() is called from
>   vcc_release() which holds lock_sock(), a sleeping lock.
> - Remove the manual sk_receive_queue drain from lec_atm_close()
>   since vcc_destroy_socket() already drains it after lec_atm_close()
>   returns.
>
> v2: Switch from spinlock + sock_hold/put approach to RCU to properly
>     fix the race. The v1 spinlock approach had two issues pointed out
>     by Eric Dumazet:
>     1. priv->lecd was still accessed directly after releasing the
>        lock instead of using a local copy.
>     2. The spinlock did not prevent packets being queued after
>        lec_atm_close() drains sk_receive_queue since timer and
>        workqueue paths bypass netif_stop_queue().
>
> Note: Syzbot patch testing was attempted but the test VM terminated
>     unexpectedly with "Connection to localhost closed by remote host",
>     likely due to a QEMU AHCI emulation issue unrelated to this fix.
>     Compile testing with "make W=3D1 net/atm/lec.o" passes cleanly.
>
> Reported-by: syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Df50072212ab792c86925
> Link: https://lore.kernel.org/all/20260309093614.502094-1-kartikey406@gma=
il.com/T/ [v1]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  net/atm/lec.c | 70 +++++++++++++++++++++++++++++++++------------------
>  net/atm/lec.h |  2 +-
>  2 files changed, 46 insertions(+), 26 deletions(-)
>
> diff --git a/net/atm/lec.c b/net/atm/lec.c
> index fb93c6e1c329..32adf28663a0 100644
> --- a/net/atm/lec.c
> +++ b/net/atm/lec.c
> @@ -154,10 +154,19 @@ static void lec_handle_bridge(struct sk_buff *skb, =
struct net_device *dev)
>                                         /* 0x01 is topology change */
>
>                 priv =3D netdev_priv(dev);
> -               atm_force_charge(priv->lecd, skb2->truesize);
> -               sk =3D sk_atm(priv->lecd);
> -               skb_queue_tail(&sk->sk_receive_queue, skb2);
> -               sk->sk_data_ready(sk);
> +               struct atm_vcc *vcc;
> +
> +               rcu_read_lock();
> +               vcc =3D rcu_dereference(priv->lecd);
> +               if (vcc) {
> +                       atm_force_charge(vcc, skb2->truesize);
> +                       sk =3D sk_atm(vcc);
> +                       skb_queue_tail(&sk->sk_receive_queue, skb2);
> +                       sk->sk_data_ready(sk);
> +               } else {
> +                       dev_kfree_skb(skb2);
> +               }
> +               rcu_read_unlock();
>         }
>  }
>  #endif /* IS_ENABLED(CONFIG_BRIDGE) */
> @@ -216,7 +225,7 @@ static netdev_tx_t lec_start_xmit(struct sk_buff *skb=
,
>         int is_rdesc;
>
>         pr_debug("called\n");
> -       if (!priv->lecd) {
> +       if (!rcu_access_pointer(priv->lecd)) {
>                 pr_info("%s:No lecd attached\n", dev->name);
>                 dev->stats.tx_errors++;
>                 netif_stop_queue(dev);
> @@ -449,10 +459,19 @@ static int lec_atm_send(struct atm_vcc *vcc, struct=
 sk_buff *skb)
>                                 break;
>                         skb2->len =3D sizeof(struct atmlec_msg);
>                         skb_copy_to_linear_data(skb2, mesg, sizeof(*mesg)=
);
> -                       atm_force_charge(priv->lecd, skb2->truesize);
> -                       sk =3D sk_atm(priv->lecd);
> -                       skb_queue_tail(&sk->sk_receive_queue, skb2);
> -                       sk->sk_data_ready(sk);
> +                       struct atm_vcc *vcc;
> +
> +                       rcu_read_lock();
> +                       vcc =3D rcu_dereference(priv->lecd);
> +                       if (vcc) {
> +                               atm_force_charge(vcc, skb2->truesize);
> +                               sk =3D sk_atm(vcc);
> +                               skb_queue_tail(&sk->sk_receive_queue, skb=
2);
> +                               sk->sk_data_ready(sk);
> +                       } else {
> +                               dev_kfree_skb(skb2);
> +                       }
> +                       rcu_read_unlock();
>                 }
>         }
>  #endif /* IS_ENABLED(CONFIG_BRIDGE) */
> @@ -468,23 +486,16 @@ static int lec_atm_send(struct atm_vcc *vcc, struct=
 sk_buff *skb)
>
>  static void lec_atm_close(struct atm_vcc *vcc)
>  {
> -       struct sk_buff *skb;
>         struct net_device *dev =3D (struct net_device *)vcc->proto_data;
>         struct lec_priv *priv =3D netdev_priv(dev);
>
> -       priv->lecd =3D NULL;
> +       rcu_assign_pointer(priv->lecd, NULL);
> +       synchronize_rcu();
>         /* Do something needful? */
>
>         netif_stop_queue(dev);
>         lec_arp_destroy(priv);
>
> -       if (skb_peek(&sk_atm(vcc)->sk_receive_queue))
> -               pr_info("%s closing with messages pending\n", dev->name);
> -       while ((skb =3D skb_dequeue(&sk_atm(vcc)->sk_receive_queue))) {
> -               atm_return(vcc, skb->truesize);
> -               dev_kfree_skb(skb);
> -       }
> -
>         pr_info("%s: Shut down!\n", dev->name);
>         module_put(THIS_MODULE);
>  }
> @@ -510,12 +521,14 @@ send_to_lecd(struct lec_priv *priv, atmlec_msg_type=
 type,
>              const unsigned char *mac_addr, const unsigned char *atm_addr=
,
>              struct sk_buff *data)
>  {
> +       struct atm_vcc *vcc;
>         struct sock *sk;
>         struct sk_buff *skb;
>         struct atmlec_msg *mesg;
>
> -       if (!priv || !priv->lecd)
> +       if (!priv || !rcu_access_pointer(priv->lecd))
>                 return -1;
> +
>         skb =3D alloc_skb(sizeof(struct atmlec_msg), GFP_ATOMIC);
>         if (!skb)
>                 return -1;
> @@ -532,18 +545,27 @@ send_to_lecd(struct lec_priv *priv, atmlec_msg_type=
 type,
>         if (atm_addr)
>                 memcpy(&mesg->content.normal.atm_addr, atm_addr, ATM_ESA_=
LEN);
>
> -       atm_force_charge(priv->lecd, skb->truesize);
> -       sk =3D sk_atm(priv->lecd);
> +       rcu_read_lock();
> +       vcc =3D rcu_dereference(priv->lecd);
> +       if (!vcc) {
> +               rcu_read_unlock();
> +               kfree_skb(skb);
> +               return -1;
> +       }
> +
> +       atm_force_charge(vcc, skb->truesize);
> +       sk =3D sk_atm(vcc);
>         skb_queue_tail(&sk->sk_receive_queue, skb);
>         sk->sk_data_ready(sk);
>
>         if (data !=3D NULL) {
>                 pr_debug("about to send %d bytes of data\n", data->len);
> -               atm_force_charge(priv->lecd, data->truesize);
> +               atm_force_charge(vcc, data->truesize);
>                 skb_queue_tail(&sk->sk_receive_queue, data);
>                 sk->sk_data_ready(sk);
>         }
>
> +       rcu_read_unlock();
>         return 0;
>  }
>
> @@ -618,7 +640,7 @@ static void lec_push(struct atm_vcc *vcc, struct sk_b=
uff *skb)
>
>                 atm_return(vcc, skb->truesize);
>                 if (*(__be16 *) skb->data =3D=3D htons(priv->lecid) ||
> -                   !priv->lecd || !(dev->flags & IFF_UP)) {
> +                   !rcu_access_pointer(priv->lecd) || !(dev->flags & IFF=
_UP)) {
>                         /*
>                          * Probably looping back, or if lecd is missing,
>                          * lecd has gone down
> @@ -753,12 +775,12 @@ static int lecd_attach(struct atm_vcc *vcc, int arg=
)
>                 priv =3D netdev_priv(dev_lec[i]);
>         } else {
>                 priv =3D netdev_priv(dev_lec[i]);
> -               if (priv->lecd)
> +               if (rcu_access_pointer(priv->lecd))
>                         return -EADDRINUSE;
>         }
>         lec_arp_init(priv);
>         priv->itfnum =3D i;       /* LANE2 addition */
> -       priv->lecd =3D vcc;
> +       rcu_assign_pointer(priv->lecd, vcc);
>         vcc->dev =3D &lecatm_dev;
>         vcc_insert_socket(sk_atm(vcc));
>
> diff --git a/net/atm/lec.h b/net/atm/lec.h
> index be0e2667bd8c..ec85709bf818 100644
> --- a/net/atm/lec.h
> +++ b/net/atm/lec.h
> @@ -91,7 +91,7 @@ struct lec_priv {
>                                                  */
>         spinlock_t lec_arp_lock;
>         struct atm_vcc *mcast_vcc;              /* Default Multicast Send=
 VCC */
> -       struct atm_vcc *lecd;
> +       struct atm_vcc __rcu *lecd;
>         struct delayed_work lec_arp_work;       /* C10 */
>         unsigned int maximum_unknown_frame_count;
>                                                 /*
> --
> 2.43.0
>

Hi Eric,

Gentle ping on the v2 patch below.
Please let me know if you have any concerns.

Thanks,
Deepanshu Kartikey

