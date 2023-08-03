Return-Path: <netdev+bounces-23945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC7976E3CD
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677031C214BE
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0731914AA1;
	Thu,  3 Aug 2023 08:59:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F043C7E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:59:36 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F854E43
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:59:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso10498351fa.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 01:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691053173; x=1691657973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njscq6+geSyL8knM0LkHk83bPVCQ+A0pc4AOU0S0p6c=;
        b=aD9bKhW4rSX/zzNdCIBpOfR9wu17oUtZ0RguRV4tyTkjjGGEyhnIbgDHry+5ON4Cyy
         J2Zq7OmxN69oWnvo/xV5ElRy8YTfOnu91Pqm1J4Vcn62has574CCFwKFHZbQGXhpTEJ1
         Tb+EAGoKtKRXSVAPv8Gc+f/tpLqHurccwukzVbOYuVoK15dzEv10m2hDpPG7Ua42gEp8
         /dEUlNIRnodktelsYbsycHwWJx9tnoYP8jBaK+ZuF4zwwaAe+MSto67/DNdGqglwFT0X
         APiVsxbxygMngfWjXPuCt4yIZEz1HioDInIi6DntRRSelNjdWAONduIp1tkVE1Wtnzyx
         N/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691053173; x=1691657973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njscq6+geSyL8knM0LkHk83bPVCQ+A0pc4AOU0S0p6c=;
        b=Wxl2U121Eys9lJvvS/3QhRs0MZ0le4Q3Vy2WY4Sgy8rAH9cGtYmPVRpjsYK+bx98aV
         GXeszwjOjQDCwHjAHR+SIwAfy0BHaLeysskvf5d0z/GEo1l4ZinzYeOlYrzQdHRm8O0V
         YTvfX4rrrIWMQ1/pzExQqa5fZ3lb/dPGKv4GUSDz+2uGGs+zh8pG3qe170vSQNHdXLqW
         63XbBkck5z3h6Fuihhj+HhTo1mVNrXwZgzxHPmxF5saPU0Ct5NRT79JoKoGua4J/gnJc
         lTG0JhkQLQTmKEGJOs+4OfvTkulTQ/wNv+JybjXR2/aIGfCrAwtmP5Q9BgHYcpKmQrhb
         M+ww==
X-Gm-Message-State: ABy/qLY9MtefZ/sd21+bYrUjZTBe1VU7RoAMQOAV2Gk8LJsD7vkiwb+E
	TBiq02vsPLHubipIDygnur4WVfFgjVjwXXZ9MgHorwc6cXKZ0fhQiU0=
X-Google-Smtp-Source: APBJJlGqoZZpO+k7+kJDs4iho4OFxii2uZoD1H/TrVVOEAO5RlRbaZ4LmV//87oYU64FY91LBTB0AUrY4i3nGCM0UQ8=
X-Received: by 2002:a2e:9a89:0:b0:2b9:4841:9652 with SMTP id
 p9-20020a2e9a89000000b002b948419652mr6346882lji.25.1691053173221; Thu, 03 Aug
 2023 01:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802070454.22534-1-liangchen.linux@gmail.com>
 <20230802113755.4451c861@kernel.org> <CAKhg4tJS5zapTpF0HLaqfmck6Mdy_oR3R0Sem9eB3eC3MH+qPA@mail.gmail.com>
In-Reply-To: <CAKhg4tJS5zapTpF0HLaqfmck6Mdy_oR3R0Sem9eB3eC3MH+qPA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Aug 2023 11:58:57 +0300
Message-ID: <CAC_iWjJ=AR1j5dBYuT4zdO0Ai_88mz__MuwMSuL-=6T6BYhiFg@mail.gmail.com>
Subject: Re: [PATCH net-next] xdp: Fixing skb->pp_recycle flag in generic XDP handling
To: Liang Chen <liangchen.linux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Liang

On Thu, 3 Aug 2023 at 11:26, Liang Chen <liangchen.linux@gmail.com> wrote:
>
> On Thu, Aug 3, 2023 at 2:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Wed,  2 Aug 2023 15:04:54 +0800 Liang Chen wrote:
> > > In the generic XDP processing flow, if an skb with a page pool page
> > > (skb->pp_recycle =3D=3D 1) fails to meet XDP packet requirements, it =
will
> > > undergo head expansion and linearization of fragment data. As a resul=
t,
> > > skb->head points to a reallocated buffer without any fragments. At th=
is
> > > point, the skb will not contain any page pool pages. However, the
> > > skb->pp_recycle flag is still set to 1, which is inconsistent with th=
e
> > > actual situation. Although it doesn't seem to cause much real harm at=
 the
> > > moment(a little nagetive impact on skb_try_coalesce), to avoid potent=
ial
> > > issues associated with using incorrect skb->pp_recycle information,
> > > setting skb->pp_recycle to 0 to reflect the pp state of the skb.
> >
> > pp_recycle just means that the skb is "page pool aware", there's
> > absolutely no harm in having an skb with pp_recycle =3D 1 and no
> > page pool pages attached.
>
> I don't see it causing an error right now either. But it affects
> skb_try_coalesce in a negative way from a performance perspective -
> from->pp_recycle can be falsely true leading to a coalescing failure
> in "(from->pp_recycle && skb_cloned(from))" test, which otherwise
> would let the coalesce continue if from->pp_recycle was false. I
> wonder if that justifies the need for a fix.

This applies to non-native XDP code only though, right?  IIRC that
code was to make xdp easier to use but it's not used when xdp-like
performance is needed.

Thanks
/Ilias
>
> Thanks,
> Liang
>
>
> >
> > I vote not to apply this.

