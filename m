Return-Path: <netdev+bounces-113773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 536CF93FE1C
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD1F283FE0
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 19:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3DD185606;
	Mon, 29 Jul 2024 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KKeHxiMG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C3B8F6E;
	Mon, 29 Jul 2024 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722280420; cv=none; b=YNDyl1MgQ4cmuPPsCwJpII45SYXC9VU+04NvesADhBJgtDkvwI1Ru2E1g/z8df3Hoa+EUVVOgGl5+IK1IQPuIKhf0I3tWCF0HMaDprdcNLYOHpuy2nMn4hdNMKnL9W0JdZ0r4gTC7del3pZLoXESewpf/2JuN5BaRjq0iz9RBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722280420; c=relaxed/simple;
	bh=D/k2gflf1CrQfdyqcQrRM64Li2eb8kGekB0k0/MRf5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORZUZ/ID9GsSwM8Hjk+I9pWIPBPyTJwN/w9++p+kBkspabHF6Yc2Ss2C6frRM2WUl3tS7AtNGSa/G5YlXSmienEc7c8iB8cqgkxvTKRiujQM0/ARFqj6Vq5RJnxq9VrbRHg56xzmutYttic71b5pPeNykbn+/B1zvbHXNhhLxYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KKeHxiMG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8ZNHWlm+Nyx2XlIJKfuX2NFq0FaRdmbdH9dI8jmg1jQ=; b=KKeHxiMGW1WqVAx5xcire9s3PW
	pbbSam9Yr97KKG412JLv3dmyYl0G5g2Ek7hi2sa3dtdF78PUdWjto4KsZndNGMWdMAZ1sFJTrWZA7
	QGd4cVL+lVgF3+8/Lsyk+VkCbwIvrG/J0H8nZ8FyjAU1ZfnIl6gFxU+hS2c6HgunBLkk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYVoE-003UwU-Ho; Mon, 29 Jul 2024 21:13:26 +0200
Date: Mon, 29 Jul 2024 21:13:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] vdpa: support set mac address from vdpa tool
Message-ID: <52af9b4f-aa8f-4c6f-9ced-c6fa9b396343@lunn.ch>
References: <20240729052146.621924-1-lulu@redhat.com>
 <20240729052146.621924-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729052146.621924-2-lulu@redhat.com>

> +static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
> +					struct genl_info *info)
> +{
> +	struct vdpa_dev_set_config set_config = {};
> +	struct vdpa_mgmt_dev *mdev = vdev->mdev;
> +	struct nlattr **nl_attrs = info->attrs;
> +	const u8 *macaddr;
> +	int err = -EINVAL;
> +
> +	down_write(&vdev->cf_lock);
> +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> +		set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> +
> +		if (is_valid_ether_addr(macaddr)) {
> +			ether_addr_copy(set_config.net.mac, macaddr);
> +			memcpy(set_config.net.mac, macaddr, ETH_ALEN);

ether_addr_copy() and memcpy()?

> +			if (mdev->ops->dev_set_attr) {
> +				err = mdev->ops->dev_set_attr(mdev, vdev,
> +							      &set_config);
> +			} else {
> +				NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +						       "device does not support changing the MAC address");

You would generally return EOPNOTSUPP in this case, not EINVAL.

Also, the device does not support setting attributes. Given the
generic name, i assume you plan to set other attributes in the future,
at which point this error message will be wrong.

	Andrew

