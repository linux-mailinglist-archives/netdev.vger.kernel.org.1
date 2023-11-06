Return-Path: <netdev+bounces-46258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D20637E2EC2
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 22:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326BB1F20F5E
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 21:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E442E642;
	Mon,  6 Nov 2023 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/waIwl8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EF62E639
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 21:15:04 +0000 (UTC)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC5AB3;
	Mon,  6 Nov 2023 13:15:03 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4ac459d7962so1005468e0c.1;
        Mon, 06 Nov 2023 13:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699305302; x=1699910102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pDNcwAtyE05sKduQb5rMgv/slyyDqYM9dQystHpAe00=;
        b=d/waIwl8ZhA+3fMGbwtKR/1HQ2FRL8sJJsPoARNUrIj8zRK8eO7BDXtgdodqgjiHLU
         unS+H7Eo+A7ubP2doo1X9VDwtqXBTb3ZE2Z826gxkVF4W0np3D84TjK0bwBUS4W6KEoL
         qBFnETI4bh8yk/HI3sm5F++bZk1MkQeh7O3+c3lcqALf1dcJTnQMH+BBcjMAcREoAYN1
         AbMnGj1EzdZssMWjcM16p5fGRn00qXcOBLFkZxFhNtlcigbicTYrEPh7n57SXkrT2+Cj
         jhacDSfXLrzR+cF+pM2dASy3gyLaxagYqaM/x+jFxgRDfvXU/TyTl5RSnksMGtFehfvY
         wK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699305302; x=1699910102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDNcwAtyE05sKduQb5rMgv/slyyDqYM9dQystHpAe00=;
        b=aX5cbGP1wCwveuRfm4tKEgwNVCIrlD5DrRm910xvVAVp5pmL5H/X5MiGc/fVpUbZl3
         ykvtYO8cH5Ez3/ejMX7SWUcIn5YKC0k/ieHa54C+lsJQfmUiDnbg1OWaJtdgFtx616KE
         PV2OTpkPfHvPA9Fm4Ht3tgTK9Qq8h55Lw/WgOvsLWh+RqXxMaBUYjYRNFhDiKQKrf7mZ
         4ZXR8CfbbQk6yNpRcFjtoLgPPPt0v23yPN9f3Az7xeObo4vsx2KwaM5fR/Oudog45rV5
         73qi2paemTaAT40Q1m4AEtCvgjvf2goD4N6vaY4GiUItT2Du18y9A+ckgy5jN3nnmk/n
         7YyA==
X-Gm-Message-State: AOJu0YySOXuUrwY9uvsMK5z2lq1ujaCi0/VA0l+EtzQP6aA1saFuim5x
	ZqR5sZlDUW213kinphNnAxKUpM/4VKuN/IWN8wQ=
X-Google-Smtp-Source: AGHT+IFSfXgdSlZ+tas3UVj7xs8CWVob5ysFpk92liyDA5WPCjjGPD1amiOzYCm06+9kKyONPbaGF06Qrr1pItVwWII=
X-Received: by 2002:a05:6122:4694:b0:49d:20fb:c899 with SMTP id
 di20-20020a056122469400b0049d20fbc899mr441320vkb.4.1699305302147; Mon, 06 Nov
 2023 13:15:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-11-almasrymina@google.com> <ZUk0FGuJ28s1d9OX@google.com>
 <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
In-Reply-To: <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 6 Nov 2023 13:14:25 -0800
Message-ID: <CAF=yD-+MFpO5Hdqn+Q9X54SBpgcBeJvKTRD53X2oM4s8uVqnAQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"

> > IMHO, we need a better UAPI to receive the tokens and give them back to
> > the kernel. CMSG + setsockopt(SO_DEVMEM_DONTNEED) get the job done,
> > but look dated and hacky :-(
> >
> > We should either do some kind of user/kernel shared memory queue to
> > receive/return the tokens (similar to what Jonathan was doing in his
> > proposal?)
>
> I'll take a look at Jonathan's proposal, sorry, I'm not immediately
> familiar but I wanted to respond :-) But is the suggestion here to
> build a new kernel-user communication channel primitive for the
> purpose of passing the information in the devmem cmsg? IMHO that seems
> like an overkill. Why add 100-200 lines of code to the kernel to add
> something that can already be done with existing primitives? I don't
> see anything concretely wrong with cmsg & setsockopt approach, and if
> we switch to something I'd prefer to switch to an existing primitive
> for simplicity?
>
> The only other existing primitive to pass data outside of the linear
> buffer is the MSG_ERRQUEUE that is used for zerocopy. Is that
> preferred? Any other suggestions or existing primitives I'm not aware
> of?
>
> > or bite the bullet and switch to io_uring.
> >
>
> IMO io_uring & socket support are orthogonal, and one doesn't preclude
> the other. As you know we like to use sockets and I believe there are
> issues with io_uring adoption at Google that I'm not familiar with
> (and could be wrong). I'm interested in exploring io_uring support as
> a follow up but I think David Wei will be interested in io_uring
> support as well anyway.

I also disagree that we need to replace a standard socket interface
with something "faster", in quotes.

This interface is not the bottleneck to the target workload.

Replacing the synchronous sockets interface with something more
performant for workloads where it is, is an orthogonal challenge.
However we do that, I think that traditional sockets should continue
to be supported.

The feature may already even work with io_uring, as both recvmsg with
cmsg and setsockopt have io_uring support now.

