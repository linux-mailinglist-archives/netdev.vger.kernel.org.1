Return-Path: <netdev+bounces-274210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMjbFHRezWlncgYAu9opvQ
	(envelope-from <netdev+bounces-274210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:05:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B703737F025
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70898300A135
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68880477E2E;
	Wed,  1 Apr 2026 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tBSgTCyi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E8E3F0A95
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775066156; cv=pass; b=uUXnekSQ1xXe9SftVMhDo5kSY/JM2nWbttYCPFRIFPLkt3vo01k7xg7h1nfLLM4mVOJYoREmjv0et8uVZNS/Gqzwmoj3JhsnBTjCiXcDelMEv2xIwhfS98WyUsVFoBr0Cd/+HFcw/TyqNWKpChn1jEmBbKCbSNn+XV/PGuE0+PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775066156; c=relaxed/simple;
	bh=or+76jn0FEoxZEDgs+blLHXOCDPDP7ryQ+3bXD+Frzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaEZPP+r48vVFX4hQDa05h1OYx5FB9Bnsmyue62qQ5JBgq04IumIPKEZo2Vhu1aD9xhUevOpD1Mz8olPhRNjWQxd5+poPq3nmYekzqo1Y+wKsgZOO3U6UJH0uThCGSrHXmPK4HjIYBwVngNZXw2jyLcgynGTMzfaCRguuGrasZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tBSgTCyi; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50bc115f206so45657401cf.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 10:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775066154; cv=none;
        d=google.com; s=arc-20240605;
        b=OY+MdGlIyAzM9WEp6/e2CNOe9ZJNwDaVLE6Zbs9Toh60BfBvQBN5iFlS7V8x5lDyAX
         x5vJtKXUFhssaLoQ834+xypDBIsWOApkWPLJ2iMC0QspXEMQperAFnlgYo6UWyINvMIg
         mZCHP5sm4ZUypvVCIaub9YbQMdOMMsmXI6o7RVAwA1846kbFtdt9lsHf8QrzDthT0EJQ
         bNYQWOmWCSwGZakW7er7sSbcZwGe7PCoLYH66WoZVEo3cGcLmKOZ8JN4OMg5SKrhAhfZ
         0Skdszii9WHYwwa4IzxtIou1KlOB8aPZoGcxGHFqSY3HsR9VH6Kk5PuevZ7TD4LeZCqg
         rDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5f1ZMUupkXFCrIPzu5rcRwP1FQ10ax+bVT0RwJQ98gI=;
        fh=jOga7ab3goxWkMUOQ6A8uAeRKqAlaY6Hjq2F57HXnxY=;
        b=kIbRK1PEdmTlARsxNToOQeXov8NesGMqMqCF8mQ4T0WN5hdKqXr6T9OCpp/4ztk24g
         oe0TYPZKfjkheCxGaR1EqsYvprp3LrFTA8aNb0kgQhNjnUFyv2DJNzlNqtns6Gcu7TRf
         PePumXk+z3t48z7BqELfyJR9a6+QX9bXTTo20B4bFPfF+Rerm73pv1FLHR/a/JhNxbty
         svzMA1M5XtVHRdHGBeLrT9lXpu9N0jj7wrKMw2rHkkzepFl7uKbv/DspFEvzPFuZlwq6
         MCyd7yHFUtNRkzfzWy427QZunbhnSI5D+MPUw6zFVpK+zMS1By2gt/573hrJ9udgMODe
         4qXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775066154; x=1775670954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5f1ZMUupkXFCrIPzu5rcRwP1FQ10ax+bVT0RwJQ98gI=;
        b=tBSgTCyigyoWP+38RxgG2uGbjYRVuNcw45zhFQMOz6pNopTmQnR3iA2uDb+7hWPKQr
         PY+Z4gp63K71tbUSCqjrGK1TigD19jXI3/oTN8PxHF7bQ5pS6YfRAI0pjvC8It06ab23
         i/WkAPJBOMFoCf75O0k+WqROhWTcGkHmfZ2r/8M/IUxybZZWcv9QnZlEV74EqZ2eAuh5
         rBeWq/hBnqfB3jkvi/BS6rzuLq1IJzamMebQFyhWhw+roJAmw+icD06Ze/RZCU5JD9kI
         gtVLPiRULxf+Fe7hqZgKYbmhrgGF51SX2qOmrLArsOtQq2Ni6DaIPVXI/Ono9W9m4dek
         wddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775066154; x=1775670954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5f1ZMUupkXFCrIPzu5rcRwP1FQ10ax+bVT0RwJQ98gI=;
        b=Kf5W+4DxWClHZ0mzWcK0H6ql5Wqxaew1bareqP3UeohQHgQDHGJcXB1cMFGZMez03I
         PnQO2R+iXNhU3Ei/kM/8g2ZowGpYbXIyIzvgd5W3alhMJ6jQFw/Uz14J523LWxowPEi3
         FCbH3Qem/79DstE2eXKjafl7hvPPtbQg019DqmC0UP20IImMwpqR/9Kmdfo124apz03w
         pqO2TvcV+AWpIlR0SOpO/3iYFzdxsCVYj7dTmv3Hg2tDK8QWSGSVHQ/OaNfItH9yAefs
         wFDM5AwSgjjuFsKB7lr6oMZgr5lEIZJ4gj+4AGiRMssvER0gpow2W0kSU+UVO/W/gfLZ
         z/cg==
X-Forwarded-Encrypted: i=1; AJvYcCUp8OnkT9llt49OKz7FpM1ZF7Kl5fO9DiAiQ7TvZzGxFcVWJH6DNnJtLv/byI83N9qHp8OfW/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu1yxJb9BX7Lya0tXzbFuzDnXg4O1f9JOqE2+qg829a8WvubLj
	e1GHP0p2hrDErY5BelOKPzoDZXm+ijo8zKCTq/N5k0B5uWDZB8DMyI27PL13vZjSCP+3sLc/AXz
	SWMx/IQcYppJh5bOBA9LRtEhnkaKIVqdKIoASC+NZ
X-Gm-Gg: ATEYQzw2FcPTyEt3nZ/XvRLx7APbf8f4T9GA/hHLe7G13rTPJI8amylAcwhVQ4Pecq7
	vgDFMVVNxZ9sX/RHTUhJIUKook0gLYGcL+tjrTa17qlE8jLUM1vCy1bRpMv/cjYfxHlje36I4vQ
	a5DNywnT29Oz5Va9ROQfR5G/KfunlG2MMQ9XW2NwrRlLGOz01zxKp71pssm7/oS+hVNzMDprTPu
	GIYiz8PIzq3Hi6YvdbNRABTxmgFePs8bJU1NLLkWRnnJb1BOTjC3ykqvaAikPzBXqyp8Oc86xY4
	JzRwaYFg
X-Received: by 2002:a05:622a:1f0b:b0:50b:444c:e268 with SMTP id
 d75a77b69052e-50d3bc0fdc0mr63521811cf.19.1775066153285; Wed, 01 Apr 2026
 10:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-b4-fib6_metric_set-kmemleak-v3-1-88d27f4d8825@gmail.com>
In-Reply-To: <20260331-b4-fib6_metric_set-kmemleak-v3-1-88d27f4d8825@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 10:55:41 -0700
X-Gm-Features: AQROBzB8byDrfYKWEL9jcZ3-PWb01mI87_i8kLwZS7R7xUpjFXIQVz4OHYdrbZk
Message-ID: <CANn89iKKAVYq0=F0ry-UVLZMcvmCzNvQRFPBPOgJhdF5qaM0xA@mail.gmail.com>
Subject: Re: [PATCH net v3] ipv6: fix data race in fib6_metric_set() using cmpxchg
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fei Liu <feliu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274210-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,linux.dev,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B703737F025
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 9:17=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> fib6_metric_set() may be called concurrently from softirq context without
> holding the FIB table lock. A typical path is:
>
>   ndisc_router_discovery()
>     spin_unlock_bh(&table->tb6_lock)        <- lock released
>     fib6_metric_set(rt, RTAX_HOPLIMIT, ...) <- lockless call
>
> When two CPUs process Router Advertisement packets for the same router
> simultaneously, they can both arrive at fib6_metric_set() with the same
> fib6_info pointer whose fib6_metrics still points to dst_default_metrics.
>
>   if (f6i->fib6_metrics =3D=3D &dst_default_metrics) {   /* both CPUs: tr=
ue */
>       struct dst_metrics *p =3D kzalloc_obj(*p, GFP_ATOMIC);
>       refcount_set(&p->refcnt, 1);
>       f6i->fib6_metrics =3D p;   /* CPU1 overwrites CPU0's p -> p0 leaked=
 */
>   }

Reviewed-by: Eric Dumazet <edumazet@google.com>

