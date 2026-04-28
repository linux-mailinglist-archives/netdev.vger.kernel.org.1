Return-Path: <netdev+bounces-281623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O8/MntB8Gn1QgEAu9opvQ
	(envelope-from <netdev+bounces-281623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:11:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D03447D76D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCDEB302C6E8
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9513B29C325;
	Tue, 28 Apr 2026 05:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHGtti42"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352E22459DD
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777352971; cv=pass; b=EVX5c61TmTE7PWU0A7lm4p7f4JaFgtvrzR1uUllwNipUOC1Kym2OrxNXWtlwKxgFUofNyHUh6+kwz0YfAzRSHaYRlAshrC1pdZCfMofT4RSQXuMwiTcPiUuUaa4eQRaPuT0BkFyJ78ajP9pg8bqk8BTApSvzqSJUYT3psdfCe2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777352971; c=relaxed/simple;
	bh=NdgYKLhmujZ8lnCSV4ee+TRqZ7JkF4rn1WY2UR35PX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyBcluxqtcMBw384gN8SsUfmK7+gMQ/M1Rubzqc1KuFP3BMb0aTmut23nlDh7xgsVFM2+K2YAtoM+8BbSZjccC/zgvrzioOT0mzqNAcAL9nRsrSIBatY1V/xgNw6dBhj9j8CuiLB8OC5pn/zDkMkovcVoeEB/tNVIQFaCEbF0Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kHGtti42; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50faf8ed9c5so45485611cf.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777352968; cv=none;
        d=google.com; s=arc-20240605;
        b=Ln0/1clBuMYmmo/BNbzLAtKeNKLkJx7t7My6gIVJJskzGdBPkpmSyLYPUf63NMuLWq
         Zk91VbgNNd6Y0NcuOJ9mHIOZwrR4GEbiUC62/cwRqDz9HhbaK3A9/2r+b/a5s5++ZhNn
         FPI4SZIMGpbpXyX4UE/vOM7dxZ6/me1CssfOSuOA55TQ4nhcBwmMQd1rDt4Y1/JXUPi1
         vHEuCVZVD63xw34vtiNRDBUUjeEDNgx1Y/HCbOSr7b5A3MCcHm0rrmXJewuqWxGIcB9I
         eXOCiUy4u/5dm9kj+uuqykOtQonBLtOUm154u3rwK6XhMxWS8PHwO6yoiTjHzEGrei9A
         fdJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DCgtW/WHTCdI+LgLvgClR4xu5VOt3ICgbmXr1vzycdg=;
        fh=39Ud9tbODaiSvnJyCTx+IQFfP4gXJtI+CKP6Hf5O5dY=;
        b=kVuv+x+i/uSEAxtXUNc7IlBgz//QUd1XK7lGAVE0KkHknaljZ6BYti1N6fIJq7IES5
         0RfH9BgSReBrn3w8PgP2cDNIesjN/kGe3DmymX61xGCOe3PJPr+A/kZCrIEGX4LnGVdW
         fYoLGl0Avafy1atYL1tAZW+/e2j1+ZoeAFGXQQkA9+Lmsbfyxczsa9DjIAslC4SqvR2D
         /rL9cb7ZlF2AO3lWNBeJtTy9/WktIvj+PEt5cHM88IwaJBxzWTOuu917WjCpdnSBG6ud
         uEXQjIuHz6dJocno5IFcv4vh/5Ghnofv0HUGthIWu2VaYHJuzMMsUUlcPcq/r0M8sMBk
         /3cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777352968; x=1777957768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCgtW/WHTCdI+LgLvgClR4xu5VOt3ICgbmXr1vzycdg=;
        b=kHGtti42QOFDF2+gqyJ3+wAIgSb6pz9CEYsyQNlLbOBe7A8v4/HuG+5NgGpcU1o0F0
         FPHiDfagNEVA9bLjmCz6Ck29E3zBVxUDrTs9oMbZ0X2ScHVmevcxCidEY4nKDWrADVPa
         1Tk0QP97uqfhq/CpflEJ2prtpt+Vj1hoCKGH2zhx7xgcWZCxac4eTEhs3BMyahQ5AdYa
         5T1WgldLhie+mOOIUMAtanVAbad2s5HBOsuARsPkXI2sJmGOjBTLbHt6MMJC8rLVkyiC
         tjP6iEzr4kyhPKullE3EM/baZMZNA2ENGBppjpZOtk0wMPyapXLtqlZl/8P1YrKoyF8M
         q8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777352968; x=1777957768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DCgtW/WHTCdI+LgLvgClR4xu5VOt3ICgbmXr1vzycdg=;
        b=BRHWVMKfJd3+mqnBYWxUcRCmqQz2TqZYa4aymmNnMdmHLuPmJh73Rj97Yx9pOtgs5t
         VncdjpsdSvcE6VhS07wlaBUJZ2UMCTgEtn4fLDDWMaeHNSzupCLROW+0eUV6a1rubWXp
         aSKuQpDxIB5IMK90Lm8CxITsbX/f3H4ak2bxp4fseYEXrl6P6T10ua+Wp1lKoZBEmuOj
         c420A4/nM9+ZSzHyb2z3YEOiKpkYLfGNHEZIJlJZ1bJiLCorzfdQhvaOrbh2P8Sn9NcI
         wEy/QrXoS1nqvZVvyCTCdRHy3QnFbtk0JHew9va17l5D5svX83zn6gzhOVZ/v3LsErJY
         IYRw==
X-Forwarded-Encrypted: i=1; AFNElJ9r00HDF4CYDraO4Pjxh1+rKZ/1idvglawMPVhhedqvX5tYoJ89WppEIO3fIfFNL3x6qKaBV7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ku6KXFBcqnUVS83mQkdwq4cw0XjZnZfjhRnSqvX5R6TkV887
	RgvEl513SjCr/q+LWAU4sztpzUkjA7N47MX9/ZOSksutyukasEnSph/KmjoOcs6o8uj08uDWiVj
	eq0nQ3AA/6ytIy5oWHmFrnUBNeH33/aLhGV9yWplO
X-Gm-Gg: AeBDieuBUNAOalCXTCyuq2LGsM92GECT/6/MOmNATAqIenFG45unn889J1oulD0PdFD
	TpnoAoZFrdjXZGo+CSY8HIaP/QfbO+xLQlkp75Gi6OBvAuLfzQO4lqv3Ai+nhLfIMTPNmR4jGEr
	B2BHqqOLdvzsoW4zERcZY6USfg0xsOCp9ZVSf64zlw3YISiq5BnIXjt0uQwce0Vm4O3twPd+NfQ
	n1dKvOSZninjdh6oNi3XmRTxq/QvkWu6zIFODRstf/ftPmk2tJ5OGGH+1fa1fElpSeIkBgs/3GN
	2OiL9/Yff5yUeGUJs9lqOrUOjyJjEfyDHsS+98oM/mbL75/q00MJwxjL7hIk0UToh2G1yqD3eEq
	ZlL4uVsT4SQ==
X-Received: by 2002:a05:622a:5516:b0:50e:6054:bc with SMTP id
 d75a77b69052e-5100e123e63mr20740371cf.16.1777352967583; Mon, 27 Apr 2026
 22:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428025505.768-1-nashuiliang@gmail.com>
In-Reply-To: <20260428025505.768-1-nashuiliang@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Apr 2026 22:09:15 -0700
X-Gm-Features: AVHnY4KQrlQONcJ2TvqThFJvlmLqk1wA1sLYTaro2-g0tiSL7NAHuE1Rsu0Y2Z0
Message-ID: <CANn89i+H=gPo22v0ApLges0ScjMOgAcVsDQLwkr2iAEu+M7B7w@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: reduce RFS/ARFS flow updates by checking
 LLC affinity
To: Chuang Wang <nashuiliang@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Krishna Kumar <krikku@gmail.com>, Neal Cardwell <ncardwell@google.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2D03447D76D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281623-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,fomichev.me,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Mon, Apr 27, 2026 at 7:56=E2=80=AFPM Chuang Wang <nashuiliang@gmail.com>=
 wrote:
>
> The current implementation of rps_record_sock_flow() updates the flow
> table every time a socket is processed on a different CPU. In high-load
> scenarios, especially with Accelerated RFS (ARFS), this triggers
> frequent flow steering updates via ndo_rx_flow_steer.
>
> For drivers like mlx5 that implement hardware flow steering, these
> constant updates lead to significant contention on internal driver locks
> (e.g., arfs_lock). This contention often becomes a performance
> bottleneck that outweighs the steering benefits.
>
> This patch introduces a cache-aware update strategy: the flow record is
> only updated if the flow migrates across Last Level Cache (LLC)
> boundaries. This minimizes expensive hardware reconfigurations while
> preserving cache locality for the application. A new sysctl,
> net.core.rps_feat_llc_affinity, is added to toggle this feature.
>
> Performance Test Results:
> The patch was tested in a K8s environment (AMD CPU 128*2, 16-core Pod
> with CPU pinning, mlx5 NIC) using brpc[1] echo_server and rpc_press.
>
> rpc_press Commands:
>
>   for i in {1..8}; do
>     ./rpc_press -proto=3D./echo.proto -method=3Dexample.EchoService.Echo
>     -server=3D<IP>:8000 -input=3D'{"message":"hello"}'
>     -qps=3D0 -thread_num=3D512 -connection_type=3Dpooled &
>   done
>
> Monitor mlx5e_rx_flow_steer frequency:
>
>   /usr/share/bcc/tools/funccount -i 1 mlx5e_rx_flow_steer
>
> Frequency of mlx5e_rx_flow_steer (via funccount[2]):
>
>   Before: ~335,000 counts/sec
>   After:   ~23,000 counts/sec (reduced by ~93%)
>
> System Metrics (after enabling rps_feat_llc_affinity):
>
>   CPU Utilization: 38% -> 32%
>   CPU PSI (Pressure Stall Information): 20% -> 10%
>
> These results demonstrate that filtering updates by LLC affinity
> significantly reduces driver lock contention and improves overall
> CPU efficiency under heavy network load.
>
> [1] https://github.com/apache/brpc/
> [2] https://github.com/iovisor/bcc/blob/master/tools/funccount.py
>
> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> ---
> v2 -> v3: patch net -> net-next
> v1 -> v2: add rps_feat_llc_affinity; add brpc tests
>
>  include/net/rps.h          | 18 ++--------
>  net/core/dev.c             | 72 ++++++++++++++++++++++++++++++++++++++
>  net/core/sysctl_net_core.c | 34 ++++++++++++++++++
>  3 files changed, 108 insertions(+), 16 deletions(-)
>
> diff --git a/include/net/rps.h b/include/net/rps.h
> index e33c6a2fa8bb..37bbb7009c36 100644
> --- a/include/net/rps.h
> +++ b/include/net/rps.h
> @@ -12,6 +12,7 @@
>
>  extern struct static_key_false rps_needed;
>  extern struct static_key_false rfs_needed;
> +extern struct static_key_false rps_feat_llc_affinity;
>
>  /*
>   * This structure holds an RPS map which can be of variable length.  The
> @@ -55,22 +56,7 @@ struct rps_sock_flow_table {
>
>  #define RPS_NO_CPU 0xffff
>
> -static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
> -{
> -       unsigned int index =3D hash & rps_tag_to_mask(tag_ptr);
> -       u32 val =3D hash & ~net_hotdata.rps_cpu_mask;
> -       struct rps_sock_flow_table *table;
> -
> -       /* We only give a hint, preemption can change CPU under us */
> -       val |=3D raw_smp_processor_id();
> -
> -       table =3D rps_tag_to_table(tag_ptr);
> -       /* The following WRITE_ONCE() is paired with the READ_ONCE()
> -        * here, and another one in get_rps_cpu().
> -        */
> -       if (READ_ONCE(table[index].ent) !=3D val)
> -               WRITE_ONCE(table[index].ent, val);
> -}
> +void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash);
>
>  static inline void _sock_rps_record_flow_hash(__u32 hash)
>  {
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 203dc36aaed5..630a7f21d8de 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4964,6 +4964,8 @@ struct static_key_false rps_needed __read_mostly;
>  EXPORT_SYMBOL(rps_needed);
>  struct static_key_false rfs_needed __read_mostly;
>  EXPORT_SYMBOL(rfs_needed);
> +struct static_key_false rps_feat_llc_affinity __read_mostly;
> +EXPORT_SYMBOL(rps_feat_llc_affinity);
>
>  static u32 rfs_slot(u32 hash, rps_tag_ptr tag_ptr)
>  {
> @@ -5175,6 +5177,76 @@ static int get_rps_cpu(struct net_device *dev, str=
uct sk_buff *skb,
>         return cpu;
>  }
>
> +/**
> + * rps_record_cond - Determine if RPS flow table should be updated
> + * @old_val: Previous flow record value
> + * @new_val: Target flow record value
> + *
> + * Returns true if the record needs an update.
> + */
> +static inline bool rps_record_cond(u32 old_val, u32 new_val)
> +{
> +       u32 old_cpu =3D old_val & ~net_hotdata.rps_cpu_mask;
> +       u32 new_cpu =3D new_val & ~net_hotdata.rps_cpu_mask;
> +
> +       if (old_val =3D=3D new_val)
> +               return false;
> +
> +       /*
> +        * RPS LLC Affinity Feature:
> +        * Reduce RFS/ARFS flow updates by checking LLC affinity.
> +        *
> +        * Frequent flow table updates can trigger constant hardware stee=
ring
> +        * reconfigurations (e.g., ndo_rx_flow_steer), leading to signifi=
cant
> +        * contention on driver internal locks (like mlx5's arfs_lock).
> +        *
> +        * This strategy only updates the flow record if it migrates acro=
ss LLC
> +        * boundaries. This minimizes expensive hardware updates while pr=
eserving
> +        * cache locality for the application.
> +        */
> +       if (static_branch_unlikely(&rps_feat_llc_affinity)) {
> +               /* Force update if the recorded CPU is invalid or has gon=
e offline */
> +               if (old_cpu >=3D nr_cpu_ids || !cpu_active(old_cpu))
> +                       return true;
> +
> +               /*
> +                * Force an update if the current task is no longer permi=
tted
> +                * to run on the old_cpu.
> +                */
> +               if (!cpumask_test_cpu(old_cpu, current->cpus_ptr))
> +                       return true;
> +
> +               /*
> +                * If CPUs do not share a cache, allow the update to prev=
ent
> +                * expensive remote memory accesses and cache misses.
> +                */
> +               if (!cpus_share_cache(old_cpu, new_cpu))
> +                       return true;
> +
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
> +{
> +       unsigned int index =3D hash & rps_tag_to_mask(tag_ptr);
> +       u32 val =3D hash & ~net_hotdata.rps_cpu_mask;
> +       struct rps_sock_flow_table *table;
> +
> +       /* We only give a hint, preemption can change CPU under us */
> +       val |=3D raw_smp_processor_id();
> +
> +       table =3D rps_tag_to_table(tag_ptr);
> +       /* The following WRITE_ONCE() is paired with the READ_ONCE()
> +        * here, and another one in get_rps_cpu().
> +        */
> +       if (rps_record_cond(READ_ONCE(table[index].ent), val))
> +               WRITE_ONCE(table[index].ent, val);
> +}
> +EXPORT_SYMBOL(rps_record_sock_flow);

We do not want to put rps_record_sock_flow out of line.
rps_llc_check() is probably fine, it should not be called often.


diff --git a/include/net/rps.h b/include/net/rps.h
index e33c6a2fa8bbca3555ecccbbf9132d01cc433c36..7e98918d8751eb824b7057cca9e=
5d40c28e5f18a
100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -55,10 +55,12 @@ struct rps_sock_flow_table {

 #define RPS_NO_CPU 0xffff

+bool rps_llc_check(u32 old_val, u32 new_val);
+
 static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
 {
        unsigned int index =3D hash & rps_tag_to_mask(tag_ptr);
-       u32 val =3D hash & ~net_hotdata.rps_cpu_mask;
+       u32 old_val, val =3D hash & ~net_hotdata.rps_cpu_mask;
        struct rps_sock_flow_table *table;

        /* We only give a hint, preemption can change CPU under us */
@@ -68,7 +70,8 @@ static inline void rps_record_sock_flow(rps_tag_ptr
tag_ptr, u32 hash)
        /* The following WRITE_ONCE() is paired with the READ_ONCE()
         * here, and another one in get_rps_cpu().
         */
-       if (READ_ONCE(table[index].ent) !=3D val)
+       old_val =3D READ_ONCE(table[index].ent);
+       if (old_val !=3D val && rps_llc_check(old_val, val))
                WRITE_ONCE(table[index].ent, val);
 }

