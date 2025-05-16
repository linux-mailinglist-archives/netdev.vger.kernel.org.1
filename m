Return-Path: <netdev+bounces-191191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8821ABA5E4
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2931BC4F8E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86598280018;
	Fri, 16 May 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWGPEJUO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D927FB35
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747434373; cv=none; b=BR4Ja4zvHbTgdk219Yhh/eGPv3kBQsichVzLuJNLPdUtFtT8h6z7/Y5Ja6xNMrd637tmBLcwc8lHpq7VnoM7drbMMQwxbNikF4bbB6NHwmqeH5aaDBXseuDpO295GEA7mhT7dK4YB/kkT2usWnuMB4BzExz5niHEtonefj/HLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747434373; c=relaxed/simple;
	bh=GB5kdatSxsO6t+bXnALNz8I6F833542L/5Lee4x/I/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C30uc5K0HF2dbfi26B+QLf+xw6WgoWig+DbGj6bEr9EpnjMx0+HUuA527K7Qwa4j5zJJ1Vh6Diga0a92kmLAvXUxgYlPw2B+PnSKNQk3fnGQZocqCWYrE6VeKHqAZgqK8vIGGikkKGLJfeFnlkBQdqkaO2VAz5ISUVk3JEr7PjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWGPEJUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8191AC4CEE4;
	Fri, 16 May 2025 22:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747434372;
	bh=GB5kdatSxsO6t+bXnALNz8I6F833542L/5Lee4x/I/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NWGPEJUO8upUFHakNzbKiBBKrUC4hpKocra9Zn6X4uEAp6b9Ic30EHrFQDsUFATkK
	 P/py2kzRp6qm4TqG62U1k0FRXZQFQ8HVwlqU+uM4mLDNOtbOnTlIBVQpcrfNCaGtnR
	 1xwemNgpySVcd97w6+btGeq+MHVDrD7rxy2lOWtpeeKmBJarmUkrAmFefWAagTFiLz
	 b6O6zQ1K8GXg4gaovrB4DYB2I1lBKqK5d0bm32LRljqjkiJFHI32Ny7QsGoLV0tFfg
	 z6AZ1cpY7zZoG9vdAzB9rCMvyXAqWw+wg+Fp8uVyRKBeidLBLtwTM7R9zp/hR0crGO
	 vQ90WJncRMhfg==
Date: Fri, 16 May 2025 15:26:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: sysfs: Implement is_visible for
 phys_(port_id, port_name, switch_id)
Message-ID: <20250516152611.5945afae@kernel.org>
In-Reply-To: <20250515130205.3274-1-yajun.deng@linux.dev>
References: <20250515130205.3274-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 21:02:05 +0800 Yajun Deng wrote:
> +static struct attribute *netdev_phys_attrs[] __ro_after_init = {

Why __ro_after_init and not const? I can't find the reason with 
a quick grep. This is just an array of pointers, not objects.

> +	&dev_attr_phys_port_id.attr,
> +	&dev_attr_phys_port_name.attr,
> +	&dev_attr_phys_switch_id.attr,
> +	NULL,
> +};
> +
> +static umode_t netdev_phys_is_visible(struct kobject *kobj,
> +				      struct attribute *attr, int index)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct net_device *netdev = to_net_dev(dev);
> +
> +	if (attr == &dev_attr_phys_port_id.attr) {
> +		/* The check is also done in dev_get_phys_port_id; this helps returning
> +		 * early without hitting the locking section below.
> +		 */
> +		if (!netdev->netdev_ops->ndo_get_phys_port_id)
> +			return 0;
> +	} else if (attr == &dev_attr_phys_port_name.attr) {
> +		/* The checks are also done in dev_get_phys_port_name; this helps
> +		 * returning early without hitting the locking section below.
> +		 */
> +		if (!netdev->netdev_ops->ndo_get_phys_port_name &&
> +		    !netdev->devlink_port)
> +			return 0;
> +	} else if (attr == &dev_attr_phys_switch_id.attr) {
> +		/* The checks are also done in dev_get_phys_port_name; this helps
> +		 * returning early without hitting the locking section below. This works
> +		 * because recurse is false when calling dev_get_port_parent_id.
> +		 */
> +		if (!netdev->netdev_ops->ndo_get_port_parent_id &&
> +		    !netdev->devlink_port)
> +			return 0;

I'm slightly worried some user space depends on the files existing,
but maybe ENOENT vs EOPNOTSUPP doesn't make a big difference.

Can you remove the comments, tho? I don't think they add much value.
-- 
pw-bot: cr

