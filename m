Return-Path: <netdev+bounces-289732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yD80MpsnDWo8twUAu9opvQ
	(envelope-from <netdev+bounces-289732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:16:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0CF5871F7
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A587F3048AFD
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398ED332EA7;
	Wed, 20 May 2026 03:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIeOIMQP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C74F3093C1
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 03:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246652; cv=pass; b=czgae/F2YpOhMMAwlFIie5sJ4xd3F+GSMnBplLqTLCv0qsmu5cHiezRhagduiAa8fhaTW1HZphf5kT99sRjAKPiKZZgCE+PvqWow/X7J7Y8JOiNAsVh/QlDGJuapT3ZxS+3fhUy+wEtkmAfI2ZOJztgwWFEksFnRqEnJeY8hSG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246652; c=relaxed/simple;
	bh=BMHrQTe2c6EDMZGb7kDM0vRuhZGlq/BxcLHexRcE3Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eK+CaQgCPW39M0Z46QV2C+sL1iu97olnqqF4xfgXEJi4zQ4w+7Enj/mnRrQeW5gOPkawDBqvjKANrq2GjSUsoPuqgSdT+k6J5yyiuZlwbhCKMJaH9Cmqdp5kkBr0ZCpWU+0QHuqh2Yulqi4cdetXsUIqpzvpc1GLYmgREdnxQGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIeOIMQP; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so35474005e9.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 20:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779246648; cv=none;
        d=google.com; s=arc-20240605;
        b=L3SIHiFoOGVCRaJtdE11Kp3PBBjWXGN+0BFArCZpYEhwdkP8xn99NrxL6AN4Vusi81
         ED+OD/p/1IzhDkcClpE3GuMjQe0GqQgKVT6YJnxhhB4/iSngFV3l/ML+TNBxaHNFtwlz
         n58Xu23skygSjhJAey8hq22leENZkz2Cfv8mHLfmUkwp0uaj4rPj4bEY7BMFILYmNX9o
         ijiiDrVmhcfb+/uw2tWdiiSKFg06SFkcKB49F9FNAa1hIFdV2CKetD2rSQWxsGDBd5qs
         DCO11Luz3FPoySjqVhclsYZHjaDbd4vmkMe0btew/e2mUAFfxmHoS8G/mshkKPWCCh24
         ZeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QsR6q5JfX7B48DESnaRhiDdBNO0p5N+mlvbf9lr1YNY=;
        fh=ScTYW8zfEzq37mbCtTseBJUg2BAvvnwZM44oCqnJSg0=;
        b=YKo2MklI7nDMoW8I5hw7sYjT+s8GyhUiKsLVB0pyjX4/2crO3eVgY0Pf1e/TB/vUWz
         8ijPpoJqzXpqFtlgy4g28vxAXsKg75mnIe7ASXkT5hvj/rF0g5ZHglOIS7PjXD0xvj64
         L+TIX2hh/Ig8OIVBq5f9uNPSLDlQUl6XmVUHTAFP1rlxAFu9nIayreqrRgz0akhvuAqY
         aQmDgmtPA9Vv+g4b/B75lmvCIQbIOMkvXy0Kmmy6gIgef7abhlcQ26oyH7Rc/UzY8mKi
         YjWY+pHxkmSiHqsqnmlQGORzhPFyu/3WEvwKi1R71JzR5CR+qOujDHlVO4B9uTjmxlQZ
         6aLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779246648; x=1779851448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsR6q5JfX7B48DESnaRhiDdBNO0p5N+mlvbf9lr1YNY=;
        b=sIeOIMQPUIb8QCimCYGH3Gf+pgfLizgI4Ra0uzoKuHNIhdcfdzXtUUSFqVhuUNUdUf
         VhWn6pcwR1ELimwN7wer2QgWVlrNmYKuADHlqYtuUZBloyHqA5V2HQT2275c4C544670
         2MWNdnWxtFXmxC3zq0CZcHUQ2Ng8cgJtEXU6ctB5bGkHWhAGPSSxIXAAUjy5LNyXz6CF
         BXLUkqFXcablD31ebBlWOThyFj9HF+PhdYDkeKI223WDCxUPVbEGcznITVg7RknCmOQm
         LYxbLzBXBwOBhM+2r9cJd5ouR/0unj2hdONSejimFcABkagFKx3eFZv8JhpMuFPgon9j
         DotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779246648; x=1779851448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QsR6q5JfX7B48DESnaRhiDdBNO0p5N+mlvbf9lr1YNY=;
        b=Z9OZ83orJcQ2mfdH5KWtUFlaT7lle9i08+4v1kJoCBCaDs84ZDNTbk0wwlyJ4gVyhc
         Q914S25aQzGElu1wtn5CYVUA9Mv3p3GMi7YS/wfInT9BXyvaoWdHkafhfi8DwrO1X6Kl
         JaAjBmFHrfXZMoJjlNpnsLtABYVQdzl+hboDMEM0RJvW8b/1AhmdrpJOTgvUNZGtqwXp
         M0wyfBqAg2/HjyLV6CVhF4A0tYRlDRBPpYjXAeOmJ5Xp/H9vbUhv8eF+/Alje/0uheD6
         eLfpVPFcsyml9e1HitRbAIrWA+FQIhSet1H4dOSF8vIZgF4rgEeF0I+WYxcQmiaUB5Zz
         0m9w==
X-Forwarded-Encrypted: i=1; AFNElJ8+lL57YXkYLh9FRCMIpuwO/HCMV2WVv+5sRQll2+VhmzwfcDsSYCRkv+hDkgqrza2xYP0L5eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBk2rJn3z/UUSC36PW37PIxk0/ISvlDRhuR2dFSw1Du9zvgrDn
	JWsuLSoaoSF5poy1O/gY/+c5J3/+mymJGhw+7PghnPfZqrGVMLEPqlLQjn30X/HcbDF8SEAyGkU
	hXoCrUrM1MHtueR75LPFSOGWara4i8ag=
X-Gm-Gg: Acq92OG1UMkA6xYAvcUHD4USyz4V77BYvnMDuV7qqi8+mVlSXfYVlYTDEgDNyPEQII/
	N6teevEWQp8qJP5kgKp4J7o+9OKV0G0RBhWzGtw7UHpgC3b7liEDE628BkRW8Po+YuNklbIpTqb
	zhH8YvRzkCxgZrPSOn1NJLrZZFtQPldbKimpw6r8qk8ILv4II5f4UMe72kxcDTbzaFSgdo8R2bt
	Bdqt2HxJ9lNebyncWQs+4NN0iuPvBTlbJMJa+qGdq2GR7IlK4YwwWaN8fraABQhysXJfrzhnS2E
	de85NcpKFoqcvZKUBYGmFVHZo3aoU3LaTUqhxA==
X-Received: by 2002:a05:600c:a00f:b0:48a:5301:bb5c with SMTP id
 5b1f17b1804b1-48fe63263dfmr356252365e9.16.1779246648329; Tue, 19 May 2026
 20:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519123547.2055911-1-maoyixie.tju@gmail.com> <20260519123547.2055911-3-maoyixie.tju@gmail.com>
In-Reply-To: <20260519123547.2055911-3-maoyixie.tju@gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 20 May 2026 11:10:10 +0800
X-Gm-Features: AVHnY4I3AptLgQdP84Anayx_kwHlX9_fdHBoUR4ERtTWNcQUZL0x64t1gnXMsec
Message-ID: <CABAhCOSEP1voA-g16sHK+C+84rcQZvX9CWJs1hNaSk-ygbbD1A@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289732-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawleon@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ip6_tnl.net:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4B0CF5871F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 8:35=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> After "ip6: vti: Use ip6_tnl.net in vti6_changelink()." in the same
> series, vti6_update() unlinks and relinks the tunnel through t->net.
> vti6_siocdevprivate() still uses dev_net(dev) for the collision
> lookup. For a tunnel migrated through IFLA_NET_NS_FD, dev_net(dev)
> is the new namespace, not t->net.
>
> The SIOCCHGTUNNEL path on a migrated tunnel then proceeds as
> follows:
>
>   net =3D dev_net(dev)                    /* migrated netns */
>   t   =3D vti6_locate(net, &p1, false)    /* misses target in t->net */
>   ...
>   t   =3D netdev_priv(dev)
>   vti6_update(t, &p1, false)            /* mutates t->net's hash */
>
> A caller in the migrated netns sets the migrated tunnel's parameters
> to those of a tunnel that lives only in the creation netns. The
> collision check in dev_net(dev) sees nothing. vti6_update() then
> prepends the migrated tunnel at the head of the creation netns
> hash bucket for those parameters. Subsequent lookups in the creation
> netns resolve to the migrated device. xfrm receive delivers packets
> matching those parameters through a device the caller controls.
>
> Reachable from an unprivileged user namespace ("unshare --user
> --map-root-user --net"). Cross tenant scope on container hosts.
>
> Use t->net for the SIOCCHGTUNNEL path on a non fallback device. The
> lookup then matches the namespace vti6_update() operates on.
> SIOCADDTUNNEL and SIOCCHGTUNNEL on the fallback device retain
> dev_net(dev), which equals init_net for the fallback.
>
> Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_link=
_ops")

Again 5e72ce3e3980 doesn't introduce this bug.

> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Cc: stable@vger.kernel.org # v5.15+
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  net/ipv6/ip6_vti.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
> --- a/net/ipv6/ip6_vti.c
> +++ b/net/ipv6/ip6_vti.c
> @@ -834,15 +834,19 @@ vti6_siocdevprivate(struct net_device *dev, struct =
ifreq *ifr, void __user *data
>                 if (p.proto !=3D IPPROTO_IPV6  && p.proto !=3D 0)
>                         break;
>                 vti6_parm_from_user(&p1, &p);
> -               t =3D vti6_locate(net, &p1, cmd =3D=3D SIOCADDTUNNEL);
>                 if (dev !=3D ip6n->fb_tnl_dev && cmd =3D=3D SIOCCHGTUNNEL=
) {
> +                       struct ip6_tnl *self =3D netdev_priv(dev);
> +
> +                       t =3D vti6_locate(self->net, &p1, false);

Also check ns_capable() against self->net?

>                         if (t) {
>                                 if (t->dev !=3D dev) {
>                                         err =3D -EEXIST;
>                                         break;
>                                 }
>                         } else
> -                               t =3D netdev_priv(dev);
> +                               t =3D self;
>
>                         err =3D vti6_update(t, &p1, false);
> +               } else {
> +                       t =3D vti6_locate(net, &p1, cmd =3D=3D SIOCADDTUN=
NEL);
>                 }
>                 if (t) {
> --
> 2.34.1
>

