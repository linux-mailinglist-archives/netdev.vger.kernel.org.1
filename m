Return-Path: <netdev+bounces-14810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC78B743F34
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D261C20918
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6249416437;
	Fri, 30 Jun 2023 15:51:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EBD168A3
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 15:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D8EC433D9;
	Fri, 30 Jun 2023 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688140269;
	bh=o+HQ6sKOLOmf9NJpSPsWFmx92fmjlFfWr9D3EoklLi8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jHffzW9mVEhnx1vyn2AqZf5LL+zIBS/Fs/Cilynv8kMBaoJPC/L0mO8gkSH4wa9C7
	 TzFQ6M8ouxTdZyX2eL8agbFrKVKOHxkraVuVKUg8wZMUVKEzQ6TJvZzRfTLad3abQZ
	 /EkJu5MoHfqasGxByyrNqF/w249qqWuCvlokWkPAZ64NAxx70LWWY3qyj2MnkvRSSS
	 n7cm1F2X+mKVMIhYwXA11c0RjkrAdVhShvzs4hbpz4ijrugYfSkSIArFTV8Riv2GC/
	 of8L/DUGLlrJlfnbWetYpiCIvF/9yS7p0s+6SyAptGHRbz3euuE6hc23utAsaA0s/i
	 IoDByBRQ7H5vg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so3302924e87.3;
        Fri, 30 Jun 2023 08:51:09 -0700 (PDT)
X-Gm-Message-State: ABy/qLYlpwkV1iabXoTBm7GPqhGbZWRgRXNt1O3ruzhsCm2vrTjJCC1c
	o42AZ2lvp/Gu3At9whENjnhDX4xRxZSVjQLsRl0=
X-Google-Smtp-Source: APBJJlHeM6BWV3muIjxnacs7zjjB0XKOeozxgRkAM5i8VKs9paqzZF7WBIi4waH6K6drUKfYMfm79y4EELrsxUS4wqA=
X-Received: by 2002:a05:6512:3da5:b0:4f8:6e6e:3f42 with SMTP id
 k37-20020a0565123da500b004f86e6e3f42mr4240856lfv.14.1688140267474; Fri, 30
 Jun 2023 08:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008a7ae505aef61db1@google.com> <20200911170150.GA889@sol.localdomain>
 <c16e9ab9-13e0-b911-e33a-c9ae81e93a8d@I-love.SAKURA.ne.jp>
 <CAMj1kXFqYozjJ+qPeSApESb0Cb6CUaGXBrs5LP81ERRvb3+TAw@mail.gmail.com>
 <59e1d5c0-aedb-7b5b-f37f-0c20185d7e9b@I-love.SAKURA.ne.jp>
 <CAMj1kXGHRUUFYL09Lm-mO6MfGc19rC=-7mSJ1eDTcbw7QuEkaw@mail.gmail.com>
 <CAG_fn=X+eU=-WLXASidBCHWS3L7RvtN=mx3Bj8GD9GcA=Htf2w@mail.gmail.com>
 <CAMj1kXFrsc7bsjo2i0=9AqVNSCvXEnYAukzoXeaYEH9EpNviBA@mail.gmail.com>
 <CAG_fn=VFa2yeiZmdyuVRmZYtWn6Tkox8UVrOrCv4tEec3BFYbQ@mail.gmail.com>
 <CAMj1kXEdwjN7Q8tKVxHz98zQ4EsWVSdLZ5tQaV-nXxc9hwRYjQ@mail.gmail.com>
 <CAG_fn=UWZWc+FZ_shCr+T9Y3gV9Bue-ZFHKJj78YXBq3JfnUKA@mail.gmail.com>
 <CAMj1kXE_PjQT6+A9a0Y=ZfbOr_H+umYSqHuRrM6AT_gFJxxP1w@mail.gmail.com> <20230630082733.4250175b@kernel.org>
In-Reply-To: <20230630082733.4250175b@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 30 Jun 2023 17:50:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE9a399_CiXNHMqpNk+Fz=4YPd0s-5B0gU66wYbEhiiZQ@mail.gmail.com>
Message-ID: <CAMj1kXE9a399_CiXNHMqpNk+Fz=4YPd0s-5B0gU66wYbEhiiZQ@mail.gmail.com>
Subject: Re: [PATCH] net: tls: enable __GFP_ZERO upon tls_init()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Potapenko <glider@google.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+828dfc12440b4f6f305d@syzkaller.appspotmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, Aviad Yehezkel <aviadye@nvidia.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Jun 2023 at 17:27, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 30 Jun 2023 17:16:06 +0200 Ard Biesheuvel wrote:
> > Note that this is the *input* scatterlist containing the AAD
> > (additional authenticated data) and the crypto input, and so there is
> > definitely a bug here that shouldn't be papered over by zero'ing the
> > allocation.
>
> Noob question, it's not the tag / AAD, right? We definitely don't init
> that..

assoclen + cryptlen does not cover the tag on encryption, so it would
be omitted here regardless of whether it was covered in the input
scatterlist or not.

