Return-Path: <netdev+bounces-275859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFZoBTV71GmxuQcAu9opvQ
	(envelope-from <netdev+bounces-275859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 05:34:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C903A96E7
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 05:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AA7730166D7
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 03:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79644374169;
	Tue,  7 Apr 2026 03:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/9MC9sH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD91E505
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 03:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775532846; cv=pass; b=G1xIeuxG8pPUoBXTDsGGANzcP2Wd1vrFXLzDczjQP5loP5vi3eMwHwQQXVU/u7Y5MSBhFGTOn02rGMpZ2IdwG7dtZy5VLTGpmzke34n5YKdm6eA200FY72L+M/NlinjuwpkEbjCAnBf+AuJ2KFvEds5FNzz6NSMrvmAbHu4XVsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775532846; c=relaxed/simple;
	bh=Yjx0P1FayQ+aswRUqrzahcSgnCpPUXKWDEzX7RCxt+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tK/2b/dTTPQOoeMId7gBT7eCw1QXxpTkaC64EvvpyJsuBNIQTq+ROkBpAEPdYArILiP7DkRle2fxb8DLyjiGFQSF3y8Qdu6LBE2GZWZk3wv7bg5m6DRUR2J9q97Z/3aVd9t7bjrBLuXuu6qzci1dV5svJoqYl/OyU3WvGZdrAbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/9MC9sH; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59e4a04f059so4294344e87.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 20:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775532842; cv=none;
        d=google.com; s=arc-20240605;
        b=aLqqNFWs7Vs3hgV0NOVTiQgPoiyAwaX3DLVsD/YxQO5oX6SzOmBkM6tcsJklJPs3yl
         QD87RQ4KCqX+qgsvx6TjpymC4gCkdhYLZl+bDIE9mz6FFr/zaufnsp7qpo6b1nitLQsW
         a0Uy8dp3A5IaAa7VEYVe9S4yWBHXkU+7jHK3E3xR/PBsLne8elgsRQaceuydgMB8g4vi
         HLzgKqfBBRtXph5/zt5/UotPW/gjmybc+kRrABIHblNJ2nzn/FdeUnbrYI9+w5bYxMDV
         5eeYBYQ9oCEPgW51mFoLAOO3yQeWFaI2QGA11Cy/B2Yex8LNkZpU4JeVtJB1/Hm33P3j
         V3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3PNoohLi4ojxQ+BzINYqs8H5aArYT9tOIdlY75O8KU=;
        fh=Mcm0MKXyVUegOTHJqZZ1bQ/WWKOysWTBRbs750w2xpU=;
        b=AEg6CJuU+yIxF5FTphCxXe05xAIGKbf5O9z+ZuiFg5DSlRE+6ysqjuJ4NSoEc/JPTz
         3I20x2rr3dyL1ENfGw6wydLF6vDbjmeHVjMcycMhXgOZ4t2ZCGxLm1T0Kjrm5DYI3BK2
         s2WfOjPGkLYtKT/oNBJdRhuDqMHvXh7a5EeAuoNInlPGqxo0mA4bxyrSSXqd745tzhz8
         vZUvcDyMokNNZ1FzV13JfGfSXriebnCPgQMXZvzEESax5AlqA+knWa7x5fiXUy2jFlXB
         jiZPF11MKiO2CQr1s5rK1B05919Chf8NBslyhXkzV+ZHNSrNwM429sYhM8n70tHMZnaT
         UtNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775532842; x=1776137642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3PNoohLi4ojxQ+BzINYqs8H5aArYT9tOIdlY75O8KU=;
        b=a/9MC9sHiadUav7bheLILFiODYAk4t/HMampf1dIg7ahKQLyrJceJGSgu85nPNi060
         46TjAQ0YBKTh8IzMKV9v/bHg8y0WlMUFdFbCFmUtiJ8n9Mt0IngWteypHPrLYbqV0CVs
         xVQspp+VkjNEsIYzEPHUR2d8GjIAf8Mz1mK6XJIN5uKdnkIGgUfx7XEKlVcJXx/yMcXQ
         5Qiai6ZF3RK8K9iLj/cTh2KuJrKYeceBWulCLTClOe16phQ8+l3zHST7bJPg4y7+AcFG
         nKAIZOpffgT1YRq+TwpBtThembUlIq+MQotvkiRoOBLvr1K+Ttk3IAk09vb/l9rJAxw/
         fEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775532842; x=1776137642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3PNoohLi4ojxQ+BzINYqs8H5aArYT9tOIdlY75O8KU=;
        b=VKapg33Cyjp65jNrdgWDYEWpTub/pCNPJ2PEsrswoUHITL4zVltV1dAgpwIgtp0nnw
         pTQFn496GvTvGnAZqlH2G510ysdaxuW6U5NLxef+Rq+E44vkxtLkUGMqj9ibM3vSncd3
         ulOD32zeBKIEaL0MvDq6Y87qFBVkjM0wLaK9oObx+vS3hU16SRE88Pwc9bOCMR0dFWYd
         9Sl2qxYt6uSPHFe0sIv66alwgWAUQDy6f4ICDmcxo6sytq++gKIyKbqgGgItjlMaiNvd
         PKAnxC1LuaDtywMqjh1dHVNh6+OrN7WJ3OiTACJsnuKhqY4qFnjZPKczBNSxFj8njW4N
         H9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjosuJ4/9cVvsdindHjZ52DtndK2jQlshXTovvh9suxdM8ilu9cMHP8qYrgAO+geU1NumXv2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+r9gLzWUflmChiYlFlvzes2sLPGZVL4pfSmV/gUuZzQYDiyjG
	w9ypAx2vraQWWSB2X+i45JPxHipXK3bcB2V3I6fWRfj7z/4F8MT65hg+o3E6nfwApRC3mtTfnYF
	/QRLHHVjyDb/WkD+jygUVXAjfr7IZwDwl3vkAcc8=
X-Gm-Gg: AeBDiesN8Blsl2x1TCQm9kFn29qBy21iUxoIHRuxaOpBQJHXp+FR2EqshCQRQh03Pbe
	ir3z+0krCF/sYcW42vxCbuRoBkGvgggyqk6zBM6YH3PlHY8i75vguPNIzJQ2yaAyW6orzlcZ4q5
	uXx8tVmY49EnWYbdPtCxaA1WyS9QuLz+767XKSJTcP+DySFpmzz5wzGIMs5EZ6o8iyI5UYYUxBJ
	2LRlBsKggnzdG7FJrtIaf5R1mOMhejtR5MX/uN2GaGL9MLWXzQ3hR6PhC2V6We8OwMr/qV34kZd
	sbXPcItD
X-Received: by 2002:a05:6512:118c:b0:5a2:c742:7a76 with SMTP id
 2adb3069b0e04-5a33759394dmr5793209e87.44.1775532841398; Mon, 06 Apr 2026
 20:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com> <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
 <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com> <willemdebruijn.kernel.27ec47b22b23c@gmail.com>
In-Reply-To: <willemdebruijn.kernel.27ec47b22b23c@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 7 Apr 2026 11:33:23 +0800
X-Gm-Features: AQROBzCVep2rMbj10HatyLnc1BEUgEJA7ncanO8dNr1X3UBx1xselIpn5iOhKeo
Message-ID: <CAL+tcoAvVBN7juJEBt5-FYQ4eGTe7dYrFbR3CMOwguw=_X=btA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275859-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 60C903A96E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 10:37=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Mon, Apr 6, 2026 at 10:28=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > The patch is the 1/2 part of push-level granularity feature.
> > > >
> > > > Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs even
> > > > though it might not carry the last byte of the sendmsg.
> > > >
> > > > Prior to the patch, BPF timestamping cannot cover this case:
> > > > The following steps reproduce this:
> > > > 1) skb A is the current last skb before entering wait_for_space pro=
cess
> > > > 2) tcp_push() pushes A without any tag
> > > > 3) A is transmitted from TCP to driver without putting any skb carr=
ying
> > > >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > > > 4) sk_stream_wait_memory() sleeps for a while and then returns with=
 an
> > > >    error code. Note that the socket lock is released.
> > > > 5) skb A finally gets acked and removed from the rtx queue.
> > > > 6) continue with the rest of tcp_sendmsg_locked(): it will jump to(=
goto)
> > > >    'do_error' label and then 'out' label.
> > > > 7) at this moment, skb A turns out to be the last one in this send
> > > >    syscall, and miss the following tcp_bpf_tx_timestamp() opportuni=
ty
> > > >    before the final tcp_push()
> > > > 8) BPF script fails to see any timestamps this time
> > > >
> > > > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/ipv4/tcp.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > index c603b90057f6..7d030a11d004 100644
> > > > --- a/net/ipv4/tcp.c
> > > > +++ b/net/ipv4/tcp.c
> > > > @@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *sk, stru=
ct msghdr *msg, size_t size)
> > > >  wait_for_space:
> > > >               set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > > >               tcp_remove_empty_skb(sk);
> > > > -             if (copied)
> > > > +             if (copied) {
> > > > +                     tcp_bpf_tx_timestamp(sk);
> > > >                       tcp_push(sk, flags & ~MSG_MORE, mss_now,
> > > >                                TCP_NAGLE_PUSH, size_goal);
> > >
> > > Now the number of skbs that will be tracked will be unpredictable,
> > > varying based on memory pressure.
> >
> > Right, I put some effort into writing a selftests to check how many
> > push functions get called at one time and failed to do so.
> >
> > >
> > > That sounds hard to use to me. Especially if these extra pushes
> > > cannot be identified as such.
> > >
> > > Perhaps if all skbs from the same sendmsg call can be identified,
> > > that would help explain pattern in data resulting from these
> > > uncommon extra data points.
> >
> > You meant move tcp_bpf_tx_timestamp before tcp_skb_entail()? That is
> > close to packet basis without considering fragmentation of skb :)
>
> No, I meant somehow in the notification having a way to identify all
> the skbs belonging to the same sendmsg call, to allow filtering on
> that. But I also don't immediately see how to do that (without adding
> yet another counter say).

If we don't build the relationship between skb and sendmsg (just like
the SENDMSG sock option), we will have no clue on how to calculate. If
we only take care of the skb from the view of the syscall layer, it's
fine by moving tcp_bpf_tx_timestamp() before tcp_skb_entail(). But in
terms of per skb even generated beneath TCP due to gso/tso, there is
only one way to correlate: adding an additional member in the skb
structure to store its sendmsg time. This discussion is only suitable
for use cases like net_timestamping.

Well, my key point is that, I have to admit, the above (including
existing bpf script net_timestamping) is a less effective way which
definitely harms the performance because of the extremely frequent
look-up process. It's not suitable for 7x24 observability in
production. What we've done internally is make the kernel layer as
lightweight/easy as possible and let the timestamping feature throw
each record into a ring buffer that the application can read, sort and
calculate. This arch survives the performance. But that's simply what
the design of the kernel module is, given the fast deployment in
production. I suppose in the future we could build a userspace tool
like blktrace to monitor efficiently instead of the selftest sample.
Honestly I don't like look-up action.

Since we're modifying the kernel, how about adding a new member to
record sendmsg time which bpf script is able to read. The whole
scenario looks like this:
1) in tcp_sendmsg_locked(), record the sendmsg time for each skb
2) in either tso_fragment() or tcp_gso_tstamp(), each new skb will get
a copy of its original skb
3) in each stage, bpf script reads the skb's sendmsg time and the
current time, and then effortlessly do the math.

At this point, what I had in mind is we have two options:
1) only handle the skb from the view of the send syscall layer, which
is, for sure, very simple but not thorough.
2) stick to a pure authentic packet basis, then adding a new member
seems inevitable. so the question would be where to add? The space of
the skb structure is very precious :(

>
> Right now, push-based seems rather arbitrary to me, informed more by
> technical limitations than a clear design. Perhaps per-packet makes
> more sense, esp. since BPF calls are cheap (compared to the other
> errqueue mechanism).

Agreed.

Thanks,
Jason

