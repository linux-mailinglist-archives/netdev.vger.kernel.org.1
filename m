Return-Path: <netdev+bounces-17621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D9F752605
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FF51C20D30
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBE21EA96;
	Thu, 13 Jul 2023 15:03:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D911EA94
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:03:18 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E77C1
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:03:16 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-403b622101bso283461cf.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689260595; x=1691852595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuJLwdE0omyDZos74nGK0sX1tRoAsTyEZr0R6xMfO1U=;
        b=iTSrR1NalxPbTEa1HFqZ+Etd4c4WmR8OQ5QPD8rf6wHVJBx9QuzSwiOKTUzkkgv2dV
         Fc2ziIHsaIOiJuK1h1/50K6Ootq8eLviynztis0BL3Yv/mv/SDJcf0HbzDbLrnXB5stD
         bTtIxdHXnZuMue76JMWCa4oWmOggcC1ny66AiK1uGwqxIgWW2SihNwOihqoxQS6ei8qf
         Aw2iCqdIKnCSSQx4fAUD514E95gmbO8WOCygfS6rX0uSLMikV9yddU+T2vzRfgtZzOgs
         Jlh2zQxS5PyT8r0QI9vdvx8nyXtTu7nsgFkmLQx0ctlRrUiX33oR44U3ARc5+IrCLVG3
         Ub4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260595; x=1691852595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuJLwdE0omyDZos74nGK0sX1tRoAsTyEZr0R6xMfO1U=;
        b=fkVH3LLa+zep7M1UGcOsllD4yvDsFtB6q0Mob2lM6fEptRXBcnwx+un9fTk0l72EHF
         0V8WIhA8NIxJJpK1noYFyFxb+BuQU+SG4onjgH/zqfmCJqOFjaC4RIl7MaS1cR97NMlD
         dd2c1g5P9Bx7lp7AzDqijveHyFIRqpf9RPFIfMgImD1Ep32dZ+TYURgtWchwIaoQtLG6
         MOYN5xk/hEy63TWhl2DP7/bLh4xAnTPQm9hQeors2NHZ2a3TXqikrj9EWGdXiS8DUhTH
         2hbhRG3DNNXV+r5RsA+YdzAQmzhA19NbcGdPjJyJ3egIw8ZWchIt5pwDgDvP1dYVAXnk
         Ma9Q==
X-Gm-Message-State: ABy/qLYOGr1WslzjpH+GQnT0n2CsDbxif4DSgsalcPMI1AdiT1WwJjw0
	hzCgxhxu9LKsQ4D97lzVL4NeEl93jAa4LmPbhVCggOYww5WJmrTeNFnCSQ==
X-Google-Smtp-Source: APBJJlFhrqnjfPFaeQ13tWskAQuksLJp+haykei12hsF7nX+htc93VrZWggIDXE4gjwOg97ojoDlnZpSTdXvao5923M=
X-Received: by 2002:a05:622a:307:b0:403:b1e5:bcae with SMTP id
 q7-20020a05622a030700b00403b1e5bcaemr582094qtw.10.1689260595093; Thu, 13 Jul
 2023 08:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230712135520.743211-1-maze@google.com> <ca044aea-e9ee-788c-f06d-5f148382452d@kernel.org>
In-Reply-To: <ca044aea-e9ee-788c-f06d-5f148382452d@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 13 Jul 2023 17:03:04 +0200
Message-ID: <CANP3RGeR8oKQ=JfRWofb47zt9YF3FRqtemjg63C_Mn4i8R79Dg@mail.gmail.com>
Subject: Re: [PATCH net] ipv6 addrconf: fix bug where deleting a mngtmpaddr
 can create a new temporary address
To: David Ahern <dsahern@kernel.org>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 4:59=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 7/12/23 7:55 AM, Maciej =C5=BBenczykowski wrote:
> > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > index e5213e598a04..94cec2075eee 100644
> > --- a/net/ipv6/addrconf.c
> > +++ b/net/ipv6/addrconf.c
> > @@ -2561,12 +2561,18 @@ static void manage_tempaddrs(struct inet6_dev *=
idev,
> >                       ipv6_ifa_notify(0, ift);
> >       }
> >
> > -     if ((create || list_empty(&idev->tempaddr_list)) &&
> > -         idev->cnf.use_tempaddr > 0) {
> > +     /* Also create a temporary address if it's enabled but no tempora=
ry
> > +      * address currently exists.
> > +      * However, we get called with valid_lft =3D=3D 0, prefered_lft =
=3D=3D 0, create =3D=3D false
> > +      * as part of cleanup (ie. deleting the mngtmpaddr).
> > +      * We don't want that to result in creating a new temporary ip ad=
dress.
> > +      */
> > +     if (list_empty(&idev->tempaddr_list) && (valid_lft || prefered_lf=
t))
> > +             create =3D true;
>
> I am not so sure about this part. manage_tempaddrs has 4 callers --
> autoconf (prefix receive), address add, address modify and address
> delete. Seems like all of them have 'create' set properly when an
> address is wanted in which case maybe the answer here is don't let empty
> address list override `create`.

I did consider that and I couldn't quite convince myself that simply
removing "|| list_empty()" from the if statement is necessarily correct
(thus I went with the more obviously correct change).

Are you convinced dropping the || list_empty would work?
I assume it's there for some reason...

