Return-Path: <netdev+bounces-16055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36B974B2E4
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 16:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45A11C20FA7
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 14:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6265D311;
	Fri,  7 Jul 2023 14:15:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B1D2EB
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 14:15:17 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCA219B2
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 07:15:07 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-401f4408955so234621cf.1
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 07:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688739306; x=1691331306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMc4NAgWarwTrQqbWQNJfKreDOIBa3Jzrkw+D5ZeiKc=;
        b=bKMc7ATyO3EA39lyk1SAgreadVeJpQSjxuve7oNPZ90IhcvuZFHyc2oK3dX5eiTuzZ
         Kg4DyTtAGwrrN09DJQggc1c+t7i+ViIhtyjl/H+Nuubt4KOoRLhSThEx6iKtGBYgPZOA
         yHTu+xZBPKhIPmZDjpUpLP/Ty23gxzUgSFvKQGJXZSnK+dv6QWeP8Yx2BhwJ417CDY1/
         1Z7JY/enynvF4NuUIBsDCNcGHbc/GgZ8lYQ7yR/EiaWfjm1qvQK0weyE/MfcLpBU3b7G
         v1Fs2FgzVBeU0YFBl6wn+j1COz2xtDXLUGejBQ5UB9+JcAGXfCDVqygRL/eW0PKiIS+R
         tyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688739306; x=1691331306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMc4NAgWarwTrQqbWQNJfKreDOIBa3Jzrkw+D5ZeiKc=;
        b=TuS6PNZsw/HxZoQQut+Cco8pHqEj8AXOhNp6S1OSTHKo+szCZh/BWTPmscpGULHpGf
         nIcUFbcGuboycuYC4m84CxxNuECLMtunqIy9E2E8a97fsBARcn3720TsrHzfaNHdDo26
         dPJ706fbI8Q2IJq2Md+h7OvFY1+6NUZ3l1O537i9ofKqMxbVelfO786HKBIkuy2AI1ha
         EWErCQPabgXQSXOLsrbW0i4Nda3Ldjlj85F/7+a8JKYwOkQGGuvkg5ZbDu5rwsl+LNXz
         pZQHU2iHYLjhGPuWc9xfQL6UdlZTd96EaSNXPb10okX6Hy3pxCBQA0O22f+NWcAFWuca
         yXRA==
X-Gm-Message-State: ABy/qLYRdu89K9NEqwz0Xw9H7t2Gygaylbr9A1vlJOjrJZV9G1yVViGn
	bDuD5ZIk+MohH533K4GrN4vTVMgs5LgShmoyyNjjHw==
X-Google-Smtp-Source: APBJJlFQTKxXmiriOsz0IFQV0Wy7mQv9GOocaSeU3zxM+twA9egCiyk3uGmxLIhjFZXnqgsXjk+cqglAYTDEICBFSwk=
X-Received: by 2002:ac8:5acd:0:b0:3f7:ff4a:eae5 with SMTP id
 d13-20020ac85acd000000b003f7ff4aeae5mr222546qtd.12.1688739306485; Fri, 07 Jul
 2023 07:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ecbccca7b88acfd07164623c40f93cf0842645d3.1688716558.git.pabeni@redhat.com>
In-Reply-To: <ecbccca7b88acfd07164623c40f93cf0842645d3.1688716558.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Jul 2023 16:14:55 +0200
Message-ID: <CANn89iJF-=OktdVJ15NhV9QnvU+8t4gNiCRydj28tJAa0d1Q8Q@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent skb corruption on frag list segmentation
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Ian Kumlien <ian.kumlien@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 10:11=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Ian reported several skb corruptions triggered by rx-gro-list,
> collecting different oops alike:
>
> Reported-by: Ian Kumlien <ian.kumlien@gmail.com>
> Tested-by: Ian Kumlien <ian.kumlien@gmail.com>
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

