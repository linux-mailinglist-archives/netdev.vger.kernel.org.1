Return-Path: <netdev+bounces-265248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFWjFmQxrWl1zQEAu9opvQ
	(envelope-from <netdev+bounces-265248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 09:20:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEEE22F05C
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 09:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B76C230074EE
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 08:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E2F35F169;
	Sun,  8 Mar 2026 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaWn5wlD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA8A35F16A
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772958045; cv=pass; b=eXqj/Pzn/nwfxJnq5m2u+NIXVSz5mgPkq/3EY2yoPHvQb+RETGvzu+1xm3ELBUgzDgdWl2v/Ak4NgrHtPSE6tKA6pBlzzhIQNhaT+t3zghYD3iVO22vQBybOGfKSPijG4qYDwaFXs2we1PEWtNpcVX4yzJb7dqoxqtgqWF6Y9ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772958045; c=relaxed/simple;
	bh=O2G/bkfsud423MmsppQXKc+ycMoO20aFsuHK3LCDSms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Njio48zWgC6cHzLrtcm7rNvA/3ab1IH5YaJp41fKgT+VTjpgoVVnRkD4fJtANAV+jCslgIRJlFD1n8tPKMd8jrlNTonA5SXWCHTcTHz6AkVaLEbcxKkbPWbWnyFTCrwZmwDTk4MPmQmd8cCaLFG4iyLRytacYXLfxwbChM1uVFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaWn5wlD; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3598df39444so4472364a91.2
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 00:20:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772958043; cv=none;
        d=google.com; s=arc-20240605;
        b=Zpg35irQhSrXYUs3WQkG7HMh4xEcnqVikTeoAY3RLJlYNM9rQPmf56N/hKoJNNVq6h
         +cBJ+37Az4V4fDwAp+UkVSNYGSZMSoUXZzb3KlOYxvO5G08izNguxRGdFjvNG6asnYvK
         HduJYvw+CT/qL56ukvO0gOUrQsxlBb0h3r9doDCzfl/XjThoIlVORZruM/uUbpOJoiDr
         vqozpRgobjI3ehR2Cy+Xt8qnTSuSbObLO6JlB3SENgKFvZYmW6upnYqzwqsDbXOUVakM
         W1xHTS91lcZ057eYNhARAHxog47c1eZIiLABoVKKsC+sN7DruUtWpsKuoHOD8RFsqTVR
         +IXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lxw2yV7ExBCkr6Opf3XJKAnjnMc+8VXZSgtjVb/aJRo=;
        fh=jj0krVOL48i/LPqZlhWj5NnEAXBY2wSmRBDFGC+Yywg=;
        b=jPFp8wKsr37MgW4hstVOolcC4CD1wcl8mD9s1Ed/Mik0ayWOPjWqyQ9EC518h0P9hT
         k3UU4EaLGwSsRkV3vVwrdlamAuGgGS4oKb0o1xn8zU6KQgO0dUikyZmRKNQejUxpcDR+
         Za6mej5y5Ta1n7TrEfAaTqHQbFhR/XQrYq799d5nIvagu2BhV813lCdBhRj48rpTwb5s
         LFSYlTHFA4sep3kfCWK/nr6gQnwtAlnvTtoZGT25UXksZ/QFvnKRLNcxrvMSeZJ1B/WM
         Pk9LC7yDV/20Orf+2xw8SKnca7GWzbFozDtoltPr2VD3DH6KL4yz2vwenAhaqeOoJnCe
         OeAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772958043; x=1773562843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxw2yV7ExBCkr6Opf3XJKAnjnMc+8VXZSgtjVb/aJRo=;
        b=YaWn5wlD4T8o1iBhG7gdk8HKKvv8NqqNaDu7tyyrcij2xpXL/fQFpfppHmZRUk3JRA
         sIdoyqsRPd4gaaQ8Cuj2AYaywoT0QGo6CEM8PXiXkgpNb1QS3Td5zHb794JtkY1cOysD
         vdy/X0F5AAC3ex9ajR8ExYlzNlUWEEe2avqdE3XC2ywL6ume0nvK9WL/CaZ/lg3DI0U+
         CLXZbTxoVA6gDD8dnVEYaPJDCcvdhhxdlKX3l0qQJpLqxU+SLFxxv2GdTAAk5qo5NS+v
         hBoiK4T6ey/2ooC3RkN0wZ5m2kbhac5cYb4m+CY2ycTLiYGRb8MxTSCCTApvr7buxApx
         lQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772958043; x=1773562843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lxw2yV7ExBCkr6Opf3XJKAnjnMc+8VXZSgtjVb/aJRo=;
        b=HzjjIy+W7U2n9uRB8vu6ujzMo9Zd3oTV4hYJRZW2Kx9zzG550I8DwuKd59Y4i5Qy9p
         JVANSdje6rpARJHwXduesXdN9pCe3dO1uRtQ2a+OhTjqavwQX3pfnfbp7kzE+EoXc3Zz
         hIrxUZ74ULB+kdjKWOqLUDhUFdYsif0wBEZEhxl5AaEthk7Ly+idVej6dyP1Y7Vx5mUO
         ikV5c/VEEKKKSik81ubsteZq1qIwr/DM+tAzxJXNPRxAMcEwHbpia/HfLJIUHq0M4v4T
         T7nFvfBKNvlRlt4mj0waL78JXTlSnQjhInB6xxhAcmEgywOD88sJGjlaySG2yhsIay+Q
         sa2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpDRwk6DdYAS/fHbzmbg+1oigagLpIflADwmgeGFpEU4bZkUEQS+QAUipMv6dCyza8ChRH5tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzowviY5e5l+dreIZezOPrUGrScCHg6FjzsQDj6ZPse8PcfjomX
	TzUkiGBHtF0X9ynOHyNCIXaw54YL2v+fgbpBLSonHt+HvN18XOVAPEaQ4uJOPVCASsoUi2rx0no
	3R1k2FzCYVXuQG8qyqAgh4tGpvj8d9Bg=
X-Gm-Gg: ATEYQzyaCo+4feiws1nMsK3+rfT/3KFWHfXUTDGBI1uM+hE0jd52ryBlJnB3e/XTA1h
	0hvQVutptLGLj2167GTAP5R3LQ1FHdSGWGp6IW7XS2LQ0dMqJBpIx1aX8I6w1yqEtmNGXO2ywDw
	svRMglVsuz2GZFrp81wJoN55EE7J0JydsKpsvU1igB6B21FLKLHCrfNkm5rsi7BE+1R0bDpfoVg
	44H5sPLqqleInjT2qcLRRulA8qLaZ7+/qkRH2xpEoYXkSwdP5bw6AruAJO7vE2RAI9h0dXwgsu4
	lnlv8ShT
X-Received: by 2002:a17:90b:240e:b0:359:c7ef:97bc with SMTP id
 98e67ed59e1d1-359c7ef9b32mr3016172a91.22.1772958043117; Sun, 08 Mar 2026
 00:20:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308070925.58939-1-nashuiliang@gmail.com> <CANn89iJYiyp4dwA+Ye=7ySgQZaPnL=XfoQ4S4eXM-gs3pP+keA@mail.gmail.com>
In-Reply-To: <CANn89iJYiyp4dwA+Ye=7ySgQZaPnL=XfoQ4S4eXM-gs3pP+keA@mail.gmail.com>
From: chuang <nashuiliang@gmail.com>
Date: Sun, 8 Mar 2026 16:20:31 +0800
X-Gm-Features: AaiRm53zKEEa72ne44DdeX45TbxT5T1UmO7VHS3nnSgRPmNEu3XSj31cK8zOSj8
Message-ID: <CACueBy4KyU8DjwtLM6pzjQNTbiy2M+ZhZdO7Ag=ssqWq00CJ7w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: reduce RFS/ARFS flow updates by checking
 LLC affinity
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4BEEE22F05C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265248-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,fomichev.me,google.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.957];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nashuiliang@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

On Sun, Mar 8, 2026 at 3:19=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Sun, Mar 8, 2026 at 8:10=E2=80=AFAM Chuang Wang <nashuiliang@gmail.com=
> wrote:
> >
> > The current implementation of rps_record_sock_flow() updates the flow
> > table every time a socket is processed on a different CPU. In high-load
> > scenarios, especially with Accelerated RFS (ARFS), this triggers
> > frequent flow steering updates via ndo_rx_flow_steer.
> >
> > For drivers like mlx5 that implement hardware flow steering, these
> > constant updates lead to significant contention on internal driver lock=
s
> > (e.g., arfs_lock). This contention often becomes a performance
> > bottleneck that outweighs the steering benefits.
> >
> > This patch introduces a cache-aware update strategy: the flow record is
> > only updated if the flow migrates across Last Level Cache (LLC)
> > boundaries. This minimizes expensive hardware reconfigurations while
> > preserving cache locality for the application.
> >
> > Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> > ---
> >  include/net/rps.h | 17 +--------------
> >  net/core/dev.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 55 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/net/rps.h b/include/net/rps.h
> > index e33c6a2fa8bb..2cd8698a79d5 100644
> > --- a/include/net/rps.h
> > +++ b/include/net/rps.h
> > @@ -55,22 +55,7 @@ struct rps_sock_flow_table {
> >
> >  #define RPS_NO_CPU 0xffff
> >
> > -static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
> > -{
> > -       unsigned int index =3D hash & rps_tag_to_mask(tag_ptr);
> > -       u32 val =3D hash & ~net_hotdata.rps_cpu_mask;
> > -       struct rps_sock_flow_table *table;
> > -
> > -       /* We only give a hint, preemption can change CPU under us */
> > -       val |=3D raw_smp_processor_id();
> > -
> > -       table =3D rps_tag_to_table(tag_ptr);
> > -       /* The following WRITE_ONCE() is paired with the READ_ONCE()
> > -        * here, and another one in get_rps_cpu().
> > -        */
> > -       if (READ_ONCE(table[index].ent) !=3D val)
> > -               WRITE_ONCE(table[index].ent, val);
> > -}
> > +void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash);
> >
> >  static inline void _sock_rps_record_flow_hash(__u32 hash)
> >  {
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 203dc36aaed5..770cfb6fe06b 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -5175,6 +5175,60 @@ static int get_rps_cpu(struct net_device *dev, s=
truct sk_buff *skb,
> >         return cpu;
> >  }
> >
> > +/**
> > + * rps_record_cond - Determine if RPS flow table should be updated
> > + * @old_val: Previous flow record value
> > + * @new_val: Target flow record value
> > + *
> > + * Returns true if the record needs an update.
> > + */
> > +static inline bool rps_record_cond(u32 old_val, u32 new_val)
> > +{
> > +       u32 old_cpu =3D old_val & ~net_hotdata.rps_cpu_mask;
> > +       u32 new_cpu =3D new_val & ~net_hotdata.rps_cpu_mask;
> > +
> > +       if (old_val =3D=3D new_val)
> > +               return false;
> > +
> > +       /* Force update if the recorded CPU is invalid or has gone offl=
ine */
> > +       if (old_cpu >=3D nr_cpu_ids || !cpu_active(old_cpu))
> > +               return true;
> > +
> > +       /*
> > +        * Force an update if the current task is no longer permitted
> > +        * to run on the old_cpu.
> > +        */
> > +       if (!cpumask_test_cpu(old_cpu, current->cpus_ptr))
> > +               return true;
> > +
> > +       /*
> > +        * If CPUs do not share a cache, allow the update to prevent
> > +        * expensive remote memory accesses and cache misses.
> > +        */
> > +       if (!cpus_share_cache(old_cpu, new_cpu))
> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> > +void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
> > +{
> > +       unsigned int index =3D hash & rps_tag_to_mask(tag_ptr);
> > +       u32 val =3D hash & ~net_hotdata.rps_cpu_mask;
> > +       struct rps_sock_flow_table *table;
> > +
> > +       /* We only give a hint, preemption can change CPU under us */
> > +       val |=3D raw_smp_processor_id();
> > +
> > +       table =3D rps_tag_to_table(tag_ptr);
> > +       /* The following WRITE_ONCE() is paired with the READ_ONCE()
> > +        * here, and another one in get_rps_cpu().
> > +        */
> > +       if (rps_record_cond(READ_ONCE(table[index].ent), val))
> > +               WRITE_ONCE(table[index].ent, val);
> > +}
> > +EXPORT_SYMBOL(rps_record_sock_flow);
> > +
> >  #ifdef CONFIG_RFS_ACCEL
> >
> >  /**
> > --
> > 2.47.3
> >
>
> Interesting idea but:
>
> 1) Some of us do not use CONFIG_RFS_ACCEL yet.

Points 1 and 3 are noted. If this approach is acceptable, I can
implement it as a selectable option (e.g., using a static key) to
toggle the LLC-aware strategy.

> 2) You put a very fast path function out-of-line, why ?

The reason is that tun uses sock_rps_record_flow_hash(). When I moved
all rps_record_sock_flow and rps_record_cond modifications into
include/net/rps.h, it triggered the following compilation errors due
to symbol visibility:

ERROR: modpost: "cpus_share_cache" [drivers/net/tun.ko] undefined!
ERROR: modpost: "cpus_share_cache" [net/sctp/sctp.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1

This arises because the patch uses cpus_share_cache() to limit the
RFS/ARFS update frequency at the LLC level. To keep this in the fast
path, I could move cpus_share_cache() to
include/linux/sched/topology.h.

> 3) I think the behavior should be selectable with a static key or
> something like that.

Please refer to my response to point 1.

>
> 4) Please provide benchmark results.

The scenario is similar to the one described in "[RFC] problems with
RFS on bRPC applications"[1].

I attempted to enable ARFS on a Mellanox CX-6 NIC. While it performs
well for simple workloads, performance degrades significantly when
running a bRPC[2]  workload on a 2-node NUMA machine. After tracing, I
identified patterns that ARFS/RFS fails to handle efficiently:

- Multiple threads use epoll to read from the same socket, causing
frequent flow updates in sock_flow_table.
- Threads reading from the socket migrate frequently between CPUs.

I tested a PoC version using a bRPC service, utilizing funccount [3]
to monitor execution frequency and perf top to observe hotspots:

Before Patch

The mlx5e_rx_flow_steer frequency is over 380k/s, and queued_spin_lock
is a major hotspot (6.30% in perf top). The application also suffers
from a noticeable drop.

FUNC                                     COUNT
mlx5e_rx_flow_steer              387594

FUNC                                     COUNT
mlx5e_rx_flow_steer              390142

FUNC                                     COUNT
mlx5e_rx_flow_steer              386694

FUNC                                     COUNT
mlx5e_rx_flow_steer              389094

# perf top hotspot:
queued_spin_lock                         6.30%

After Patch

The ARFS update frequency is significantly reduced. queued_spin_lock
is no longer a hotspot in perf top, and the application's overall
performance has improved.

FUNC                                     COUNT
mlx5e_rx_flow_steer                      43

FUNC                                     COUNT
mlx5e_rx_flow_steer                        9

FUNC                                     COUNT
mlx5e_rx_flow_steer                    207

FUNC                                     COUNT
mlx5e_rx_flow_steer                      26

1: https://lore.kernel.org/netdev/CAHCEFEwToeQe_Ey8e=3Dsf8fOmoobvrDCPsxw+hf=
USoRawPX03+Q@mail.gmail.com/t/#u
2: https://github.com/apache/brpc
3: https://github.com/iovisor/bcc/blob/master/tools/funccount.py


>
> Thanks.

