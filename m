Return-Path: <netdev+bounces-33382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E5279DA4D
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 22:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D651C20BFD
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE381B64C;
	Tue, 12 Sep 2023 20:54:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E359470
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 20:54:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A14BE199
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694552063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijWxXQrMbFDRYhu2hkP5ViJPf81XjON2E0T1RctinI0=;
	b=CM02FocD+cj6WPX2nTeL0EINIg3MMMFi7ImOSmL7FgAe05sYIkzZ4VQIz0HRGu2LL0hmBm
	HC/5zsnlFvzs79+XJgoGDiTnAeKM9ocNoF6fdCNO67uIghi4TnCsdZLrfRnOUeRFPSsoDF
	xRZelhG1ui1ylOUzHZ2xENDi0p2jBmE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-mOqN_m-AMneK7l7p9Qf-dQ-1; Tue, 12 Sep 2023 16:54:21 -0400
X-MC-Unique: mOqN_m-AMneK7l7p9Qf-dQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a9e3f703dfso375424166b.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694552060; x=1695156860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijWxXQrMbFDRYhu2hkP5ViJPf81XjON2E0T1RctinI0=;
        b=HOqACCJsbhBKjZYEWnjjoF8Z61mKkNMcaExFTNNdBUk2gAR7RBm5+i518fUKEClOFX
         jJVCUrKZHmaptY8GStK5jY18GcgEosOlkFxaXm3I81YXvRI6/421Tn6zUCzTG3pMuC01
         APY4SbOa372FTmZCkOu5gERbiVYnZ9ONlY4AZONTHFO7TJXoYsXxCR+FTTpNt+02IQ34
         YEOR4EbHN1U9nSMEcUsqztOynChwCQDD/FHxb486jcuOjIWCFU+UFqMk/p+R5QtLfz53
         pvWFKUhiKIbzOMXfyAv3xO2U2LAQ7MBma7YKYVCYfcS1pUijQnqPAK+V829WKw9SwTWt
         HcKg==
X-Gm-Message-State: AOJu0YzEJE8m/V2A/I7JvY/qTJWsbSdgfW2y/Zlcl8CBzjViBxDCh9g0
	djKGf2CKuQH9zSsYlKtEu3P4g+6fNuNz5BxqJWTtqIKG7HoAdRme5Sxc0CGfMY2c1EkeVgDp+qv
	mz7645fcd+G939co+
X-Received: by 2002:a17:907:762d:b0:9a1:edfd:73b2 with SMTP id jy13-20020a170907762d00b009a1edfd73b2mr333968ejc.2.1694552060374;
        Tue, 12 Sep 2023 13:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnYBJkuLhJzI88PFNoikAiC6EDSv3wLMLb4ZDAGoRXLAyQXdTnHGROIdoQ7FcDxEiAcFo9rQ==
X-Received: by 2002:a17:907:762d:b0:9a1:edfd:73b2 with SMTP id jy13-20020a170907762d00b009a1edfd73b2mr333957ejc.2.1694552060112;
        Tue, 12 Sep 2023 13:54:20 -0700 (PDT)
Received: from redhat.com ([2.52.10.100])
        by smtp.gmail.com with ESMTPSA id h10-20020a1709063b4a00b009737b8d47b6sm7203807ejf.203.2023.09.12.13.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 13:54:19 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:54:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: kuba@kernel.org, davem@davemloft.net, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org, brett.creeley@amd.com,
	netdev@vger.kernel.org, simon.horman@corigine.com,
	eperezma@redhat.com, drivers@pensando.io
Subject: Re: [PATCH net-next] virtio: kdoc for struct virtio_pci_modern_device
Message-ID: <20230912165357-mutt-send-email-mst@kernel.org>
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

not sure why this is net material though.
I think I will take it in virtio tree.

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


