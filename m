Return-Path: <netdev+bounces-52586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28787FF484
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF0E1C20A54
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F259C54BDF;
	Thu, 30 Nov 2023 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="porqdL/l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3051DE0
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 08:18:13 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b4142so13820a12.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 08:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701361091; x=1701965891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idRcfiVqF+E2cYXo+zQDkuWOz//BMA/8BirJ8n68Hf4=;
        b=porqdL/lLw6xHGqhkEilkdrBLpxpWizO6ZHcZ5z8hyblL8+8nOHoUEnSGUU7j7T0QM
         s22YTRKmxTa5ZtS8/lHeANI8tW3msEAQfbWxwXpk5PWcw8BKHPEbJAKGDOtUmyjIfPK8
         n3Y95ubqUqpfgE6Fiy4OJ0OzMyw0DQhrsqnDlc2oSPp34VyRqENzHalmOzXpZVn3CKwR
         /e1NaSBm4aWZvFx7yhEXYHtdNAenQLaAPTdgWkn9EVCNoU4ZC6keX70v9qBF8BCM4yeM
         Nbr1KY4HumzEQcBF0LdADCtxw2qdxBdi3OFJ6EdueuXUH7gaw12AwCl2oUdH4UaG0Rnx
         IWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701361091; x=1701965891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idRcfiVqF+E2cYXo+zQDkuWOz//BMA/8BirJ8n68Hf4=;
        b=agP1TQ1VhRXlkyDW25HlVJd27UJJw7t7LKjYcfZcnPn+sDwdZreME3dqzoTDiZnilY
         /YEMjwoK3vDs2nDAgHNrEjnou3Gy71/BsfgO6BTxodx4/hTlnFj8vjs4UsTrgAmGl1Dg
         51Fodps5JIskSEtWtHLknzWwUj1YZ0HgR6MEQOQ0a/ncgCrH4ptZAnnsERMgFAocSE2t
         MyWHbbwLx0BZ59R5Ikuz1mpuo4qzttPxsWZHQ5HAKik130yAmjEDbBxePu+3b1b0itW+
         LgUKyqoygTugelJKuGSgafF+BiraNiypwzaHRhaoAVAcWXILITo3qylgIHdqBMEfoHO2
         QJxw==
X-Gm-Message-State: AOJu0YwdLdnK/OKwhbtB5IpagR9CdgtP1ISDBbMz8LtCJF1zoWSUNjp9
	IckT1RKIm3c1Ykhjk/9BxV4foV04SXGqTQx4uDpYKoMZzw7GUZyvL5s=
X-Google-Smtp-Source: AGHT+IHL8EJFNcjxZizkXkpMV5LlaJ/kUzJFvFaNoEcsC+XVaGxftpXZ1NAIR0IsXHO9869ZZL92YxiFQZVjqIlF3+Q=
X-Received: by 2002:a50:d60f:0:b0:543:fb17:1a8 with SMTP id
 x15-20020a50d60f000000b00543fb1701a8mr170416edi.3.1701361091373; Thu, 30 Nov
 2023 08:18:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49a05d612fc8968b17780ed82ecb1b96dcf78e5a.1701358163.git.gnault@redhat.com>
In-Reply-To: <49a05d612fc8968b17780ed82ecb1b96dcf78e5a.1701358163.git.gnault@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 17:17:57 +0100
Message-ID: <CANn89iJ4W3DSGVm89CQ8yz=VYyLeCY4_4cOJuGULoxft8ezO-w@mail.gmail.com>
Subject: Re: [PATCH net-next v3] tcp: Dump bound-only sockets in inet_diag.
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Michal Kubecek <mkubecek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 4:40=E2=80=AFPM Guillaume Nault <gnault@redhat.com>=
 wrote:
>
> Walk the hashinfo->bhash2 table so that inet_diag can dump TCP sockets
> that are bound but haven't yet called connect() or listen().
>
> The code is inspired by the ->lhash2 loop. However there's no manual
> test of the source port, since this kind of filtering is already
> handled by inet_diag_bc_sk(). Also, a maximum of 16 sockets are dumped
> at a time, to avoid running with bh disabled for too long.
>
> There's no TCP state for bound but otherwise inactive sockets. Such
> sockets normally map to TCP_CLOSE. However, "ss -l", which is supposed
> to only dump listening sockets, actually requests the kernel to dump
> sockets in either the TCP_LISTEN or TCP_CLOSE states. To avoid dumping
> bound-only sockets with "ss -l", we therefore need to define a new
> pseudo-state (TCP_BOUND_INACTIVE) that user space will be able to set
> explicitly.
>
> With an IPv4, an IPv6 and an IPv6-only socket, bound respectively to
> 40000, 64000, 60000, an updated version of iproute2 could work as
> follow:
>
>   $ ss -t state bound-inactive
>   Recv-Q   Send-Q     Local Address:Port       Peer Address:Port   Proces=
s
>   0        0                0.0.0.0:40000           0.0.0.0:*
>   0        0                   [::]:60000              [::]:*
>   0        0                      *:64000                 *:*
>
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>
> v3:
>   * Grab sockets with sock_hold(), instead of refcount_inc_not_zero()
>     (Kuniyuki Iwashima).
>   * Use a new TCP pseudo-state (TCP_BOUND_INACTIVE), to dump bound-only
>     sockets, so that "ss -l" won't print them (Eric Dumazet).
>


> +pause_bind_walk:
> +                       spin_unlock_bh(&ibb->lock);
> +
> +                       res =3D 0;
> +                       for (idx =3D 0; idx < accum; idx++) {
> +                               if (res >=3D 0) {
> +                                       res =3D inet_sk_diag_fill(sk_arr[=
idx],
> +                                                               NULL, skb=
, cb,
> +                                                               r, NLM_F_=
MULTI,
> +                                                               net_admin=
);
> +                                       if (res < 0)
> +                                               num =3D num_arr[idx];
> +                               }
> +                               sock_gen_put(sk_arr[idx]);

nit: this could be a mere sock_put(), because only full sockets are
hashed in bhash2[]

Reviewed-by: Eric Dumazet <edumazet@google.com>

