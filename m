Return-Path: <netdev+bounces-272130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLIgChBexWlM9wQAu9opvQ
	(envelope-from <netdev+bounces-272130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:25:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C4D338585
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E6DF308B9CE
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF793405AC1;
	Thu, 26 Mar 2026 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKJtRJtX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37112379EDC
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542104; cv=pass; b=FbRIccbJXYih06h5gvQNRtPTD1XPQ/0UcrXe30/p5t7K0tCgpg+vV3wrq1kD/nOYa8wW2d6wmrtqtmd1e9eqJPHayEarTlUyyhArn00JUcdslL0hFb1Unb2TRbYBY+xthmv7s7YLbvxPVP580f59oKujtd9NfPgzrtQ82bG3Md8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542104; c=relaxed/simple;
	bh=IdE26osVi2GGbKMFg8DCx7SRVYH7IgJiBHlOPnH7las=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BokLvzHCH3wVzGXitARGKt6mumERA4fdStRHDhPA8lvxXTLOE61jKR/c7qIucDPLbI+ajf5jeasF2TmapZx8IxCYhF0bsqTwWZCbS+bHM6+6ORhh7AWeD001wGEzCFvq7wMJoVZ0Fe2GrdlqHN1FgpVHTgx4buOxdC9uPeVvqzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKJtRJtX; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c0c955a481so2477166eec.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542102; cv=none;
        d=google.com; s=arc-20240605;
        b=fqjQHpeqyBE8t3nGZ+BX8UBpYRAzxxnYd3UrGQZNS7O9wa/B6hW0PDeRLa1jIPBuYi
         U0J+KEdecuohWv4sn1Vnt+DIXX2xtgACzFM1EK6+LpQiT99G/yPbh3c9Hf/W2+HKzr8U
         TRCPbUCA1N0YSy52oZOEpN5UdNIAtCcV2OJhVZK8E/ygti/x0rXiH6xhn83/Uyg5MNTR
         L76etK7ZaO4kFrPzimKYp8tb9bPiG0JXx1wRbRo5SQ1Lg97qTBt4bDTswkyAi6vHaqa8
         uEgQdORs6ooDLJQD/EF6qOgpXz2cGSfpRLMYgiaV8/rToQHnUoFu/vLBCt7GwwNUeQhs
         RqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7iq6U5FJ+ZHUMCCitzN/cmPf/HccBLSMGS1zhQZMmdE=;
        fh=H8oqCNLR9MJBNt0bs/RbZmTVcJYETnHvxvhIEnqdJw4=;
        b=d0orngt4/qTRCu+Np+HBRXnYC2ywhwYCYvKGPwH0pZhEnStDfVkeSLbLIqK4Umwp3E
         z73KKYNvr3TvxWNyfukM/DRwK8QvalFvHgj99QbzA1c94Gjhzsu/blsxBuENP32BF1HY
         PF/xgXXXk+7wlEB0dzsIgtqzGJaffkSqqHcEArLqTHB2P/3wC8U6ataInlzUV1gJIQRw
         AAg+6Gb8KsMad8f4YKMNyJP33A/iZzhjK4eYFjBkWQECru5sc7j8LasFp3Dl3gYeGyeQ
         uxXeY9Ef2Of+KyjeTx9oaS50rntwgd7GNJ3W9GyRMsvQc4Dg2N+ixSXPPItlEgpDQnMO
         s78A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774542102; x=1775146902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iq6U5FJ+ZHUMCCitzN/cmPf/HccBLSMGS1zhQZMmdE=;
        b=RKJtRJtX/U71CrrY+bDHkRxIHx2Ksbr8hQBRadQBYhg4oZQrlydbsJKFXoW/1+Lr+u
         e9Sb3Qhhb49Cxg34SEiL6g01sbZGSL5c6hHLeqyuD9YK2GgvYYhoRamkqywxfTu+C+6O
         +5l3hMnPW/49k7b8FymAndGXoBGwOvxIJYJbVV0zXQ9KhWgExJkEjDSfAi/+Az0B6shF
         s6XxX57+s/9/UxwRR4eG4mLW+rflR8pA2uFE/DhGXFSAklg7kT3uXoPOdm00/fjUMsYA
         X3IH+20zHi2Z1k3ngGgKCfoBmSfsYhAealy4emUZXH5q6fCxzyZSiSloskrXbzzGBvKY
         bkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542102; x=1775146902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7iq6U5FJ+ZHUMCCitzN/cmPf/HccBLSMGS1zhQZMmdE=;
        b=JZnHe9/bCXIfhZ2440hEB+n9vpKT4Sq1Lt72D7Mq/DEKd2wdlaDnwDG9DYNMj3E8KO
         raAYeoRhszmJiMt2qujLk0LAZoMW5WHHrnkjt6CdS+wZM1Yd4jKnFlUU60P3eNY66Bip
         DpjgxeqRA5/GHdOTtAPrEh9dKraGN7kGlpAhud+Q3qwAt8IPJIBAS3O2PbqeB/U1HIWA
         U1dgNR3v1ypHMx4qWF0b/Ii6B3szXVTN+moaOh7/kT6/ctFHEZL8CaYpbbpge2NKvQ1R
         Qrq1rgPMleDnAk2HlAcFD4oToQZ+HkW8ROHABdIKv6SSL5DdsoG96fGBFj6z9m47uEAg
         A6Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWtG+i2FK+SqJVPWohAMRCaFquu6/RtQiAmSfVE25nCj5bdoJhbGvZ6ggyWLsVVfmQ8ZBdqN2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOWjaUI2wV+WunRYHUW6U0iNw+JOxubcTvfPxMq4tTwJ7Jrh52
	udgtMnWJHVnr2c+p+OvrNPTjqWTef0HhO/ip9gH7AjD9uboz8mV+S53GOOe10bvJpFOMagbEMxz
	N3DmxomynNxF72k+gC2pETW5uyfDEB50=
X-Gm-Gg: ATEYQzx4tSw9cWUZmNQ8uY3oonkq1SSfSMKtbVy0ekAnOwt46LO3xvsILXh56rDvPrc
	drofKqz6Es/zTzOqVskydZRJ5MvWae2Wl37t9/8fRfeV9ju1fyjpCzJ/4ZReD2sQTn2QLXBYviK
	M0MULkzxNn4KCRDmobTIFVF80LvcVsOhqURdtHDpm+ajeUNPxveYG9ojbRfoSQcpJOFr2R4eRo/
	YbswgZpBTZpszsd9RSvQqHaAkQhTVa2rddGIIdEeuWws+6jtIwplPFugn82gFF7K+1rkvL12YW1
	r5Rzsjk=
X-Received: by 2002:a05:7300:3205:b0:2c1:27c:75bd with SMTP id
 5a478bee46e88-2c15d0ea50amr4880949eec.0.1774542102180; Thu, 26 Mar 2026
 09:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326144249.97213-1-kerneljasonxing@gmail.com> <CANn89iL6FyoHBrfpwYSd5wPzFh3Y_1T8C6bVFuRRf7PP5p=WRw@mail.gmail.com>
In-Reply-To: <CANn89iL6FyoHBrfpwYSd5wPzFh3Y_1T8C6bVFuRRf7PP5p=WRw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 27 Mar 2026 00:21:02 +0800
X-Gm-Features: AQROBzBSyqhpaarw0ZXfgCbR56nFJd8ZbBaOn_hjnQ3oaBznezYa7nBgkKhxrdM
Message-ID: <CAL+tcoBL5+qSQhz8BO0ozOoEE0EgPpaoaPvp455e+gqrRyrEUQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add sysctl to toggle napi_consume_skb()
 alien skb defer
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272130-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MAILSPIKE_FAIL(0.00)[172.232.135.74:server fail];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,enp2s0f1:email]
X-Rspamd-Queue-Id: 85C4D338585
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:55=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Mar 26, 2026 at 7:43=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Commit e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
> > defers freeing of alien SKBs (alloc_cpu !=3D current cpu) via
> > skb_attempt_defer_free() on the TX completion path to reduce cross-NUMA
> > SLUB spinlock contention to improve multi-queue UDP workloads.
> >
> > However, this unconditionally impacts the napi_skb_cache fast recycle
> > path for single-flow / few-flow workloads (e.g. AF_XDP benchmarks[1]):
> > when the TX completion NAPI CPU differs from the SKB allocation CPU,
> > SKBs are deferred instead of being returned to the local napi_skb_cache=
,
> > forcing RX allocations back to the slow slab path.
> >
> > The existing net.core.skb_defer_max=3D0 could disable this, but it is a
> > global switch that also disables the defer mechanism in TCP/UDP/MPTCP
> > recvmsg paths, losing its positive SLUB locality benefits there. AF_XDP
> > can co-exist with other protocols. That's the reason why I gave up
> > reusing skb_defer_disable_key. Besides, if the defer path is disabled,
> > that means TCP/UDP/MPTCP in process path will trigger directly freeing
> > skb with enabling/disabling bottom half(in kfree_skb_napi_cache())
> > which could affect others. So my thinking is not to touch this path.
> >
> > Add a dedicated sysctl net.core.napi_consume_skb_defer backed by a
> > static key to selectively control the alien skb defer feature. Let
> > users decide which is the best fit for their own requirements.
> >
> > This patch also avoids touching local_bh* pair(in
> > kfree_skb_napi_cache())
> > to minimize the overhead.
> >
> > [1]: taskset -c 0 ./xdpsock -i enp2s0f1 -q 1 -t -S -s 64
> > 1) sysctl -w net.core.napi_consume_skb_defer=3D1 (as default)
> >  sock0@enp2s0f1:1 txonly xdp-skb
> >                    pps            pkts           1.00
> > rx                 0              0
> > tx                 1,851,950      20,397,952
> >
> > 2)sysctl -w net.core.napi_consume_skb_defer=3D0
> >  sock0@enp2s0f1:1 txonly xdp-skb
> >                    pps            pkts           1.00
> > rx                 0              0
> > tx                 1,985,067      25,530,432
> >
> > For AF_XDP scenario, it turns out to be around 6.6% improvement.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  net/core/net-sysfs.h       |  1 +
> >  net/core/skbuff.c          |  5 ++++-
> >  net/core/sysctl_net_core.c | 35 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/net-sysfs.h b/net/core/net-sysfs.h
> > index 38e2e3ffd0bd..a026f757867e 100644
> > --- a/net/core/net-sysfs.h
> > +++ b/net/core/net-sysfs.h
> > @@ -14,4 +14,5 @@ int netdev_change_owner(struct net_device *, const st=
ruct net *net_old,
> >  extern struct mutex rps_default_mask_mutex;
> >
> >  DECLARE_STATIC_KEY_FALSE(skb_defer_disable_key);
> > +DECLARE_STATIC_KEY_TRUE(napi_consume_skb_defer_key);
> >  #endif
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 3d6978dd0aa8..3db90a9aa61d 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -94,6 +94,7 @@
> >
> >  #include "dev.h"
> >  #include "devmem.h"
> > +#include "net-sysfs.h"
> >  #include "netmem_priv.h"
> >  #include "sock_destructor.h"
> >
> > @@ -1519,7 +1520,8 @@ void napi_consume_skb(struct sk_buff *skb, int bu=
dget)
> >
> >         DEBUG_NET_WARN_ON_ONCE(!in_softirq());
> >
> > -       if (skb->alloc_cpu !=3D smp_processor_id() && !skb_shared(skb))=
 {
> > +       if (static_branch_likely(&napi_consume_skb_defer_key) &&
> > +           skb->alloc_cpu !=3D smp_processor_id() && !skb_shared(skb))=
 {
> >                 skb_release_head_state(skb);
> >                 return skb_attempt_defer_free(skb);
> >         }
> > @@ -7257,6 +7259,7 @@ static void kfree_skb_napi_cache(struct sk_buff *=
skb)
> >  }
> >
> >  DEFINE_STATIC_KEY_FALSE(skb_defer_disable_key);
> > +DEFINE_STATIC_KEY_TRUE(napi_consume_skb_defer_key);
> >
> >  /**
> >   * skb_attempt_defer_free - queue skb for remote freeing
> > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > index b508618bfc12..33e8217ee1ce 100644
> > --- a/net/core/sysctl_net_core.c
> > +++ b/net/core/sysctl_net_core.c
> > @@ -372,6 +372,35 @@ static int proc_do_skb_defer_max(const struct ctl_=
table *table, int write,
> >         return ret;
> >  }
> >
> > +static int proc_do_napi_consume_skb_defer(const struct ctl_table *tabl=
e,
> > +                                         int write, void *buffer,
> > +                                         size_t *lenp, loff_t *ppos)
> > +{
> > +       static DEFINE_MUTEX(napi_consume_skb_defer_mutex);
> > +       int val, ret;
> > +
> > +       mutex_lock(&napi_consume_skb_defer_mutex);
> > +
> > +       val =3D static_key_enabled(&napi_consume_skb_defer_key);
> > +       struct ctl_table tmp =3D {
> > +               .data   =3D &val,
> > +               .maxlen =3D sizeof(val),
> > +               .extra1 =3D SYSCTL_ZERO,
> > +               .extra2 =3D SYSCTL_ONE,
> > +       };
> > +
> > +       ret =3D proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
> > +       if (!ret && write) {
> > +               if (val)
> > +                       static_branch_enable(&napi_consume_skb_defer_ke=
y);
> > +               else
> > +                       static_branch_disable(&napi_consume_skb_defer_k=
ey);
> > +       }
> > +
> > +       mutex_unlock(&napi_consume_skb_defer_mutex);
> > +       return ret;
> > +}
> > +
>
> Seems a copy/paste of proc_do_static_key() ?

Thanks, Eric. Much simpler right now:
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index b508618bfc12..a6a1b2c3f8e1 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -676,6 +676,16 @@ static struct ctl_table net_core_table[] =3D {
                .proc_handler   =3D proc_do_skb_defer_max,
                .extra1         =3D SYSCTL_ZERO,
        },
+       {
+               .procname       =3D "napi_consume_skb_defer",
+               .data           =3D &napi_consume_skb_defer_key.key,
+               .maxlen         =3D sizeof(napi_consume_skb_defer_key),
+               .mode           =3D 0644,
+               .proc_handler   =3D proc_do_static_key,
+       },
 };

I will post it then after more tests tomorrow morning :)

Thanks,
Jason

