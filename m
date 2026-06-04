Return-Path: <netdev+bounces-295067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cPSaKLMoIWp3/wAAu9opvQ
	(envelope-from <netdev+bounces-295067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:26:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D7263D9C2
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:26:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=k+Y9YeKZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295067-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295067-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57E11300C828
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 07:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9131C3D6CAB;
	Thu,  4 Jun 2026 07:21:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB27175A86
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 07:21:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557662; cv=pass; b=LYap7XJqol+41OPl6mswLeOPM7/f2XnVaKQ3mJjG7+U+Tm4CzdK/5naafkNlS/tkX6IXKVV03CV81zeSrOEd/6H/yaxL/UbypYG6PQvfnh7Y+eLVTAgBoGqUxbvP7837A+BNFEXEzmOSRi7l9RNdsGuGZOCjNTTpAxkEGrMaw94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557662; c=relaxed/simple;
	bh=X9xjukybo6S7vXXk+qL+5aNke3f2xVT5L4Cl/0Wyf2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WuhJQpsBVBkPRdCSqouCRem761Beraewb7D8GMeC4BMGhF+d/5Y5ld23dIQpH5A7bvufT60xjR32xlJkD+KP+VhoviP4K7HSoUWevkQ4ZHZFUCep68IL9Ewy19/rOqhGG7WlSmeBdPaAgpoUcwbKsfqKxC82ns2w83aZgsscCYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+Y9YeKZ; arc=pass smtp.client-ip=209.85.160.170
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5174a3d9598so3660471cf.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 00:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780557660; cv=none;
        d=google.com; s=arc-20240605;
        b=QRKenuPc3ePMijURJenkkxO/VN7e2KsPMh+M3GlInsFYDJX/6t2ajGa99/N9fbHxNg
         mxFshR69uVh2qkUjkAv69ih5lf7ZDXANDspugU6mhxSRmwKNl1cEg6Zuen4THhAqVhA6
         QU6e6EcUVvy+E2ZAjdKP8Nah6f1sJ1ODQJwJchEDESa5b5hgDfMkS3yhyIB88h6O4K9S
         xHvI038F5VkRe8wL75UWqdGLQbsHz/+R/hs4Dm7E2iS/ywNX1dvgbsUr/iYxtc77IhOG
         kWQMIa2GpJjLi8U5hhMfqQRKUxIzvcGNn4SRCECYDvWqPoTgY5rSV4NwbwaB1x48qzuj
         ikbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VRJUjNFYXqgMCP6VqtwWRNf39zONDcKlcYz+DrknF84=;
        fh=dvnGgD2it5si6ubeRTq8cWbTqZOBMPW5IUdXL4EHTe4=;
        b=UJ7FspKt8a/OId277gvsq77Na9qNH9Aq6dbBAtDMCBzC5jVLDdBAitxOepxfwgkQto
         ge5E3/3SSbPiCAIlew0iAUPc3UsJbFPdK3uWdoAsv64LxTxTPhMLkB0I/cJoT33WufRW
         /AXCgdd8bgXYxrcZo2hHSdUWyLB9BkxIc2+6wmgNAYYusyy32VHv8lh/LpwwJmPOIYih
         RRr8yxUf9FXWi6Rl2ApUu330nZfUvxBEkEA68V6+jx8uR07xJOl6yJVDwN3JMkB7atY9
         80xB0mgfNWlF4udaFOzlymzGQ97jURW4UBMU5FlD0TyW1An3ymRLwjRAA1uW338jfjYR
         E7+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780557660; x=1781162460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRJUjNFYXqgMCP6VqtwWRNf39zONDcKlcYz+DrknF84=;
        b=k+Y9YeKZrZHeZr5p8KrOFEwrZNeOUYgGeEGjVO1RtOm8To3B81zor3JX+RH+zjFDn3
         RdY28+bLWIwriPh31B4vJsPxVl/DLtD1GwR2OPvK5Y6RQgi3gZGgcFn3NdS5yZuaXEKT
         c7m5OZ7DnG/ZvB+iHO1NsrM/CNB1xax4g2c/xGq9nv9SaWovq22VKe3o8fj5Xdrboy+u
         xGtP7nyeVTSejeWajp5M+AZJbeE8Gd6JIRTc5BFn/6BBbPon8zGrl8fpN61xACSqsWpN
         H00b+Khgj0jaOp4TaLAb+vBIJknjhtPsORs3Al9DklqbO84bFeLiYeXNlJxQ+yuGGAO3
         N8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780557660; x=1781162460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VRJUjNFYXqgMCP6VqtwWRNf39zONDcKlcYz+DrknF84=;
        b=AvJ4NAFC8/tb/VinnoJWBxYnJaoEcNwNQ2M5cbXovqAXcXH9m1TCxYYjVhv8Tq9YnP
         k+p9M8sB3VqFb9Wax+x3SHYBNGqSM7SFApp8NXU2DnKDCt/8JmAumNFYg4nYQJarPgkN
         otxS3lqeRVSaG4uL79pZyDBvcHN2hzY822x/aT0UKWD/+4uO3GqRjS16RwOGXsuJBXfs
         QdnxqXhEN53L9upShpxeaTEdN+Tff6HSMAd+UZ0Dj9UC8OpNcss8NU3ozviQmelLQX7H
         cuvDAT8Sre1d/luGk5fdD2FrRSQo/1/7rziSNPxT8I9awH4TcsFUJnTzlcPd/8y2uU55
         6eLw==
X-Forwarded-Encrypted: i=1; AFNElJ/YS2ndbbUcuSirxsfmeoL/nH5uE+08D0+ckiue5NEenkCrnGCX/Kw5GXZ34s1WnGVZ4/Ugc/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzroxsbZUY77XkR9S8kxWpiW99cQ4XiUCMJXCjAusvSiYQLk/nu
	kklNCSeV08GoAmkB8Bzi43vOcKId14w2LJkJ82aZ25xyeteN7hrG2DSirVlBE1rXBs3JYGllKcw
	qd2KlQqhif6kyp9068ym+v0MTT3EjsNBZlGXN
X-Gm-Gg: Acq92OFLi5vJJj5YL/wvUMNgjFeAdP/lBKTZtEbLAFeLCPFGDQaoVqtNBfkt+zVbclf
	LqRtPIau+mmmXsv+IKahtOoau6FM1nh1mHabCouWJ1l0gloNdIh5Awd1ZImfC/CiFw5J7jNLh0t
	MRuBTUXa9e8Y08Tp7GPRg/ZrX4qwLBxZCG4GvdRQYcL4EgEWPAdz10/DaHv0MLhQwNXXElOiWUL
	4BmpYECmryUhVWXLgpVTbG6AlexxfcCyzG8SJOOrFRkcyjGqJXr/Hm4xzv5Oo5ps1laKTrdKHDS
	0HASiILhAtqcit5ziBI=
X-Received: by 2002:a05:622a:7c95:b0:517:29c1:2b58 with SMTP id
 d75a77b69052e-51778706242mr69490691cf.48.1780557660032; Thu, 04 Jun 2026
 00:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526063650.952-1-xuewen.yan@unisoc.com>
In-Reply-To: <20260526063650.952-1-xuewen.yan@unisoc.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 4 Jun 2026 15:20:48 +0800
X-Gm-Features: AVHnY4JMDbEjgp_41z4QQ3jxPPk1W4FxPy4hld5AnX75Yz1GbP34j3RzSyqNPn8
Message-ID: <CAB8ipk9-A2KPFu6B4PVfJ-X+W1QvH0dwrkPZS_3xzdLOOPOBUA@mail.gmail.com>
Subject: Re: [RFC PATCH] net/core: use wake_up_interruptible_poll() in sock_def_readable()
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: edumazet@google.com, kuniyu@google.com, pabeni@redhat.com, 
	willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org, 
	peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com, 
	guohua.yan@unisoc.com, Wade.Shu@unisoc.com, di.shen@unisoc.com, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:xuewen.yan@unisoc.com,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:peterz@infradead.org,m:mingo@redhat.com,m:vincent.guittot@linaro.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ke.wang@unisoc.com,m:guohua.yan@unisoc.com,m:Wade.Shu@unisoc.com,m:di.shen@unisoc.com,m:jiayuan.chen@linux.dev,m:jstultz@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295067-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[xuewenyan94@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuewenyan94@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16D7263D9C2

Hello everyone,
Any comments about this?

Or we only ignore sync for thread:
---
diff --git a/net/core/sock.c b/net/core/sock.c
index b37b664b6eb9..a46334266e86 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3610,9 +3610,14 @@ void sock_def_readable(struct sock *sk)

        rcu_read_lock();
        wq =3D rcu_dereference(sk->sk_wq);
-       if (skwq_has_sleeper(wq))
-               wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN | EPOLLP=
RI |
+       if (skwq_has_sleeper(wq)) {
+               if (in_interrupt())
+                       wake_up_interruptible_sync_poll(&wq->wait,
EPOLLIN | EPOLLPRI |
+                                               EPOLLRDNORM | EPOLLRDBAND);
+               else
+                       wake_up_interruptible_poll(&wq->wait, EPOLLIN
| EPOLLPRI |
                                                EPOLLRDNORM | EPOLLRDBAND);
+       }
        sk_wake_async_rcu(sk, SOCK_WAKE_WAITD, POLL_IN);
        rcu_read_unlock();
 }
@@ -3628,9 +3633,14 @@ static void sock_def_write_space(struct sock *sk)
         */
        if (sock_writeable(sk)) {
                wq =3D rcu_dereference(sk->sk_wq);
-               if (skwq_has_sleeper(wq))
-                       wake_up_interruptible_sync_poll(&wq->wait, EPOLLOUT=
 |
+               if (skwq_has_sleeper(wq)) {
+                       if (in_interrupt())
+
wake_up_interruptible_sync_poll(&wq->wait, EPOLLOUT |
+                                               EPOLLWRNORM | EPOLLWRBAND);
+                       else
+                               wake_up_interruptible_poll(&wq->wait, EPOLL=
OUT |
                                                EPOLLWRNORM | EPOLLWRBAND);
+               }

                /* Should agree with poll, otherwise some programs break */
                sk_wake_async_rcu(sk, SOCK_WAKE_SPACE, POLL_OUT);

On Tue, May 26, 2026 at 2:37=E2=80=AFPM Xuewen Yan <xuewen.yan@unisoc.com> =
wrote:
>
> sock_def_readable() currently uses wake_up_interruptible_sync_poll() to
> wake up tasks waiting for readable data on a socket. The _sync variant
> sets the WF_SYNC flag, which tells the scheduler that the waker will
> schedule away soon, so the wakee should stay on the same CPU to avoid
> needless cache bouncing.
>
> However, we found that the following stack:
>  -vfs_write
>  -sock_write_iter
>  -unix_stream_sendmsg
>  -sock_def_readable
>  -__wake_up_sync_key
>
> In this process-context scenario, the waker does NOT go to sleep
> after the wakeup. With WF_SYNC, the scheduler is misled into placing
> the wakee on the waker's CPU (via wake_affine_idle()'s sync path when
> nr_running =3D=3D 1), causing both the sender and receiver to contend for
> the same CPU. This may hurt throughput for IPC workloads on multi-core
> systems where the sender and receiver could otherwise run in parallel
> on different CPUs.
>
> Switch to wake_up_interruptible_poll() which does not set WF_SYNC.
> This allows the scheduler to freely migrate the wakee to an idle CPU,
> enabling true parallelism between the sending and receiving processes.
>
> Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
> Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
> Note:
> The possible cost is that for softirq callers (TCP/UDP receive path), the=
 wakee
> may be migrated away from the current CPU where the received data is
> cache-hot. However, this is mitigated by:
>   - The scheduler's existing wake_affine logic which already considers
>     cache affinity regardless of WF_SYNC.
>
> We are not very familiar with the networking code here,
> so we would greatly appreciate any suggestions or advice from the communi=
ty.
>
> Thanks=EF=BC=81
> ---
>  net/core/sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index b37b664b6eb9..42ab9373194f 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3611,7 +3611,7 @@ void sock_def_readable(struct sock *sk)
>         rcu_read_lock();
>         wq =3D rcu_dereference(sk->sk_wq);
>         if (skwq_has_sleeper(wq))
> -               wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN | EPOL=
LPRI |
> +               wake_up_interruptible_poll(&wq->wait, EPOLLIN | EPOLLPRI =
|
>                                                 EPOLLRDNORM | EPOLLRDBAND=
);
>         sk_wake_async_rcu(sk, SOCK_WAKE_WAITD, POLL_IN);
>         rcu_read_unlock();
> --
> 2.25.1
>

