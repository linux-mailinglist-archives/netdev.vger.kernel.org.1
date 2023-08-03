Return-Path: <netdev+bounces-23931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED7B76E2F1
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A048281ECB
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEC414AA4;
	Thu,  3 Aug 2023 08:26:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E4813AD0
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:26:05 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2E649E5
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:26:03 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9c0391749so10545101fa.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691051162; x=1691655962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cEbgGBj2kzNVj0mvMvo7ywv5QF2d/NALvPgdt1azFE=;
        b=ZgHqi9pH3wLSB6VkTmScMX0g0BtTqafh35ggGAubhlxIsckgJUGs5UblP+pBuikHsN
         f0yq4R8XSjLBZFeeKIxaDjTBOvUvNL14JjpO8KMcFMCiTH3o4T0+thICk/umYvSl6l0Y
         UV3u6j2hAgB+mSG1oUGmFMOrgoRHlt4FKbb+3xQNSxTwoYMaeD4pv1IQh96Wbe3iCZes
         j+9PDha6QLIZDeVaLswZtQdyGfLClowRNQMi9m5og596Z1OMucCPD/NWIW6y7WaTPRXQ
         LfLuPJ41mLjsJB6o4ZsWFrWZ0rvrg2LcoWgDdLNWHXPM9r20WzP8NTF1VVfdO7AiqbB1
         43nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691051162; x=1691655962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cEbgGBj2kzNVj0mvMvo7ywv5QF2d/NALvPgdt1azFE=;
        b=Ke7m56OE2/P4v8kQf78wWUqn3ySole9hyI8Y2X5AMrDWYTEaJ7wuBFns4MPl2fWtmr
         vlOYCtu3+ehPC5OIzxbxkTwJL435GGWppfFxJWaVXQJHJXlxuBdeES/LLpB4i6uHhK9C
         kFbadS3vVlHWj8wkvWYTC5j2JynC0fKLI9tXnevKp/83vEyrMEmGK14K4JpKovHmWirQ
         t2oP8cmOK+FJ9nF2bpV3JarOYX9KlybZv8x0B0DyFklsp4xUtnAiCHtn4XnJhbdTQCHp
         HIP8UQHen8OwzjgAKphGtx5GIQmRTFjO3K9iXKjhgU18FL2/Bn3Vc08tKzaSTd44NYnA
         C/Uw==
X-Gm-Message-State: ABy/qLb8JQC45Of/1mU4Osy7d6N4/Qyg67cxecXMOvEJ6nnUB+y20taf
	4HWoW0T3KOeRLHudKRJ1GvHQkvc4A8a4liRTd5k=
X-Google-Smtp-Source: APBJJlG8IPsSslb280lJoEa9QQWDPTnjvYzneoX5XSWhjobuHZo7gcOAF39Mr445Y3VWwB8yCRJtRtXNHdAGo7mFwTw=
X-Received: by 2002:a2e:98d0:0:b0:2b9:e8d6:c486 with SMTP id
 s16-20020a2e98d0000000b002b9e8d6c486mr7044596ljj.27.1691051161579; Thu, 03
 Aug 2023 01:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802070454.22534-1-liangchen.linux@gmail.com> <222b7508-ee46-1e7d-d024-436b0373aaea@intel.com>
In-Reply-To: <222b7508-ee46-1e7d-d024-436b0373aaea@intel.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 3 Aug 2023 16:25:49 +0800
Message-ID: <CAKhg4tJen5JQp-cpvdmdzy1RYJL_=a0bk6TYs0ud0G1rn1ebsg@mail.gmail.com>
Subject: Re: [PATCH net-next] xdp: Fixing skb->pp_recycle flag in generic XDP handling
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, ilias.apalodimas@linaro.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 3, 2023 at 1:11=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Liang Chen <liangchen.linux@gmail.com>
> Date: Wed,  2 Aug 2023 15:04:54 +0800
>
> > In the generic XDP processing flow, if an skb with a page pool page
> > (skb->pp_recycle =3D=3D 1) fails to meet XDP packet requirements, it wi=
ll
> > undergo head expansion and linearization of fragment data. As a result,
> > skb->head points to a reallocated buffer without any fragments. At this
> > point, the skb will not contain any page pool pages. However, the
> > skb->pp_recycle flag is still set to 1, which is inconsistent with the
> > actual situation. Although it doesn't seem to cause much real harm at t=
he
>
> This means it must be handled in the function which replaces the head,
> i.e. pskb_expand_head(). Your change only suppresses one symptom of the
> issue.
>

I attempted to do so. But after pskb_expand_head, there may still be
skb frags with pp pages left. It is after skb_linearize those frags
are removed.

Thanks,
Liang

> > moment(a little nagetive impact on skb_try_coalesce), to avoid potentia=
l
>
>                   ^^^^^^^^
>                   negative
>

Sure, Thanks.


> > issues associated with using incorrect skb->pp_recycle information,
> > setting skb->pp_recycle to 0 to reflect the pp state of the skb.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
>
> I won't say for sure, but may be a candidate for the fixes tree, not
> next. This way it would need a "Fixes:" tag here (above the SoB).
>
> > ---
> >  net/core/dev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 10e5a036c706..07baf72be7d7 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4934,6 +4934,8 @@ static u32 netif_receive_generic_xdp(struct sk_bu=
ff *skb,
> >                       goto do_drop;
> >               if (skb_linearize(skb))
> >                       goto do_drop;
> > +             if (skb->pp_recycle)
> > +                     skb->pp_recycle =3D 0;
> >       }
> >
> >       act =3D bpf_prog_run_generic_xdp(skb, xdp, xdp_prog);
>
> Thanks,
> Olek

