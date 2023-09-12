Return-Path: <netdev+bounces-33020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B0379C4A5
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 06:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938632815C8
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 04:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542E914F85;
	Tue, 12 Sep 2023 04:20:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487AA23A6
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:20:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C97401BE
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 21:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694492440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6LAvoxrA++ddyGlbZEfJ4woougSxOGWkQHAKbY5VPw=;
	b=UURAkTN7eCaFtdOsF86ItwEoYdsxp1fx8vOaaqpk/dsEO3VPXGua6Tp4kQooJhBAkEC99w
	riR7k60KNN1WpqgDs7inflR4qztCAATCzmkR80DninsHXsqgCXrIopYMhz4cH/ZACht/Rt
	eJFJbTS8XvcUeWL6ViCC8SSijX5SdzQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-WL1miexsPCKdThcHFLq1dQ-1; Tue, 12 Sep 2023 00:20:39 -0400
X-MC-Unique: WL1miexsPCKdThcHFLq1dQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2bc84f4d7a5so38380331fa.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 21:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694492437; x=1695097237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6LAvoxrA++ddyGlbZEfJ4woougSxOGWkQHAKbY5VPw=;
        b=anBWdiR5uxOz5MPn6kIu2XnOVe4i5ux+9MZ0E2mUPBJB+GdEaq9SoV/0NwHxWbL3Ii
         TUpyvkMgnpQ8o0bIKVte8vF0UU3Fy4sNnwZ9uP8FZYoKTyLZz/OiCEjp2lDzcT9JSASk
         N+aFwW5iJnqER3PYNE+gg8GjMOONgxOVDz3V1fmURk6Vk5qSQw+ohQ9aqCJHgorWmIz6
         K+TWR5U6BGGr7xwc06YEF9fTMgJud+87uRw2lp7ZmZ4xc6yOaDJMo0WuoduVOqEvZzlU
         lTNZ6+7X6GNWXj55/ett8w23HgXjLiRF7MmKuaiizVocrhrb5BQxihTM0n2Wgm968pCR
         CGXg==
X-Gm-Message-State: AOJu0YyrZThfDo3ljYA+GuICpaYomtzXdvEuO7chkxaxwIVwgWY1Ds9g
	hvRzIKFWzkBKyitQLTGGuABW0MNHGw0ZV37l957nErlPScr7Xd3z8Ze1s8T6y8thph7b1+MIYyk
	N3U6TYgFmqXzGEnEeMzrh2sRVtyQE6kgnICwDLiZhnHE=
X-Received: by 2002:a05:6512:2316:b0:4fe:bfa:9d8b with SMTP id o22-20020a056512231600b004fe0bfa9d8bmr517015lfu.12.1694492437309;
        Mon, 11 Sep 2023 21:20:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7S/I7ZWNi2kM9iAuPAShj8/IiRcb1wj+fArTe8MC0SS9AH0w1KXFbw0WxANKbi4vELzpAlajCjNIFW2kHyys=
X-Received: by 2002:a05:6512:2316:b0:4fe:bfa:9d8b with SMTP id
 o22-20020a056512231600b004fe0bfa9d8bmr517008lfu.12.1694492437002; Mon, 11 Sep
 2023 21:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911213104.14391-1-shannon.nelson@amd.com>
In-Reply-To: <20230911213104.14391-1-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Sep 2023 12:20:26 +0800
Message-ID: <CACGkMEv9ZXx+y=gwCBL5TbMX24rNAYSZ4_5ormVE0oeDZcr1vw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio: kdoc for struct virtio_pci_modern_device
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: kuba@kernel.org, davem@davemloft.net, mst@redhat.com, 
	virtualization@lists.linux-foundation.org, brett.creeley@amd.com, 
	netdev@vger.kernel.org, simon.horman@corigine.com, eperezma@redhat.com, 
	drivers@pensando.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 5:31=E2=80=AFAM Shannon Nelson <shannon.nelson@amd.=
com> wrote:
>
> Finally following up to Simon's suggestion for some kdoc attention
> on struct virtio_pci_modern_device.
>
> Link: https://lore.kernel.org/netdev/ZE%2FQS0lnUvxFacjf@corigine.com/
> Cc: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

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


