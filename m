Return-Path: <netdev+bounces-260791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BfPLouznmnZWwQAu9opvQ
	(envelope-from <netdev+bounces-260791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:32:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29093194427
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20BC03023D9B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BEB31B839;
	Wed, 25 Feb 2026 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRdCuvmr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC631B82C
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772008327; cv=pass; b=oxGqM/EnuF4wzPkfG0uTiayxRJkkr7E8Zm4hg2d69vBhGEhWPfRYBVJjtPzJt4SultBuf/a6+KqGcxvpMEqfr/OakOlmqRab5eHj9IUOnajNLJ/XmH38E1TsLQxxDTAEO3b+26PsEm6cFEH2L9C0KordXKJYg1mpjr9Va/cBnO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772008327; c=relaxed/simple;
	bh=H7uGJhCUP5kAxxAKcldXorPp/nEFUtCx4oLDvpDZZNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaqI8IdtnrxR7MYbGm7sg7jZhyouJ7WcIQELvyJIdcS4F1xj6LD/6CFqUskWkqvjxIx4OUSRa+YRJgaIu0dgWVZJ+N9v8Ey/OnrLBCAWVejwcEUlhlIBXFDG9pLqSgc7vmtC+oISovdK7LVAJKrLup76++WVJ/GsRqgswPw1fHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRdCuvmr; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50335b926c2so60033181cf.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 00:32:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772008324; cv=none;
        d=google.com; s=arc-20240605;
        b=GpmwhVtbs1jiW1GxSy5rxJkoYimEhgGVOP0p2Jd/hcuNvxb9R/H2CsosE65MHb3f6a
         KkWYFRHwQbA0su4U8aXly7ehCu+Iol7pbl32sQydlCb+GOZU2vmnMoIUrCEQFKyzYhAt
         lolv+PWqJHw4tOyjeKbiegt/OCZsnL2g7BRHXddSv2wgPBNkrLATstV3nQzr7suDU3b/
         y7DPD+cHxas7PAt5aFTF5KSE2S9ywtdIwCn6FrePRkcOr3FLL6F1KM8xAHyUVbEsKke7
         ZQSHNwqzdDaq9mHW+s3cAbdnaArs/UgtG6dk9z3SMd8OYhBiXnobaF+jaP086keZOIm/
         HBfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D7siYQD1xuhDtkoxAw0gYhYQmKcVAnP64qM/iLy57RI=;
        fh=U1zNGik+94VT/q5Q1RzenxqZrv+zlFiVGa85lKxa1VE=;
        b=Xm705QAyYxFeficPd9cfw1zgdTnQV4ATxWcRta4B9zRWq6+HPy1hc++co76j+2Xtfd
         fPBwk6fWTExc+WGsT5Lyhd/+1V5xGx0l2hyr9hKsERVppJ4CYb8r/GrBTAj0gMGOU/Y5
         lWOl39tmmyi0V+RT/a5im+29gjIUuoBaJRl9AepxbSVdqRC70SZ8rNwzqjMLZC6XNCeL
         mBIFwUY+3vjxqYb+NYAJPva3HQJLB3aRfu7YKn3eSN4RHZ5KCHhf7Og2ncvg5NmQisI/
         wCztOTNM4H23n+dtF0kZhSh0tXWuwTfuuHO+jr4GD2LSiQ6BcyZBzJJ+Z1qljNJ2osVd
         GYNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772008324; x=1772613124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7siYQD1xuhDtkoxAw0gYhYQmKcVAnP64qM/iLy57RI=;
        b=SRdCuvmrEl9DIJZDZMHtNq42EJgXfeU0dqOYgy+GDevT2AbOlZn0u3n42kK8f5EgEH
         +8KOm6A7umVJRH4LEdfEh987Ngggq+IhdYJQUkPPNa0mUpSJ/wAZDwD3O/oWp5qfkZEw
         iSRzIlVWGGm7L55tOeZPe3U38J9PVMMHTuIeOFm61kxMCUAISGWy9Tv2gZqwlV8Xz9Z2
         YtPV+416FFz5JxoCrvExqEdWGLQ6/pDFKEZdel6nB1tCjuLjy7qdzBLV+2IRhh5xcxKc
         lHWDmGN8z+tMDE1egbLral70BBTxO2WMr9/TbSk9MhrjM62ItdRX0Bd6Iz8nEvmF773E
         SIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772008324; x=1772613124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D7siYQD1xuhDtkoxAw0gYhYQmKcVAnP64qM/iLy57RI=;
        b=opsBkLkc3ebDVislD0ase9cu8i7hICbdvtimliA4tOrWPyg94nTEP5Xw1ogN2yTgy1
         twaVgdpd8S1mHHnJqTnPGUqRLQJ1pMM8iCnfX57Paz0W5pMO7db8rJPbi4YohXjlOd4m
         fUDmYx1YafB+y+ZYFTLk81/KqQYH7j10SkFLRt9RnlqINR1nZDnFr8zfomg7fvy0IPZy
         hVE5USV36MllYHw5TL1UpOXhqKmqevIyUmhh209Iko8jlcH3uDWwrnyDoETr+La0Jya8
         lle1uGGopZLkVCGBUoAHTq6KF/KsuKrkkM5rd+hMV/mNjq84gvkVen2csi3WGStaNpR2
         36pw==
X-Gm-Message-State: AOJu0YykoXb8v+bGEhSRfMA2YU0v09C7cz9ZqhYv+xAr269zspI6zv+l
	6QIssFuJ1sAw6vc4lA41Sr4d9STyRY5ns+4xoo4wvSDzC74DgnePZ1MKapRQrjQh+9Q7QIUeiLH
	jbRK3qKfcKjXjtsgvuEchInmzkiQjdgYitSzIgN25mZ0WMD3ovIUvCoEt6qI=
X-Gm-Gg: ATEYQzyFBxexsSUUVAPHppqdaX48oUyd0Fiej1CtcB2gRWYE6iW8jrQZ6kMw9Q/0h7B
	YLfdap+Jgj/QJ1Zt5yeZQEVslvfZtVzSaSol0mOI52Ej5Hi/7OpW1MkCVXUuAlywcx1kfm08YWk
	FE1Zr4kk6iA50Gn+a062ioSUnuE9x+0dDZN2J6Ketnfpk64PcmXCfJP5Gs6enV+nnvvFCvtK4Ke
	mBDA97+11zA+Q4smRYHc0tIpzoA5zzDGr52XY7oEsqziFEtBmO9paBzCsVVmCO4tZoYKjnHQzJt
	brk+veoIelgESGrYg7TJYbsVdTLdAGhiSqUO7cPf74MPqo+C0Jds
X-Received: by 2002:ac8:5a50:0:b0:4f4:de66:5901 with SMTP id
 d75a77b69052e-5070bba49demr211968151cf.5.1772008323553; Wed, 25 Feb 2026
 00:32:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225074633.149590-1-leon.huangfu@shopee.com>
In-Reply-To: <20260225074633.149590-1-leon.huangfu@shopee.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Feb 2026 09:31:53 +0100
X-Gm-Features: AaiRm507EGOddch-kDNSzMHFchJtTr1oj0fZFTjVzjHQ2BHh-bU1RsoVageww8g
Message-ID: <CANn89i+RZtN0wcyBUxKf83pkcbH4=nN_Cpc62tNwwS8T-LQR2A@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: Add net.ipv4.tcp_purge_receive_queue sysctl
To: Leon Hwang <leon.huangfu@shopee.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, kerneljasonxing@gmail.com, lance.yang@linux.dev, 
	jiayuan.chen@linux.dev, Leon Hwang <leon.hwang@linux.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260791-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,google.com,nvidia.com,gmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,shopee.com:email]
X-Rspamd-Queue-Id: 29093194427
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 8:46=E2=80=AFAM Leon Hwang <leon.huangfu@shopee.com=
> wrote:
>
> Introduce a new sysctl knob, net.ipv4.tcp_purge_receive_queue, to
> address a memory leak scenario related to TCP sockets.

We use the term "memory leak" for a persistent loss of memory (until reboot=
)

Lets not abuse it and confuse various AI/human agents which will
declare emergency situations
caused by an inexistent fatal error.

>
> Issue:
> When a TCP socket in the CLOSE_WAIT state receives a RST packet, the
> current implementation does not clear the socket's receive queue. This
> causes SKBs in the queue to remain allocated until the socket is
> explicitly closed by the application. As a consequence:
>
> 1. The page pool pages held by these SKBs are not released.

This situation also applies for normal TCP_ESTABLISHED sockets, when
applications
do not drain the receive queue.

As long the application has not called close(), kernel should not
assume the application
will _not_ read the data that was received.


> 2. The associated page pool cannot be freed.
>
> RFC 9293 Section 3.10.7.4 specifies that when a RST is received in
> CLOSE_WAIT state, "all segment queues should be flushed." However, the
> current implementation does not flush the receive queue.

Some buggy stacks send RST anyway after FIN. I think that forcingly
purging good data
received before the RST would add many surprises.

>
> Solution:
> Add a per-namespace sysctl (net.ipv4.tcp_purge_receive_queue) that,
> when enabled, causes the kernel to purge the receive queue when a RST
> packet is received in CLOSE_WAIT state. This allows immediate release
> of SKBs and their associated memory resources.
>
> The feature is disabled by default to maintain backward compatibility
> with existing behavior.
>
> Signed-off-by: Leon Hwang <leon.huangfu@shopee.com>
> ---
>  Documentation/networking/ip-sysctl.rst         | 18 ++++++++++++++++++
>  .../net_cachelines/netns_ipv4_sysctl.rst       |  1 +
>  include/net/netns/ipv4.h                       |  1 +
>  net/ipv4/sysctl_net_ipv4.c                     |  9 +++++++++
>  net/ipv4/tcp_input.c                           | 16 ++++++++++++++++
>  5 files changed, 45 insertions(+)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index d1eeb5323af0..71a529462baa 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1441,6 +1441,24 @@ tcp_rto_max_ms - INTEGER
>
>         Default: 120,000
>
> +tcp_purge_receive_queue - BOOLEAN
> +       When a socket in the TCP_CLOSE_WAIT state receives a RST packet, =
the
> +       default behavior is to not clear its receive queue.  As a result,
> +       any SKBs in the queue are not freed until the socket is closed.
> +       Consequently, the pages held by these SKBs are not released, whic=
h
> +       can also prevent the associated page pool from being freed.
> +
> +       If enabled, the receive queue is purged upon receiving the RST,
> +       allowing the SKBs and their associated memory to be released
> +       promptly.
> +
> +       Possible values:
> +
> +       - 0 (disabled)
> +       - 1 (enabled)
> +
> +       Default: 0 (disabled)
> +
>  UDP variables
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rs=
t b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> index beaf1880a19b..f2c42e7d84a9 100644
> --- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> +++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> @@ -123,6 +123,7 @@ unsigned_long                   sysctl_tcp_comp_sack_=
delay_ns
>  unsigned_long                   sysctl_tcp_comp_sack_slack_ns           =
                                             __tcp_ack_snd_check
>  int                             sysctl_max_syn_backlog
>  int                             sysctl_tcp_fastopen
> +u8                              sysctl_tcp_purge_receive_queue
>  struct_tcp_congestion_ops       tcp_congestion_control                  =
                                             init_cc
>  struct_tcp_fastopen_context     tcp_fastopen_ctx
>  unsigned_int                    sysctl_tcp_fastopen_blackhole_timeout
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index 8e971c7bf164..ab973f30f502 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -220,6 +220,7 @@ struct netns_ipv4 {
>         u8 sysctl_tcp_nometrics_save;
>         u8 sysctl_tcp_no_ssthresh_metrics_save;
>         u8 sysctl_tcp_workaround_signed_windows;
> +       u8 sysctl_tcp_purge_receive_queue;
>         int sysctl_tcp_challenge_ack_limit;
>         u8 sysctl_tcp_min_tso_segs;
>         u8 sysctl_tcp_reflect_tos;
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 643763bc2142..da30970bb5d5 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -1641,6 +1641,15 @@ static struct ctl_table ipv4_net_table[] =3D {
>                 .extra1         =3D SYSCTL_ONE_THOUSAND,
>                 .extra2         =3D &tcp_rto_max_max,
>         },
> +       {
> +               .procname       =3D "tcp_purge_receive_queue",
> +               .data           =3D &init_net.ipv4.sysctl_tcp_purge_recei=
ve_queue,
> +               .maxlen         =3D sizeof(u8),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dou8vec_minmax,
> +               .extra1         =3D SYSCTL_ZERO,
> +               .extra2         =3D SYSCTL_ONE,
> +       },
>  };
>
>  static __net_init int ipv4_sysctl_init_net(struct net *net)
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 6c3f1d031444..43f32fb5831d 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4895,6 +4895,7 @@ EXPORT_IPV6_MOD(tcp_done_with_error);
>  /* When we get a reset we do this. */
>  void tcp_reset(struct sock *sk, struct sk_buff *skb)
>  {
> +       const struct net *net =3D sock_net(sk);
>         int err;
>
>         trace_tcp_receive_reset(sk);
> @@ -4911,6 +4912,21 @@ void tcp_reset(struct sock *sk, struct sk_buff *sk=
b)
>                 err =3D ECONNREFUSED;
>                 break;
>         case TCP_CLOSE_WAIT:
> +               /* RFC9293 3.10.7.4. Other States
> +                *   Second, check the RST bit:
> +                *     CLOSE-WAIT STATE
> +                *
> +                * If the RST bit is set, then any outstanding RECEIVEs a=
nd
> +                * SEND should receive "reset" responses.  All segment qu=
eues
> +                * should be flushed.  Users should also receive an unsol=
icited
> +                * general "connection reset" signal.  Enter the CLOSED s=
tate,
> +                * delete the TCB, and return.
> +                *
> +                * If net.ipv4.tcp_purge_receive_queue is enabled,
> +                * sk_receive_queue will be flushed too.
> +                */
> +               if (unlikely(net->ipv4.sysctl_tcp_purge_receive_queue))
> +                       skb_queue_purge(&sk->sk_receive_queue);
>                 err =3D EPIPE;
>                 break;
>         case TCP_CLOSE:
> --
> 2.52.0
>

Please prepare a packetdrill test.

