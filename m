Return-Path: <netdev+bounces-13030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 151C1739FBC
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F6A1C210B5
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3DF1B8FC;
	Thu, 22 Jun 2023 11:38:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2A93AA8C
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:38:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C562101
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 04:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687433838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W7SKEzo0tiPtjA/r8jOe2vPyIc6DKSYtWpFv1BZVSgU=;
	b=Et4xGHTBY5geu4WiDFyWr0DhpLyP73vfB026rF5OrfHiW8qUNFaOFrKwSjwBSDj2aZgIoq
	BGCdl1o84fq5xeBW5HQFzrczWyldj9rC8hlJ+0mWs6HuVT9JzONXw7BlLrq5xjeS9H8+Vl
	Nkr+wO/S6Q8010k1SpogzoXqoGnrcG0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-YS2OdNzePKO6umhmEZO6rg-1; Thu, 22 Jun 2023 07:37:17 -0400
X-MC-Unique: YS2OdNzePKO6umhmEZO6rg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94f7a2b21fdso619729166b.2
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 04:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687433836; x=1690025836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7SKEzo0tiPtjA/r8jOe2vPyIc6DKSYtWpFv1BZVSgU=;
        b=hV3fqCNk3uFUx+8EATJaaONUmgUgfRc/krMI5LQHpg2WabNqbJGGyg3NksSH6u2TsX
         jwM3+I54/G9A/VgEO7ObXxpuTvKAwjRQv/om2Hfk8GCAeCYyT4nFBNev8xdn8vabKSMS
         6IAQvc+JXWJxht+Ch/hqHnhg2Y1WgShCvrUlD7Vo9H2GEa8/5Z42W9pkXicUPkpXC6mK
         m8j1Mx4rmsPqbR1kVGkbTX0nXIPzSZZqEoCp6FKmvrrVfU8xiaPRBzNN3iJI0NysegI0
         AsZjb19QlfZBFz2Jzd5TQt4vTQg2Ai8mP3sxojRi3uGDKUeI6Vr3YpzBcLbHYKn94nIT
         A+qg==
X-Gm-Message-State: AC+VfDwDdV0nqzULCPZM9wsOPcWKAii7XDlToyyyISYCTU0ymbdYDvCw
	4Ld79XXaQNHxuMqn02mO4Ef8bYEnKUleavDWrx2VU2pLnKsjBGuGBgpJUxsWc1UBk9jjS+yvjxf
	fnOAvvOqE7EcRgh/v
X-Received: by 2002:a17:907:9810:b0:96f:bcea:df87 with SMTP id ji16-20020a170907981000b0096fbceadf87mr18311952ejc.42.1687433836424;
        Thu, 22 Jun 2023 04:37:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+6ZFEmHAogYeFG0AWvOJXQRz4NqoLSKP89l/++Hp1rS3Ll408wTBVz5tejEgoel33u4yaOA==
X-Received: by 2002:a17:907:9810:b0:96f:bcea:df87 with SMTP id ji16-20020a170907981000b0096fbceadf87mr18311937ejc.42.1687433836129;
        Thu, 22 Jun 2023 04:37:16 -0700 (PDT)
Received: from redhat.com ([2.52.159.126])
        by smtp.gmail.com with ESMTPSA id l11-20020a170906644b00b00988956f244csm4586680ejn.6.2023.06.22.04.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:37:15 -0700 (PDT)
Date: Thu, 22 Jun 2023 07:37:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230622073625-mutt-send-email-mst@kernel.org>
References: <20230605110644.151211-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605110644.151211-1-sgarzare@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
> vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
> don't support packed virtqueue well yet, so let's filter the
> VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
> 
> This way, even if the device supports it, we don't risk it being
> negotiated, then the VMM is unable to set the vring state properly.
> 
> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

OK so for now I dropped this, we have a better fix upstream.

> ---
> 
> Notes:
>     This patch should be applied before the "[PATCH v2 0/3] vhost_vdpa:
>     better PACKED support" series [1] and backported in stable branches.
>     
>     We can revert it when we are sure that everything is working with
>     packed virtqueues.
>     
>     Thanks,
>     Stefano
>     
>     [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/
> 
>  drivers/vhost/vdpa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 8c1aefc865f0..ac2152135b23 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -397,6 +397,12 @@ static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
>  
>  	features = ops->get_device_features(vdpa);
>  
> +	/*
> +	 * IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE) don't support
> +	 * packed virtqueue well yet, so let's filter the feature for now.
> +	 */
> +	features &= ~BIT_ULL(VIRTIO_F_RING_PACKED);
> +
>  	if (copy_to_user(featurep, &features, sizeof(features)))
>  		return -EFAULT;
>  
> 
> base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
> -- 
> 2.40.1


