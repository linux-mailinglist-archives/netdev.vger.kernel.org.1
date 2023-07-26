Return-Path: <netdev+bounces-21175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07560762AE1
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 07:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3ED4281BC2
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 05:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF3D63BF;
	Wed, 26 Jul 2023 05:38:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF063AC
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:38:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFC426A2
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 22:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690349918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfs3nnD/SOOUA7MFV9W94hwiVWoxJiHiqbutUMOkKZQ=;
	b=bu/0wS/rC944LMPG0hrxFwvanzuSGpleBFlAEtLuK7TA/fMUL2U2tA000CjQUSG1ca+PWB
	DNzeMReFKqtTikrKbuXhudEQIcD68FMHuf68hHfIStuOzvgUA+j93APdXIszlD9uzp2fwh
	/LOpXUsvizeN+HcU26DUrGYICtxI7rU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-w5TjdmgzPQe_bWb25PRpgw-1; Wed, 26 Jul 2023 01:38:36 -0400
X-MC-Unique: w5TjdmgzPQe_bWb25PRpgw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b710c5677eso57171111fa.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 22:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690349914; x=1690954714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfs3nnD/SOOUA7MFV9W94hwiVWoxJiHiqbutUMOkKZQ=;
        b=IG5pEm0jeWZUb199RcpRmx9LZ+dABCwRZ80OL+PSt5JJal2TAMhLZkH/+btOJIz61m
         uuSGb0fLLd5o83WxGS8PXq1Fo0qDxCHTp8O14PU9fZ956DeaoShJWV5NPciAjnG9DM75
         0QAtaTfXZgV5BKsRxfMVeaVs47BEkvQzA/MYa7sIiFekFWyzIK1R7Ygsb4Fs5zQV4d/w
         fOacVkBPkzkF4aNk4DsipEpjD8B1+Cq0TBqnsnZTBudKvEZLXlsFXzvLrSSIFrQ5GyMX
         yvFikDvWKYSkpIMguvXpHJRHZBk8Xsq3Z1bc/ynSEVFUepf/QXQ5V32rmR9aLBM6u3zR
         bdcw==
X-Gm-Message-State: ABy/qLYFKdm0ETdhsGtSHXEmMpz96DdbGaBo9d1eCLUUmjXf+iUWPpcs
	jwxdf39/NA+OQPP4SfN19oKXmvklF2rhuWImntzyVjMR/seC6uLVEvhgjz/fVLR2IRwsy53w9Y/
	7TU9Opm0vy74r0vUgBpDwoaKUUxqWItEO
X-Received: by 2002:a2e:8042:0:b0:2b6:dd9a:e1d3 with SMTP id p2-20020a2e8042000000b002b6dd9ae1d3mr605680ljg.44.1690349914782;
        Tue, 25 Jul 2023 22:38:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZ1ivRh44yxvv5AoW/k+bdQtpElC2pldw9fqqViy1tLZuooCCFV/0/FqgQ945tCdp+io30vgVHGutAPfdVtuA=
X-Received: by 2002:a2e:8042:0:b0:2b6:dd9a:e1d3 with SMTP id
 p2-20020a2e8042000000b002b6dd9ae1d3mr605673ljg.44.1690349914469; Tue, 25 Jul
 2023 22:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230705114505.63274-1-maxime.coquelin@redhat.com>
In-Reply-To: <20230705114505.63274-1-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jul 2023 13:38:22 +0800
Message-ID: <CACGkMEtF9c0dL+bk0=JovcVs-ZVzEJJXdt9gx=_Lh+KtwFu9ig@mail.gmail.com>
Subject: Re: [PATCH] vduse: Use proper spinlock for IRQ injection
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: xieyongji@bytedance.com, mst@redhat.com, david.marchand@redhat.com, 
	lulu@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 7:45=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> The IRQ injection work used spin_lock_irq() to protect the
> scheduling of the softirq, but spin_lock_bh() should be
> used.
>
> With spin_lock_irq(), we noticed delay of more than 6
> seconds between the time a NAPI polling work is scheduled
> and the time it is executed.
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Cc: xieyongji@bytedance.com
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index dc38ed21319d..df7869537ef1 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -935,10 +935,10 @@ static void vduse_dev_irq_inject(struct work_struct=
 *work)
>  {
>         struct vduse_dev *dev =3D container_of(work, struct vduse_dev, in=
ject);
>
> -       spin_lock_irq(&dev->irq_lock);
> +       spin_lock_bh(&dev->irq_lock);
>         if (dev->config_cb.callback)
>                 dev->config_cb.callback(dev->config_cb.private);
> -       spin_unlock_irq(&dev->irq_lock);
> +       spin_unlock_bh(&dev->irq_lock);
>  }
>
>  static void vduse_vq_irq_inject(struct work_struct *work)
> @@ -946,10 +946,10 @@ static void vduse_vq_irq_inject(struct work_struct =
*work)
>         struct vduse_virtqueue *vq =3D container_of(work,
>                                         struct vduse_virtqueue, inject);
>
> -       spin_lock_irq(&vq->irq_lock);
> +       spin_lock_bh(&vq->irq_lock);
>         if (vq->ready && vq->cb.callback)
>                 vq->cb.callback(vq->cb.private);
> -       spin_unlock_irq(&vq->irq_lock);
> +       spin_unlock_bh(&vq->irq_lock);
>  }
>
>  static bool vduse_vq_signal_irqfd(struct vduse_virtqueue *vq)
> --
> 2.41.0
>


