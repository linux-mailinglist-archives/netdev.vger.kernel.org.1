Return-Path: <netdev+bounces-297944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AHibMExJKmqDlwMAu9opvQ
	(envelope-from <netdev+bounces-297944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:36:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA55066EA7B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:36:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=VTVVxToi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297944-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297944-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64CB23006D55
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 05:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E229B29A31C;
	Thu, 11 Jun 2026 05:36:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB219AD5C
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 05:36:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781156165; cv=pass; b=T8L54dLKYOZ6BM3aG1NzSmsHKaIxQKlYwJe15gY9RFtVv47qCEcA23iB8xc7Mg4JVBvGsA9NjPkDqTRxmmCqBYArtckUYrD6TTJSSv+/RbNUrgf96OTqw+kZtiGQJmNtR0A6GfjYuChT81P0aQXKBqxj8Gqzb3yJo5LqvQEcFoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781156165; c=relaxed/simple;
	bh=bwYCRmnq+jFXORV0LGb3H+BhPuUcqZI2WbWh7SUuGB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bI8WxJU2CWvVYHsubWuz2hxe70LR9I2jakPLsk8QzBl+2Wko5wzVwsM+hvbuLYtjEKwV3uu/q+e0b1vyUFOtK4ol20Rk3uB0wXQmKfjkU6GgQdky48Jy2lngZ+t5wP4iHDCZSpnkQl9T69Bh9Yt9yeTt79YQmAnxgnH0v+nNt18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VTVVxToi; arc=pass smtp.client-ip=74.125.82.45
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13807d2f898so7023274c88.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 22:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781156163; cv=none;
        d=google.com; s=arc-20240605;
        b=KC7xHYOsjJ8R8EKoRZ7CjTJgUBAz1UBv3/uqpay2v2xckHLY/dPdgG49Ru1yKIA6G1
         BsdznDeLiaSkWdM0OkL6GA3rw12AqweEcDTEvF7/vjAUCnkSGV2MUNzqbRcdQGtwg9ju
         REqPlW3o91mUGj6CHqheEXTbJa04sM1WeDO9GnOxGzA1g/nvAbKxDXJ+PGItuQo/8+Rc
         p1VaxCEEPDN9MWNd672XnH3JR7WbCbs402ruyLGL19Jmnid0gravQWSIVpcoQUk4eODb
         Acx7BAr044R0AsrOUoV46s+bsagVwmZ37HB33Vu1duxmDFDXXQjXi/q5b5k9njmtTyF2
         k+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=soAjsrXNMHmygPUT/9NkcmMIYXFkAZy1qTaNlUPMtYk=;
        fh=B1BtsyGLkEcJ0p/2o5phW9uMS0m3C6siJRxSx6qpUks=;
        b=iRMpDzKGlIVP0RkCUzYo42iCOVvUS//eLi6v4HrGWusFp0/6wfxLua9YGFuG9LOg/s
         ACSnHfiYIl+t31RuB5XNGNEHX35KJ34sONKiV5idDxfXv/quYeGQmAOtRS0Bd9b453l7
         UyRUR1uT3GqBbiCuo+jseLTKC1w5ZBN3cKypB0n6A27ubOnUBNZFr73eATQMCPbgFoVN
         PkTdCc/fg0hvRJuss0X7+q6D5nnggvqh5n3Oh0CJ9AojiUIBpoGTw0bOw0sWMQ603fo/
         L2b64N7GuZ/kvMIYyOT6rAXeCEJ/TaBxzA7OfD66pywIoCt06sH4g9+ULX6ASd9FOBWo
         8+jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781156163; x=1781760963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soAjsrXNMHmygPUT/9NkcmMIYXFkAZy1qTaNlUPMtYk=;
        b=VTVVxToitdcBptmTnPuNeiUonv7KzxBHU/QIYoPfF35dEaO5Rk1PRf7jTgC1/EuJce
         KMGQOv1ssPw1PsoddUVJ7oiiERjg4Z29FAPbCwSxmKUVKWKbK0bgjDrfSgaMMSQjkIuj
         EpClgceOiPyCLepq2438Aen4GzwbXS9tUZQD17awyVuQdQ3ZB+XCGvfaglIBzlJDFHV0
         H9bpU7sIYDnOvN3yFjZFy08a0XsNAYww+errDxUUrgbcX96PIm5apUue9JtOWM2GPcBS
         MRS64VkyuewErxoN5r5K5JoWz04ofd5FnlgyokgTWsYiH36tKts4J8zORAvHbIgOLsdx
         P91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781156163; x=1781760963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=soAjsrXNMHmygPUT/9NkcmMIYXFkAZy1qTaNlUPMtYk=;
        b=ByjMCtAe7cGYP9AtVacp1Z2jNfsGigLCVZXfpZP8afi2bAouxlRYuzJUADl7sttc9F
         VC9/diN+jLZf62L6uUzvBG6nwk3L5rCRf5q/tsO/GYKRXf6rB2l+RX0HYo509dC13AZM
         3GnZNgn3yScPehRNsVq/SFdePTS+KEb6zqxOUcAMq/WXC4wCCHFakK6dIHrnt60til2i
         YDsbQxDWPsmRY6ze7TV8v/fEk77ci+P1yokd8xUUTXnZlUAp+u6JyFBGQDecy6IDfsst
         vKnQg6sVVdXZVZMvpJRYQWO3yBIGrZjFcTCRmdVUGrtTPJK1tKmID39KLeCMQWqJm9fU
         w0Og==
X-Gm-Message-State: AOJu0YzaaCm3KgADCVtncb6ui14HjftrzfGRHj5YYKUteIgNYReBtGrC
	CtEwRSut98gxojDtfDyIUJKUUpvwrcKwctXQpJ67ecMCQ9oNJgP7MTrF/7rDr5lLALmL9VZs8Qg
	0AW44zYOq/Rjiy04QVo2bNHOejY9MGR1n/9ww4reB
X-Gm-Gg: Acq92OHKIxQXgYon25ZyxDbGKlXMlH/r0vhrIDQJmpbyWJ5+Mt+xVZ/nPa6+3npbNi/
	t0meAZzTgAhsFe6BXt7mGLIuXHO146G0g0AuTsrENPgILHnGX4JMlcdDBNZH1tE03lZICw8u5yE
	/4/i/3ojlj4WAf0Vlk6i//dCAhQMrDM0oJT0ks0XaJdBH0+G3jzEx3wNBUkuqJuEl3wtG48uQem
	OAROvoRjA0y9hBDtgnHqkRpSaG1MG9Oz73cX1kkt3MOAfZbvUuOF1Gl1MNOzMxjN7tZXUhbF/Lu
	hN5/IY+dEwJNXYSfx5JP+AX5v2VG6TeGZvfpx/G3X72ZJ2fjyGphb5W9q6XWcGK1rWTmGBaUFae
	XJRZq+lYpAvueSwwAxt4iHSAVN3SJNFH9r8DsUyiV3yRbinCm1+82m+/kEVk0QuX77TFcyLBm6g
	==
X-Received: by 2002:a05:7022:98d:b0:136:da48:a3e0 with SMTP id
 a92af1059eb24-138423fe525mr872403c88.28.1781156162284; Wed, 10 Jun 2026
 22:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611035318.1091442-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260611035318.1091442-1-runyu.xiao@seu.edu.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 10 Jun 2026 22:35:50 -0700
X-Gm-Features: AVVi8CcVWozqzu_8obd5Q8i9b5VSbUtZjE7Q1KLm7kkUKNIb1qmSfDAES2VR9q4
Message-ID: <CAAVpQUBAYM=1gXAxRdcj2w_NSJfb8Z__Vr0tQNEm3_FTj0_9XA@mail.gmail.com>
Subject: Re: [PATCH net v3] raw: annotate lockless match fields in raw_v4_match()
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, maze@google.com, 
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297944-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:netdev@vger.kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:maze@google.com,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA55066EA7B

On Wed, Jun 10, 2026 at 8:53=E2=80=AFPM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> raw_v4_match() is a lockless match helper under sk_for_each_rcu(). It
> still reads inet->inet_daddr, inet->inet_rcv_saddr and
> sk->sk_bound_dev_if with plain loads while bind, connect and disconnect
> paths can update the same match fields concurrently.
>
> Annotate only those mutable match fields in raw_v4_match(), and do so
> at the point of use instead of hoisting the bound-device read before
> the earlier short-circuit tests.
>
> Also annotate the corresponding IPv4 writers so the read side matches
> explicit WRITE_ONCE() updates when those same fields are modified.
>
> Fixes: 0daf07e52709 ("raw: convert raw sockets to RCU")
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
> v3:
> - drop the inet_num annotation for raw sockets
> - cover inet_daddr as well
> - avoid hoisting sk_bound_dev_if into a temporary variable
> - annotate the matching IPv4 writer paths
>
> v2:
> - note that inet_num and sk_bound_dev_if already have WRITE_ONCE() writer=
s
> - add WRITE_ONCE() in raw_bind() for inet_rcv_saddr
> - previous version: https://lore.kernel.org/r/20260601073937.1137673-1-ru=
nyu.xiao@seu.edu.cn
>
>  include/net/ip.h    |  3 ++-
>  net/ipv4/datagram.c |  4 ++--
>  net/ipv4/raw.c      | 23 ++++++++++++++++-------
>  net/ipv4/udp.c      |  4 ++--

UDP change should be a separate patch.


>  4 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/ip.h b/include/net/ip.h
> index 7f2fe1a8401b..3902e8b58699 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -679,7 +679,8 @@ static inline void ip_ipgre_mc_map(__be32 naddr, cons=
t unsigned char *broadcast,
>
>  static __inline__ void inet_reset_saddr(struct sock *sk)
>  {
> -       inet_sk(sk)->inet_rcv_saddr =3D inet_sk(sk)->inet_saddr =3D 0;
> +       inet_sk(sk)->inet_saddr =3D 0;
> +       WRITE_ONCE(inet_sk(sk)->inet_rcv_saddr, 0);

Where is inet_reset_saddr() called for raw_sock ?


>  #if IS_ENABLED(CONFIG_IPV6)
>         if (sk->sk_family =3D=3D PF_INET6) {
>                 struct ipv6_pinfo *np =3D inet6_sk(sk);
> diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
> index 1614593b6d72..7d25519a6cdd 100644
> --- a/net/ipv4/datagram.c
> +++ b/net/ipv4/datagram.c
> @@ -63,12 +63,12 @@ int __ip4_datagram_connect(struct sock *sk, struct so=
ckaddr_unsized *uaddr, int
>         }
>
>         /* Update addresses before rehashing */
> -       inet->inet_daddr =3D fl4->daddr;
> +       WRITE_ONCE(inet->inet_daddr, fl4->daddr);
>         inet->inet_dport =3D usin->sin_port;
>         if (!inet->inet_saddr)
>                 inet->inet_saddr =3D fl4->saddr;
>         if (!inet->inet_rcv_saddr) {
> -               inet->inet_rcv_saddr =3D fl4->saddr;
> +               WRITE_ONCE(inet->inet_rcv_saddr, fl4->saddr);
>                 if (sk->sk_prot->rehash)
>                         sk->sk_prot->rehash(sk);
>         }
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index 5aaf9c62c8e1..dfb294b5c794 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -120,13 +120,21 @@ bool raw_v4_match(struct net *net, const struct soc=
k *sk, unsigned short num,
>                   __be32 raddr, __be32 laddr, int dif, int sdif)
>  {
>         const struct inet_sock *inet =3D inet_sk(sk);
> +       __be32 daddr, rcv_saddr;
>
> -       if (net_eq(sock_net(sk), net) && inet->inet_num =3D=3D num  &&
> -           !(inet->inet_daddr && inet->inet_daddr !=3D raddr)    &&
> -           !(inet->inet_rcv_saddr && inet->inet_rcv_saddr !=3D laddr) &&
> -           raw_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
> -               return true;
> -       return false;
> +       if (!net_eq(sock_net(sk), net) || inet->inet_num !=3D num)
> +               return false;
> +
> +       daddr =3D READ_ONCE(inet->inet_daddr);
> +       if (daddr && daddr !=3D raddr)
> +               return false;
> +
> +       rcv_saddr =3D READ_ONCE(inet->inet_rcv_saddr);
> +       if (rcv_saddr && rcv_saddr !=3D laddr)
> +               return false;
> +
> +       return raw_sk_bound_dev_eq(net, READ_ONCE(sk->sk_bound_dev_if),
> +                                  dif, sdif);
>  }
>  EXPORT_SYMBOL_GPL(raw_v4_match);
>
> @@ -724,7 +732,8 @@ static int raw_bind(struct sock *sk, struct sockaddr_=
unsized *uaddr,
>                                          chk_addr_ret))
>                 goto out;
>
> -       inet->inet_rcv_saddr =3D inet->inet_saddr =3D addr->sin_addr.s_ad=
dr;
> +       inet->inet_saddr =3D addr->sin_addr.s_addr;
> +       WRITE_ONCE(inet->inet_rcv_saddr, addr->sin_addr.s_addr);
>         if (chk_addr_ret =3D=3D RTN_MULTICAST || chk_addr_ret =3D=3D RTN_=
BROADCAST)
>                 inet->inet_saddr =3D 0;  /* Use device */
>         sk_dst_reset(sk);
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 0ac2bf4f8759..5d3e07f3ac27 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2156,10 +2156,10 @@ int __udp_disconnect(struct sock *sk, int flags)
>          */
>
>         sk->sk_state =3D TCP_CLOSE;
> -       inet->inet_daddr =3D 0;
> +       WRITE_ONCE(inet->inet_daddr, 0);
>         inet->inet_dport =3D 0;
>         sock_rps_reset_rxhash(sk);
> -       sk->sk_bound_dev_if =3D 0;
> +       WRITE_ONCE(sk->sk_bound_dev_if, 0);
>         if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
>                 inet_reset_saddr(sk);
>                 if (sk->sk_prot->rehash &&
> --
> 2.34.1

