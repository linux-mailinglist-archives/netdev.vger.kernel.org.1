Return-Path: <netdev+bounces-52438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48E97FEBD6
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116141C20B53
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396CF38DE1;
	Thu, 30 Nov 2023 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/4qdeZS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7E912A
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:28:39 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b4142so8342a12.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701336517; x=1701941317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYTO4rF01yQdrGq8MtagjqTxRZA+nr1xyV2aU+e/ISE=;
        b=M/4qdeZSLqDpibEMSb8+GLsj1kjRuTktkeDrZHjiy6eXLMYP4KmCPIQL1UrLFDva52
         NixRwSeYSm6PzOXJrNI6/5/69hZQnmDtBQM/zUNBHbvV4GFcBJ8DPbgquGiMAEfDPRFD
         OXZ43xxww5t6uopQNVlhFpzUdgo1eB/sZt3FWlJB76B0VCPbUpaac2vk8BGZgiJq6O2n
         BbqlQMVJcdP8yqPrAsmNR2ywVdDWf0aydVZrJJLS4SZ7OmZ2Y00Lutyw3Squgkbcod9h
         QodF2jlJrw15jtG8L9wvwg9T1ge9aQ7vVIgokqFKwhcAGeJuwwqn0sF1PiNXRrUDuYi8
         Da3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336517; x=1701941317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYTO4rF01yQdrGq8MtagjqTxRZA+nr1xyV2aU+e/ISE=;
        b=CiPIgIeoqeM5KWMcJa/UpcHAXxiClPeD/n4oaHs5awbwB1Vshjrs2sQkZWL9t41tGH
         pen/dbrf/TPN4fniU4b64izyxFsE597JOnQ/GROieGoWIYK/+YG6JV7OolXHGi1OrW23
         uvT/kZP5dJAZWEttjpjrD3nJn7tXe87QKdF0kH5Ty+9ThMzVTkb13nOJyc+V9qdE0Hky
         rouyLUhzr5y43K/ttfBmX2mZwwOf0a6OHZfwG9XQmKLvwdqb2zzKG8GYLIAbYtYGRf7/
         0gLsCEaRGniQowuivVHqkGHc2KU2bmEY1tccw9WCCPKan13GNhLEiUaIvsldzkenJEgm
         n73A==
X-Gm-Message-State: AOJu0YzPQwo2qT6Vi47H0vmUqwG+RSEAEDejagONQ0o7be+3QxCSgvXi
	iBuDAibtkwXYQRQ+Tj5NM5Gac+s0z4gaAwgHDHswuQ==
X-Google-Smtp-Source: AGHT+IFX4Ipcy0AZhXL1gEJRBFpC0gbGnP6UE0YbwfHyvEfHwVdGHwXgy8n+LAyoxHj8fXDVd/7W04cSSqiYUiU1H/Y=
X-Received: by 2002:a50:c081:0:b0:54b:6b3f:4a86 with SMTP id
 k1-20020a50c081000000b0054b6b3f4a86mr115360edf.4.1701336517262; Thu, 30 Nov
 2023 01:28:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a4f5b61c9cd44eada41d8f09d3848806@AcuMS.aculab.com>
In-Reply-To: <a4f5b61c9cd44eada41d8f09d3848806@AcuMS.aculab.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 10:28:23 +0100
Message-ID: <CANn89iJ_uWADjV-JytShdDXYa=nDghEYS9Sy+EBu=tUWgwuS9w@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv4: Use READ/WRITE_ONCE() for IP local_port_range
To: David Laight <David.Laight@aculab.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>, 
	David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"jakub@cloudflare.com" <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 8:26=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> Commit 227b60f5102cd added a seqlock to ensure that the low and high
> port numbers were always updated together.
> This is overkill because the two 16bit port numbers can be held in
> a u32 and read/written in a single instruction.
>
> More recently 91d0b78c5177f added support for finer per-socket limits.
> The user-supplied value is 'high << 16 | low' but they are held
> separately and the socket options protected by the socket lock.
>
> Use a u32 containing 'high << 16 | low' for both the 'net' and 'sk'
> fields and use READ_ONCE()/WRITE_ONCE() to ensure both values are
> always updated together.
>
> Change (the now trival) inet_get_local_port_range() to a static inline
> to optimise the calling code.
> (In particular avoiding returning integers by reference.)
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>  include/net/inet_sock.h         |  5 +----
>  include/net/ip.h                |  7 ++++++-
>  include/net/netns/ipv4.h        |  3 +--
>  net/ipv4/af_inet.c              |  4 +---
>  net/ipv4/inet_connection_sock.c | 29 ++++++++++------------------
>  net/ipv4/ip_sockglue.c          | 34 ++++++++++++++++-----------------
>  net/ipv4/sysctl_net_ipv4.c      | 12 ++++--------
>  7 files changed, 40 insertions(+), 54 deletions(-)
>
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index 74db6d97cae1..ebf71410aa2b 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -234,10 +234,7 @@ struct inet_sock {
>         int                     uc_index;
>         int                     mc_index;
>         __be32                  mc_addr;
> -       struct {
> -               __u16 lo;
> -               __u16 hi;
> -       }                       local_port_range;
> +       u32                     local_port_range;
>
>         struct ip_mc_socklist __rcu     *mc_list;
>         struct inet_cork_full   cork;
> diff --git a/include/net/ip.h b/include/net/ip.h
> index 1fc4c8d69e33..154f9dd75fe6 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -349,7 +349,12 @@ static inline u64 snmp_fold_field64(void __percpu *m=
ib, int offt, size_t syncp_o
>         } \
>  }
>
> -void inet_get_local_port_range(const struct net *net, int *low, int *hig=
h);
> +static inline void inet_get_local_port_range(const struct net *net, int =
*low, int *high)
> +{
> +       u32 range =3D READ_ONCE(net->ipv4.ip_local_ports.range);

Please insert an empty line here.

> +       *low =3D range & 0xffff;
> +       *high =3D range >> 16;
> +}
>  void inet_sk_get_local_port_range(const struct sock *sk, int *low, int *=
high);
>
>  #ifdef CONFIG_SYSCTL
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index 73f43f699199..30ba5359da84 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -19,8 +19,7 @@ struct hlist_head;
>  struct fib_table;
>  struct sock;
>  struct local_ports {
> -       seqlock_t       lock;
> -       int             range[2];
> +       u32             range;  /* high << 16 | low */
>         bool            warned;
>  };
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index fb81de10d332..b8964b40c3c0 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1847,9 +1847,7 @@ static __net_init int inet_init_net(struct net *net=
)
>         /*
>          * Set defaults for local port range
>          */
> -       seqlock_init(&net->ipv4.ip_local_ports.lock);
> -       net->ipv4.ip_local_ports.range[0] =3D  32768;
> -       net->ipv4.ip_local_ports.range[1] =3D  60999;
> +       net->ipv4.ip_local_ports.range =3D  60999 << 16 | 32768;
>
>         seqlock_init(&net->ipv4.ping_group_range.lock);
>         /*
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 394a498c2823..1a45d41f8b39 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -117,34 +117,25 @@ bool inet_rcv_saddr_any(const struct sock *sk)
>         return !sk->sk_rcv_saddr;
>  }
>
> -void inet_get_local_port_range(const struct net *net, int *low, int *hig=
h)
> -{
> -       unsigned int seq;
> -
> -       do {
> -               seq =3D read_seqbegin(&net->ipv4.ip_local_ports.lock);
> -
> -               *low =3D net->ipv4.ip_local_ports.range[0];
> -               *high =3D net->ipv4.ip_local_ports.range[1];
> -       } while (read_seqretry(&net->ipv4.ip_local_ports.lock, seq));
> -}
> -EXPORT_SYMBOL(inet_get_local_port_range);
> -
>  void inet_sk_get_local_port_range(const struct sock *sk, int *low, int *=
high)
>  {
>         const struct inet_sock *inet =3D inet_sk(sk);
>         const struct net *net =3D sock_net(sk);
>         int lo, hi, sk_lo, sk_hi;
> +       u32 sk_range;
>
>         inet_get_local_port_range(net, &lo, &hi);
>
> -       sk_lo =3D inet->local_port_range.lo;
> -       sk_hi =3D inet->local_port_range.hi;
> +       sk_range =3D READ_ONCE(inet->local_port_range);
> +       if (unlikely(sk_range)) {
> +               sk_lo =3D sk_range & 0xffff;
> +               sk_hi =3D sk_range >> 16;
>
> -       if (unlikely(lo <=3D sk_lo && sk_lo <=3D hi))
> -               lo =3D sk_lo;
> -       if (unlikely(lo <=3D sk_hi && sk_hi <=3D hi))
> -               hi =3D sk_hi;
> +               if (unlikely(lo <=3D sk_lo && sk_lo <=3D hi))
> +                       lo =3D sk_lo;
> +               if (unlikely(lo <=3D sk_hi && sk_hi <=3D hi))
> +                       hi =3D sk_hi;
> +       }
>
>         *low =3D lo;
>         *high =3D hi;
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 2efc53526a38..bf940fe249a5 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -1055,6 +1055,20 @@ int do_ip_setsockopt(struct sock *sk, int level, i=
nt optname,
>         case IP_TOS:    /* This sets both TOS and Precedence */
>                 ip_sock_set_tos(sk, val);
>                 return 0;
> +
> +       case IP_LOCAL_PORT_RANGE:
> +       {
> +               const __u16 lo =3D val;
> +               const __u16 hi =3D val >> 16;

I know that we use __u16 and __u32 already, but I think we should
reserve them for exported fields in uapi.

New code  should use u16 and u32, no need for __ prefixes.

> +
> +               if (optlen !=3D sizeof(__u32))
> +                       return -EINVAL;
> +               if (lo !=3D 0 && hi !=3D 0 && lo > hi)
> +                       return -EINVAL;
> +
> +               WRITE_ONCE(inet->local_port_range, val);
> +               return 0;
> +       }
>

