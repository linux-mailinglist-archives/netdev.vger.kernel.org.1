Return-Path: <netdev+bounces-274593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Pb7HWGHzmnfoAYAu9opvQ
	(envelope-from <netdev+bounces-274593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:12:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E666538B18A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91B16310C69B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B2F3EF657;
	Thu,  2 Apr 2026 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI0A4/uB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210132E6BD
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142203; cv=pass; b=uLAIAhbn8b/NeXfiI1hy+ClgBs43Zl+EBYEvoKYTm/hkNa5V7SD150EoZ7LQ6+RdmeyQb4ZqjnR5jxLSl1lniPSYLVTOrHjhFa/UQ8xfqrNIxnvyJ0Q8rGuXx7fu8+Du/oY2ERCrVB7jm4H92omOoHY1Gss6r+xudsJ5p7V/2iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142203; c=relaxed/simple;
	bh=lofNdyWUXZVap12KWLURp/pYOz4oIDqw8y6o1ELMaVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9QRjG+EY1f15cdYLpXY//5AI48pZD6cT7efq6PqKUW2Ox6u+2rLoPLFJRux113nWI3kjERTM3BFLuasxt89WmHIBWlBZeyt+kjTDXk423BY/6yeiJfRdkVfpZkaksfD9SljIQoxtkQ7URyxc676HO8kaj7vKY7gmTEUYLzIxnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZI0A4/uB; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a2beae348eso1213657e87.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 08:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775142200; cv=none;
        d=google.com; s=arc-20240605;
        b=aNaZGp6tJGqPHNRZUhIUdkLGWKGQtrWn6tkG/uvMnZMGyoXylzZYmF+VxhjNbUPPSa
         T1LdoF1mO2q3ziLY/djCkftFIFHxHC5lnS1czKg/EnAkx0o/q66EQ3Q9jDLLt3Hw8Cr0
         l0KW/qdN0DzSDexCHXwycmfihnjCZwhL3FYqJxU4C1k/Wpy1GdhYauON+SAskmPPWIlN
         5yUVoe3jpkc1VICBxrokdxwdXLI6o7ilQsms3QBKO3lblm5alwhKjAyOfwVyfbiuX8dP
         CwF8jNgFurbGqBJqD9lbcz2d/jQcuByMC8diaHh57dp00z4I6oyrGMqO2ddA4HwPPXDj
         9Ivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n1EgYJ9vycbY3i86U4BIFL6EWmDytvwea3vastxduog=;
        fh=UiWyrBDw+fcsD/ypwStbHYw0P/Tk7kDtScVke8oIAWs=;
        b=h8od9Mr9azXhuA/eUrG8BWjVvMj2lquZet5nUpcL0ZXatBzP5jEdu4/F2n1qdNqla0
         WWbCY9RNoYr5QMydU/Eee7f1nSYWNUvxixVTJHeeFz3Vt+pKUAJahdIB0q9djYJupoBT
         MMr44FLiRUlnXuiKOS0hbr69kn1EmJrT1Ghbi20Fux1zp2Tv2Jeh9TgSomagIMvPVbCn
         p/s4WJe/t2KBPxznBFcH2qWt1fl14QJuORQaQEPyquISvxkt02OVB6dMrFosV24guJ0w
         vl7gpJ7GqILTYpVU9qkDGxIM2HymBTn3ezrcbYEgXTcx+QwMlMZ9wLF4HzrAGuDp4C+N
         Kyyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775142200; x=1775747000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1EgYJ9vycbY3i86U4BIFL6EWmDytvwea3vastxduog=;
        b=ZI0A4/uBqQDpQgcviu0kcugFgXjFQwfYEqggjkMUVTSrgu8o+JpHxTE0TI/NHrvNX8
         DYhOnrEbW0PG+7KkoccZ89Tq8kIyVtHx4erGbd4auCbCoUqt2gUSQx5jpg825wk4F6g2
         bZ9Zrzxqfu4pWt9AIRyHODAavuKQkMJDdWnegNq49Au2XRIcUXanezOMixfR+YfxEfKE
         0rJF15g14SBRgrWl8bOOLUKLlSVR5eK0tPYlbM0S8yPPqY6MfqxgiOwjMSnZIEYJuqhV
         6CJ0MxAj1+vlkPrS9ihD7i29uGXnQ8gAWnL6MStgUOg6kJGyhkSjzFt/QbDmLrTht6c7
         ctvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142200; x=1775747000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1EgYJ9vycbY3i86U4BIFL6EWmDytvwea3vastxduog=;
        b=TV102Xf1SVISJuIGACTBt7zcfWSQkhUgq0d8KYsvDnivkUliBb+POaM3NbnkoNK01E
         Yu5n6x10QyqdBOpAW6JfyLz0Gy8ZoS8dEFp4V5EuXydlQWMKsjggzjkD7A7y8Ji/yYs0
         FIT3+/Ooj6FubpyEtkU+nj7ukAq+zIADcnFw4OLP/wTlpA6aLAMXGrjo6SBJezNfS+y6
         ArqQqUizfqQnA8WF4XhZDsDHcUO01C7Q38U3lFL9lKKPFFViyr6+Zf40I8EVFk4+DRQH
         P2kB3Cp8RzvenwKEEE0mGijV/qKzE19tlihInDYmwwHepfFKO3bwc7sWgcEgNQLlRZKd
         1mtw==
X-Forwarded-Encrypted: i=1; AJvYcCUZLcf32yFYO6xkjEDNzjPuGAXr3zZVUxL3s83Ub+3ET6oi8EH8aZ+nP341PWOxLC2erfhJFGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xCV8oK7MpdPFB26BvVYmPEojLbkl9YPGLVcPtG/F9B+1BJbf
	VVJ9sgQ22tBWAVodtOvWeH/Nj6k23IQElDlMN4hKTpyPdMQUPgi1bIPOJEYM+4l0RQUaxmt1meS
	Ho5bYpJqHGjd1b6/qDgQSINEYPdDqEaE=
X-Gm-Gg: ATEYQzxWug4xv36cZlRbIKXj9m/k41tG5UEdV5aHC+zp9Hs+Hy3daPTL8DQebwU7K77
	hX+i85DXOc1lZz5FMw/BtuROr+K1gkEz8ayJfTffChbGj2PYORohVKRzlYwSs9LhonQO4M5Nw3z
	mq886hop9a9zxG3YUOIywsTQ1N6krKqej21uY9RV7/CIqPsoEUBQS4DfF52buz5vRTA/X5FvILN
	P5gytvnzL44GPVPIGIoxzYrOU/xJXmmq/YJ69THjNwS6UHwnz4MPSYgomHxEgOcA8UuexqjZLEx
	V+hqNF4=
X-Received: by 2002:a05:6512:3b9a:b0:5a2:c9f8:afcb with SMTP id
 2adb3069b0e04-5a2c9f8b0demr890264e87.21.1775142199369; Thu, 02 Apr 2026
 08:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402085831.36983-1-kerneljasonxing@gmail.com> <CANn89iK-e1=yQhN0t48Cm7ru9cYwKwBw1_DDRcVffX91s4wWNA@mail.gmail.com>
In-Reply-To: <CANn89iK-e1=yQhN0t48Cm7ru9cYwKwBw1_DDRcVffX91s4wWNA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 2 Apr 2026 23:02:41 +0800
X-Gm-Features: AQROBzBJfSydgfwqPkDmNwNo4GMnmziuySDVe3m_UFJO5oSXU6idj1BhnFcc7mg
Message-ID: <CAL+tcoDiyptBUch5LZuRKn5BbJK_6TcgSi91D31axRtjqpSzzw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-274593-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,tencent.com:email]
X-Rspamd-Queue-Id: E666538B18A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 10:24=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Apr 2, 2026 at 1:58=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs even
> > though it might not carry the last byte of the sendmsg.
> >
> > If we don't do so, we might be faced with no single timestamp that
> > can be received by application from the error queue. The following step=
s
> > reproduce this:
> > 1) skb A is the current last skb before entering wait_for_space process
> > 2) tcp_push() pushes A without any tag
> > 3) A is transmitted from TCP to driver without putting any skb carring
> >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > 4) sk_stream_wait_memory() sleeps for a while and then returns with an
> >    error code. Note that the socket lock is released.
> > 5) skb A finally gets acked and removed from the rtx queue.
> > 6) continue with the rest of tcp_sendmsg_locked(): it will jump to(goto=
)
> >    'do_error' label and then 'out' label.
> > 7) at this moment, skb A turns out to be the last one in this send
> >    syscall, and miss the following tcp_tx_timestamp() opportunity befor=
e
> >    the final tcp_push
> > 8) application receives no timestamps this time
> >
> > The original commit ad02c4f54782 ("tcp: provide timestamps for partial =
writes")
> > says it is best effort. Now it's time to cover the only potential point
> > to avoid missing record.
> >
> > The side effect is obvious that we might record more than one time for =
a
> > single send syscall since the skb that we keep track of in this scenari=
o
> > might not be the last one. But tracing more than one skb is not a bad
> > thing since there is an emerging/promissing trend to do a detailed
> > packet granularity monitor.
>
> This is rather weak/lazy, especially if you do not know how long the
> thread is put to sleep?

Thanks for the review!

I actually thought about how to recognize which one should be the last
skb in each send syscall. But it turns out that much more complicated
work needs to be done which hurts the stack and common structures like
tcp_sock. That's why I gave up and instead chose a much simpler way to
minimize the impact.

>
> >
> > Thanks to the great ID, namely, tskey, application that is responsible
> > for the collect/sort of timestamps leverages it to put that record in
> > between two consecutive send syscalls correctly.
> >
> > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/ipv4/tcp.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 516087c622ad..2db80d75cfa4 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1411,9 +1411,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct m=
sghdr *msg, size_t size)
> >  wait_for_space:
> >                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> >                 tcp_remove_empty_skb(sk);
> > -               if (copied)
> > +               if (copied) {
> > +                       tcp_tx_timestamp(sk, &sockc);
> >                         tcp_push(sk, flags & ~MSG_MORE, mss_now,
> >                                  TCP_NAGLE_PUSH, size_goal);
> > +               }
> >
> >                 err =3D sk_stream_wait_memory(sk, &timeo);
> >                 if (err !=3D 0)
>
> I think non blocking model should be used by modern applications,
> especially ones caring about timestamps.

Please note that BPF timestamping has already been merged. It's a
standalone script that monitors all kinds of flows and discovers those
strange/unexpected behaviors. So we normally don't take a look at the
implementation of each application before spotting any exceptions.

Besides, sometimes monitoring the latency of the host doesn't have
much to do with the mode of application. People might want to observe
more deeper into the underlying layer. Right now, without the patch,
the monitor possibly ends up missing the record of this send syscall,
which has been reliably reproduced by Yushan.

>
> This patch has performance implications.
>
>  tcp_tx_timestamp() is quite big and was inlined because it had a single =
caller.
>
> After this patch, it is no longer inlined.
>
> scripts/bloat-o-meter -t vmlinux.before vmlinux.after
> add/remove: 2/0 grow/shrink: 0/1 up/down: 239/-192 (47)
> Function                                     old     new   delta
> tcp_tx_timestamp                               -     223    +223
> __pfx_tcp_tx_timestamp                         -      16     +16
> tcp_sendmsg_locked                          4560    4368    -192
> Total: Before=3D29652698, After=3D29652745, chg +0.00%

That's right and I really appreciate your recent great effort trying
to mitigate the impact of function calls.

My take is that it is a trade off. Adding one more track of the skb
(which adds a function call) actually doesn't hurt much especially for
this scenario and the last skb scenario. This path basically is not
that hot. There are some left things to be done to improve the
socket/BPF timestamping feature. And I plan to push more patches
(sure, very carefully) to enhance the ability of BPF timestamping to
observe TCP which is inevitable to add some extra functions and if
statements.

I'm wondering if the above makes sense to you.

Thanks,
Jason

