Return-Path: <netdev+bounces-274603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIKUIuiOzmkbogYAu9opvQ
	(envelope-from <netdev+bounces-274603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:44:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 806B238B646
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E7973007ACB
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1F02D2385;
	Thu,  2 Apr 2026 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FO4RPTZK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271E0280318
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144410; cv=pass; b=QBC/iF9viOIWrXrV5oMeuyTB8Z1DwqmlB8tIJ7YyyOgVeqx+6IKtAIc+RqtXszbnfWCAHBwYqwxzD1Q1ZZdvmNSLQxdIAB1HatMTfjb252pJyo84GemSfyjE14QZMQecQZKrFa4iXR+rVwp0RdbpafseVXUOkolb4Hc51F8MjIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144410; c=relaxed/simple;
	bh=kw9BL8iQ2QxWx+YfION/SDcYGe7T5ulahoEpJfolM1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XK05J7sXorLRhFofv8TzbgcdcN0JwAMFlPdDa2RiTI2oD2YtlKn6BpYJgD8CSceVqPgNKoi1yXPDmNfxPbcUbamZ4Tn7O3sCzHbsGdKkmNrQANIltvKnyrE1e+Sxdt3A4WDkl5oIvAqJlJhLIwOUEqterRZB8mGYFWpO8QJF/Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FO4RPTZK; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50b266413fbso8845251cf.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 08:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775144408; cv=none;
        d=google.com; s=arc-20240605;
        b=J7bPrughqw7uVchovE7EtfQdwp+VDSDTFhg9kn1iufhoD75sfsmCPP7TKMcZPiLHMd
         X2Nm5zQT3NYlyrJZTId2hm5noyhyVEB5QY2835DgjrkInJ1m9CO2yk7Vpe3CcanibI5q
         BCaBpc4tdZo4mhC3mRCCW2wRO6iJyaKwU7Ti1iJ/zWwsTRorYX4+dDq9MS4m6OReUQ2m
         wc6RtHjJ7XQM4+Kna1mxkc+aUjf8KQI/Dn+/ZRKJjyzJ639AX3OtJKUt7g3cqYXuav2A
         pVXx60hjQFPYQZCdyEPg0/gV7RC7pgb5d/+f/96/yCTWm+ca9b+H8OxY7/OgzScRTO4F
         v5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7J3Si4VNPpUY/ge9ly51ZPh8nWapKA+5NfcyLhvIPZA=;
        fh=ceyL/5toTQPIniZeaTpCFOiUR8MPTATXy9Y9Cqyfob8=;
        b=ZKZUqgin1ef+e8ISJrDqmv4yj9K9qB7gNQGWI5jRNOZVOTzhoLxXI9mrV7uEwSDDeX
         7yFNcd95W4UyMD7bL//cZS7uVWPPggL0RJVLfyC5eUH/QipNwmNlI+ezNLGbaknT59Qj
         zpJK+QoPIOp3WjO/flKIVi5Rg/zhHLxYqBemKc/BYg1BvvxHwAku6XIT5l/k0e7nvpFx
         rUMfnav0/uHAW+dwNkMb0fi6g6Fdx10xYmo0EsUSRjE9iq+iVF5LcRsqohFPRzYmAbps
         efVI1YbeKAO+z//N258v7A6SPgokEHOozWRqXDcbM7CLQayFbuW70mc5z+K1neUOhbEM
         vxIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775144408; x=1775749208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J3Si4VNPpUY/ge9ly51ZPh8nWapKA+5NfcyLhvIPZA=;
        b=FO4RPTZKjlHfyjKuPeReEGpE74iENs5TbQo7yU+WRY8EWujNYkWJ2mHEW+To4TQdRr
         g2yTFFEzmsJEbuD4Y2PcBt0bg6bcXboe7Q6mHuGNYF+Wf7WMyMk4cDcPS/Dy2WxmUiHx
         N8/5Oc95I5SVi4c9aBa0RbJOly5bKuGCBaTBqUpBVtbfgupM+dk/Nx2wHliZhdu0/bm9
         mcwT7erbcUmDSHXYyEbBGBtS1KdOsPirEEe/koLaWgNy2EMXIMaIU9D0soN7fN244PMX
         ZPhAjWhZm0xgCbPZp0ZN6QaNOQ71/0GyGcsVZwdDnBv+dCYnPTOnQRbDIoWnWLjJAG6z
         iVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775144408; x=1775749208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7J3Si4VNPpUY/ge9ly51ZPh8nWapKA+5NfcyLhvIPZA=;
        b=LQwt+eRAMfw+F8HSJbilhjVz/v5AvCX0bjVIaK5Y7ihZ3ioAfcmTTbCAe/B8Dzplpf
         0iuO977VQa/DGUq/jzy+wK7SbCMu0/u+YjW7ME8HiTPCu1jTGwDmOVDSfwAWOjQJuuAr
         F5Dshrd7anU7zB4TC4tapgV/Ig2Sjq3Yvmm8R9i19POYbfrxuFpOpJEEQ1/hYe49zlIV
         rJIybvwRRsZRzcLAndkdkmlwmKd/Ewi+IWooObpLRNM8mrY5W6iDjGITEEKDgu/G/Zis
         ZyQgwRo+k5PcgNDtiHid88Zculz5SV6Rcf2X4kNHqfA7z2jz5ktJ1dxeyjuLKasyUbz2
         6MDA==
X-Forwarded-Encrypted: i=1; AJvYcCW87t4TX2s0drxZcYIUth4WqRRyx9Ob5J8no5FWweCK/CgiFfiHi4Ku9IXASGEof+uQU3u1tOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd+zZYm7+vDNR24+hUcNuXQvFbCkZYBMeGX786FEOZRljRupIc
	F51PHkLncWhHgtYEVcnQXTN+aF/oxioWw0HoedEViLCFR13FVwHonNZxzym4OfJf5duXf8mem7V
	iwuCMrkD9ohTCr9IP2sYkFPMmbHrG0ui3gmwjl8wLxyCUqV5mdS3P3Be6QTk=
X-Gm-Gg: ATEYQzytR0qcBNiFT+4d7X1L/glQnnoKcRKizqLPOHqYboH4kPjRg5mkGaypD/1jIRY
	HLFNEyqeHVWCFeLXko9UgDNxVDPrpCr8DGWJRduPeSbrvs3thcAUE8l5E8xJXr2iByEToNY9AFB
	LHCEfvvSCCM8o1jmkNkrdb4awIjFn4Lwm6km47AwgjbQehpU5ltBeYIiABwyyJ6eDfSePk+94SM
	hW9OQQhz5aPs0Bx0ILu+Yh9arQQZ88ntNtKLGuQWmOp7dLq7ide+IxpvEKtRe7YnPi5hSsmHaEB
	05/PGek=
X-Received: by 2002:a05:622a:17cb:b0:50b:3c7e:a33c with SMTP id
 d75a77b69052e-50d4c0218e9mr55771441cf.38.1775144407015; Thu, 02 Apr 2026
 08:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402085831.36983-1-kerneljasonxing@gmail.com>
 <CANn89iK-e1=yQhN0t48Cm7ru9cYwKwBw1_DDRcVffX91s4wWNA@mail.gmail.com> <CAL+tcoDiyptBUch5LZuRKn5BbJK_6TcgSi91D31axRtjqpSzzw@mail.gmail.com>
In-Reply-To: <CAL+tcoDiyptBUch5LZuRKn5BbJK_6TcgSi91D31axRtjqpSzzw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Apr 2026 08:39:55 -0700
X-Gm-Features: AQROBzCp5rKv0Va0KtEj5fN1XOJk6RDZS6aHovXbyWP7ScJ4vqLoDuvZuZAwLOo
Message-ID: <CANn89i+J=OBqHFh3jWNVXm7QWhSDJ=PHtmMtzyBrTpOoNtmu5w@mail.gmail.com>
Subject: Re: [PATCH net-next] net-timestamp: take track of the skb when
 wait_for_space occurs
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemb@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274603-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vmlinux.new:url,tencent.com:email]
X-Rspamd-Queue-Id: 806B238B646
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 8:03=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Thu, Apr 2, 2026 at 10:24=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Apr 2, 2026 at 1:58=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs even
> > > though it might not carry the last byte of the sendmsg.
> > >
> > > If we don't do so, we might be faced with no single timestamp that
> > > can be received by application from the error queue. The following st=
eps
> > > reproduce this:
> > > 1) skb A is the current last skb before entering wait_for_space proce=
ss
> > > 2) tcp_push() pushes A without any tag
> > > 3) A is transmitted from TCP to driver without putting any skb carrin=
g
> > >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > > 4) sk_stream_wait_memory() sleeps for a while and then returns with a=
n
> > >    error code. Note that the socket lock is released.
> > > 5) skb A finally gets acked and removed from the rtx queue.
> > > 6) continue with the rest of tcp_sendmsg_locked(): it will jump to(go=
to)
> > >    'do_error' label and then 'out' label.
> > > 7) at this moment, skb A turns out to be the last one in this send
> > >    syscall, and miss the following tcp_tx_timestamp() opportunity bef=
ore
> > >    the final tcp_push
> > > 8) application receives no timestamps this time
> > >
> > > The original commit ad02c4f54782 ("tcp: provide timestamps for partia=
l writes")
> > > says it is best effort. Now it's time to cover the only potential poi=
nt
> > > to avoid missing record.
> > >
> > > The side effect is obvious that we might record more than one time fo=
r a
> > > single send syscall since the skb that we keep track of in this scena=
rio
> > > might not be the last one. But tracing more than one skb is not a bad
> > > thing since there is an emerging/promissing trend to do a detailed
> > > packet granularity monitor.
> >
> > This is rather weak/lazy, especially if you do not know how long the
> > thread is put to sleep?
>
> Thanks for the review!
>
> I actually thought about how to recognize which one should be the last
> skb in each send syscall. But it turns out that much more complicated
> work needs to be done which hurts the stack and common structures like
> tcp_sock. That's why I gave up and instead chose a much simpler way to
> minimize the impact.
>
> >
> > >
> > > Thanks to the great ID, namely, tskey, application that is responsibl=
e
> > > for the collect/sort of timestamps leverages it to put that record in
> > > between two consecutive send syscalls correctly.
> > >
> > > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/ipv4/tcp.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index 516087c622ad..2db80d75cfa4 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -1411,9 +1411,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct=
 msghdr *msg, size_t size)
> > >  wait_for_space:
> > >                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > >                 tcp_remove_empty_skb(sk);
> > > -               if (copied)
> > > +               if (copied) {
> > > +                       tcp_tx_timestamp(sk, &sockc);
> > >                         tcp_push(sk, flags & ~MSG_MORE, mss_now,
> > >                                  TCP_NAGLE_PUSH, size_goal);
> > > +               }
> > >
> > >                 err =3D sk_stream_wait_memory(sk, &timeo);
> > >                 if (err !=3D 0)
> >
> > I think non blocking model should be used by modern applications,
> > especially ones caring about timestamps.
>
> Please note that BPF timestamping has already been merged. It's a
> standalone script that monitors all kinds of flows and discovers those
> strange/unexpected behaviors. So we normally don't take a look at the
> implementation of each application before spotting any exceptions.
>
> Besides, sometimes monitoring the latency of the host doesn't have
> much to do with the mode of application. People might want to observe
> more deeper into the underlying layer. Right now, without the patch,
> the monitor possibly ends up missing the record of this send syscall,
> which has been reliably reproduced by Yushan.
>
> >
> > This patch has performance implications.
> >
> >  tcp_tx_timestamp() is quite big and was inlined because it had a singl=
e caller.
> >
> > After this patch, it is no longer inlined.
> >
> > scripts/bloat-o-meter -t vmlinux.before vmlinux.after
> > add/remove: 2/0 grow/shrink: 0/1 up/down: 239/-192 (47)
> > Function                                     old     new   delta
> > tcp_tx_timestamp                               -     223    +223
> > __pfx_tcp_tx_timestamp                         -      16     +16
> > tcp_sendmsg_locked                          4560    4368    -192
> > Total: Before=3D29652698, After=3D29652745, chg +0.00%
>
> That's right and I really appreciate your recent great effort trying
> to mitigate the impact of function calls.
>
> My take is that it is a trade off. Adding one more track of the skb
> (which adds a function call) actually doesn't hurt much especially for
> this scenario and the last skb scenario. This path basically is not
> that hot. There are some left things to be done to improve the
> socket/BPF timestamping feature. And I plan to push more patches
> (sure, very carefully) to enhance the ability of BPF timestamping to
> observe TCP which is inevitable to add some extra functions and if
> statements.
>
> I'm wondering if the above makes sense to you.

If you mostly care about BPF, I would suggest:

iff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index bd2c3c4587e133897aa057bd3b26c29df050607f..444254b8870c4406a7105cd3ce1=
77745fb1b6c0a
100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -506,6 +506,20 @@ static void tcp_tx_timestamp(struct sock *sk,
struct sockcm_cookie *sockc)
                bpf_skops_tx_timestamping(sk, skb,
BPF_SOCK_OPS_TSTAMP_SENDMSG_CB);
 }

+static void tcp_tx_timestamp_before_wait_memory(struct sock *sk)
+{
+       struct sk_buff *skb;
+
+       if (!cgroup_bpf_enabled(CGROUP_SOCK_OPS) ||
+           !SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING))
+               return;
+
+       skb =3D tcp_write_queue_tail(sk);
+       if (skb)
+               bpf_skops_tx_timestamping(sk, skb,
+                                         BPF_SOCK_OPS_TSTAMP_SENDMSG_CB);
+}
+
 /* @wake is one when sk_stream_write_space() calls us.
  * This sends EPOLLOUT only if notsent_bytes is half the limit.
  * This mimics the strategy used in sock_def_write_space().
@@ -1403,10 +1417,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct
msghdr *msg, size_t size)
 wait_for_space:
                set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
                tcp_remove_empty_skb(sk);
-               if (copied)
+               if (copied) {
+                       tcp_tx_timestamp_before_wait_memory(sk);
                        tcp_push(sk, flags & ~MSG_MORE, mss_now,
                                 TCP_NAGLE_PUSH, size_goal);
-
+               }
                err =3D sk_stream_wait_memory(sk, &timeo);
                if (err !=3D 0)
                        goto do_error;


Note: You also could use a different skops to differentiate cases in
your monitoring.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 1/0 up/down: 69/0 (69)
Function                                     old     new   delta
tcp_sendmsg_locked                          4848    4917     +69
Total: Before=3D29651496, After=3D29651565, chg +0.00%

