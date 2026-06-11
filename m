Return-Path: <netdev+bounces-297943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BE2ZEgxJKmpVlwMAu9opvQ
	(envelope-from <netdev+bounces-297943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:35:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B338466EA33
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:35:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="kxH//JZX";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297943-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297943-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FA33302BEB3
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 05:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD08305673;
	Thu, 11 Jun 2026 05:25:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C061634DCC8
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 05:25:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781155540; cv=pass; b=PQBOWrnXli6LYPfrjBmjYoFw3MKdpBUIzwhGvO3aYCaCP0sicH12n6kdM+8ojsQ4DVXdUnjR/otFKcT6MDhVxFuNltgf1t6OgI6DFGtB/7SyrgwyyWZHhWeUDJ6dbqIfEvcqHsN/CORoGxexYzIK1jUDYzfmtEB3JfYKXEBjKSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781155540; c=relaxed/simple;
	bh=doUH9A5FJeHhSpLTZvYVSKYZvkUfrZzvjQ6bRoxSw9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGrjoFLcs8noWb/iAQRUn+HUCHRGyMPexbF+v3Vce1LZTM8MpeOzDhqSj3dfsUQl7hOreTiMDMHm4U6ePXG6klOp9CkQegfPCplXuCdFiEM9zaTVQhcZHXpeIgJX0++kjOrWsdaP6wZRs6MFGhAPxxaWkAAaVCCkgrgyt2D7EU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kxH//JZX; arc=pass smtp.client-ip=74.125.82.49
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-137ec563a95so9294957c88.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 22:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781155533; cv=none;
        d=google.com; s=arc-20240605;
        b=lWx3KI9tzU3/R4BShI0WlVAfSaMuaijsRTYiyJB0Yzkgz3sq2gu+w35BVs8PXAwLON
         ixm5vD7C9dVUBuNHMmJ0xl3LNOzmVBMp2uKibm2tvxco8omu5seKlyoGdZsJSsSIH/X4
         TItdff0o29VTElMqapdu2lN/Qlrpzh1IqMxLu/XhWW17fzO2Q0vJfPTpwov//Ak92YCB
         g6jZ5L1lwl8X3AV5g6nqE2q4OoKHMXSvHxbIHQQ5W0+pjHqDok1wT4elSwewJcs94X8a
         wB0D3kPhRaIKb8Qnp1A/JWhuKvUEUEptcVe0dG8pV9Wlkf5tmTVabmXh50GbRP2RbVcQ
         Sh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bsXPQ0eSPRjGxPvV6S9kXwYJJ8AOokCaHBCHCpNZoVI=;
        fh=pq0MkGENV4Jd4E9KhoDAtop/S1pOUlKYaONR8uouUz0=;
        b=KzznGK3OKAMRgfTgBUZqcfwyhu/UunYAWT61qura34U6hw3u0Gf++p9rnO/0agsAsV
         gGtVirrDASjZyJZoXaOqRWyHVycLra7jWf9Z3JJovfdkYsepCUd3POTpAB0/AqwljyMN
         P8qieDj/7/Jin6cY//s217S/VytvVJbbmcmzSsjU7J0HYMVw9oMwfPfl7UkiNrUcfvs6
         YLpLu2BNzhQBOPVEdceMQ0Czgjx6d0EYUvGXd5hCCbXhyEff7fnLQEtdH0bSJeffDM3r
         NNcJp3jzOLJvir6Ewhps5oebdKQBB03qaCkXKzlQ0DtQWZq3Ww9nLQ+VbqVEFNta77nd
         W08w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781155533; x=1781760333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsXPQ0eSPRjGxPvV6S9kXwYJJ8AOokCaHBCHCpNZoVI=;
        b=kxH//JZXSfZITF8DuxQ/71UBi7IfevT5VexptsvFppd552u5EQWCvDV4fhj1txugw8
         MveE71rjZ4ApYdzdGX9hCGjzJy9lmatcV7sg3HEHq6MH7sIwILVDMgkw0XuJxH/6Eov4
         vvG3NkW1OAf0PVMd1HFkUIITBdoLtlMRK4afTXVKccY9Zj1RvfJOnkFl3qxhQrVYAUIE
         pY2kt6rkJ0z/sBRE1k4NuPVjsOmgUPK4uNUeF0b0Sj82fbAuJuyTTvpyG6MS5hvp3mXY
         qh36eeetkBGxvF7PdeNT3ciDdk6mu/xGU9FFPJ0lb7LcaP2gS+/+VnI/kXm4MK8Anber
         ZQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781155533; x=1781760333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bsXPQ0eSPRjGxPvV6S9kXwYJJ8AOokCaHBCHCpNZoVI=;
        b=S/UsjpQ3DPmFuJnCj8zEjmK47NzOxeKaBdUErqsdJpXHuJDKyZmMUmRwS4ZdGga56o
         p6jO6Ciz0Uvws4kv3GV7FbdPStYdrpfPm1h98Lhe1vlshnqN6aQ9xqAu3yhRWI8sRrt6
         OB/vDsRa2OkGN7teZYhVxwsAhl4S+kb5Le3ntX02U6IDs6qXEbfmz4JYqIBDRZ4PDOu6
         QHr+jbIZ8YDVxm2W38MNbec2Dhkh/ruy+gbRtOf6SmcdezZShUyhrT8YCd5O+5ZNg34T
         Ks37QLnJJnNfrgEpfM1phza6eOoz+ZrWmO/3PSc/F79PfJ8SWvcn6qHhyJwtHf+WXxcs
         hhwA==
X-Forwarded-Encrypted: i=1; AFNElJ9DNfMb203B0ayXF/NLL62rwwNt6duiVyh3yY+imHawF9XbtYXoBEL1ICUMmpqwfVwxvLp8z0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXoQK/KcNdWZH73qyWNQFFrfnO0MNfvEWe3WtAY4A8MFT35U/9
	SawgweYJcsOCfx5lPIplwd3xtqP7hyWy3Y8s4h+hrOpSb/FentDqLcakV7/knVCHHXetfDr+4Ly
	/OT8CCAaf7twiPxQOYWZP+6TK07lw/xFt9zIonBhn
X-Gm-Gg: Acq92OHCreUkmhSMCKYMc3ZvSXe8LMjfjAZiTAQDa61pS0uMD2t9T0eNx0cKOTKhrNS
	a5AHdYO0jvXc6Yu6IwiXVZUSpN0hC8echCly8cZfTIq/hddTKXyQdo0IvjYtEa/4VQ1Um68BsWb
	UJ/nXGYjpQ3NN7BlApQlHncTZkoMkk3g85lKtoRWcyPB10j95bepDiLEShu5gXdVrY4OwALFxGa
	cgwWjexHOn7sutFZNFRNCUoH3e42YkEJeC/jO5l6R/r9aKZvAO29ozbP8WMF/etVbob5wxYkb+I
	E7550U3wF1c4BUq7U6/r/16KUxtdkQ95MXlbP73oQVFzu+85IDnZrnCJuRdUhjnGOuwmexFKAdO
	RwdRChQDkLCBPoI1gINBAkjnek+p0rFcNFGjHxa0H7n2YKnV6i19itXMVxIfSrXk=
X-Received: by 2002:a05:7022:fd04:b0:138:243e:ce97 with SMTP id
 a92af1059eb24-1384211ed0amr814067c88.4.1781155532797; Wed, 10 Jun 2026
 22:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609163110.1717419-1-maoyixie.tju@gmail.com> <20260609163110.1717419-2-maoyixie.tju@gmail.com>
In-Reply-To: <20260609163110.1717419-2-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 10 Jun 2026 22:25:21 -0700
X-Gm-Features: AVVi8Cfeeen7lsi6FYsubpu0yMJSyRS-lpOJ_IEl5eZUW7gNg_gtEJK7dUFJJ50
Message-ID: <CAAVpQUAzWFyif353QDyOXCw9BHCFasbWHh+gKKz=EF9Ot_ODBQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/7] net: ip_gre: require CAP_NET_ADMIN in the
 device netns for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,m:shawleon@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-297943-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ip6_tnl.net:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B338466EA33

On Tue, Jun 9, 2026 at 9:31=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com> w=
rote:
>
> A tunnel changelink rewrites the tunnel in its creation netns. After an
> IFLA_NET_NS_FD migration that netns is not the caller's. The rtnl
> changelink path only checks CAP_NET_ADMIN against the caller's netns. A
> caller with caps only in its current netns can then rewrite a tunnel
> that lives in another netns, and it picks the endpoint addresses.

nit: This paragraph is not precise (e.g. even without netns migration
a device can use two netns w/ IFLA_LINK_NETNSID, "current netns"
sounds like current->nsproxy->net_ns but not w/ IFLA_NET_NS_PID
etc, also I don't get the last sentence after "it picks...").

Simply state that changelink() operates on at most two netns,
dev_net() and link_net.

>
> Add net_admin_capable(). It requires CAP_NET_ADMIN in the tunnel's netns
> and is skipped when that netns is the device's current netns, where the
> rtnl path already checked the cap. The other patches in this series use
> the same helper.
>
> Gate ipgre_changelink() and erspan_changelink() with it. The check is at
> the top of the op, before any attribute is parsed, because the parsers
> update live tunnel fields first. ipgre_netlink_parms() sets
> t->collect_md before ip_tunnel_changelink() runs.
>
> Commit 8b484efd5cb4 ("ip6: vti: Use ip6_tnl.net in
> vti6_siocdevprivate().") added the same check on the ioctl path. This
> adds it on RTM_NEWLINK.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  include/net/net_namespace.h | 18 ++++++++++++++++++
>  net/ipv4/ip_gre.c           |  6 ++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index 80de5e98a66d..17fb71a78cb6 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h

net/core/rtnetlink.c is a better fit.
It has rtnl_get_net_ns_capable().


> @@ -358,6 +358,24 @@ static inline bool net_initialized(const struct net =
*net)
>         return READ_ONCE(net->list.next);
>  }
>
> +/**
> + * net_admin_capable - test for CAP_NET_ADMIN over a network namespace
> + * @net: namespace whose state the operation would change
> + * @cur: namespace the operation runs in, e.g. dev_net(dev)
> + *
> + * Returns true when @net is @cur, where CAP_NET_ADMIN was already
> + * checked for the running namespace,
> or when the caller holds
> + * CAP_NET_ADMIN over @net. rtnl changelink paths use this: a device can
> + * be moved so its state lives in a namespace other than the one the
> + * request runs in, and the cap must then be held over that namespace.
> + */
> +static inline bool net_admin_capable(const struct net *net,
> +                                    const struct net *cur)

Rename the helper and change args to

rtnl_dev_link_net_capable(const struct net_device *dev, const struct
net *link_net)

since the netns we care about here is rtnl_newlink_params.link_net
(if specified) and dev_net() is redundant in all callers.

Also remove kdoc, it just reiterates the two conditions below.


> +{
> +       return net_eq(net, cur) ||
> +              ns_capable(net->user_ns, CAP_NET_ADMIN);
> +}
> +
>  static inline void __netns_tracker_alloc(struct net *net,
>                                          netns_tracker *tracker,
>                                          bool refcounted,
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 169e2921a851..040a0ef95184 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1457,6 +1457,9 @@ static int ipgre_changelink(struct net_device *dev,=
 struct nlattr *tb[],
>         __u32 fwmark =3D t->fwmark;
>         int err;
>
> +       if (!net_admin_capable(t->net, dev_net(dev)))
> +               return -EPERM;
> +
>         err =3D ipgre_newlink_encap_setup(dev, data);
>         if (err)
>                 return err;
> @@ -1486,6 +1489,9 @@ static int erspan_changelink(struct net_device *dev=
, struct nlattr *tb[],
>         __u32 fwmark =3D t->fwmark;
>         int err;
>
> +       if (!net_admin_capable(t->net, dev_net(dev)))
> +               return -EPERM;
> +
>         err =3D ipgre_newlink_encap_setup(dev, data);
>         if (err)
>                 return err;
> --
> 2.34.1
>

