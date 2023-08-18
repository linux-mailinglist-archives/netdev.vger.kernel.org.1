Return-Path: <netdev+bounces-28778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BA3780AC4
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7B11C215E2
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D492182AC;
	Fri, 18 Aug 2023 11:10:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3E11801B;
	Fri, 18 Aug 2023 11:10:20 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79463592;
	Fri, 18 Aug 2023 04:10:19 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso780169276.2;
        Fri, 18 Aug 2023 04:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692357019; x=1692961819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aqcz6+CxleF/o9TEc80m8NBOqId1CND3CqvR2adeCrk=;
        b=bcWLE7GmjLzg5FLTfyj2gS7rzmn6BlMZrKEV189s13CdDRHbeZpltWXq5ZwCq3KoJ4
         RN7Pz6FU5DPcoVurTiZE2ceRXHBZDeMCJBIkH2Snn60xXuYcGTT9H0ud3edgD2HlSeVK
         t269fS0uUu876g7EqY6jOlIv/kuCJecN5bEuRcW4fWAU5OX4TBDeIw67ci9Q2lQbEzWe
         mKeBIk2SSJgrjaLKA0z1GtngW11H6hE064EshncH5hpjTRmlkO2WMe4DDZeBPffFm2ut
         eOjuwYS/8ZsDoG/otYo2huB/FEuTl3Tsyvd7IjstBHwa9DxiVB8ZqeTmCbqQOED6L1LV
         T2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692357019; x=1692961819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aqcz6+CxleF/o9TEc80m8NBOqId1CND3CqvR2adeCrk=;
        b=H1EzKm6WVk67FICypJcTDntK9B+TaSraHoz677XlqsZvKFhfrtkcSgax1qRlbVviP8
         GKypMxm9j192rbYMdqB4MBDVsVCft603xZwAgYaewvXOdisayqc0r+9nPjmDNCs2hPRm
         +UnNK6rFjBYu93FYPj4eCBSEDjKGFTU2IzBmeDuEDKbAF6ZS9W8CKjG8pozDlBzo2R9a
         c02km6c05ybVPQ17nvHwtzqDGu3oiGST4UL/6Z3wn9vqNejili2ZHJPhSpB78qi917zO
         wUGZflIbD9nwyUUPBW7LFOW2p26ByKOVW6wNafTjI6dd8xbUNWkU8V8eP1Fj91QqcQ2z
         V8Mw==
X-Gm-Message-State: AOJu0Yy+cJllzjnYGu/s2wJwUK8LQ4Nd1MUsRAv7l14o8svZQRGPmGRN
	vvoP1rfgi9eem/CnLgKPd85bDiv9emZ5sPRbp5U=
X-Google-Smtp-Source: AGHT+IFa1lCmf93SIjjWLr4QMBNGshpVNdTOoZk81LOSK8FUfuY3igGAEIXdQX2Sl0YLblLw5xm4pbRe4oUujk7VXSY=
X-Received: by 2002:a05:6902:1890:b0:d4b:6a0:fe2b with SMTP id
 cj16-20020a056902189000b00d4b06a0fe2bmr3171716ybb.36.1692357019061; Fri, 18
 Aug 2023 04:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
 <202308170000.YqabIR9D-lkp@intel.com> <cfc29063-9e20-5101-d70b-62b5423d2d10@intel.com>
In-Reply-To: <cfc29063-9e20-5101-d70b-62b5423d2d10@intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 18 Aug 2023 13:10:07 +0200
Message-ID: <CANiq72m9ZEVkP76FMFOnPYkA8ih4Mq72HtW9AbrJ-JPy9ku3jw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack allocs
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, kernel test robot <lkp@intel.com>, 
	Yujie Liu <yujie.liu@intel.com>, Philip Li <philip.li@intel.com>, 
	Greg KH <gregkh@linuxfoundation.org>
Cc: rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Jacob Keller <jacob.e.keller@intel.com>, 
	intel-wired-lan@lists.osuosl.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 12:38=E2=80=AFPM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> Rust folks, could you please tell me if this is something I should fix,
> or I just uncovered some existing bug in "unstable" thing?
>
> Perhaps it is worth to mention, diff of v3 vs v2 is:
> move dummy implementation of __has_builtin() macro to the top of
> compiler_types.h, just before `#ifndef ASSEMBLY`

Nothing you need to worry about, it is an issue with old `bindgen` and
LLVM >=3D 16, fixed in commit 08ab786556ff ("rust: bindgen: upgrade to
0.65.1") which is in `rust-next` at the moment. Sorry about that, and
thanks for pinging us!

LKP / Yujie / Philip: since we got a few reports on this, would it be
possible to avoid LLVM >=3D 16 for Rust-enabled builds for any branch
that does not include the new `bindgen` or at least 08ab786556ff? Or,
if Greg is OK with that, I guess we could also backport the upgrade,
but perhaps it is a bit too much for stable?

Cheers,
Miguel

