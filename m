Return-Path: <netdev+bounces-46272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE08A7E2FE3
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 23:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03781C208C2
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 22:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E264DF51;
	Mon,  6 Nov 2023 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEAWP4pi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D42FE0B
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 22:34:29 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491DCD71
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 14:34:28 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da3dd6a72a7so5819671276.0
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 14:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699310067; x=1699914867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zv4RhvnOMGMg3eq9ITCzr1fXI0OmuHMDkPX1MRaWOUU=;
        b=AEAWP4pigd41zdBt1hBIUie5sLlAIM4ueJ0NGxsLXsOIxP2p4z0CasI4hWr8TTAy+f
         TE8Q8TELXMmsMG0/4IZhOQvLbUKScbQ0mYfluhOjFdSRIybwPkGCSfgr0jwgpfxzC5Lv
         As2b06TOL63ltUGXrOKwNTPGgm+ATwXzhbfvzN7CG2yAuAsSn2Lhz1SKBxy3wiuYWhUf
         thuXg7SE1KdbcY8bN2ClER6N44owNc2MTNmtZIkbISSjHCmfeIh8QK2enP9VZzrhizpi
         UHKZk5YLrExrejpD2TxqnsUw/TfapD6JP040TC59mLlw2teH/GaWyPbtml/+VsnUenf0
         8Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699310067; x=1699914867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zv4RhvnOMGMg3eq9ITCzr1fXI0OmuHMDkPX1MRaWOUU=;
        b=XrOk+JUMv3OHOoEicvOhEvZTBslwl+RuQxz+oEauwZ+oHc/gIOWN8sARrLmUTPK+3N
         +RYQ7qAWkCa5km7+MaVvuVwYeDebcpGZSjnekdvZ8+F05F2uNwlAgUmNRXW/g9ODTqQs
         SrtI9h5IHtOiuUtwJWO2EsXxH3VaGLtxKFSJ5kC76UgpEonhW26jjFiIupqcQk8cH3IQ
         w380qo87LBmFfRCT/GtpCshC9vbxIceRl4l0ExxL4BQD4KI5JH3SwAqOCCzMrHq9O3g0
         TEQxpuoRaVM5fy30SH12RJluXPkUVTtuxEbn4iMhe6Ue5wC89Sg9cZXd8khqtNtI43vy
         vdBQ==
X-Gm-Message-State: AOJu0Yy4KM3VUKFnydKo9NmOLK/iU7jKKVg7G3ZGmZNZV2RySXo3NY9j
	95JtSBc5xok2oxZj29Q3egyTv7Q=
X-Google-Smtp-Source: AGHT+IG3dN7sVGEmAqpGExbdQBclQaMGObFV5Ff7qDqy+XlnkEORRSYhm4pZMVboGPR/chlEPa5JMbg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1083:b0:da0:567d:f819 with SMTP id
 v3-20020a056902108300b00da0567df819mr727054ybu.10.1699310067541; Mon, 06 Nov
 2023 14:34:27 -0800 (PST)
Date: Mon, 6 Nov 2023 14:34:25 -0800
In-Reply-To: <CAF=yD-+MFpO5Hdqn+Q9X54SBpgcBeJvKTRD53X2oM4s8uVqnAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-11-almasrymina@google.com> <ZUk0FGuJ28s1d9OX@google.com>
 <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com> <CAF=yD-+MFpO5Hdqn+Q9X54SBpgcBeJvKTRD53X2oM4s8uVqnAQ@mail.gmail.com>
Message-ID: <ZUlp8XutSAScKs_0@google.com>
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
From: Stanislav Fomichev <sdf@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="utf-8"

On 11/06, Willem de Bruijn wrote:
> > > IMHO, we need a better UAPI to receive the tokens and give them back to
> > > the kernel. CMSG + setsockopt(SO_DEVMEM_DONTNEED) get the job done,
> > > but look dated and hacky :-(
> > >
> > > We should either do some kind of user/kernel shared memory queue to
> > > receive/return the tokens (similar to what Jonathan was doing in his
> > > proposal?)
> >
> > I'll take a look at Jonathan's proposal, sorry, I'm not immediately
> > familiar but I wanted to respond :-) But is the suggestion here to
> > build a new kernel-user communication channel primitive for the
> > purpose of passing the information in the devmem cmsg? IMHO that seems
> > like an overkill. Why add 100-200 lines of code to the kernel to add
> > something that can already be done with existing primitives? I don't
> > see anything concretely wrong with cmsg & setsockopt approach, and if
> > we switch to something I'd prefer to switch to an existing primitive
> > for simplicity?
> >
> > The only other existing primitive to pass data outside of the linear
> > buffer is the MSG_ERRQUEUE that is used for zerocopy. Is that
> > preferred? Any other suggestions or existing primitives I'm not aware
> > of?
> >
> > > or bite the bullet and switch to io_uring.
> > >
> >
> > IMO io_uring & socket support are orthogonal, and one doesn't preclude
> > the other. As you know we like to use sockets and I believe there are
> > issues with io_uring adoption at Google that I'm not familiar with
> > (and could be wrong). I'm interested in exploring io_uring support as
> > a follow up but I think David Wei will be interested in io_uring
> > support as well anyway.
> 
> I also disagree that we need to replace a standard socket interface
> with something "faster", in quotes.
> 
> This interface is not the bottleneck to the target workload.
> 
> Replacing the synchronous sockets interface with something more
> performant for workloads where it is, is an orthogonal challenge.
> However we do that, I think that traditional sockets should continue
> to be supported.
> 
> The feature may already even work with io_uring, as both recvmsg with
> cmsg and setsockopt have io_uring support now.

I'm not really concerned with faster. I would prefer something cleaner :-)

Or maybe we should just have it documented. With some kind of path
towards beautiful world where we can create dynamic queues..

