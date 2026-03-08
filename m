Return-Path: <netdev+bounces-265246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF5oGCQjrWkGywEAu9opvQ
	(envelope-from <netdev+bounces-265246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 08:20:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B771A22EE61
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 08:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5CA83017C0D
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 07:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07C6285CA3;
	Sun,  8 Mar 2026 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FOu54YRR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773201E1C02
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772954400; cv=pass; b=P7aIRMYAu6jQ96EUVsVneJ6wWxDq5qMkIgwKDnNvHZPVjRtP2yEGvtN32NGGKFCPtUXB/0Q+M0R+mXg6nvjsW+cukcr2t8fPKm+TTxfWxUEK51rl6lKmcZEsCCskPdMXSHgT5aX32628hIzFk6oW5awIv1PF/jqMJ9Cjqt+Njss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772954400; c=relaxed/simple;
	bh=SNKXVC1wFEakODjmG+oKhGWcgC/kn6oshw7URu3rry8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BU9pxKYQcCeH3t0DHqPRjDK9hRGxsOZHuNLxZh8OjPTiV7f2TeQi04cilzZez+jMQ85MvX6TbKY4mJg7iMTttxB2UNU5beCWBLaCHHHrOggxjMJ3/zEJ5r+3nHVqAyaGZeC6ai26ujn/YCwQR0UDETYt1L6jJxWUSM+GBbQ0k4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FOu54YRR; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899d6b7b073so115917956d6.2
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 23:19:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772954398; cv=none;
        d=google.com; s=arc-20240605;
        b=YAn8jpON2VDOH1QEzTjBayScaKEVlcDkA4r3NPdApVuT9Sxri3aOPkOhkrT0hqX+qS
         KKp+mcRWi10i7zXJNXDelm1WgnFfA1NCLgjAj3+s8QSNvZx3DGD+T17kPt4WP7mtR4Pe
         Rp0sUduYz11h7MCmjHB/Xwz2EePc4y9bWviqCJRRk4Kfpi1iCVEMX/j9EpsIA9o5NUrl
         F7qc9XbkArX8f4HOBsNhDYiwDYSQKFUfaY1/b0p93EwRGJkhKBm2L7JEOPIhJkoZ/iBh
         OKcl6DKPsFfPQvX1VPuxVfLLqdx+ST5VYXgu3tsqTG2olMZPQHoAiYxf8mXn1CUZfOSx
         WYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f4ppOcbrWUJXPlbrh+y+Arr3u3lMue97JxPQJZdMh+k=;
        fh=eJxi9c2fiowOr/B3oyxTtLKR0Q0qXA1tj0P5jDD0NHQ=;
        b=JPuUDrkz0Z+k7A+8tBob565dAtHF1c5Puwoi6xclR/k16fKhgUECr/ia8nFe2bnDn5
         DQJpW//I/GLHG7s604Z1Y9o9UvutfuL3S6nmuw0LzI/iGEsMa9Z0DuNmwiuKxioJrqsQ
         fNE6wZNkV4m+G4qt26nDop8qWSCpr8CwwlVTyshHPYcJk+RF2e6PoCCwqNJC11p/QQJN
         9sUd+vyhQwOLslH7QWu50kjxE5WhKZWjZZoH32NZy+iSjQbJUq9PVjTzULRFfPHGjepP
         TO3kdoNETo0CH6HZ0NHJKu8xVejPvIuo0wWS2aXXlTCqDcwA93AcTWPZJ9b9O+/Yc3Kf
         y/sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772954398; x=1773559198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4ppOcbrWUJXPlbrh+y+Arr3u3lMue97JxPQJZdMh+k=;
        b=FOu54YRRzIeWrqXjJYRJdP02mBveoshNPR3r+abyOLIRGrQX/l1uGi+mLYDTD0sqdP
         ZP32sbqJbpzwYFpwXlm/0WTWAGj5GXJlrv7hAAO988B6i584wgK0z8mFUe9qo01uwykO
         AbFb9iTVsbdU3mVh4P1a2TxpPUVkY0T3p0pt/Gl5PLZ+6+fuSvAoL8q65GUeoY4ZNKCe
         JK2E3iimdpP78o67SqVgRWYSeEh1YtBAbAdcqKCu6vizeW0ZBRgulJWvxzKJ9pWnZMsB
         4dMEEep2t6oN8V9UBmoFwHsHJ0tftkl9VXUbzEX4Ko9xTEWp8trjsEz2jVPxGl40yJ6p
         h7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772954398; x=1773559198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4ppOcbrWUJXPlbrh+y+Arr3u3lMue97JxPQJZdMh+k=;
        b=VNBm8RmAEnG1nlnBG6qcK9sDIex7NZnVZGOOvEx0+Ric3fvFJ5eE0JAQSkB01d4zGG
         3jUt665ms3xiN7rJ2wRAVJUjpPQUhCMMLETPhwjGl7Aflx0+CNzSrezAFQ7ls7UtWFuW
         EuKJ/sEFtCdAuQlxKindAesNkMg1JKT00wkCdFnt3q/KrsKBLgpEAcfWNSqQgBoTqmBy
         5pjso7JQI4g/G3yLQ4UaTbQYGHTINjiDj0I72vyNuORb+P2KgO1XZ2HepNFf6pDLIPha
         ZRUMmTyqySKgS3GMG8PLCMyIy1ZwTAL6Vp76e2LGSoqtnWbmlmatSzjCYcwKvy6h69Ra
         46uw==
X-Forwarded-Encrypted: i=1; AJvYcCWV3RoSTzhZAdc0rR1UTBvEITzTHEGLhpxnDofVXjatyf0dBUTaSGRLImeaFP2PPfwy7ME9sSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtjhWJz18jFzFmY+F76mjFNPQV39ZlCz/9yg0DHHwfv/us5n2N
	n4wlkPOiJOosd7oTB5usQLjgfuRjrbLK7pX0eUlasm+peVEOJ+67CnyDRLVQllQGWxTmsxHknjP
	SddfEURG/obo6rptWJlElnk64c6MxeyC6SVjSiB7n
X-Gm-Gg: ATEYQzxFslF+Ry/p7N+IoGNeAP02tNVzD2pbfIg7ypncb1snMYud6rsriXEPeIvNerZ
	9suT+QF4IACMewubIJKacArHhlFxdFRXTXtzRaW4QXi8Sk4L9glKGtErOjD1hPHq42w5XqBJkH2
	j9jOiIC+tUJQTCGK0wP6PLLFxu8RpO7ADp/SxS9xkmNb2bxXMuX2zZlSkF9U9VKUdJYza5pcOGx
	rtAY0h1Gr9Im7CoZz7lzSFrln5lBkvBIq4nAEFqnFaqwl7P5MDSwkLLEL+Mltb0hQJa7ROxLZH3
	pfdxaUJ9
X-Received: by 2002:a05:6214:da5:b0:895:7864:f69d with SMTP id
 6a1803df08f44-89a30aa0ce4mr117614696d6.40.1772954398043; Sat, 07 Mar 2026
 23:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308070925.58939-1-nashuiliang@gmail.com>
In-Reply-To: <20260308070925.58939-1-nashuiliang@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 8 Mar 2026 08:19:47 +0100
X-Gm-Features: AaiRm51cwJ30HnmgcjUxeNPc9DgwjGTuar6mO4vzPzYPJoE9scmH_9hc2BtI6K4
Message-ID: <CANn89iJYiyp4dwA+Ye=7ySgQZaPnL=XfoQ4S4eXM-gs3pP+keA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: reduce RFS/ARFS flow updates by checking
 LLC affinity
To: Chuang Wang <nashuiliang@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B771A22EE61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265246-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,fomichev.me,google.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 8, 2026 at 8:10=E2=80=AFAM Chuang Wang <nashuiliang@gmail.com> =
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
> preserving cache locality for the application.
>
> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> ---
>  include/net/rps.h | 17 +--------------
>  net/core/dev.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 16 deletions(-)
>
> diff --git a/include/net/rps.h b/include/net/rps.h
> index e33c6a2fa8bb..2cd8698a79d5 100644
> --- a/include/net/rps.h
> +++ b/include/net/rps.h
> @@ -55,22 +55,7 @@ struct rps_sock_flow_table {
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
> index 203dc36aaed5..770cfb6fe06b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5175,6 +5175,60 @@ static int get_rps_cpu(struct net_device *dev, str=
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
> +       /* Force update if the recorded CPU is invalid or has gone offlin=
e */
> +       if (old_cpu >=3D nr_cpu_ids || !cpu_active(old_cpu))
> +               return true;
> +
> +       /*
> +        * Force an update if the current task is no longer permitted
> +        * to run on the old_cpu.
> +        */
> +       if (!cpumask_test_cpu(old_cpu, current->cpus_ptr))
> +               return true;
> +
> +       /*
> +        * If CPUs do not share a cache, allow the update to prevent
> +        * expensive remote memory accesses and cache misses.
> +        */
> +       if (!cpus_share_cache(old_cpu, new_cpu))
> +               return true;
> +
> +       return false;
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
> +
>  #ifdef CONFIG_RFS_ACCEL
>
>  /**
> --
> 2.47.3
>

Interesting idea but:

1) Some of us do not use CONFIG_RFS_ACCEL yet.

2) You put a very fast path function out-of-line, why ?

3) I think the behavior should be selectable with a static key or
something like that.

4) Please provide benchmark results.

Thanks.

