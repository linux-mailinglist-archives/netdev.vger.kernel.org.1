Return-Path: <netdev+bounces-306848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OpHaOMc4UmpINQMAu9opvQ
	(envelope-from <netdev+bounces-306848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 14:36:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 322F7741871
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 14:36:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="MQ0eUdX/";
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306848-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306848-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE297301225F
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FA037B012;
	Sat, 11 Jul 2026 12:36:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3D2D0C94
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 12:36:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783773380; cv=pass; b=fJHY68J+vr9yj19Drfk2VqbiMWWSG9NjQmE2JywmFypqwUwLVSUkSUffjVxBobZnu2mP6/f4UguD6Dla5KEBl7Y7yEg1Ux+1TbluPru14um+7fabsbc8ZeRg1z89wYBrFJoiWmsAwdb0JBaqZRQL0KUlHAIwCuvit57JW2egkUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783773380; c=relaxed/simple;
	bh=SySi6wxUjqMlb54PMbePhqAsSdMDQniN9v3lzfJ0YBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KH1xFdVxIWEHJ7PQsTQm9PnFAjUEhR4fnyZhW2Q5EQrWsO9LXV/OMQP4CHtcg3pXUjPJKJUfYmSJ8hV5yvH0g9OL9DCSGLDdfzn6RDu3hxJCbOHg5SgCOu1YZChR5fKKEo5L2eWFZqjoEp0BjxljhFW/jbmAhfwcVKI8IFafumY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQ0eUdX/; arc=pass smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cabc0a1ab6so22720475ad.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 05:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783773378; cv=none;
        d=google.com; s=arc-20260327;
        b=ABFNvyTw1QF6RZYQv5Enwsf/IgFkUWpYiXq/sl6zjxxQIR1hgJIvcgbBfB7qCMpy1k
         S4J6T9HyYMrp6taWgOjL6h7GAvw77i82hh5PIkycdum7g0ExMxM3Vwvh5mzYxU+H9QVp
         5VPB5GpbGJL5gWkDNkoU4s2y362zLLH56MVxj9XJGGZD+9Ax60+Alp25t1hWwljKERgX
         JmRFrSzjNlztEuJz8G1JO3AiVHrPB4m1a3SAaip9TAjsmoDoqDKpu92YD6rW+YYy6OMT
         WFFjkXhF1utYm9+aHPecLH3r+TGvWmT1MxAaw6G6RQxj/y6dff4/aVTJeCBjdrpSnZ/l
         MD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p3UIKxrSmu2n2Hpeaq2hgsK+CnJAUQ4ug/QP00PQNO8=;
        fh=dJw97ISd2fx7fIYE30lbo2f2i8MBs5+aOtlkCmCCDvI=;
        b=c45wWZFgRVkUpLUPV0j5qJnYu/uOElLHvMulGTi87mupZreupg0eWDW4aNfzxr1tnF
         dl7yGhcz37pE2eqRiKqybu2xST0ucsHaAlhqnY7bmx9P4EuutWNOeaEXSS+3DuQtHdl5
         mCyOrdgtQopORrFp6wKVPhv49M8FBW6/33IGolUJ99a/DyEEK3l0pidQMptteBgBYMlT
         2043xH8YzOAWoXxQ8KOKsoZctuG/RanmMgI3djtvJuFhAR57tcK+N6OE6BDcrO8Odx0s
         DuCCNkG5sSrotNs8MNsLQiUk+f1kY7tBQsVMfXs+/7EL5TkmVcnQIwGPrkbAPvUTYRfC
         B8Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783773378; x=1784378178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p3UIKxrSmu2n2Hpeaq2hgsK+CnJAUQ4ug/QP00PQNO8=;
        b=MQ0eUdX/oniybHA+rDpe+ptxDmMruUTmcmIIOOw3AgiH28xBXVMUwJS8dbNMB9u2LS
         maJyrlSVk9CjK8fLh22CXbV/vui7wjRQ82KWYNtdVPok6kUzx8lbRaetLGY0FMVi8A17
         wqGPoAWA45XW+Sn0+aWx1pukoIu72QWLKcA/g1oeskMWq7IpjAQYahnRuMF2oO8Zpl6y
         XSmUylgv+ofZMqpzjeTP50fLAD7MbGPKHZ2n2btvmoDL15sWAMx/e89J9RZtyFAVqsRP
         pNpmsJ7QyyjTOMS2cl3PdGe0AiCnRzDy/7waPCck5a53602HlJrG0rpX71pZaogDI13l
         9ejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783773378; x=1784378178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p3UIKxrSmu2n2Hpeaq2hgsK+CnJAUQ4ug/QP00PQNO8=;
        b=E7gQLxcMXhLqNSxobeXHid1pqkIITBhOZMANJc7/NtFWbo7xgEm/YdKd0GrII2ZpHM
         NhA1gSsPrAlmktvNgH12Nt07WhwM3feQaj+xS6tsSEWAD83+0an+hMlbKhfjSooC/DnV
         1W5rPRj9NVgIgzYSw3YXfLF6U4V14ziE0vkmOcwAEniT0U5fw1o1U0Ks4CmcBHsTbRsc
         ykZPpE2D1c1iOGq4C+Kv+ASc4xpbobG/Tua9f5ZASJ6KoQjVROqGMpdMeF9E1VRHrDKG
         pqpYAyfEgEu1DrTYwcP+5wajdsLhJVQ65yqbiXgACTrvllUvmXb0TFrBchoAUyn9lvTa
         neog==
X-Forwarded-Encrypted: i=1; AHgh+RrpLl1zleg19/GBFsPMbtMOVNTJmn4s83NemSYdYwfkneinB4c8Gt848zPaqr8k6U9EGoan87Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2jrGSQTteouorQLuufXuRtJ1Phw7zwfdTAgkQ+VyS628VI+lB
	lkKYmd4e+BnGRPUomQ5iiTWVcTye/shXsSkBe+CncMYfVj76RZc6FiLX2f7v7rwSwA5iXKNNO/6
	/6flGCK0+MuyTeuY4guZgyPBsONPiUC88V29zbbr7
X-Gm-Gg: AfdE7ckQWQ2WRLzK7jweffytcbBbyuxi2JwW/n58VCBER2bpxd+WJUc2dTDSnB6VtCx
	ac6zwHNK9uyZOc4gqbNk/VK3kHypYZ2JHzVU2reVy/WniUy7iykiWBJ+ujA7ER0HVaqZ7LkA0Zm
	So1R5cnJyyvVjVtP8hgOvYOYO0767hPVkHJT4G+auKR8FWe5T3kqZJC0tm+Lat35WSPQX4eJukh
	tWS9Ls1R1NQknNIWQiCM5at+/b147NxC+HeaZgTfVJ+MeOBrUq6DM4Pl0RcLq6Wrh1NHpzalgxG
	qyCY/1vQPM0aYp9WiaFQbLcj8c2vEqz058pn4QqYt8jObeA4K8FF7kxug/JrseUu6ND+KgJ6Bmq
	XiHwgt6KNv22v0Rx/g20Pn4Xdeb1Kuj0DcGAzoEAoBO3dUq5147qR
X-Received: by 2002:a05:6a20:72a5:b0:398:6ea8:21d2 with SMTP id
 adf61e73a8af0-3c110a69208mr3046148637.19.1783773378103; Sat, 11 Jul 2026
 05:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620-bpf-iter-tcp-refcnt-v1-1-883bf9e69495@linux.dev>
In-Reply-To: <20260620-bpf-iter-tcp-refcnt-v1-1-883bf9e69495@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 11 Jul 2026 05:36:05 -0700
X-Gm-Features: AVVi8CcfTyzxfkzbvbHTzEquulsluAfF-rDOUv_47ONGcdu5G8dIKhY0LEnBX3Q
Message-ID: <CAAVpQUDiLwSYwFStRGpMQkGbm3j8_KJm9LVj0ykV7V3nYQ4YTg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Ben Cressey <ben@cressey.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jose.fernandez@linux.dev,m:edumazet@google.com,m:ncardwell@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrii@kernel.org,m:yonghong.song@linux.dev,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:ben@cressey.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-306848-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 322F7741871

On Fri, Jun 19, 2026 at 5:33=E2=80=AFPM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> reqsk_queue_hash_req() publishes a TCP_NEW_SYN_RECV request_sock onto
> the ehash chain (via inet_ehash_insert(), which drops the bucket lock on
> return) and only afterwards refcount_set()s rsk_refcnt to 3.
>
> Lockless readers such as __inet_lookup_established() account for this by
> using refcount_inc_not_zero(), but bpf_iter_tcp_established_batch() uses
> plain sock_hold() while holding the bucket lock, on the assumption that
> the lock guarantees sk_refcnt > 0. That assumption does not hold for
> request_sock:
>
>   CPU 0                                CPU 1
>   -----                                -----
>   tcp_conn_request()
>    reqsk_queue_hash_req()
>     inet_ehash_insert(req)
>      spin_lock(bucket)
>      __sk_nulls_add_node_rcu(req)      // rsk_refcnt =3D=3D 0
>      spin_unlock(bucket)
>                                        bpf_iter_tcp_established_batch()
>                                         spin_lock(bucket)
>                                         sock_hold(req)   <-- addition on =
0
>                                         spin_unlock(bucket)
>     refcount_set(&req->rsk_refcnt, 3)  // clobbers saturated value
>
> which surfaces as:
>
>   refcount_t: addition on 0; use-after-free.
>   WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x48/0x90, CPU#1
>   Call Trace:
>    bpf_iter_tcp_established_batch+0x14e/0x170
>    bpf_iter_tcp_batch+0x53/0x200
>    bpf_iter_tcp_seq_next+0x27/0x70
>    bpf_seq_read+0x107/0x410
>    vfs_read+0xb9/0x380
>
> refcount_warn_saturate() then saturates the count, the publishing CPU's
> refcount_set() clobbers it, and the socket is left one reference short.
> When the last legitimate owner drops its reference the reqsk is freed
> while still reachable, leading to use-after-free panics in e.g.
> inet_csk_accept() or inet_csk_listen_stop().
>
> This reproduces in seconds with tcp_syncookies=3D0, a handful of threads
> doing connect()/close() to a local listener while others read an
> iter/tcp link in a tight loop.
>
> Use refcount_inc_not_zero() and skip the socket on failure, the same way
> every other ehash walker does. The listening hash is unaffected as
> listeners are always inserted into lhash2 with sk_refcnt >=3D 1, so
> bpf_iter_tcp_listening_batch() is left as-is.
>
> If every matching socket in a bucket is mid-init, end_sk can stay at 0;
> advance to the next bucket in that case rather than terminating the
> whole iteration on a stale batch[0].
>
> Fixes: 04c7820b776f ("bpf: tcp: Bpf iter batching and lock_sock")
> Reviewed-by: Ben Cressey <ben@cressey.dev>
> Assisted-by: Claude:unspecified
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
> ---
>  net/ipv4/tcp_ipv4.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fdc81150ff6c..92342dcc6892 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3074,25 +3074,25 @@ static unsigned int bpf_iter_tcp_established_batc=
h(struct seq_file *seq,
>  {
>         struct bpf_tcp_iter_state *iter =3D seq->private;
>         struct hlist_nulls_node *node;
> -       unsigned int expected =3D 1;
> -       struct sock *sk;
> +       unsigned int expected =3D 0;
> +       struct sock *sk =3D *start_sk;
>
> -       sock_hold(*start_sk);
> -       iter->batch[iter->end_sk++].sk =3D *start_sk;
> -
> -       sk =3D sk_nulls_next(*start_sk);
>         *start_sk =3D NULL;
>         sk_nulls_for_each_from(sk, node) {
> -               if (seq_sk_match(seq, sk)) {
> -                       if (iter->end_sk < iter->max_sk) {
> -                               sock_hold(sk);
> -                               iter->batch[iter->end_sk++].sk =3D sk;
> -                       } else if (!*start_sk) {
> -                               /* Remember where we left off. */
> -                               *start_sk =3D sk;
> -                       }
> -                       expected++;
> +               if (!seq_sk_match(seq, sk))
> +                       continue;
> +               if (iter->end_sk < iter->max_sk) {
> +                       /* reqsk_queue_hash_req() inserts with sk_refcnt =
=3D=3D 0
> +                        * and refcount_set()s it after the bucket lock d=
rops.
> +                        */
> +                       if (unlikely(!refcount_inc_not_zero(&sk->sk_refcn=
t)))
> +                               continue;
> +                       iter->batch[iter->end_sk++].sk =3D sk;
> +               } else if (!*start_sk) {
> +                       /* Remember where we left off. */
> +                       *start_sk =3D sk;
>                 }
> +               expected++;

This should be incremented just after seq_sk_match()
(see below)


>         }
>
>         return expected;
> @@ -3129,6 +3129,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_f=
ile *seq)
>         struct sock *sk;
>         int err;
>
> +again:
>         sk =3D bpf_iter_tcp_resume(seq);
>         if (!sk)
>                 return NULL; /* Done */
> @@ -3167,6 +3168,10 @@ static struct sock *bpf_iter_tcp_batch(struct seq_=
file *seq)
>         WARN_ON_ONCE(iter->end_sk !=3D expected);

Let's say the batch array was smaller than the hash chain length
and we reallocate the array based on "expected" w/ the bucket lock.

What happens if refcount_set(..., 3) is called during reallocation ?
bpf_iter_fill_batch() will see the larger "expected", and WARN_ON_ONCE()
will be triggered.


>  done:
>         bpf_iter_tcp_unlock_bucket(seq);
> +       if (unlikely(!iter->end_sk)) {
> +               ++iter->state.bucket;
> +               goto again;
> +       }
>         return iter->batch[0].sk;
>  }
>
>
> ---
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> change-id: 20260619-bpf-iter-tcp-refcnt-107d52b238da
>
> Best regards,
> --
> Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
>

