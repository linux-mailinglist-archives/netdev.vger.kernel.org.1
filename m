Return-Path: <netdev+bounces-26155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD33777087
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7741C214A6
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 06:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4068F1C17;
	Thu, 10 Aug 2023 06:37:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF691110
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:37:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B79E4B
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 23:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691649455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSNLC6BB/rIG6JAwglNeuVJJEDiOdKe+AYgeEbBc/lo=;
	b=gWfyTreSBAjjv6yIfDo+R2+u4NhrZQBl4fB4j+4a9Lf+HnAAN4YfXdZXp0URaNYHcB17y1
	sI7w8ZSGbG1EiwzZol67frbe94Z/2e1L5wg/J2NTVakW2wY8AtpHxjNy6zyLFIovkTlYnI
	onDPHTOetT0hceBOuDHiqTCUnmBTZtw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-tdDKLb-iN22LugK3mI3UHw-1; Thu, 10 Aug 2023 02:37:33 -0400
X-MC-Unique: tdDKLb-iN22LugK3mI3UHw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b9da035848so5931811fa.3
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 23:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691649452; x=1692254252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSNLC6BB/rIG6JAwglNeuVJJEDiOdKe+AYgeEbBc/lo=;
        b=D6Ns6ad89s9dHbuzGV7eKei63bvZoOZNTCmB90AITB5BOpb/zXDWAQCDuOXVRHAsdk
         yja4WqQbCCWcs1guwt59ZcAv/jvyKaWbtWgPsIYTffP9fRo3JdpsyqX0O3+ex1v7DOEb
         n2fbUEykSXpvJhc9pbPxr09cYAwbxdgoIkuhAOBBXkoiBHBTYuI0+2CyDV6cVklxihxB
         sf85JPVdBIXVvfpjj10BVB/IOdQXthxZEVIR+SszZ2VDT++05RZWw2fn8UqY9aXKnGM5
         5zUagsbh6WT8SuyAijjFsgHqHf9rGNLKHinAu9MLhVTyMJbqtewj9ZrX2ovLMiyoZkHM
         reGg==
X-Gm-Message-State: AOJu0YyWV3Ne/LDQ5hEH/ymXvL6hXKnhdHpRCPugqC1i6ObM769nDaK6
	zSJF1RKQOX4S51iaqK7AqlgT4l/t6If8jff0dIeKK/XvPezzEcjWrrhj6I+0JfSMZnH7xHCMYYH
	AAZk+YvfIXFKX4LEVpyHzZtGEYdpCBUdJ
X-Received: by 2002:a2e:3a13:0:b0:2ba:3eac:bece with SMTP id h19-20020a2e3a13000000b002ba3eacbecemr1006411lja.49.1691649452062;
        Wed, 09 Aug 2023 23:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJpXi/a4Vbryg7Fl7HPBw1URqscGlQaQzUr+KC+DXEyOalDWFvBvFxtKqjVMF2nh7cLKtEKJ77bDQThv1jTFw=
X-Received: by 2002:a2e:3a13:0:b0:2ba:3eac:bece with SMTP id
 h19-20020a2e3a13000000b002ba3eacbecemr1006397lja.49.1691649451800; Wed, 09
 Aug 2023 23:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com> <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org> <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org> <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com> <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com> <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230801121543-mutt-send-email-mst@kernel.org> <1690940971.9409487-2-xuanzhuo@linux.alibaba.com>
 <1691388845.9121156-1-xuanzhuo@linux.alibaba.com> <1691632614.950658-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691632614.950658-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Aug 2023 14:37:20 +0800
Message-ID: <CACGkMEuBytsv3uZcEVMKU_JvSzfHxXU9Er3Yha7=DqjMMDxpng@mail.gmail.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, 
	virtualization@lists.linux-foundation.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 9:59=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
>
> Ping!!
>
> Could we push this to the next linux version?

How about implementing the wrappers along with virtqueue_dma_dev() to
see if Christoph is happy?

Thanks

>
> Thanks.
>


