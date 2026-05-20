Return-Path: <netdev+bounces-289807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBEANR1iDWquwgUAu9opvQ
	(envelope-from <netdev+bounces-289807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:26:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBFE588EC4
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF2753044213
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 07:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61696370AE2;
	Wed, 20 May 2026 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="elAByUqz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0437189D
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261946; cv=pass; b=EUDHjIQH29yiepNzYyGt00EYl79mkjW5S6EH8WmXMHfXkm17D2iYd49NhaPkdL1bdz0OGRigiEsmAOJvk/zU6f66oywyH/K1WFA3YO/RXmP0RRsMZO4jm6QDHbIyiqNNaeqJR1nSi29En6Rhdn4tZ9e3pCDb/llh39RhZr/qHWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261946; c=relaxed/simple;
	bh=DpuQ8Poe19voowdeiVQ8ziD67bSszQ9be7fcUPBKxIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idc1/3hkCj8dCGpHuEzW4o84YgVhMjgfXk5XHBUmrYIBoPNzTaFoTgqxvaWoqHxm0wgcWAYazASJCHDNs760pRa9GocrdanXifFRQSFgERLOAkH5eOEpKpmHugcSQKnexZ9pz8Hc5Yk3EZNWua5oCq2f4jBpt14W4LmgSJTvurE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=elAByUqz; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-90f850473f9so475416085a.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 00:25:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779261944; cv=none;
        d=google.com; s=arc-20240605;
        b=LE461v7P+I7zzzzJpJ0hvIUp7kwZzORUoJ/2naW9MHK+RZ3DDSeUQWWVJwh7bsA/QH
         ud0zfKWgkFYksX3bVC0zLrq+XqXV08FDDuU39GtyBgAdDTRvqUpgl6YQ9s5uvfnfQ+UU
         QtNdyc7zYfElXAk3SBaXCDXMCWYhzMemAHUo2rKRiC66+6ipXDiDOWhOkSG/4GGWdeZM
         mYMxQDr++RAA7+LZPfElXdoTdaPdcOFStkK4u9pQ9B9re+Wy8tGTEtW8gz4/EDsUcNDX
         Cu58EOEupoWX22TEZT9UUiCYKmf41U0V3KnqgZ7r/evlKhJqNYcDgUysNM3hhFAWplti
         XlEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=576nO/YV1iMXtGVxB8ckBZBIVkpdxC8JVKo+7JWN4sU=;
        fh=hNzy4O4tk2xeHhbcxz2d6lzTvVRCyXqa1b5K7LahNDg=;
        b=EaqIYKOA7uUNkYVuz4LN38NniwYSPATeIAQux7zNvWEWx5YWEnN1/GMEjJs+3CyxNt
         pLZA1oP0isBZfh0OJXK+pivTFtyPBSCN+Plm5nVN/wxU94PzTIcV+ewgwqAEjBzeq3tr
         YbuBzdhWs1/jo4VmXEHCJX5s0wAo3/jml4vkgfwR+xGr8bOpotnykBt3sfU286PnNBky
         Oc2OAaQeNkaJu5FQCRlDK+Is9opWJfVexQSUnBrGDHTTncVtd1UpQWiGazX0wuXzb9Jw
         5onydrYEoDIHcWd+HzOc5FIh5jR3QoWjlXAZo2Y6+hZvMzOj4nvnqWdhWdBil39coW81
         na6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779261944; x=1779866744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=576nO/YV1iMXtGVxB8ckBZBIVkpdxC8JVKo+7JWN4sU=;
        b=elAByUqzdu+FsutTNWjq7d88iJhdXgyI7+cBlKN4EHhS8S32JoSOMuiCFkRFdyTxvi
         t2x4Xy+C9oICuCwbE0mzeD7CbhpM+uFBjWrt64zaWc5jPDEZJUUIo628lJCdg2opSsVz
         0JEAX16jjsxrJkecHiLhH1xDr7LmuYAsQ8D3NNMf5tvoQNp//KEF6Fv8N7zmYCvED+j6
         8sL2ocEx+l4T0+6HREpFKdhttv+RmmXS4R0zl2bEAVyVnReZgmqQj1bnL1w6QBQwI3EI
         l+K2aTWhLKD3Z+UbDZJyEBGLH6jZm6ZDDbW8Rj8XSTnBIonoC78sW4KwifHNbV7EmZCK
         8s5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779261944; x=1779866744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=576nO/YV1iMXtGVxB8ckBZBIVkpdxC8JVKo+7JWN4sU=;
        b=KNAivCfAdur9cApDV8MuiOziVGRPwx7l3vBPjyLgR1ArwejjlYSATHQdcC5bEBSmXi
         XHEkkhCNehCKJuZu2tDY0lmtvT1KhQF7jXZNao6d/+rMFt23nC3Yn5APK0rk2W3H9yuQ
         pnnjGehlfFOFuq39cx3lyfOeeGblZXUNsCkajlZqrLCs25L9vDs6QzeUVOmr5fNZk6ub
         0eWTd2yt3RWDqtV03lr9muwYYguw/JkIMpCLLfcWATuk9aItfwazA3r15CbqQjEGXcuF
         r8tNyI9+TA0z43RcU8BUpQC0opEqH4CgDC/KmNMlSg9ptk0ulZ5wipbbq/ZM43IefDEp
         2jpQ==
X-Gm-Message-State: AOJu0YyIou3CRj3rly9xD+EOgqVZuydBRb9qI5SZl41U2EYEN0MWnDe1
	9KuQegAjZ4CJrJonv5HaDVyEfD+d8/Izyn2TnXNQQ440aBBdtSyaNZfR3TGBBH9fvYfs7UBBoWt
	KHpy9c8v6OJMoWR6zyfAhqc51jyJxRLytA5bQIywy
X-Gm-Gg: Acq92OFQlCqw+u11ofH6O4sZqOdDkVxkQVtuf/Afpw31IbjYyuQwCnOX8eBI+S/dZUV
	/1dwKkFU2v4qmJgrofNvyPTo/CYm03J3vreD0yno7CLMNOQYSqyHuH5YSkQWWqMmsQ4HHHV6Z77
	ormPyCbmA2bbIC4vv9Ullzv66Ajy2HAO//zOKgOX33UL3w+TD3sxJ63XKUIR7aF07tva3Leblem
	vb9TXvoEJETe+ccQj4OYcsqi3WSuccw0YLbBFvDf4RFpSp2f8dGTohdO/l9jOuwa5Q0oxEvCiF2
	r/PwmWVlA1VceCG+PdSqWsf7NVZlRVkaLpZV3ucu05fC8Wmyb84NWHcrysIMq5IUYP/oAE/9Ozo
	4E0iSJ/6y/BlVPmApR0l+SlTvawRD2wOcCDA7PNW0H17bTNWeH/5B6w4AFxPQeR5l
X-Received: by 2002:a05:620a:2685:b0:90d:b6b7:ca93 with SMTP id
 af79cd13be357-911cef0364fmr3314735185a.47.1779261943125; Wed, 20 May 2026
 00:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520064310.4154268-1-ntspring@meta.com> <20260520064310.4154268-2-ntspring@meta.com>
In-Reply-To: <20260520064310.4154268-2-ntspring@meta.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 May 2026 00:25:32 -0700
X-Gm-Features: AVHnY4JA5ULcAD8FHiBt5X7hD0S7aFEuUITtlQpIRKTp5El2DBtrGA8XL-7n_ec
Message-ID: <CANn89iLoHtMa+94G5NHC5L9Cp4dbkQPKnZneNo08ak4Z6ZzAtg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/2] tcp: rehash onto different local ECMP
 path on retransmit timeout
To: Neil Spring <ntspring@meta.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289807-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,meta.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8CBFE588EC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 11:43=E2=80=AFPM Neil Spring <ntspring@meta.com> wr=
ote:
>
> Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO, PLB,
> and spurious-retransmission events, but the cached route is reused and
> the new hash is not propagated into the ECMP path selection logic.  Two
> changes are needed to make rehash select a different local ECMP path:
>
...
>
> Signed-off-by: Neil Spring <ntspring@meta.com>
> ---
>  net/core/filter.c                |  1 +
>  net/ipv4/tcp_input.c             |  6 ++++--
>  net/ipv4/tcp_plb.c               |  7 ++++++-
>  net/ipv4/tcp_timer.c             |  4 ++++
>  net/ipv6/af_inet6.c              |  3 +++
>  net/ipv6/inet6_connection_sock.c |  7 +++++++
>  net/ipv6/syncookies.c            |  4 ++++
>  net/ipv6/tcp_ipv6.c              | 13 +++++++++++--
>  8 files changed, 40 insertions(+), 5 deletions(-)
>
>

...

> diff --git a/net/ipv4/tcp_plb.c b/net/ipv4/tcp_plb.c
> index c11a0cd3f8fe..accdd83dfc3d 100644
> --- a/net/ipv4/tcp_plb.c
> +++ b/net/ipv4/tcp_plb.c
> @@ -78,7 +78,12 @@ void tcp_plb_check_rehash(struct sock *sk, struct tcp_=
plb_state *plb)
>         if (plb->pause_until)
>                 return;
>
> -       sk_rethink_txhash(sk);
> +       if (sk_rethink_txhash(sk)) {
> +#if IS_ENABLED(CONFIG_IPV6)

Please remove the #if IS_ENABLED(CONFIG_IPV6).
Code will compile just fine if IPV6 is not enabled, and is not
ultra-fast-path anyway.

if (sk_rethink_txhash(sk) && sk->sk_family =3D=3D AF_INET6)
         __sk_dst_reset(sk);


> +               if (sk->sk_family =3D=3D AF_INET6)
> +                       __sk_dst_reset(sk);
> +#endif
> +       }
>         plb->consec_cong_rounds =3D 0;
>         WRITE_ONCE(tcp_sk(sk)->plb_rehash, tcp_sk(sk)->plb_rehash + 1);
>         NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPPLBREHASH);
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 322db13333c7..24c1c19eda6e 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -300,6 +300,10 @@ static int tcp_write_timeout(struct sock *sk)
>         if (sk_rethink_txhash(sk)) {
>                 WRITE_ONCE(tp->timeout_rehash, tp->timeout_rehash + 1);
>                 __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEOUTREHASH)=
;
> +#if IS_ENABLED(CONFIG_IPV6)

Same remark here.

> +               if (sk->sk_family =3D=3D AF_INET6)
> +                       __sk_dst_reset(sk);
> +#endif
>         }
>
>         return 0;
>

