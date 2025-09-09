Return-Path: <netdev+bounces-221303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DDAB5018D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0F907BE637
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9013570AE;
	Tue,  9 Sep 2025 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLaoMygv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C2350820;
	Tue,  9 Sep 2025 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431792; cv=none; b=d5gQJVUE0XFYkmYfw3Q/tVd1qeLTv3TiNF/GSXO2Is1uWRMUtNggu51U4RsHbAKVJxjPi16wFJLQEutg1h+oiKj7XaW6sTpYo4fQZkHSX4o3GjIoUaCXHM2KqER/6LYlK0jt3EFEOmRVp7jp1iRlWXz2DRWiE2gdF2tHPSu2EXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431792; c=relaxed/simple;
	bh=gnSZ009TbhMPnnauveV95W6+WSVRAPHvvwU+16TjJ94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxcDx+VqGCbV9qzkl77HjrWSiYeFtaA6RF6PVR4kI7KqPo1rJapupLT4Edj6l4bSyDY+xEm5B6lkeeQymoxjDsLKvSJUKO6IaC/TD/wQY3R8Rl5yzo9co8TDwLpv5tbaM2FtP1BJCGrMm9Jc1Nx3NmbfV5gSCsdWhz8ynTWfV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLaoMygv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0078CC4CEFB;
	Tue,  9 Sep 2025 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757431792;
	bh=gnSZ009TbhMPnnauveV95W6+WSVRAPHvvwU+16TjJ94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLaoMygvQeudCxBCmlMph7ApSpewjTyman3XH1/JZcXGtVVtAHEBZ/FTaoiU9ORaG
	 re6z6FAAZO7mODWhuQxPc4onh52rA/TpwyUuhTH7prclk2ylpHFFAwZISVIgaVkVea
	 YhMZOihBDy4Cg9Kp8zlC06+1Nj9GrPIejXV+kJcw5HNTiCEI7SMr0ddtI+MadU9ktp
	 guRfAmxhKTNkTrNjEywz2IcJPFz9SWvvadOJrcZ2y5YVS3ozlaE7vbaIRbQw4Wljco
	 nDzLrYAKSeTnfFZk2ijXe2yNCXJVfIZpmr/IhYDc47u1MPNIfK2nw4mnMMXkvoPEOA
	 8xJng89nq+iMw==
Date: Tue, 9 Sep 2025 16:29:47 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	alex.williamson@redhat.com, virtualization@lists.linux.dev,
	pabeni@redhat.com, parav@nvidia.com, shshitrit@nvidia.com,
	yohadt@nvidia.com, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH net-next v2 01/11] virtio-pci: Expose generic device
 capability operations
Message-ID: <20250909152947.GA20205@horms.kernel.org>
References: <20250908164046.25051-1-danielj@nvidia.com>
 <20250908164046.25051-2-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908164046.25051-2-danielj@nvidia.com>

On Mon, Sep 08, 2025 at 11:40:36AM -0500, Daniel Jurgens wrote:

...

> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index db31fc6f4f1f..a6e121b6f1f1 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -12,6 +12,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/completion.h>
>  #include <linux/virtio_features.h>
> +#include <linux/virtio_admin.h>
>  
>  /**
>   * struct virtqueue - a queue to register buffers for sending or receiving.
> @@ -161,6 +162,7 @@ struct virtio_device {
>  	struct virtio_device_id id;
>  	const struct virtio_config_ops *config;
>  	const struct vringh_config_ops *vringh_config;
> +	const struct virtio_admin_ops *admin_ops;

nit: Please consider also adding admin_ops to the Kernel doc for
     struct virtio_device.

>  	struct list_head vqs;
>  	VIRTIO_DECLARE_FEATURES(features);
>  	void *priv;

...

