Return-Path: <netdev+bounces-293955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABSKIBc9HmpriAkAu9opvQ
	(envelope-from <netdev+bounces-293955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:16:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D79E562724D
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8210C307513A
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E39343899;
	Tue,  2 Jun 2026 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrZMVbgp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715B7348C44
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366217; cv=pass; b=nhf/LKytrYv923QoS6PbKyu4s1aoOXyJZaLELmKtNyF17h/ard9i0ZZ8WjD9rDldhgp4Z+jl5qE/CZ3DnVSA0SIqoyji1b1PoMYyg/l0lvuRsU9jZ9Fu/snWwVmVcEUyHJUt+sScfUE4BX/lhwCIloIEBbqwAn2ppwA/0xqEpys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366217; c=relaxed/simple;
	bh=LHS2lhZgKMmZxzsPYW2PXD0tEfpF49HGVgg6ty6nidU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmJE2PVnIWKAB3tmnF2QQ8A7G0D63IQ5xiLktpEXHC34r7w6FQpZJXcdVh7wn0WK6+8zgzWu5LOiWHQhiI2dtMxaYhv3CarEvLXsPt1rDll7XAb2qm84ndoQg++bRjsaeWRYYzjxHpUJqHo2FuQmSdHYPbaaKtDD0c2eVSHPIoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrZMVbgp; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45efb698ef2so1281097f8f.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 19:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780366211; cv=none;
        d=google.com; s=arc-20240605;
        b=jxpNQbi4r/3UeGC2aahz2qETrKbonmT4HHJRctlTJ7OQ7eA9EyRKspbdfpjRnB2v5A
         TwZZ+zGVVhxkIX5md4h1v3Kn6rEzfyAoM7CL60+0pLVIQY4pCEt0ZPBTqHKM7bc0+7x5
         9l6qooIePXh1dfpbBm0QFH0HsRl+9uLccKeehE4UoWMu0WAVhQg/7lzjzJJuDb0EHMAK
         hhKljq23nQEle1fQrlJDuJWsF9qr8dgBbBcZdSV8rIBAUdCI4RR0XgqkMww+a3oeKlDi
         FhQH6Y8j8pbiZfe6uHOuH2nmsu6WA9TPYANYc1gcA4OSXr3Qjj505Uv3/36nQK4bUlg+
         ws/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iTbhl9+TdhzGMasdKn19jki+NsU7h/pgqeVahMbDzwE=;
        fh=pY3+gfPV0RqSRoeZEhf0wafiZkkoMrdeVrwQJP4X05M=;
        b=eA1y6Vxm1zk6g5iPBi+byIDIYoo6fD62xlnR3DxNVtxc0G5i8iT59s/edotcPVjzJd
         u6Y0CgKRgjdBoHc8u1Bkp6/QzOOeOjuNFP/TNLvS/PmvXQGFNvRMWGaECwxwJOfiuba2
         2Hu1jbroO/1NKLm8zQKOn1ARyVEiBfYDlUqF2Nfu8ftdnjLePQ8hc4wYH/wYw9ibDJ1v
         WNTmmPSIToO07ZDDhf6sR1ipdd3e8jK/OMVxf6ehMxeXxVsdgZUObfLEiAOd57zScAlA
         OHMxVnG41fVu7MWf2kakhsIt2+TMRntQ5lDEHUufz4n9e0saE0DRiia0FxR5PR4AtShk
         b43g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780366211; x=1780971011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTbhl9+TdhzGMasdKn19jki+NsU7h/pgqeVahMbDzwE=;
        b=SrZMVbgpw1M5vU+9LFvEOoMCKI4tPAMadPvqSSL5WHp/Bx2JA943ZyqY83NiH09jGZ
         UiNu+wzofGY2+4zrycSUgO2WlzPUB2Lmnvz0pj8YdfaukOIG0srKaQY57C26/Y5NVAre
         kejImo9RAS4Npx7psbFKp82fVd2de2tXrdpfRg205fHedqssdbtAQfm+n9pABYo1sGq2
         QuGw4XiTOGl5Gjm3Em63PnukQRcda2GQO+NV7lMNVZ6c1R8UFNbfdW1h810iVCAem+WM
         LkG1d12P2UJjqC1A5B6/9uZqP1FrG9+Cqjmwh8w6JMIKmPIZhRpjk72g9e/0iBSJjMi+
         vN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780366211; x=1780971011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTbhl9+TdhzGMasdKn19jki+NsU7h/pgqeVahMbDzwE=;
        b=FYowmSDgg5EQqNV8MDyHtHgEsL/7SXZ3TK14HPQSYyRVcb6lOIJgzkY/EfxftoFvrN
         HHQweZ/yN3xYvUZ4eKtC3oKT5Kfji8L8WU22Q9kJyesSDq+yzcdYRj4GPIMuxZCB7dvx
         wIdlJOjzKJ0ecYPog2vkobaLuQjjx6Cd44tEl1IUExLQzFwS+JDLvTYoHngLLnwz473E
         YA8jSrBsI+eYodbx1yHo0azbicBRgP+Gz36JFbYjNced4wxE9iE7BdXVX/TGmiIBIxG3
         OUfcMNF2z+0120MRCHKEEnNFAfFc5oRaurTlYsRrND3LjCymIh7hW9QykJn+1922htEm
         qsXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cPxpAlatKj9h4TA+n90GSrZ8lSCI+HCHPgjAMcc/6UObeSLKKdeuWloDNCr9vVAWiH6cHLPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFy/mrGGSEpkTZEMH8/emSJt2b9M36tDdPvWgvF7JyL2hEe+O2
	bWRMcNQpiXteOAuW0bBGRMl1cW6AZVvybJ6EGJb1GjuQj4tAs5s/ZMJDGmS4UTSStxPijS0wmPQ
	G2XBsyOHhRvANvYmpT4Dj4njqHkdnXZQ=
X-Gm-Gg: Acq92OGtOwKCJCxMO9YJ2gpo0tbziDeQkuxaVGTxHgO8FfHlCW9hSPw4bRMLOcM5Cim
	MyK+mEILK9tDDKFA+tzfinjWSEj8mtqDFS2Nwzy14W12gFeO5rOYFS75/92s3Yc6xYYZsveYeN+
	WprvUZUP3CPLD+TxyiiE5jef8UvwqE1fYdGJD6CIxJY4Qh169B6DLyz5iGFc1mEhZn7GB2Mrqec
	ABYQugINfYLhgI21cM63DmIZZ8g+8Dw1fXOzAHIiZBjeZFA4FI740iW/U4ojll3vrbzpOGCTOiR
	dxA/wn9FEv6Ae9+RJiQi3N1WurWUmmvVHijKDpIjO8khiOMs0ej8ECessNc=
X-Received: by 2002:adf:ea87:0:b0:45e:ec27:b4c2 with SMTP id
 ffacd0b85a97d-45ef6b9300fmr16473165f8f.36.1780366210708; Mon, 01 Jun 2026
 19:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601034148.1272080-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260601034148.1272080-1-maoyixie.tju@gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 2 Jun 2026 10:09:34 +0800
X-Gm-Features: AVHnY4J9HcySFrlIHPpvZnAh5JRZtt7vCxk9UsX_ASk4WS58ydIafXR_8sRpNFU
Message-ID: <CABAhCOQ7Sd2G4ZVwNUK7i6cF7v=CwhcYosvYAgopb=32aNimZQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: require CAP_NET_ADMIN in the device netns for
 tunnel changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293955-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,google.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawleon@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ip6_tnl.net:url]
X-Rspamd-Queue-Id: D79E562724D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 11:41=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> A tunnel changelink mutates the tunnel hash of the device's creation
> netns. ip_tunnel_changelink(), ip6_tnl_changelink(), vti6_changelink(),
> ip6gre_changelink(), ip6erspan_changelink() and xfrmi_changelink() all
> look up and update through t->net.
>
> The rtnl path into changelink only checks CAP_NET_ADMIN against
> tgt_net. After IFLA_NET_NS_FD migration the creation netns differs from
> the caller's netns. A caller with caps only in its current netns can
> then rewrite an entry in the creation netns hash. They pick the
> endpoint addresses. Commit 8b484efd5cb4 ("ip6: vti: Use ip6_tnl.net in
> vti6_siocdevprivate().") added the same check on the ioctl path. This
> adds it on the RTM_NEWLINK path.
>
> Check ns_capable(t->net->user_ns, CAP_NET_ADMIN) in each changelink
> before the lookup and update. The newlink path has long checked the
> capability in the link netns. The changelink path never did.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
> Fixes: 5311a69aaca3 ("net, ip6_tunnel: fix namespaces move")
> Fixes: 690afc165bb3 ("net: ip6_gre: fix moving ip6gre between namespaces"=
)
> Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
> Fixes: 11b326fb0a37 ("ip6: vti: Use ip6_tnl.net in vti6_changelink().")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
> v2: Reworked per Kuniyuki Iwashima's review. v1 gated the check on
>     dev->rtnl_link_ops->get_link_net in __rtnl_newlink(). That gate is
>     too broad. For peer types like netkit and veth get_link_net returns
>     the peer netns, which changelink does not mutate, so the core check
>     would wrongly require CAP_NET_ADMIN there. Move the check into the
>     changelink path of the tunnel types that mutate t->net, against
>     t->net->user_ns. This mirrors the ioctl side in 8b484efd5cb4.
>
> v1: https://lore.kernel.org/netdev/20260527070824.2677331-1-maoyixie.tju@=
gmail.com/
>
>  net/ipv4/ip_tunnel.c           | 3 +++
>  net/ipv6/ip6_gre.c             | 6 ++++++
>  net/ipv6/ip6_tunnel.c          | 3 +++
>  net/ipv6/ip6_vti.c             | 3 +++
>  net/xfrm/xfrm_interface_core.c | 3 +++
>  5 files changed, 18 insertions(+)
>
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 50d0f5fe4e4c..51d8787318f3 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -1251,6 +1251,9 @@ int ip_tunnel_changelink(struct net_device *dev, st=
ruct nlattr *tb[],
>         struct net *net =3D tunnel->net;
>         struct ip_tunnel_net *itn =3D net_generic(net, tunnel->ip_tnl_net=
_id);
>
> +       if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +               return -EPERM;
> +

Should modifying params that don't affect tunnel lookup (e.g. GRE_CSUM
and GRE_SEQ) require CAP_NET_ADMIN in link netns?

>         if (dev =3D=3D itn->fb_tunnel_dev)
>                 return -EINVAL;
>
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index 365b4059eb20..0de4994bc92f 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -2047,6 +2047,9 @@ static int ip6gre_changelink(struct net_device *dev=
, struct nlattr *tb[],
>         struct ip6gre_net *ign =3D net_generic(t->net, ip6gre_net_id);
>         struct __ip6_tnl_parm p;
>
> +       if (!ns_capable(t->net->user_ns, CAP_NET_ADMIN))
> +               return -EPERM;
> +
>         t =3D ip6gre_changelink_common(dev, tb, data, &p, extack);
>         if (IS_ERR(t))
>                 return PTR_ERR(t);
> @@ -2266,6 +2269,9 @@ static int ip6erspan_changelink(struct net_device *=
dev, struct nlattr *tb[],
>         struct __ip6_tnl_parm p;
>         struct ip6gre_net *ign;
>
> +       if (!ns_capable(t->net->user_ns, CAP_NET_ADMIN))
> +               return -EPERM;
> +
>         ign =3D net_generic(t->net, ip6gre_net_id);
>         t =3D ip6gre_changelink_common(dev, tb, data, &p, extack);
>         if (IS_ERR(t))
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 9d1037ac082f..2834004c7011 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -2102,6 +2102,9 @@ static int ip6_tnl_changelink(struct net_device *de=
v, struct nlattr *tb[],
>         struct ip6_tnl_net *ip6n =3D net_generic(net, ip6_tnl_net_id);
>         struct ip_tunnel_encap ipencap;
>
> +       if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +               return -EPERM;
> +
>         if (dev =3D=3D ip6n->fb_tnl_dev) {
>                 if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
>                         /* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, =
so
> diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
> index df793c8bfffb..7b05e0c491db 100644
> --- a/net/ipv6/ip6_vti.c
> +++ b/net/ipv6/ip6_vti.c
> @@ -1044,6 +1044,9 @@ static int vti6_changelink(struct net_device *dev, =
struct nlattr *tb[],
>         struct __ip6_tnl_parm p;
>         struct vti6_net *ip6n;
>
> +       if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +               return -EPERM;
> +
>         ip6n =3D net_generic(net, vti6_net_id);
>         if (dev =3D=3D ip6n->fb_tnl_dev)
>                 return -EINVAL;
> diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_cor=
e.c
> index 330a05286a56..a1029a829406 100644
> --- a/net/xfrm/xfrm_interface_core.c
> +++ b/net/xfrm/xfrm_interface_core.c
> @@ -869,6 +869,9 @@ static int xfrmi_changelink(struct net_device *dev, s=
truct nlattr *tb[],
>         struct net *net =3D xi->net;
>         struct xfrm_if_parms p =3D {};
>
> +       if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +               return -EPERM;
> +
>         xfrmi_netlink_parms(data, &p);
>         if (!p.if_id) {
>                 NL_SET_ERR_MSG(extack, "if_id must be non zero");
> --
> 2.34.1
>

