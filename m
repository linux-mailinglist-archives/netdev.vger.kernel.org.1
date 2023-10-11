Return-Path: <netdev+bounces-40080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145E17C5A3A
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 19:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C111C20C2D
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 17:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE55A41;
	Wed, 11 Oct 2023 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zwv78Tgh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8127439938
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 17:27:49 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C479D
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 10:27:45 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9a516b015cso49379276.2
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697045265; x=1697650065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux9l0w8MwnLT0igWhr7JaIiHQtbfOgsc08xSinU3ZPo=;
        b=zwv78Tgh1+jyOCA7IjpgSzWo28Vb32DC5uCOb3xX42u7MAahzPSBvKIeGUHT94i6WO
         xyFHgmDYHf9WsJCx7vArqxNR5PIUDbCTtLack+xiEEJ+I3oNv+HhpzpZ42o1ucMJuT4O
         d6En98q9xkI5PcJSW+slO8vWniyWKaD51TPn5lXldfUuPSH6Bs2jQfteVbgznqJn3JDF
         EmVoXRNDC2gWOMBDSiTKjd0EhTrPxqnR9wiV7auvuKfVtJs1Sv0wgxTa1DGYpjW6bOgT
         KUveSZBQxVXfBe0OfxEMx4LWoiYL4l/JO+izqmPTgLsoJyCWIn/BLe9MSJMEoMiZ9fFd
         YQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697045265; x=1697650065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ux9l0w8MwnLT0igWhr7JaIiHQtbfOgsc08xSinU3ZPo=;
        b=LF77I7WtF2Dk7NMMe7z75pjBvqGdN1oLVoKlh5dEs6iddJJmcQT/Mwwo27citZuY2T
         2Zv0K7x95sSEnYsdO+b4xm+kArwGcIJV7FVpR2k3r1DgGz563sH3aOZ2vKK58msdTxaY
         oyKUM9OZnd4ltG5d7/leHLrG2Bt7/ou+wZI2FVZ20p8QpRrHP6Ztnkq7Du2KEw0PAZNu
         kurfmuY/jzWBj0Cvxs+GA5wNSHPF6nI2vc6TbJ818QCSSNZjs+ocvFWegkZlO7vbVuTX
         h8j9u5ysGSI6ZTECZzMCmAOTXkIawsIPHxjVzf+ApiQSbxU5gQwu8sYpHgeE5l//Tpyj
         SBWw==
X-Gm-Message-State: AOJu0YxCJk/X9e60Q09gm+kC9tcDgRPr5UetE09HhrFNP8+wYEgTI9Zm
	lJ985o4XLkAn6JBIQ/1QXJj626iaVbo88R2AHdRc0g==
X-Google-Smtp-Source: AGHT+IEQBUxAGueSbmH/ftTAGlXE9A+ltpTRdTrDbTEhQBxV4DZ94J8BvpuSx30G8cixjCAWrpDqrGG06hOXwp1ztB0=
X-Received: by 2002:a25:938b:0:b0:d15:e204:a7be with SMTP id
 a11-20020a25938b000000b00d15e204a7bemr21213352ybm.8.1697045265167; Wed, 11
 Oct 2023 10:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com> <0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
 <20231009080646.60ce9920@kernel.org> <da08ba06-e24c-d2c3-b9a0-8415a83ae791@mojatatu.com>
 <20231009172849.00f4a6c5@kernel.org> <CAM0EoM=mnOdEgHPzbPxCAotoy4C54XyGiisrjwnO_raqVWPryw@mail.gmail.com>
 <20231010112647.2cd6590c@kernel.org>
In-Reply-To: <20231010112647.2cd6590c@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 11 Oct 2023 13:27:34 -0400
Message-ID: <CAM0EoMkKm4VcQB7p1abg9d-Pozz7fV-isexDtA1rGX+NuJEykA@mail.gmail.com>
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC requirement
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pedro Tammela <pctammela@mojatatu.com>, markovicbudimir@gmail.com, 
	Christian Theune <ct@flyingcircus.io>, stable@vger.kernel.org, netdev@vger.kernel.org, 
	Linux regressions mailing list <regressions@lists.linux.dev>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 2:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 10 Oct 2023 11:02:25 -0400 Jamal Hadi Salim wrote:
> > > > We had a UAF with a very straight forward way to trigger it.
> > >
> > > Any details?
> >
> > As in you want the sequence of commands that caused the fault posted?
> > Budimir, lets wait for Jakub's response before you do that. I have
> > those details as well of course.
>
> More - the sequence of events which leads to the UAF, and on what
> object it occurs. If there's an embargo or some such we can wait
> a little longer before discussing?
>
> I haven't looked at the code for more than a minute. If this is super
> trivial to spot let me know, I'll stare harder. Didn't seem like the
> qdisc as a whole is all that trivial.

The qdisc is non-trivial. The good news is we now know there's at
least one user for this qdisc ;->

cheers,
jamal

