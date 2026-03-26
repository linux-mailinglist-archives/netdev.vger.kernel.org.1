Return-Path: <netdev+bounces-272101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDrVBKBKxWkU8wQAu9opvQ
	(envelope-from <netdev+bounces-272101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:02:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA6B337390
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3504301F4A0
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42183FF8B7;
	Thu, 26 Mar 2026 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VmA+Sgi+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A623FB05E
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536934; cv=pass; b=G/T4n1HhHLER6iaCPpGvoVM1MxxWixyqeV4/r1EgXxNFS8LlqBa4TJeeb9H4SCOUGqJAv9aVYc4jFp6lhjCz0oKrv1jWnHAzGIVp0gc7Suxx/ARy2+NVsY209sg5S9Al57WnGPHoTWbLAqx5I3ZQll5/Cfr0+ILp2d989w9Dju8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536934; c=relaxed/simple;
	bh=tZ0yr/CZY3LYhWiMsNShnpb27MpRn7kLmYKx9zn63ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/xExc1Ac9egmbPsZccoSVztpHL4YrOyZ+thC+3cYZyrrDfYMh32+4CicqUXYKaSoWIcBk/Mu+JCKvPEothc+isB55awfZDwugypNwwjwX0t7Jf+XDr3iaXufmYAJdo8aQPS64eMyW+FkkVqP/tT6ZaxFYsRmB9EB70IzCumupQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VmA+Sgi+; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-505a1789a27so6038731cf.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 07:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774536930; cv=none;
        d=google.com; s=arc-20240605;
        b=Nu7Y1bQujojOzG6ZBbj1fuDOII72Wm3kzuN7HrYF4Ih7mQp/e9GoM4SCluEnW+xQgW
         PWzOfaQ8WL7csVyHwNTqj4x77xduP5xx7Oyu0nUbFXfE/UruXXctuLbO77F43W+hiwjJ
         wBMA9EXGcs+hN9nkqR0yupTrrsSEQMDv5foayFt1waPxkCiEHL35xRFPn9mmCUbLwQOH
         oF9wy0ofPaR9xSNZ0zXkSRshSMxqbqRL5Qd1nihWXJHjetNC+yTXpFaotgxfhMzxDxgX
         khhpXjsAwWcufrhVuTBv+oEi0V7VNOfpX34sza4aZKdxWmv0aW3gJ+6Dkr9knQQGRj/e
         uK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yQELiFlrY5cAsCmeCqDi8o2YKzJRpE8ymDVP3+0x8ns=;
        fh=E+okvSgNM5pVOLtQytV7kD1ZlNANeDh4Tc0L9gFVHCk=;
        b=BLjtQk9oTdofWmP+pR1Vjj0wVyibdzzu1vnUl9mkTKu86L53Rq2Js16H4Sp6wpOjwm
         80f0N8SkKQ4t2pXRFBwrVmV/SxX7Olcqh2sDPpDNpbl5hRzqI+YSLr/wwbR4k2nX6bZ+
         3Yqb7a+k7YW2LGIbbmMk1xC0XXXJgDvbkCuQxBzsvAm/E2YdRYWBeg+9hoZEw4f3Eg0G
         FNAWa2WBkpwREP/uqmdLasg15ucRinfEstnTVf1It1tOL89KeOMiaSg2LOnOkH4gJUWW
         6f6ELpUZzSsj7v6r764uaxeb6I75NQPhB0cXNtnHgMgbmiyskfAHLf+BtBGk7i0N7C86
         Z3rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774536930; x=1775141730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQELiFlrY5cAsCmeCqDi8o2YKzJRpE8ymDVP3+0x8ns=;
        b=VmA+Sgi+ZF80ovDEFzG9CH/XyfvOBkqxhC/IBdi75HFcY3jtEiVB1LOKAcRC2wwV/r
         Rf28rKTSJcYVO7kaTFh0RcHef5TNsd2rI2JEuGNzpnQRa4uxXY1oPAPVbBo3yT5ZKyGO
         KQUHv2nbjNFiueMfRavSXMWq82Brr8rrhdlZ2aZSBWDq2otrWoYzFe4kDyw1jOdFmHxT
         KlHOJM94ahD7OHnMAzHT2YWDVFrkL5SlWb7cFqpz9xwfbEDGOJTc9Kl6oMPjxa+yV3Ii
         bGERYyjNP+WZudV7ljVIoCgPNOb3guhdBqs7cj15IvaVP2nLQqoxV8g1U+qXpsSGTKMG
         UHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774536930; x=1775141730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yQELiFlrY5cAsCmeCqDi8o2YKzJRpE8ymDVP3+0x8ns=;
        b=H5Svscf87aKZ++QFMf7Hwk07dS/SLbtx2mF3IdcniqomKiryw3BhkFDbdIVWNThZJF
         VK/HprbdQ950fcMLd8FVOf9LTkJwRf0y8R0v0MBsHrRa8sxfkfojrZLjAX8o3in9gA+c
         J6xQoX74lIRkhHXLSgfV+Gh+tdRofRV7ZB811n4z91xqrYz5Df/XHptbb99C6U9zyAn9
         0AHZHiR4Qs87fhD5X9yGQzO6fozRFOjSP2qV8GuISO+0l2or5T6HEBzLSkkO80jCxvvN
         l8CqB4jw9D6Ufe/5wu2rnLlVnqPL/OoghsHx7ygeQf0m2aB4zqpGrNskXiY+PTJ0BUoi
         7Zew==
X-Forwarded-Encrypted: i=1; AJvYcCUPAFl1dKnL7xzimsrcmhP8xSfSwfdzCZDRXeIkbJN9HHFMqe7cGGeDJfUFDS/xUWZLahDg69I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMkgRf0sTJ3LTHwx52DZWYasUfJNAGhij3YYpSXbT8zwPKjJMn
	JymKVyFL2e+LG625owiMJdtRWh8kvoy5thkIRVXbNOU8JNctS/HxbGDM5slpHLN5vnjansvD25I
	C4TjU0CL8zx+lXgxh4JWUgMvU9ozE7RyyRxjIGfjE
X-Gm-Gg: ATEYQzy7vqNZY+CwzIDM+p/DVFgeZ4i8vPVuxbsF+p1UWSNe8hHawL3i9Ic/PnFbHHI
	ld8dk5ZROtWIYHbPBxBcxYl/gKvVrXU2wsDW7ppWBOCuuDma3afEIp2SEwB9BLOO2IgbZHpp3Nz
	QosiPiEFxkJhseBoskocBj6sBX+uCzt2FV29ooV2ieQJbpi20dtT+Lc55TXIrrAHBgl5LaJaGAz
	/NoM6IT6mK5r5rDj2AXt4XWG9SzkkDbEFN15MqmIIwmx7dCn8e1olSd+KeCvQCtzeN+eCVUNGFu
	Eroyyk9fqlSTgX1pRh8z7VdRoaxs0evBKjnkPA==
X-Received: by 2002:a05:622a:900c:b0:509:1949:7b36 with SMTP id
 d75a77b69052e-50b80d6adfamr98705351cf.30.1774536929323; Thu, 26 Mar 2026
 07:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326144249.97213-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260326144249.97213-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Mar 2026 07:55:17 -0700
X-Gm-Features: AQROBzDH6mwfGDFLJnM_M_-H65T_AScWrH_KahstKAMiF6roZPGzr8VbYDWWgbM
Message-ID: <CANn89iL6FyoHBrfpwYSd5wPzFh3Y_1T8C6bVFuRRf7PP5p=WRw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add sysctl to toggle napi_consume_skb()
 alien skb defer
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-272101-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: AEA6B337390
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 7:43=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Commit e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
> defers freeing of alien SKBs (alloc_cpu !=3D current cpu) via
> skb_attempt_defer_free() on the TX completion path to reduce cross-NUMA
> SLUB spinlock contention to improve multi-queue UDP workloads.
>
> However, this unconditionally impacts the napi_skb_cache fast recycle
> path for single-flow / few-flow workloads (e.g. AF_XDP benchmarks[1]):
> when the TX completion NAPI CPU differs from the SKB allocation CPU,
> SKBs are deferred instead of being returned to the local napi_skb_cache,
> forcing RX allocations back to the slow slab path.
>
> The existing net.core.skb_defer_max=3D0 could disable this, but it is a
> global switch that also disables the defer mechanism in TCP/UDP/MPTCP
> recvmsg paths, losing its positive SLUB locality benefits there. AF_XDP
> can co-exist with other protocols. That's the reason why I gave up
> reusing skb_defer_disable_key. Besides, if the defer path is disabled,
> that means TCP/UDP/MPTCP in process path will trigger directly freeing
> skb with enabling/disabling bottom half(in kfree_skb_napi_cache())
> which could affect others. So my thinking is not to touch this path.
>
> Add a dedicated sysctl net.core.napi_consume_skb_defer backed by a
> static key to selectively control the alien skb defer feature. Let
> users decide which is the best fit for their own requirements.
>
> This patch also avoids touching local_bh* pair(in
> kfree_skb_napi_cache())
> to minimize the overhead.
>
> [1]: taskset -c 0 ./xdpsock -i enp2s0f1 -q 1 -t -S -s 64
> 1) sysctl -w net.core.napi_consume_skb_defer=3D1 (as default)
>  sock0@enp2s0f1:1 txonly xdp-skb
>                    pps            pkts           1.00
> rx                 0              0
> tx                 1,851,950      20,397,952
>
> 2)sysctl -w net.core.napi_consume_skb_defer=3D0
>  sock0@enp2s0f1:1 txonly xdp-skb
>                    pps            pkts           1.00
> rx                 0              0
> tx                 1,985,067      25,530,432
>
> For AF_XDP scenario, it turns out to be around 6.6% improvement.
>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  net/core/net-sysfs.h       |  1 +
>  net/core/skbuff.c          |  5 ++++-
>  net/core/sysctl_net_core.c | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/net-sysfs.h b/net/core/net-sysfs.h
> index 38e2e3ffd0bd..a026f757867e 100644
> --- a/net/core/net-sysfs.h
> +++ b/net/core/net-sysfs.h
> @@ -14,4 +14,5 @@ int netdev_change_owner(struct net_device *, const stru=
ct net *net_old,
>  extern struct mutex rps_default_mask_mutex;
>
>  DECLARE_STATIC_KEY_FALSE(skb_defer_disable_key);
> +DECLARE_STATIC_KEY_TRUE(napi_consume_skb_defer_key);
>  #endif
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 3d6978dd0aa8..3db90a9aa61d 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -94,6 +94,7 @@
>
>  #include "dev.h"
>  #include "devmem.h"
> +#include "net-sysfs.h"
>  #include "netmem_priv.h"
>  #include "sock_destructor.h"
>
> @@ -1519,7 +1520,8 @@ void napi_consume_skb(struct sk_buff *skb, int budg=
et)
>
>         DEBUG_NET_WARN_ON_ONCE(!in_softirq());
>
> -       if (skb->alloc_cpu !=3D smp_processor_id() && !skb_shared(skb)) {
> +       if (static_branch_likely(&napi_consume_skb_defer_key) &&
> +           skb->alloc_cpu !=3D smp_processor_id() && !skb_shared(skb)) {
>                 skb_release_head_state(skb);
>                 return skb_attempt_defer_free(skb);
>         }
> @@ -7257,6 +7259,7 @@ static void kfree_skb_napi_cache(struct sk_buff *sk=
b)
>  }
>
>  DEFINE_STATIC_KEY_FALSE(skb_defer_disable_key);
> +DEFINE_STATIC_KEY_TRUE(napi_consume_skb_defer_key);
>
>  /**
>   * skb_attempt_defer_free - queue skb for remote freeing
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index b508618bfc12..33e8217ee1ce 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -372,6 +372,35 @@ static int proc_do_skb_defer_max(const struct ctl_ta=
ble *table, int write,
>         return ret;
>  }
>
> +static int proc_do_napi_consume_skb_defer(const struct ctl_table *table,
> +                                         int write, void *buffer,
> +                                         size_t *lenp, loff_t *ppos)
> +{
> +       static DEFINE_MUTEX(napi_consume_skb_defer_mutex);
> +       int val, ret;
> +
> +       mutex_lock(&napi_consume_skb_defer_mutex);
> +
> +       val =3D static_key_enabled(&napi_consume_skb_defer_key);
> +       struct ctl_table tmp =3D {
> +               .data   =3D &val,
> +               .maxlen =3D sizeof(val),
> +               .extra1 =3D SYSCTL_ZERO,
> +               .extra2 =3D SYSCTL_ONE,
> +       };
> +
> +       ret =3D proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
> +       if (!ret && write) {
> +               if (val)
> +                       static_branch_enable(&napi_consume_skb_defer_key)=
;
> +               else
> +                       static_branch_disable(&napi_consume_skb_defer_key=
);
> +       }
> +
> +       mutex_unlock(&napi_consume_skb_defer_mutex);
> +       return ret;
> +}
> +

Seems a copy/paste of proc_do_static_key() ?

