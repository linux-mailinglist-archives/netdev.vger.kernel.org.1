Return-Path: <netdev+bounces-18349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA1675685B
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B368928138C
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59FBAD52;
	Mon, 17 Jul 2023 15:53:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79B253CA
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 15:53:40 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503CEA4
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 08:53:39 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40371070eb7so509491cf.1
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689609218; x=1692201218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pK03hhHheIJvqruWqabhLvkxIsrgtrIeE1l/NaK2B8E=;
        b=ktQ3Cohae8BtvGHO/VofvhZPocYnWZRYuQBeZf32czv9GYgBr5z2OgxGo5JPjdZK+0
         P6AEoS/rsj1QrJWirbaUGRoeTiYyQArj3SQ+WIvDBvFkWZX62SV19hCukGVEu2nB/eOm
         Cd7t8DoU0pY6KNDcwm57WVf3s9/0U3+0qOCnWkDhgIr1DuQcZZ7uBeH3c6Pp5hoQ84ja
         sy7ZEVkVCCpkUH1PHPgZCkfeD09DnDL2fb+XxungWXYqAZuy0stwYYr7qfR5aGXRh+O6
         qJuBuzsidO/lAp9zTqPZ61Ojvrbq+z2QMvcalN6h3MCbH1ZpjE4WuIRbLXdl0ClCtHm5
         +Mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689609218; x=1692201218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pK03hhHheIJvqruWqabhLvkxIsrgtrIeE1l/NaK2B8E=;
        b=JMoeRkQwxKbKuwp0CYzrdIubt11UrQ9d1rj/1hN6jQt/crvDEAYkLJWM5OXAcYNufS
         3IVtFyM8MX/Gry2dB7OT9CD50KG6RGI/Wz2q1Zl0pdudyOBvgSiTzVIhWeLPYszme3F1
         5lyq5pGIhJAE0zXmhNAse5RHnI/4kN0+GYs3kMlDweW58B1SsHPxcAYKXBwTF/cKm+T5
         pNmMpugoJBUDK67mI9RUaK35DCcAM4PnTJKIYPgA0gIOW0Hua8su/BnQkSOpISzPBI85
         eJOaXI53g3kTOtd+YK64wF4SnvzbupdXNwJ3L+a4/nuyS67RAr52rgGSN9hyBmSqXG80
         fwsQ==
X-Gm-Message-State: ABy/qLYc7vX2oCOl2iMEqykF1wg3rhIF0IWaH1FhSlTEDWua/rpslOHG
	Lepv0Hh4SspnJE9lYiQs7l2Uly6ffE+FrJmkX0JJ/A==
X-Google-Smtp-Source: APBJJlFmldkyiAVX0KXpV00UUih5Y9Dv7V14DBLKC1+wUC/xiqWdIALTWbo0WS2Cu3dddxuhhqHzQtV+nfKmV/zOEJw=
X-Received: by 2002:a05:622a:15d4:b0:3f8:5b2:aef5 with SMTP id
 d20-20020a05622a15d400b003f805b2aef5mr1023734qty.29.1689609218228; Mon, 17
 Jul 2023 08:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717145024.27274-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20230717145024.27274-1-ruc_gongyuanjun@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Jul 2023 17:53:26 +0200
Message-ID: <CANn89iKk2TBA18TcGMUT=r-zT-kKe69nf17idojNStosXmLPPQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] net:openvswitch: check return value of pskb_trim()
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: Pravin B Shelar <pshelar@ovn.org>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 4:50=E2=80=AFPM Yuanjun Gong <ruc_gongyuanjun@163.c=
om> wrote:
>
> do kfree_skb() if an unexpected result is returned by pskb_tirm()
> in do_output().
>
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  net/openvswitch/actions.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index cab1e02b63e0..6b3456bdff1c 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -920,9 +920,11 @@ static void do_output(struct datapath *dp, struct sk=
_buff *skb, int out_port,
>
>                 if (unlikely(cutlen > 0)) {
>                         if (skb->len - cutlen > ovs_mac_header_len(key))
> -                               pskb_trim(skb, skb->len - cutlen);
> +                               if (pskb_trim(skb, skb->len - cutlen))
> +                                       kfree_skb(skb);
>                         else
> -                               pskb_trim(skb, ovs_mac_header_len(key));
> +                               if (pskb_trim(skb, ovs_mac_header_len(key=
)))
> +                                       kfree_skb(skb);
>

This patch is not correct, skb will be reused later, and UAF will happen.

