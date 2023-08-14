Return-Path: <netdev+bounces-27231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1647377B08A
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 06:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44AEC280F27
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 04:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095041FDE;
	Mon, 14 Aug 2023 04:39:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044F1FAA
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 04:39:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285D3E7E
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 21:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691987923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aK0SJ5Ys3aL4eIY1ULDHKa+YKSKcNhoW58WmpbgTceE=;
	b=eoL4inzHPzeQhbVRNc6f0N7/ILcXv3q+s/g0KSmfSRkrv/hOCOvFlOwmWshhMvGu9Ml3xZ
	wf6eaVTqyZ1kAJnH1A5+N0oj5Tz1vEZOjehqo9K3ozsVNKFRPfqwKs9zWHIRAJiYZb9tg3
	/BU/79UN8kA/b2/88V5CzHTzJmu0SII=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-85ZWEHp-NKOrjkp4mpUs8g-1; Mon, 14 Aug 2023 00:38:41 -0400
X-MC-Unique: 85ZWEHp-NKOrjkp4mpUs8g-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9fa64db5cso37932301fa.2
        for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 21:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691987919; x=1692592719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aK0SJ5Ys3aL4eIY1ULDHKa+YKSKcNhoW58WmpbgTceE=;
        b=IHNhjUVj0lUiJuUIeiciQ9qToqREhqVSqUj9P3uWAaSwt9GDW0fUXV1epM7j/f0UiH
         hesR421gtzUbV1LuMQasSMHR2NIcxzeCJGUOCmrCf7LSZSFfk5CAXanOCrsquhCoF+3/
         gyc1B67a6DTS3YDPtpVd+L1MPbnOHadmwAIguyJJN7Po4BEy9B3fEVxEpEHr+klcE6cY
         /FizBSyKZicuJRgePxs1f4HBoC4dPoT8ypPUksctY+aBihnHPzM6s0oygJYof/6xigK6
         55vGHJMLpev1wrvS90/zZI2UQyJ305KZzhX2cdADdAJmQihqlD4bxI1WLOjanhi1toGd
         qb2g==
X-Gm-Message-State: AOJu0YxIlF3MCLSH1oLSPDD55Ht2VwE5B7zyXVwxIo63y2o1YIyJIsOC
	9m8Gz/7NGcj8KqCNiC7G7aCpkPgy/hpO1ifHZSudH1ETItZLGvVQBM64vLCVGloybNjAQ0ixhoo
	sG2JZA1Jyvx2TaqOh5ZGm935MVKEwYwW5
X-Received: by 2002:a2e:b712:0:b0:2b4:6eb0:2a27 with SMTP id j18-20020a2eb712000000b002b46eb02a27mr5968655ljo.17.1691987919725;
        Sun, 13 Aug 2023 21:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPgsJX7lmRRXk9QZtHBISV4+zSZ0QOhF0u67nsy81U9FUxM1FnoRDpxfZLXAQcZCxRxHts49gu6GBBBeW2d/I=
X-Received: by 2002:a2e:b712:0:b0:2b4:6eb0:2a27 with SMTP id
 j18-20020a2eb712000000b002b46eb02a27mr5968639ljo.17.1691987919420; Sun, 13
 Aug 2023 21:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230811065512.22190-1-hengqi@linux.alibaba.com>
In-Reply-To: <20230811065512.22190-1-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Aug 2023 12:38:28 +0800
Message-ID: <CACGkMEugNDGufpcK0apumz6+MdptoshMPuVWB4Czo1Z5jw1UyA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/8] virtio-net: support dynamic notification
 coalescing moderation
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 2:55=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Now, virtio-net already supports per-queue notification coalescing parame=
ter
> setting. Based on this, we use the netdim library[1] of linux to support
> dynamic notification coalescing moderation for virtio-net.
>
> [1] https://docs.kernel.org/networking/net_dim.html

Do you have perf numbers?

Thanks

>
> This series also introduces some extractions and fixes. Please review.
>
> Heng Qi (8):
>   virtio-net: initially change the value of tx-frames
>   virtio-net: fix mismatch of getting txq tx-frames param
>   virtio-net: returns whether napi is complete
>   virtio-net: separate rx/tx coalescing moderation cmds
>   virtio-net: extract virtqueue coalescig cmd for reuse
>   virtio-net: support rx netdim
>   virtio-net: support tx netdim
>   virtio-net: a tiny comment update
>
>  drivers/net/virtio_net.c | 370 +++++++++++++++++++++++++++++++++------
>  1 file changed, 316 insertions(+), 54 deletions(-)
>
> --
> 2.19.1.6.gb485710b
>


