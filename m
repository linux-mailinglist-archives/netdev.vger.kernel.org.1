Return-Path: <netdev+bounces-34469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8897A44F8
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738AD281CC2
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 08:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2814D14A9D;
	Mon, 18 Sep 2023 08:41:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665CA566A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:41:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F59123
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 01:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695026476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCPsfcbIVqzhPMc9WpjHh54nSWIDbNSd7gzRQ5+/f94=;
	b=Y36ur8sYD9CZXwuU0ClaSuyATSmYbWW0zd7gcXXtmR11I+iz7IbUYMCYzR+UzwJwXLHpu/
	z/ac1atkBp3Wpc4neORrE1cbd72lIUFLgnVxg7hyabSkIBnf05oUr1pOstCtksdZjD9WlL
	kwAnrYt+zfWj951Up4nLGV7TGxmCZUE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-vrJMCeCSMQe-YfED-HMrOg-1; Mon, 18 Sep 2023 04:41:13 -0400
X-MC-Unique: vrJMCeCSMQe-YfED-HMrOg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50318e9067eso635418e87.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 01:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695026472; x=1695631272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCPsfcbIVqzhPMc9WpjHh54nSWIDbNSd7gzRQ5+/f94=;
        b=tfofo6pCI2bQCBPETkOKd1j97Bi1WT7mNxQL+d6Bq7stwKjscpDzfjwyTyYrA4UeGa
         KViUUYQdPYkqmbeWotQFupWCWTBPxhCReQd4Q5lNCaCSe3eWpF3tpxUPqAzOxtWeOAnF
         NL1FZ+py09ARJPpjF/732NkkJ3nR7K9STmF08HBmaF4TotO1xANZ8V4XXZsDPeFOw4M4
         IoOmVmWUMqm1uT1Iu55kRA+uIITS1iKU0O1Fk7zZPZMwD31l/J3l/6Ckl3QCG15FReCP
         IpH7qwwy1YqYeQgZgRfHO8vm8d0AZ+mNvAPpzqax6aJhk5pi1dygNanb+YQm/pHUqA9x
         jFHA==
X-Gm-Message-State: AOJu0YzRWMpHd/EUcQAggGQlm5AhVDnrTYipUeYkuDcgiC+rkbf7rOjc
	Rcj2mXmQxjooFsFGRDFESItyW3KoU+Mo+rnIjOObiEQNWJZ9Kmyr7sATUSVXIqSPr1l/hyYbfi8
	wlzmOvvmHsMpI/ymCX3X4vWRxeVzavMCs
X-Received: by 2002:a05:6512:23a7:b0:500:a092:d085 with SMTP id c39-20020a05651223a700b00500a092d085mr7708219lfv.68.1695026472251;
        Mon, 18 Sep 2023 01:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHftb4P10wWIp3v1EHXZOaP1ysBNS2M6oNZ6GDQlDzpedtNdGUMoZMBhfxfUMabxjFMqZEsMi5wHIELNox0cn8=
X-Received: by 2002:a05:6512:23a7:b0:500:a092:d085 with SMTP id
 c39-20020a05651223a700b00500a092d085mr7708204lfv.68.1695026471949; Mon, 18
 Sep 2023 01:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com> <20230912030008.3599514-2-lulu@redhat.com>
In-Reply-To: <20230912030008.3599514-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Sep 2023 16:41:00 +0800
Message-ID: <CACGkMEuwjga949gGBKyZozfppMa2UF5mu8wuk4o88Qi6GthtXw@mail.gmail.com>
Subject: Re: [RFC v2 1/4] vduse: Add function to get/free the pages for reconnection
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, maxime.coquelin@redhat.com, xieyongji@bytedance.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 12, 2023 at 11:00=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function vduse_alloc_reconnnect_info_mem
> and vduse_alloc_reconnnect_info_mem
> In this 2 function, vduse will get/free (vq_num + 1)*page
> Page 0 will be used to save the reconnection information, The
> Userspace App will maintain this. Page 1 ~ vq_num + 1 will save
> the reconnection information for vqs.

Please explain why this is needed instead of only describing how it is
implemented. (Code can explain itself).

>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 86 ++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 26b7e29cb900..4c256fa31fc4 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -30,6 +30,10 @@
>  #include <uapi/linux/virtio_blk.h>
>  #include <linux/mod_devicetable.h>
>
> +#ifdef CONFIG_X86
> +#include <asm/set_memory.h>
> +#endif
> +
>  #include "iova_domain.h"
>
>  #define DRV_AUTHOR   "Yongji Xie <xieyongji@bytedance.com>"
> @@ -41,6 +45,23 @@
>  #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
>  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
>
> +/* struct vdpa_reconnect_info save the page information for reconnection
> + * kernel will init these information while alloc the pages
> + * and use these information to free the pages
> + */
> +struct vdpa_reconnect_info {
> +       /* Offset (within vm_file) in PAGE_SIZE,
> +        * this just for check, not using
> +        */
> +       u32 index;
> +       /* physical address for this page*/
> +       phys_addr_t addr;
> +       /* virtual address for this page*/
> +       unsigned long vaddr;

If it could be switched by virt_to_phys() why duplicate those fields?

> +       /* memory size, here always page_size*/
> +       phys_addr_t size;

If it's always PAGE_SIZE why would we have this?

> +};
> +
>  struct vduse_virtqueue {
>         u16 index;
>         u16 num_max;
> @@ -57,6 +78,7 @@ struct vduse_virtqueue {
>         struct vdpa_callback cb;
>         struct work_struct inject;
>         struct work_struct kick;
> +       struct vdpa_reconnect_info reconnect_info;
>  };
>
>  struct vduse_dev;
> @@ -106,6 +128,7 @@ struct vduse_dev {
>         u32 vq_align;
>         struct vduse_umem *umem;
>         struct mutex mem_lock;
> +       struct vdpa_reconnect_info reconnect_status;
>  };
>
>  struct vduse_dev_msg {
> @@ -1030,6 +1053,65 @@ static int vduse_dev_reg_umem(struct vduse_dev *de=
v,
>         return ret;
>  }
>
> +int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> +{
> +       struct vdpa_reconnect_info *info;
> +       struct vduse_virtqueue *vq;
> +       void *addr;
> +
> +       /*page 0 is use to save status,dpdk will use this to save the inf=
ormation
> +        *needed in reconnection,kernel don't need to maintain this
> +        */
> +       info =3D &dev->reconnect_status;
> +       addr =3D (void *)get_zeroed_page(GFP_KERNEL);
> +       if (!addr)
> +               return -1;

-ENOMEM?

Thanks


