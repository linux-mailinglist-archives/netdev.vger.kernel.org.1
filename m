Return-Path: <netdev+bounces-283651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAXUDlqX92mdjQIAu9opvQ
	(envelope-from <netdev+bounces-283651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:43:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2767B4B7045
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96E4E3001CCC
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 18:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352933988E0;
	Sun,  3 May 2026 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulOLG/af"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFE63859E6
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777833812; cv=pass; b=DimAGGJ8/h52/ylohQW75XXZ7+MYPMxOmFE2IORE+hVYFw4rvfuGWzNYwup/erIlmKPauMRMySiA9FwSn6hob3nlsj/Y2ljzkUqUV7M8spfQb6fCPRGPUh71Ihx1YasSyxJWirrQGAUJI0GpNiWDgIdgxM5+UxMXDzPZIi4WJ/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777833812; c=relaxed/simple;
	bh=f1hC6iEIXkPQ17P2Xw3+xWe4ppF+RMkkpnONRcne0aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQFiIquD5tlGGo0q2zLXq6LcRGGR7EFO962POKAJ+gcwq3A5yhlYEsMETakwY+sYAu3qHMH6ar9GMVqcoYsOhrsqLyixhsO25w4ReL+qseOzy1SZSxmue8EuVQfPnAmcty8o5vUfjfFzc8KSVBAW+Xkha7zRfvprnIhEDbETP2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ulOLG/af; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c1a170a50so4257828c88.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 11:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777833810; cv=none;
        d=google.com; s=arc-20240605;
        b=HntcVCT2hmiPI2QQpKWTnSzf8I+WpznahLymWnX6LriG2G61RzlU0QViM3gKGQdIOB
         dEwJTxV59ek0+V97Q7gn/QldI8HnUBijkLVBzGkL6xoAsol8U8a6EBAP+XFeihoxnfub
         Dnb4cJQf1GE1OSemgDN4kQe+FQA2kLZqVAekupc7rrWkfWtU8mIKjkgy6sLHxz6Vz47N
         9OvEf/0yEPD2p17cizXzQOyaqrhnxya8WsqZ6h0Q2H0d0hSkCGBKALBZeMIz1MXQCM0n
         6Hh32ulGeXJgIqGVskCHxFdXRt5RGWQ/tk4dMxXGKe2ctxr07ud9selT23Y/9wQj1g/h
         xuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IfvuJm+0t0GcG8lJDQwtknZ/zPfDtgffOwkhX9UhnN0=;
        fh=HF/9TwV850h/aNv+81pXws+sL1FusDTJ9uVmh/LX8YA=;
        b=C5XdIPWhDpwsuN2yaprKKqjPlXZYyIwKg1ipldcBPq0G8sFNH/an3Ve+Ongz64CDoF
         E25uQSbJLecACTSr4d+W327hNJiseNiYlynnbdBmItkeN7mJeXFYTP//6PZDFOZFce8L
         uJJzaZjZH0Y2zpgRwzlMTX9ELJ9NF78ynyRwK9Deh/dNMunQ/z1CeHP07IRt9FApSA4w
         3MsEd8DLlYShTVgWISkhiOE011++TKjToK6dHdiYgPT6RzMlbRqhVoYYgCLukViVL83u
         TACx7gyFRt14VuAqHMeTpx4cW/uMPejkc+0LFl2Jne5Ol/savBighwnFL/OMgpjPVRTL
         4IPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777833810; x=1778438610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfvuJm+0t0GcG8lJDQwtknZ/zPfDtgffOwkhX9UhnN0=;
        b=ulOLG/afKKKFuyyFWQUGIPTy9V8iPXfowHz05M45p169rIt30X2woVjXFSgCyfVoe4
         ahrZIaIGoTKIKw0VDXLk9WoLV4vD2gDpL2Beh/Tf/49G7ah3mkLhxP0UR7UCU9yjPwYx
         PD523kRy0FEu4jowA536JUkj7BTzujOBAzp2KkPCZYR0+Nwb4df363R+zd7shpT2rE0T
         jomVb6x4jfJaPaWORyfTSPEDYuJ44hoPEKi36RZy01ZgWFf6aWgBXgjXAPHCV4T0RTqR
         wbl00acXW/s6Zz5eR0O0o/qSTVIO2It6ktg/UDx9yTKLY0VemqjSXlI+tmKKZP0qsbTq
         RMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777833810; x=1778438610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IfvuJm+0t0GcG8lJDQwtknZ/zPfDtgffOwkhX9UhnN0=;
        b=ljJVPHrH5Cw8doZ8WVeX/DWhHDVJ57F69DhLO0A//nefOv7iiXaNAX1jkVM3OADJhU
         NJuMzqqyI1ntkRwc8FwlQmuILcQjD8wWSyvHq+3ot88e05O7K/PcRz+XyvvF9ptlY+a7
         W+GNttdVLMuU0OGO/Lj2HJ24T4dPCdW5EFR41yUS5mb5OV0eikKbXBspfJpv8x5YGetx
         ZmHpL8Z2ivbnFRNPuZ0S8hK7N+rfhhc+9pIrvBMD1IhmUIBK2Jav90oY9F6F3o+8rA8+
         wRJyWW+inhtPWYIiN1npiodOSsM/gF/wfB/dJlfYWnzu8AtjGUTc5Ba/BJ5InHyZz1NY
         DSog==
X-Forwarded-Encrypted: i=1; AFNElJ9MGA4niSn/fZaJ2om6Z0gUzMVwkZzlMo7suDHNOw63OE4XfAJvgmXwfmzEit26icESXSdO1Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIjXwUhZD7LmTNCyunNS5krWdED9WYugy9ntsY1T7r5mPIk0pL
	0kNMY7V9h/IhpjWMBh+jQ+Izq0AAXfRoILf3qNlYOW8bLXw3oFjOnOH6NVwgbZf8YGOVR8V6TxS
	tWgCJHEpehsR1aHN4ZIQ2SRR75O9XF58cEgBLRuqg
X-Gm-Gg: AeBDiev9KS6MUmI2JI2eQQmdRjM/MyB2JFGP/jXy8Q2PA2oBd8fzao06Beh9b4X//Au
	o4/11Jk4qphmW8VmpXe7WgxK4h9Fi8kczy6zm8W8C1VxxNfJZ95MobXRhVSRHXD5r3XUF3Ys1tP
	5Odil/WnW56iYSU/ssQ6GLpAURyF61YPCkFLuSqH9zNC2lm6MxL+99uklZBRwG78OmdNIvSrvo7
	f89gS5OPYBR6TVvcQL8apl1ZDtADqyp8wsuhtjAPm0uxM79feuEZeigh/HLifjWxp+nq5ESogLD
	gMjmzruM/Ag55R2TIgcgDT7CPGxhEb+krdmtM1c5E5TUxIn/38sANSmGnQnSP1bHt1eZOO92LVW
	+XL20AEnLw04okwVSR7NnsGfpxHbRFx+I980LPeDmUuxd7s/9I4U09mh7F1vr6VN0brMS8cjt3A
	==
X-Received: by 2002:a05:7022:2218:b0:12d:de3f:f3ea with SMTP id
 a92af1059eb24-12dfd885f96mr3108846c88.42.1777833809180; Sun, 03 May 2026
 11:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com> <20260502031401.3557229-2-kuniyu@google.com>
In-Reply-To: <20260502031401.3557229-2-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 3 May 2026 11:43:17 -0700
X-Gm-Features: AVHnY4KF8nbjgow-xptmbPmRMpR1rWhkHVXrdBqFkBX3dyaWaRHUByeHOfb6i2w
Message-ID: <CAAVpQUCFu0r_h7x2QefnHgKhtpM6A7te4P-QuCxcw2wGxaNbMg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 01/15] udp_tunnel: Pass struct sock to udp_tunnel_sock_release().
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2767B4B7045
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283651-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]

For Sashiko's review:

On Fri, May 1, 2026 at 8:14=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
[...]
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/=
rxe/rxe_net.c
> index 50a2cb5405e2..b454e4a17997 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -288,7 +288,7 @@ static struct socket *rxe_setup_udp_tunnel(struct net=
 *net, __be16 port,
>         return sock;
>  }
>
> -static void rxe_release_udp_tunnel(struct socket *sk)
> +static void rxe_release_udp_tunnel(struct sock *sk)
>  {
>         if (sk)
>                 udp_tunnel_sock_release(sk);
> @@ -636,7 +636,7 @@ static void rxe_sock_put(struct sock *sk,
>         if (refcount_read(&sk->sk_refcnt) > SK_REF_FOR_TUNNEL) {
>                 __sock_put(sk);
>         } else {
> -               rxe_release_udp_tunnel(sk->sk_socket);
> +               rxe_release_udp_tunnel(sk);
>                 sk =3D NULL;
>                 set_sk(net, sk);
>         }

---8<---
This isn't a bug introduced by this patch, but does this assume sk_refcnt
exclusively tracks rxe endpoints?
If the network stack holds a transient reference via sock_hold() when this =
is
called, it appears this would decrement the refcount and skip releasing the
tunnel.
Could this lead to a permanent socket leak when the network stack drops its
reference?
---8<---

Pre-existing issue.
The socket management in RXE is fundamentally broken
(vulnerable to concurrent newlink/dellink), and I'm working
on a fix here.
https://lore.kernel.org/all/0e05de34-79a0-415f-afb2-cc6c194ad87d@linux.dev/


> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/r=
xe/rxe_ns.c
> index 8b9d734229b2..64621c89f8bf 100644
> --- a/drivers/infiniband/sw/rxe/rxe_ns.c
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
> @@ -47,7 +47,7 @@ static void rxe_ns_exit(struct net *net)
>         rcu_read_unlock();
>         if (sk) {
>                 rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
> -               udp_tunnel_sock_release(sk->sk_socket);
> +               udp_tunnel_sock_release(sk);
>         }
>

---8<---
This isn't a bug introduced by this patch, but could dereferencing sk here
cause a use-after-free?
The sk pointer is obtained via rcu_dereference() but used after
rcu_read_unlock() completes:
rcu_read_lock();
sk =3D rcu_dereference(ns_sk->rxe_sk4);
rcu_read_unlock();
If a concurrent thread drops the last reference to the socket right after t=
he
lock is released, could sk point to freed memory during the
udp_tunnel_sock_release() call?
---8<---

Same RXE pre-existing issue.


[...]
> diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
> index 5bae3cf7fe76..422f86291b42 100644
> --- a/net/ipv4/fou_core.c
> +++ b/net/ipv4/fou_core.c
[...]
> @@ -634,7 +631,7 @@ static int fou_create(struct net *net, struct fou_cfg=
 *cfg,
>  error:
>         kfree(fou);
>         if (sock)
> -               udp_tunnel_sock_release(sock);
> +               udp_tunnel_sock_release(sock->sk);
>
>         return err;
>  }

---8<---
This isn't a bug introduced by this patch, but is there a use-after-free ri=
sk
in this error path?
Because kfree(fou) is called before udp_tunnel_sock_release(), if a UDP pac=
ket
is received concurrently, could the network softirq invoke fou_udp_recv() a=
nd
access the freed fou object via rcu_dereference_sk_user_data(sk)?
Should kfree(fou) be called after the release, or replaced with kfree_rcu()=
?
---8<---

Pre-existing issue that I mentioned in patch 11 and
orthogonal to this series.


> diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
> index b1f667c52cb2..1159a6a6fbb2 100644
> --- a/net/ipv4/udp_tunnel_core.c
> +++ b/net/ipv4/udp_tunnel_core.c
> @@ -195,9 +195,11 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct s=
ock *sk, struct sk_buff *skb
>  }
>  EXPORT_SYMBOL_GPL(udp_tunnel_xmit_skb);
>
> -void udp_tunnel_sock_release(struct socket *sock)
> +void udp_tunnel_sock_release(struct sock *sk)
>  {
> -       rcu_assign_sk_user_data(sock->sk, NULL);
> +       struct socket *sock =3D sk->sk_socket;
> +
> +       rcu_assign_sk_user_data(sk, NULL);
>         synchronize_rcu();
>         kernel_sock_shutdown(sock, SHUT_RDWR);
>         sock_release(sock);

---8<---
Can kernel_sock_shutdown() cause a NULL pointer dereference here?
---8<---

No, this function is not supposed to be called more than once.
Sashiko's example is due to broken RXE.

