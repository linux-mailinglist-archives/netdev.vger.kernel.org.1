Return-Path: <netdev+bounces-31758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0688178FF99
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 17:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6548C281B8A
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B05BE66;
	Fri,  1 Sep 2023 15:02:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD9323BF
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 15:02:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E8110CF
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693580557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPtvtqNvs8+fkjweTMnIvDrbDyuw67BhNfXzt3RNVMM=;
	b=HcUlL6ejP3pLHW6mbQVs+GIHtVxMV41mHJXUZ2yuVi2eo+U6XJpX54Ar8mO27JYD3DWUiK
	HW3QDP72aLoRTOtNyAZFw6OfpJXrU/fcHaCgnCEBACClZfkvyRUwg82tZO8BSGlxRq2r02
	lY3/o88+r/aB191NSw8e0YKCj5Y3IX4=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-zAgAPP3MNJKycjkex0MsYw-1; Fri, 01 Sep 2023 11:02:36 -0400
X-MC-Unique: zAgAPP3MNJKycjkex0MsYw-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-d7e79ec07b4so758803276.0
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 08:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693580556; x=1694185356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPtvtqNvs8+fkjweTMnIvDrbDyuw67BhNfXzt3RNVMM=;
        b=g/BVtBZJaSE26G2PMMdboG6PucP37SFHPCJTD5KlodVEJQpKpepdY3V0qpjV8MaJj7
         A7q0F9Oiso19ObEAeVXFonuGvvAjcKhWU4Y0173Czi183waqiKl8qC8yLYSr1jcFSODr
         TUEUq+l43NXUVzKDNR4hN8+Pefhth1bUFrkt1GaGlhUNQSVv6H8gt6qBSW/z7HhklDsV
         8fzpnJoypd+vVcXoVQKUarWnaTvV27ZEksIc1FjWNOAx3Zvar2U9lBTPUAia2jeWJqyH
         w5389UPS+uMp8Ov+gbsyVoPXIA9OEA+cTHX3siVTOxAQ342H2h2HClxQaojY/xo+jMUN
         an/w==
X-Gm-Message-State: AOJu0YztPvhxbbYJea3pul/Tp+1UTnMz2WQPpfb3+7jn9RQXrS5n2xEx
	0q1VVi+pe6RKM9Gtv2byTUMPtFpo+WzzPkNb/SiJvFcFzcK4YGXaHDuzf6h3K1r3ARtruXu5yFJ
	HHupN1mxmVvvAam4HQ+T76pwn7v+1RGkE9NZ8jJVZ64U=
X-Received: by 2002:a25:8752:0:b0:d7b:9d44:767a with SMTP id e18-20020a258752000000b00d7b9d44767amr3306148ybn.17.1693580555915;
        Fri, 01 Sep 2023 08:02:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs1xdLT3UOu9lvAa/G6DmDabzFqab74Wu93gIr5nfITxBjd7OJjba6LzCwnp8NcfPXE1GmnmPW1c47Brfww1U=
X-Received: by 2002:a25:8752:0:b0:d7b:9d44:767a with SMTP id
 e18-20020a258752000000b00d7b9d44767amr3306126ybn.17.1693580555733; Fri, 01
 Sep 2023 08:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230828213403.45490-1-shannon.nelson@amd.com>
In-Reply-To: <20230828213403.45490-1-shannon.nelson@amd.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 1 Sep 2023 17:01:59 +0200
Message-ID: <CAJaqyWf+1K-hYqqAnhVmdf-9PB-rEXeYdOT+o=FpBNT3kzBewQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio: kdoc for struct virtio_pci_modern_device
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: jasowang@redhat.com, mst@redhat.com, 
	virtualization@lists.linux-foundation.org, brett.creeley@amd.com, 
	netdev@vger.kernel.org, simon.horman@corigine.com, drivers@pensando.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 11:35=E2=80=AFPM Shannon Nelson <shannon.nelson@amd=
.com> wrote:
>
> Finally following up to Simon's suggestion for some kdoc attention
> on struct virtio_pci_modern_device.
>
> Link: https://lore.kernel.org/netdev/ZE%2FQS0lnUvxFacjf@corigine.com/
> Cc: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

When you repost it,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  include/linux/virtio_pci_modern.h | 34 ++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci=
_modern.h
> index 067ac1d789bc..a38c729d1973 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -12,37 +12,47 @@ struct virtio_pci_modern_common_cfg {
>         __le16 queue_reset;             /* read-write */
>  };
>
> +/**
> + * struct virtio_pci_modern_device - info for modern PCI virtio
> + * @pci_dev:       Ptr to the PCI device struct
> + * @common:        Position of the common capability in the PCI config
> + * @device:        Device-specific data (non-legacy mode)
> + * @notify_base:    Base of vq notifications (non-legacy mode)
> + * @notify_pa:     Physical base of vq notifications
> + * @isr:           Where to read and clear interrupt
> + * @notify_len:            So we can sanity-check accesses
> + * @device_len:            So we can sanity-check accesses
> + * @notify_map_cap: Capability for when we need to map notifications per=
-vq
> + * @notify_offset_multiplier: Multiply queue_notify_off by this value
> + *                            (non-legacy mode).
> + * @modern_bars:    Bitmask of BARs
> + * @id:                    Device and vendor id
> + * @device_id_check: Callback defined before vp_modern_probe() to be use=
d to
> + *                 verify the PCI device is a vendor's expected device r=
ather
> + *                 than the standard virtio PCI device
> + *                 Returns the found device id or ERRNO
> + * @dma_mask:      Optional mask instead of the traditional DMA_BIT_MASK=
(64),
> + *                 for vendor devices with DMA space address limitations
> + */
>  struct virtio_pci_modern_device {
>         struct pci_dev *pci_dev;
>
>         struct virtio_pci_common_cfg __iomem *common;
> -       /* Device-specific data (non-legacy mode)  */
>         void __iomem *device;
> -       /* Base of vq notifications (non-legacy mode). */
>         void __iomem *notify_base;
> -       /* Physical base of vq notifications */
>         resource_size_t notify_pa;
> -       /* Where to read and clear interrupt */
>         u8 __iomem *isr;
>
> -       /* So we can sanity-check accesses. */
>         size_t notify_len;
>         size_t device_len;
>
> -       /* Capability for when we need to map notifications per-vq. */
>         int notify_map_cap;
>
> -       /* Multiply queue_notify_off by this value. (non-legacy mode). */
>         u32 notify_offset_multiplier;
> -
>         int modern_bars;
> -
>         struct virtio_device_id id;
>
> -       /* optional check for vendor virtio device, returns dev_id or -ER=
RNO */
>         int (*device_id_check)(struct pci_dev *pdev);
> -
> -       /* optional mask for devices with limited DMA space */
>         u64 dma_mask;
>  };
>
> --
> 2.17.1
>
>


