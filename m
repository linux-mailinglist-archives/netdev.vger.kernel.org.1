Return-Path: <netdev+bounces-239203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D11C657B0
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A8C74EE0C9
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB553019A6;
	Mon, 17 Nov 2025 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMHLwdZ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420942D29C2;
	Mon, 17 Nov 2025 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399756; cv=none; b=pEXXZcgLImk8GV5o9x1N16Yv5C5HTSov0AZK4b1Kwr2ZZBdDwrDXtVb5+Lidz2W4PPQ5JDoKnYTmg6BEHobxstdDToMAU6OvF2FSG/8/dr0ACf0Wc+nOVNYtBfc3kqO3SGybwnDh6Hs2P39unLZWaF2adhOddxVqabR338Q9Yxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399756; c=relaxed/simple;
	bh=/guVKY3NacRISrw7vY7R/cHB5q9scX6T19T5UB+/qX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbVCLl839Qg3d7NchdVtvm34o7B+QCvrk5txxw9x+HfqWKLuJmvuonVajL+W5I/fgH/DU6Q4SAu7Y2D1PJp5pAb/r4rKj+0BNtAgq22ByTNSgOlKTActyrIIBVVKoOD1N+cSCL17zTcSbJQu1ZFKB09ngWZUTv+eLsv7bGOTlOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMHLwdZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C14C4AF09;
	Mon, 17 Nov 2025 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763399755;
	bh=/guVKY3NacRISrw7vY7R/cHB5q9scX6T19T5UB+/qX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMHLwdZ7Aju7H0sjsb5YNVFBmJy7+Ak2GF5V0XkhLfAkxQCT2SkTGQ4NrNF2ZTsoU
	 CFNIerAzjd8Z4pK5eusA6U2jTD9OiccMmWiBl7OrO6mRf5XDdFHmoSV/7XHZZlI07/
	 WrvNfHqf7j8PcI6Xc9X1FG+8cEsMIvR/COKBABg4nc4zHnUj65DJkMNvKKfkSFFMVy
	 Uys51FOv1BP36F24WepHf1w1ML2ZMF1JJn9oFHEp+HY1OSmfiE0CEgdU5pzbPW2old
	 DAORsm7Ysg+G/nXjs4CkI6GgZhiypkqbq6iR6OARXqIDmZ1vcbfTFfks1kw/JCbkCy
	 8tYelu9obiVdQ==
Date: Mon, 17 Nov 2025 17:15:50 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v10 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <aRtYRhKK8lbvREcy@horms.kernel.org>
References: <20251112193435.2096-2-danielj@nvidia.com>
 <20251112193435.2096-8-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112193435.2096-8-danielj@nvidia.com>

On Wed, Nov 12, 2025 at 01:34:30PM -0600, Daniel Jurgens wrote:

...

> +static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
> +{
> +	int err;
> +
> +	err = xa_alloc(&ff->classifiers, &c->id, c,
> +		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
> +		       GFP_KERNEL);

Hi Daniel,

I am wondering if some sort of bounds checking should be done for
classifiers_limit. E.g. if it is 0, then this will set the
maximum limit to -1 (UINT_MAX), which seems somewhat large,
assuming classifiers_limit of 0 doesn't mean unlimited.

Flagged by Claude Code with https://github.com/masoncl/review-prompts/

> +	if (err)
> +		return err;
> +
> +	err = virtio_admin_obj_create(ff->vdev,
> +				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> +				      c->id,
> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				      0,
> +				      &c->classifier,
> +				      c->size);
> +	if (err)
> +		goto err_xarray;
> +
> +	return 0;
> +
> +err_xarray:
> +	xa_erase(&ff->classifiers, c->id);
> +
> +	return err;
> +}

...

> +static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
> +				       struct ethtool_rx_flow_spec *fs,
> +				       u16 curr_queue_pairs)
> +{
> +	struct virtnet_ethtool_rule *eth_rule;
> +	int err;
> +
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	err = validate_flow_input(ff, fs, curr_queue_pairs);
> +	if (err)
> +		return err;
> +
> +	eth_rule = kzalloc(sizeof(*eth_rule), GFP_KERNEL);
> +	if (!eth_rule)
> +		return -ENOMEM;
> +
> +	err = xa_alloc(&ff->ethtool.rules, &fs->location, eth_rule,
> +		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->rules_limit) - 1),
> +		       GFP_KERNEL);

Likewise for rules_limit.

> +	if (err)
> +		goto err_rule;
> +
> +	eth_rule->flow_spec = *fs;
> +
> +	err = build_and_insert(ff, eth_rule);
> +	if (err)
> +		goto err_xa;
> +
> +	return err;
> +
> +err_xa:
> +	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> +
> +err_rule:
> +	fs->location = RX_CLS_LOC_ANY;
> +	kfree(eth_rule);
> +
> +	return err;
> +}

...

