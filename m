Return-Path: <netdev+bounces-280910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FH1CG7L6mk9DwAAu9opvQ
	(envelope-from <netdev+bounces-280910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:46:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1425458E6E
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5100301C174
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DE3262808;
	Fri, 24 Apr 2026 01:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rY8SuGd3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E510123909C
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776995072; cv=pass; b=G72n6DkeTGIf+HNv68VDJ/CM3kmcxH79Ra42yOzU7M8mqAvmKXJE3TQDeq0xsBFjxlX31tGEM3MgbtR+5cfM6tnT+NygfN0zrpXNUaN1AxXaEnU7ZBF05uTcKrASN8sMNet17nExgFZP8GJQJxkupkdwCnEIsueP9KSPs797ns8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776995072; c=relaxed/simple;
	bh=tcVlOrjbcu3PtjIrZ7kxEKcgKoWLnFtXfcTmbStzT2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOc5CPxBkayBZJi6BjD+kcgmkLrZ+nSo1BNUrdecCPw1ye/rYElUcTYKo0hakrbi7rw/kBgwgP4O5b8hxu+285OBrb7hmDvyyr0Am/Pb8a5VkIdN6jpARWl+gCuG2KJwZ0eX00GuD9OdFcgcP198OBFr2ZKne82qb37hdIoL5sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rY8SuGd3; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a9296b3926so42381675ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 18:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776995069; cv=none;
        d=google.com; s=arc-20240605;
        b=luvVdhKftNW3JA1T1rsTsz44lAzVxieUAB+F1hUmFltW+Ef22WHjR/TnX0GkE+aGDn
         gTh41+AMEGVMv4j9eI9C9GOD25toJZTQ/dxNq7AMTf/gNZP81RLyWkHOEvmVb/elhhvg
         67yO+6JxQVpgr+ssllbma68wpDY13w5VvOdkiGEAlA9HVXthXI27xQUGHto5v3Ye6ucc
         2K3fJOlwbuEEuSYp6jdubSELWsYrb6JhHKHmcWJl/0dWf9RoZLoboanQ15cJhY2Yg+8p
         /y7KNoY3ccflE6xpC9EdhhoXZw9UCqsSBy8yi/H2dalU4qsmoaQ4ApZcQrakeizRx7am
         AFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=smpB6TlBZbFNQosajMhgVsLYPgcW/K3bWNylQA3ACNM=;
        fh=s+ytQyAPFo6VXVGzP2g+HvAvBaqshTOCjIszbXHISsQ=;
        b=IzdJkspe5yIhkuAO+P+MkAlB+0WG/MZ9V14rQ0qnRXcQlxyEHSldvko3sDc6zp+tqy
         r/mQXRdDZoaIuGsjPjdQPjO//QbAjcynZ6S51QSmwo9/YKsl2vwij0l7Cf4m6FAfGsfK
         eRC716ULUn5pkHHNjXK9jHjFLXYeAPGw4PaDGYf/TgwQmOI6uo0hNzcp447LUNfSxQT7
         hALH+Z1ong52ziOy56g/BJ6TVfsl778hFiMXwAdzb2IFSA5LGPkPcYrZ5toL+NxszOia
         NPagly8QxxQi1NQjyGUg3j3ggG7/U2p+/ujPExPWDnRg2Xf6zTYPyrORe+qp9eNLgSWM
         T77w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776995069; x=1777599869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smpB6TlBZbFNQosajMhgVsLYPgcW/K3bWNylQA3ACNM=;
        b=rY8SuGd325k9CSzX/TkJfr5DLKjuQMmvh+pRj9UfSlowdMkYeYw+pH7pLEryIzZ9CB
         OZj464heXmDjZS+fszfwGIbN901YIP2HHB6W2v7EuKzCGZesDKObttoQ4QhfyNjcDYv+
         gjswnyowiohbQHswLmv8iDFoSpJP6EcKcvrqY4zY/04/Oxulxvdf+UkoTy1mMbYeYM/X
         qAPGIKt8Q3sJwmvOtA7tYJqkT7d9c/YWPHZQAqBus7N3UawtbezTEJgCL5NhJd3j1T9C
         Vz/I+vmxYHVh8Vsjbof+juMWB2pngtK7PZiAAxZBVonzhNcJV6mHfTqOulh3dbcjExCs
         kxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776995069; x=1777599869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=smpB6TlBZbFNQosajMhgVsLYPgcW/K3bWNylQA3ACNM=;
        b=m7mqGYkV1pKXoYshAL53+Boz/tMZwpfLf/FEKWlt14GBObajCam68TjhGu2y43ik4f
         hGWEB4ommBDjMjAT33QxpgRKN3BkGuCHLYX5QXy1zP+WqNX/sF5quLkoomgUeVuPFPli
         dDjdFejqMV5dExkO59byXNQJ7LttBFnBIDbCeibBY76FQjeoKlaqiRQwtGVGGDhaSLQQ
         g4CKnSPcUNkIYWAQH6y/GPkca3ueQSFFBIrW/2REj4SoFfr2g0uSH1jYHcluD3Jg+8uL
         g3NkpOp2GtWY3vab54CDOv7/7nfLoC9bpmgwx2r/oOnnB7erfHXrf9l7GuQC7GEor3u+
         EjKA==
X-Forwarded-Encrypted: i=1; AFNElJ83D8IVHaXPGS2IEtEWdgKd+BeBlIGZbCbRVigb6yb4/ApiwXyT93z2hlgUNMpWrHuxXISR6PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuFu4jTubWAGbQaf6q7l554BIm2CQi5zkALi6j8G2zvqmUyBBJ
	eK6HJIjB1vgWqTw4wjCFRrQw/XD2xl9Bl/5XQU4TSVge+QUOZTGqb6tDHkTxAXkfm/8H6nPKGHf
	8Nde1tKL37L67Ix5+RIt4Xu15zk92cM5Yg3g3XLrUzrAsJx1pOhRCLDnvgMEjEg==
X-Gm-Gg: AeBDieseOgB1ziPr05/LSohQ0dRQu7aNYvoxpLAN7QU80wUICli2prn0+uzZFVTHOw8
	fpvcKl49p4RKmVFEZTEhoqXEkdMPjfWS+jb28AojIcsjT7Za91PlgqxtugWG8Ui8QIb2JDRSqVq
	hD98EHXB3zqbKN7fI9QJQlKdjylrwaG/u+bbzlrW1h1/ISijdGsHFt4mDUG1qtuywdP7tS42FBe
	myD3Ukps0/Obc+lGz0+1ZNo/1M8smdckDYRFF9tRvAi5tJBMb7w+3peBx2ikm8lMitDClbqZjAM
	XSLoVgOj/E7W/N4a/rUv0rXV/qJ+QV3T63AU16XUm9XzQGxgYiQ73wG/uJDgx+3N11kd
X-Received: by 2002:a17:903:2ecc:b0:2b4:5f67:5914 with SMTP id
 d9443c01a7336-2b5f9f65423mr347836855ad.33.1776995068684; Thu, 23 Apr 2026
 18:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420171837.455487-1-hramamurthy@google.com>
 <20260420171837.455487-3-hramamurthy@google.com> <0e1c941e-dcaa-40fb-9df2-ac1db429f60a@redhat.com>
 <CAHwYsirGS1Frgtg+V7D2PB74F5gxAB8GXo+Zvss_aYbJC5LwFg@mail.gmail.com>
In-Reply-To: <CAHwYsirGS1Frgtg+V7D2PB74F5gxAB8GXo+Zvss_aYbJC5LwFg@mail.gmail.com>
From: Pin-yen Lin <treapking@google.com>
Date: Thu, 23 Apr 2026 18:44:17 -0700
X-Gm-Features: AQROBzDJZWR0M6oei0tA9R848FjEX9ScXZ6DuKnymGx1T2i8gxj3pkOEe9VuvG8
Message-ID: <CAHwYsiqW=bAusHgpZFnj0LrY_OT97y6oAJScvChq46uYXZPLdQ@mail.gmail.com>
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
X-Rspamd-Queue-Id: B1425458E6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280910-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[treapking@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Thu, Apr 23, 2026 at 6:17=E2=80=AFPM Pin-yen Lin <treapking@google.com> =
wrote:
>
> Hi Paolo,
>
> On Thu, Apr 23, 2026 at 4:47=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 4/20/26 7:18 PM, Harshitha Ramamurthy wrote:
> > > From: Debarghya Kundu <debarghyak@google.com>
> > >
> > > gve_get_base_stats() sets all the stats to 0, so the stats go backwar=
ds
> > > when interface goes down or configuration is adjusted.
> > >
> > > Fix this by persisting baseline stats across interface down.
> > >
> > > This was discovered by drivers/net/stats.py selftest.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
> > > Signed-off-by: Debarghya Kundu <debarghyak@google.com>
> > > Signed-off-by: Pin-yen Lin <treapking@google.com>
> > > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > > ---
> > >  drivers/net/ethernet/google/gve/gve.h      |  6 ++
> > >  drivers/net/ethernet/google/gve/gve_main.c | 64 +++++++++++++++++++-=
--
> > >  2 files changed, 63 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethe=
rnet/google/gve/gve.h
> > > index cbdf3a842cfe..ff7797043908 100644
> > > --- a/drivers/net/ethernet/google/gve/gve.h
> > > +++ b/drivers/net/ethernet/google/gve/gve.h
> > > @@ -794,6 +794,10 @@ struct gve_ptp {
> > >       struct gve_priv *priv;
> > >  };
> > >
> > > +struct gve_ring_err_stats {
> > > +     u64 rx_alloc_fails;
> > > +};
> > > +
> > >  struct gve_priv {
> > >       struct net_device *dev;
> > >       struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
> > > @@ -882,6 +886,8 @@ struct gve_priv {
> > >       unsigned long service_task_flags;
> > >       unsigned long state_flags;
> > >
> > > +     struct gve_ring_err_stats base_ring_err_stats;
> > > +     struct rtnl_link_stats64 base_net_stats;
> > >       struct gve_stats_report *stats_report;
> > >       u64 stats_report_len;
> > >       dma_addr_t stats_report_bus; /* dma address for the stats repor=
t */
> > > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net=
/ethernet/google/gve/gve_main.c
> > > index 675382e9756c..8617782791e0 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > > @@ -105,9 +105,22 @@ static netdev_tx_t gve_start_xmit(struct sk_buff=
 *skb, struct net_device *dev)
> > >               return gve_tx_dqo(skb, dev);
> > >  }
> > >
> > > -static void gve_get_stats(struct net_device *dev, struct rtnl_link_s=
tats64 *s)
> > > +static void gve_add_base_stats(struct gve_priv *priv,
> > > +                            struct rtnl_link_stats64 *s)
> > > +{
> > > +     struct rtnl_link_stats64 *base_stats =3D &priv->base_net_stats;
> > > +
> > > +     s->rx_packets +=3D base_stats->rx_packets;
> > > +     s->rx_bytes +=3D base_stats->rx_bytes;
> > > +     s->rx_dropped +=3D base_stats->rx_dropped;
> > > +     s->tx_packets +=3D base_stats->tx_packets;
> > > +     s->tx_bytes +=3D base_stats->tx_bytes;
> > > +     s->tx_dropped +=3D base_stats->tx_dropped;
> > > +}
>
> Sashiko says:
>
> Can this result in torn reads on 32-bit architectures?
> The base_net_stats struct accumulates 64-bit network statistics in gve_cl=
ose()
> under rtnl_lock, but these stats are read here via ndo_get_stats64 which =
can
> execute concurrently without rtnl_lock.
> On 32-bit systems, a concurrent update might result in torn reads since 6=
4-bit
> memory reads are not atomic.
> Should u64_stats_sync sequence counters or atomic types be used here?
>
> We will add u64_stats_fetch_(begin|retry) to guard this in v2.
>
> > > +
> > > +static void gve_get_ring_stats(struct gve_priv *priv,
> > > +                            struct rtnl_link_stats64 *s)
> > >  {
> > > -     struct gve_priv *priv =3D netdev_priv(dev);
> > >       unsigned int start;
> > >       u64 packets, bytes;
> > >       int num_tx_queues;
> > > @@ -142,6 +155,14 @@ static void gve_get_stats(struct net_device *dev=
, struct rtnl_link_stats64 *s)
> > >       }
> > >  }
> > >
> > > +static void gve_get_stats(struct net_device *dev, struct rtnl_link_s=
tats64 *s)
> > > +{
> > > +     struct gve_priv *priv =3D netdev_priv(dev);
> > > +
> > > +     gve_get_ring_stats(priv, s);
> > > +     gve_add_base_stats(priv, s);
> > > +}
> > > +
> > >  static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
> > >  {
> > >       struct gve_flow_rules_cache *flow_rules_cache =3D &priv->flow_r=
ules_cache;
> > > @@ -1493,6 +1514,23 @@ static int gve_queues_stop(struct gve_priv *pr=
iv)
> > >       return gve_reset_recovery(priv, false);
> > >  }
> > >
> > > +static void gve_get_ring_err_stats(struct gve_priv *priv,
> > > +                                struct gve_ring_err_stats *err_stats=
)
> > > +{
> > > +     int ring;

Another Sashiko comment:

If the interface is brought down when ring memory allocation previously
failed, could priv->rx be NULL here?
Unlike gve_get_ring_stats(), there is no check for whether priv->rx is
allocated before dereferencing it.

This will also be fixed in v2.

> > > +
> > > +     for (ring =3D 0; ring < priv->rx_cfg.num_queues; ring++) {
> > > +             unsigned int start;
> > > +             struct gve_rx_ring *rx =3D &priv->rx[ring];
> > > +
> > > +             do {
> > > +                     start =3D u64_stats_fetch_begin(&rx->statss);
> > > +                     err_stats->rx_alloc_fails +=3D
> > > +                             rx->rx_skb_alloc_fail + rx->rx_buf_allo=
c_fail;
> > > +             } while (u64_stats_fetch_retry(&rx->statss, start));
> >
> > Sashiko says:
> >
> > Could this loop improperly inflate the baseline metric by double counti=
ng?
> > If a concurrent update causes the sequence counter to change,
> > u64_stats_fetch_retry() forces the loop to restart. Because the additio=
n
> > is performed in-place on err_stats->rx_alloc_fails, the same ring's
> > error values will be added again.
> > Would it be safer to use local variables inside the retry loop and upda=
te
> > the global accumulator only after the loop completes successfully, simi=
lar
> > to the pattern established in gve_get_ring_stats()?
> >
> We'll fix this by using local variables in v2.
> >
> > > +     }
> > > +}
> > > +
> > >  static int gve_close(struct net_device *dev)
> > >  {
> > >       struct gve_priv *priv =3D netdev_priv(dev);
> > > @@ -1502,6 +1540,10 @@ static int gve_close(struct net_device *dev)
> > >       if (err)
> > >               return err;
> > >
> > > +     /* Save ring queue and err stats before closing the interface *=
/
> > > +     gve_get_ring_stats(priv, &priv->base_net_stats);
> > > +     gve_get_ring_err_stats(priv, &priv->base_ring_err_stats);
> >
> > Sashiko says:
> >
> > Does this create a temporary spike in reported statistics?
> > During gve_close(), the active ring stats are added to base_net_stats.
> > However, priv->rx and priv->tx are not set to NULL until the memory
> > teardown completes in gve_queues_mem_remove().
> > If ndo_get_stats64 is called concurrently during this window, it will
> > add both the active ring stats and the newly updated base stats togethe=
r.
> > This causes the reported statistics to temporarily double until the
> > teardown finishes.
>
> As Sashiko mentioned, this is an existing concurrency issue between
> gve_close() and gve_get_stats() (i.e., .ndo_get_stats64() callback of
> gve driver):
>
> gve_queues_mem_remove(priv);
> This is a pre-existing issue, but can this lead to a use-after-free
> during concurrent stats retrieval?
> When gve_queues_mem_remove() frees the ring memory, priv->rx and
> priv->tx are not set to NULL until after the memory is freed. If
> gve_get_stats() executes during this window, it may iterate over and
> dereference the already freed ring memory.
>
> We will send out a separate patch to fix this.
>
> >
> > Note that you are expected to proactively comment/reply on the ML to th=
e
> > concerns raised by sashiko reviews.
>
> Thanks for the reminder.
>
> >
> > Thanks,
> >
> > Paolo
> >
>
> Regards,
> Pin-yen

Regards,
Pin-yen

