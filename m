Return-Path: <netdev+bounces-32791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF52479A719
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 12:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7467A2813DD
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 10:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D19C150;
	Mon, 11 Sep 2023 10:03:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4252BE6F
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:03:20 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65544E68
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 03:03:19 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-415155b2796so289701cf.1
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694426598; x=1695031398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2hcxVFqoiMjV0ieZ7k2DwXxV9QmZa9qY//8kb+w5h4=;
        b=kfWA0DQCIJvm5IkUvUrWdhq+8/v/xhek+DY/G7XLkG30QCqwsXlK6pW4xCNvRnuvRo
         cVE4ZhlSpDPQRchYWaNMTxo7Q9dDIaeq2HDTVyRp/95KiHMDM0PCtbSW8/ZGPwVu3GXV
         T5wKc7iebr+NWSZUR+9VozJgwDIgKv8jw1OYayGikjgQ3mdFFQPFodzc3KpqU5f5c/D+
         6Dq0Fes82IyxM3Atok4lOIf/XcwNyXwhObnEKhYPTNwPKZ4LkoaLN5qrU6LtOwiJ1JbO
         JDHI5eFLohJf7nngIOc0ip+x0a28cBsVa2xEOYHnwNO5M2wrfdgVhJW8OlI6cnBEXdWC
         hFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694426598; x=1695031398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2hcxVFqoiMjV0ieZ7k2DwXxV9QmZa9qY//8kb+w5h4=;
        b=WBdzQGvSQ75KABcwBJwtCce0OWuCL9r8l6RCAx2H4lw5DRVw6LPIz+GRGEZbpCTQE5
         EctgPP+OzXr9QMg3z/E358LHnUI34zKRor9f5hzOxTYvWacPI3Hofxq6kHMSi49wyPKd
         PkEeGpvbSPs+E8v5i7JesxP9+0v6vHfLq7syyM/QoTcnT4w7KsSudy1IVF5FRv2zFAbs
         HPO2kdO+dZcCMWzifTNaZBZxsqZvpVv/6ejutrp3n1XtXQv9VrVtzYjC87O5a7KMAIve
         4vABj9ZEu9TEW4uQZO2LFvoomZ6/WjKJ1E63QdIEzKby8kD5btMo8+zkq/Qr3Y1smZdQ
         OXTA==
X-Gm-Message-State: AOJu0Yy+MediMLbZJEigltCNK1ndgHuU6v4B7QZAFWu0H/5ZEjYpbJEC
	fZDPGrLTmWfyujAez/fyeREdFUoBFN6kd0BRqzsfrQ==
X-Google-Smtp-Source: AGHT+IFUN/iQV2Ttbu+bkcTNMpHOndrAQR6m6+DHJt745pvP8CJMxASNmT7/Hohtbh60cPuLION2yj8/jzx3kjXamCA=
X-Received: by 2002:ac8:5846:0:b0:403:affb:3c03 with SMTP id
 h6-20020ac85846000000b00403affb3c03mr613416qth.10.1694426598217; Mon, 11 Sep
 2023 03:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911095039.3611113-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20230911095039.3611113-1-mika.westerberg@linux.intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 11 Sep 2023 12:03:06 +0200
Message-ID: <CANn89i+RbD3Dr+ca1+HErkW099DgZXQ7VF=vcY3zAd-xViFusg@mail.gmail.com>
Subject: Re: [PATCH] net: thunderbolt: Fix TCP/UDPv6 GSO checksum calculation
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alex Balcanquall <alex@alexbal.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 11, 2023 at 11:50=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Alex reported that running ssh over IPv6 does not work with
> Thunderbolt/USB4 networking driver. The reason for that is that driver
> should call skb_is_gso() before calling skb_is_gso_v6(), and it should
> not return false after calculates the checksum successfully. This probabl=
y
> was a copy paste error from the original driver where it was done
> properly.
>
> While there add checksum calculation for UDPv6 GSO packets as well.

This part does not belong to this patch, and should be submitted for net-ne=
xt.

Note that this driver is not supposed to receive UDP GSO packets.

>
> Cc: stable@vger.kernel.org

What would be the Fixes: tag for this patch ?

> Reported-by: Alex Balcanquall <alex@alexbal.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/net/thunderbolt/main.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/mai=
n.c
> index 0c1e8970ee58..ba50a554478f 100644
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c
> @@ -1049,12 +1049,21 @@ static bool tbnet_xmit_csum_and_map(struct tbnet =
*net, struct sk_buff *skb,
>                 *tucso =3D ~csum_tcpudp_magic(ip_hdr(skb)->saddr,
>                                             ip_hdr(skb)->daddr, 0,
>                                             ip_hdr(skb)->protocol, 0);
> -       } else if (skb_is_gso_v6(skb)) {
> -               tucso =3D dest + ((void *)&(tcp_hdr(skb)->check) - data);
> -               *tucso =3D ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
> -                                         &ipv6_hdr(skb)->daddr, 0,
> -                                         IPPROTO_TCP, 0);
> -               return false;
> +       } else if (skb_is_gso(skb)) {
> +               if (skb_is_gso_v6(skb)) {
> +                       tucso =3D dest + ((void *)&(tcp_hdr(skb)->check) =
- data);
> +                       *tucso =3D ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr=
,
> +                                                 &ipv6_hdr(skb)->daddr, =
0,
> +                                                 IPPROTO_TCP, 0);
> +               } else if (protocol =3D=3D htons(ETH_P_IPV6) &&
> +                          (skb_shinfo(skb)->gso_type & SKB_GSO_UDP)) {
> +                       tucso =3D dest + ((void *)&(udp_hdr(skb)->check) =
- data);
> +                       *tucso =3D ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr=
,
> +                                                 &ipv6_hdr(skb)->daddr, =
0,
> +                                                 IPPROTO_UDP, 0);

This is dead code in the current state of this driver.

> +               } else {
> +                       return false;
> +               }
>         } else if (protocol =3D=3D htons(ETH_P_IPV6)) {
>                 tucso =3D dest + skb_checksum_start_offset(skb) + skb->cs=
um_offset;
>                 *tucso =3D ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
> --
> 2.40.1
>

