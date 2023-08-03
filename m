Return-Path: <netdev+bounces-23933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269E576E2F9
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE16F1C2148A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A924D1548F;
	Thu,  3 Aug 2023 08:26:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B71548E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:26:32 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203FD3AAF
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:26:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so10182051fa.2
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691051189; x=1691655989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRmTu/iJygILEtwB4nFn1cZ8IL1EY6F3shQYOjUlgaA=;
        b=JYAyIkyhtoZLN6fDZ703qpjlgnlfercMd7aielWOWujXJsubwSbQo88QxXgPM7woZN
         nu49r3vkgDofYsnZJ41pd/4ij0LV73zGEV3N063XWK76UzIXxjX0Tj7+mOr6REe2c+dY
         0SLWA4y/Tu4dmYh+SkMR3hQEq4+Jp5VI4cenYA05P33ZZQ3f9hrp+eMcsEvo/7zviPVJ
         yrRd/bqLjJDqegncifwxNKWb34kxXOHN9ZckRlmsoa4uo60Bc1uw78SOAijSRAhcqESq
         52Atr9owYphQQgsvP8eARChXOldlhM7ItJGnWwHm3683QHjx5csYbrUZKyTtg+A9/5tS
         vg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691051189; x=1691655989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRmTu/iJygILEtwB4nFn1cZ8IL1EY6F3shQYOjUlgaA=;
        b=edmo7M5U70ZutYPh9rrqhMQ5KhhETEMTcbNh57PRqtqcH2pYjvCvz2etUqQecyBw/e
         bDXt5g7Hu5helbB2lwqCNzcg1LtRupRk9YKJLN82Rz2JoTez51B+721AmvPBhZbtX2Mi
         5xxOjHJ/r2mueLaC88RfkrjTABfH8P6gEATrDU2tjKHlFI3Rx6ntrUmMicxBnTu/kjJz
         XjEGv3vGWk/2hpNEPlK4ZeZIyN6VKJqghnKy03iQK4m5U8mHLAn0agAB/zdYC/YUWHXy
         nK6an6qd/vnGmdIwQoI/EyC8OqYD0jP3VbZ7QXsaui2VHzMEQ4IzYd9g3H9dh4X144QN
         G4+w==
X-Gm-Message-State: ABy/qLazV14vlRIN6MOw/11IpMmtIodssoSPhRLVhiXfXp0F1E6hwpDk
	1rynyZkJZIifrE5xs7AdTQKWsDUy2IwUy+gVeI0=
X-Google-Smtp-Source: APBJJlG3CvKEBxEZOcy3fc9K4OOZOoBDAGSZk4wh6GQLlpuC3OYjXesNDO7KBvrtaiSQO/3oKUPlt/AarZ7Zg/MY5Uc=
X-Received: by 2002:a2e:3307:0:b0:2b6:e76b:1e50 with SMTP id
 d7-20020a2e3307000000b002b6e76b1e50mr7146096ljc.41.1691051189017; Thu, 03 Aug
 2023 01:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802070454.22534-1-liangchen.linux@gmail.com> <20230802113755.4451c861@kernel.org>
In-Reply-To: <20230802113755.4451c861@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 3 Aug 2023 16:26:16 +0800
Message-ID: <CAKhg4tJS5zapTpF0HLaqfmck6Mdy_oR3R0Sem9eB3eC3MH+qPA@mail.gmail.com>
Subject: Re: [PATCH net-next] xdp: Fixing skb->pp_recycle flag in generic XDP handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	ilias.apalodimas@linaro.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 3, 2023 at 2:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  2 Aug 2023 15:04:54 +0800 Liang Chen wrote:
> > In the generic XDP processing flow, if an skb with a page pool page
> > (skb->pp_recycle =3D=3D 1) fails to meet XDP packet requirements, it wi=
ll
> > undergo head expansion and linearization of fragment data. As a result,
> > skb->head points to a reallocated buffer without any fragments. At this
> > point, the skb will not contain any page pool pages. However, the
> > skb->pp_recycle flag is still set to 1, which is inconsistent with the
> > actual situation. Although it doesn't seem to cause much real harm at t=
he
> > moment(a little nagetive impact on skb_try_coalesce), to avoid potentia=
l
> > issues associated with using incorrect skb->pp_recycle information,
> > setting skb->pp_recycle to 0 to reflect the pp state of the skb.
>
> pp_recycle just means that the skb is "page pool aware", there's
> absolutely no harm in having an skb with pp_recycle =3D 1 and no
> page pool pages attached.

I don't see it causing an error right now either. But it affects
skb_try_coalesce in a negative way from a performance perspective -
from->pp_recycle can be falsely true leading to a coalescing failure
in "(from->pp_recycle && skb_cloned(from))" test, which otherwise
would let the coalesce continue if from->pp_recycle was false. I
wonder if that justifies the need for a fix.

Thanks,
Liang


>
> I vote not to apply this.

