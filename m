Return-Path: <netdev+bounces-23252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE73C76B6EF
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6443C281A57
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9AE23BC0;
	Tue,  1 Aug 2023 14:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9122EED
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:11:57 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E35511D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:11:51 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40c72caec5cso328801cf.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690899110; x=1691503910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkC3KIklnTCY53hK9lBcQer2DPh4HPjr+bgJxfgI/K0=;
        b=AWiRoEuYk0UGZeHx2qpOUsfJvYvsb9ItVBq1bBfWodqv8ZtmHcSr5U4SJH+F1o5vWI
         K6iPs0qHJLgYXDC2w0OADuJPUFP1UEbCuEa7zAkE3mKud7uQly0y644nfeff9UA+hzRN
         7uUZDuGz9fvLg+w3oFRAf8MffaUovWmFq72/mIu+dU6ms+nbXasl12aGs9/XvEI5qwnU
         VSH1cgj6/KjWVNDXvD3quSoqJJNC1CERaEVyHfPr0JMOGtpjbMDtFV84czo6m4O7UCnr
         aXou7ABUttpT7pdmUHdfZX3kY+ncNENW6E2OKNfk4afkRnrmzBRadF1EUSjKYnXClAE7
         V7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899110; x=1691503910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkC3KIklnTCY53hK9lBcQer2DPh4HPjr+bgJxfgI/K0=;
        b=EKWchudQt6Xchq5m/O4u5FSofEOl/oErift38Vzj0+jkgTMxV/khstzb96HYKJOSvm
         GPxBqssZRJBMF5MpLZSjisFaSmIDXlrX1XA0qoND2H/UnFvrKUe8Zkh8AHQEk9T4vjfn
         PKLgwdMxN7gamzfODUBYi6vkAbpTrSCnbtEThFHGKspVGcLgP1M1A4w1hPFX9YfAG75L
         NBRvqBAUV6ZQ474jJ6jhaEcqArr03YwtwD+vJ0tvw32QOlcTb2ut1T8SWRjjrCQIKoEM
         oWbbK84aFqtZNZpT3b/nYwqus52arH5zcxbTH87Y7C0OhiG2qcrnrI7yu/9dXXbJprfH
         tj9A==
X-Gm-Message-State: ABy/qLYWB8kZScRm9U4Efn+XwIBEPVh/hpYOKvrmrGVSeMhFb+M0VUhq
	8Y0dqcaMQEAzzFezDhDdCXDIRMmhTnDwzFG7JeTksQ==
X-Google-Smtp-Source: APBJJlFNN7TWoySV0L3/UDLWOkPxv6mhMd0pB7EJCklr4ZYuom2VaoZTG0odAsEuSbDFFTORdXlTxd8qkchCkWNlu7Q=
X-Received: by 2002:a05:622a:15d0:b0:3f8:5b2:aef0 with SMTP id
 d16-20020a05622a15d000b003f805b2aef0mr825346qty.24.1690899110445; Tue, 01 Aug
 2023 07:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801112101.15564-1-quic_ajainp@quicinc.com>
 <447ba1fe-b20b-4ed0-97bc-4137b2ccfb37@lunn.ch> <8c591002-308e-bdba-de5f-c96113230451@quicinc.com>
In-Reply-To: <8c591002-308e-bdba-de5f-c96113230451@quicinc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Aug 2023 16:11:39 +0200
Message-ID: <CANn89iL3TTLJy0kbbxLZRyyRft66absBbh4x22KMKCag7ywOzg@mail.gmail.com>
Subject: Re: [PATCH] net: export dev_change_name function
To: Anvesh Jain P <quic_ajainp@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <simon.horman@corigine.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Andy Ren <andy.ren@getcruise.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Venkata Rao Kakani <quic_vkakani@quicinc.com>, 
	Vagdhan Kumar <quic_vagdhank@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 3:08=E2=80=AFPM Anvesh Jain P <quic_ajainp@quicinc.c=
om> wrote:
>
>
>
> On 8/1/2023 6:01 PM, Andrew Lunn wrote:
> > On Tue, Aug 01, 2023 at 04:51:01PM +0530, Anvesh Jain P wrote:
> >> export dev_change_name function to be used by other modules.
> >>
> >> Signed-off-by: Vagdhan Kumar <quic_vagdhank@quicinc.com>
> >> Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
> >
> > It would be normal to include a user of the API when exposing an API.
> >
> > What module needs to change the name of a device? At the moment, only
> > user space can do this via netlink or an IOCTL.
> >
> >       Andrew
> CONFIG_RENAME_DEVICES is the module which needs "dev_change_name" API.
> Our requirement is to change the network device name from kernel space.

We do not support out-of-tree code.

You will have to upstream this code first.

