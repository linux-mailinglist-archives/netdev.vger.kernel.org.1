Return-Path: <netdev+bounces-43585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F423F7D3F59
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE06B28143C
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AF31C6B2;
	Mon, 23 Oct 2023 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Skm84mHK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740A219FD
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 18:37:10 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B1CB7
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 11:37:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7cf717bacso52304697b3.1
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 11:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698086228; x=1698691028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zkp3GhU+1Us4YKcIu3p+gH7dAzVM9mIh6D4qo6L9agU=;
        b=Skm84mHKJtxgqL/lbmCI1SiCALE+x2D+ZugHobLsH1X1kx91Ndcn6KeN98Tb+tmuNO
         KCxu1ClxJdQ8KInUFgGN34SPU9dFBNSfD6UW4ou2yXureZPIwYDirz3L5JmIDn7k+S5t
         zEXnD7YMPIK9/Y4dpZZsPI5cbwX9epLKDJAViFxkuDngwc9D9QruCOAv8QHmOUblPXI8
         pvtC+7X0iEpR4geEp7aPdRZzJvT0BePQt0H1gl/gG2R4TChzGSrw3VenrBUpjZwnXan1
         85MWMpYVxmka8LXqCrM+o9kgud7zSoMf8UHrNL/oL4HsMfcrYtGSdvfAK3Ukib+D73gw
         kFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698086228; x=1698691028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkp3GhU+1Us4YKcIu3p+gH7dAzVM9mIh6D4qo6L9agU=;
        b=ugcphbhw4GJ5fa7P01L7g5376e+Sfux2XHA+WBaY8GCtuifgX2TM6+ohKaedh1ULUX
         WlIZO9gvRoJtfVTzf/F9zLn3cxZD5zbiXEr8raLxq0+kmc0tZZvsgm1eNswcCNT0C34w
         mFETRoD7w0oXvWl2GXowYLpE8kwUDhpLJ1LEYMiv7ufDdQNwoZ102M4ON6uSHUW/Qjxk
         nEm6diNI4Zyj9wZrtZbHa9CYf6e3nDD2GlTRsR4cC+g3LD0YfbiHDJo9XdkCiCCJD+vF
         lqRPp+teBtYtrgwqF3pS4k0sPjsYOaa3/AB/lKu5ZPZHxape8t7unQEmgHwNAkGfmb+B
         3xxw==
X-Gm-Message-State: AOJu0YyLid1dqGd1w5nYBFeRHuT9ZDW8BOmCJ5NyfRJWGCWhBZhkkKZG
	GTpk0jACH8j2aAcFsgdGx8Lfqd8=
X-Google-Smtp-Source: AGHT+IGkj0PdIYBXrXzXCy3R2mHIIxOsxmRO80d6JRFdAfS/cdj6zEz4Ylvc2hM6ac2JRlnEEVP3r30=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a0d:e8c6:0:b0:5a7:b575:49c3 with SMTP id
 r189-20020a0de8c6000000b005a7b57549c3mr230436ywe.4.1698086228232; Mon, 23 Oct
 2023 11:37:08 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:37:06 -0700
In-Reply-To: <CAJ8uoz3BXFWmA1imhSCZnmRp-+whrE6ge0T3QbA9gqqeb6deCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com> <20231019174944.3376335-2-sdf@google.com>
 <CAJ8uoz3BXFWmA1imhSCZnmRp-+whrE6ge0T3QbA9gqqeb6deCA@mail.gmail.com>
Message-ID: <ZTa9Us6Uq3TF_TDe@google.com>
Subject: Re: [PATCH bpf-next v4 01/11] xsk: Support tx_metadata_len
From: Stanislav Fomichev <sdf@google.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, yoong.siang.song@intel.com, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"

On 10/23, Magnus Karlsson wrote:
> On Thu, 19 Oct 2023 at 19:50, Stanislav Fomichev <sdf@google.com> wrote:
> >
> > For zerocopy mode, tx_desc->addr can point to the arbitrary offset
> 
> nit: the -> an

Thanks!
 
> > and carry some TX metadata in the headroom. For copy mode, there
> > is no way currently to populate skb metadata.
> >
> > Introduce new tx_metadata_len umem config option that indicates how many
> > bytes to treat as metadata. Metadata bytes come prior to tx_desc address
> > (same as in RX case).
> >
> > The size of the metadata has the same constraints as XDP:
> > - less than 256 bytes
> > - 4-byte aligned
> > - non-zero
> >
> > This data is not interpreted in any way right now.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/net/xdp_sock.h            |  1 +
> >  include/net/xsk_buff_pool.h       |  1 +
> >  include/uapi/linux/if_xdp.h       |  1 +
> >  net/xdp/xdp_umem.c                |  4 ++++
> >  net/xdp/xsk.c                     | 12 +++++++++++-
> >  net/xdp/xsk_buff_pool.c           |  1 +
> >  net/xdp/xsk_queue.h               | 17 ++++++++++-------
> >  tools/include/uapi/linux/if_xdp.h |  1 +
> >  8 files changed, 30 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 7dd0df2f6f8e..5ae88a00f34a 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -30,6 +30,7 @@ struct xdp_umem {
> >         struct user_struct *user;
> >         refcount_t users;
> >         u8 flags;
> > +       u8 tx_metadata_len;
> >         bool zc;
> >         struct page **pgs;
> >         int id;
> > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> > index b0bdff26fc88..1985ffaf9b0c 100644
> > --- a/include/net/xsk_buff_pool.h
> > +++ b/include/net/xsk_buff_pool.h
> > @@ -77,6 +77,7 @@ struct xsk_buff_pool {
> >         u32 chunk_size;
> >         u32 chunk_shift;
> >         u32 frame_len;
> > +       u8 tx_metadata_len; /* inherited from umem */
> >         u8 cached_need_wakeup;
> >         bool uses_need_wakeup;
> >         bool dma_need_sync;
> > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> > index 8d48863472b9..2ecf79282c26 100644
> > --- a/include/uapi/linux/if_xdp.h
> > +++ b/include/uapi/linux/if_xdp.h
> > @@ -76,6 +76,7 @@ struct xdp_umem_reg {
> >         __u32 chunk_size;
> >         __u32 headroom;
> >         __u32 flags;
> > +       __u32 tx_metadata_len;
> >  };
> >
> >  struct xdp_statistics {
> > diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> > index 06cead2b8e34..333f3d53aad4 100644
> > --- a/net/xdp/xdp_umem.c
> > +++ b/net/xdp/xdp_umem.c
> > @@ -199,6 +199,9 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
> >         if (headroom >= chunk_size - XDP_PACKET_HEADROOM)
> >                 return -EINVAL;
> >
> > +       if (mr->tx_metadata_len > 256 || mr->tx_metadata_len % 4)
> > +               return -EINVAL;
> 
> Should be >= 256 since the final internal destination is a u8 and the
> documentation says "should be less than 256 bytes".

Thanks, will fix.

