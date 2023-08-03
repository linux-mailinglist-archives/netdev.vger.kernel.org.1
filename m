Return-Path: <netdev+bounces-24028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 849C076E812
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584AB1C20430
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 12:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3C01ED39;
	Thu,  3 Aug 2023 12:17:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13321EA72
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 12:17:27 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0F1716
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 05:17:26 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9cbaee7a9so13605591fa.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691065045; x=1691669845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIwEeh4kFmrY9ERyUwboLqJAQm0B6Gx2M6+z8kZM7rY=;
        b=pYCyEY3dE32pZOiLyDMcsbczlgPbAemIJ6zKvRne6iWSDG5TYQfKnRhqQffTFdy+65
         Pxk7+C5U7HXE64awQVcijOfQbH/elHFXw7GPO6TqB+qUPbMkpGE7RUAIYfl0S7/t32Sg
         auyTmerDc2xlwxp/vNCM7o3V51ykL1WD+nIlERTmD78A6IIpI7AfV01i2VFhH7dXU8Of
         56EYPw+sTjnILg+nETvMXL7LlvjskNp9NfUDpNJu/VqWM5zP97wjDU6L+7YIl+MWpeId
         kOMD7RpONkJ1GTABO7Lhf7vQjeeG0EWEfGuDHGDv/6ZU/QpNJxZgu/YS1b5bwlnfP83S
         kvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691065045; x=1691669845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIwEeh4kFmrY9ERyUwboLqJAQm0B6Gx2M6+z8kZM7rY=;
        b=hrzDsFsKoUc4EYI6vG2REURt/jC8e0eLbuUsQnd7JogYgh3q8ONJDjrfzIC5mshDrS
         vDsO3QWIVXcc9Pm2mV0m/IowOmN7Tvdrauoc4i2xwI0k4lIWiZamVNX5xBYxyvhWACC6
         acm+kage41mQzt/69ZwwvMlCiL5m5Wo/acwU9EtTHozOcbzEyXVi/uRel60wIE4B9N5O
         qoXV327iA63sL1zHWYEnbT6pVhlTlpWtocUjBSa0ga6i9XiGNWNqBcdYfoskmDFen+lF
         xhYvtH+QF4sCGjHbd4XYwVPfvZdF7oWt/49GBFHr/lsKgUH2EIX4sXxt+RIzwkc0b7UU
         CsEg==
X-Gm-Message-State: ABy/qLa7jb4c7bLVSubzfKGuG5Wjnve6PZCRhbcxYVcbSVL6dw0j0Wuv
	5b37qkxjwCzxQIcz+Fg35/Y6kGSyYpwWhI/ROdY=
X-Google-Smtp-Source: APBJJlHeyoGi1czWrJLG0EuBItST9TkJRaeLyfHuTKQM0oZgswBM9WnyzYhz648hntnOP4ORUI9tobApeP6Bg9YEZ20=
X-Received: by 2002:a2e:98d0:0:b0:2b9:c4ce:558f with SMTP id
 s16-20020a2e98d0000000b002b9c4ce558fmr7048365ljj.37.1691065044454; Thu, 03
 Aug 2023 05:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802070454.22534-1-liangchen.linux@gmail.com>
 <20230802113755.4451c861@kernel.org> <CAKhg4tJS5zapTpF0HLaqfmck6Mdy_oR3R0Sem9eB3eC3MH+qPA@mail.gmail.com>
 <CAC_iWjJ=AR1j5dBYuT4zdO0Ai_88mz__MuwMSuL-=6T6BYhiFg@mail.gmail.com>
In-Reply-To: <CAC_iWjJ=AR1j5dBYuT4zdO0Ai_88mz__MuwMSuL-=6T6BYhiFg@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 3 Aug 2023 20:17:12 +0800
Message-ID: <CAKhg4tJg6bP84QnPMwHgYFZhp1S7W3Hm-5M7PE2ATnYt58G=iA@mail.gmail.com>
Subject: Re: [PATCH net-next] xdp: Fixing skb->pp_recycle flag in generic XDP handling
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 3, 2023 at 4:59=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Liang
>
> On Thu, 3 Aug 2023 at 11:26, Liang Chen <liangchen.linux@gmail.com> wrote=
:
> >
> > On Thu, Aug 3, 2023 at 2:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Wed,  2 Aug 2023 15:04:54 +0800 Liang Chen wrote:
> > > > In the generic XDP processing flow, if an skb with a page pool page
> > > > (skb->pp_recycle =3D=3D 1) fails to meet XDP packet requirements, i=
t will
> > > > undergo head expansion and linearization of fragment data. As a res=
ult,
> > > > skb->head points to a reallocated buffer without any fragments. At =
this
> > > > point, the skb will not contain any page pool pages. However, the
> > > > skb->pp_recycle flag is still set to 1, which is inconsistent with =
the
> > > > actual situation. Although it doesn't seem to cause much real harm =
at the
> > > > moment(a little nagetive impact on skb_try_coalesce), to avoid pote=
ntial
> > > > issues associated with using incorrect skb->pp_recycle information,
> > > > setting skb->pp_recycle to 0 to reflect the pp state of the skb.
> > >
> > > pp_recycle just means that the skb is "page pool aware", there's
> > > absolutely no harm in having an skb with pp_recycle =3D 1 and no
> > > page pool pages attached.
> >
> > I don't see it causing an error right now either. But it affects
> > skb_try_coalesce in a negative way from a performance perspective -
> > from->pp_recycle can be falsely true leading to a coalescing failure
> > in "(from->pp_recycle && skb_cloned(from))" test, which otherwise
> > would let the coalesce continue if from->pp_recycle was false. I
> > wonder if that justifies the need for a fix.
>
> This applies to non-native XDP code only though, right?  IIRC that
> code was to make xdp easier to use but it's not used when xdp-like
> performance is needed.

Sure, this applies to non-native XDP code only. Thanks.

Thanks,
Liang

>
> Thanks
> /Ilias
> >
> > Thanks,
> > Liang
> >
> >
> > >
> > > I vote not to apply this.

