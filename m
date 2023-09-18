Return-Path: <netdev+bounces-34470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5B67A4516
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2291C20B1D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3FD14AA6;
	Mon, 18 Sep 2023 08:47:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D197A23B9
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:47:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71EBCDE
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 01:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695026796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ne/6wvHEM171/1YnTSavkevXbhaVIZD2o3rmnI4AXAc=;
	b=JenUigJg2zm1da2Ng9D80+bYItNE0fRxDkSa9N/kh7jM5w3+DC5mVE+DUBWp+YPlhysKh9
	Eyzzjeu8yAcO2MGEU4TkWZ5O/eAgYAU93ExgI4zbiXMr2FLI0YaXqz1KKKD4z7huoY4s8g
	e4YHIiJgu3iCGbyChNelVWJwpUS72gM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-FN6AZAoPP2ieKnp_ccS5rA-1; Mon, 18 Sep 2023 04:46:30 -0400
X-MC-Unique: FN6AZAoPP2ieKnp_ccS5rA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50076a3fd35so4895845e87.1
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 01:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695026789; x=1695631589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ne/6wvHEM171/1YnTSavkevXbhaVIZD2o3rmnI4AXAc=;
        b=TTDOfD5U8cCf8aAehjQgtW6T5ciXi+tU6WdIqCaRyd5Jp1f5o2lVJOh2Hw2W91ndyJ
         5cvnfD022AZhh0dVIqjdjSIiLCiKmqlFddoJLwVUVTv/EmgIMVtQsh3OmjHr+P4o9A6Y
         sstidW092rbVjywEvIzbmXUMgpAV2SpdN5WUBkLfyn+FrwrzAgxPrpoTe1xM2h2hgC5l
         ogKtAM4cZYEDWwOevgf23yO7iiXHvfies9V/xeBB7pk9sFI6E9UThaRtTjHmwTvIGNYm
         88NjHF3wx/bV7esF/dJ6RwyVMOolJhylZoL1hBGBRkpsXmQFp3QmkDzAYfZmxJBiu4ZN
         /ewQ==
X-Gm-Message-State: AOJu0YxkVCfHWSs5e04IPdbDN14MIn7RYWTbz9q6kgBwUYsN7So4dQQG
	LUTqomN+txi3ITF7zS8cX00G+pJ/Iej8LvfooBJG5h8xPW8xyUC3NINvAsGPRN3k6oJ2V1vOU/c
	QyAcAvHwrhxl6YXNkBUh7qJKFuDdnQoy9
X-Received: by 2002:a05:6512:3d27:b0:503:5d8:da33 with SMTP id d39-20020a0565123d2700b0050305d8da33mr5511656lfv.20.1695026789528;
        Mon, 18 Sep 2023 01:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgMCrTK06HsA1jmrN2m8hmh2JeHg5MHIGzt2YqOFrbMXyCjP3e56ikeAOpp3+Aew9hlguYd0zxzDgNAWMVZ90=
X-Received: by 2002:a05:6512:3d27:b0:503:5d8:da33 with SMTP id
 d39-20020a0565123d2700b0050305d8da33mr5511649lfv.20.1695026789253; Mon, 18
 Sep 2023 01:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com> <20230912030008.3599514-3-lulu@redhat.com>
In-Reply-To: <20230912030008.3599514-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Sep 2023 16:46:18 +0800
Message-ID: <CACGkMEuOYWYYGta5VoZaURVxrBFwU+1aNwoh7RyT1woQCNHJtg@mail.gmail.com>
Subject: Re: [RFC v2 2/4] vduse: Add file operation for mmap
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
> Add the operation for mmap, The user space APP will
> use this function to map the pages to userspace
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 63 ++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 4c256fa31fc4..2c69f4004a6e 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1388,6 +1388,67 @@ static struct vduse_dev *vduse_dev_get_from_minor(=
int minor)
>         return dev;
>  }
>
> +static vm_fault_t vduse_vm_fault(struct vm_fault *vmf)
> +{
> +       struct vduse_dev *dev =3D vmf->vma->vm_file->private_data;
> +       struct vm_area_struct *vma =3D vmf->vma;
> +       u16 index =3D vma->vm_pgoff;
> +       struct vduse_virtqueue *vq;
> +       struct vdpa_reconnect_info *info;
> +
> +       if (index =3D=3D 0) {
> +               info =3D &dev->reconnect_status;
> +       } else {
> +               vq =3D &dev->vqs[index - 1];
> +               info =3D &vq->reconnect_info;
> +       }
> +       vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
> +       if (remap_pfn_range(vma, vmf->address & PAGE_MASK, PFN_DOWN(info-=
>addr),
> +                           PAGE_SIZE, vma->vm_page_prot))
> +               return VM_FAULT_SIGBUS;
> +       return VM_FAULT_NOPAGE;
> +}
> +
> +static const struct vm_operations_struct vduse_vm_ops =3D {
> +       .fault =3D vduse_vm_fault,
> +};
> +
> +static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +       struct vduse_dev *dev =3D file->private_data;
> +       struct vdpa_reconnect_info *info;
> +       unsigned long index =3D vma->vm_pgoff;
> +       struct vduse_virtqueue *vq;
> +
> +       if (vma->vm_end - vma->vm_start !=3D PAGE_SIZE)
> +               return -EINVAL;
> +       if ((vma->vm_flags & VM_SHARED) =3D=3D 0)
> +               return -EINVAL;
> +
> +       if (index > 65535)
> +               return -EINVAL;
> +
> +       if (index =3D=3D 0) {
> +               info =3D &dev->reconnect_status;
> +       } else {
> +               vq =3D &dev->vqs[index - 1];
> +               info =3D &vq->reconnect_info;
> +       }
> +
> +       if (info->index !=3D index)
> +               return -EINVAL;

Under which case could we meet this?

> +
> +       if (info->addr & (PAGE_SIZE - 1))
> +               return -EINVAL;

And this?

> +       if (vma->vm_end - vma->vm_start !=3D info->size)
> +               return -EOPNOTSUPP;
> +
> +       vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTDUMP);

Why do you use VM_IO, VM_PFNMAP and VM_DONTDUMP?

Thanks

> +       vma->vm_ops =3D &vduse_vm_ops;
> +
> +       return 0;
> +}
> +
>  static int vduse_dev_open(struct inode *inode, struct file *file)
>  {
>         int ret;
> @@ -1420,6 +1481,8 @@ static const struct file_operations vduse_dev_fops =
=3D {
>         .unlocked_ioctl =3D vduse_dev_ioctl,
>         .compat_ioctl   =3D compat_ptr_ioctl,
>         .llseek         =3D noop_llseek,
> +       .mmap           =3D vduse_dev_mmap,
> +
>  };
>
>  static struct vduse_dev *vduse_dev_create(void)
> --
> 2.34.3
>


