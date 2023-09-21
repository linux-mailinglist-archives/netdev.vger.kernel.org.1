Return-Path: <netdev+bounces-35595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA187A9E22
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670C9B20C67
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8385182CC;
	Thu, 21 Sep 2023 19:56:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A861805D
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:56:35 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F83C5BB0
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:56:33 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41761e9181eso3391cf.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695326192; x=1695930992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikz2a4N7UFzKRwtkzQFTTgRBMnXjiDyuZ2j1nEVvN04=;
        b=qRqpxQ92QxL052ACclCyturK4JBotWGLpZzLDBtAsY1Zh0tQbFhSb8l5wRo0K7AMQ2
         2BXHLQ63/C2BsUzCxRxpdOi/YPPAVP/wvhCfOdaPSR5ybh3iGGCLz+LVh7pXYICdSnCX
         I3DasgmGLZYA6QEIdgKwTYB5+de0dr3lC/3He3kwXroSQOQ61HSA+K1LSgB/neVJg8lO
         qYLutOTfIGiZzgFiCoha5PvgdV4A6jqSZ+No59vBDFxdXYFDjn3/9VWRhvD8bkVXlh2J
         8qgKFbZ8VTwdZ2UPzWtueTgpf/fH33Z2g4RG288nzydYcfnvPTG8qqgxrRkU4iaOZEl7
         BQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695326192; x=1695930992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikz2a4N7UFzKRwtkzQFTTgRBMnXjiDyuZ2j1nEVvN04=;
        b=pJ3DiVwJ+76OK3sBq4fncVQ0RETHI93r64JGaMenpMQQZQqhvsYaKRfCFuwybECumH
         zKeIWzUNL5ijAAacN/bwnnKO1ZFwkhJ6+4udfKYPGs63XDTgkzHHIPzjm4xZXLf4DI2l
         V4TR7IPz4KOXt0hZDiAYBqss4s/yel8v2vk81aq6NnP6Y6ACTg/HUku/hn+aCb1V4K5G
         MU67uW4z9HCyvVwb3K0tmQ1Nb0c9bZKePLTNl2HNtV0bqKjPN9We2BVlSkbD04j7lSaB
         zoj/oTg0/KzeaJxH9LnMCZ+XgYIHtIdNfZqgzltHvfyTREhkyfEqdEV3bFgzowiCYdSK
         ZWCw==
X-Gm-Message-State: AOJu0YzHV58ylftExFqn74BoXzok25kFymTPfMgypMY7zqUHwUP3NH8M
	JpXfXT4uQVVcgLjgNpE8l8btWzPrDqUYAK7K9CrB2A==
X-Google-Smtp-Source: AGHT+IFLDgkTFR2oj15zWX13oxgiotdHdt94RLVPz8ag0+nX/g2oqhVrGRGjlTMHLMWz0B9i3by6UkOxpe7JzHTD3B0=
X-Received: by 2002:ac8:5b4a:0:b0:410:a4cb:9045 with SMTP id
 n10-20020ac85b4a000000b00410a4cb9045mr8338qtw.18.1695326192082; Thu, 21 Sep
 2023 12:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921092713.1488792-1-edumazet@google.com> <121d8e5b-1471-6252-219b-6ec4abf872f0@kernel.org>
In-Reply-To: <121d8e5b-1471-6252-219b-6ec4abf872f0@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Sep 2023 21:56:20 +0200
Message-ID: <CANn89iL0qUDk8j02zdMFVxof+a4kxFAdxDSe42Gmx405=V4=fA@mail.gmail.com>
Subject: Re: [PATCH net] neighbour: fix data-races around n->output
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 9:38=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 9/21/23 3:27 AM, Eric Dumazet wrote:
> > n->output field can be read locklessly, while a writer
> > might change the pointer concurrently.
> >
> > Add missing annotations to prevent load-store tearing.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/net/neighbour.h         |  2 +-
> >  net/bridge/br_netfilter_hooks.c |  2 +-
> >  net/core/neighbour.c            | 10 +++++-----
> >  3 files changed, 7 insertions(+), 7 deletions(-)
> >
>
> Reviewed-by: David Ahern <dsahern@kernel.org>
>
>
> WRITE_ONCE is needed for net/atm/clip.c

Like other constructors (ipv4, ipv6), clip_constructor() is called on
a not yet published object,
no particular burier is needed.

Thanks.

