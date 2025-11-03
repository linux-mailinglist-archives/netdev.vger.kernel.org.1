Return-Path: <netdev+bounces-234953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4485AC2A19F
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 06:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4403AC505
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 05:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5DD28C5B8;
	Mon,  3 Nov 2025 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="atWmmoYp"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B014628B4F0
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 05:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149188; cv=none; b=naRk8qE8buZeb4poOzH3jxRJWaEiU7OO/McDEaBp0kW8aIpvtxNP0FqLM+2/i2Uc6rBU826S+UO6KcKRCqAwDMXozUsF/DjGTvRfnnGqpJ53AN8rqSy6U7LTaq01dcJHmaSj5w7pCtOsmWom5waPXS5v0+PoSOjd/IFJRPSq6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149188; c=relaxed/simple;
	bh=4BspCf86vbIia40I49o6bkPUwiTNmvBXFuaa8dzhugg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=fP2ICx04Xce0NKhZv0FBs4AibqE59TwXFVqYAK2TwTlxkl4DVivwudyDEC5/+mWyncMTf79KrKzLU77cLYLq+kK/hVAzgufGmeOQsadZd/761+UI7D7Fg55sTwju2RRgzhI0JCQHwx48FpES5SKh94NwZ8b9Gtyw711F+3U0oEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=atWmmoYp; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762149182; h=Message-ID:Subject:Date:From:To;
	bh=Y4LQcn2dUfRQQ0yXMJpCXP0K66RO9bdEkYFxMNILUI8=;
	b=atWmmoYpsWPgBsLnE+IMX0V+GHtAhzz6UcXu5MYEzcwLNsYEz8U4/WnDvqSqvo9XK1NUKnL3OktdXOU5CSFLuZkTeiNT42/rPSEtR5rj8MJAezwQwj3D6DY2rwNax11EF4gH4ckBb6Q8dKxPDW+YHZzXytlsNlUKO63RV1mN1Fw=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrXRvuM_1762149181 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Nov 2025 13:53:02 +0800
Message-ID: <1762149174.8174753-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 04/12] virtio: Expose object create and destroy API
Date: Mon, 3 Nov 2025 13:52:54 +0800
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
 <20251027173957.2334-5-danielj@nvidia.com>
In-Reply-To: <20251027173957.2334-5-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 27 Oct 2025 12:39:49 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> Object create and destroy were implemented specifically for dev parts
> device objects. Create general purpose APIs for use by upper layer
> drivers.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

>
> ---
> v4: Moved this logic from virtio_pci_modern to new file
>     virtio_admin_commands.
> v5: Added missing params, and synced names in comments (Alok Tiwari)
> ---
>  drivers/virtio/virtio_admin_commands.c | 75 ++++++++++++++++++++++++++
>  include/linux/virtio_admin.h           | 44 +++++++++++++++
>  2 files changed, 119 insertions(+)
>
> diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
> index 94751d16b3c4..2b80548ba3bc 100644
> --- a/drivers/virtio/virtio_admin_commands.c
> +++ b/drivers/virtio/virtio_admin_commands.c
> @@ -88,3 +88,78 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
> +
> +int virtio_admin_obj_create(struct virtio_device *vdev,
> +			    u16 obj_type,
> +			    u32 obj_id,
> +			    u16 group_type,
> +			    u64 group_member_id,
> +			    const void *obj_specific_data,
> +			    size_t obj_specific_data_size)
> +{
> +	size_t data_size = sizeof(struct virtio_admin_cmd_resource_obj_create_data);
> +	struct virtio_admin_cmd_resource_obj_create_data *obj_create_data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist data_sg;
> +	void *data;
> +	int err;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	data_size += obj_specific_data_size;
> +	data = kzalloc(data_size, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	obj_create_data = data;
> +	obj_create_data->hdr.type = cpu_to_le16(obj_type);
> +	obj_create_data->hdr.id = cpu_to_le32(obj_id);
> +	memcpy(obj_create_data->resource_obj_specific_data, obj_specific_data,
> +	       obj_specific_data_size);
> +	sg_init_one(&data_sg, data, data_size);
> +
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE);
> +	cmd.group_type = cpu_to_le16(group_type);
> +	cmd.group_member_id = cpu_to_le64(group_member_id);
> +	cmd.data_sg = &data_sg;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> +	kfree(data);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_obj_create);
> +
> +int virtio_admin_obj_destroy(struct virtio_device *vdev,
> +			     u16 obj_type,
> +			     u32 obj_id,
> +			     u16 group_type,
> +			     u64 group_member_id)
> +{
> +	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist data_sg;
> +	int err;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->type = cpu_to_le16(obj_type);
> +	data->id = cpu_to_le32(obj_id);
> +	sg_init_one(&data_sg, data, sizeof(*data));
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_DESTROY);
> +	cmd.group_type = cpu_to_le16(group_type);
> +	cmd.group_member_id = cpu_to_le64(group_member_id);
> +	cmd.data_sg = &data_sg;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> +	kfree(data);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> index 36df97b6487a..039b996f73ec 100644
> --- a/include/linux/virtio_admin.h
> +++ b/include/linux/virtio_admin.h
> @@ -77,4 +77,48 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
>  			 const void *caps,
>  			 size_t cap_size);
>
> +/**
> + * virtio_admin_obj_create - Create an object on a virtio device
> + * @vdev: the virtio device
> + * @obj_type: type of object to create
> + * @obj_id: ID for the new object
> + * @group_type: administrative group type for the operation
> + * @group_member_id: member identifier within the administrative group
> + * @obj_specific_data: object-specific data for creation
> + * @obj_specific_data_size: size of the object-specific data in bytes
> + *
> + * Creates a new object on the virtio device with the specified type and ID.
> + * The object may require object-specific data for proper initialization.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
> + * operations or object creation, or a negative error code on other failures.
> + */
> +int virtio_admin_obj_create(struct virtio_device *vdev,
> +			    u16 obj_type,
> +			    u32 obj_id,
> +			    u16 group_type,
> +			    u64 group_member_id,
> +			    const void *obj_specific_data,
> +			    size_t obj_specific_data_size);
> +
> +/**
> + * virtio_admin_obj_destroy - Destroy an object on a virtio device
> + * @vdev: the virtio device
> + * @obj_type: type of object to destroy
> + * @obj_id: ID of the object to destroy
> + * @group_type: administrative group type for the operation
> + * @group_member_id: member identifier within the administrative group
> + *
> + * Destroys an existing object on the virtio device with the specified type
> + * and ID.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
> + * operations or object destruction, or a negative error code on other failures.
> + */
> +int virtio_admin_obj_destroy(struct virtio_device *vdev,
> +			     u16 obj_type,
> +			     u32 obj_id,
> +			     u16 group_type,
> +			     u64 group_member_id);
> +
>  #endif /* _LINUX_VIRTIO_ADMIN_H */
> --
> 2.50.1
>

