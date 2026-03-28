Return-Path: <netdev+bounces-272819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YANqFMxFyGk9jQUAu9opvQ
	(envelope-from <netdev+bounces-272819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 22:19:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D88D034FFB8
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 22:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE51B3009882
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 21:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0583536492F;
	Sat, 28 Mar 2026 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYX+ReWe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695E346E64
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774732745; cv=pass; b=KN1FqHJvpoIU4PvGCuePVkI22eClHhnB7zDaWCZsf80S2gxNoci8KAY3+FC+T5Ytc1GgZQck/eEXNMvy9UjHNQJZDpWcFbcbU8SWtJzso3bbpRu+ClEhrz/o2680f1ypZOldGEk3fDzab8SeziotZ2S6hYyrX4FwBGKHh+iQ39c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774732745; c=relaxed/simple;
	bh=RdlmNbYcSO7Vui1HbCfl3BLGYhnu0FcF4Irn9izRU1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYYYEgCY0y+C2mXSTv0WRdfGpQfLX3Q2hIXTA0cD4NYgHZRXlSYY4MMS5URplutDpwInF53qnb5uJAInTLEEcU0MEU8plc3BXX4AJ7q2gBU9VqAIGPxS6e9+SQ1WVEkRmRaw4UyYLtn3Wc5AvHKI/k+1q2LpRXC1CfEqNmhhmBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYX+ReWe; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12732e6a123so143214c88.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 14:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774732743; cv=none;
        d=google.com; s=arc-20240605;
        b=l033bj/6TfIoHKp/Y5Wh3EGbH5eY3Hpe2dZGgYt78wEaICTjAIfoH3tGb8n5Lz0REl
         /hH17HcSZj8PGi6qRnaxB9+qSHFXNICVFgTzWsJHqw7mVQKpz8uQ4sDI5+7WRNlyH0Z9
         yVmqKTr/TLcvROnlZpG4tfLK10DR3k8LsCKwXMSO5aAGV7ZFoe/5oSjQDL2dcExCT7RE
         ecIOp6PKCvtC882V2WQ9Wk6Xa4gSIPMFWOCgidF5djqLFf2f5qi+3Sg2+j9M/3qQuS5k
         lnPVHMCQlpDDN5xe1pzHp94LgEojdvN7zpUj14mJRjDHwvOsdkrwzJd11g0P2fvpMEBD
         Dsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PBiTFJ2Aekxslv0nQzrSV8JBl6uUm9THEIcdA/4Aakk=;
        fh=sLcLFHH8jvYha3R8WrhKldB31Yp6edTt89E3Sdmhdto=;
        b=T9R6zwlwhU84K7pYyhzHW5vPeU/ZOQ5/IMs5LcliGULXaBurWRQ3hE6aI2rqMhfdA5
         3DT27uHujt4vByAcym7WVv1hym8wRK17UoMHOLUiqCTvBvLlddKqKGRUHIUfG9AA6F6C
         bKjxrtdPHNB6Y8d7QuChRQAZxT6QGus+UN67UhabD9BqH4RUXMYIzlR91kfgHm8pCYyJ
         p7JPBZRXZp+tFy6iMTWKPLh7KMIIStwj2LZzoWM3EguqsbHBqn5Lk/hcY7t6vc/nzPWo
         EC3VRdSdJZ8ger6LPjawLCpq2feuzYWOJUBcsHmUspPS51JYcsdxaYtVEnZwNzBI6DlL
         dU5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774732743; x=1775337543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBiTFJ2Aekxslv0nQzrSV8JBl6uUm9THEIcdA/4Aakk=;
        b=iYX+ReWeXe188ACbUGCpLf1UXz7AFVkIvqyAJuiuMc3DXcCgUsDW/t+3m3oddWvcSa
         QpO92Zq4iSZyM/jDa+NTlgOKXqbo7W9adtjaIyRQ4kNnj+/Xfp0P9k4RBdD5aY+LrY1C
         EXbU+lJ383x4D0pCCZhFTJ4Pa3fofttFVlnk9Pwtf3SnEFV8VdQ6WX1c9VV1pmK2+R2C
         c9geZcmqnsmFcWBNNUx548K9nEhy5TDsMWEsC3XUYMvttdM0gyGFDMXOLRkbqAD0zStj
         cdGt5JBCmt9gaxTXNK7Vqk0xnTvoA91dgRGzRn9hdXK1B/fO7raQH9x3LHZ5rU20Srri
         U0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774732743; x=1775337543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PBiTFJ2Aekxslv0nQzrSV8JBl6uUm9THEIcdA/4Aakk=;
        b=LqTRT5V5SWBd4p7ZezQpQfRPoe8laGuw3FHjF4IviYVL8a+X7PRGmpE13No8FvG75t
         EWu3XhxprtuqHBd83/WyeIWyPGjYuANzHLI/wKCOO1l1auJsaSzX2xysgi0cTPvgUHti
         g2VfpPpwRMH5EGZ0he2U/SeVEdkwYWLgrlA2XB/MJ3ZOSedMBkcdCXUNjE4Xw/dCMpkN
         +04/tHoskF5W0ewcIy3v4JGjZFOItH3Fb0un4QNuP7DhF+e7bU0P/ccSj03M+phVC783
         CUJSMq4tdj2Lu86fUWTY4oyhubH+DvoZRx9iHgqYaVMLwxTJvUkIXW+SEBps8QxPvSk5
         +X3w==
X-Gm-Message-State: AOJu0YzRp+zhjNSkEkQVC1E2iblNUpEc4iYJ/692zkf3fpxwBydvm9xR
	F+8ZlbivM9E9YyP2Hd+A5HLIgOTBzWB6c+zmxivB3qY9vNZCzxjgXynQfAoPg0p9159sKibGbYl
	NFs3Fo8/jUVwKTDUAw5GFvIY6T2Br8WRbnxMtIjTbHHZhKjctcSuKSzCC
X-Gm-Gg: ATEYQzzo15w81FLdZij0Rg/vKf+t9Hmjx5LtSGflxum4BzfcGoA05f6VaRT7iH+F0GV
	0d0q3vUcNcFkKSviFXDiw4iqLEF6EJus6ZQIXEi86Jw0y6BWPUsiFi+nvoCj+rC+Aj/2BcJdOfk
	IOg36XpLVZrD4DONLoMUNk2IQaFzr7PU/5Llg5vuPGeo/GRK9ovrJwdhxzJ4AtPCFvaLxvwv26b
	1c5OJiDNBdAaIk4oJn11PHQ8TJPvBwu+HCraUqEbryvEKuAhSIOC8HRwEIJT9zNNM0NEWWhLAnf
	8o6/j1WZPI0c6RREJ9ITqlDQ6tX9y0X2ixc3cL68VcIkuMtsHMe6OKnxpL11Snv18FEOZXGR
X-Received: by 2002:a05:7022:458d:b0:127:9c10:446c with SMTP id
 a92af1059eb24-12ab28a1e13mr4511274c88.7.1774732742875; Sat, 28 Mar 2026
 14:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328135215.901879-1-nickgarlis@gmail.com>
In-Reply-To: <20260328135215.901879-1-nickgarlis@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 28 Mar 2026 14:18:51 -0700
X-Gm-Features: AQROBzBd9ECxhJCHvjjqCxkWZr6ORLlclA1P09xwEdlha2fZzQ55KnJeu6PdD5Q
Message-ID: <CAAVpQUAQVYkbcshJnpPkwMzQzKuNziHRuone=MKV9xAGWW2Y2Q@mail.gmail.com>
Subject: Re: [PATCH net v3] rtnetlink: add missing netlink_ns_capable() check
 for peer netns
To: Nikolaos Gkarlis <nickgarlis@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272819-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D88D034FFB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 6:52=E2=80=AFAM Nikolaos Gkarlis <nickgarlis@gmail.=
com> wrote:
>
> rtnl_newlink() lacks a CAP_NET_ADMIN capability check on the peer
> network namespace when creating paired devices (veth, vxcan,
> netkit). This allows an unprivileged user with a user namespace
> to create interfaces in arbitrary network namespaces, including
> init_net.
>
> Add a netlink_ns_capable() check for CAP_NET_ADMIN in the peer
> namespace before allowing device creation to proceed.
>
> Fixes: 81adee47dfb6 ("net: Support specifying the network namespace upon =
device creation.")
> Signed-off-by: Nikolaos Gkarlis <nickgarlis@gmail.com>
> ---
> v3:
>   - Move netlink_ns_capable() check from rtnl_newlink() into
>     rtnl_get_peer_net(), after the last rtnl_link_get_net_ifla(tb)
>     call. The tbp path is already covered by rtnl_link_get_net_capable()
>     in the caller. (suggested by Kuniyuki)
>   - Pass skb to rtnl_get_peer_net() for the capability check.
>   - Add IS_ERR() check on rtnl_link_get_net_ifla(tb) return value.
> v2:
>   - Removed "Reported-by" tag
>   - Fixed "Fixes" tag with the help of Kuniyuki Iwashima (thanks !)
>
>  net/core/rtnetlink.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index fae8034efbf..4be7fc6e23a 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3894,12 +3894,14 @@ static int rtnl_newlink_create(struct sk_buff *sk=
b, struct ifinfomsg *ifm,
>         goto out;
>  }
>
> -static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
> +static struct net *rtnl_get_peer_net(struct sk_buff *skb,
> +                                    const struct rtnl_link_ops *ops,
>                                      struct nlattr *tbp[],
>                                      struct nlattr *data[],
>                                      struct netlink_ext_ack *extack)
>  {
>         struct nlattr *tb[IFLA_MAX + 1];
> +       struct net *net;
>         int err;
>
>         if (!data || !data[ops->peer_type])
> @@ -3915,7 +3917,19 @@ static struct net *rtnl_get_peer_net(const struct =
rtnl_link_ops *ops,
>                         return ERR_PTR(err);
>         }
>
> -       return rtnl_link_get_net_ifla(tb);
> +       net =3D rtnl_link_get_net_ifla(tb);
> +       if (IS_ERR(net))

nit: use IS_ERR_OR_NULL and remove "if (!net) below


> +               return net;
> +
> +       if (!net)
> +               return NULL;
> +
> +       if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
> +               put_net(net);
> +               return ERR_PTR(-EPERM);
> +       }
> +
> +       return net;
>  }
>
>  static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
> @@ -4054,7 +4068,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct=
 nlmsghdr *nlh,
>                 }
>
>                 if (ops->peer_type) {
> -                       peer_net =3D rtnl_get_peer_net(ops, tb, data, ext=
ack);
> +                       peer_net =3D rtnl_get_peer_net(skb, ops, tb, data=
, extack);
>                         if (IS_ERR(peer_net)) {
>                                 ret =3D PTR_ERR(peer_net);
>                                 goto put_ops;
> --
> 2.34.1
>

