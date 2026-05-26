Return-Path: <netdev+bounces-291490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJZkJWD5FGo6SAcAu9opvQ
	(envelope-from <netdev+bounces-291490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:37:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8A85CF765
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 447C9302262C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 01:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036E8290DBB;
	Tue, 26 May 2026 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rcXMqPS9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57887242D72
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779759386; cv=pass; b=sdPDonNdz3yXJbSyW2pPiI2CYeUOAuX7GYCPR0cCTnFkuaMSW7fNTxjRRjfEZNZ+JPpR9zWOhonJ2F4skIkt6Qf7pucGii8CrBa0qMw33MyaiSPvZ5EpGDmw/18ZzTx79az3041vm1JraUPAA0L/O2TSDRc/p0/+PHADxCp1ats=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779759386; c=relaxed/simple;
	bh=20oqsb5TgC2urT04UJV0YlTv9L0A/IK5SzgJwJB0tmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImMVtIV4QeU3dK4OIB8fcirFpa1bk316G3BmYDJEhotmA4BLy2QgwNbZhywRKiQb875tB+MWmK7ou7kIFNS/UU8799mGQmDxGnYEhya/8ubrY5JGehok8i/EQ8qY67hScEFp0R94Wl/xky8mA9Cz+qxeTLJxYXOPJGKIXrzcSN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rcXMqPS9; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-13721dfd471so213830c88.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:36:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779759384; cv=none;
        d=google.com; s=arc-20240605;
        b=klJq6sk0MEymnl5p6MSuP9Np+qe2KtgErgEwvJABuk5VI79729WueB+lcvZav0Hdyr
         k21Edw7fanjBNOEfyvKX/B+M2qnRtnDufbRyMjymKOwKSZE7c196JZZbAFIjvj6jNcsu
         O78hpAq9KLWlvJ4dPbqhWLBCnMmyi7cAvepNOK4bM86wu1/9VRgW3lbt6IzkReHBpnxy
         RpRFDPKpdamPFx0koCk8SrMSw6mEE8KKR2s2Myb+hTbiJ10aR7ECZPbZQaLbRB+REtGH
         Phis8nuFZmia6Ujl0VJPyc/cNoI8XLayCeX+a5HNpfdHpK0WLXoch/3ecpvFBFAxuVRJ
         Nrbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TxPIh6nRr+g7wEUwBZPHclgpQXct+YOvcSJHdaVTmo4=;
        fh=HT1ciBbQQ3eCZxYtePdgoFAootfrUB6cixOYL11YnB0=;
        b=CvFFKXHVJ5W3nshnKLIBiGicoA3XBKotLOB0W/4l8Jgep+ldbOt0APKcTRUPqPWJWA
         ycSWsnEFAWBGZQfq61oQYq95ymi0CMba/eB74THTtuccd7z4JoNXEUhF7PWKYGVW2//c
         1xkYStHi8SOHN3vGc4i//t/U9YLoHZXlhTiYZQ6scJGKnDdkOKG8icv8DvpP1hBbszRR
         +/fJeBxVnfOm7MqfsQY+Z3RJVmVr2vNuSh42/Ng68lF4zpmcl9+/lch460rUD8cSzhLx
         UUB3uRU7tLL0ObMYHBpWbz+vlbHxPR3/TCerb1MZl9nf565OtdLIrQgWdW/WItiq8D1G
         MgGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779759384; x=1780364184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxPIh6nRr+g7wEUwBZPHclgpQXct+YOvcSJHdaVTmo4=;
        b=rcXMqPS9Sh6UVeF/F+YH38CNXBMw58LzYO6tvFL14CUT7Zvud21kl3ilC8McVhqjlX
         n8MR88UEYBlQyVm0vfH79tS7GPRSNgjzg/hC55Jp9T1vrb0J/eDjdnSLDU9/6EMnSfzp
         r44hO6FAJ8Xu3a2MS/b2BE3uC9TDUVsn8hPwK7w3Rdg02UKO3X+cLhLVNfW1JCIDw+sq
         oKVxcFqwAn6HfaaYAN2iicrerRPAYAd9+Ns5vs5g86+LmF8aUbZcI1na0VPvowaNPO48
         pXz2OOjc+D0iGioCHRWqWXQzaQbg+N9CNILIsAsU+w9YbQnmGvErVgASMnmFPoryagYa
         h+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779759384; x=1780364184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TxPIh6nRr+g7wEUwBZPHclgpQXct+YOvcSJHdaVTmo4=;
        b=pK+XEMNZW544S/0TYwAw1oBy3Y5M40sSJ8Q677mZ6Njx127tXIHYsuhyxIG7b8h4sb
         RLlhwTB1z7YKfWa9AiUVzU4snE1jpMs88f62uhlTwCTvr+qT2dCxtF3tBOO5kOjj3Coy
         d/A6HbWdSrJ2cBLbOtnrUemsyFgFo4tF4NKC7Q2nk516XZblJrhapso+SEjqCLu0bDd6
         +c8bEfi5puQgSHswKcCHwtRFX+ykAPI/l8rlaRA/Tq2cIFB/bO4Exc8akiUrrZ8uIioK
         cblXNYw9M42uuGMTfHnIzpGZGJy0wo2w/MkiGPDFUDa/al5yj+zWOSjczGKlm7fZZ3Eu
         F2ZA==
X-Forwarded-Encrypted: i=1; AFNElJ+/2QmXVXDVXApQEl9bekM78Lwvs7JPqPxAYr/HcnAaOPm/RXDdZ6g5tJZgmxBF0UWryeOknYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcg1+Vi9cxzktNpye4bWy3owQ443xLQI+c94zRpOJxVVbNBov5
	9EfGoc9dY9hEmitcaQUVaG/HpWK0UXnf3HwiIuLenj95JbI+nAsfsYr3RmGh6BCbZeuTkKEC59H
	Zy+ZC00QdEyqU1d6woRWYSxslTTSTQ7Q/W/6dRXwi
X-Gm-Gg: Acq92OG2RGH836299P8tdNFs2xO4NwP0WaxMpLuPBq2EM/Wx1+nqe3fzz1wGiePtGfj
	WZuOJwUEklFXoxcW8xXmDb3/2GNji5WsLkircwjiHg5+3bHY3Tvog5iQti9kNYzjHSLX6xKiCQ8
	PUwoToETdJe3elddAbm54+MwVmILnphivXIh4AOQ5CqrfTf3uTT7gsfivzBDSGXdeLagaXLZgk9
	Hzn/149h3LZDbc/AW5muNiMy48igIgi7fsGIA9McFhMTUG8SnN3SliPH6OUMkjH5oiU5Gbtbzb0
	j6XhF0IiBMhPg+bCc2ZymZkYslAwKtZ64l+02kwQIP60+WEVrvqpExTfwZbjBS5gldG11aT/E2B
	wQGByBFilUwve81JEQfMxTBoybjJqoG2nCAw1B5T7va1sNPMp3a15w1EeAzugJ+hRKGXcRtBdYA
	==
X-Received: by 2002:a05:7022:6b86:b0:135:4127:64b6 with SMTP id
 a92af1059eb24-1365f6fe492mr5863960c88.3.1779759383473; Mon, 25 May 2026
 18:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525001745.1251640-1-kuniyu@google.com> <20260525001745.1251640-6-kuniyu@google.com>
In-Reply-To: <20260525001745.1251640-6-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 25 May 2026 18:36:12 -0700
X-Gm-Features: AVHnY4L8XVQUoOEAMaJlzHrnW7QeOX5d1ukeS--uSJuepBM4gP7ij-ZrgF5bXO4
Message-ID: <CAAVpQUA+uWxMoVkC6KeZnU1wT+q-EF0PXqpSYYjHA2=Fd30H=g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 5/5] geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291490-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ED8A85CF765
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For Sashiko review

pw-bot:cr

On Sun, May 24, 2026 at 5:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> By default, a GENEVE device bind()s its underlying UDP socket(s) to
> the IPv4 or IPv6 wildcard address because there is no way to specify
> a specific local IP address to bind() to.
>
> This prevents deploying multiple GENEVE devices on a multi-homed host
> where each device should be isolated and bound to a different local IP
> address on the same UDP port.
>
> Let's introduce new options, IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6,
> to allow specifying a local IPv4/IPv6 address for the backend UDP
> socket.
>
> By default, when collect metadata mode (IFLA_GENEVE_COLLECT_METADATA)
> is enabled, both IPv4 and IPv6 sockets are created.  However, if a
> source address is specified via the new attributes, only a single
> socket corresponding to that specific address family is created.
>
> Accordingly, geneve_find_sock() and geneve_find_dev() are updated to
> take the source address into account, ensuring that multiple devices
> and sockets configured with different source addresses can coexist
> without conflict.
>
> In addition, the source address is validated in geneve_xmit_skb()
> and geneve6_xmit_skb(), so the BPF prog must set it in bpf_tunnel_key.
>
> With this change, multiple GENEVE devices can be successfully created
> and bound to their respective local IP addresses:
>
>   (*) "local" is the keyword for IFLA_GENEVE_LOCAL / IFLA_GENEVE_LOCAL6
>
>   # for i in $(seq 1 2);
>   do
>           ip link add geneve4_${i} type geneve local 192.168.0.${i} exter=
nal
>           ip addr add 192.168.0.${i}/24 dev geneve4_${i}
>           ip link set geneve4_${i} up
>
>           ip link add geneve6_${i} type geneve local 2001:9292::${i} exte=
rnal
>           ip addr add 2001:9292::${i}/64 dev geneve6_${i} nodad
>           ip link set geneve6_${i} up
>   done
>
>   # ip -d l | grep geneve
>   9: geneve4_1: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
>       geneve external id 0 local 192.168.0.1 ...
>   10: geneve6_1: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
>       geneve external id 0 local 2001:9292::1 ...
>   11: geneve4_2: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
>       geneve external id 0 local 192.168.0.2 ...
>   12: geneve6_2: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
>       geneve external id 0 local 2001:9292::2 ...
>
>   # ss -ua | grep geneve
>   UNCONN 0      0         192.168.0.2:geneve      0.0.0.0:*
>   UNCONN 0      0         192.168.0.1:geneve      0.0.0.0:*
>   UNCONN 0      0      [2001:9292::2]:geneve            *:*
>   UNCONN 0      0      [2001:9292::1]:geneve            *:*
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> iproute2 patch is here:
> https://lore.kernel.org/netdev/20260523061102.2762452-1-kuniyu@google.com=
/
>
> Changelog:
> v2:
>   * Move addr_type to if-block for CONFIG_IPV6=3Dn
>   * Validate saddr in geneve_xmit_skb() and geneve6_xmit_skb().
> ---
>  drivers/net/geneve.c         | 151 +++++++++++++++++++++++++++++++++--
>  include/uapi/linux/if_link.h |   2 +
>  2 files changed, 146 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 3a62d132a8c4..d68a563b6808 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -775,9 +775,10 @@ static struct sock *geneve_create_sock(struct net *n=
et,
>                 udp_conf.family =3D AF_INET6;
>                 udp_conf.ipv6_v6only =3D 1;
>                 udp_conf.use_udp6_rx_checksums =3D geneve->cfg.use_udp6_r=
x_checksums;
> +               udp_conf.local_ip6 =3D info->key.u.ipv6.src;
>         } else {
>                 udp_conf.family =3D AF_INET;
> -               udp_conf.local_ip.s_addr =3D htonl(INADDR_ANY);
> +               udp_conf.local_ip.s_addr =3D info->key.u.ipv4.src;
>         }
>
>         udp_conf.local_udp_port =3D info->key.tp_dst;
> @@ -1061,6 +1062,16 @@ static struct geneve_sock *geneve_find_sock(struct=
 net *net,
>                 if (gs->gro_hint !=3D gro_hint)
>                         continue;
>
> +               if (family =3D=3D AF_INET &&
> +                   inet_sk(gs->sk)->inet_saddr !=3D info->key.u.ipv4.src=
)
> +                       continue;
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +               if (family =3D=3D AF_INET6 &&
> +                   !ipv6_addr_equal(&gs->sk->sk_v6_rcv_saddr, &info->key=
.u.ipv6.src))
> +                       continue;
> +#endif
> +
>                 return gs;
>         }
>
> @@ -1327,6 +1338,12 @@ static int geneve_xmit_skb(struct sk_buff *skb, st=
ruct net_device *dev,
>         if (IS_ERR(rt))
>                 return PTR_ERR(rt);
>
> +       if (geneve->cfg.info.key.u.ipv4.src &&
> +           saddr !=3D geneve->cfg.info.key.u.ipv4.src) {
> +               dst_release(&rt->dst);
> +               return -EADDRNOTAVAIL;
> +       }
> +

---8<---
Does this drop packets in collect_md mode when the BPF program omits the
source IP?
---8<---

Yes, and it's mentioned in the commit message.


>         err =3D skb_tunnel_check_pmtu(skb, &rt->dst,
>                                     GENEVE_IPV4_HLEN + info->options_len =
+
>                                     geneve_build_gro_hint_opt(geneve, skb=
),
> @@ -1438,6 +1455,12 @@ static int geneve6_xmit_skb(struct sk_buff *skb, s=
truct net_device *dev,
>         if (IS_ERR(dst))
>                 return PTR_ERR(dst);
>
> +       if (!ipv6_addr_any(&geneve->cfg.info.key.u.ipv6.src) &&
> +           !ipv6_addr_equal(&saddr, &geneve->cfg.info.key.u.ipv6.src)) {
> +               dst_release(dst);
> +               return -EADDRNOTAVAIL;
> +       }
> +
>         err =3D skb_tunnel_check_pmtu(skb, dst,
>                                     GENEVE_IPV6_HLEN + info->options_len =
+
>                                     geneve_build_gro_hint_opt(geneve, skb=
),
> @@ -1729,6 +1752,8 @@ static const struct nla_policy geneve_policy[IFLA_G=
ENEVE_MAX + 1] =3D {
>         [IFLA_GENEVE_INNER_PROTO_INHERIT]       =3D { .type =3D NLA_FLAG =
},
>         [IFLA_GENEVE_PORT_RANGE]        =3D NLA_POLICY_EXACT_LEN(sizeof(s=
truct ifla_geneve_port_range)),
>         [IFLA_GENEVE_GRO_HINT]          =3D { .type =3D NLA_FLAG },
> +       [IFLA_GENEVE_LOCAL]             =3D { .type =3D NLA_BE32, .len =
=3D sizeof_field(struct iphdr, daddr) },
> +       [IFLA_GENEVE_LOCAL6]            =3D { .type =3D NLA_BINARY, .len =
=3D sizeof(struct in6_addr) },

---8<---
Should this use NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)) to enforce
strict UAPI validation for the fixed-size binary structure?
---8<---

Indeed, I'll use it.


>  };
>
>  static int geneve_validate(struct nlattr *tb[], struct nlattr *data[],
> @@ -1788,7 +1813,45 @@ static int geneve_validate(struct nlattr *tb[], st=
ruct nlattr *data[],
>         return 0;
>  }
>
> +static bool geneve_saddr_wildcard(const struct ip_tunnel_info *info)
> +{
> +       if (ip_tunnel_info_af(info) =3D=3D AF_INET) {
> +               if (!info->key.u.ipv4.src)
> +                       return true;
> +#if IS_ENABLED(CONFIG_IPV6)
> +       } else {
> +               if (ipv6_addr_any(&info->key.u.ipv6.src))
> +                       return true;
> +#endif
> +       }
> +
> +       return false;
> +}
> +
> +static bool geneve_saddr_conflict(const struct ip_tunnel_info *a,
> +                                 const struct ip_tunnel_info *b)
> +{
> +       if (ip_tunnel_info_af(a) !=3D ip_tunnel_info_af(b))
> +               return false;
> +
> +       if (geneve_saddr_wildcard(a) || geneve_saddr_wildcard(b))
> +               return true;
> +
> +       if (ip_tunnel_info_af(a) =3D=3D AF_INET) {
> +               if (a->key.u.ipv4.src =3D=3D b->key.u.ipv4.src)
> +                       return true;
> +#if IS_ENABLED(CONFIG_IPV6)
> +       } else {
> +               if (ipv6_addr_equal(&a->key.u.ipv6.src, &b->key.u.ipv6.sr=
c))
> +                       return true;
> +#endif
> +       }
> +
> +       return false;
> +}
> +
>  static struct geneve_dev *geneve_find_dev(struct geneve_net *gn,
> +                                         const struct geneve_config *cfg=
,
>                                           const struct ip_tunnel_info *in=
fo,
>                                           bool *tun_on_same_port,
>                                           bool *tun_collect_md)
> @@ -1798,8 +1861,10 @@ static struct geneve_dev *geneve_find_dev(struct g=
eneve_net *gn,
>         *tun_on_same_port =3D false;
>         *tun_collect_md =3D false;
>         list_for_each_entry(geneve, &gn->geneve_list, next) {
> -               if (info->key.tp_dst =3D=3D geneve->cfg.info.key.tp_dst) =
{
> -                       *tun_collect_md =3D geneve->cfg.collect_md;
> +               if (info->key.tp_dst =3D=3D geneve->cfg.info.key.tp_dst &=
&
> +                   (cfg->dualstack || geneve->cfg.dualstack ||
> +                    geneve_saddr_conflict(info, &geneve->cfg.info))) {
> +                       *tun_collect_md |=3D geneve->cfg.collect_md;
>                         *tun_on_same_port =3D true;
>                 }
>                 if (info->key.tun_id =3D=3D geneve->cfg.info.key.tun_id &=
&

---8<---
Is the extack error message returned by geneve_configure() when
tun_on_same_port is true still accurate?
This patch allows multiple externally controlled (collect_md) Geneve device=
s
to exist on the same UDP port, as long as they are bound to different local
IPs. However, if a user makes a configuration mistake causing an IP conflic=
t,
tun_on_same_port will be set to true.
This causes geneve_configure() to return the legacy error message:
if (cfg->collect_md) {
if (tun_on_same_port) {
NL_SET_ERR_MSG(extack,
"There can be only one externally controlled device on a destination port")=
;
Could this message mislead users about the multi-homing capability, hiding
the fact that a local IP overlap is the true cause of the failure?
---8<---

Makes sense.  I'll update the error message.

