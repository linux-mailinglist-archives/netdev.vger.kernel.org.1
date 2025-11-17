Return-Path: <netdev+bounces-239204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FB1C657A4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A14A14EFE80
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E503009E9;
	Mon, 17 Nov 2025 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtLgbdXD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A04B2C08B6;
	Mon, 17 Nov 2025 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399816; cv=none; b=BSVBEUXn57Yhx9hTAHOYHoVXZ28BtDo84DtmUWu53XmbjxiJwzpw6eoLHeyDQn9ljlKVtI0HckWgf9zQOhNf01HodLKZaTUQaGp1Pz1XTAEpfa+qatIoFbdfXMLdeKj9YhQQTUZ44C5/ZEVXtbJPG+IAIuKtFg0V5Jrlhrk8RXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399816; c=relaxed/simple;
	bh=aSN2U8OA4qyDQGDzWqVDqSjIH96A5Ew/ICgomZ+RUnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTdeaaHrFskH8qAq6qFyJtBSNeIKDV7XTfN8/0gjPfmSU8bTs+9Pvr+biHD0aAjP+lmVp4dFEAVE0FTyb0CiJCViMBAjud87JnYkde7E5SYP0yj893DsfKudn1zxLW7fUaFFQGP8D64D6wFsv/qucQS9EgKtXYL1uspRWK8HOtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtLgbdXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7D9C4CEF1;
	Mon, 17 Nov 2025 17:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763399815;
	bh=aSN2U8OA4qyDQGDzWqVDqSjIH96A5Ew/ICgomZ+RUnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LtLgbdXDSystToNwnLgM6w9Xk6ODgY1Qf4lG4zZHFn6IyFlWUSdB89RAjDZ58u6Yd
	 D1WXd1X2nGaQzzYNh0OQiFo4W9iglbajXlR1NbogUFvvakeukx1LdqJkaOtVBy/Exz
	 C+DTjheM7MMZUW2pd9SohmiXxWjAX/y6qD4uJ5/ugdNMHaWRRdA5sI0xbmL8XLxSkj
	 Knl2GPS4e7N54YwwbHTKrmXLfbC4+X48x7iQ/8D5/IJAzyuN8mMBLHD10Rd6HCg4mr
	 kqQJZSEvZ3ExfnJ6RLCzGKtBPmqo9S14oxamzKF1poK6im9x2/RCV8m7obFKY8cV6v
	 ZzzrLapLCUheg==
Date: Mon, 17 Nov 2025 17:16:50 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v10 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <aRtYgplAuUnCxj2U@horms.kernel.org>
References: <20251112193435.2096-2-danielj@nvidia.com>
 <20251112193435.2096-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112193435.2096-6-danielj@nvidia.com>

On Wed, Nov 12, 2025 at 01:34:28PM -0600, Daniel Jurgens wrote:

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
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
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
> +	if (!ff->ff_caps) {
> +		err = -ENOMEM;
> +		goto err_cap_list;
> +	}
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
> +	if (!ff->ff_mask) {
> +		err = -ENOMEM;
> +		goto err_ff;
> +	}
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
> +	if (!ff->ff_actions) {
> +		err = -ENOMEM;
> +		goto err_ff_mask;
> +	}
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

Hi Daniel,

I'm not sure that the bounds checking in the loop above is adequate.
For example, if ff->ff_mask->count is larger than expected.
Or sel->length returns MAX_SEL_LEN each time then it seems
than sel could overrun the space allocated for ff->ff_mask.

Flagged by Claude Code with https://github.com/masoncl/review-prompts/

> +
> +	if (real_ff_mask_size > ff_mask_size) {
> +		err = -EINVAL;
> +		goto err_ff_action;
> +	}
> +
> +	err = virtio_admin_cap_set(vdev,
> +				   VIRTIO_NET_FF_SELECTOR_CAP,
> +				   ff->ff_mask,
> +				   real_ff_mask_size);
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

