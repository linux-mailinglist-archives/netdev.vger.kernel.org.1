Return-Path: <netdev+bounces-275583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3XdFBoWm02n8jwcAu9opvQ
	(envelope-from <netdev+bounces-275583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 14:26:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 621503A3450
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 14:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C60E300D6BE
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 12:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101A73358AF;
	Mon,  6 Apr 2026 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pA00TjKD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570052F5A12
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478401; cv=pass; b=ayxjLN6zSaVRPxMjOl+sgZrzC6NGVsVsHLriCuC4SKaU9GRtaGIBmaZhUh4POHC8oKWxEvGzj05buCwCHq6rxs/f3GWY7/WuKFjKF4pb5Rk2lm8J6vXii/jLtjPJzIDE6ZYf+sKT/EkvO6FOcn6hkNlnq334WFIPrZxmK1QfjOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478401; c=relaxed/simple;
	bh=Z/CDbcWuE2J/SDaUeb3SFAxsaRLnVodNz2nY2wKc/uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJSbfOJqjmEovIsUxHoCL3YxPnAZ59jvQf0mgs55em/e/CX4KQERjKIl1yfZ3l8/6bXtQym7PH02R8TLthLwPuSntOg8Vfh2b4rGd3MkB2OzdaHR612wHfF2x/mQMVDuUWugk+KDf/OwrqV/AK2qubgqj3opgWA+WliDA6/Y5xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pA00TjKD; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a337552604so2653109e87.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 05:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775478398; cv=none;
        d=google.com; s=arc-20240605;
        b=ij/SvFG2W8rbv94BbNjNlaprabX9/6Fv0BKxk4ZINTNA5qk1QT6Gkn8geXq8cRjig0
         ODJ+4ydL/g6eenAVlZ7vRme0FDzLL2JUN2KErV6QLjhLDHNiKfQu2X5GnGO15sQROaiu
         XUvo3g7+sUYTc93K+1+KkIzUHKB1EXhTc1h5yXd0L6H8AIRam66clI6WC5C7tbjIIaVb
         msY0K12lG3hF3ZHJWSPRj/u5YEyBWm+PD0g4wJaUOmHgrmeBOvhBwaNQKa/0Wb+nSKck
         OcJXRQH4oPVm7wU1Y2cpL9JWyB7atpxsHNKPTHlpC6E9DZi8QTZvg4d37r5hNzd2d88v
         9sKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tN2kgEeuddHm624zpdzvfwyc6om3StRoXFX3peqADZ4=;
        fh=IcnT/Fnx5mduAl81Sg7EDI92SYwm41Bk5lKwjUSGqQA=;
        b=MVYqnbxsSBOEvK68l1cCUCp0X6jmaU90SsETBpo6QjP+OXSDRu2Bx+2lNV/j02mEZ4
         8hry5VO6ZJQ7CHf51L3TG8NbeKZEuhhd3hGnGTF3mmzkY0YIdBwn6Y1ro63cs+doI/Bt
         PEAHBDclIIV1VoyicnnAkbtqjqx22GJEjXWPIn0EP1mFPL55zMmPF/ltVrWL61kcXSLA
         uUjPENHv17pTTq0a2plD4y+8+dj7BxI+7EINGZ5TpSZ9R2nYQNkE2deNf3vxWusnH1Wc
         goiZQCeR8HczDMHhHnLo87PcaSFtkZC+m7LrjI/GLFh2DmDHsECEubY987S7hwicT5PK
         XgkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775478398; x=1776083198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tN2kgEeuddHm624zpdzvfwyc6om3StRoXFX3peqADZ4=;
        b=pA00TjKDq4FE/RJh9y8RK2tmpRUDmjGDuxQ5einp5mZb0DDULGx1v+z1tDGx6mB6uP
         gHE1GwjRFoE1Yuz6owMB91z9haE/YY7ZBGNBHB0Zb3N4xcTOXK30MDwM2xtSwuaUqPjU
         cVKHZuWJnuXGZmkELj2tY6XDjQMg7EkE1MP9639C1CI08EYXKFdtyPyUQ8vrEjWC8nc5
         hYjHv0JzU88k4jRcvqU5iubjnxx9EdOdgTzjzNKNGOKPg+FYFk+3N+4egwn4lNMdyVxb
         IWw5zmPgg8MDzeODxtqHekct3i8GpWJoFheMg5xEKl7qCt3alTHWUZYNelL2sQ+7L0UU
         EhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775478398; x=1776083198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tN2kgEeuddHm624zpdzvfwyc6om3StRoXFX3peqADZ4=;
        b=ByySlJkIdw75yngvFX5bRAgihiLDyn8SCeQ1zwTM1NSyuCQV8lJJ3cQXWGNpsrgot0
         d1yZK8wOvpZpwZ5BMlrr0ZrS2UeThdFmsBMjidcKyVFM4Lb8cA+ReXnDOhmYfpAaYdLv
         5UfN6u4JUj69ZMymXT8nXit9aJoewa24GJc77/RZqNNen1+PW0BCdVAKfXpAQOB6/oLe
         U4QNmmdCzgt4hLrmopiM5ktwneqhnBJ+6QY8aLQomiRYmncPVnzbg3GD5ZW1wNOw1Tez
         F72SNB4YGED5uu+J5XeiJwmD68Qu9KmY6IHIPalTBRLHqAnpvrZ9SNAyjUEsl8SwXzS2
         5ceg==
X-Forwarded-Encrypted: i=1; AJvYcCX/6Wz+fjUfFBjLgjaWJsHSfpsPSrzMdVJX74CuiWsz6xFUb3GGNFi5XQUvgr4E1QHiF1LYhTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFo4wUB1mcGkLH2GM0hlizLXokq78HltRG5vjt5gBS4IRrmbKR
	iDv4SBVJMpZuYoVbp0DoWoW2kAMeeXuzeASvf1RAqfVTKkjAjH2PwAK+anpodAKCGsiWlab9RjF
	WPOF+Nz81X1cUTp20k9kyxkX58pg+hN0=
X-Gm-Gg: AeBDiet5t0In4JqahVpZByOkTH6c4AAPNvUv5vMwYzqDDZZat9cBReF9ZIbGX0Jmj0i
	qnRqKwBqoJAZnKiErbZ40Zdj5SYuNqOSh6A53b6zP6ZPu6trROe8Gw/thU7IGvz9tFKWrOSyc0J
	wesZJk3j5AGBGMG0jGRJ6SliCFUVIBRomPISMZSMAi6nq86TFiWUIToEcMCOcgxVFeUqucm9KC+
	cVP4n8Z/lDO7mvj+klDfW7BBLg6q7YhzOFiFZV+MmUaXPH0YURHhPWpQ+i/WNAfdagt7Bym2As3
	oVCseKk=
X-Received: by 2002:a05:6512:a94:b0:5a2:a5a5:5247 with SMTP id
 2adb3069b0e04-5a3375849dfmr3854740e87.32.1775478398126; Mon, 06 Apr 2026
 05:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404150452.83904-1-kerneljasonxing@gmail.com> <willemdebruijn.kernel.2053d6bde1d3d@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2053d6bde1d3d@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 6 Apr 2026 20:25:59 +0800
X-Gm-Features: AQROBzAkyAbdNPQICndZJGh_99XQNrNmvda_T-DEftWK4oIla1p5dml9GEDR0PY
Message-ID: <CAL+tcoDuSyQdR83C-07bUpJfYdnrkkcA8gO+0qKZM8PTbiFofA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/4] bpf-timestamp: convert to push-level granularity
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275583-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 621503A3450
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 10:17=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > 1. Design of send-level granularity
> > Originally, socket timestamping was designed to support tracing each
> > sendmsg instead of per packet because application needs to issue
> > multiple extra recvmsg() calls to get the skbs carrying the timestamp
> > one by one if application chooses tag with different tags(SCHED/DRV/ACK=
).
> > It's an obvious huge burden if the application expects to see a finer
> > grained behavior.
> > Another point I mentioned a bit in Netdev 0x19[1], supposing the amount=
 of
> > data that application tries to transfer at one time is split into 100
> > smaller packets, recording the last skb's timestamps (SCHED/DRV/HARDWAR=
E)
> > is no longer meaningful because at the moment timestamping only records
> > 1/100 packets. In this case, only the delta between when to send and wh=
en
> > to ack matters.
> >
> > 2. Known missing tag issues in TCP
> > A critically important thing is that we can miss tagging the last packe=
t
> > in a few conditions as the patch 3/4 explains. That means we lose track
> > of the send syscall. Digging into more into how tcp_sendmsg_locked work=
s,
> > I found it's not feasible to successfully identify the last skb before
> > push functions get called. With that said, if we want to make the featu=
re
> > better to cover all of these cases, we inevitably needs to place
> > tcp_bpf_tx_timestamp() function before each push function.
> >
> > 3. Practice at Tencent
> > In production, we have a version that applies the packet basis policy t=
o
> > do the exhaustive profiling of each flow for months in order to:
> > 1) 100% make sure to capture the jitter event. No sampling.
> > 2) observe the performance, find the bottleneck and improve it.
> > We're still collecting data and investigating how it helps us in all th=
e
> > potential aspects before upstreaming. My personal perspective on this i=
s
> > to replace tcpdump eventually. It's worth mentioning tcpdump no longer
> > satisfies our micro observation in modern data center.
> >
> > 4. The tendency toward finer-grained observability
> > As we're aware that there are already many various bpf scripts trying t=
o
> > implement the fine grained monitor of the packets, it's an unstoppable
> > tendency for the future observability. We're faced with so many latency
> > reports (like jitter, perf degradation) on a daily basis. Getting the
> > root cause of each report is exactly what we pursue.
> > After we know which request causes the problem, if it belongs to kernel=
,
> > we will dig into the packet behavior with more useful information
> > included. This is the process of tracing down the jitter problem.
> > Likewise, in BPF timestamping that mitigates the impact of calling extr=
a
> > syscalls, breaking the coarse granularity into smaller ones is a first
> > good way to go. It shouldn't be the burden like before especially it's
> > independent of application.
> >
> > 5. Details of the series
> > Now it's time to convert BPF timestamping feature into push-level
> > granularity by only recording the last skb in each push function, which
> > is quite similar to how we previously treat each send syscall.
> > Regarding each push function as a whole, we only care about
> > the last skb from each push since the skb can be chunked into different
> > smaller packets. BPF scripts like progs/net_timestamping.c has the
> > ability to trace each tagged skb and calculate the latency:
> > 1) delta between send and each tagged skb in tcp_sendmsg_locked()
> > 2) delta between SCHED/DRV/ACK. Three timestamps are also correlated
> >    with the sendmsg time.
> >
> > In conclusion, push-level is more of a compromise approach which covers
> > those corner cases and further enhances the capabilities (like a finer
> > grained observation of jitter and performance issues).
>
> # push-level design
>
> It it significantly less intuitive than per-syscall, which is under
> user control. Or even than per-packet. As a fix for missing timestamps
> I understand these two extensions, even with the unintended side
> effect of reporting many unnecessary extra skbs in the common case.
> As a model to advocate for, less so.

Thanks for your review!

Fair enough. One mode of our internal kernel module directly hijacks
tcp_skb_entail() that handles the last skb of this skb if
fragmentation happens.

>
> Would it help if all skbs from the same sendmsg() can still be
> identified as common from the same syscall? That allows the user

I have to add more comments about push level:
the last skb from each push function will always be correlated with
its own sendmsg. With the help of BPF_SOCK_OPS_TSTAMP_SENDMSG_CB, bpf
script can do so.

> to discard all but the last one (if they wish)

Oh, I just replied with another reply. Let's start the discussion here.

It would be great if we have a definite finer grained observability.

>
>
> # ABI changes
>
> For SO_TIMESTAMPING we would not be able to make this change
> unconditionally as the behavior change would break existing
> application expectations.

Right.

>
> That is why historically we have guarded new behabvior behind new
> TS options flags.
>
> The same may be true for BPF.

How about adding a socket option for a per packet mode, say,
BPF_SOCK_OPS_TSTAMP_TCP_PACKET_CB around tcp_skb_entail() which works
very similarly to
BPF_SOCK_OPS_TSTAMP_SENDMSG_CB. After that, users have a standalone
option to decide whether to trace all the skbs from the sendmsg.

If so, the origin BPF timestamping that works exactly like socket
timestamping is the best effort (we don't 100% guarantee the timestamping
feature captures every sendmsg call). With the new socket option
involved, we provide a finer grained vision without harming users who
favor the origin design with those two issues resolved.

A kind reminder is that if the skb is fragmented, for instance, due to
TSO being disabled, only the last smaller/child one will be monitored.

>
>
> # SO_TIMESTAMPING and BPF timestamping differences
>
> A related point is that this breaks the 1:1 relationship between
> SO_TIMESTAMPING and BPF timestamping. As said before, I think that
> is fine as BPF timestamping can be cheaper. But we should avoid the
> two forking in incompatible ways. I suggest that BPF timestamping
> becomes a superset of SO_TIMESTAMPING: it must have all features
> of SO_TIMESTAMPING, and may offer more.

Thanks for your insight. I agree with you! A new socket option should
be fine, I suppose.

>
>
> # Documentation and testing
>
> Please also expand Documentation and include a test.

Will update the doc in the next version.

Sorry, a test for push-level is a bit difficult. Let me complete it
after we reach a consensus on how we use it :)

Thanks,
Jason

