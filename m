Return-Path: <netdev+bounces-280878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBNrMd6R6mmE0wIAu9opvQ
	(envelope-from <netdev+bounces-280878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 23:40:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A815457EFB
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 23:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57289300ACA8
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407DF306D2A;
	Thu, 23 Apr 2026 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT9kswB5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0493603F8
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776980444; cv=pass; b=ZaycrwI75U6ysRKgjX/6w3sA8trvB7Noc+ns52O40LekptWDwDyixV+KBXz76UhhZ9kInNPzPwKA35oA5AFMm1jfNVVQTRBa/fTvXCq/vYd74+HH9mnBqZa0TRwEr8JtTCo/3CiEX/kyzcqKvmJfbyy/HHCSGwCTYOOJ70mU6Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776980444; c=relaxed/simple;
	bh=LBaojAYoQTEOG485YZ+/4Sb1CgR+bBaYEXRwbg8I+Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QevDZXBng/K0EPda3NXJaNGSIV+aKz9Rah/2sBVvQUpg0D+RhXbKTOeqZNSPJX+8erOMRraqalTqQJDQPF2SaA1zmZwVlrCC6BZGaZG8DXSQizZnE579K5vmTG5TTMe4UamkNlvb0GxXe7C37pPSdz+GibB5+dXNZSnrrgyzZoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT9kswB5; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fc4425b6bso63779017b3.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 14:40:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776980442; cv=none;
        d=google.com; s=arc-20240605;
        b=NhxIZIhgIMe4HpfAh602ZcuIhuYtKKuH1fMFVLC3yfW3goApUORid4LH4WyHKUM2Qq
         twL8b8dIJei0u5lde5sB8JqAhJvwjtrFcqwPdzQPDruVy18Q8iRJcD2IUzP9mavgAQSq
         9kEIjFExR2YeuA0QMKeu6Iud5/8v4hPVnBKZ3B8yHeolQt0l3l2M2YUh4eOV3dXo3tL+
         hzljp3YpejMrelZBoC6FtUtmkZxwriITxwfN4yrQCHkyp/Fu1OT0YrxNtN+QAcNYmFjW
         PY6kPXK3qpAW8RqmB2Euw/XtwKoIEZHJ2/mrF87kNwEeR5pU/oNjuL9OiJf3DvZLEWJG
         djoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZkKWSdXKAjKaTvWAA3BKuowSpND4UX4TINDWGeSiV2c=;
        fh=V8Fl4VdT0t8CCdNZwIAGgiFgLpEO0Mq2ePPLawTKPcY=;
        b=gzncPPV40Ib7omAbYeNX2Z6TQbaqUfRccssIHpcSmOYIEqutPY4NQmxPFGlDmEXXYO
         4GvfLvyvtFE/HHbW2+W9umY2e3h1p7qjpw8+UBQi/iO/eSiLYKwvByv/Bxas4MWK6avm
         A6+vvJx2ui9esnheVhw2m8AS1+/GBCUlbqO9kyfMO7HfSDAJN6yUinstDs8HwUYoZJIO
         8NQtz7z4bv5zUm5txX7z9hUQIYsbptAHUB6Uy0wmwaa2dQSDTtKWqK+MWHFQtMgh6Dlt
         8M58OPX2PqVTTdrQyIegOkI66WtXDXWOnv0B1NmAJc6qUkCqeztlC3H7eC2zkyyClmA8
         s9dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776980442; x=1777585242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkKWSdXKAjKaTvWAA3BKuowSpND4UX4TINDWGeSiV2c=;
        b=jT9kswB5AbFqnbYQcNFbLRH3XsR6TChPt0dYn4uPvdgBQW/Qt8FuGNJEGzqvHL0qGJ
         1YpSp1usCZ1Q77V0+ESt20E1UZ6uQ4iQiEFUPMQQDDAJBv8svpgzgrDv01HYvJbf//k8
         7pZ3yK3tKaJcU3H/2cYRztdnA40hoFXgVTSkk7N2YS3RHWkrD8b1VmnHq8OG4p7h5hw3
         sSDE1VWNfhB63R0z1FNTiUdycOPem5vDHSrdqDpKrcvr3aNWLd4pmU/p6ZiAJFd998/i
         AdponXqt/Wq3vTi1dRuRm2FAd7X3C5T5PYOUQS93O8mZtcfVzLRBK0jFPP7ktVxnYm4P
         K8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776980442; x=1777585242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZkKWSdXKAjKaTvWAA3BKuowSpND4UX4TINDWGeSiV2c=;
        b=HYpTwpoXoJyLZj6V0uM07eI3fj3qdvPKC6B7WgYzsN9n17lGi7QR922uu1nMx5p3Q4
         FWnQ0iWVJGqWdqMigf84Vah8ELoBqD20WCmdXKFOIGMgN9YIE0n3Xzu7DawvifrfY1mt
         uvVjIH+ngGbuR7wKkXIulm+s+jRlwbc6r2z1Abmi7SntLsjBdQ1xJHoQyP6zJZIIzm6E
         pPH9uNRfuGxi0hKlFmWHUUNl8JSgqzX9rEkCjyDJzFknWzPlGFfQAkbvHYwvnKQLAXRX
         46TyPhe3TzYkQWEADC18UoYP2U+l0xleUCP5Ri6t1mJ0D1HWM4OGxJ+YckTSDHdLTuQ0
         1DuA==
X-Forwarded-Encrypted: i=1; AFNElJ9WPa72F16tkjhrxCc/LLF2dgP59RZMJFFzrE3cCA3OlIHPpI4KNV1JgR6o1Gfx6ZmcF/tRHC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxkwgKHXcuJ7hSlUsjTQ8HSlF2trj01bLRar4WgXfSCUC0e6jv
	xU1urxe+XOvunZ386zi6QZCwCWfqO2BdiLqvrRTbxdt637A9lEMb1IYj56kaXmMnwyasRfw/MbN
	j9oV6Mbke0eY8Is5T2NFUW3GDgdStmhHQMA==
X-Gm-Gg: AeBDiesXCWg1ST10WNuN30eh0nuO2b+2FLjNBZnBwPI0dLzgF5wMW4dzPkIIYPC6+/T
	5QqKpC4j7G/liNonmbqp7SZ0ds/gaucJzt0ezuZafM+ol8QUM9EKMH1+l5PNlW6mU19sltlu4C/
	lPlf8Vs90IDA2Z19vFzi+JvZuhEp+2HcLhNW0IbAXYKOcMCjWhpEVylKSnSQgh/sUGFKYTge4Zz
	S1cOu7Lkc9W7LcyNeIBA+LPhZg7Sl6RsL4ZIJXZwYEvwewZSBVEQOke8iq+mK+TZu30hlbOYDCb
	j3CtwhaWhpMX8klC40nIO7nqzK/rtxo=
X-Received: by 2002:a05:690c:9201:b0:79c:ff02:a048 with SMTP id
 00721157ae682-7b9ece6ad3fmr279055557b3.4.1776980441695; Thu, 23 Apr 2026
 14:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422065411.1007737-2-bestswngs@gmail.com>
In-Reply-To: <20260422065411.1007737-2-bestswngs@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Apr 2026 14:40:27 -0700
X-Gm-Features: AQROBzC34lSJnNThVZ-OV1TLMJPbKer-jB6dylzgNn1S8zHtGmTLEWl0Ij91Jec
Message-ID: <CAMB2axOjSHOBq2_3-N8eZ0twdth2MxtLs8sO9tYDcdE64vkekA@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: Fix NULL pointer dereference in
 bpf_sk_storage_clone and diag paths
To: Weiming Shi <bestswngs@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Leon Hwang <leon.hwang@linux.dev>, Kees Cook <kees@kernel.org>, 
	Fushuai Wang <wangfushuai@baidu.com>, Menglong Dong <menglong8.dong@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	TAGGED_FROM(0.00)[bounces-280878-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linux.dev,baidu.com,gmail.com,vger.kernel.org,asu.edu];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.298];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,asu.edu:email]
X-Rspamd-Queue-Id: 6A815457EFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 12:37=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> =
wrote:
>
> bpf_selem_unlink_nofail() sets SDATA(selem)->smap to NULL before
> removing the selem from the storage hlist. A concurrent RCU reader in
> bpf_sk_storage_clone() can observe the selem still on the list with
> smap already NULL, causing a NULL pointer dereference.
>
>  general protection fault, probably for non-canonical address 0xdffffc000=
000000a:
>  KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
>  RIP: 0010:bpf_sk_storage_clone+0x1cd/0xaa0 net/core/bpf_sk_storage.c:174
>  Call Trace:
>   <IRQ>
>   sk_clone+0xfed/0x1980 net/core/sock.c:2591
>   inet_csk_clone_lock+0x30/0x760 net/ipv4/inet_connection_sock.c:1222
>   tcp_create_openreq_child+0x35/0x2680 net/ipv4/tcp_minisocks.c:571
>   tcp_v4_syn_recv_sock+0x123/0xf90 net/ipv4/tcp_ipv4.c:1729
>   tcp_check_req+0x8e1/0x2580 include/net/tcp.h:855
>   tcp_v4_rcv+0x1845/0x3b80 net/ipv4/tcp_ipv4.c:2347
>
> Add a NULL check for smap in bpf_sk_storage_clone().
> bpf_sk_storage_diag_put_all() and bpf_sk_storage_diag_put() have the
> same unprotected dereference pattern, add NULL checks there as well and
> pass the validated smap to diag_get() so it no longer performs its own
> rcu_dereference.
>
> Fixes: 5d800f87d0a5 ("bpf: Support lockless unlink when freeing map or lo=
cal storage")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Acked-by: Amery Hung <ameryhung@gmail.com>

> ---
> v3:
>   pass smap to diag_get()
> v2:
>   drop the NULL check in diag_get(); The caller already checks smap for
> NULL.
>
>  net/core/bpf_sk_storage.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index f8338acebf077..1f9bd0005883b 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -172,7 +172,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struc=
t sock *newsk)
>                 struct bpf_map *map;
>
>                 smap =3D rcu_dereference(SDATA(selem)->smap);
> -               if (!(smap->map.map_flags & BPF_F_CLONE))
> +               if (!smap || !(smap->map.map_flags & BPF_F_CLONE))
>                         continue;
>
>                 /* Note that for lockless listeners adding new element
> @@ -534,10 +534,10 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_=
stgs)
>  }
>  EXPORT_SYMBOL_GPL(bpf_sk_storage_diag_alloc);
>
> -static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff=
 *skb)
> +static int diag_get(struct bpf_local_storage_map *smap,
> +                   struct bpf_local_storage_data *sdata, struct sk_buff =
*skb)
>  {
>         struct nlattr *nla_stg, *nla_value;
> -       struct bpf_local_storage_map *smap;
>
>         /* It cannot exceed max nlattr's payload */
>         BUILD_BUG_ON(U16_MAX - NLA_HDRLEN < BPF_LOCAL_STORAGE_MAX_VALUE_S=
IZE);
> @@ -546,7 +546,6 @@ static int diag_get(struct bpf_local_storage_data *sd=
ata, struct sk_buff *skb)
>         if (!nla_stg)
>                 return -EMSGSIZE;
>
> -       smap =3D rcu_dereference(sdata->smap);
>         if (nla_put_u32(skb, SK_DIAG_BPF_STORAGE_MAP_ID, smap->map.id))
>                 goto errout;
>
> @@ -599,9 +598,11 @@ static int bpf_sk_storage_diag_put_all(struct sock *=
sk, struct sk_buff *skb,
>         saved_len =3D skb->len;
>         hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
>                 smap =3D rcu_dereference(SDATA(selem)->smap);
> +               if (!smap)
> +                       continue;
>                 diag_size +=3D nla_value_size(smap->map.value_size);
>
> -               if (nla_stgs && diag_get(SDATA(selem), skb))
> +               if (nla_stgs && diag_get(smap, SDATA(selem), skb))
>                         /* Continue to learn diag_size */
>                         err =3D -EMSGSIZE;
>         }
> @@ -633,6 +634,7 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_dia=
g *diag,
>         unsigned int diag_size =3D nla_total_size(0);
>         struct bpf_local_storage *sk_storage;
>         struct bpf_local_storage_data *sdata;
> +       struct bpf_local_storage_map *smap;
>         struct nlattr *nla_stgs;
>         unsigned int saved_len;
>         int err =3D 0;
> @@ -668,7 +670,11 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_di=
ag *diag,
>
>                 diag_size +=3D nla_value_size(diag->maps[i]->value_size);
>
> -               if (nla_stgs && diag_get(sdata, skb))
> +               smap =3D rcu_dereference(sdata->smap);
> +               if (!smap)
> +                       continue;
> +
> +               if (nla_stgs && diag_get(smap, sdata, skb))
>                         /* Continue to learn diag_size */
>                         err =3D -EMSGSIZE;
>         }
> --
> 2.43.0
>

