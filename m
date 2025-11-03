Return-Path: <netdev+bounces-234931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA6C29E19
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 03:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9BE1887F50
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 02:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC76C2820A9;
	Mon,  3 Nov 2025 02:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qzqsDmHb"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0D1C5D77
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 02:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762138051; cv=none; b=BhS2FZcp5zP1ozcjA5zPIOYEMuwWFW9g2rjAiL09Ykc0Cgx63KLuPTDs9JcyCi57wtO1cK1UNdkh+DJhO//eKNTcR04hsCVmWU4TpODae01D1w5atWj7bc+KOS9jBK5CYV0435nad28lNi3DbuaO1T30Sq5/uWOCS47mjXxcRoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762138051; c=relaxed/simple;
	bh=LEPm2c4qtBl2T46rH4ITrp+B+Kz4bvpY8XnnQ+ovD+g=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=VOWCZ9SleDjJYbXtqG0wReUb0LxkkNR773wYU4O/RZGeapYcs8VycDlvxn22tqlOmSyne7LGgXdTkMeyimvMjjJ2gvr24lJVt5Kntu0RfsODkhX9HDaYUHPMH6lf/zqT1AzBLwg+iQ4PsVEMZEO3ed+Ec9Y4TrZSiCC3h8tero0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qzqsDmHb; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762138041; h=Message-ID:Subject:Date:From:To;
	bh=9l+4VzDjWX1NJHCbPVBWAGY6TQ5FSqwHDj06RomNQyg=;
	b=qzqsDmHbYvDKUF2WW+8cp3bjigdUlWeiQOTuuHWQRzlIdlSdIl1iCfBA2BsMi1yqM9Y2R7QpaegBDnoWK8fr1Y1LP1yAbAOSXU4+ACQXZ7EDnCsvGYhvf+VNsAua/AeHsXRDmPXuIM4l5PteL/yLoosfPXDhGQR7sP5IUzLS9tM=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrVnH7b_1762138040 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Nov 2025 10:47:20 +0800
Message-ID: <1762138033.0221238-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 06/12] virtio_net: Create a FF group for ethtool steering
Date: Mon, 3 Nov 2025 10:47:13 +0800
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
 <20251027173957.2334-7-danielj@nvidia.com>
In-Reply-To: <20251027173957.2334-7-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 27 Oct 2025 12:39:51 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> All ethtool steering rules will go in one group, create it during
> initialization.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> v4: Documented UAPI
> ---
>  drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a9fde879fdbf..10700e447959 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -284,6 +284,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>  };
>
> +#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
> +#define VIRTNET_FF_MAX_GROUPS 1
> +
>  struct virtnet_ff {
>  	struct virtio_device *vdev;
>  	bool ff_supported;
> @@ -6791,6 +6794,7 @@ static void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
>  			      sizeof(struct virtio_net_ff_selector) *
>  			      VIRTIO_NET_FF_MASK_TYPE_MAX;
> +	struct virtio_net_resource_obj_ff_group ethtool_group = {};
>  	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
>  	struct virtio_net_ff_selector *sel;
>  	size_t real_ff_mask_size;
> @@ -6855,6 +6859,12 @@ static void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>
> +	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
> +		err = -ENOSPC;
> +		goto err_ff_action;
> +	}
> +	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
> +
>  	err = virtio_admin_cap_set(vdev,
>  				   VIRTIO_NET_FF_RESOURCE_CAP,
>  				   ff->ff_caps,
> @@ -6893,6 +6903,19 @@ static void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>
> +	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> +
> +	/* Use priority for the object ID. */
> +	err = virtio_admin_obj_create(vdev,
> +				      VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +				      VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				      0,
> +				      &ethtool_group,
> +				      sizeof(ethtool_group));
> +	if (err)
> +		goto err_ff_action;
> +
>  	ff->vdev = vdev;
>  	ff->ff_supported = true;
>
> @@ -6915,6 +6938,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>  	if (!ff->ff_supported)
>  		return;
>
> +	virtio_admin_obj_destroy(ff->vdev,
> +				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
> +				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				 0);
> +
>  	kfree(ff->ff_actions);
>  	kfree(ff->ff_mask);
>  	kfree(ff->ff_caps);
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> index bd7a194a9959..6d1f953c2b46 100644
> --- a/include/uapi/linux/virtio_net_ff.h
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -12,6 +12,8 @@
>  #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
>  #define VIRTIO_NET_FF_ACTION_CAP 0x802
>
> +#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
> +
>  /**
>   * struct virtio_net_ff_cap_data - Flow filter resource capability limits
>   * @groups_limit: maximum number of flow filter groups supported by the device
> @@ -88,4 +90,17 @@ struct virtio_net_ff_actions {
>  	__u8 reserved[7];
>  	__u8 actions[];
>  };
> +
> +/**
> + * struct virtio_net_resource_obj_ff_group - Flow filter group object
> + * @group_priority: priority of the group used to order evaluation
> + *
> + * This structure is the payload for the VIRTIO_NET_RESOURCE_OBJ_FF_GROUP
> + * administrative object. Devices use @group_priority to order flow filter
> + * groups. Multi-byte fields are little-endian.
> + */
> +struct virtio_net_resource_obj_ff_group {
> +	__le16 group_priority;
> +};
> +
>  #endif
> --
> 2.50.1
>

