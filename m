Return-Path: <netdev+bounces-40116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E259A7C5D3D
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA17282AF7
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091213A29A;
	Wed, 11 Oct 2023 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Znfct9J5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED963A290
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 18:57:35 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87559D
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 11:57:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso2136a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697050652; x=1697655452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxkPm2B1OBi9iYXN9MuYvqMChLrgNkYVTRTGG0T2fWU=;
        b=Znfct9J5uEgMZVS1t6P08/oENe6hb2X2cUn4rUHygOG4K4hSUJyA46KYMfvuMVvnNC
         YBOg90xjmdMPkrghJIlAI1sFi3qYnzIvOAFlLJlt0SkPZIgITJf0aEdqZlk33s27PL0/
         rTu+SQsfw9ESzD7QWQ2+5kvmW63c2uUtP0j3a7r2Ght46DlR0kUS+pLaOLfxxr1DgVT7
         wPYLtGItYZiDYhtRIvID7Wq9EACmVar0wTdyCmGKI5VNywMahzf6bOBVV6tqXtj5vc5Q
         S8qW30qGBXXJn2rRFxe4jS9ZhMVHRHKerR93I0WeFeJRYsMx9fSk/rVjmwO8q2Be+3RY
         Zjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050652; x=1697655452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxkPm2B1OBi9iYXN9MuYvqMChLrgNkYVTRTGG0T2fWU=;
        b=j8FxgH0Nd479xNKi3YNqWIF4cGNoNIJSC3t9QIOJLx70F2jskWBGZkkqb9fJc3yC8a
         lTIgoeKSeoLXCuJgMVNRedLHuyuyit6/KM0RAXnE6Br38MZ+lN8Yo7ur6uiTTWe1O97n
         krdVnWIYM+v7u7hx1pDpFKbgloPeONpK6mq7VMM4KmfaWulpKy0+ld96isl6CrehH5PC
         t2WA3TQiCBeE9PaT7LssCli7LvClVlh23PTkmk4/9k/xHlDXaAxqVFBDtlUr1d/SpWlx
         bJSEgZL/soRc8ZGPhOJpEwdYavtNrgxqjU9ZkS0SUO7En2BWtRFNxPzAQ35JRg+ddy7P
         3HIw==
X-Gm-Message-State: AOJu0YzfJlm6h2yplLtHSPKoggh7iVw5GcRcbiyzC7r7vv68yzTZGLmI
	zCefFP9Gq4T5vPTM/AbclB1RA4EYIj/bx4ucQrGoUw==
X-Google-Smtp-Source: AGHT+IFc/89I7Y+6rUKwx8XNGrZ9m5vt94TlXkrFXEIM0Zdkve1IgyQhh4RAedFUg2xtXtVh8L8xDVXSIjlO7zGT0M0=
X-Received: by 2002:a50:c35c:0:b0:538:50e4:5446 with SMTP id
 q28-20020a50c35c000000b0053850e45446mr140284edb.5.1697050652003; Wed, 11 Oct
 2023 11:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1696965810-8315-1-git-send-email-haiyangz@microsoft.com>
 <20231010151404.3f7faa87@hermes.local> <CAK6E8=c576Gt=G9Wdk0gQi=2EiL_=6g1SA=mJ3HhzPCsLRk9tw@mail.gmail.com>
 <PH7PR21MB3116FC142CAECCD5D981C530CACDA@PH7PR21MB3116.namprd21.prod.outlook.com>
 <20231010191542.3688fe24@hermes.local> <PH7PR21MB311616744CBE08375C52C2B8CACCA@PH7PR21MB3116.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB311616744CBE08375C52C2B8CACCA@PH7PR21MB3116.namprd21.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Oct 2023 20:57:18 +0200
Message-ID: <CANn89i+DWa-xbBToc2-Zr2YyZ_axbeo6poyLp9t-XqGr2EzOPA@mail.gmail.com>
Subject: Re: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Yuchung Cheng <ycheng@google.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"kuniyu@amazon.com" <kuniyu@amazon.com>, "morleyd@google.com" <morleyd@google.com>, 
	"mfreemon@cloudflare.com" <mfreemon@cloudflare.com>, "mubashirq@google.com" <mubashirq@google.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "weiwan@google.com" <weiwan@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 8:49=E2=80=AFPM Haiyang Zhang <haiyangz@microsoft.c=
om> wrote:
>
>
>
> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Tuesday, October 10, 2023 10:16 PM
> > To: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Yuchung Cheng <ycheng@google.com>; linux-hyperv@vger.kernel.org;
> > netdev@vger.kernel.org; KY Srinivasan <kys@microsoft.com>;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; corbet@lwn.net; dsahern@kernel.org;
> > ncardwell@google.com; kuniyu@amazon.com; morleyd@google.com;
> > mfreemon@cloudflare.com; mubashirq@google.com; linux-
> > doc@vger.kernel.org; weiwan@google.com; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
> >
> > On Tue, 10 Oct 2023 22:59:49 +0000
> > Haiyang Zhang <haiyangz@microsoft.com> wrote:
> >
> > > > > If this an application specific optimization, it should be in a s=
ocket option
> > > > > rather than system wide via sysctl.
> > > > Initially I had a similar comment but later decided a sysctl could
> > > > still be useful if
> > > > 1) the entire host (e.g. virtual machine) is dedicated to that appl=
ication
> > > > 2) that application is difficult to change
> > >
> > > Yes, the customer actually wants a global setting. But as suggested b=
y Neal,
> > > I changed it to be per-namespace to match other TCP tunables.
> >
> > Like congestion control choice, it could be both a sysctl and a socket =
option.
> > The reason is that delayed ack is already controlled by socket options.
>
> I see. I am updating the doc and variable location for this sysctl tunabl=
e patch
> as suggested by the reviewers, and will resubmit it.
>
> I will also work on a separate patch for the setsockopt option.
>
>

I am not sure about adding a socket option, and finding room in the
socket structure.

See our recent effort reshuffling fields in tcp socket for better
performance (stalled at this time).

I would rather experiment first with a sysctl.

