Return-Path: <netdev+bounces-38946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3F77BD24E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 05:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67921C201EE
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 03:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915928F62;
	Mon,  9 Oct 2023 03:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="guJ4xc+v"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B818F45
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 03:08:06 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F5CAC
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 20:08:04 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59c215f2f4aso49536347b3.1
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 20:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696820883; x=1697425683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwEfqH+ZZi38DlbQatjn6Imup0zBT+HV0s2je2cotj4=;
        b=guJ4xc+v97u5hxqri15r7K9RuSPj9kLAj5qEJd0GtqMTUBbbgvFDuHzha4NUGfOgAy
         fJ126uYiLhZfPt24zlxh5IyDpNd1bHrnFpDMbQztuYq/wrJPTE8pg+OWqFZa1SvuKx5k
         xN4gGp7Jw8buwmR/ZQ+Hr2unrRWXV5FC0WzSxyLEHj56mtYwtvrZk/8ECCxms/wUbKit
         53Cy3tGrwgwNYj7uj2jYKI+6qS+kmwna8MH2yLmmLbirXxWxHre5e+xqVBzRXEbt6TIU
         zDDuF55VTngIxVSHDYIiSOhXm9QjVi2C4tDiaMfUYLD31N5EYKFBlJ6bUfkmBexZlYab
         TwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696820883; x=1697425683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwEfqH+ZZi38DlbQatjn6Imup0zBT+HV0s2je2cotj4=;
        b=sn/CxGp6xi+LLEOMsHaesURgxLjlIAqwJsCPG3FJg1nHCBcUiXSDnNMkm9mH6NXIlM
         cXUMD4l2E7bmmHiIf5W6UGo704s5EoPrczhw6cRvzTvHoW6cRdxnNSyaPl4TkjhLFq0c
         1BMSotdzvekiy1Hqshwp4zc6yiivChnLbQpirxojBHr/PnUl1lOPeUtGQubAYOqCR9Ba
         NdVsLIOXBfaHdvKi1cDZ8EKYe5H8oUr8lNTcyrN9FwHrvMc9ByOGosBgUaWkvhg2iatC
         0ADti+ZynHk9kgrgIQ7YG6LHf2ols/fgw/GnwPp6dBzaXwSDPncqoZK1y+9RaOW4xhdU
         6NeQ==
X-Gm-Message-State: AOJu0YyXUO4zYuQa8hZN51XdqNosYnGMZt813SqdX9m0LQwrZh3rM2eE
	D6Bm0t5/8dMPi2OOnWAlnN334756CsH0+7m9U4SSwWppztTbcLZorM8U1w==
X-Google-Smtp-Source: AGHT+IFhJHDhUJUa0yrILzA2GI50GNAuaWSoHcFPn8hoImr1HHqbjqjpz+BvpPupQ6A/u01QD+ryyn22roXIK1UYHPM=
X-Received: by 2002:a05:690c:dd2:b0:5a4:f7d3:394e with SMTP id
 db18-20020a05690c0dd200b005a4f7d3394emr19334241ywb.14.1696820883736; Sun, 08
 Oct 2023 20:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALNs47sdj2onJS3wFUVoONYL_nEgT+PTLTVuMLcmE6W6JgZAXA@mail.gmail.com>
 <7edb5c43-f17b-4352-8c93-ae5bb9a54412@lunn.ch> <CALNs47ujBcwHG+sgeH3m7gvkW6JKWtD0ZS66ujmswLODuExJhg@mail.gmail.com>
 <20231008.232827.1538387095628135783.fujita.tomonori@gmail.com>
In-Reply-To: <20231008.232827.1538387095628135783.fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 8 Oct 2023 23:07:51 -0400
Message-ID: <CALNs47v7rVp2jFGBuG_UBEpTTfp6aKOts4A1hBP0rohw5=q_QA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: andrew@lunn.ch, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 8, 2023 at 10:28=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
> > Fujita - since this doesn't get exposed, could this be pub(crate)?)
>
> Device? I don't think so. If we make Device pub(crate), we need to
> make trait Driver pub(crate) too.

Not `Device`, just `pub fn from_raw`. I think it is fine as-is (I see
you sent a new version)

> > Fujita, I think we started doing comments when we know that
> > lossy/bitwise `as` casts are correct. Maybe just leave the code as-is
> > but add
> >
> >     // CAST: the C side verifies devnum < 32
>
> Ok. As I commented on the RFC reviewing, I don't think that we
> need try_from conversion for values from PHYLIB. Implementing bindings
> for untrusted stuff doesn't make sense.
>
> https://lore.kernel.org/all/20230926.101928.767176570707357116.fujita.tom=
onori@gmail.com/
>
> On the other hand, I think that it might worth to use try_from for
> set_speed() because its about the bindings and Rust PHY drivers.
> However, I leave it alone since likely setting a wrong value doesn't
> break anything.

Agreed, thanks for the followup

