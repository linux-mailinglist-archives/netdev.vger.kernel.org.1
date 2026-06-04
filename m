Return-Path: <netdev+bounces-295060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QTpqAQ8fIWo//QAAu9opvQ
	(envelope-from <netdev+bounces-295060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 08:45:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A25263D4F1
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 08:45:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="bqd1/HBu";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295060-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295060-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C8AD302A1AA
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 06:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332863CCFB5;
	Thu,  4 Jun 2026 06:45:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FEE3542F4
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 06:45:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555521; cv=pass; b=YGRsIZXB63Ss0D/zy/cK1otChA0DJu6MppVvkGWJ8kzltKK8dTksxQ3zEEiWXEM/b/+kalrDisSwZG5RDqVWLWHXUn3LjadGppFaDapRzpHdATgWgTJhYIQ0Tutb/4ymrStqDK7xnjmtinV4QhUAQuvAJVtr84fP/3z3/3nOEXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555521; c=relaxed/simple;
	bh=vanpS1yaGLVvjgX9OJUOk5+5XahkPs+IQUwZLe28efY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfYjj3p2lnJCXAkgNJCPfKvlvHZk4Sj4bvMpGoD7KrUsXs8o7rc4ETml2kCsa4u33QjhH+KplsWSmTuGScSXc2J8Ib2RKo0T/p/YpDhWgQa+TgI/wr7IWriDsLj8RQWN/B8RfBiSoMKpNbgWtfrjnHj2zcYpByAfl5+P0pMefQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqd1/HBu; arc=pass smtp.client-ip=74.125.82.51
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-137f27712fdso25222c88.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 23:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780555515; cv=none;
        d=google.com; s=arc-20240605;
        b=ERazyG0Au3OV46Eg4AtuMCWlCSRjeNmmp23TMaM834DUf6N8nIq6hDZOR85EBDayIO
         3drNpZQxHuK6EmHC2nxVT2WVrFmFdrvUXKw7mmgeHkgcwZme8EMfBbJcuSuCShOClkMI
         a2n/2sxoBhuwRtGOdLHhvCHCN/0ThWN4sn4yE9UNV8X2rf4j/BYe+nqU8WebP5MRH+tV
         LYx5PpnS2jJUCFU0ajxzKa4ZH+zuKVqM9RxtsCLE5HtIW5tSevHr0hR9ciQe5idc2N2g
         sB7w7adz1d4F9DfKF2GEAIGWcgbwSRM+DkRUnwAw+kOsSqu1JwL51VpoKUz5Kgqryi0O
         jCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oqLC1ZyUbsrS8VIC+GHhJNOdtBNsT5LpOiDbY5gQx0o=;
        fh=/93hyZUIM3W5waDYAih9kb54/7/pIZs4lnHYtxJ1qug=;
        b=FkQKKk6JDyvFu5EKuXnQmsFO6QiuBk01wS9vyNtT59kIsvMJJKptj3zG6o4z/b9b56
         naDwZEMn5aflASKFEKQs+8oZYlig2XVTApaDhbrKDGTE94H5tHFsrRe+GiXBlmmhCFU2
         Z/JVFqrR9jo12BVAjBRQZgqlMmPfrpMV0/TvLxzGMzDk0ygZtZhw0icVxDN2+LxReDaX
         ds8Dgi7s59Yr8PTCAbyXPDfj0S5I7TBprkl+zTya40AXFLEEGQMHyPTMtV7h6LduVDyS
         Ax7PQoimSDjSE7CP1GxaJPTNdcDcGrM5HIN08MS4FeFJ83XiG8OedfQZntvGFAQlJaY2
         yIkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780555515; x=1781160315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqLC1ZyUbsrS8VIC+GHhJNOdtBNsT5LpOiDbY5gQx0o=;
        b=bqd1/HBuWsey45XVxRanYJLzPm6smQnqxsyGE6mSNNAmh+65Hzkz3cqZ7CRA1xRyf5
         jD7ilICaTagtZOB9oDOUHqGBpTPUP7/Y4mxKO5bNotL61OY4sRjcZQQQNI7DSHHZ6Ymv
         zYSk2LA9tp+cDaAPjZhlXCZ7J/5fCtIfiBbPY/hV3LloN+NO32Xm5MtL24yFh4GhSiGm
         5W7SRLhl2gya3Jqp8C+kFP+38Fiq2WnE0NcqumoIrMm5cRZlAizWaBJmYRUa1DyfHBeF
         /Ao2ERrmNhgYkg6fKKT0eSzIjrdaXq/gb+VIJ9LjwlXc3WKArcdu7tI+cpRoMz/YLnb1
         kjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780555515; x=1781160315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oqLC1ZyUbsrS8VIC+GHhJNOdtBNsT5LpOiDbY5gQx0o=;
        b=UBiV2ezFgNE7Z4Xc0syeGZXwmTIQcy3BkB9OhM96HRgufiWTrgXPj8LsYIO2gon/NG
         MTFb0IBrOLlfhCnOUJAp6dOV0zuMNWV+RvYG4L0B+VUnpCEU5tik5BvbL5WBITnl4Fz8
         HLKKuEarkFzm9u4wmWZw7SF95X7mFbpsi3KRy8Vr61GsaiQXoeaQvMe0mPKdcmRY6elj
         Ic0XShIm6GSlEc2Nt25KZCES3A5BGc2UD8E+IffYtRF7oCuO/sTioncWI952nAz7ySab
         ddzYxt2buogSxMcPQMoG8MGtRXmOWBgkWDTMDCNhYYdrmMtTPgzTjRZ17kJWI0OpAqMY
         zhoQ==
X-Forwarded-Encrypted: i=1; AFNElJ99FcDwlkHixoM9C3ihPO3DULJ6Aogvn6AyGe+4CU9RCafH8U94RmVb+pYo/0G78JSG9bDS8No=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4rtnGsvw1/d/+NTuW9UNuTw8jGWI76hIBQycDAejyTaQTEsov
	JLWjp4EuMfSMrbH8ZedvvZkgz/0PDbAmEN47PMdj/bCutAKLdS67UVoyJt8rDMWOZuKM4hSFQ7c
	6knYGNU2OYuskFK5RYvFD61N87fZQEEk4FCvBtYoK
X-Gm-Gg: Acq92OFZPPw9/GJ1hu/AR4ye+t2xstJ/EIvCJDqzRiSaPMqD7ONpB9FsFYDRBb8slUj
	6Ye2ciG/BTsCgSFnEooz6xgP8ZeYGKB9bETTOKd78wIDyts3us4taHpfKYf8l7HTw9bQ741Gm/w
	+sj97wqgqSN1vHYxaaSih6c2O8tGYA5Rvwvy36rCcLqHyQjqaXGV2j653MRj1Rb8dhWLhtwLEtm
	Ynm6zxrcOLV/58bPEoziMONOMZBBaci2GK+1RRLytGa+/MQ6VlYC1zs43uhFTPr0YUUsL2U/dpY
	B2DcGUs/3QTxF0MJIENx17z7GHLW8IPjvwXEMDQTk74HRGp8GvxzXerMcCh85KBCJZQgTUt9Dk0
	A4afgyES9kqyrraTabLcvKxBfG6nLy1evYA2cp/KoQCjRxaj8lacKffvhg+xOHDc=
X-Received: by 2002:a05:7022:628b:b0:137:699d:7b95 with SMTP id
 a92af1059eb24-137f6bc8a08mr2650501c88.19.1780555514624; Wed, 03 Jun 2026
 23:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601034148.1272080-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260601034148.1272080-1-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 3 Jun 2026 23:45:03 -0700
X-Gm-Features: AVHnY4IpoIBqL7O4an-vF8_7ewLRrxVC-xjimvQxF5gwh4Yh2qBo4D5NO5WQrCo
Message-ID: <CAAVpQUCUtPJuktP7gxbC02NtDWDFEHegPUPwyQoPGA==+d0Jfw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: require CAP_NET_ADMIN in the device netns for
 tunnel changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295060-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dsahern@kernel.org,m:shaw.leon@gmail.com,m:nickgarlis@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,m:shawleon@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,ip6_tnl.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A25263D4F1

On Sun, May 31, 2026 at 8:41=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com> =
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

Some attributes might have already changed before calling
ip_tunnel_changelink().

e.g. ipgre_netlink_parms() updates t->collect_md, which will
be visible once the device owner calls changelink.

Also, check net_eq(net, dev_net(dev)) to avoid unnecessary
LSM invocations.


> +               return -EPERM;
> +
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

