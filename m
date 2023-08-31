Return-Path: <netdev+bounces-31649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD1178F420
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 22:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6771C20AF9
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 20:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F0F19BD2;
	Thu, 31 Aug 2023 20:35:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C461B8F57
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 20:35:06 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755001B1
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:35:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99cce6f7de2so149329066b.3
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693514101; x=1694118901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aWePRdbXzBpRT6QRQ1CHpCsys7WhYwP5Qvoi+71DC8=;
        b=jKpPkWgO8vIqrT2TFEKg8GrnekwoWfTROsKFR3AFuuoQKSwkiWBTm2a1o/T3xg5Pbt
         jk8H7MOKNdo2t3t2EqtwmiTPyzzaio1DGB7To1bg2hoHnhNVmdxNPVFU0nJpLl6+15kY
         64asK/nr0+v/x7aIOf8kTWAhBaDI1CpqdXwytmvQbbsel2deSuJY9tZvc0o0frfaQrXo
         xtK8geJ39sHkt4m0DSmbsbeLd0vTX50cHyy3pStHxi5IribOiwKviruxNDPuh4qrKl3b
         qjgun874Zboh42CM/ohpckWm/glEKBEHEe5iHE03cdEMCXaGgXvb2KhxpUQxNm4wUqKA
         NKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693514101; x=1694118901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aWePRdbXzBpRT6QRQ1CHpCsys7WhYwP5Qvoi+71DC8=;
        b=htz0kHo8Ln/NxuTkOeAA3B43dc+bV9sdPXata276j40dOJ1ZI1QOh3g1mTDg83qxek
         3MXBoMsoX0g8B8/keLiMUgBBEYfov2fDq2gwvnoOM595EyR7BUNCWIUsujNz3h/+creE
         gX/SNk7SHHITjBxLJXpIX2+mkLlYo9yQ+ODtIgDKkBzra1ADVsfUc2FkI53s3mGCcLC/
         wJ33TRVk7VqymWscX7UAp7KTzEVREqrliJpxVEcqBK4+MUO2HhyHoAwey/KBEuS2HheP
         5fmgkyeD8Cfts15F/+GDVS4C7kAad/olmFDeojHttDgn+v8xShSXFBm11kBPtvHo/BEq
         jqBg==
X-Gm-Message-State: AOJu0YxPKCGCFJIZCTunc6h0shgSCcMdae3YhCKNrXZhaoG9XhuD3caA
	RElNJZr8WE1h2j0d76payuc03+/z6OkYQXy29vsat/ckJvlq+gLYQ1d2eg==
X-Google-Smtp-Source: AGHT+IHup9hoQwkLNGGktO82ukgCAO5UZGpGqbhLIz1xZwq30feUF6eGalwUSHAueY7o8QMRcLSQ7l62CB+k/miuixs=
X-Received: by 2002:a17:907:78d9:b0:9a1:e994:3440 with SMTP id
 kv25-20020a17090778d900b009a1e9943440mr315092ejc.4.1693514100852; Thu, 31 Aug
 2023 13:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADKFtnSPTQGLxfpn38cfwTPk=JY-=Ywne2DFoRkq03m-eKo17Q@mail.gmail.com>
 <7702c74e-482f-cd89-1d12-fb6869bd53f2@iogearbox.net> <2023083123-musky-exterior-5fa5@gregkh>
 <CADKFtnRw=9F7Epa2T1N_2Zeu4sj+YySuvVb-PTOdfiAF9g4cPA@mail.gmail.com> <2023083113-unwed-chalice-c8d6@gregkh>
In-Reply-To: <2023083113-unwed-chalice-c8d6@gregkh>
From: Jordan Rife <jrife@google.com>
Date: Thu, 31 Aug 2023 13:34:49 -0700
Message-ID: <CADKFtnQpD_LKDMZM8qoJF94m40+cP46--eqjhuu0LV8RobmsoQ@mail.gmail.com>
Subject: Re: Stable Backport: net: Avoid address overwrite in kernel_connect
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Oops, my mistake. Sorry for the mixup! In that case, I will

> send an email to stable@vger.kernel.org containing the subject of the pat=
ch, the commit ID, why you think it should be applied, and what kernel vers=
ion you wish it to be applied to.

as option 2 suggests.

-Jordan

On Thu, Aug 31, 2023 at 1:26=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Aug 31, 2023 at 01:09:04PM -0700, Jordan Rife wrote:
> > Greg,
> >
> > Sorry if I've misunderstood. The netdev FAQ
> > (https://www.kernel.org/doc/html/v5.7/networking/netdev-FAQ.html#q-i-se=
e-a-network-patch-and-i-think-it-should-be-backported-to-stable)
> > seemed to indicate that I should send network backport requests to
> > netdev.
>
> 5.7 is a very old kernel version, please use the documentation from the
> latest kernel version.
>
> You can use "latest" instead of "v5.7" there.
>
> > I saw "option 2" in
> > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > which reads
> >
> > > send an email to stable@vger.kernel.org containing the subject of the=
 patch, the commit ID, why you think it should be applied, and what kernel =
version you wish it to be applied to.
> >
> > Would "option 3" listed there be preferred?
>
> What's wrong with option 2?
>
> thanks,
>
> greg k-h

