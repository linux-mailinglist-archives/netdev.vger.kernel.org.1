Return-Path: <netdev+bounces-35464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C707A99BB
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907791C20F22
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F7B44462;
	Thu, 21 Sep 2023 17:23:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BEA1944F
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:23:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D721F31
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695316941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqoOPgme4Uuv5hKrBPiJj6+uKIVnMHAtPkgpqGU6vG4=;
	b=GYExix0CJKRSwCeurDzn+SB3vhtr2reV8fv2btz7/At3FSeGoOepo6GNhvM9lZoFPRDCnd
	JkjPi26nyAnZja0TR88WlDa7P5QxdRJ8hYsJl0QVhfqThIKnMVdgG4/ar14J0z7Jv7iq1e
	T1XxydJhTR3Sz0MmGtZyEDntF8WTKZI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-6duPFt4EOiGShIi8XQYuGA-1; Thu, 21 Sep 2023 10:07:01 -0400
X-MC-Unique: 6duPFt4EOiGShIi8XQYuGA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31fd48da316so676917f8f.3
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 07:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695305219; x=1695910019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqoOPgme4Uuv5hKrBPiJj6+uKIVnMHAtPkgpqGU6vG4=;
        b=NYpck2f5H4jUNwe2mDgvkiH+xL+c414KU9If/7NButHt0GOpwIVFFINBzdVvPhcZ03
         Ja982RT3lUZ1gnIc0/5wlZ4TIL1LIBpXnc5M5cU7kAkwVt9YTvLlGOlN17UrsG/zYexU
         RiiDnPUoazikpUW3wqy8NNbP+HlVEQ88/i9jNKKeJ4IQaToiRkb/Q2d/m6Vmt0zggV+l
         yE17s+MiqAW4dTLO1NcooEP+pp2WgY8LEhz1s6Y8F2rLShcFEuYobCkj70iFu69t3HHN
         3BV7mA7+YuPAvqrSR+cKOo22ZyF5pEXlnUt0dX5SwKZupg0UMQmAZ7bUgyq7heAhuV0b
         0aVQ==
X-Gm-Message-State: AOJu0YxmO2nG0EDfsOCeoS3sjwvDphME0MkpHSBTWpMro/G/aC3hSSQe
	OgwzCc1uwe3LpaMH8ISyIQXODbeTBOplYnJx6iEGbsT04OApKXJ+Ujc8mfLzBZIxjToUfD7WZQ4
	r3ySAXt7Rex18/Sn/Fazv95tv1V74k2FFSXAOuGW5
X-Received: by 2002:adf:e604:0:b0:319:7c7d:8d1 with SMTP id p4-20020adfe604000000b003197c7d08d1mr4559818wrm.44.1695305219571;
        Thu, 21 Sep 2023 07:06:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc9cPDe47gAzDmyMLuyvubfic4IfTmoR2y3Zwjncq14ViwH92x3CA0CL7uTBYmXwPLmcQOAKYKkzdqCkjcTCA=
X-Received: by 2002:adf:e604:0:b0:319:7c7d:8d1 with SMTP id
 p4-20020adfe604000000b003197c7d08d1mr4559793wrm.44.1695305219207; Thu, 21 Sep
 2023 07:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com> <20230912030008.3599514-2-lulu@redhat.com>
 <CACGkMEuwjga949gGBKyZozfppMa2UF5mu8wuk4o88Qi6GthtXw@mail.gmail.com>
In-Reply-To: <CACGkMEuwjga949gGBKyZozfppMa2UF5mu8wuk4o88Qi6GthtXw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 21 Sep 2023 22:06:16 +0800
Message-ID: <CACLfguUu83eYPr=yaSMEAm77igOvdc1ZF-LPNPRcbKrg1OsbUA@mail.gmail.com>
Subject: Re: [RFC v2 1/4] vduse: Add function to get/free the pages for reconnection
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, maxime.coquelin@redhat.com, xieyongji@bytedance.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 4:41=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Sep 12, 2023 at 11:00=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > Add the function vduse_alloc_reconnnect_info_mem
> > and vduse_alloc_reconnnect_info_mem
> > In this 2 function, vduse will get/free (vq_num + 1)*page
> > Page 0 will be used to save the reconnection information, The
> > Userspace App will maintain this. Page 1 ~ vq_num + 1 will save
> > the reconnection information for vqs.
>
> Please explain why this is needed instead of only describing how it is
> implemented. (Code can explain itself).
>
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 86 ++++++++++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 26b7e29cb900..4c256fa31fc4 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -30,6 +30,10 @@
> >  #include <uapi/linux/virtio_blk.h>
> >  #include <linux/mod_devicetable.h>
> >
> > +#ifdef CONFIG_X86
> > +#include <asm/set_memory.h>
> > +#endif
> > +
> >  #include "iova_domain.h"
> >
> >  #define DRV_AUTHOR   "Yongji Xie <xieyongji@bytedance.com>"
> > @@ -41,6 +45,23 @@
> >  #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
> >  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
> >
> > +/* struct vdpa_reconnect_info save the page information for reconnecti=
on
> > + * kernel will init these information while alloc the pages
> > + * and use these information to free the pages
> > + */
> > +struct vdpa_reconnect_info {
> > +       /* Offset (within vm_file) in PAGE_SIZE,
> > +        * this just for check, not using
> > +        */
> > +       u32 index;
> > +       /* physical address for this page*/
> > +       phys_addr_t addr;
> > +       /* virtual address for this page*/
> > +       unsigned long vaddr;
>
> If it could be switched by virt_to_phys() why duplicate those fields?
>
yes will remove this part
Thanks
Cindy
> > +       /* memory size, here always page_size*/
> > +       phys_addr_t size;
>
> If it's always PAGE_SIZE why would we have this?
will remove this
Thanks
Cindy
>
> > +};
> > +
> >  struct vduse_virtqueue {
> >         u16 index;
> >         u16 num_max;
> > @@ -57,6 +78,7 @@ struct vduse_virtqueue {
> >         struct vdpa_callback cb;
> >         struct work_struct inject;
> >         struct work_struct kick;
> > +       struct vdpa_reconnect_info reconnect_info;
> >  };
> >
> >  struct vduse_dev;
> > @@ -106,6 +128,7 @@ struct vduse_dev {
> >         u32 vq_align;
> >         struct vduse_umem *umem;
> >         struct mutex mem_lock;
> > +       struct vdpa_reconnect_info reconnect_status;
> >  };
> >
> >  struct vduse_dev_msg {
> > @@ -1030,6 +1053,65 @@ static int vduse_dev_reg_umem(struct vduse_dev *=
dev,
> >         return ret;
> >  }
> >
> > +int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> > +{
> > +       struct vdpa_reconnect_info *info;
> > +       struct vduse_virtqueue *vq;
> > +       void *addr;
> > +
> > +       /*page 0 is use to save status,dpdk will use this to save the i=
nformation
> > +        *needed in reconnection,kernel don't need to maintain this
> > +        */
> > +       info =3D &dev->reconnect_status;
> > +       addr =3D (void *)get_zeroed_page(GFP_KERNEL);
> > +       if (!addr)
> > +               return -1;
>
> -ENOMEM?
>
sure will change this
Thanks
Cidny
> Thanks
>


