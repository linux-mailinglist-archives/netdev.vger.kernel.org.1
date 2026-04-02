Return-Path: <netdev+bounces-274645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGtvJQGtzml+pQYAu9opvQ
	(envelope-from <netdev+bounces-274645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:53:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EC338CC6A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8119130115A7
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31F43290D8;
	Thu,  2 Apr 2026 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iX57u8JK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987DD2D5C83
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152368; cv=pass; b=W+XzVpGTi16tCoa86XKiqlYuvCfNm60m355K+We392AR3KGjAtXDal6R8wWsXAWktFLvwSoQAyM1g+kEfKR5R64Wh8KCCQR13Ty8GkA7nsmI+O1Ppg1y4NgPul+VLsYgoGTlNAWDAoSJkSuHKMyxyDVwKQAjkuTHEj7hreo9344=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152368; c=relaxed/simple;
	bh=/73RCmeu9wCv1zWz7WH8/irF6TsraBSZuGy3U8qDGg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itGEU08XJwwokmmSbZsqzE3pV+NvuEIUFLX9nZGsPKHp5bisBSGcFMJBX3CpBjyNOW/uX0CarGLQbSPwtsjePwTdx5iPSXE4DxOA3TkZ49CMmcHdPyETCAPrNCNcs2u1qtjfoINgpFuQ0zvvEeHnLeI/smeJXywxn6DTaP7YkmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iX57u8JK; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12713e56abdso627580c88.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 10:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775152367; cv=none;
        d=google.com; s=arc-20240605;
        b=Okinzbu9Z79JQDkEPKMaAH22qjARsVDnpA5uanhmz+WpJ9Bz/fiZrkuvjsEuGpHex8
         zUMF+J2spNKaxdgF13MT0of8QZkuP/2hylBtAovcXFxjw1MUP1IOYWMbM4myFcJ8jqmx
         8kCyFOZCbm+eIG0AQmQPhRppdJ48SdIdcTXfSDWoI+RziOfkW+4XGJNcy8lvYsOUc4W0
         wQhnr2KohRG7/Ny0RNF3D69wJIphZNTRSK9ObHKMSrVsFdTGWAIxZpN62Uuxo1lZhBrN
         SUlcwa3Wmig5N55VZSqzfPf6Raoq5HSOv96AhtPOrCGwiXP7nNTUSd2MMvAiecKXwjq9
         arfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ODkRns72nxtXy60FZ14PndRlfpFoNYr/5uUrWRxGSz0=;
        fh=KVYWGuCndXoF5paumBE+LhvATNHBmLwQnPFcsxPuniY=;
        b=QY37wKpMK/2yo4Y9T0Khg677lk0pkLJsK6FL5dKVvmfn2sjIWQdXBnYaggTsd767hu
         7DDGi+qHwPvFYA/zzhUJoLISslhEeZZhpSXuWMwh5Nl40FGRQnA348gQzz37yo+aWWOW
         UvRdrVPnMdW0qLwuuzPJZjQTymAq2ybgLe+ReQfwmYG3LdsH7P73XLKrJPw1IJIaOLjR
         UWAGeHKSOF5pWnYIzDO/i+4gufszwvJjfWqIVMEQYwyP2WkzXYl/ZZ2yfCjucbJye3SD
         IZ0FnXtSIJJGwe01Q1UMQEALUZrgxv5BcmWVHs+OUYmQm/sfHRGcy5DfQt8+jrTwopSU
         pNGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775152367; x=1775757167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODkRns72nxtXy60FZ14PndRlfpFoNYr/5uUrWRxGSz0=;
        b=iX57u8JKZ/NpCEQKWh24A2Ld8bCbB1+ajZn7Q3MrvACDkypn88YNawSYMwzgb2GP/a
         WaxEoFGJhBXp9s9KLXwGlb++yr31TjDSk2tp1cyAiX+WGUijM2zTVK5kvIVps1mDJvmC
         fS4iFOiExIru49Oj2hAeVAXNd4OXXa+efplCaZoNcwILYSVpP38uvNX4BLurJSLOA2kM
         VW4dBeSS8d3R7lrP8/l4/UxqGemgx19vl0RM3LsoNwnNcA3vPMq1wh7HZHajZFyz/SCi
         cCgryZ/OwC0TRR2qEMApGWjEgKGMP8pS5BDci3+12R23lr98Zf5FX1ef7Fp4ERAcE8cy
         eWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775152367; x=1775757167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ODkRns72nxtXy60FZ14PndRlfpFoNYr/5uUrWRxGSz0=;
        b=Wegp3w+IOmYzVjroBk71p6On1nEPbAWb+6lbCFcvU5g88EDuQrReBCmQ+oEmkUWp5h
         NMTkNAUaWFKRmg1+K9CivQGfSHMQpuJxDFfgW3tzHbpXB4q+gtVHQzoLhciIV9kh7BA8
         UFqS5ILXEGAFsQv4MPaStPmzjZ2rMI4TIytgzsRZ/nJgcqQx7Ot9KX1up9UJc0jPqDoK
         ZAWoHskFNqbWve0oJd39c2x5fblHEvi59G/SK7KE0YSHz2pPb8eHJA7qwCm8b3vuOVPN
         nfOOMU9DNRqZB/6SsvOy73Guct73kV3myZOPed1hkJ4skc+vy6P44s4Di+CNh/GjLmIq
         Zz7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTrqws1+XrbTN3B6E294heq8m9TmK7TGN7TRnsAIllukDQMy/b3d4dlUqS5WjONDsuvaEphtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg1zt0LYLpJmvJ9lOpGzGmr5wnhAARZukb1v0SBoGmHj0NFo7w
	3VHb6HlOnlAH7/9p84hhuJjIAxbsRuclhvR8HFMmOxMPIjabE7eY60/YxIoF5Q53orWM6CpcnTu
	T8dgjIXaVAlj2BTvit51vLRMSKBYXuIw7jYv2r0wO
X-Gm-Gg: ATEYQzyUUOfnfTXewDqGpYiI/nd56gxMct86pL3zcbX/A1jZCQNhf+88I5Zg2E8DRsy
	ZIxZ4nzaj7P0bUxE7A3b7OzRyijTke/vvfwHfRhviawUTzpucju5ehyZNrDQXbatjLEXXUnFsh5
	orlCNLKQ0swITeljAV4c7DKOG43GpWX6VS+NakOR7jyrj6YAXpEsrjate6mpzj7CGcmFeyT6MB5
	VrUWBgZ1Gfmw4oXGOfPSjfkeKECb5ZHiwgfCC0cT9PobxwhV2PrJDwHzziRY3Zs5Hr1I93ivPXG
	anfuc82rcm3iFeYU2XkHuF7lpWzBFJ4ZZX0O1z+mvsgwz61D1s1+mQsfJqZZZ+13I0+8wQ==
X-Received: by 2002:a05:7022:f68d:b0:12b:ebc9:5f6 with SMTP id
 a92af1059eb24-12bf04a2869mr1272265c88.0.1775152365875; Thu, 02 Apr 2026
 10:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328213338.450601-1-nickgarlis@gmail.com> <20260401194553.6e8a17f8@kernel.org>
 <CA+jwDR=9UgxAW828FF4geu8RukGyi7OLTS0ShVr4S8-36SWamw@mail.gmail.com>
In-Reply-To: <CA+jwDR=9UgxAW828FF4geu8RukGyi7OLTS0ShVr4S8-36SWamw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 2 Apr 2026 10:52:34 -0700
X-Gm-Features: AQROBzAM-R_j6Y-AclU0LcwBoz3v0-7m1x6CgwmxowcITUiwhFVV3JauAXi1OvE
Message-ID: <CAAVpQUDPjpiC_rSx+ry5o0KLfEWPg4VEiN60ihkF9NwrOX_n1Q@mail.gmail.com>
Subject: Re: [PATCH net v4] rtnetlink: add missing netlink_ns_capable() check
 for peer netns
To: Nikolaos Gkarlis <nickgarlis@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274645-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 35EC338CC6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 10:46=E2=80=AFAM Nikolaos Gkarlis <nickgarlis@gmail.=
com> wrote:
>
> On Thu, Apr 2, 2026 at 4:45=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Sat, 28 Mar 2026 22:33:38 +0100 Nikolaos Gkarlis wrote:
> > > -static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops=
,
> > > +static struct net *rtnl_get_peer_net(struct sk_buff *skb,
> > > +                                  const struct rtnl_link_ops *ops,
> > >                                    struct nlattr *tbp[],
> > >                                    struct nlattr *data[],
> > >                                    struct netlink_ext_ack *extack)
> > >  {
> > >       struct nlattr *tb[IFLA_MAX + 1];
> > > +     struct net *net;
> > >       int err;
> > >
> > >       if (!data || !data[ops->peer_type])
> >
> > There's an early return hiding outside of the context here.
> > the patch is technically correct, I think, because if we take this
> > shortcut we end up with the same netns as tgt_net so we'll validate
> > that it's capable later. But it's probably not obvious to a casual
> > reader of this code (or AI agents, sigh)
> >
> > So let's rewrite this along the lines of:
> >
> >         struct nlattr *tb[IFLA_MAX + 1], **attrs;
> >         struct net *net;
> >         int err;
> >
> >         if (!data || !data[ops->peer_type]) {
> >                attrs =3D tbp;
> >         } else {
> >                 err =3D rtnl_nla_parse_ifinfomsg(tb, data[ops->peer_typ=
e], extack);
> >                 if (err < 0)
> >                         return ERR_PTR(err);
> >
> >                 if (ops->validate) {
> >                         err =3D ops->validate(tb, NULL, extack);
> >                         if (err < 0)
> >                                 return ERR_PTR(err);
> >                 }
> >
> >                 attrs =3D tb;
> >         }
> >
> >         net =3D rtnl_link_get_net_ifla(attrs);
> >         if (IS_ERR_OR_NULL(net))
> >                 return net;
> >
> >         if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
> > ...
> >
> > ?
>
> I agree it=E2=80=99s a bit confusing with the early exit. I=E2=80=99ll ap=
ply the suggested
> changes and send a v5.
>
> That said, would it make sense to introduce a separate
> rtnl_nets_add_capable() helper that wraps rtnl_nets_add() instead?

Let's focus on the fix in net.git.

Also, I don't want to hide rtnl_nets_add() in a helper.


>
> Something along these lines:
>
> @@ -334,6 +334,19 @@ static void rtnl_nets_add(struct rtnl_nets
> *rtnl_nets, struct net *net)
>      rtnl_nets->len++;
>  }
>
> +static struct net *rtnl_nets_add_capable(struct sk_buff *skb,
> +                                         struct rtnl_nets *rtnl_nets,
> +                                         struct net *net)
> +{
> +    if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
> +        put_net(net);
> +        return ERR_PTR(-EPERM);
> +    }
> +
> +    rtnl_nets_add(rtnl_nets, net);
> +    return net;
> +}
> +
>  static void rtnl_nets_lock(struct rtnl_nets *rtnl_nets)
>  {
>      int i;
> @@ -4059,18 +4072,29 @@ static int rtnl_newlink(struct sk_buff *skb,
> struct nlmsghdr *nlh,
>          ret =3D PTR_ERR(peer_net);
>          goto put_ops;
>      }
> -    if (peer_net)
> -        rtnl_nets_add(&rtnl_nets, peer_net);
> +    if (peer_net) {
> +        peer_net =3D rtnl_nets_add_capable(skb,
> +                                        &rtnl_nets,
> +                                        peer_net);
> +        if (IS_ERR(peer_net)) {
> +            ret =3D PTR_ERR(peer_net);
> +            goto put_ops;
> +        }
> +    }
>      }
>      }
>
> -    tgt_net =3D rtnl_link_get_net_capable(skb, sock_net(skb->sk), tb,
> CAP_NET_ADMIN);
> +   tgt_net =3D rtnl_link_get_net_by_nlattr(sock_net(skb->sk), tb);
>      if (IS_ERR(tgt_net)) {
>          ret =3D PTR_ERR(tgt_net);
>          goto put_net;
>      }
>
> -    rtnl_nets_add(&rtnl_nets, tgt_net);
> +    tgt_net =3D rtnl_nets_add_capable(skb, &rtnl_nets, tgt_net);
> +    if (IS_ERR(tgt_net)) {
> +        ret =3D PTR_ERR(tgt_net);
> +        goto put_net;
> +    }
>
>      if (tb[IFLA_LINK_NETNSID]) {
>          int id =3D nla_get_s32(tb[IFLA_LINK_NETNSID]);
> @@ -4082,10 +4106,10 @@ static int rtnl_newlink(struct sk_buff *skb,
> struct nlmsghdr *nlh,
>          goto put_net;
>      }
>
> -    rtnl_nets_add(&rtnl_nets, link_net);
> -
> -    if (!netlink_ns_capable(skb, link_net->user_ns, CAP_NET_ADMIN)) {
> -        ret =3D -EPERM;
> +    link_net =3D rtnl_nets_add_capable(skb, &rtnl_nets,
> +                                    link_net);
> +    if (IS_ERR(link_net)) {
> +        ret =3D PTR_ERR(link_net);
>          goto put_net;
>      }
>      }
>
> Note that this changes the order in link_net, checking capabilities
> before creating the object.
>
> Disclaimer: I=E2=80=99m not very familiar with this code, so this may be =
a bad idea.

