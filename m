Return-Path: <netdev+bounces-234951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 347B8C2A193
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 06:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26EF34E5A0F
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 05:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3745288C25;
	Mon,  3 Nov 2025 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MXJYJZbl"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943AA2877FA
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149151; cv=none; b=FYQ3ZL25bjT/ate+E3Q75hy5Rr79iDAotdZ1NC9acNZUZIkTw6BKZtxz/GKaqsbiIqNUQFR/nMCNXroepy6LeQUlGsmyqvSmYJVWEJcfCQHifLqQ++i5uQ4zw5LbxWxlG2YOX+38zOMp3Mxvm3LiBRAXt20o/6Y9dz1fDaFPfGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149151; c=relaxed/simple;
	bh=h1q1IXh9U3iBuNiSm2KO8xYBEesiDIHbHwi3p7ms9uw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=mUJwigg5eIx4kY0g/gGxf5XoNa3CJDIDl4o8kiMBhah9Pt1387JZ7vQywtnnE1vq7rEv0lV3IuHWQnNQu8rjoTVtZc+5Ob8/MtFy0brKPNYp/516kQ32W26cT/QhUAQw/3Vr04ynaC+dId0qdzgHA4yFAwE+/vLcD/18QjJyvIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MXJYJZbl; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762149145; h=Message-ID:Subject:Date:From:To;
	bh=afTtka6ni8L8kr17yyNJs3Rfnbnht7lmYWlbw1okYkk=;
	b=MXJYJZbltftzag9qW+xr1cDTvne9TSoxRkoTlFFoAMpplfHQlCLsvDwghWwhkxkpJvX7meeKhu26UGZnCUq2/qqKnyzmjzX33PKqD0a+szp93dP1S8Z6Z92saE3o7ExcmYpFB8GjqLfawDDqf9fAsWZUroWj/J5WOZOR8D56SeY=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrXRvfi_1762149144 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Nov 2025 13:52:25 +0800
Message-ID: <1762149138.1701145-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 02/12] virtio: Add config_op for admin commands
Date: Mon, 3 Nov 2025 13:52:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <virtualization@lists.linux.dev>,
 <parav@nvidia.com>,
 <shshitrit@nvidia.com>,
 <yohadt@nvidia.com>,
 <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>,
 <shameerali.kolothum.thodi@huawei.com>,
 <jgg@ziepe.ca>,
 <kevin.tian@intel.com>,
 <kuba@kernel.org>,
 <andrew+netdev@lunn.ch>,
 <edumazet@google.com>,
 Daniel Jurgens <danielj@nvidia.com>,
 <netdev@vger.kernel.org>,
 <mst@redhat.com>,
 <jasowang@redhat.com>,
 <alex.williamson@redhat.com>,
 <pabeni@redhat.com>
References: <20251027173957.2334-1-danielj@nvidia.com>
 <20251027173957.2334-3-danielj@nvidia.com>
In-Reply-To: <20251027173957.2334-3-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 27 Oct 2025 12:39:47 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> This will allow device drivers to issue administration commands.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

>
> ---
> v4: New patch for v4
> ---
>  drivers/virtio/virtio_pci_modern.c | 2 ++
>  include/linux/virtio_config.h      | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index ff11de5b3d69..acc3f958f96a 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -1236,6 +1236,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.admin_cmd_exec = vp_modern_admin_cmd_exec,
>  };
>
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> @@ -1256,6 +1257,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.admin_cmd_exec = vp_modern_admin_cmd_exec,
>  };
>
>  /* the PCI probing function */
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 16001e9f9b39..19606609254e 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -108,6 +108,10 @@ struct virtqueue_info {
>   *	Returns 0 on success or error status
>   *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
>   *	set.
> + * @admin_cmd_exec: Execute an admin VQ command.
> + *	vdev: the virtio_device
> + *	cmd: the command to execute
> + *	Returns 0 on success or error status
>   */
>  struct virtio_config_ops {
>  	void (*get)(struct virtio_device *vdev, unsigned offset,
> @@ -137,6 +141,8 @@ struct virtio_config_ops {
>  			       struct virtio_shm_region *region, u8 id);
>  	int (*disable_vq_and_reset)(struct virtqueue *vq);
>  	int (*enable_vq_after_reset)(struct virtqueue *vq);
> +	int (*admin_cmd_exec)(struct virtio_device *vdev,
> +			      struct virtio_admin_cmd *cmd);
>  };
>
>  /**
> --
> 2.50.1
>

