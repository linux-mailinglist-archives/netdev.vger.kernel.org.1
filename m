Return-Path: <netdev+bounces-273500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJJ9MU19y2mLIQYAu9opvQ
	(envelope-from <netdev+bounces-273500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:52:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD495365869
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BB0C3064750
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37CD3CD8D2;
	Tue, 31 Mar 2026 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBuIi8tm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167133CA487
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942922; cv=pass; b=tCt7wL/R8zKFm9EnKPrQwCDqbHvZAbXPPpSXruJ6CgJ9GgvAJHzVdPo+I74KUvnJGaXNANHYmF3ya/w5qfw1QVzfRKWzDkqrXbD/jGKu21NxqFUtmMJOOmSO5vDu5+5KiR7xpO2AY5Q8nXIRALC7FTtNhJt3OD0EXet6VGg286U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942922; c=relaxed/simple;
	bh=a1QkK7I8SeMgmm/Y9a/kKU0O6tDHmyG25X9M1qLN5zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZIW1cmz1qs+2Z2kyRK3i3wT/UpWIc5ZrLdM4PKqB2c0GmhBU8zV6PI2XMe+Gf2LDfp4BikbHvBB5KdXR+s8ZBrovr+Ow+T6j9EjIpSbvRI6TzMp9BgkBoeYH2GvlJf++sGTrekumpQQ87SpThnJcJtCp3/60GIjw1NHDjNIXeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBuIi8tm; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6e2355739dso2210444a12.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774942919; cv=none;
        d=google.com; s=arc-20240605;
        b=ZoQrbuoNAUiuTrMqK+rMlN+Ozb6oEN37qbf86Tii3W3G0imOeo8ok+k3XDPD6Wj+xe
         siamVffnO0ywCpFCQPhd95CmySaxesohITOH9booQ9qH05MODmBklmL7HIsQYZUI5As0
         9F3iwyjtQdQa7FKkncPfeCidyDaDVPGHdTcJLwx/sKYdy8FhzQ0HtvEIOnhPOjXCsZhh
         pQV5q1gXEhc87cbI1JDTW8yNqNUCJG+OKppjGrrSVXasbkRZ7Rnm36VUYcN5z9qMrSuS
         ywbbwQIKfC6z7jTS2bV1N6TXMD7L5Qmx/1jw/M0OQhf9xj6hm4r1hXXmP/MnUgMGSRh4
         F2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Cr4Zovzs+pQeNLXzZfu53r1i4mWUqRa9tnTrTbj1Dk=;
        fh=vljY2qVMIOwMXsrvnykgVVE9tdmJSJAZlAfWXS58GKs=;
        b=IVB++9Wade+DMYUS2NNOKqxryJIT3JniMHJeeZ1aTW8oqQHnJK0WY7/elwno7gbNSL
         Y3tEQ553LFxRPuWRlvAhzTWwyN6vsgbEW2V0mLuAN1+klG7nFE4gAsYiWhA3C2RadpJm
         QtyUWKBZ3gRvuH8GXQrIVsSQZHx3fEQ2SM8k03SUWT8XjFTLMwUd/aV3kvsIZKHc5Mzp
         lBoNr/ifBDPmpR5qyDg9ACl3Qq+kGiBObwbGLXcZpIUERNWLjd4Hk8SYdwXZEVUjKC4B
         QnOthFqzuCeRpqwzfMWukjhh4lnd3nj/0bBnva3eV7gyEgJAXNeUAunsIsCEX+JJUnNH
         U/nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774942919; x=1775547719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Cr4Zovzs+pQeNLXzZfu53r1i4mWUqRa9tnTrTbj1Dk=;
        b=IBuIi8tmx5t3FFQTGtYIFTU3HLzH4Lzuz8MXHcAyO3vZHrV5cH769gkAqlM+78uN/s
         qy/kLRfL0hHa7TuDonfS52aUHVfiMl7JIFgF463nx2FABxYxGht9ZYvSUHbYeB8T0lbg
         wj5f3kpoecmeHmHwJZNzThKZWq5SQlwiR7BXuQDOcghsqpxKJ9SIu47k5DuHKve3VlIJ
         5PN+/Outuag5Ij0sUO2gcIge0G/9eLLDn/lC0+Lj1Ci6rB1dV+agh/NKwbkdqTO/gCea
         g3HLmzLixIdJofA1vFRs8LZImhxZG/Kxk2h8T7jUU/shXkXh4tNeB8jFPN4/N5wnHQng
         zROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774942919; x=1775547719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Cr4Zovzs+pQeNLXzZfu53r1i4mWUqRa9tnTrTbj1Dk=;
        b=GaL98vUU1/0mndRncMoVOwsRQG9xwuGOdVhu8A0BwKYNDgEtHbsqi/lTreyDJL3NqD
         WAORTiA8qrBdBa5IjRjIe6GM2pPxYlVeWDwsVr5OY/pHW3b6PEOPBk2dRU1w1TzdqIKi
         c7pLgCpHH70e3FiW9LmynGq8twzL+QcGyDijQqNMB4InQx3Mbl+ZTBQ45T8wWG+he0ut
         sLAZEGW8VfJNx1WrGkYbskx6dDIxw3IEOqXsYQN+isR38C7nSVpxFqzq+Dea8EJbieOD
         6LmscdUfNreNmP/6hHwe6+U1mfzW9sAjw/Mw+1sdWbXcZZJo0fQ45yTUWcSlO9zvWfgI
         pssA==
X-Forwarded-Encrypted: i=1; AJvYcCWAxgL57oaLieH8zIwoqCNQTwY7YwXT+7apTtthbNGPu/7Nzd+JPDBGOzPdLKg45IWWiC5MEvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVjHV3OuCPYvI8fXUFeDnMzy2S+vzDz+nZIV4jF9XoZjYXZ+tE
	09RntQWvA+x+XBbZP/DKcSYYv6nnJ5TU+r3iGPqdC3bz0ayVs6ZI5h1layXSTdQk2rZQje++irm
	Q6Pnb0MAu6AXspUa/dsTqtbA6joXIbDk=
X-Gm-Gg: ATEYQzy4blLytst1lmUIBiRwRyVH/oB5AnfVBS0jTx5X9svqOb2Ai0YDBYvxy+1Fc3x
	lvYKH3UIpU0zVa54BN/SvrDdH9swpI9RH8wB9R6fMJyN8LwCy+ST/jzYnRgXgglICCkL8dKckBy
	mAXZKh6hz93owb9MDrnE0NC4+4yt10HvttL/xJ1cTtIe9TRcHQFZJMdzSyiiSwQumqD2txalHpT
	/10W5LTzkNHUm7AdFCrogidF++TlzUVUmJHOs0rrb6d9lg9qL1g1i0lEex4BnG5IH7N//suIhXD
	E17OahqVjX14YRV1DxA=
X-Received: by 2002:a17:902:da91:b0:2b0:9101:1b77 with SMTP id
 d9443c01a7336-2b0cdc4389cmr168095845ad.17.1774942919354; Tue, 31 Mar 2026
 00:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308070925.58939-1-nashuiliang@gmail.com> <CANn89iJYiyp4dwA+Ye=7ySgQZaPnL=XfoQ4S4eXM-gs3pP+keA@mail.gmail.com>
 <CACueBy4KyU8DjwtLM6pzjQNTbiy2M+ZhZdO7Ag=ssqWq00CJ7w@mail.gmail.com>
In-Reply-To: <CACueBy4KyU8DjwtLM6pzjQNTbiy2M+ZhZdO7Ag=ssqWq00CJ7w@mail.gmail.com>
From: chuang <nashuiliang@gmail.com>
Date: Tue, 31 Mar 2026 15:41:48 +0800
X-Gm-Features: AQROBzANTQf_uoolmSr3z0UNwJduWDkWdltMdut_EszLxodnYn9XIG0JOcu7ZPM
Message-ID: <CACueBy5bNuKQ27F0FYTsKePq_92unuEAaMqgyGK_3ovSrO6rWA@mail.gmail.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273500-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nashuiliang@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BD495365869
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Any thoughts or suggestions on the patch "reduce RFS/ARFS flow updates
by checking LLC affinity"? It=E2=80=99s been a while since the last update.

On Sun, Mar 8, 2026 at 4:20=E2=80=AFPM chuang <nashuiliang@gmail.com> wrote=
:
>
> Hi,
>
> On Sun, Mar 8, 2026 at 3:19=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Sun, Mar 8, 2026 at 8:10=E2=80=AFAM Chuang Wang <nashuiliang@gmail.c=
om> wrote:
> > >
> > > The current implementation of rps_record_sock_flow() updates the flow
> > > table every time a socket is processed on a different CPU. In high-lo=
ad
> > > scenarios, especially with Accelerated RFS (ARFS), this triggers
> > > frequent flow steering updates via ndo_rx_flow_steer.
> > >
> > > For drivers like mlx5 that implement hardware flow steering, these
> > > constant updates lead to significant contention on internal driver lo=
cks
> > > (e.g., arfs_lock). This contention often becomes a performance
> > > bottleneck that outweighs the steering benefits.
> > >
> > > This patch introduces a cache-aware update strategy: the flow record =
is
> > > only updated if the flow migrates across Last Level Cache (LLC)
> > > boundaries. This minimizes expensive hardware reconfigurations while
> > > preserving cache locality for the application.
> > >
> > > Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> > > ---
> > >  include/net/rps.h | 17 +--------------
> > >  net/core/dev.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 55 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/include/net/rps.h b/include/net/rps.h
> > > index e33c6a2fa8bb..2cd8698a79d5 100644
> > > --- a/include/net/rps.h
> > > +++ b/include/net/rps.h
> > > @@ -55,22 +55,7 @@ struct rps_sock_flow_table {
> > >
> > >  #define RPS_NO_CPU 0xffff
> > >
> > > -static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 has=
h)
> > > -{
> > > -       unsigned int index =3D hash & rps_tag_to_mask(tag_ptr);
> > > -       u32 val =3D hash & ~net_hotdata.rps_cpu_mask;
> > > -       struct rps_sock_flow_table *table;
> > > -
> > > -       /* We only give a hint, preemption can change CPU under us */
> > > -       val |=3D raw_smp_processor_id();
> > > -
> > > -       table =3D rps_tag_to_table(tag_ptr);
> > > -       /* The following WRITE_ONCE() is paired with the READ_ONCE()
> > > -        * here, and another one in get_rps_cpu().
> > > -        */
> > > -       if (READ_ONCE(table[index].ent) !=3D val)
> > > -               WRITE_ONCE(table[index].ent, val);
> > > -}
> > > +void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash);
> > >
> > >  static inline void _sock_rps_record_flow_hash(__u32 hash)
> > >  {
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 203dc36aaed5..770cfb6fe06b 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -5175,6 +5175,60 @@ static int get_rps_cpu(struct net_device *dev,=
 struct sk_buff *skb,
> > >         return cpu;
> > >  }
> > >
> > > +/**
> > > + * rps_record_cond - Determine if RPS flow table should be updated
> > > + * @old_val: Previous flow record value
> > > + * @new_val: Target flow record value
> > > + *
> > > + * Returns true if the record needs an update.
> > > + */
> > > +static inline bool rps_record_cond(u32 old_val, u32 new_val)
> > > +{
> > > +       u32 old_cpu =3D old_val & ~net_hotdata.rps_cpu_mask;
> > > +       u32 new_cpu =3D new_val & ~net_hotdata.rps_cpu_mask;
> > > +
> > > +       if (old_val =3D=3D new_val)
> > > +               return false;
> > > +
> > > +       /* Force update if the recorded CPU is invalid or has gone of=
fline */
> > > +       if (old_cpu >=3D nr_cpu_ids || !cpu_active(old_cpu))
> > > +               return true;
> > > +
> > > +       /*
> > > +        * Force an update if the current task is no longer permitted
> > > +        * to run on the old_cpu.
> > > +        */
> > > +       if (!cpumask_test_cpu(old_cpu, current->cpus_ptr))
> > > +               return true;
> > > +
> > > +       /*
> > > +        * If CPUs do not share a cache, allow the update to prevent
> > > +        * expensive remote memory accesses and cache misses.
> > > +        */
> > > +       if (!cpus_share_cache(old_cpu, new_cpu))
> > > +               return true;
> > > +
> > > +       return false;
> > > +}
> > > +
> > > +void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
> > > +{
> > > +       unsigned int index =3D hash & rps_tag_to_mask(tag_ptr);
> > > +       u32 val =3D hash & ~net_hotdata.rps_cpu_mask;
> > > +       struct rps_sock_flow_table *table;
> > > +
> > > +       /* We only give a hint, preemption can change CPU under us */
> > > +       val |=3D raw_smp_processor_id();
> > > +
> > > +       table =3D rps_tag_to_table(tag_ptr);
> > > +       /* The following WRITE_ONCE() is paired with the READ_ONCE()
> > > +        * here, and another one in get_rps_cpu().
> > > +        */
> > > +       if (rps_record_cond(READ_ONCE(table[index].ent), val))
> > > +               WRITE_ONCE(table[index].ent, val);
> > > +}
> > > +EXPORT_SYMBOL(rps_record_sock_flow);
> > > +
> > >  #ifdef CONFIG_RFS_ACCEL
> > >
> > >  /**
> > > --
> > > 2.47.3
> > >
> >
> > Interesting idea but:
> >
> > 1) Some of us do not use CONFIG_RFS_ACCEL yet.
>
> Points 1 and 3 are noted. If this approach is acceptable, I can
> implement it as a selectable option (e.g., using a static key) to
> toggle the LLC-aware strategy.
>
> > 2) You put a very fast path function out-of-line, why ?
>
> The reason is that tun uses sock_rps_record_flow_hash(). When I moved
> all rps_record_sock_flow and rps_record_cond modifications into
> include/net/rps.h, it triggered the following compilation errors due
> to symbol visibility:
>
> ERROR: modpost: "cpus_share_cache" [drivers/net/tun.ko] undefined!
> ERROR: modpost: "cpus_share_cache" [net/sctp/sctp.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
>
> This arises because the patch uses cpus_share_cache() to limit the
> RFS/ARFS update frequency at the LLC level. To keep this in the fast
> path, I could move cpus_share_cache() to
> include/linux/sched/topology.h.
>
> > 3) I think the behavior should be selectable with a static key or
> > something like that.
>
> Please refer to my response to point 1.
>
> >
> > 4) Please provide benchmark results.
>
> The scenario is similar to the one described in "[RFC] problems with
> RFS on bRPC applications"[1].
>
> I attempted to enable ARFS on a Mellanox CX-6 NIC. While it performs
> well for simple workloads, performance degrades significantly when
> running a bRPC[2]  workload on a 2-node NUMA machine. After tracing, I
> identified patterns that ARFS/RFS fails to handle efficiently:
>
> - Multiple threads use epoll to read from the same socket, causing
> frequent flow updates in sock_flow_table.
> - Threads reading from the socket migrate frequently between CPUs.
>
> I tested a PoC version using a bRPC service, utilizing funccount [3]
> to monitor execution frequency and perf top to observe hotspots:
>
> Before Patch
>
> The mlx5e_rx_flow_steer frequency is over 380k/s, and queued_spin_lock
> is a major hotspot (6.30% in perf top). The application also suffers
> from a noticeable drop.
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer              387594
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer              390142
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer              386694
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer              389094
>
> # perf top hotspot:
> queued_spin_lock                         6.30%
>
> After Patch
>
> The ARFS update frequency is significantly reduced. queued_spin_lock
> is no longer a hotspot in perf top, and the application's overall
> performance has improved.
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer                      43
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer                        9
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer                    207
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer                      26
>
> 1: https://lore.kernel.org/netdev/CAHCEFEwToeQe_Ey8e=3Dsf8fOmoobvrDCPsxw+=
hfUSoRawPX03+Q@mail.gmail.com/t/#u
> 2: https://github.com/apache/brpc
> 3: https://github.com/iovisor/bcc/blob/master/tools/funccount.py
>
>
> >
> > Thanks.

