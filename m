Return-Path: <netdev+bounces-44311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021537D7876
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954F6B21176
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24330374D5;
	Wed, 25 Oct 2023 23:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIEAcZw4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51A266BC
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:19:37 +0000 (UTC)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A41E123
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 16:19:36 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-457cb7f53afso166641137.3
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 16:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698275975; x=1698880775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taICvgvneOloaENZoxU0FzQrgOATT8dr3HIW19MkbAk=;
        b=bIEAcZw4N/2krr0/6vBoRdvGpEga82SAiCiR+VnoJg7LBubl1XajkhFchiTt59RNvJ
         5mi+G7GE1aSs4nBKiEctyFAbBKmedOhfvD2TnFkp/bOoWd/GrxkvpgPcD7dcVS2p32+2
         TeN0URzHZL0i1Ji63BOW7BDyqfVTWKPUXn0jO+COl3ywFpPQmszXmYDPVwdwXKrGy26K
         AlmFEMY1jehhG3x5JonPwwVTWUA4h7KWCItirK4fFCaz04FxHn4dQA3obzH/FVcOsu+b
         rE7tkI+erOYuXcNybr/v+UEAsjj0t36Wmlz+MFX1lTsgEEVoFaR1jIr58+UumPL4fjZB
         tT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698275975; x=1698880775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taICvgvneOloaENZoxU0FzQrgOATT8dr3HIW19MkbAk=;
        b=Tttc/T7IpLkklM2yYdLIUtyFq6ONKOcAojQTb2POWVMiGKtaL3hlrduCaEUcX6dqsf
         Zc3Ekypgi0F00AK+owGLKPKK1SPwpD6Ctege+vhOJuyHOZpEu/c7zXk+gVnctSLlprxa
         1ZF6nPSy29buO2Co93mD+IHtcVyn0cl+kiqX1JWXAxA9uOY0IFYY6jwsu50ewJf3MssE
         rUguza5FBu8Mv1ZqCFHnikum5/sF2WJNCrdd6+hNhfvM2Ia/lcG74267xjPBRAW8U3xT
         OtyHKqBLtaxT0x4PxaM/dN3g/tqAoY1RqiI/cwDIieWQcVKx1qaPYl0Jo/59sRVzGdU4
         SOsw==
X-Gm-Message-State: AOJu0YxXHkUmCNyRl3g2G3m5UBwz6cOTfCS3uYGySORlefAhZSCNy8Zx
	GsZKiOtAM2Eop+sBpIYVXViobqU1LHGnzamch2/bmXIZ
X-Google-Smtp-Source: AGHT+IGtVcKOQHQfhMcknFLxOQU7bfTABNO/rma1Y+CNKCyRGzFFdy+dMunxP8C7zUn0G/Rlt7rpG0iewzfcJJJpd1g=
X-Received: by 2002:a67:c211:0:b0:457:de3b:9b32 with SMTP id
 i17-20020a67c211000000b00457de3b9b32mr15929295vsj.18.1698275975604; Wed, 25
 Oct 2023 16:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024194958.3522281-1-willemdebruijn.kernel@gmail.com>
 <20231025160119.13d0a8c2@kernel.org> <CAF=yD-JV031xfCDwb_=GG-i8+CR3OnQMCMTsMvWU0vwDtByB=w@mail.gmail.com>
 <20231025161412.340d9737@kernel.org>
In-Reply-To: <20231025161412.340d9737@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 25 Oct 2023 19:18:59 -0400
Message-ID: <CAF=yD-J15HqBrzJ_tFSS82Kp_F3sWYH3pPQb+jRL0jT-vT61cQ@mail.gmail.com>
Subject: Re: [PATCH net] llc: verify mac len before reading mac header
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, Willem de Bruijn <willemb@google.com>, 
	syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 7:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 25 Oct 2023 19:05:59 -0400 Willem de Bruijn wrote:
> > > I think this one may want 1 to indicate error, technically. No?
> >
> > Absolutely, thanks. For both tests.
>
> Both state machine callbacks (functions with names ending with 'test_r'
> in the patch), right? Perhaps 'goto out' is what's expected here.
>
> The fixup function seems to have inverse return semantics, because
> why not.

Exactly :) Extrapolating from that is where I went wrong.

