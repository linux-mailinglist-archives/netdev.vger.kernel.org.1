Return-Path: <netdev+bounces-234950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4900C2A18D
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 06:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A947B3AABAF
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 05:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7376B2877FA;
	Mon,  3 Nov 2025 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h12Agi+M"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80E288CA3
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149140; cv=none; b=RARy+8Z9QIHsYks27v8q8Lo7ilZ90AzVQMvrWmqGtozlbeH8GSaImads38Gulz8ST/gX0BvUlcWoZnXcQTCK6IDjiqbsnEoPpZ7hWKjh1Jes447ktElpln479J4+/Hflfnrrc4sCd9oVEQmZWWSUPjySB6isc7eHom+1kwcYYl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149140; c=relaxed/simple;
	bh=brHqwmLsUWZWUu90YyHR/skwZSeBRJ18qxv9Ln1Qnvc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=rLKcvlaO6s1oQv/IuDy//PgUpLEXU2VbJyMqNK8XzmfdWMBqNotlgRV8ehRG4hsMQOdCtMVPY3N9cFsbDXMwSg5SaMEizn04GP+GdNnFpxsweU11a1hFvvpiZ21egf9RxITnKB5xlNSPU4TDqNcu5SCXUFVV05sRFAg9A3vuUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h12Agi+M; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762149135; h=Message-ID:Subject:Date:From:To;
	bh=iTHTYpGXR3C8vFCYgy89MEG8CUL91+Y45e/S8iFDgBA=;
	b=h12Agi+M5yVUZN2bfUPaKsW8FW8hWu89tujSnUpv47RiE7HIJ/oKSRl+0sarMzVq30cA0xLXdgZsNDv7CFagh9ZxTUHbhJUCH7xyBp+oobK3eKRaJ1PSejHdzVNniXuBf7LjIIX11DyC3foaNpzCzw7qx0DAMpJVRv2y3KKlQRo=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrXRvcK_1762149134 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Nov 2025 13:52:14 +0800
Message-ID: <1762149125.9105027-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 01/12] virtio_pci: Remove supported_cap size build assert
Date: Mon, 3 Nov 2025 13:52:05 +0800
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
 <20251027173957.2334-2-danielj@nvidia.com>
In-Reply-To: <20251027173957.2334-2-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 27 Oct 2025 12:39:46 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> The cap ID list can be more than 64 bits. Remove the build assert. Also
> remove caching of the supported caps, it wasn't used.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

>
> ---
> v4: New patch for V4
> v5:
>    - support_caps -> supported_caps (Alok Tiwari)
>    - removed unused variable (test robot)
> ---
>  drivers/virtio/virtio_pci_common.h | 1 -
>  drivers/virtio/virtio_pci_modern.c | 8 +-------
>  2 files changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 8cd01de27baf..fc26e035e7a6 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -48,7 +48,6 @@ struct virtio_pci_admin_vq {
>  	/* Protects virtqueue access. */
>  	spinlock_t lock;
>  	u64 supported_cmds;
> -	u64 supported_caps;
>  	u8 max_dev_parts_objects;
>  	struct ida dev_parts_ida;
>  	/* Name of the admin queue: avq.$vq_index. */
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index dd0e65f71d41..ff11de5b3d69 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -304,7 +304,6 @@ virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
>
>  static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
>  {
> -	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
>  	struct virtio_admin_cmd_query_cap_id_result *data;
>  	struct virtio_admin_cmd cmd = {};
>  	struct scatterlist result_sg;
> @@ -323,12 +322,7 @@ static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
>  	if (ret)
>  		goto end;
>
> -	/* Max number of caps fits into a single u64 */
> -	BUILD_BUG_ON(sizeof(data->supported_caps) > sizeof(u64));
> -
> -	vp_dev->admin_vq.supported_caps = le64_to_cpu(data->supported_caps[0]);
> -
> -	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
> +	if (!(le64_to_cpu(data->supported_caps[0]) & (1 << VIRTIO_DEV_PARTS_CAP)))
>  		goto end;
>
>  	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
> --
> 2.50.1
>

