Return-Path: <netdev+bounces-13178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1CD73A8B6
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 21:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D041C21031
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491CE206B3;
	Thu, 22 Jun 2023 19:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3944E1F923
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 19:00:57 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F017E9B
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:00:55 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so39861cf.0
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687460455; x=1690052455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBcPk71S59A1wzQowZ1Auxttbe+Ge21/r6ggp+unjvQ=;
        b=L4VgaxZ+U75Gm3srBSvPHyzPLnx4Ksb14ZD8O1Zra/FVdqfsXWwhp22/K8SDOAka2k
         R8H4KrmJFrWcH1/YSQZpQ9QK5bwniww2Y7UqgQKzXgCVXaDEn2vdBy1RQh2eA4zxGAH1
         NgI2jT7GeoJavj7QOL+5cjexW7l3+uZMrw229pAYw8AT31ACpajzYpYXKRbw0c7EOtlI
         5kx4BHXUGONko1zIdMIh2fGlUD6GNCYTCPYfC6CmwIEykBF4C6NAc3QXnzpORKy+XB2T
         nBDiA73PD0lYpNO34aJIkaW0wCKCAFx0CV3hdvCWnYgPxMPHl0aprM8z7YyXe5t+tHae
         5zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460455; x=1690052455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBcPk71S59A1wzQowZ1Auxttbe+Ge21/r6ggp+unjvQ=;
        b=amuTsd/bWYGRwNToF3wcRgOYuimEBQ0GpvpmqfjhdkTCmb0CdaAeurVHS0cs72M9lx
         BfbQO86ow499Tt3bYT1FQ76UyOi5bQRu9U10Tn8YACzzmQb24z7hCU/ZrhF/hhb99ybL
         OS8A1iqe2M4uYd5eUp02K1kk+hV0772CbMYXrI8ayn+CzXH4XNGKYaUjsv/iOSnygMy5
         amOYKBgna7PnpV0DZoNMhAcY+KDS6aWpgpV12F4qSq0Bfftb4Id2x1YsJAMXxIzu33vr
         fH3SDGhUCS6mshnjQUilQ5+igPyvyfoslpulo1RIdrjiqg727pjAbI4e/zJi0MqW4r7f
         X7Iw==
X-Gm-Message-State: AC+VfDyqdlVAkBpZSZy4V1/A3u4wd2M2vzwcNztH5q4Beed5qoK//L+0
	DZyZN7g/Ih0xO6j8FHBhnqkalzPbpt81E9s8ADGoww==
X-Google-Smtp-Source: ACHHUZ4n5kiY5wfEeQJIUZfsX/hSRPLUYRWuRwMlTvLyJV4N+ZTEpNCNU7sEqGU528AmkmRi1NuOSwrVlWuXUZBuC+Y=
X-Received: by 2002:a05:622a:2c1:b0:3ef:343b:fe7e with SMTP id
 a1-20020a05622a02c100b003ef343bfe7emr1838748qtx.2.1687460454845; Thu, 22 Jun
 2023 12:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230622152304.2137482-1-edumazet@google.com> <22643.1687456107@famine>
 <CANn89iJSmS_B1q=oG_e-RxtWkOuj0x0eqhsp5BeuCn-TuS0W5w@mail.gmail.com> <26275.1687460144@famine>
In-Reply-To: <26275.1687460144@famine>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jun 2023 21:00:43 +0200
Message-ID: <CANn89i+Vcwp9o59Fzy+epqS+YSxjrStNjBRX-5GSie_TdiMbVg@mail.gmail.com>
Subject: Re: [PATCH net] bonding: do not assume skb mac_header is set
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Jarod Wilson <jarod@redhat.com>, 
	Moshe Tal <moshet@nvidia.com>, Jussi Maki <joamaki@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 8:55=E2=80=AFPM Jay Vosburgh <jay.vosburgh@canonica=
l.com> wrote:
>
> Eric Dumazet <edumazet@google.com> wrote:
>
> >On Thu, Jun 22, 2023 at 7:48=E2=80=AFPM Jay Vosburgh <jay.vosburgh@canon=
ical.com> wrote:
> >>
> >> Eric Dumazet <edumazet@google.com> wrote:
>
> [...]
>
> >> > drivers/net/bonding/bond_main.c | 2 +-
> >> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bo=
nd_main.c
> >> >index edbaa1444f8ecd9bf344a50f6f599d7eaaf4ff3e..091e035c76a6ff29facba=
f1c0f26d185dc8ff5e3 100644
> >> >--- a/drivers/net/bonding/bond_main.c
> >> >+++ b/drivers/net/bonding/bond_main.c
> >> >@@ -4197,7 +4197,7 @@ u32 bond_xmit_hash(struct bonding *bond, struct=
 sk_buff *skb)
> >> >               return skb->hash;
> >> >
> >> >       return __bond_xmit_hash(bond, skb, skb->data, skb->protocol,
> >> >-                              skb_mac_offset(skb), skb_network_offse=
t(skb),
> >> >+                              0, skb_network_offset(skb),
> >> >                               skb_headlen(skb));
> >> > }
> >>
> >>         Is the MAC header guaranteed to be at skb->data, then?  If not=
,
> >> then isn't replacing skb_mac_offset() with 0 going to break the hash (=
as
> >> it might or might not be looking at the actual MAC header)?
> >>
> >
> >In ndo_start_xmit(), skb->data points to MAC header by definition.
>
>         Ok.
>
> >>         Also, assuming for the moment that this change is ok, this mak=
es
> >> all callers of __bond_xmit_hash() supply zero for the mhoff parameter,
> >> and a complete fix should therefore remove the unused parameter and it=
s
> >> various references.
> >
> >Not really: bond_xmit_hash_xdp() calls __bond_xmit_hash() with
> >sizeof(struct ethhdr)
>
>         I don't think so:
>
> static u32 __bond_xmit_hash(struct bonding *bond, struct sk_buff *skb, co=
nst void *data,
>                             __be16 l2_proto, int mhoff, int nhoff, int hl=
en)
> {
>
>         "mhoff", currently supplied as skb_mac_offset(skb) in
> bond_xmit_hash(), is the fifth parameter.
>
> static u32 bond_xmit_hash_xdp(struct bonding *bond, struct xdp_buff *xdp)
> {
> [...]
>         return __bond_xmit_hash(bond, NULL, xdp->data, eth->h_proto, 0,
>                                 sizeof(struct ethhdr), xdp->data_end - xd=
p->data);
> }
>
>         The fifth argument here is 0.
>

Ah right, I will send another patch to remove it then.

I think it makes sense to keep the first patch small for backports.

History of relevant patches :

from 5.17

429e3d123d9a50cc9882402e40e0ac912d88cfcf bonding: Fix extraction of
ports from the packet headers

from 5.15

a815bde56b15ce626caaacc952ab12501671e45d net, bonding: Refactor
bond_xmit_hash for use with xdp_buff

