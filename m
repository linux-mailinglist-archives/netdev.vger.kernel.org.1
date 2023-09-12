Return-Path: <netdev+bounces-33381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F4C79DA4A
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 22:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CD1281799
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74267AD4F;
	Tue, 12 Sep 2023 20:53:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E5A959
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 20:53:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B45DF199
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694552031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7gqxsWGxYdMmHjhvfD7Qqc8EetmHcPGV2O7WRpaBLQ=;
	b=LnBDizzfL++gZ96TAcmaG2Mb1uWsdecdatM4J3/1Q2bWFpxkDyIH/bgpzwJCQ2PJseYPLP
	W1apgB7K3iljEcpTCtPALdOEwV4V7p/DLiSahuSRR67eumrNeNF3es7P+nDv3w4u8J/1nB
	s2jAahtnsLBrFyXXE8iKb8+xVOoa8HY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-dr-DxHYvPX2ZMxI2jC0Iug-1; Tue, 12 Sep 2023 16:53:50 -0400
X-MC-Unique: dr-DxHYvPX2ZMxI2jC0Iug-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-52c6f3886e3so4175145a12.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694552028; x=1695156828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7gqxsWGxYdMmHjhvfD7Qqc8EetmHcPGV2O7WRpaBLQ=;
        b=rR9/rhZ8mmSp16hFPHInK+lalYpdDYr7kQE/3AsrJzw6g4Jpme3VnxoTDT5oBbYEoD
         bc1SWhT0k4dmBIWK8V4Y/SDQE9C3Bm9GnsMCCuqANa6AwCw0g/EtV9NJzfvuSYogUF57
         eBXcaaI5Xu+740wKbkecRBM5fbB43IWbIqql0p9NuHi+S/8NqCcDoECg0Vc7GYCLG/wH
         lh0GGB5Bqz8/elk2X3D0f58Jt887kUtz37Zj9CX2YrHd9sNCC1GAblNjTPAhprK5pcfV
         xHedLtM9raoh8IuHsMouHSTfQRT3xK8KjaHWPjdhzlOvuheRHBn5DsHxdae1Oi9zZdPh
         UegA==
X-Gm-Message-State: AOJu0YwZO/YqqqdFymwr1O2Kh3vD753Q4mpm0grfJudNcOv9a6ahJUPp
	0eC/l6yDZ6R/D3kQ9RyfPTigB5JxER5gJ289O4zp34lGs3JyU8oq4bBUE7LOIkSh1mAVLuH/aA4
	nLjWng2laHXxKyxybA2TeXC85
X-Received: by 2002:a05:6402:6d0:b0:521:a4bb:374f with SMTP id n16-20020a05640206d000b00521a4bb374fmr725829edy.5.1694552028477;
        Tue, 12 Sep 2023 13:53:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc2BLxKU/ksq/+8WwZzj4E5STO0xOwYElcI4SSFgQhPbX048/Lcnncc+nW3pYUPefRnpegTA==
X-Received: by 2002:a05:6402:6d0:b0:521:a4bb:374f with SMTP id n16-20020a05640206d000b00521a4bb374fmr725815edy.5.1694552028183;
        Tue, 12 Sep 2023 13:53:48 -0700 (PDT)
Received: from redhat.com ([2.52.10.100])
        by smtp.gmail.com with ESMTPSA id bc3-20020a056402204300b0052348d74865sm6224540edb.61.2023.09.12.13.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 13:53:47 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:53:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: kuba@kernel.org, davem@davemloft.net, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org, brett.creeley@amd.com,
	netdev@vger.kernel.org, simon.horman@corigine.com,
	eperezma@redhat.com, drivers@pensando.io
Subject: Re: [PATCH net-next] virtio: kdoc for struct virtio_pci_modern_device
Message-ID: <20230912165335-mutt-send-email-mst@kernel.org>
References: <20230911213104.14391-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911213104.14391-1-shannon.nelson@amd.com>

On Mon, Sep 11, 2023 at 02:31:04PM -0700, Shannon Nelson wrote:
> Finally following up to Simon's suggestion for some kdoc attention
> on struct virtio_pci_modern_device.
> 
> Link: https://lore.kernel.org/netdev/ZE%2FQS0lnUvxFacjf@corigine.com/
> Cc: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Acked-by: Eugenio Pérez <eperezma@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/virtio_pci_modern.h | 34 ++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index 067ac1d789bc..a38c729d1973 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -12,37 +12,47 @@ struct virtio_pci_modern_common_cfg {
>  	__le16 queue_reset;		/* read-write */
>  };
>  
> +/**
> + * struct virtio_pci_modern_device - info for modern PCI virtio
> + * @pci_dev:	    Ptr to the PCI device struct
> + * @common:	    Position of the common capability in the PCI config
> + * @device:	    Device-specific data (non-legacy mode)
> + * @notify_base:    Base of vq notifications (non-legacy mode)
> + * @notify_pa:	    Physical base of vq notifications
> + * @isr:	    Where to read and clear interrupt
> + * @notify_len:	    So we can sanity-check accesses
> + * @device_len:	    So we can sanity-check accesses
> + * @notify_map_cap: Capability for when we need to map notifications per-vq
> + * @notify_offset_multiplier: Multiply queue_notify_off by this value
> + *                            (non-legacy mode).
> + * @modern_bars:    Bitmask of BARs
> + * @id:		    Device and vendor id
> + * @device_id_check: Callback defined before vp_modern_probe() to be used to
> + *		    verify the PCI device is a vendor's expected device rather
> + *		    than the standard virtio PCI device
> + *		    Returns the found device id or ERRNO
> + * @dma_mask:	    Optional mask instead of the traditional DMA_BIT_MASK(64),
> + *		    for vendor devices with DMA space address limitations
> + */
>  struct virtio_pci_modern_device {
>  	struct pci_dev *pci_dev;
>  
>  	struct virtio_pci_common_cfg __iomem *common;
> -	/* Device-specific data (non-legacy mode)  */
>  	void __iomem *device;
> -	/* Base of vq notifications (non-legacy mode). */
>  	void __iomem *notify_base;
> -	/* Physical base of vq notifications */
>  	resource_size_t notify_pa;
> -	/* Where to read and clear interrupt */
>  	u8 __iomem *isr;
>  
> -	/* So we can sanity-check accesses. */
>  	size_t notify_len;
>  	size_t device_len;
>  
> -	/* Capability for when we need to map notifications per-vq. */
>  	int notify_map_cap;
>  
> -	/* Multiply queue_notify_off by this value. (non-legacy mode). */
>  	u32 notify_offset_multiplier;
> -
>  	int modern_bars;
> -
>  	struct virtio_device_id id;
>  
> -	/* optional check for vendor virtio device, returns dev_id or -ERRNO */
>  	int (*device_id_check)(struct pci_dev *pdev);
> -
> -	/* optional mask for devices with limited DMA space */
>  	u64 dma_mask;
>  };
>  
> -- 
> 2.17.1


