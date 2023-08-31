Return-Path: <netdev+bounces-31644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF7978F3C1
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 22:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6624C1C2092E
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF75119BC9;
	Thu, 31 Aug 2023 20:09:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FEE8F57
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 20:09:19 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CCCE5B
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:09:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bf3f59905so146563366b.3
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693512556; x=1694117356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSnFsfKZ+qRGWBghbpO4seWCjNhkGf4D7rTMG5RrZBk=;
        b=1stgM6rPyQvgvm+FLW1BNSfU1tUL24kgok598aL+m4s6DLQeOU0jheCQAUL9AewoIl
         CMmn+nbwG0/NgYZtBe167Sq8oij8lLYhHKnPCHKyLIwj8qFm8SFbALXNmtyOpc/WkgMo
         p/1DAe5WH4HH4T3UC2ok7NLolJVGPZBiWpBQHxWMxhiQ9oyJ0vOA6jmaQG0pxsfJjuWs
         nYTepqLDUMbaMzWFV4kHB6dku090A2RS4fjhFSydHGmYOpi0ZNwAIU5TFRzCvOgk66X3
         44IDErlXpLVI3dRBI50LyrsHmrDCQInOvCNeVMkhQ8AQEUBREh3dCtefGhny/6bwAF1K
         /4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693512556; x=1694117356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSnFsfKZ+qRGWBghbpO4seWCjNhkGf4D7rTMG5RrZBk=;
        b=eB36UvYeoFYuAPaa8RY/DzNHei7v72b9vLSXn2MCiQ7sNzIYJaQAQ9qMpB8QcUP1lD
         mCMmqEBtL3xnIBDZhhoXe2nxEFWwukNT6xYUQ78Ic8+SUJQ+/S5KMAa225wc2b//f/o9
         uRbJSC0LaNJGJcFH9QfC2e6PuuLKSLmmi71bQafV4JP4jOtDaPesrG16nDqYSEzOGdVX
         GFrQYeT3N2k/TuFDZel3pD+ucerqsnadqfv4VSWgY8lRs/vcxh57BhQvFvH2lW4KbFsA
         qdCrY6SIzQ93SO1iJe32sffBfrTefFC67Jey4FDgmek1Zq4yLCWjNVos53ItFumZWw5W
         kPaA==
X-Gm-Message-State: AOJu0YwOZ1d6kgsjg5MHPSzaSiieYjVfQiiA16je4rSlPuGdQ6cedrpO
	lJ5X74Vh/PkwkK3gk93x871hi6Hc4KB8DjRAAmetIU1bHKepzb80W/SpSQ==
X-Google-Smtp-Source: AGHT+IFa3tIDiNrzVmbiuK8i9QUH1Rj6uCMlqGQED3STrq2/hhZsklTJgnea0YFVHmTQi3Pa0xiGljpUOH9E90C/9RQ=
X-Received: by 2002:a17:906:225c:b0:9a1:bb8f:17d0 with SMTP id
 28-20020a170906225c00b009a1bb8f17d0mr285925ejr.30.1693512556265; Thu, 31 Aug
 2023 13:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADKFtnSPTQGLxfpn38cfwTPk=JY-=Ywne2DFoRkq03m-eKo17Q@mail.gmail.com>
 <7702c74e-482f-cd89-1d12-fb6869bd53f2@iogearbox.net> <2023083123-musky-exterior-5fa5@gregkh>
In-Reply-To: <2023083123-musky-exterior-5fa5@gregkh>
From: Jordan Rife <jrife@google.com>
Date: Thu, 31 Aug 2023 13:09:04 -0700
Message-ID: <CADKFtnRw=9F7Epa2T1N_2Zeu4sj+YySuvVb-PTOdfiAF9g4cPA@mail.gmail.com>
Subject: Re: Stable Backport: net: Avoid address overwrite in kernel_connect
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Greg,

Sorry if I've misunderstood. The netdev FAQ
(https://www.kernel.org/doc/html/v5.7/networking/netdev-FAQ.html#q-i-see-a-=
network-patch-and-i-think-it-should-be-backported-to-stable)
seemed to indicate that I should send network backport requests to
netdev. I saw "option 2" in
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
which reads

> send an email to stable@vger.kernel.org containing the subject of the pat=
ch, the commit ID, why you think it should be applied, and what kernel vers=
ion you wish it to be applied to.

Would "option 3" listed there be preferred?

-Jordan

On Thu, Aug 31, 2023 at 12:47=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Aug 31, 2023 at 09:26:31PM +0200, Daniel Borkmann wrote:
> > [ Adding Greg to Cc ]
> >
> > On 8/31/23 8:47 PM, Jordan Rife wrote:
> > > Upstream Commit ID: 0bdf399342c5acbd817c9098b6c7ed21f1974312
> > > Patchwork Link:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/c=
ommit/?id=3D0bdf399342c5
> > > Requested Kernel Versions: 4.19, 5.4, 5.10, 5.15, 6.1, 6.4, 6.5
> > >
> > > This patch addresses an incompatibility between eBPF connect4/connect=
6
> > > programs and kernel space clients such as NFS. At present, the issue
> > > this patch fixes is a blocker for users that want to combine NFS with
> > > Cilium. The fix has been applied upstream but the same bug exists wit=
h
> > > older kernels.
>
> Jordan:
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>
> </formletter>

