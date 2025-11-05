Return-Path: <netdev+bounces-235814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D5CC36049
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 15:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9734F4E6EE0
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 14:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5B522D785;
	Wed,  5 Nov 2025 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIWcwzHH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A7321CFF6;
	Wed,  5 Nov 2025 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352393; cv=none; b=VFKU7sAm32/JRQ529mxPxHCpumvoC8hIUyTnq+ExqWpSneXbw4XpezWctglVPCuaKV0l2y5+iycNDlHwRIjx3jRAQBnTrmi+96WSWDLPRZPLkEoxXoD6FWjl+FA1veKOq11rNhEw4p3W3c1iJijRVJXyfIalmJb0DpGLQKlmwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352393; c=relaxed/simple;
	bh=Yxpd5GlPnzRHRD85/yNv+ei8nAB9qXHt9wQG+oedP2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9tIIlOXJm+7SCIo0PVnAnkUbmw7LgfZsWtEnvX41sIWKVZUi5LjceWP0XCx4blkp6QnlY+5X+530PIde/RMcePsXTnsdIGNR4/vRdRSkVQ4MfLeZCzhOqq+1xojwtkiYAaKuCqcz1fN+3ICIpEnU+z3lhxQ55Aq4hD9waZalRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIWcwzHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F9FC4CEF5;
	Wed,  5 Nov 2025 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762352393;
	bh=Yxpd5GlPnzRHRD85/yNv+ei8nAB9qXHt9wQG+oedP2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIWcwzHHWUP4L5zcWtIkYU3AZ0fOWWHZipMskgE9146l4qQQOm7yGumrnW6jBOOK0
	 DZwzV+yP9dpL4vF0ycebaIReMocf4LjP/8GWtxzNJS9HXFsRwGsoPEDZ7Mz94xPSZI
	 zZGOINNLkjEG2IINmYTvN60ompniMFj+8Hr1YSRNB26uwOZeqw7AAvTQI9p6Cdvmpo
	 6oeDgwOLapAdxtp6ZmoOBYFk9lwOrWOfzFBSEtmwBZgOt2euXvzR/r+acLf6P7ni0s
	 bMekGhDRmgnRdjotOuTIHZdb8wbIwwLwWPsVPP5RnFZfKk54pbFUjle26GBIcLsDHK
	 tQs+9q5xcwMoA==
Date: Wed, 5 Nov 2025 14:19:47 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	alex.williamson@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v7 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <aQtdA1YGpePiepXV@horms.kernel.org>
References: <20251103225514.2185-1-danielj@nvidia.com>
 <20251103225514.2185-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103225514.2185-6-danielj@nvidia.com>

On Mon, Nov 03, 2025 at 04:55:07PM -0600, Daniel Jurgens wrote:

...

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c

...

> +static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
> +{
> +	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
> +			      sizeof(struct virtio_net_ff_selector) *
> +			      VIRTIO_NET_FF_MASK_TYPE_MAX;
> +	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
> +	struct virtio_net_ff_selector *sel;
> +	size_t real_ff_mask_size;
> +	int err;
> +	int i;
> +
> +	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
> +	if (!cap_id_list)
> +		return -ENOMEM;
> +
> +	err = virtio_admin_cap_id_list_query(vdev, cap_id_list);
> +	if (err)
> +		goto err_cap_list;
> +
> +	if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
> +				 VIRTIO_NET_FF_RESOURCE_CAP) &&
> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
> +				 VIRTIO_NET_FF_SELECTOR_CAP) &&
> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
> +				 VIRTIO_NET_FF_ACTION_CAP))) {
> +		err = -EOPNOTSUPP;
> +		goto err_cap_list;
> +	}
> +
> +	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
> +	if (!ff->ff_caps)

Hi Daniel,

I think that err needs to be set to a negative error value here...

> +		goto err_cap_list;
> +
> +	err = virtio_admin_cap_get(vdev,
> +				   VIRTIO_NET_FF_RESOURCE_CAP,
> +				   ff->ff_caps,
> +				   sizeof(*ff->ff_caps));
> +
> +	if (err)
> +		goto err_ff;
> +
> +	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
> +	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
> +		ff_mask_size += get_mask_size(i);
> +
> +	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
> +	if (!ff->ff_mask)
> +		goto err_ff;
> +
> +	err = virtio_admin_cap_get(vdev,
> +				   VIRTIO_NET_FF_SELECTOR_CAP,
> +				   ff->ff_mask,
> +				   ff_mask_size);
> +
> +	if (err)
> +		goto err_ff_mask;
> +
> +	ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
> +					VIRTIO_NET_FF_ACTION_MAX,
> +					GFP_KERNEL);
> +	if (!ff->ff_actions)

... and here.

Flagged by Smatch.

> +		goto err_ff_mask;
> +
> +	err = virtio_admin_cap_get(vdev,
> +				   VIRTIO_NET_FF_ACTION_CAP,
> +				   ff->ff_actions,
> +				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
> +
> +	if (err)
> +		goto err_ff_action;
> +
> +	err = virtio_admin_cap_set(vdev,
> +				   VIRTIO_NET_FF_RESOURCE_CAP,
> +				   ff->ff_caps,
> +				   sizeof(*ff->ff_caps));
> +	if (err)
> +		goto err_ff_action;
> +
> +	real_ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
> +	sel = (void *)&ff->ff_mask->selectors[0];
> +
> +	for (i = 0; i < ff->ff_mask->count; i++) {
> +		if (sel->length > MAX_SEL_LEN) {
> +			err = -EINVAL;
> +			goto err_ff_action;
> +		}
> +		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
> +		sel = (void *)sel + sizeof(*sel) + sel->length;
> +	}
> +
> +	if (real_ff_mask_size > ff_mask_size) {
> +		err = -EINVAL;
> +		goto err_ff_action;
> +	}
> +
> +	err = virtio_admin_cap_set(vdev,
> +				   VIRTIO_NET_FF_SELECTOR_CAP,
> +				   ff->ff_mask,
> +				   ff_mask_size);
> +	if (err)
> +		goto err_ff_action;
> +
> +	err = virtio_admin_cap_set(vdev,
> +				   VIRTIO_NET_FF_ACTION_CAP,
> +				   ff->ff_actions,
> +				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
> +	if (err)
> +		goto err_ff_action;
> +
> +	ff->vdev = vdev;
> +	ff->ff_supported = true;
> +
> +	kfree(cap_id_list);
> +
> +	return 0;
> +
> +err_ff_action:
> +	kfree(ff->ff_actions);
> +	ff->ff_actions = NULL;
> +err_ff_mask:
> +	kfree(ff->ff_mask);
> +	ff->ff_mask = NULL;
> +err_ff:
> +	kfree(ff->ff_caps);
> +	ff->ff_caps = NULL;
> +err_cap_list:
> +	kfree(cap_id_list);
> +
> +	return err;
> +}

...

