Return-Path: <netdev+bounces-38811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 940097BC938
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 19:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A549281DAE
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467E715ADE;
	Sat,  7 Oct 2023 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="EQl2k5u0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA211845
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 17:09:41 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED1683
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 10:09:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-278fde50024so3300076a91.1
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 10:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1696698579; x=1697303379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYhP/huvrOYDkwx62xaXsMeKrkSGbyLo03n91Qlo6Mw=;
        b=EQl2k5u0/S1taf8g8cz/CXCs/yptGfkf8Luoy5TTcq5IZBMSDxU1uYSWuq0HRJHwuM
         a+9zxPncyVMNQ0Mhtds2DVQ/i2JH9PmhQt0oqVIS8YQRPgkU3lLovFPrlpA/N8MQBfBe
         9NhHsli3wv/sTfSzRARDqoAGG49p95RRIawgX1WcWHQcI+DOqPXL3LyJpWK75yJJqP65
         0Vpl5Bzjkvw4wXMUSUMIdMhSdvMl1kDPvnubm8DPHPRMyNC+1g8MQNbqqIseBWVY8S8P
         6cfKijPyKCn0NIwcinEpXHIxgCWheo6Rr16H/+oV1OuYlZEQ3khBOZ6M8N0/XBViK8hO
         6bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696698579; x=1697303379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYhP/huvrOYDkwx62xaXsMeKrkSGbyLo03n91Qlo6Mw=;
        b=XPKaQ89kV8NeL5d2qojON1XOtnKttOLiwRhUlK7r2oAe+rT9dd6Ac7aRMfCaKYFTzm
         IKllp4sH4uypZ2ZwHCwZBK3x2KipwrO+gBp0r01DWRFchWAA2YCYtJqbS7U0wYQ1UsRG
         x9/QdYyBkTPFC3zf4ScpVHLMQlMs8LLau7MYX36SOmfxYRkfCbcgwB0Xy6pKr6F9wHAa
         msQpx88tO0kew5UaG0vqgBpFUcq3ZAMz+RU7G/TdWgCn2bZqqfH8ryeQUUuaYahUC3XI
         4uVw2F60TwSXuPLn/xrzONDuQIA2qQAmtSQbh5T+eh3walzDLC22be8yseRQY1c+yfZI
         lzyA==
X-Gm-Message-State: AOJu0YzgitEErS4hEn+rF1pUa0v2TIjpD619lmB96MJjohNbh1bRDd05
	vsLwjcA3pT4NHDUl8rpWdWz604YaWpYuiJxtPGf/gg==
X-Google-Smtp-Source: AGHT+IHxCMHBfMVpExIVVSuVJhNalYlVYtiO/6e3jOfUl/8Xjel7DkFyavkBsCraG3ea8mn7lAMq3L92cfKKD865Ndc=
X-Received: by 2002:a17:90b:1c0f:b0:261:2824:6b8c with SMTP id
 oc15-20020a17090b1c0f00b0026128246b8cmr11459496pjb.13.1696698578521; Sat, 07
 Oct 2023 10:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1@mail.lac-coloc.fr>
In-Reply-To: <4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1@mail.lac-coloc.fr>
From: Tom Herbert <tom@herbertland.com>
Date: Sat, 7 Oct 2023 10:09:26 -0700
Message-ID: <CALx6S353hHELfoMPcTwTEvd3v6sn2jfFA7zegrtBRt6M3PaO1Q@mail.gmail.com>
Subject: Re: [PATCH net-next] vxlan: add support for flowlabel inherit
To: Alce Lafranque <alce@lafranque.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, vincent@bernat.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 30, 2023 at 8:14=E2=80=AFAM Alce Lafranque <alce@lafranque.net>=
 wrote:
>
> By default, VXLAN encapsulation over IPv6 sets the flow label to 0, with =
an
> option for a fixed value. This commits add the ability to inherit the flo=
w
> label from the inner packet, like for other tunnel implementations.

Is there any reason not to make setting the flow label on by default?
We've been doing this for TCP for quite a while now and it's not
breaking the network.

Tom

>
> ```
> $ ./ip/ip addr add 2001:db8::2/64 dev dummy1
> $ ./ip/ip link set up dev dummy1
> $ ./ip/ip link add vxlan1 type vxlan id 100 flowlabel inherit remote 2001=
:db8::1 local 2001:db8::2

Alce,

Is there any reason not to always set the flow label or at least make
setting the flow label be the default? We've been doing this for TCP
for quite a while now and it's not breaking the network, and we're
already setting the UDP source port with flow entropy in VXLAN anyway.

Tom

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
>             nla_put_u8(skb, IFLA_VXLAN_LEARNING,
>                        !!(vxlan->cfg.flags & VXLAN_F_LEARN)) ||
>             nla_put_u8(skb, IFLA_VXLAN_PROXY,
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index f346b4efbc30..2d746f4c9a0a 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -416,6 +416,17 @@ static inline u8 ip_tunnel_get_dsfield(const struct =
iphdr *iph,
>                 return 0;
>  }
>
> +static inline __be32 ip_tunnel_get_flowlabel(const struct iphdr *iph,
> +                                            const struct sk_buff *skb)
> +{
> +       __be16 payload_protocol =3D skb_protocol(skb, true);
> +
> +       if (payload_protocol =3D=3D htons(ETH_P_IPV6))
> +               return ip6_flowlabel((const struct ipv6hdr *)iph);
> +       else
> +               return 0;
> +}
> +
>  static inline u8 ip_tunnel_get_ttl(const struct iphdr *iph,
>                                        const struct sk_buff *skb)
>  {
> diff --git a/include/net/vxlan.h b/include/net/vxlan.h
> index 6a9f8a5f387c..f82ce013c8ff 100644
> --- a/include/net/vxlan.h
> +++ b/include/net/vxlan.h
> @@ -329,6 +329,7 @@ struct vxlan_dev {
>  #define VXLAN_F_VNIFILTER               0x20000
>  #define VXLAN_F_MDB                    0x40000
>  #define VXLAN_F_LOCALBYPASS            0x80000
> +#define VXLAN_F_LABEL_INHERIT          0x100000
>
>  /* Flags that are used in the receive path. These flags must match in
>   * order for a socket to be shareable
> @@ -534,6 +535,7 @@ static inline void vxlan_flag_attr_error(int attrtype=
,
>                 break
>         switch (attrtype) {
>         VXLAN_FLAG(TTL_INHERIT);
> +       VXLAN_FLAG(LABEL_INHERIT);
>         VXLAN_FLAG(LEARNING);
>         VXLAN_FLAG(PROXY);
>         VXLAN_FLAG(RSC);
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index fac351a93aed..bd69af34feba 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -830,6 +830,7 @@ enum {
>         IFLA_VXLAN_DF,
>         IFLA_VXLAN_VNIFILTER, /* only applicable with COLLECT_METADATA mo=
de */
>         IFLA_VXLAN_LOCALBYPASS,
> +       IFLA_VXLAN_LABEL_INHERIT,
>         __IFLA_VXLAN_MAX
>  };
>  #define IFLA_VXLAN_MAX (__IFLA_VXLAN_MAX - 1)
> --
> 2.39.2
>

