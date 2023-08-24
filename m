Return-Path: <netdev+bounces-30208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E74B7866AD
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 06:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CB5281429
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 04:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39A82452F;
	Thu, 24 Aug 2023 04:27:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D22452D
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 04:27:24 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A50E66
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 21:27:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so56183391fa.0
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 21:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692851241; x=1693456041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFvAkRwVN7V/LGHTRnq7pNxW95ljpBXDVQDpM7MHO+A=;
        b=a7UlFyn+c4dvM2vTfM/pVkSETz6/qCzbJ1sYSrYUqonwZttPJuFJoDjPRZR+W9Yqe7
         LeySvKFSgkde8fADUh9EqTIzL2AtA9KeR6KwDvOOvK+nAz2XkZ3hBt+b3eu7D2qywdXF
         lxasT/W4ksY+QcC3DSiobNAqT9M0ZFsPfRjcOQJQstc6h1j6kX0Av4knx24F3+2hhPil
         RbBgA7FRjEuzA8N0Ys5MBocn/oBdOq9S3q6DWvhn4egi1pd8Gp0VmZoU81KRjMHShAN2
         sSAF7cZ6UHR7rz3aWqc2MG9g61ebsSuFZJk07gcKnppltIcNw/f+Ljs1sli8nmg9aKrj
         D8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692851241; x=1693456041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFvAkRwVN7V/LGHTRnq7pNxW95ljpBXDVQDpM7MHO+A=;
        b=hCySYsJ/7g19uE9ENvfE8bjrAJb/tOxzBDqLpu7hHDtrgi4QOPPoeSOnED0xi//T04
         /Pbwg0gPl3JjxeTe5q4brKZIgVHCcRuyozvmEPjbDuW8Iy8eFwyygsjvSlt6UyEa5+sF
         tfEzXaWmNiUh8zjdvYXsfKSiTKq2LNORQxZVxJIsif5d4aW+5MsJLHU8E8ow0oQNKxcN
         q5WNmmPxUrgaDnoiOvlezSJyK73tzfEJwQxcUdycCMwZCQEFE3/PfyFNZXDpjpQZGz3e
         Ziyx4g0GpUfmC+/uQH+B7iChea4X5eM33EH9fxtqikFng/udSLkODF1bmVsV4LcPEoXo
         rCTg==
X-Gm-Message-State: AOJu0YxkZeYui3j8WuxUJmhxiQ6b5PNIJezUV0gc2wvA5vf7SDtZeDiM
	cNfeNxqiRA3bl4SCaotRLj0tNvSv7xa/LkfNG70=
X-Google-Smtp-Source: AGHT+IEEX8kE7PF+OnEqetCQxi3KCC1S2kpEDosdAjGRJAUuzkMoSlnQdLyP0mcUyzPWaWXCRzkkgUtipjFrLIR+F3s=
X-Received: by 2002:a2e:a309:0:b0:2b5:9f54:e290 with SMTP id
 l9-20020a2ea309000000b002b59f54e290mr10773753lje.0.1692851241033; Wed, 23 Aug
 2023 21:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169272709850.1975370.16698220879817216294.stgit@firesoul>
In-Reply-To: <169272709850.1975370.16698220879817216294.stgit@firesoul>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 24 Aug 2023 12:27:08 +0800
Message-ID: <CAKhg4tL7fK=xdO6NuKqz2-DuXv=w-GFkaSbBWxtoVo-1XRJOTg@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v1 0/4] veth: reduce reallocations of SKBs
 when XDP bpf-prog is loaded
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, lorenzo@kernel.org, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, mtahhan@redhat.com, 
	huangjie.albert@bytedance.com, Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 1:59=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
> Loading an XDP bpf-prog on veth device driver results in a significant
> performance degradation (for normal unrelated traffic) due to
> veth_convert_skb_to_xdp_buff() in most cases fully reallocates an SKB and=
 copy
> data over, even when XDP prog does nothing (e.g. XDP_PASS).
>
> This patchset reduce the cases that cause reallocation.
> After patchset UDP and AF_XDP sending avoids reallocations.
>

This approach is a lot more elegant than registering two XDP memory
models and fiddling with the skb and XDP buffer. The tests conducted
in our environment show similar figures in terms of performance
improvements. For example, using pktgen (skb data buffer allocated by
kmalloc) with the following setup: pktgen -> veth1 -> veth0 (XDP_TX)
-> veth1 (XDP_PASS) gives an improvement of around 23%. Thanks!


Thanks,
Liang

> Future work will investigate TCP.
>
> ---
>
> Jesper Dangaard Brouer (4):
>       veth: use same bpf_xdp_adjust_head check as generic-XDP
>       veth: use generic-XDP functions when dealing with SKBs
>       veth: lift skb_head_is_locked restriction for SKB based XDP
>       veth: when XDP is loaded increase needed_headroom
>
>
>  drivers/net/veth.c | 86 +++++++++++++++++++---------------------------
>  net/core/dev.c     |  1 +
>  net/core/filter.c  |  1 +
>  3 files changed, 38 insertions(+), 50 deletions(-)
>
> --
> Jesper
>

