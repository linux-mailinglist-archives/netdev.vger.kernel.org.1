Return-Path: <netdev+bounces-272011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BgWKeoixWmC7AQAu9opvQ
	(envelope-from <netdev+bounces-272011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:13:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3D433509C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58DD7306C0F8
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B3D3CE48C;
	Thu, 26 Mar 2026 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fq8jan2p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B73F7A91
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526772; cv=pass; b=SgM8BvexH7f+aHSWtXJJRrj/7ldzy/slq+EtGCfxkKRdsQjLZqHNk9HwdyvasYK6gl6n0jHchNl0Rwpq1frOB0LCIId2sQhTFUhgzGiY20VWkI04+dQQDb794KXkTPrs1kNQrmnzrOPV1Q1hqtSHntn7HQr2UFgoq0KnytG25wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526772; c=relaxed/simple;
	bh=eQT/gEmkCe5NS4qcXKP9zjHQDG+jtJ6p8AUq96WTtf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMGdgI1XFP2jlnzlGj0MBKWMex3W3vTEMre9dl9wGrXxKGFVQpHskDq7PRrLbR6sZinicq+VxBHIiQ8dL+L6wvbd2si56wPQ74EOGZVc4ANjwXqYM487qUXE7DBog9k8N9PvnLaR/klo+xq5i6eP1EJSOnKr7hSNexwd1ZQ3M+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fq8jan2p; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cfc137464dso121552285a.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774526769; cv=none;
        d=google.com; s=arc-20240605;
        b=XAFhSa+DRxHJ3ts3mSW2GY9DQ730eTDU4neJCbr3CKjNRBAlxVb2XZ6CQ+hRf1Ipg4
         UE9QQGCVNagGbHikYWAfFujenCWsOwBdIRk8X6mTBe99YwHxQaqjZ3F2XEjGiWUO7WGx
         uID9BJkzpfHaNSfBJ5ZB8iL+B/JhKBnCSPP+fqndOjVUcOylyby9MiQQGtwWo/3Zmb2w
         Kbn3qtoCTCGLyH2LZgzto/tCFvVMM8Qqa/FAHU8XZOXm31ihMUOvpvk71wLkDPJQFYSw
         Yvk/p/fHELJMKNzirpCFb953xL6eagdEe0g5nVDRy6060Kglal1BXR2hEEoSrpqwYtNM
         wJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m0dyGS7det5IYP95uObW2P54x5YYQotdkxhUwpKFMwg=;
        fh=F3+5zFgpA8YEzhp5DQ1YhlWa6HEzOVIJL5RGJuLI8Nc=;
        b=SBWcewNAEiKCje4iJhgeVMrv51z7yfupamYVhWVY3+uE8eHQ0JSRE8EhfRJIF5Mnb9
         zhDFvuk9TlrUhIiW4QVkrex0nqCs20zCAQ5drWA3C8T7MwxesGy8hQaD3yRJp/A3gtOP
         4tDO197uKq1G9E5QcIMlVuETzrOpkJ9uaNpeRZblWGK+3TrNNgUVBmotctFYUCLPEMuf
         ybRPZUvv8tB/9huwKNuImIf924twN9cgeSBtGdLzhHsCBpxrxuJDbKqo+/ULCah0mrdu
         OTql075ZRgNAXdAqJRHPw8qEnyZdAaLmhOgRFpirgg6epsyqNKezpJ17vv8bagfz8X8d
         X8iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774526769; x=1775131569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0dyGS7det5IYP95uObW2P54x5YYQotdkxhUwpKFMwg=;
        b=fq8jan2pyt4IZDN2UL1/Br/dTPKG3pDU56IB/wPwBHTf7hs2QagRZpl7zO3rYZPfLy
         aVvI1dmEc/4Q3DVs35KwjTFZ33RsB/yfK46wXUv1SoAhf0oWo0fplQa1vMAY1sM2Odb8
         CMP1II1r+5SC+r6AZI+rqyzb4dcQ76C5uIu2KgSqv6mmzlrhOCRs8qev1zAL+i6TSwYM
         jTWD1E+Umdm6M3iQgy5cje1I7wlA9nvtAFU4irgxKdjs2K+hi0CxvFrPQijZrnQ8fZN4
         sb22axSnl/A+ORt+Na2TWWoGTkjqq/vyt2qmT1yxRNLa7kLLvrurKJ/CAap077miK5ha
         jXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774526769; x=1775131569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m0dyGS7det5IYP95uObW2P54x5YYQotdkxhUwpKFMwg=;
        b=gQZY4XmtJePUMeytx5n29M8yhSgGgsgnWxTLYeJHozudTUG6R0bJajjXmj7EJTjz4I
         ZoQNSoBXp+QWxjcoiK9L50HqCCthH9wK2gNl+90JmIPAJb6kIeoDf7dY2mPXGg6pkNw6
         JMboEMAjEKVzphHeWDr6gtXnomy/Cn0DzQ4HVnV2A2YgPo2tWOupt68ADrcAG2notJeT
         pm9JJVPxkczQU38JUCDqan02OEMr7TBL/qzZ9RjMeje+yD1yKApC/cKnsvM2wzhpjDsf
         QotQ64wThk1D8Cu9IZyR16erDIt7IH+BGOciEuXOEUGFA3Uil07y6tq9TOi93lPRsfyS
         8Z3w==
X-Forwarded-Encrypted: i=1; AJvYcCVAXZ32l2XkMuKTM25cdXg4+4kUchtFFna1CgLgdh8xQXXYpF0to2k3PewHcGa41PKJyqtp12g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywub7BXXTpQTDPt9A6MakAWH0Z68Vv39m3IS20GOFKg9j+pMZpU
	w7vPGfkEQAWXkoVke+fePK9TYi1GWDTgZ2Xiy2STyih0C6T4FFG4ylLCd01V4GQYcXAB5wFxbQY
	T/tzOO7i5Y2t76arFG3HdvYAs0UuxC2mKaO5i8szp
X-Gm-Gg: ATEYQzxdYqeVYy8fmW3cXJPftjxXv8w30yz7fZxLNoPDTUKeYB16SSCVHoIh0UM5//u
	K++UCQ9CVfwUv35QAmoQoUcTmkST6PkcJRQnFc830Tqf8OzkW1KVPzRyd0fBe2UXLVvRAbRpEop
	6VCVI6PKCyZM8hz+N+OmbOyLydZs7zxgIm4t0ZUYEU5np5JzZauP3/WYV/LMExGeM+99bfTeRVL
	HUyV8KJ+cReSXuftphfHkpqyYRKbNknGZQeVd6n0h8bZucPZNuzR8PrsAsPvPYIOZhtW4HnFut0
	iuIm9A==
X-Received: by 2002:ac8:43cc:0:b0:50b:6c59:7172 with SMTP id
 d75a77b69052e-50b80e9eb21mr68435801cf.62.1774526768586; Thu, 26 Mar 2026
 05:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-b4-fib6_metric_set-kmemleak-v1-1-c89fc1b312c0@gmail.com>
In-Reply-To: <20260326-b4-fib6_metric_set-kmemleak-v1-1-c89fc1b312c0@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Mar 2026 05:05:57 -0700
X-Gm-Features: AQROBzBUxrK4YRyT-DzwWB8t2rKERWjMpNrNJofUo_hFT_UxxHVGFhc9uKj0hZY
Message-ID: <CANn89i+SX1Kp7D2JzzEtg-zRkJzi4bdjzc2snvM7npJQzNp0+Q@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: fix data race in fib6_metric_set() using cmpxchg
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fei Liu <feliu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272011-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BD3D433509C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 9:22=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> =
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
>
> The dst_metrics allocated by the losing CPU has refcnt=3D1 but no pointer
> to it anywhere in memory, producing a kmemleak report:
>
>   unreferenced object 0xff1100025aca1400 (size 96):
>     comm "softirq", pid 0, jiffies 4299271239
>     backtrace:
>       kmalloc_trace+0x28a/0x380
>       fib6_metric_set+0xcd/0x180
>       ndisc_router_discovery+0x12dc/0x24b0
>       icmpv6_rcv+0xc16/0x1360
>
> Fix this by replacing the plain pointer store with cmpxchg() and free
> the allocation safely when competition failed.
>
> Fixes: d4ead6b34b67 ("net/ipv6: move metrics from dst to rt6_info")
> Reported-by: Fei Liu <feliu@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/ipv6/ip6_fib.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index dd26657b6a4a..64de761f40d5 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -730,14 +730,16 @@ void fib6_metric_set(struct fib6_info *f6i, int met=
ric, u32 val)
>         if (!f6i)
>                 return;
>
> -       if (f6i->fib6_metrics =3D=3D &dst_default_metrics) {
> +       if (READ_ONCE(f6i->fib6_metrics) =3D=3D &dst_default_metrics) {
> +               struct dst_metrics *dflt =3D (struct dst_metrics *)&dst_d=
efault_metrics;
>                 struct dst_metrics *p =3D kzalloc_obj(*p, GFP_ATOMIC);
>
>                 if (!p)
>                         return;
>
>                 refcount_set(&p->refcnt, 1);
> -               f6i->fib6_metrics =3D p;
> +               if (cmpxchg(&f6i->fib6_metrics, dflt, p) !=3D dflt)
> +                       kfree(p);
>         }
>

The following line should happen before the cmpxchg(),
 ->metrics[X] accesses also need READ_ONCE()/WRITE_ONCE() annotations.


>         f6i->fib6_metrics->metrics[metric - 1] =3D val;
>
> ---
> base-commit: c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f
> change-id: 20260326-b4-fib6_metric_set-kmemleak-7aa51978284a
>
> Best regards,
> --
> Hangbin Liu <liuhangbin@gmail.com>
>

