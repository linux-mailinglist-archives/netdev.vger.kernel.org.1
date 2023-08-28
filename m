Return-Path: <netdev+bounces-31057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F7F78B1C1
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 15:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09781C2094B
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 13:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA474125DD;
	Mon, 28 Aug 2023 13:25:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7A712B63
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 13:25:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7D9128
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693229141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lkVi8G9t3DhEUoFFRrWK8mrl/xbvzQsgW1UJs7JQLE=;
	b=A9yYkpDc+LJzEiWP+HgiQybBSmzWZLJcsNeqPMaSmVu2lDUTU3gnXHahqgO95qMhH+TNNV
	nyB8jKtxriIjsJzpY+9KIoH0P6yMJRIK8Ay4Njp6B+HlX/SMU0zTK6LeJ5b7Cen9I6PA1L
	4Wq+YGU96U3Mi1JbP52Y5BIKSRICm3w=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-GQDoaSg4OXOLjtJ0gpSTxg-1; Mon, 28 Aug 2023 09:25:37 -0400
X-MC-Unique: GQDoaSg4OXOLjtJ0gpSTxg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40ea01f3e3bso38681331cf.1
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693229136; x=1693833936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lkVi8G9t3DhEUoFFRrWK8mrl/xbvzQsgW1UJs7JQLE=;
        b=WWLySi+Ba9wsg0Ql8LcGXCpg1z6nTYgao9+ZBx9fe3XtQwJXeWtMpukz1/OZiWXWIb
         EzMO7FvhzlNv19fIFWw/kSzcmIsI8sRgu0qTpkdQ33NBLAiiYtIROR5GT8r4wc+5lAvy
         Wb4vL5IqWqHV47KRzlTxGpdie8O37nmc4WiYoDfOteiDIujBMhqs6yGJi7vgskcqmJcN
         nB/OFocrOspYOoxBCiE//FpZCMmGEqHd2lZcwiFYSKOJcsiYPfx8v1NpLW7GodWEQWxP
         Jc2VNrq+LKbzVkB9OtozSQ5l7XEWJ9FF56rwBs7cjF8v+N1WDSOjNT80lYkytptyaTcc
         gFAg==
X-Gm-Message-State: AOJu0YyO8+A8WeHE40kiJyWnKPOn1K/0mGbNYa0RygywvOAOBDo4mRYE
	h33XFYexkiA2gZraiEXoeFCDUq008Wf9VIZDRI9T2AdWDJX8jWJgxLv7NE3tz7YdFdGd1+2fLp/
	/4hsgecbs2gwhYi77ycplwtOnB+Q++qH9
X-Received: by 2002:a05:622a:1a24:b0:411:f4fe:9ed9 with SMTP id f36-20020a05622a1a2400b00411f4fe9ed9mr16323491qtb.33.1693229136765;
        Mon, 28 Aug 2023 06:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBLr77o5uusum213XormNvFrxdCOcrOegbeF8tGFSkFqjJPSBRC5UPszDdYzg0ivfq4iMGUTGklyqa2fGqOrY=
X-Received: by 2002:a05:622a:1a24:b0:411:f4fe:9ed9 with SMTP id
 f36-20020a05622a1a2400b00411f4fe9ed9mr16323477qtb.33.1693229136556; Mon, 28
 Aug 2023 06:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230828132107.18376-1-wander@redhat.com>
In-Reply-To: <20230828132107.18376-1-wander@redhat.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Mon, 28 Aug 2023 10:25:25 -0300
Message-ID: <CAAq0SUkY=MfgJk+w8ZPtn=A5GEm_4BknPL-bgLn=77_fc3XX6Q@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter/xt_u32: validate user space input
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Patrick McHardy <kaber@trash.net>, 
	Jan Engelhardt <jengelh@gmx.de>, "open list:NETFILTER" <netfilter-devel@vger.kernel.org>, 
	"open list:NETFILTER" <coreteam@netfilter.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+stable as I forgot to add it in the Cc section.

On Mon, Aug 28, 2023 at 10:21=E2=80=AFAM Wander Lairson Costa <wander@redha=
t.com> wrote:
>
> The xt_u32 module doesn't validate the fields in the xt_u32 structure.
> An attacker may take advantage of this to trigger an OOB read by setting
> the size fields with a value beyond the arrays boundaries.
>
> Add a checkentry function to validate the structure.
>
> This was originally reported by the ZDI project (ZDI-CAN-18408).
>
> Fixes: 1b50b8a371e9 ("[NETFILTER]: Add u32 match")
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  net/netfilter/xt_u32.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/net/netfilter/xt_u32.c b/net/netfilter/xt_u32.c
> index 177b40d08098..117d4615d668 100644
> --- a/net/netfilter/xt_u32.c
> +++ b/net/netfilter/xt_u32.c
> @@ -96,11 +96,32 @@ static bool u32_mt(const struct sk_buff *skb, struct =
xt_action_param *par)
>         return ret ^ data->invert;
>  }
>
> +static int u32_mt_checkentry(const struct xt_mtchk_param *par)
> +{
> +       const struct xt_u32 *data =3D par->matchinfo;
> +       const struct xt_u32_test *ct;
> +       unsigned int i;
> +
> +       if (data->ntests > ARRAY_SIZE(data->tests))
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < data->ntests; ++i) {
> +               ct =3D &data->tests[i];
> +
> +               if (ct->nnums > ARRAY_SIZE(ct->location) ||
> +                   ct->nvalues > ARRAY_SIZE(ct->value))
> +                       return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static struct xt_match xt_u32_mt_reg __read_mostly =3D {
>         .name       =3D "u32",
>         .revision   =3D 0,
>         .family     =3D NFPROTO_UNSPEC,
>         .match      =3D u32_mt,
> +       .checkentry =3D u32_mt_checkentry,
>         .matchsize  =3D sizeof(struct xt_u32),
>         .me         =3D THIS_MODULE,
>  };
> --
> 2.41.0
>


