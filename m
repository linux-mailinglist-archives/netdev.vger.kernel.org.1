Return-Path: <netdev+bounces-256791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAatGv+Og2lCpQMAu9opvQ
	(envelope-from <netdev+bounces-256791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 19:25:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB84CEB9B0
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 19:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97B7D3008E2B
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 18:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44B942317B;
	Wed,  4 Feb 2026 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="uK7+DlDP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2CA330665
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770229500; cv=pass; b=qaNtd6uZ6ggfAyJ0e9amauLB8hxo5k0H9TvAeAtFsG1jTj90FCJ7Def1t9pan3tLYQHUgNsvtkYGolYfWGB/1CrUgD62lmpdhScZr/o+wXBAJRMJaSMoJVrky2fYfXs24orjB1gsHMKYJnrxtqK3QV7siWdQ93A63QJZb9OXET8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770229500; c=relaxed/simple;
	bh=/wkLMsGtN0mKEqKt8yQ/dt93QcmkN79JCItUY+jQy4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3aj//ftHzlhkem8QCppTn9aOh/S8IirfsvYcvdK2CAQ/LFhmvK1X2I5/jHCUkQqLDbnVCPYNFTi9kIpTGBNg+nOMJbCKgDsVqhc0+utnFrTmbLdi7rwUV9ntA1D4cEoYW67YjZYkQX5GFr4t6va4TcBJxQA2HFbm35lhXaOW4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=uK7+DlDP; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82311f4070cso131494b3a.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 10:25:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770229500; cv=none;
        d=google.com; s=arc-20240605;
        b=cRmJOYFS4ORIyth3zqRJgxMFEkpKpuxjzpyDabE5QI1RiS24G2Nf4utTX7ni7yK3HK
         mPp/gd2g7sQd5/Jbsr9N+hEfBaWnU1bsER2aq18bYeLoEJdt07OobvJHESE4CtKxOmyv
         eSeG2lUwvIIs2tj871RmybQyM3BIuIcXrtF5veO+EeiRP1r6X7fNNhnv+Dbjyy1nOHn+
         p1nt0jgB7h531XMwuAG8ZCExX3Bu3VqHlNa8m2HsDkoN3EOMwtjhMGveDiPT7Jn9LDFK
         21Ey+OXax4Vjr4P5In0fFShZGVli4kMLtCwmby+79lc/hpTb0209VQ6BuQI2L7l+FyqY
         Rdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=96XLxFlmBveXvIXybUp4HXQqlp6dTh2TxHdljpJDzZ0=;
        fh=5/glgb+oiO7gQQLJwME/c8M5sYlhh8aRf4gdLctTr0U=;
        b=UQqdovMXHl/6aR73l3hkh6wseZ8vgo4/sGnLX/4rB241aJnUOB5JVlRaiHIH126AxQ
         3/ksP4hmLQTOYqarV+7muIKx+Bi58vTSx0Xrq2ajpDkyPusZDEBoneccrfC4RoZjYWt/
         XJUx//aIp2naEB6NJxC8z3GMcY0KanNIqefMZalezvemI5B3G3QUytT9qy4dxE1FOHtP
         IGMP9wIHSxsP47BB3GpWtoQ0A+kc13Ubq2hGFCkqm61Yejud3mokNgRV02UAGBuYLW3L
         4zqiIx3Q6aUAUIPsKmIptLtK04BqqwXCmf4RL9Zt+bkosAh3DaouIJhV5xVdkWq95k2t
         yGRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770229499; x=1770834299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96XLxFlmBveXvIXybUp4HXQqlp6dTh2TxHdljpJDzZ0=;
        b=uK7+DlDPBjcpFo4JcWZc5Ym7VKCrSvvnLp1Z+ai/stUx8B60Wrt4+kIKlvGZaIdBRm
         Vk6YE0d0a9Mvrgpwjn4mi1siFXG4v+qfMYAx3fB2F1qthAGMhSoajo9jI30QEuvIJ7xp
         I0fqykXDhKkIwo1PFoWwAIILsv4N2yP9wE1enKXnbMh11lbVvDsAPuk8n6BlttiV6Kqn
         HN1Hn5oEhhH1YinB0tI5EDmNzLPkhAq+lAYlYGSMpxVMKTRGp5qmIxViZUjh1ZGdLvst
         H4wb/3bUfb2Y0EaumvsY6KcxH3k3MzpnkKGu25VfVBir3zcAbn61TZsIjWmyFJ7pjhQv
         LyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770229499; x=1770834299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=96XLxFlmBveXvIXybUp4HXQqlp6dTh2TxHdljpJDzZ0=;
        b=k7D+INN09IlUBT7VObsmW4yHK5JNZd7rEYgMV/vKgeG/1jel4/iPwk5om4Ajdv1ibr
         AzVg2e/EFY4aBnLrAtfM/ppukEGHaWHVTyJqQsjScbN8SvJw6ob8qxHlG6XIX+w5zeMX
         KRHuGulPc2zObXCwYGaG/19rH+5uvDbH2+Ex0caPeBB57eR8EVHfwJKtb9VVflf9EuWr
         +kMmQSTfQsg2k2888FBy5rytE6DkNz5qNPHFqG56rNFFo7FfUbTZmR4qJ9jEZt7ckac7
         MLEP9dPbAxqF0UR28Yu4t/IgIb/RLOGINxrhRfeTK3gjN0InEHBMEpdH3v3hhlDLzPpO
         r9ag==
X-Forwarded-Encrypted: i=1; AJvYcCWuvI0xbW1pAnOntIVd9jlkGtM86ntVxe2r8StPWRHw/AsZRsl3+LNQOiJh3oJfzdpn9UsquOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHwyiQfXZZFzjrA7VgzYyK4ma0oQz2t1O+TKDLpfiywmVzbnUR
	OKVjc1XlXf9I2+IJiTi2v94gg74agify0f60IM9epBGvFq9QkB/6QNQBcVaPLpjD0B7BkLHsQUP
	ooNjU6ZEy0iR0ohoz0s4Z5TmJjdCuUP2kgMXA4NTwnfmY8tq9sDhIdw==
X-Gm-Gg: AZuq6aIw2uK3puDByBcx9ToB5e17BfKwpWWNSBs9F4tNrutYpcIIykinSANiturpA6S
	VKmlfkNz2gf6w7t0wgfl/bz4tYtCTrfHH7s/iQh7Vd12zBb9xMG2NmD7YnbC81YWTDN5KtFgEmU
	Oi1j9/LRZCtobpTyeWXebiMbe7O31SDIJztJ6tvzSW8fHnGI14S6O1agGohTeGxiPVUDYH0LRvZ
	6NA93D9aj8O1lL6+jDt5iDtw1tcihX+Vp92qijoQSpNDyis8XEUuqTx7LgWU4XQ1oo3csffuDUP
	ilg=
X-Received: by 2002:a05:6a21:3299:b0:366:14b0:4b1a with SMTP id
 adf61e73a8af0-393904464a8mr139431637.37.1770229499638; Wed, 04 Feb 2026
 10:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203214716.880853-1-edumazet@google.com>
In-Reply-To: <20260203214716.880853-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 4 Feb 2026 13:24:48 -0500
X-Gm-Features: AZwV_Qg5Rl-r-ZGNRGvhHelxDkAv1UTxxubyqj46xQHFvoRbGS_39v5hupJnD6s
Message-ID: <CAM0EoM=aJdS5D1eHUJHHA4outzzriZEKbByfmOTOoPxNih4Wmw@mail.gmail.com>
Subject: Re: [PATCH net-next] net_sched: sch_fq: tweak unlikely() hints in fq_dequeue()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256791-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,resnulli.us,vger.kernel.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB84CEB9B0
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 4:47=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> After 076433bd78d7 ("net_sched: sch_fq: add fast path
> for mostly idle qdisc") we need to remove one unlikely()
> because q->internal holds all the fast path packets.
>
>        skb =3D fq_peek(&q->internal);
>        if (unlikely(skb)) {
>                 q->internal.qlen--;
>
> Calling INET_ECN_set_ce() is very unlikely.
>
> These changes allow fq_dequeue_skb() to be (auto)inlined,
> thus making fq_dequeue() faster.
>
> $ scripts/bloat-o-meter -t vmlinux.0 vmlinux
> add/remove: 2/2 grow/shrink: 0/1 up/down: 283/-269 (14)
> Function                                     old     new   delta
> INET_ECN_set_ce                                -     267    +267
> __pfx_INET_ECN_set_ce                          -      16     +16
> __pfx_fq_dequeue_skb                          16       -     -16
> fq_dequeue_skb                               103       -    -103
> fq_dequeue                                  1685    1535    -150
> Total: Before=3D24886569, After=3D24886583, chg +0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/sch_fq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 6e5f2f4f241546605f8ba37f96275446c8836eee..d0200ec8ada62e86f10d82355=
6bedcaefb470e6c 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -665,7 +665,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
>                 return NULL;
>
>         skb =3D fq_peek(&q->internal);
> -       if (unlikely(skb)) {
> +       if (skb) {
>                 q->internal.qlen--;
>                 fq_dequeue_skb(sch, &q->internal, skb);
>                 goto out;
> @@ -716,7 +716,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
>                 }
>                 prefetch(&skb->end);
>                 fq_dequeue_skb(sch, f, skb);
> -               if ((s64)(now - time_next_packet - q->ce_threshold) > 0) =
{
> +               if (unlikely((s64)(now - time_next_packet - q->ce_thresho=
ld) > 0)) {
>                         INET_ECN_set_ce(skb);
>                         q->stat_ce_mark++;
>                 }

While it looks rational you didnt mention any numbers.
Iam curious, is it always _guaranteed_ that inlining improves performance?

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

