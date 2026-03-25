Return-Path: <netdev+bounces-271776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNx+JXllxGmBywQAu9opvQ
	(envelope-from <netdev+bounces-271776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:45:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 941BD32D2DB
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A4113010763
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350282561A2;
	Wed, 25 Mar 2026 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CGPJG3v/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADABA346AED
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774478708; cv=pass; b=MG1b4+xh06kx4bvUhpYzQy8qmOcHM931//WkcO8faRoK2PpW+vb9pQe4aZCGcAeIO81GV7F2Fd/e2ODHwsyHbCL2Pu/Ih/mdCOeY5fdY9mfCJO9OH1drjAbV/bOEFhNHkN4mu9BDjBPkVwpaV5AvGKio2pg04Z64cRWgT3QDj8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774478708; c=relaxed/simple;
	bh=PKaosyeyF0GbRh3/kJjLCihumukTUsjtUooSh4yprVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4UMU2ZlYTrnDHKPWB2LFZPqDAyu7M8uDXKszdr8sJbZPeEoIvryAZehaqk68BUtnLT4rKOtOSNJx/ayc1wNxsGaf3+b35to0QTX/g/CLOsAMHWsaooTiXMhqW1ENvqNFK/uzV2FVoZrj/F+M/hs8SmNon9ofORvLSCFmgbd6lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CGPJG3v/; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899ee491af3so3674506d6.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 15:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774478706; cv=none;
        d=google.com; s=arc-20240605;
        b=XKH3YPGWUkFjhgW5fUVDE4szuIhTlfvgNwE21VT99NkdpAqHhgeTa1Jk4fub6xmCDo
         f78Bvplf4+4UYHPMZoRuvX7qwb9SeIZ5a1DMx8GNFQCCAkHFP87AEhl+XQmgAKN0wb+7
         UtPHhPfc0H1UrM1OXC2gO7AX0Xjc20kGYaBvneGjqr85u1EUl7VMdPmsBvGazgr5lbzk
         wz+YVwyV3dAh3JDmdTtwGl4a0v93OqERvP25TyD+8sYhLTgqab7x6yF9vYe9o0YTKqKa
         SoddZB/vM4zQmp3MXAniAvankXhDn/CpqcTWHKInuMow+Xg8i3W3Y2h4QHgfB7cTTZsG
         0T6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JPpSdfcnpkdzIvEFnEFKQLDIY4hXQlxZhcZM3Rgs6Kg=;
        fh=Awo7B9IWRRCIkOPrDmn76FJwAdujz7VADApkdcRhbOU=;
        b=CAzf0hQrALIWvAjZ3+sdakx/TbiWQ0Gd50IadzNZF6k9DtMxT+qIskDRdIiFiUl0U7
         ScdoWygvjygyb82O5WJ/KbXG3aYTtihHbsqV4ra/ngztitr8hd6ICk3QGQeagAEaiZBu
         Y0TpML3xpsbyPEPTkjkLH79C2Vp+m32aLx9l6by5FEPjKlTbJn0FIjhT6daByh09stAH
         KZFK7WYTDRd14A6pG/bEJ5k1mI8e/rAuYAWjIzxhIcOLv9raz2dyIwJn2etznnW51Re0
         VfiZw+tHYtwBTiFS6NZoygWLjCpCzv3vbFC8L/nrIVQBkFytxH5h3eR0AATed3mYkjrD
         H8xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774478706; x=1775083506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPpSdfcnpkdzIvEFnEFKQLDIY4hXQlxZhcZM3Rgs6Kg=;
        b=CGPJG3v/lOUPOzhxY+pR6MV6WuSKuaEhu8Yt6ZVGsu+PJPdDCXfLBFKwHurL+4rSdw
         ujOo11HEERcfw9SaRDHpnvgh5Rxw/jt9xJ9ybPmQ6lf1JPZIIe9kXyf05RIQeqY1P2IU
         VOre6j0/Pa9pRqxas2qHMgOS+pQqq+hvNRE7wt2HTNXSVql0nMc5Xrs+wmYRVGGF0vyr
         XF7Rs8oTzWNQv8qFraVeDPbnBbP8AL2cq5kAlKycm9BhmTuwPGhZnZ5lDKK84F9yBFNq
         d9lLqGSSPF71eRoQAHXn6dOe/fEwgaIK35qTMFiJggWLR1w87O/0GeQ9zEueeDobsKsj
         bWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774478706; x=1775083506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JPpSdfcnpkdzIvEFnEFKQLDIY4hXQlxZhcZM3Rgs6Kg=;
        b=McZuwsB31XKXe5oRgHpLqAEar0HZbExBOsuMmtn6z9LYgs1BTcwTrUyjcQpCGE5hGH
         QDGxNUbt6uBjnm+yhgZE7QX9HKy2NpcnwMginPY7fdvBk7Jl/joJvs8nAbx0RcAGQMT4
         Prya9KURlgIVKaHNIS0BcYGZYd5nrDfYgO8nRqmONPu5A3LWNSMpF1G/ue4PyfWqY3s8
         +CcVKHzelXjxmJazX9r8UAiHuV77ktsO1Sq5z7NPAu5gsLUrNZZK+hCiMPkwgsbzgWKw
         w8eZ5ec1d6IzXhjXgKVVotKD/1qt6dggeEqTsGVs7hDNgsInrrgb26g7fekaFK/aIVPz
         jDDg==
X-Forwarded-Encrypted: i=1; AJvYcCV+kHfHEp4DuZAsYDmfAHkffMtFtI3dvjJV2WcW7tp7HTgqcFNOcbqmE3vY7Ke+W0O6aFHOrcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyECeBG72cGKZeaG9dypO3HlEeEMIXr8y+jzKfebKDzpsy1cAaY
	H+grHKBNHv9jtiwxvRoDvUaiAgOdeb1MFA0+aYN582/VY/+ICEaD1vB1xvPJPq503vUbr/N6L4k
	3MvQ/nKWUT6U3gPENVAfjtHf+W3RK3PQLCXyBDOQw
X-Gm-Gg: ATEYQzyih7mDRgbjnL/mxM8eRqTMuXSIg8BJWBUAWSFAn4sG6XgOw7rKr3EOiZvl1Cz
	NsdPZKqDR7z/Go2iWi8kk+LcVBp8Pi2JHzT1fohGepJ6buQPmwqfzm5aEs7Q3K52mXgJqbcND4i
	Og/yWivFYut1Jze82F8IwIJSpyB+ctJQBUJQxHY++m09V5aAnzkkN1OJ4aw3llvmRI2EgxdGMPg
	1Ezct5OfMaFPEpCCTl3ZziCI56O//hM0AAxYj/AGLcbKNWiol5/2KjLKnxtSP9Zr6XYDvm/y0Zr
	g2UYwwjkFCNtBd9RZEWZR+B7TZxc8d//5+Ck
X-Received: by 2002:a05:6214:3c9c:b0:89a:171f:63df with SMTP id
 6a1803df08f44-89cc4943babmr81069316d6.10.1774478705104; Wed, 25 Mar 2026
 15:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325171425.3920372-1-edumazet@google.com>
In-Reply-To: <20260325171425.3920372-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Mar 2026 15:44:54 -0700
X-Gm-Features: AaiRm52yYBk8GDLVOJXgxCQpVNiP7Rjyor0zB0JhhqzhfmgWucth1kqafUEJbUc
Message-ID: <CANn89i+h75Gop9ggXqF2gJ327Ec3nrJ9iogseiJnTh5Z6Rzxhg@mail.gmail.com>
Subject: Re: [PATCH net] ip6_tunnel: validate ipv4 header in ip4ip6_err()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Oskar Kjos <oskar.kjos@hotmail.com>, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,hotmail.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-271776-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 941BD32D2DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 10:14=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Oskar Kjos reported the following problem.
>
> ip4ip6_err() calls icmp_send() on a cloned skb whose cb[] was written
> by the IPv6 receive path as struct inet6_skb_parm. icmp_send() passes
> IPCB(skb2) to __ip_options_echo(), which interprets that cb[] region
> as struct inet_skb_parm (IPv4). The layouts differ: inet6_skb_parm.nhoff
> at offset 14 overlaps inet_skb_parm.opt.rr, producing a non-zero rr
> value. __ip_options_echo() then reads optlen from attacker-controlled
> packet data at sptr[rr+1] and copies that many bytes into dopt->__data,
> a fixed 40-byte stack buffer (IP_OPTIONS_DATA_FIXED_SIZE).
>
> To fix this we could simply clear skb2->cb[].
>
> In this patch I chose to validate the inner IPv4 header and
> recompute options if any were included.
>
> Fixes: c4d3efafcc93 ("[IPV6] IP6TUNNEL: Add support to IPv4 over IPv6 tun=
nel.")
> Reported-by: Oskar Kjos <oskar.kjos@hotmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/ip6_tunnel.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 4c29aa94e86eb9439458e4b23426bfda8b3b8922..1901348617f0a4f48358c1c81=
35068f4b861059f 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -561,6 +561,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm=
 *opt,
>            u8 type, u8 code, int offset, __be32 info)
>  {
>         __u32 rel_info =3D ntohl(info);
> +       struct inet_skb_parm parm;
>         const struct iphdr *eiph;
>         struct sk_buff *skb2;
>         int err, rel_msg =3D 0;
> @@ -606,6 +607,8 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm=
 *opt,
>         skb_pull(skb2, offset);
>         skb_reset_network_header(skb2);
>         eiph =3D ip_hdr(skb2);
> +       if (eiph->version !=3D 4 || eiph->ihl < 5)
> +               goto out;
>
>         /* Try to guess incoming interface */
>         rt =3D ip_route_output_ports(dev_net(skb->dev), &fl4, NULL, eiph-=
>saddr,
> @@ -617,6 +620,18 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_par=
m *opt,
>         skb2->dev =3D rt->dst.dev;
>         ip_rt_put(rt);
>
> +       memset(&parm, 0, sizeof(parm));
> +       if (eiph->ihl > 5) {
> +               if (!pskb_network_may_pull(skb2, eiph->ihl * 4))
> +                       goto out;
> +               eiph =3D ip_hdr(skb2);
> +               parm.opt.optlen =3D eiph->ihl * 4 - sizeof(struct iphdr);
> +
> +               err =3D __ip_options_compile(dev_net(skb->dev), &parm.opt=
, skb2, NULL);
> +
> +               if (err)
> +                       goto out;
> +       }
>         /* route "incoming" packet */
>         if (rt->rt_flags & RTCF_LOCAL) {
>                 rt =3D ip_route_output_ports(dev_net(skb->dev), &fl4, NUL=
L,
> @@ -644,7 +659,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm=
 *opt,
>                 skb_dst_update_pmtu_no_confirm(skb2, rel_info);
>         }
>
> -       icmp_send(skb2, rel_type, rel_code, htonl(rel_info));
> +       __icmp_send(skb2, rel_type, rel_code, htonl(rel_info), &parm);
>
>  out:
>         kfree_skb(skb2);
> --
> 2.53.0.1018.g2bb0e51243-goog
>

I will send a V2, because __ip_options_compile() can overwrite the options.

We might need to make sure skb2->head and skb->head are different.

