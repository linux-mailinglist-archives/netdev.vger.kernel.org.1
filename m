Return-Path: <netdev+bounces-37184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8337B419D
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 17:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5E17E2833A2
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7633171A0;
	Sat, 30 Sep 2023 15:30:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6985A16400
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 15:30:08 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F51E1
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 08:30:06 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso6026a12.0
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696087805; x=1696692605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4U96VtZPrxwgnSov9FsRgxVxqRMJbrvFus7fPt9J8WA=;
        b=OR0cjLfBRyeML6IyO/2OjkaQSH3RoSJO0RGKgM5ZuL8ix6H5Y879JWTMX25giZQ60K
         sR6N53ZDPeHZNyXhoob7g04dqjXhtR68VMZZbKqzNIx5I6+Lg3tTNUdzjMSshjh+XZuJ
         5WshFM4eH3oMLwqm342RLrYctyplyCHCm6js0/QoU5W14ukfqCIj+JPyuSKUnGiAvV8e
         sZy7lNy0F2egQLWEOijdkcmMteQxEIPBx12z9+sQsv3sQAkDG0p6obH4Zhgf56geBtAR
         /cOLspYVfvwj2nMVFSOjdyAyl+Za34jY+mg0bnmMbhpPtDOl2kGzvU0eDOgz5U5xTWsK
         vLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696087805; x=1696692605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4U96VtZPrxwgnSov9FsRgxVxqRMJbrvFus7fPt9J8WA=;
        b=Pt6pdvoZKhrk5oc4ndhxW2RTWbFoJj2XrXnKCppJuLUc/HpG2J6BKKECOxvxgXl3cn
         3JmOYx4JWNbGLotfkQXxVjHyVZct2MPu5Z1rbzi4PHUQcuz+3tU/raBZzmaprsJDOtAs
         JOL08uh0+7juIyYTBrrPItY5R/prUT9dtc3vXiCHQNVQISYsAAVEJ7H0HpuCT/J269Ub
         y9rv1nLKr6pFm3IA7a5ez2vz20guQo/Q/3ubScS8XyTcb5Ty6AcKE/Xp4UkCRWovg0aK
         5HNJTmMsgnYY8jhvKIVrGLa0WY/u5kAM5y4tetOWKry4yMl5J+dxVai0c8ZO8BOGx4Nj
         jUGg==
X-Gm-Message-State: AOJu0YzCmDoDsigMKd7JKnrInanKdE1iHYDy4sEBNcb/jlCvGL5oIsGk
	BsHLxjUrDhUBC9Cb/W2JHHwUD4nwKI9aR9rCJflHeQ==
X-Google-Smtp-Source: AGHT+IG58BXNy4hV4Rg6z9TUxYepSa3oy1nKuAiM+2ci22MPAbf/PcS2tFTd4g72kS/+nSi7h5Kvb5QeXdM51WOkLUE=
X-Received: by 2002:a05:6402:782:b0:538:1d3b:172f with SMTP id
 d2-20020a056402078200b005381d3b172fmr9167edy.3.1696087804779; Sat, 30 Sep
 2023 08:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1@mail.lac-coloc.fr>
In-Reply-To: <4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1@mail.lac-coloc.fr>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 30 Sep 2023 17:29:50 +0200
Message-ID: <CANn89i+q_0e3ztiHD5YE4LBJCSeaETk3VyJ0TPuJYP9By1_1Tg@mail.gmail.com>
Subject: Re: [PATCH net-next] vxlan: add support for flowlabel inherit
To: Alce Lafranque <alce@lafranque.net>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	netdev@vger.kernel.org, vincent@bernat.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 30, 2023 at 5:13=E2=80=AFPM Alce Lafranque <alce@lafranque.net>=
 wrote:
>
> By default, VXLAN encapsulation over IPv6 sets the flow label to 0, with =
an
> option for a fixed value. This commits add the ability to inherit the flo=
w
> label from the inner packet, like for other tunnel implementations.
>
> ```
> $ ./ip/ip addr add 2001:db8::2/64 dev dummy1
> $ ./ip/ip link set up dev dummy1
> $ ./ip/ip link add vxlan1 type vxlan id 100 flowlabel inherit remote 2001=
:db8::1 local 2001:db8::2

Side question : How can "flowlabel inherit" can be turned off later
with an "ip link change ..." ?

It seems vxlan_nl2flag() would always turn it 'on' for NLA_FLAG type :

if (vxlan_policy[attrtype].type =3D=3D NLA_FLAG)
    flags =3D conf->flags | mask;  // always turn on
else if (nla_get_u8(tb[attrtype]))    // dead code for NLA_FLAG
    flags =3D conf->flags | mask;
else
    flags =3D conf->flags & ~mask;

conf->flags =3D flags;


> $ ./ip/ip link set up dev vxlan1
> $ ./ip/ip addr add 2001:db8:1::2/64 dev vxlan1
> $ ./ip/ip link set arp off dev vxlan1
> $ ping -q 2001:db8:1::1 &
> $ tshark -d udp.port=3D=3D8472,vxlan -Vpni dummy1 -c1
> [...]
> Internet Protocol Version 6, Src: 2001:db8::2, Dst: 2001:db8::1
>     0110 .... =3D Version: 6
>     .... 0000 0000 .... .... .... .... .... =3D Traffic Class: 0x00 (DSCP=
: CS0, ECN: Not-ECT)
>         .... 0000 00.. .... .... .... .... .... =3D Differentiated Servic=
es Codepoint: Default (0)
>         .... .... ..00 .... .... .... .... .... =3D Explicit Congestion N=
otification: Not ECN-Capable Transport (0)
>     .... 1011 0001 1010 1111 1011 =3D Flow Label: 0xb1afb
> [...]
> Virtual eXtensible Local Area Network
>     Flags: 0x0800, VXLAN Network ID (VNI)
>     Group Policy ID: 0
>     VXLAN Network Identifier (VNI): 100
> [...]
> Internet Protocol Version 6, Src: 2001:db8:1::2, Dst: 2001:db8:1::1
>     0110 .... =3D Version: 6
>     .... 0000 0000 .... .... .... .... .... =3D Traffic Class: 0x00 (DSCP=
: CS0, ECN: Not-ECT)
>         .... 0000 00.. .... .... .... .... .... =3D Differentiated Servic=
es Codepoint: Default (0)
>         .... .... ..00 .... .... .... .... .... =3D Explicit Congestion N=
otification: Not ECN-Capable Transport (0)
>     .... 1011 0001 1010 1111 1011 =3D Flow Label: 0xb1afb
> ```
>
> Signed-off-by: Alce Lafranque <alce@lafranque.net>
> Co-developed-by: Vincent Bernat <vincent@bernat.ch>
> Signed-off-by: Vincent Bernat <vincent@bernat.ch>
> ---
>  drivers/net/vxlan/vxlan_core.c | 20 ++++++++++++++++++--
>  include/net/ip_tunnels.h       | 11 +++++++++++
>  include/net/vxlan.h            |  2 ++
>  include/uapi/linux/if_link.h   |  1 +
>  4 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_cor=
e.c
> index 5b5597073b00..aa7fbfdd93b1 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -2475,7 +2475,11 @@ void vxlan_xmit_one(struct sk_buff *skb, struct ne=
t_device *dev,
>                 else
>                         udp_sum =3D !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
>  #if IS_ENABLED(CONFIG_IPV6)
> -               label =3D vxlan->cfg.label;
> +               if (flags & VXLAN_F_LABEL_INHERIT) {
> +                       label =3D ip_tunnel_get_flowlabel(old_iph, skb);
> +               } else {
> +                       label =3D vxlan->cfg.label;
> +               }

You can remove the braces.

>  #endif
>         } else {
>                 if (!info) {
> @@ -3286,6 +3290,7 @@ static const struct nla_policy vxlan_policy[IFLA_VX=
LAN_MAX + 1] =3D {
>         [IFLA_VXLAN_DF]         =3D { .type =3D NLA_U8 },
>         [IFLA_VXLAN_VNIFILTER]  =3D { .type =3D NLA_U8 },
>         [IFLA_VXLAN_LOCALBYPASS]        =3D NLA_POLICY_MAX(NLA_U8, 1),
> +       [IFLA_VXLAN_LABEL_INHERIT]      =3D { .type =3D NLA_FLAG },
>  };
>
>  static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
> @@ -4001,7 +4006,15 @@ static int vxlan_nl2conf(struct nlattr *tb[], stru=
ct nlattr *data[],
>
>         if (data[IFLA_VXLAN_LABEL])
>                 conf->label =3D nla_get_be32(data[IFLA_VXLAN_LABEL]) &
> -                            IPV6_FLOWLABEL_MASK;
> +                             IPV6_FLOWLABEL_MASK;
> +
> +       if (data[IFLA_VXLAN_LABEL_INHERIT]) {
> +               err =3D vxlan_nl2flag(conf, data, IFLA_VXLAN_LABEL_INHERI=
T,
> +                                   VXLAN_F_LABEL_INHERIT, changelink, fa=
lse,
> +                                   extack);
> +               if (err)
> +                       return err;
> +       }
>
>         if (data[IFLA_VXLAN_LEARNING]) {
>                 err =3D vxlan_nl2flag(conf, data, IFLA_VXLAN_LEARNING,
> @@ -4315,6 +4328,7 @@ static size_t vxlan_get_size(const struct net_devic=
e *dev)
>                 nla_total_size(sizeof(__u8)) +  /* IFLA_VXLAN_TOS */
>                 nla_total_size(sizeof(__u8)) +  /* IFLA_VXLAN_DF */
>                 nla_total_size(sizeof(__be32)) + /* IFLA_VXLAN_LABEL */
> +               nla_total_size(sizeof(__u8)) +  /* IFLA_VXLAN_LABEL_INHER=
IT */
>                 nla_total_size(sizeof(__u8)) +  /* IFLA_VXLAN_LEARNING */
>                 nla_total_size(sizeof(__u8)) +  /* IFLA_VXLAN_PROXY */
>                 nla_total_size(sizeof(__u8)) +  /* IFLA_VXLAN_RSC */
> @@ -4387,6 +4401,8 @@ static int vxlan_fill_info(struct sk_buff *skb, con=
st struct net_device *dev)
>             nla_put_u8(skb, IFLA_VXLAN_TOS, vxlan->cfg.tos) ||
>             nla_put_u8(skb, IFLA_VXLAN_DF, vxlan->cfg.df) ||
>             nla_put_be32(skb, IFLA_VXLAN_LABEL, vxlan->cfg.label) ||
> +           nla_put_u8(skb, IFLA_VXLAN_LABEL_INHERIT,
> +                      !!(vxlan->cfg.flags & VXLAN_F_LABEL_INHERIT)) ||

This seems in contradiction with NLA_FLAG semantics if the flag can
not be turned off.

Look for nla_put_flag(). User space could get confused.

>             nla_put_u8(skb, IFLA_VXLAN_LEARNING,
>                        !!(vxlan->cfg.flags & VXLAN_F_LEARN)) ||
>             nla_put_u8(skb, IFLA_VXLAN_PROXY,
>

