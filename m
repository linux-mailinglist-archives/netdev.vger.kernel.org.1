Return-Path: <netdev+bounces-280903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN0JDMHE6mnfDQAAu9opvQ
	(envelope-from <netdev+bounces-280903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:17:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4A7458AD5
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF7CF3004D0E
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A9D21CC4F;
	Fri, 24 Apr 2026 01:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YL2ehKha"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCDA19D89E
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776993466; cv=pass; b=npwFPCxB0G+Wjp0QNYg6Ihlh8qTf0Z2fzx8bM8g+a8vC3bXdDX2Tc9vXABIZ2ATUVyfI4ajhC58yYDDaNhmH+VI1v1oq9Ki6OasdhbRUQvGjYfGk6XXN0ZSUoyf2Car+FfTQZQ+MiqTiBpvhXFijYHm4/Q9UCF9Wyfjy3nncqoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776993466; c=relaxed/simple;
	bh=BftoHye19UwN5wPCxtq1p2W/P8kKhpfmToVh3f55XT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdTfZCmqit62uwhQ/bXhG+SEBPTUSw7hbWVU4kympn8h03NuNCw++CHvCeb+1DXc/CAM3N1GWYwfnEd8KK5y9Y0Dm6VgywdzJwBmFEFKTEFKz2N/GNff4Pe0DoyOwdJZtz2WANw2Lnlv/OR4aEJH0ZPjqcuK9Esbfm5VqDjj0Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YL2ehKha; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso5836999a91.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 18:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776993464; cv=none;
        d=google.com; s=arc-20240605;
        b=UzFT8XgZdRQ5PgAs+qc0wThD0hH9432N16pvJBcKyPbSqIhZHkq2ZowsjV9pxQXxEz
         U/0zGF898V6Gzz4oj3By0EIoQzm/x/KTZJkw+awJmnoPdsPDFWQ6KTVHSUI1EqQ+y9yd
         JEmvUAQ4TfNvqqLaxfbDJiNZsiFVwtuRlRXiGJlk+h+jCl8nEC18lqEO3DvERYLdGxhu
         ZJ5CCaOO3hL7pondAtxhLnyDpULRrFRUr15iba1Ew2HK57vcMl6q8tvnOqTYuRiRDyJ8
         8mbxJ+0qsZIw/fTIH0iDRRZuety8H7WIyFYKMbYvjAswuE+CS4A59sgWMxPGdj7X/Mwr
         T4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XbrbRZqlZjolBdHvcSYKsDX1RWcNQSuhFtRf5Cy8y7Q=;
        fh=PWGdLTU5HVupY0XJX1NXxDK5tw2+ygxk1COJ4dHExq4=;
        b=h44n4jf9ywB7yQW1O4aa4HIeH044b7ozjmbTxxF437M++BvXB/8sDkYytKBS9joXGs
         VzbIALtMF30G0mQWPYpVFkqUXMWe8eWUEDsa/kuSpx9dtYTsGIkIM/P0nzchurqxoUtS
         tR5GQ2KowkhCT7e8dpS189zRFtk9C3Q69ZHa3jIcDnAum7c2esi3Q3lNObtbIDoqS6op
         ZlgT7d7scFE2BW1zvYPpVUp7RNVwksiuy9mYHmG9b7+zoHoiO59iSil2f5251ZGn8EHG
         qWdutXIHHBVtdzBeKggT61qOUo6AI8LMSAwWDbVlnnqbjv37snXCNoWVNKTb161TvJLg
         Ia3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776993464; x=1777598264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbrbRZqlZjolBdHvcSYKsDX1RWcNQSuhFtRf5Cy8y7Q=;
        b=YL2ehKhakR8hNDfU76MMFSrKoXbd7KueCelwoWuH+iovB9uhMYIozf3GB18HotRbEV
         WyAer8/OYMBbS31adhTzvlnjRSlwqd+4a+XyigfRo1UqZBYT/f/MfE8vUspngagpuURs
         WSFfcRqIgheC26v2L2rn+8naJ9HefDcQKL4We4XWL26kMZL/JQW6AH02h3YIp4WrBfJL
         SpXXQNC3vsXZgfJuHOvZqJEpc2WWN30pwf6PsD8oanwpsTVCMgrypeA2J3XOvxGRgNNr
         1sYwC/K8UevqOSXeeaf0vqdY1IV5mWDeYcuH+c4hIqTmiC/z6EGDCALAQ7k2m3IyJDXF
         qVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776993464; x=1777598264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XbrbRZqlZjolBdHvcSYKsDX1RWcNQSuhFtRf5Cy8y7Q=;
        b=jnb+HNtPNrRekpGPVz4f0v36EQ+2iSOlWz36DQH69ar9xt7sV7mcpWfkzMDAi/IiUR
         pSFkGpTA9EtrqyGczfla/Ig+2DPqJOhNHjgCNTcwcUVepeNORsuaByMi3VykY61sHdId
         XLtAvz21mpPjo+Nk9x2DP6dePBS5vOTaz7ZodokDTUYSU3I57I7Ij25lXVGQUQnAHtpj
         yQFlKFULjaYpiAIEwnDTzfVMjgRxLSsFg+FB4mktQqe4C7qjqc/5KCLSZOc0leDA6/Sd
         5c2UUVzNaILNuCDwBK8t3GfKNoImgw+C3DnpfoA37QsyIf9L7RlIFAn+NQOiJyjtyRZs
         /17Q==
X-Forwarded-Encrypted: i=1; AFNElJ+9ujJ3/zENz673BMOmGpqQ2yJbL2U3HlUn2kVhchPD+OQDBCUHfR4S9cx9VvmrQaHtVOlSJ/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3sSPuvanIUb1RMW4A+ZuwV+R/xAHbJETp0R5ZK1naLkz3tZe+
	Ayy1N2PNgX7sWPgtTzeEYeJMZSSCGRmFOrcGTmm05f7863ISvSFsMsu4qvGq0j+m9BVhSgFjJ5T
	6LUZEiGHzozye5UYYQCqEkdF/OnpbBeirRBurLr+I
X-Gm-Gg: AeBDietFjCgWfXGTA4A5n6vl5bqBvd/DdVF/S75ojdbtx0lTvybBrEWDmd4FrQPIESO
	hvcQqzpTDQwuknElCSCLeKgd5wBoaj3Nk9NhNsLluHtIIjrCDEBMRaaNIBqbnwaFyybzj0a8JkY
	AJKgilmVtfuYvHRdv9T2UGKG6phzvn+J8J9Zyf2wXIDcAieR/83THm2UMizZvpD7B2TMfNVc24A
	YRJ1iF/72bVQTg7g84KJvG5PQ2d44awtesPV9+l0Ua/txpCuCA9mhALoBu3pKDNEH7QPtIpjMKw
	9Go/v2g9sKRhC+piswAhpYsJMdapGzEv4YYDMrR49VA4Lf91NbCw11Qksg==
X-Received: by 2002:a17:90b:37cb:b0:35e:5ae3:299d with SMTP id
 98e67ed59e1d1-36140411fd9mr27495218a91.11.1776993464062; Thu, 23 Apr 2026
 18:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420171837.455487-1-hramamurthy@google.com>
 <20260420171837.455487-3-hramamurthy@google.com> <0e1c941e-dcaa-40fb-9df2-ac1db429f60a@redhat.com>
In-Reply-To: <0e1c941e-dcaa-40fb-9df2-ac1db429f60a@redhat.com>
From: Pin-yen Lin <treapking@google.com>
Date: Thu, 23 Apr 2026 18:17:33 -0700
X-Gm-Features: AQROBzAk58ugy1joaMi2IsclXN8MCjWFpwU7EESqk4pj8krP7OelctOEa9CjLNI
Message-ID: <CAHwYsirGS1Frgtg+V7D2PB74F5gxAB8GXo+Zvss_aYbJC5LwFg@mail.gmail.com>
Subject: Re: [PATCH net 2/4] gve: Fix backward stats when interface goes down
 or configuration is adjusted
To: Paolo Abeni <pabeni@redhat.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, maolson@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, jacob.e.keller@intel.com, 
	pkaligineedi@google.com, shailend@google.com, jordanrhee@google.com, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Debarghya Kundu <debarghyak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1D4A7458AD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280903-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[treapking@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[]

Hi Paolo,

On Thu, Apr 23, 2026 at 4:47=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 4/20/26 7:18 PM, Harshitha Ramamurthy wrote:
> > From: Debarghya Kundu <debarghyak@google.com>
> >
> > gve_get_base_stats() sets all the stats to 0, so the stats go backwards
> > when interface goes down or configuration is adjusted.
> >
> > Fix this by persisting baseline stats across interface down.
> >
> > This was discovered by drivers/net/stats.py selftest.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
> > Signed-off-by: Debarghya Kundu <debarghyak@google.com>
> > Signed-off-by: Pin-yen Lin <treapking@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve.h      |  6 ++
> >  drivers/net/ethernet/google/gve/gve_main.c | 64 +++++++++++++++++++---
> >  2 files changed, 63 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index cbdf3a842cfe..ff7797043908 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -794,6 +794,10 @@ struct gve_ptp {
> >       struct gve_priv *priv;
> >  };
> >
> > +struct gve_ring_err_stats {
> > +     u64 rx_alloc_fails;
> > +};
> > +
> >  struct gve_priv {
> >       struct net_device *dev;
> >       struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
> > @@ -882,6 +886,8 @@ struct gve_priv {
> >       unsigned long service_task_flags;
> >       unsigned long state_flags;
> >
> > +     struct gve_ring_err_stats base_ring_err_stats;
> > +     struct rtnl_link_stats64 base_net_stats;
> >       struct gve_stats_report *stats_report;
> >       u64 stats_report_len;
> >       dma_addr_t stats_report_bus; /* dma address for the stats report =
*/
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 675382e9756c..8617782791e0 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -105,9 +105,22 @@ static netdev_tx_t gve_start_xmit(struct sk_buff *=
skb, struct net_device *dev)
> >               return gve_tx_dqo(skb, dev);
> >  }
> >
> > -static void gve_get_stats(struct net_device *dev, struct rtnl_link_sta=
ts64 *s)
> > +static void gve_add_base_stats(struct gve_priv *priv,
> > +                            struct rtnl_link_stats64 *s)
> > +{
> > +     struct rtnl_link_stats64 *base_stats =3D &priv->base_net_stats;
> > +
> > +     s->rx_packets +=3D base_stats->rx_packets;
> > +     s->rx_bytes +=3D base_stats->rx_bytes;
> > +     s->rx_dropped +=3D base_stats->rx_dropped;
> > +     s->tx_packets +=3D base_stats->tx_packets;
> > +     s->tx_bytes +=3D base_stats->tx_bytes;
> > +     s->tx_dropped +=3D base_stats->tx_dropped;
> > +}

Sashiko says:

Can this result in torn reads on 32-bit architectures?
The base_net_stats struct accumulates 64-bit network statistics in gve_clos=
e()
under rtnl_lock, but these stats are read here via ndo_get_stats64 which ca=
n
execute concurrently without rtnl_lock.
On 32-bit systems, a concurrent update might result in torn reads since 64-=
bit
memory reads are not atomic.
Should u64_stats_sync sequence counters or atomic types be used here?

We will add u64_stats_fetch_(begin|retry) to guard this in v2.

> > +
> > +static void gve_get_ring_stats(struct gve_priv *priv,
> > +                            struct rtnl_link_stats64 *s)
> >  {
> > -     struct gve_priv *priv =3D netdev_priv(dev);
> >       unsigned int start;
> >       u64 packets, bytes;
> >       int num_tx_queues;
> > @@ -142,6 +155,14 @@ static void gve_get_stats(struct net_device *dev, =
struct rtnl_link_stats64 *s)
> >       }
> >  }
> >
> > +static void gve_get_stats(struct net_device *dev, struct rtnl_link_sta=
ts64 *s)
> > +{
> > +     struct gve_priv *priv =3D netdev_priv(dev);
> > +
> > +     gve_get_ring_stats(priv, s);
> > +     gve_add_base_stats(priv, s);
> > +}
> > +
> >  static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
> >  {
> >       struct gve_flow_rules_cache *flow_rules_cache =3D &priv->flow_rul=
es_cache;
> > @@ -1493,6 +1514,23 @@ static int gve_queues_stop(struct gve_priv *priv=
)
> >       return gve_reset_recovery(priv, false);
> >  }
> >
> > +static void gve_get_ring_err_stats(struct gve_priv *priv,
> > +                                struct gve_ring_err_stats *err_stats)
> > +{
> > +     int ring;
> > +
> > +     for (ring =3D 0; ring < priv->rx_cfg.num_queues; ring++) {
> > +             unsigned int start;
> > +             struct gve_rx_ring *rx =3D &priv->rx[ring];
> > +
> > +             do {
> > +                     start =3D u64_stats_fetch_begin(&rx->statss);
> > +                     err_stats->rx_alloc_fails +=3D
> > +                             rx->rx_skb_alloc_fail + rx->rx_buf_alloc_=
fail;
> > +             } while (u64_stats_fetch_retry(&rx->statss, start));
>
> Sashiko says:
>
> Could this loop improperly inflate the baseline metric by double counting=
?
> If a concurrent update causes the sequence counter to change,
> u64_stats_fetch_retry() forces the loop to restart. Because the addition
> is performed in-place on err_stats->rx_alloc_fails, the same ring's
> error values will be added again.
> Would it be safer to use local variables inside the retry loop and update
> the global accumulator only after the loop completes successfully, simila=
r
> to the pattern established in gve_get_ring_stats()?
>
We'll fix this by using local variables in v2.
>
> > +     }
> > +}
> > +
> >  static int gve_close(struct net_device *dev)
> >  {
> >       struct gve_priv *priv =3D netdev_priv(dev);
> > @@ -1502,6 +1540,10 @@ static int gve_close(struct net_device *dev)
> >       if (err)
> >               return err;
> >
> > +     /* Save ring queue and err stats before closing the interface */
> > +     gve_get_ring_stats(priv, &priv->base_net_stats);
> > +     gve_get_ring_err_stats(priv, &priv->base_ring_err_stats);
>
> Sashiko says:
>
> Does this create a temporary spike in reported statistics?
> During gve_close(), the active ring stats are added to base_net_stats.
> However, priv->rx and priv->tx are not set to NULL until the memory
> teardown completes in gve_queues_mem_remove().
> If ndo_get_stats64 is called concurrently during this window, it will
> add both the active ring stats and the newly updated base stats together.
> This causes the reported statistics to temporarily double until the
> teardown finishes.

As Sashiko mentioned, this is an existing concurrency issue between
gve_close() and gve_get_stats() (i.e., .ndo_get_stats64() callback of
gve driver):

gve_queues_mem_remove(priv);
This is a pre-existing issue, but can this lead to a use-after-free
during concurrent stats retrieval?
When gve_queues_mem_remove() frees the ring memory, priv->rx and
priv->tx are not set to NULL until after the memory is freed. If
gve_get_stats() executes during this window, it may iterate over and
dereference the already freed ring memory.

We will send out a separate patch to fix this.

>
> Note that you are expected to proactively comment/reply on the ML to the
> concerns raised by sashiko reviews.

Thanks for the reminder.

>
> Thanks,
>
> Paolo
>

Regards,
Pin-yen

