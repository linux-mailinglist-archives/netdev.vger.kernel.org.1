Return-Path: <netdev+bounces-305232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 53lfBCApTGp3hAEAu9opvQ
	(envelope-from <netdev+bounces-305232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 00:16:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAC5715EB8
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 00:15:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=everpuredata.com header.s=google header.b="hJ2/TI3r";
	dmarc=pass (policy=quarantine) header.from=everpuredata.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305232-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305232-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0FFC3037E75
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 22:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4FB36EA98;
	Mon,  6 Jul 2026 22:15:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AED3F888C
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 22:15:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783376109; cv=pass; b=szJmYJfO7kI0e4uBh1MF7Ezez013a/0IC9nUWownlqDmw27bevTIzTft49x3LIKFhnbLM+b8RemMuHBGgQo9mkBDMYwJCx1/pHw0aDl0hukPUf6EicFK8kKOCz4rF1gB3bA5zKv7sc55qf8nF8h9rMlRLFlkf9vZ3C/+n5jkxFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783376109; c=relaxed/simple;
	bh=ArrZuExoWTtFDpj0spA5EfcfXBIxqxWTPFerCos0KFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLViu9PD71CThKaQCKBbY/HM6kJAwOi2aqqX7ECYuZbzQDtLAsHPiUbVLbdXQahnfTANrQMfZeL3bKcPk43zwUnaGgkQKg7wtRYG6diYem09/NSqTdTKnRCs+mYkjS61RhxUCvT6Zrk095jaf//UVS7ZYlkv//w+cO39HY2VIaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=hJ2/TI3r; arc=pass smtp.client-ip=209.85.217.52
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-736eec08c43so28220137.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 15:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783376104; cv=none;
        d=google.com; s=arc-20260327;
        b=tDwYPVHfVOLwI1gqfXrsOhTNV2+1yesxmVO2hrwWsgTO9ZiMIyMaBv0QOU5DASFoUX
         bbsr6yUISIAne/XN8VO2pLS9CM6VWXn23CJZ2kqbPbrrwUks0/5JNaqzxqdRIk0ZCizv
         yfSwwubfTs/C9oT4o8ap4SchDqJ4jI3aVQGf6MpJa2VX65yNgDc7uS28kJLJJfpecSZM
         c6xiBDNbvUdtUiVsfixdosUQJBANE9B3wxxXZp7oTHYumPoSVom9ngdQSMPHE96Sh7GR
         yE/zSjhXvkVX1thLE1o9YcYBh7Y8BXtRUUFyrOEaAJZVZb4D1iZxewHmw+r8YDngDDP/
         B+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=30tQGHtDF9O2XTWbiEvjPHEb9UkwR8PjZGM3FgjJWJQ=;
        fh=FUIhD4asJYerNBKkfkgbix6hL8USxyes+blvPCoeJnA=;
        b=E9FxGvB2Oco5DgG7/SQ2WvDSMwpIXULiXfW7u5L/9y2uqMcwUQOZ35qqRvUERtj9Aa
         XTmhlsLNXfNL9EBEBnZtNxWUygptGOT7m3hTv9GygkrfBZtwQ+A+QXvfG2FEcam5C3va
         mffxBV06QH/Ro8qa8f2IEa7uWmBh/mcYiKsyaKyUcCf22MgsCgwwcy8h5R0I3QmjQR2m
         7SbfzHmhbN5CHzOTZ3IvwGsaSFWcd0oT7MBIkg3cIReQnZskKMaZuEUcTOiiYZ/KZ8V2
         pv9XxzcVNeKfvVYrU+vDnMoMO7HEgQQH9ENvkjC8Jqv/5PGdfm7MtnQRI3icfIIzWzis
         F25g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1783376104; x=1783980904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30tQGHtDF9O2XTWbiEvjPHEb9UkwR8PjZGM3FgjJWJQ=;
        b=hJ2/TI3raZJ43BZ6ddweIcLzrW93JvTMXjqZIQdvnIvEdcOwjVuimgxspwFoO0pCMt
         LYy4XJ+yiYL3JJudYbg4fiI4Q9uOL+2ELNpQ859QHAlUP/FZOfCVrl19wNpjtQgxD8vn
         3k+/txcCBCgGLhI9aRvKp3kt9Ug0e8pyCnT0HW8LAGDKFrBfKr5/S6Jmcn1Bn89Cp1N7
         OOxbnBLctQufn58EsN8hQfoUoHMLH/ip5yRl5ItfUki5RebkUOwYCMGGq+NGbpnDTT44
         1qHsV3ZJ+PRT4NvebEo8a/Zj+igKehGZcdC2unVxYJ2FNs885BmPKfUbtujsD8DCMhCY
         Cu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376104; x=1783980904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=30tQGHtDF9O2XTWbiEvjPHEb9UkwR8PjZGM3FgjJWJQ=;
        b=RIwtJlGTdrSTtZ/VOQGnj5bc5worHpdmjtRswY17qm0AMaH0FXoLhnU01ymWuRGXBh
         esmToYJitgF/Ml9E+rAjNT/nxbZgyewBy7Ybk2N60eYxN0ThINIVobhHE2CBxMdNtjKU
         9cwfgcgI1VQQDqD2xeKgl2eyAIKjxhvziTZfI/rEBVwNxpNoMqzh0YiF9uyS51dxOSSr
         oj5dm4UlH9R2nNt+nEu16MTWIZoVBaNRfJ1aKWq2kLTlIWsEfltryGSoXbOzKKXIuSI5
         9y7LTSqW0fOqS0ujisjbIHH44fAbFBDVTTAQkuZRYid5G4O/vC2Mi4fYyOxJWwZ+xEp1
         lXwg==
X-Forwarded-Encrypted: i=1; AHgh+Rqyydi2MTMJfsRGCYo2VKdROk2V6GJ22gncdShTSEMiSsw5WGVJt/gqvxj50uMnf2YZFbLlXsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2kV3IBSQ1X3VraeLD5C1u6cd4I5o3dQdzq68H5Zrd5aeWBCO
	J3EVoGZRoVhKEqigYbEFkHc+Vd4mG82OmrAHVKxEPYre+bxd58qvxolwlrgfQbkWIqRFoBn1OH2
	mZQPIeASl4RJs24l32i+2dQSlZdLG9XjJFzesuKG2gw==
X-Gm-Gg: AfdE7ckzs1Q7xM+pooHoqWvGwxraQm9JT2xrLLJgWKA38BBbbtQZNcf+SefLc+1UGvB
	JXAxz7EQcMsSQEUjDjFaQ3Rbxko7o8ZfRzHSvJVY1/DVZ4X0UIMppc6tzoRG2XRyCYX3YSqf3gK
	lUST9SgZhfLHJ90Py+Ho+XMbGORQdo7NAsfQIdqkzNY15CEml7c0Vd0UpI7Kf2ReG0DGcCEk09N
	AwQZyWheG+06rrPBPmJ/PSeD3CKfdV9C3D2i4YPTlaGktVT9nsD+J2400+g3h6qNXoVMAmV4HaO
	cfwdR8xJIROTlDxyraZtTN+9g6Zv1QhkD7wfOVRJBNsA6lm0hQ33Vm6Gb34e1mtIZ/tDLmM=
X-Received: by 2002:a05:6102:3752:b0:740:2664:800b with SMTP id
 ada2fe7eead31-744c230b74cmr102945137.10.1783376103518; Mon, 06 Jul 2026
 15:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515212715.3151307-1-rjethwani@purestorage.com> <20260627210635.89769-1-nils.juenemann@gmail.com>
In-Reply-To: <20260627210635.89769-1-nils.juenemann@gmail.com>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Mon, 6 Jul 2026 15:14:52 -0700
X-Gm-Features: AVVi8CeN4t1HTguUIIhEzWA7k_mp1sVXyxDPY1mLFNJihpAK2hch87k1BF9EHHQ
Message-ID: <CAKaoeS3Yg=kncNQRRcVh8JrQXy4Aah=3fuBwcitD6mjAEJOKOw@mail.gmail.com>
Subject: Re: [PATCH net-next v14 0/9] tls: Add TLS 1.3 hardware offload support
To: Nils Juenemann <nils.juenemann@gmail.com>
Cc: borisp@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, leon@kernel.org, mbloch@nvidia.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, saeedm@nvidia.com, 
	sd@queasysnail.net, tariqt@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[everpuredata.com,quarantine];
	R_DKIM_ALLOW(-0.20)[everpuredata.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nils.juenemann@gmail.com,m:borisp@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:leon@kernel.org,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:saeedm@nvidia.com,m:sd@queasysnail.net,m:tariqt@nvidia.com,m:nilsjuenemann@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[rjethwani@everpuredata.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-305232-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[everpuredata.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@everpuredata.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,google.com,gmail.com,kernel.org,vger.kernel.org,redhat.com,queasysnail.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FAC5715EB8

On Sat, Jun 27, 2026 at 2:06=E2=80=AFPM Nils Juenemann <nils.juenemann@gmai=
l.com> wrote:
>
> Hi Rishikesh, all,
>
> thanks for picking up the sendfile/EOF fix in tls_device_splice_eof().
>
> Separate issue we hit while testing, looks pre-existing in mlx5e
> rather than v14: a NULL deref on the RX offload path. Trigger is
> ethtool -L <dev> combined 32 (down from 64) under HW-kTLS load,
> then a TLS_RX offload setup:
>
> BUG: unable to handle page fault for address: 00000000000031c0
> RIP: mlx5e_ktls_add_rx+0x268 [mlx5_core]
> Call Trace:
> mlx5e_ktls_add
> tls_device_dev_add_rx
> tls_set_device_offload_rx
> tls_setsockopt
>
> sk_rx_queue_get(sk) returns a stale rxq (62 here) after the
> reduction; mlx5e_ktls_sk_get_rxq() only guards rxq =3D=3D -1, so
> mlx5e_ktls_add_rx() dereferences priv->channels.c[62], which
> appears to be NULL. The resync paths index
> priv->channels.c[priv_rx->rxq] the same way. This path is not
> TLS 1.3 specific.
>
> I do not have a proposed fix yet. Happy to share the full
> decoded oops / additional kdump details or test patches.
>
> Thanks again,
> Nils Juenemann

Following two patches should fix this issue:

Patch 1: net/mlx5e: kTLS, Reject stale RX queue mapping on offload setup
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index bca45679e201..232e998a8f24 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -620,12 +620,15 @@ void mlx5e_ktls_handle_ctx_completion(struct
mlx5e_icosq_wqe_info *wi)
        queue_work(rule->priv->tls->rx_wq, &rule->work);
 }

-static int mlx5e_ktls_sk_get_rxq(struct sock *sk)
+static int mlx5e_ktls_sk_get_rxq(struct mlx5e_priv *priv, struct sock *sk)
 {
        int rxq =3D sk_rx_queue_get(sk);

        if (unlikely(rxq =3D=3D -1))
-               rxq =3D 0;
+               return 0;
+
+       if (unlikely(rxq >=3D priv->channels.num))
+               return -EINVAL;

        return rxq;
 }
@@ -673,7 +676,11 @@ int mlx5e_ktls_add_rx(struct net_device *netdev,
struct sock *sk,
        INIT_LIST_HEAD(&priv_rx->list);
        spin_lock_init(&priv_rx->lock);

-       rxq =3D mlx5e_ktls_sk_get_rxq(sk);
+       rxq =3D mlx5e_ktls_sk_get_rxq(priv, sk);
+       if (unlikely(rxq < 0)) {
+               err =3D rxq;
+               goto err_create_tir;
+       }
        priv_rx->rxq =3D rxq;
        priv_rx->sk =3D sk;


Patch2: net/mlx5e: kTLS, Guard resync paths against stale channel index
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 232e998a8f24..c0676148a36e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -343,6 +343,13 @@ static void resync_handle_work(struct work_struct *wor=
k)
                return;
        }

+       if (unlikely(priv_rx->rxq >=3D resync->priv->channels.num)) {
+               priv_rx->rq_stats->tls_resync_req_skip++;
+               tls_offload_rx_resync_async_request_cancel(&resync->core);
+               mlx5e_ktls_priv_rx_put(priv_rx);
+               return;
+       }
+
        c =3D resync->priv->channels.c[priv_rx->rxq];
        sq =3D c->async_icosq;

@@ -568,6 +575,10 @@ void mlx5e_ktls_rx_resync(struct net_device
*netdev, struct sock *sk,
        resync->seq =3D seq;

        priv =3D netdev_priv(netdev);
+       if (unlikely(priv_rx->rxq >=3D priv->channels.num)) {
+               priv_rx->rq_stats->tls_resync_req_skip++;
+               return;
+       }
        c =3D priv->channels.c[priv_rx->rxq];

        resync_handle_seq_match(priv_rx, c);

