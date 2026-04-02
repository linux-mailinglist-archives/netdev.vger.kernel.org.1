Return-Path: <netdev+bounces-274578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EgVKg19zmnBnwYAu9opvQ
	(envelope-from <netdev+bounces-274578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:28:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FDF38A826
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BDAD30221DC
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAD935F17D;
	Thu,  2 Apr 2026 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FOqyXwHP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3689831A56D
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139884; cv=pass; b=X2vzLFEfAxKjV3St8zy2FR6SNHLnUXvi/aQxWVWbdgvnyZpJPCmMFj7STA4x/3dHVQfHzSLlhbU7s4GNZ3Jjj/botG3TqVRheXShHl5rjduEWkKNXRk7DlVtuKr18dTxmhH5KH/E3vZ1DcQT6ItYrR+FpzqgkZe8LvoIvxxfUSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139884; c=relaxed/simple;
	bh=8hsZ8cL5+nxdwXF2zSWzvhJFXFQdIP1olQ5tBs9vJlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2E24/MZS9p+CuI4BhPjEYEl0pceAKhZyHbUobA6zk7OeP+wXKKEjW0ALZG7nxnEytYLj5widiBESBDK+lrt5DTsACux1QllzCD3roanBx+m6hauaDaUWnzYbu790J6bypDMrv2sM/Ya5zp8EkQ6yZ1K/J+WkvDMMmQffMGdZ5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FOqyXwHP; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78fc4425b6bso8903287b3.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 07:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775139882; cv=none;
        d=google.com; s=arc-20240605;
        b=VBavw1MGRpzsuhkub5YG2VqeSEvWN13QJ3T9TgCC8OiyHQlfUo/DCFD2IHXSFPeyWl
         2hJm5MNclsbiqQs6EZDV00maJKMBPsvA+qbySRVihKpzH7MkCZA1X2lekIcQzGlDGC6C
         qSoZQSDTJGyUkW4hEh4GhS93N46epqf52O2q/6vZtQeQXJ0Mjyo2079jm/TNTKLOFypG
         LHSFttZZB9wRw3LmvEfG98sD+Nw0zA9IIMWVNVlLbMBbR2vBeoFD6lBuW+YZV1zcR4Oe
         uG3Q/ynIPKFnjRvcp3qfoGtPvHsd03bQJdz85UA2W54jqNdk9arC3WqndKsbFJu/6ae+
         esIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oCTsrTbOoiqUODDl+ehJyDER0SUYUSECnbsmac1XMvA=;
        fh=vKtP3qr1sSlTpWrWucv0+Gx0Tz6v3r6lSEtI9QGGxKQ=;
        b=FHgNcb3sRwr6dP6OAk5WFHNWtoVgbbqn1sYKCV3YrXljp4mJxooRAC1FQvyAcjtiFb
         ML4crAtZg45K67tMnwiboeXiYl+/VyU3tERRzRXGBYhXNjY332mUDcj+eC1p0uGBEF4E
         Jky2iDfzMOMWuMKJtq2TOtK0lqtzL1ptBgENUBfkPKGWnhBwmoX1ZeMHP1dqaW4KO8RA
         pztnsjOV4mABuCKyQSImjdAvqF11cF3Q1XXMLQAgOhKfs/MzvrDowtkLqfXkDf9xYZna
         MmKKr+EMUtO5jMFZxtPSwKFz4H+Z21R+wjZtboDWHn7+IQNuvXFxP7sCr9pjGe0Y7Hu3
         Rbbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775139882; x=1775744682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCTsrTbOoiqUODDl+ehJyDER0SUYUSECnbsmac1XMvA=;
        b=FOqyXwHPP4gAeG1XeqMcu7E+E2EJCnVQGhZRT979Ozxyi8MgHri5aseQUzmNlcVJ46
         9ISOVVGEHuDV+J5O3OUNRfedwM9QVIUsrmAb7WMMvO1OUVBWTz+V4lwAI1r16CZ5om7Q
         gk8M6OIyMGEiRXFh3bfqWpu5UgJ49uiqwPW3WyYUDdfw8BwIvQkpLsNSW1c/ngrOhhrj
         brOTiEQr4H0v/cq3Xfh56SEOlKrFoMGfNfGtcDYZx+GMFwpx8Ed94h3jhiZ9n7kJLONn
         SfW+J19Bp3vgNkjH96bBMGv3EeLQB7MuvmPYNbdsFMw0eCI3xV807ZDfwJPBnjRf1ljh
         sdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775139882; x=1775744682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oCTsrTbOoiqUODDl+ehJyDER0SUYUSECnbsmac1XMvA=;
        b=NNPMtssY6dMNL0raDZ1WXna292dqsQXTXIcw0ZR5uWPAlCy7Axgk15a4NdNoqXUWfB
         bjkdQeRus1ccJNXDzQ+Z3N+qU5+F9Mi5EWwnNL7c0vIIb43ILi2Lzp1T/pP2hvKwo/kL
         w8nDoYNPNXtQDZDNt65mmoFt9hcE2EjyZ9+brLCNJXhVCG9Bds8Qhfcc7JpWhutFnZwL
         QlKFM1qkPEHrZBIkxmzXNAC4Ii49rLWfyQtY96iffHGbsOO2Ld8OG5n48rgUySfZ1MMb
         aOAJJEWqAdEBW+DjdHvmNvWO7foWRU1l7+xgJrNKvE+5OTZap9S+tGqSeqaCTxdNlh2d
         SvVw==
X-Forwarded-Encrypted: i=1; AJvYcCXd4SLuAcNayF5n+qgqgSj4766CUsevpnNpvQhbF0QnA18hwBJfApgUa1+fmq28ZkAY8Km3UK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXxrXeIzHO8Nq02vqi4ACKWooB85LMOhzCvvy0dOgMLehJJ0UE
	fqlBYuy0MLxyMaJcOZ6t8Li5KTSFAXNSSk3XEa6hd6IV+wrey80eq/aXzwJB382RL4zLu0DISRC
	5rGwWLOK9AoFIcDIqh2si+nmIXaWK/zXT8SzT87s+
X-Gm-Gg: AeBDieuAUmOPRJhQ84BhplWjqra6Zh9XF6km/qv4/VbGad2CDPXbHh+8R4agbA33TDQ
	3QZzYnMpZJNLaz9qn89Twp6fID8KNYOKOhW/Jx1YfpoiVivnGuAp61omqdXLvFux2Ezty1J0hax
	TktkeIcoICz5ZWMhlBF/R77HhLRhj/qFgflmvQSsic003krdWFLxJcX9Q2WFHJiYp26jMea8tO0
	f54mccYNm5a131bmxc4HUvpr+FkoNrTBDrOmn4nbWjjEWITC0s8qogQ0dYfjyTu8Xsi3tdyzHnE
	3ZVl/Hs=
X-Received: by 2002:a05:690c:6806:b0:798:4f55:2c5e with SMTP id
 00721157ae682-7a212639535mr84670727b3.30.1775139881626; Thu, 02 Apr 2026
 07:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402085831.36983-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260402085831.36983-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Apr 2026 07:24:29 -0700
X-Gm-Features: AQROBzCfpqGuAcDxNombrXH5bCUmilYU3R42ScGwtXHi58-lNMIukCtnpLEgLc4
Message-ID: <CANn89iK-e1=yQhN0t48Cm7ru9cYwKwBw1_DDRcVffX91s4wWNA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274578-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 10FDF38A826
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 1:58=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs even
> though it might not carry the last byte of the sendmsg.
>
> If we don't do so, we might be faced with no single timestamp that
> can be received by application from the error queue. The following steps
> reproduce this:
> 1) skb A is the current last skb before entering wait_for_space process
> 2) tcp_push() pushes A without any tag
> 3) A is transmitted from TCP to driver without putting any skb carring
>    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> 4) sk_stream_wait_memory() sleeps for a while and then returns with an
>    error code. Note that the socket lock is released.
> 5) skb A finally gets acked and removed from the rtx queue.
> 6) continue with the rest of tcp_sendmsg_locked(): it will jump to(goto)
>    'do_error' label and then 'out' label.
> 7) at this moment, skb A turns out to be the last one in this send
>    syscall, and miss the following tcp_tx_timestamp() opportunity before
>    the final tcp_push
> 8) application receives no timestamps this time
>
> The original commit ad02c4f54782 ("tcp: provide timestamps for partial wr=
ites")
> says it is best effort. Now it's time to cover the only potential point
> to avoid missing record.
>
> The side effect is obvious that we might record more than one time for a
> single send syscall since the skb that we keep track of in this scenario
> might not be the last one. But tracing more than one skb is not a bad
> thing since there is an emerging/promissing trend to do a detailed
> packet granularity monitor.

This is rather weak/lazy, especially if you do not know how long the
thread is put to sleep?

>
> Thanks to the great ID, namely, tskey, application that is responsible
> for the collect/sort of timestamps leverages it to put that record in
> between two consecutive send syscalls correctly.
>
> Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 516087c622ad..2db80d75cfa4 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1411,9 +1411,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct msg=
hdr *msg, size_t size)
>  wait_for_space:
>                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>                 tcp_remove_empty_skb(sk);
> -               if (copied)
> +               if (copied) {
> +                       tcp_tx_timestamp(sk, &sockc);
>                         tcp_push(sk, flags & ~MSG_MORE, mss_now,
>                                  TCP_NAGLE_PUSH, size_goal);
> +               }
>
>                 err =3D sk_stream_wait_memory(sk, &timeo);
>                 if (err !=3D 0)

I think non blocking model should be used by modern applications,
especially ones caring about timestamps.

This patch has performance implications.

 tcp_tx_timestamp() is quite big and was inlined because it had a single ca=
ller.

After this patch, it is no longer inlined.

scripts/bloat-o-meter -t vmlinux.before vmlinux.after
add/remove: 2/0 grow/shrink: 0/1 up/down: 239/-192 (47)
Function                                     old     new   delta
tcp_tx_timestamp                               -     223    +223
__pfx_tcp_tx_timestamp                         -      16     +16
tcp_sendmsg_locked                          4560    4368    -192
Total: Before=3D29652698, After=3D29652745, chg +0.00%

