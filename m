Return-Path: <netdev+bounces-22247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB0D766B07
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204DE1C21880
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BB21118C;
	Fri, 28 Jul 2023 10:50:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB54F1095A
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:50:35 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D85330C2
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:50:34 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4036bd4fff1so269151cf.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690541433; x=1691146233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYfWyfTCEcT3hJQzfO1YAXMg0xGkbveV1tJES3zeTUk=;
        b=NLML1Za7y4RXhWHhxvE1OwRnU+p6zO1MotDJwZWsLyWLCE0PxJeGWe01PwgimhD4BR
         w0gJjfl/CKnCOk9Ec3okg2uwin/n8W7tEhQGDcskSgCK8oqEs5Ffhs5c17IvFuzlE18J
         MWQKSXh6db2PxPdjdmqVt/0jxsaHxwohcJ9UWspy3/9kdYvFFjR6q1VFXwUwTnTpjIIg
         Lzr2UWAoCKnxhSYXDPzmUp1Pkq7OSkBbKoO8GCE5jYS41+0G3EX7hQnqcz2zIrZBkWzH
         W/YP9CcyOMIeTM9TI+8/qCRLREWe4ZkEG5fbshiJMxUwXQ4liuA/l4HIvl01Y8dUFeK6
         7Dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690541433; x=1691146233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYfWyfTCEcT3hJQzfO1YAXMg0xGkbveV1tJES3zeTUk=;
        b=gw7ynhc7JuYDRuYeI/mW47Ne/rj1m/MlNe4IQupIbSp8NRdvO3EUaO0FjIk27zn35C
         O0p7xkb6YhwjWQs45ccCrJ+4d3rTrw7TlWGj+45kzRjAiwhnwC0EPrEeBQLEJKXQtl9a
         4LC4h20Dp0R3HXdbmzLWsTXCq7LwucVsPngh9vpFcHiXPUNQtkmOgBnVsnZpozn+Dj/7
         MGul/XF20qHOhyWZDOq0ltOtxIULZ+V+4MJ55urCbQGXk4Xg6ck402hpwkYst2IBwIsv
         9D26W81bOAiW3EAm9ZA+ihI//pSlbCm2uJXpr6tW0/yJviZo6oMiQ+JfDF5vBhHbR0Fh
         GR6w==
X-Gm-Message-State: ABy/qLasHV94+Jo14mpYKIr/9tvXKjFIkkM6qWeUAHbwktNRYLyHNGmI
	liM01jmdrTDmYaEz7P++c3k0/1O7wTNMkA3JYM5eqw==
X-Google-Smtp-Source: APBJJlG4Paj/ge2GJYCrhBhKf2tH/RnnC7a7mHaZ8AjT/Xvue1wYoUhtfSA+NWdwhXfTp+EaANj1xQHck9LNfSfnGGw=
X-Received: by 2002:a05:622a:20d:b0:403:e1d1:8b63 with SMTP id
 b13-20020a05622a020d00b00403e1d18b63mr228668qtx.24.1690541433419; Fri, 28 Jul
 2023 03:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230728100035.32092-1-yuehaibing@huawei.com>
In-Reply-To: <20230728100035.32092-1-yuehaibing@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Jul 2023 12:50:22 +0200
Message-ID: <CANn89iJd5amMy+znSi_fP_zNLB3yta7XKcG7fVFk9h0JWDy6Pg@mail.gmail.com>
Subject: Re: [PATCH] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 12:01=E2=80=AFPM Yue Haibing <yuehaibing@huawei.com=
> wrote:
>
>  skbuff: skb_under_panic: text:ffffffff88771f69 len:56 put:-4
>  head:ffff88805f86a800 data:ffff887f5f86a850 tail:0x88 end:0x2c0 dev:pim6=
reg
>  ------------[ cut here ]------------
>

> When setup a vlan device on dev pim6reg, DAD ns packet may sent on reg_vi=
f_xmit().
> reg_vif_xmit()
>     ip6mr_cache_report()
>         skb_push(skb, -skb_network_offset(pkt));//skb_network_offset(pkt)=
 is 4
> And skb_push declar as this:
>         void *skb_push(struct sk_buff *skb, unsigned int len);
>                 skb->data -=3D len;
>                 //0xffff888f5f86a84c - 0xfffffffc =3D 0xffff887f5f86a850
> skb->data is set to 0xffff887f5f86a850, which is invalid mem addr, lead t=
o skb_push() fails.
>
> Fixes: 14fb64e1f449 ("[IPV6] MROUTE: Support PIM-SM (SSM).")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/ipv6/ip6mr.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index cc3d5ad17257..ee9c2ff8b0e4 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -1051,9 +1051,9 @@ static int ip6mr_cache_report(const struct mr_table=
 *mrt, struct sk_buff *pkt,
>         int ret;
>
>  #ifdef CONFIG_IPV6_PIMSM_V2
> +       int nhoff =3D skb_network_offset(pkt);
>         if (assert =3D=3D MRT6MSG_WHOLEPKT || assert =3D=3D MRT6MSG_WRMIF=
WHOLE)
> -               skb =3D skb_realloc_headroom(pkt, -skb_network_offset(pkt=
)
> -                                               +sizeof(*msg));
> +               skb =3D skb_realloc_headroom(pkt, -nhoff + sizeof(*msg));
>         else
>  #endif
>                 skb =3D alloc_skb(sizeof(struct ipv6hdr) + sizeof(*msg), =
GFP_ATOMIC);
> @@ -1073,7 +1073,8 @@ static int ip6mr_cache_report(const struct mr_table=
 *mrt, struct sk_buff *pkt,
>                    And all this only to mangle msg->im6_msgtype and
>                    to set msg->im6_mbz to "mbz" :-)
>                  */
> -               skb_push(skb, -skb_network_offset(pkt));
> +               skb->data +=3D nhoff;
> +               skb->len  -=3D nhoff;

__skb_pull(skb, nhoff);

>
>                 skb_push(skb, sizeof(*msg));
>                 skb_reset_transport_header(skb);
> --
> 2.34.1
>

