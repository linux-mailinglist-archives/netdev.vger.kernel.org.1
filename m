Return-Path: <netdev+bounces-284860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N9zDmBM+2nWYwMAu9opvQ
	(envelope-from <netdev+bounces-284860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:12:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8919B4DBD7F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3243304DCBE
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD60C47798B;
	Wed,  6 May 2026 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwYPWgFe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D283EC2DB
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076165; cv=pass; b=eG55kh1ZYWRFTZ9ciW2X6OvU5HNxivdBZsIErW5pL1XhR7IJTtUmw770OO9G2tMPFsgV8/lyBLkSQ7XTglmuhPwEx1F3/PDBdnMcPdgqMzvYUEmOSFWTYsUu8/TVK06c8U5/houEs90n2/vY1Z6On8Oz4c3NHfHlADbTQGqmbHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076165; c=relaxed/simple;
	bh=fgAwzIJcDQ8eNqIftM+Ys2qYzkhzF8+UPWzFGRtBbTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVmtB0ls8wO+/lVyOaWkSuWadrBWq/AnZgvXMRZt9YWVx90FTrad0ry4l2jBTLZ7cAzDOr6UcL4C/q62jVM0ENR9VIbzo5sZPYYSVMwSEoyIqp/wBGNfU0gdj1FRvxxg+VSpuY1AohpeNXfBw+xx2HOT58M+Kwb5y8AElLqOshU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwYPWgFe; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36525730172so4033889a91.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 07:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778076163; cv=none;
        d=google.com; s=arc-20240605;
        b=XrlQazDbTPdrV4WqAEnzZbN70H5OE72u4cM5dHcuivoqJI7PuS7jDOJQoO52K7R942
         Sp2fa3dG/lVJ66cple103KI+rA0O6ClffzyMVfF8TLu26i3E1Y4PpKS3GFGFZHuLfSNk
         qVK/LMLnh0uxnomRF3wik8Gzbr8fQVPl/znbIFY17g1HUBK5DQEYGBBR1x4uhs27VKHr
         jkPjz/mC9lVCozUXWu4nSvcjaZftQDVs5ZiMDOufu6/TEzT8rGqTADI9V0ahTgSbZoFh
         4s/cCaepzYzv5brdjOTjACByhmGOW0QqN8dqqYbZJC4YiWpQd7l8/gFz6G116121XR0c
         +10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UdovNLCYq0IbWq5PxDP9Dzxis1pH8PCkS+QQzY6zAqE=;
        fh=jYJDHi4NdICWqQzg5Jurx0EQskNgPT427lGzYVi3h+k=;
        b=YDKE8IXVgQq0tsbfR+3WviP6RLcn4LTIcu0f5PgkDoAXHV3JTPEcJi8iQ0E67sQqR8
         VaAOT2H9j9Wj5tfffaVN6oBnkQjEgTok3A3x2vKPMcLIdciqkIVedZG67hV3X69ZC3aD
         WR+hjFrsDCAroJeh7kLXM+SlfiGoKhYfDBQVX2+2FTOCTGmnQrm2zk4BnKdLs3W/L/JA
         4gpGS0W0od13wQsnpfkLpIc8bGY7MfDNcW9hZSbKIhA9W+S/D5LMBWGc3S1qgZkdgQho
         o8ySomZUjUSmTwqB70UXkoyxykDAYw/NTXUlM6SY8rcqZRI4brqj5iQXIfzRePEo4SYI
         Z4Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778076163; x=1778680963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdovNLCYq0IbWq5PxDP9Dzxis1pH8PCkS+QQzY6zAqE=;
        b=SwYPWgFe0htU6QIOL81aMLf4m6nnXCSdz9e42eoWi+cnAXmvdvfaXmlQm/1XDoaEuj
         EKNlLj0ur7okd91Q0p8wRRbKNR1FzExkBfWnohoBkdPrNR0enufNr+ROJY6dGalTwu1j
         huUFpZEQcH2A5Zq44g4vn/OGy/FOIBCPE3ieWeZCKU2s+p8UbFGIc9Ujmmb2uTdF/MY6
         mCOXIQqMrWabeGircrlAJyeMAOv3elEptNHdP8Xq5NItdh5ne/XTJz3VxcHhIXVibfMo
         EJVfYddaZs+K47QZgMDkYsdTTfMTBb8GGipGXMnbDHbg60wA7Xt+hXM8qa6HsB/pzgMF
         XTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778076163; x=1778680963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UdovNLCYq0IbWq5PxDP9Dzxis1pH8PCkS+QQzY6zAqE=;
        b=YxlgSFsrRSEBNoZkFf1SAGw8InVcGgI9maSbYsKDt5BmV+O9G9KnldgSzJGW6aZU/K
         VBG5J0FqydNwxDEu6XJ1kCU38ewd7H+KKM92jjSVVpT+U3AvheN8e3l7Sv8cVVGsDBht
         vmDR6uUDPCM9ZpXHWlwrw/LbSFoAbPFMHKelYYm+jZ2Z4roL+QJmdFj7frNBm5UCNsQI
         DtD04CscfsJXMOSGwWNw2ACC9GpEUn0WYQH7Bwuj3t5CxOuAQEfmogXyUPBZPXBXWHX/
         oMiP8IiAzFmX9570wh4yY9HZckXq9eUi+Xsw0oIHxpj5rslPpEORzemswXTz5VG7qitV
         ek0A==
X-Forwarded-Encrypted: i=1; AFNElJ/Q+tyt+soVJvlrpU4ypPLehRn4bni9R7XINP4ZPsNavRREK9WDgIt4daWT7gl+y1oNgoxl0yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59ZDsZgdKt31wWGxhM9/mJ6MRV/hiYI166xjRMGJIa8gpP/vw
	aGPaunAYqLhpl6G0ksQmVf057gF8H/kUB/7AOvjzOumeRDNaVPSljduknI3BxCCsQ+x6qEGRlsA
	U/ai0WBR6JO3bXVmcwKQesUpQHLpn1QI=
X-Gm-Gg: AeBDievGateePtrN3epRa5ySHTDoyUZNuzWX2GpIVsolhNPj267EI4WuhV3vnHBdvm4
	R948qhgySfucFsNGgX8dn9ZnGJgXrAzg7Zfea4AK8q1NdBjWNabkBpKsAI//PB8qd+87kVsRd0w
	eA1YeDtxZjBhWAFEn1r+etZ0qNn1jSRwHtzO8KjtMhKaoiWsL8FK1nkZUrrNLx+N/AQU+OCGJfQ
	i1aPa8naVasAgE4H86/iaJ4jS3Seu0ONIUgWqFyytpSiWEe/B/fXp79+/+ls5rAdBZDhuZ6Al06
	3UhI2qFzrhcUBJByOxlzy75xvlQ2aQ==
X-Received: by 2002:a17:90a:d886:b0:35b:8d89:719b with SMTP id
 98e67ed59e1d1-365ab3e592amr3779857a91.1.1778076161345; Wed, 06 May 2026
 07:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428025505.768-1-nashuiliang@gmail.com> <CANn89i+H=gPo22v0ApLges0ScjMOgAcVsDQLwkr2iAEu+M7B7w@mail.gmail.com>
In-Reply-To: <CANn89i+H=gPo22v0ApLges0ScjMOgAcVsDQLwkr2iAEu+M7B7w@mail.gmail.com>
From: chuang <nashuiliang@gmail.com>
Date: Wed, 6 May 2026 22:02:30 +0800
X-Gm-Features: AVHnY4KdFSvevuoRYT8lkecAzuDQZ98GwOODC3CPttbJ3x58n9wJ11HQfYS9GCA
Message-ID: <CACueBy7PGP6YG8cM8ZJP8bU9TMa0OZPXg8sVSdZVuzyMKNo-xw@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: reduce RFS/ARFS flow updates by checking
 LLC affinity
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Krishna Kumar <krikku@gmail.com>, Neal Cardwell <ncardwell@google.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8919B4DBD7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284860-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,fomichev.me,google.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nashuiliang@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]

On Tue, Apr 28, 2026 at 1:09=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Apr 27, 2026 at 7:56=E2=80=AFPM Chuang Wang <nashuiliang@gmail.co=
m> wrote:
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
> > preserving cache locality for the application. A new sysctl,
> > net.core.rps_feat_llc_affinity, is added to toggle this feature.
> >
> > Performance Test Results:
> > The patch was tested in a K8s environment (AMD CPU 128*2, 16-core Pod
> > with CPU pinning, mlx5 NIC) using brpc[1] echo_server and rpc_press.
> >
> > rpc_press Commands:
> >
> >   for i in {1..8}; do
> >     ./rpc_press -proto=3D./echo.proto -method=3Dexample.EchoService.Ech=
o
> >     -server=3D<IP>:8000 -input=3D'{"message":"hello"}'
> >     -qps=3D0 -thread_num=3D512 -connection_type=3Dpooled &
> >   done
> >
> > Monitor mlx5e_rx_flow_steer frequency:
> >
> >   /usr/share/bcc/tools/funccount -i 1 mlx5e_rx_flow_steer
> >
> > Frequency of mlx5e_rx_flow_steer (via funccount[2]):
> >
> >   Before: ~335,000 counts/sec
> >   After:   ~23,000 counts/sec (reduced by ~93%)
> >
> > System Metrics (after enabling rps_feat_llc_affinity):
> >
> >   CPU Utilization: 38% -> 32%
> >   CPU PSI (Pressure Stall Information): 20% -> 10%
> >
> > These results demonstrate that filtering updates by LLC affinity
> > significantly reduces driver lock contention and improves overall
> > CPU efficiency under heavy network load.
> >
> > [1] https://github.com/apache/brpc/
> > [2] https://github.com/iovisor/bcc/blob/master/tools/funccount.py
> >
> > Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> > ---
> > v2 -> v3: patch net -> net-next
> > v1 -> v2: add rps_feat_llc_affinity; add brpc tests
> >
> >  include/net/rps.h          | 18 ++--------
> >  net/core/dev.c             | 72 ++++++++++++++++++++++++++++++++++++++
> >  net/core/sysctl_net_core.c | 34 ++++++++++++++++++
> >  3 files changed, 108 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/net/rps.h b/include/net/rps.h
> > index e33c6a2fa8bb..37bbb7009c36 100644
> > --- a/include/net/rps.h
> > +++ b/include/net/rps.h
> > @@ -12,6 +12,7 @@
> >
> >  extern struct static_key_false rps_needed;
> >  extern struct static_key_false rfs_needed;
> > +extern struct static_key_false rps_feat_llc_affinity;
> >
> >  /*
> >   * This structure holds an RPS map which can be of variable length.  T=
he
> > @@ -55,22 +56,7 @@ struct rps_sock_flow_table {
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
> > index 203dc36aaed5..630a7f21d8de 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4964,6 +4964,8 @@ struct static_key_false rps_needed __read_mostly;
> >  EXPORT_SYMBOL(rps_needed);
> >  struct static_key_false rfs_needed __read_mostly;
> >  EXPORT_SYMBOL(rfs_needed);
> > +struct static_key_false rps_feat_llc_affinity __read_mostly;
> > +EXPORT_SYMBOL(rps_feat_llc_affinity);
> >
> >  static u32 rfs_slot(u32 hash, rps_tag_ptr tag_ptr)
> >  {
> > @@ -5175,6 +5177,76 @@ static int get_rps_cpu(struct net_device *dev, s=
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
> > +       /*
> > +        * RPS LLC Affinity Feature:
> > +        * Reduce RFS/ARFS flow updates by checking LLC affinity.
> > +        *
> > +        * Frequent flow table updates can trigger constant hardware st=
eering
> > +        * reconfigurations (e.g., ndo_rx_flow_steer), leading to signi=
ficant
> > +        * contention on driver internal locks (like mlx5's arfs_lock).
> > +        *
> > +        * This strategy only updates the flow record if it migrates ac=
ross LLC
> > +        * boundaries. This minimizes expensive hardware updates while =
preserving
> > +        * cache locality for the application.
> > +        */
> > +       if (static_branch_unlikely(&rps_feat_llc_affinity)) {
> > +               /* Force update if the recorded CPU is invalid or has g=
one offline */
> > +               if (old_cpu >=3D nr_cpu_ids || !cpu_active(old_cpu))
> > +                       return true;
> > +
> > +               /*
> > +                * Force an update if the current task is no longer per=
mitted
> > +                * to run on the old_cpu.
> > +                */
> > +               if (!cpumask_test_cpu(old_cpu, current->cpus_ptr))
> > +                       return true;
> > +
> > +               /*
> > +                * If CPUs do not share a cache, allow the update to pr=
event
> > +                * expensive remote memory accesses and cache misses.
> > +                */
> > +               if (!cpus_share_cache(old_cpu, new_cpu))
> > +                       return true;
> > +
> > +               return false;
> > +       }
> > +
> > +       return true;
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
>
> We do not want to put rps_record_sock_flow out of line.
> rps_llc_check() is probably fine, it should not be called often.
>

The same issue reported in:
https://lore.kernel.org/netdev/CACueBy4KyU8DjwtLM6pzjQNTbiy2M+ZhZdO7Ag=3Dss=
qWq00CJ7w@mail.gmail.com/
The reason is that 'tun' uses sock_rps_record_flow_hash() in
tun_flow_update(), which triggers the following compilation error due
to symbol visibility when CONFIG_TUN is built as a module:

ERROR: modpost: "rps_llc_check" [drivers/net/tun.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1

To resolve this, it seems more appropriate to export
sock_rps_record_flow_hash in net/core/dev.c:

+void sock_rps_record_flow_hash(__u32 hash)
+{
+#ifdef CONFIG_RPS
+       if (!rfs_is_needed())
+               return;
+
+       _sock_rps_record_flow_hash(hash);
+#endif
+}
+EXPORT_SYMBOL(sock_rps_record_flow_hash);
+

> diff --git a/include/net/rps.h b/include/net/rps.h
> index e33c6a2fa8bbca3555ecccbbf9132d01cc433c36..7e98918d8751eb824b7057cca=
9e5d40c28e5f18a
> 100644
> --- a/include/net/rps.h
> +++ b/include/net/rps.h
> @@ -55,10 +55,12 @@ struct rps_sock_flow_table {
>
>  #define RPS_NO_CPU 0xffff
>
> +bool rps_llc_check(u32 old_val, u32 new_val);
> +
>  static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
>  {
>         unsigned int index =3D hash & rps_tag_to_mask(tag_ptr);
> -       u32 val =3D hash & ~net_hotdata.rps_cpu_mask;
> +       u32 old_val, val =3D hash & ~net_hotdata.rps_cpu_mask;
>         struct rps_sock_flow_table *table;
>
>         /* We only give a hint, preemption can change CPU under us */
> @@ -68,7 +70,8 @@ static inline void rps_record_sock_flow(rps_tag_ptr
> tag_ptr, u32 hash)
>         /* The following WRITE_ONCE() is paired with the READ_ONCE()
>          * here, and another one in get_rps_cpu().
>          */
> -       if (READ_ONCE(table[index].ent) !=3D val)
> +       old_val =3D READ_ONCE(table[index].ent);
> +       if (old_val !=3D val && rps_llc_check(old_val, val))
>                 WRITE_ONCE(table[index].ent, val);
>  }

