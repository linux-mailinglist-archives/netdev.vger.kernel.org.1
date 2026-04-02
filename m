Return-Path: <netdev+bounces-274620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE7hC2OWzmkBowYAu9opvQ
	(envelope-from <netdev+bounces-274620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:16:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8F438BB93
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 757A4300D90A
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80142D5432;
	Thu,  2 Apr 2026 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clJcJyAb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E83CB2DC
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146195; cv=pass; b=dJrRvWzQEVrQBTQ0W1ECtaQ+V6Kns0rPkRYAlz+ZeoSs3F4OAg44O1Pfy6dGn52kaef/ZSDDYdYfcu+pG57bfZfcKVnyt64gl1xXzouunLVPPUFjq9WELnBl3f4FWPcPumQyGowTZSo1VIdsYEqzuMLyo5siUC+Rm4XGM0VlorQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146195; c=relaxed/simple;
	bh=H965XUjsASqj7oo6DqcAKqRFQOH7DqtiVe7MLNrZevU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dq089dclTfIWWWO00QgmsQSkU/iKhkoT0m5uCgOmZUmAObdGX8ve9YMM90sbRO/k9P9Xf2qKNKfzBlO7HP5dQlOsQpPMITlEpKK83o3+9jVfq5cVKFyrxZhF/WMYMPYqRUAE+qb3aVdegmeYzMy2ehg/mgXrPcRFIv8A1fXmFgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clJcJyAb; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a12cd0bd79so1297938e87.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 09:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775146192; cv=none;
        d=google.com; s=arc-20240605;
        b=ao93cGcs1ptZvWzZV9J67YaFLtiFRSm7l9tEAfTXxg9y4h8bfV4Tv/W+59fi/wOIAc
         pZvvCONExctrfpipSWbRe/etuyyzqa4Wx7H6CayUyM7fI+jhjgkFLX/fUMvZSGDeR1ux
         s+nFx3BBb2UXl+852h+YOSLyFOy3eejyCTujJEw4YMg16U4MrjoOtUR8nJHDl1px2ag0
         DWXqcGsB814svEvQdH/ZjkEipMbKYn3wKBr74ZMnALhngTyRXmiM+NormdgVCFzS8VJp
         M/C6lwSIDYrCRoaxK7h88PHMNIDwg+4xE+TbqTCKin14sr+Pab6Fqer0QVjA9tEtt3Jj
         QcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A9ixqSdFX6BlrRiQhJMQlwW8R5HTrOah8/gClvdNOHM=;
        fh=QFg3RcYmEE+iHs8k+fYr3eScMJ1mpnEIkxGaZi951UU=;
        b=Z0uG2iKM1vQscht8RM6WtO/6aEhnGZ5wVS3A+PFmBY/jwD7UOb3JO4D0QDZQbfOQOr
         SXx9vtL8bRzoW5tVIyyJqBw6mSb4AhcC/Rz08DjmZKDBSbEved/2EUD9+lVucUa5tL0a
         hDsCFLjk+zIR7rScVGBwXxWsTMyjhSuzhEk7HGew3h5a+N55LK9pLmqHCK7yaDygUexw
         82R7dxIF4vBHRxr4hu1RTMt5VjAbzX5/xR8x5K4Eyi7Krpyz/N7XHB1JBCh/EB++/lqi
         y+9y7EVDFPkpN64C4Gsk1p3+W4MY2kv+AAvvKx8OYYVurUUarv8I2/X8eaSZdZsuR0g9
         /AnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775146192; x=1775750992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9ixqSdFX6BlrRiQhJMQlwW8R5HTrOah8/gClvdNOHM=;
        b=clJcJyAbVa3fconAwfoxGC1jOZ+2d2Ei7/+jARpDly5Shxdn1j/aV+dL1gZXXj0lGi
         bFxxc2crE4dECHALueU5IZqSVdlbBdozYw3bDbwq87Opz2yqwZ7anh1pU6iSqLjCZPR3
         ojUeXuxe8xIuGWESygN/hbw+gNd67ep797IJzSSk1G4yYgheORIdoB4JEFIeP5DNuoDT
         +ufQdvhunghNoEVRZHRWeVXTk6U2AQhnfcuWkLmUNe/3q3awxMFVaWG1HImJQGeMeP4L
         F3bniu1aTNMgKK8mR9EkKnggmQNCybtlp0lUgBlik+K95n2/Q9y5QNH0bkHR5YfVRRrh
         i0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775146192; x=1775750992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A9ixqSdFX6BlrRiQhJMQlwW8R5HTrOah8/gClvdNOHM=;
        b=DmJQif9bxJiPyqrfmx2zU83YtF9sWIz9vlmJ7ohIH0659WPRELxaV+lkOBL8YVg6mU
         63tnJZqQ/pzCDd/nRSMr7nEJWPtIxNWdWFmB6Lla5DpVWEXdaUFr2JWl37nIRMTdpnqc
         MOVz64FXNYUV+5sIt8icO7ZrYuHzQhohJaK96gOrByLZGS1/WQReIOSnmAQN2FjZmWzK
         +4XNg+nGr3vzj2rSrkegeHV0mQV4vbZ6aahn5WtIWqYN73DETldXliIq87e7USTwwchS
         KPKRZp/F4PjqPVPa0sjiaUlKczDUxcsFgH5iQ0XN1OekYR+hBK0Q7IO2LTRTQYiSBZ3X
         jYwg==
X-Forwarded-Encrypted: i=1; AJvYcCXivv4HZPS1JlwmOKvoxNpdtc/idfcJpF0PsCEXbK9zWDWdkK8MiF4fSIoh7Y/kQjLieNbWws8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8F2651tS0sZkOkEVl682cC72HM8gWEQwLzhlwyF/YVV9cy6Na
	m48pfTWnQkhL2hQLjrRDBKiDlQK+z9eLX+lS5lGg37wgxBT3VwXMECygtMwJIkyuAP1Rm1bZ+NZ
	N01y3CufIM8Zl3ZBGjQyqXFbpdWvtA4AyGsP5CsY=
X-Gm-Gg: ATEYQzxYGD3E3bVf0bixkOP/JkzcfjQMwEe2pJIjGQ1jwrMb+RddKXl/4D7QGyOGa59
	a30D9MQCxNzMsUdbj6SDAEd4BZdduySiBa2cxh+ogUpLMz7BlpObnxNCjXljF9DvJzj61pkupno
	mCLBTs+DFt1UlvKPpWQ23bMRqZAOgEsZD6leXlRXjqMeG+V/eWN+a50zBcCXWvinuCcGRExQ9us
	Ma/1ApqnlJMmhxKiiLX06xKnbIVwCYACr31RxJ666B9y6SecSGtHPtyV/VAdoQ2R+g70xQSX60x
	ROydiB8EredktOJeIA==
X-Received: by 2002:a05:6512:114f:b0:5a2:a703:971 with SMTP id
 2adb3069b0e04-5a2c1ee2edcmr3146971e87.1.1775146191915; Thu, 02 Apr 2026
 09:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402085831.36983-1-kerneljasonxing@gmail.com>
 <CANn89iK-e1=yQhN0t48Cm7ru9cYwKwBw1_DDRcVffX91s4wWNA@mail.gmail.com>
 <CAL+tcoDiyptBUch5LZuRKn5BbJK_6TcgSi91D31axRtjqpSzzw@mail.gmail.com> <CANn89i+J=OBqHFh3jWNVXm7QWhSDJ=PHtmMtzyBrTpOoNtmu5w@mail.gmail.com>
In-Reply-To: <CANn89i+J=OBqHFh3jWNVXm7QWhSDJ=PHtmMtzyBrTpOoNtmu5w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 3 Apr 2026 00:09:14 +0800
X-Gm-Features: AQROBzAVnPDdub99dfIfcrr9unLeUyjrR4PrCC19uSgYYXqWu_O5ioyEAz1U3sE
Message-ID: <CAL+tcoBB+d-PwNzx1ugjDwZZBaQf8vxb3XooM3ARw9CtbiFeqw@mail.gmail.com>
Subject: Re: [PATCH net-next] net-timestamp: take track of the skb when
 wait_for_space occurs
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemb@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-274620-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,tencent.com:email]
X-Rspamd-Queue-Id: 9B8F438BB93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 11:40=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Apr 2, 2026 at 8:03=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Thu, Apr 2, 2026 at 10:24=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Apr 2, 2026 at 1:58=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs even
> > > > though it might not carry the last byte of the sendmsg.
> > > >
> > > > If we don't do so, we might be faced with no single timestamp that
> > > > can be received by application from the error queue. The following =
steps
> > > > reproduce this:
> > > > 1) skb A is the current last skb before entering wait_for_space pro=
cess
> > > > 2) tcp_push() pushes A without any tag
> > > > 3) A is transmitted from TCP to driver without putting any skb carr=
ing
> > > >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > > > 4) sk_stream_wait_memory() sleeps for a while and then returns with=
 an
> > > >    error code. Note that the socket lock is released.
> > > > 5) skb A finally gets acked and removed from the rtx queue.
> > > > 6) continue with the rest of tcp_sendmsg_locked(): it will jump to(=
goto)
> > > >    'do_error' label and then 'out' label.
> > > > 7) at this moment, skb A turns out to be the last one in this send
> > > >    syscall, and miss the following tcp_tx_timestamp() opportunity b=
efore
> > > >    the final tcp_push
> > > > 8) application receives no timestamps this time
> > > >
> > > > The original commit ad02c4f54782 ("tcp: provide timestamps for part=
ial writes")
> > > > says it is best effort. Now it's time to cover the only potential p=
oint
> > > > to avoid missing record.
> > > >
> > > > The side effect is obvious that we might record more than one time =
for a
> > > > single send syscall since the skb that we keep track of in this sce=
nario
> > > > might not be the last one. But tracing more than one skb is not a b=
ad
> > > > thing since there is an emerging/promissing trend to do a detailed
> > > > packet granularity monitor.
> > >
> > > This is rather weak/lazy, especially if you do not know how long the
> > > thread is put to sleep?
> >
> > Thanks for the review!
> >
> > I actually thought about how to recognize which one should be the last
> > skb in each send syscall. But it turns out that much more complicated
> > work needs to be done which hurts the stack and common structures like
> > tcp_sock. That's why I gave up and instead chose a much simpler way to
> > minimize the impact.
> >
> > >
> > > >
> > > > Thanks to the great ID, namely, tskey, application that is responsi=
ble
> > > > for the collect/sort of timestamps leverages it to put that record =
in
> > > > between two consecutive send syscalls correctly.
> > > >
> > > > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/ipv4/tcp.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > index 516087c622ad..2db80d75cfa4 100644
> > > > --- a/net/ipv4/tcp.c
> > > > +++ b/net/ipv4/tcp.c
> > > > @@ -1411,9 +1411,11 @@ int tcp_sendmsg_locked(struct sock *sk, stru=
ct msghdr *msg, size_t size)
> > > >  wait_for_space:
> > > >                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > > >                 tcp_remove_empty_skb(sk);
> > > > -               if (copied)
> > > > +               if (copied) {
> > > > +                       tcp_tx_timestamp(sk, &sockc);
> > > >                         tcp_push(sk, flags & ~MSG_MORE, mss_now,
> > > >                                  TCP_NAGLE_PUSH, size_goal);
> > > > +               }
> > > >
> > > >                 err =3D sk_stream_wait_memory(sk, &timeo);
> > > >                 if (err !=3D 0)
> > >
> > > I think non blocking model should be used by modern applications,
> > > especially ones caring about timestamps.
> >
> > Please note that BPF timestamping has already been merged. It's a
> > standalone script that monitors all kinds of flows and discovers those
> > strange/unexpected behaviors. So we normally don't take a look at the
> > implementation of each application before spotting any exceptions.
> >
> > Besides, sometimes monitoring the latency of the host doesn't have
> > much to do with the mode of application. People might want to observe
> > more deeper into the underlying layer. Right now, without the patch,
> > the monitor possibly ends up missing the record of this send syscall,
> > which has been reliably reproduced by Yushan.
> >
> > >
> > > This patch has performance implications.
> > >
> > >  tcp_tx_timestamp() is quite big and was inlined because it had a sin=
gle caller.
> > >
> > > After this patch, it is no longer inlined.
> > >
> > > scripts/bloat-o-meter -t vmlinux.before vmlinux.after
> > > add/remove: 2/0 grow/shrink: 0/1 up/down: 239/-192 (47)
> > > Function                                     old     new   delta
> > > tcp_tx_timestamp                               -     223    +223
> > > __pfx_tcp_tx_timestamp                         -      16     +16
> > > tcp_sendmsg_locked                          4560    4368    -192
> > > Total: Before=3D29652698, After=3D29652745, chg +0.00%
> >
> > That's right and I really appreciate your recent great effort trying
> > to mitigate the impact of function calls.
> >
> > My take is that it is a trade off. Adding one more track of the skb
> > (which adds a function call) actually doesn't hurt much especially for
> > this scenario and the last skb scenario. This path basically is not
> > that hot. There are some left things to be done to improve the
> > socket/BPF timestamping feature. And I plan to push more patches
> > (sure, very carefully) to enhance the ability of BPF timestamping to
> > observe TCP which is inevitable to add some extra functions and if
> > statements.
> >
> > I'm wondering if the above makes sense to you.
>
> If you mostly care about BPF, I would suggest:

For me, yes, I've been internally working on this stuff for a long
while and still struggling with what part is worth upstreaming. I'm
not sure how Willem thinks of the socket timestamping feature.

>
> iff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index bd2c3c4587e133897aa057bd3b26c29df050607f..444254b8870c4406a7105cd3c=
e177745fb1b6c0a
> 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -506,6 +506,20 @@ static void tcp_tx_timestamp(struct sock *sk,
> struct sockcm_cookie *sockc)
>                 bpf_skops_tx_timestamping(sk, skb,
> BPF_SOCK_OPS_TSTAMP_SENDMSG_CB);
>  }
>
> +static void tcp_tx_timestamp_before_wait_memory(struct sock *sk)
> +{
> +       struct sk_buff *skb;
> +
> +       if (!cgroup_bpf_enabled(CGROUP_SOCK_OPS) ||
> +           !SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING))
> +               return;
> +
> +       skb =3D tcp_write_queue_tail(sk);
> +       if (skb)
> +               bpf_skops_tx_timestamping(sk, skb,
> +                                         BPF_SOCK_OPS_TSTAMP_SENDMSG_CB)=
;
> +}
> +
>  /* @wake is one when sk_stream_write_space() calls us.
>   * This sends EPOLLOUT only if notsent_bytes is half the limit.
>   * This mimics the strategy used in sock_def_write_space().
> @@ -1403,10 +1417,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct
> msghdr *msg, size_t size)
>  wait_for_space:
>                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>                 tcp_remove_empty_skb(sk);
> -               if (copied)
> +               if (copied) {
> +                       tcp_tx_timestamp_before_wait_memory(sk);
>                         tcp_push(sk, flags & ~MSG_MORE, mss_now,
>                                  TCP_NAGLE_PUSH, size_goal);
> -
> +               }
>                 err =3D sk_stream_wait_memory(sk, &timeo);
>                 if (err !=3D 0)
>                         goto do_error;
>

Great, thanks, Eric!!

>
> Note: You also could use a different skops to differentiate cases in
> your monitoring.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 1/0 up/down: 69/0 (69)
> Function                                     old     new   delta
> tcp_sendmsg_locked                          4848    4917     +69
> Total: Before=3D29651496, After=3D29651565, chg +0.00%

Thanks again. I will give it a try tomorrow morning :)

Thanks,
Jason

