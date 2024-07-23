Return-Path: <netdev+bounces-112660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E3C93A76C
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 20:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0419284935
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 18:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A51C13D600;
	Tue, 23 Jul 2024 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C3X+BKuj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B146314286;
	Tue, 23 Jul 2024 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760675; cv=none; b=jEUm8J4Gzijfe+k8fzz7DegUJ4qrKH97AJHwCq2EYGVZ034lgs0f7wYk5BXFsT30Od1soDKwgM2nE7keqD5+yT6fej71Mk1m1eJmMaCRjK+g/Br+g8R6cavk+83YsRzZfvrfMJnxwrmeIlcmxSA0YoRyqcgQo3tACxsbDGjBMF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760675; c=relaxed/simple;
	bh=8WM45x4aLgxzn24xRVJdcYNSsyPdIGy9A1ixEo4iLgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5QXj6caijVcqwF90RDlDUgMCwPS1oG+XuRzk1I1w9nY5rHIvCia1uOw4EW3mL+cxyXsGr6rFTtHjaz/93IbCPGsUswCY+EQKqjNpGhIIi6xocf3Rg6ou9ABX/aMENvJXABrQoPhKKRWf+RfVgxuEXZ6QED3qVGD8wp7NUEPMUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C3X+BKuj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2LdqHMpKyhNeBqbn8cjWJNhWaXvSpX93+fz3qbvwzFc=; b=C3X+BKujtWdnJ7Md9EySwCd7ZS
	alWbsORvT8gp033nu3lRXSQr/BiL/ZUOfuU5e/BAbXM1L9lxu+X65MvL435EIFeKwyXJDh0eoaMH2
	mQy+FTpSRVW5JqjYh0LaJpwABLG5vIjRPXL4M56125EYmhtQ4xwTsv5hC/hp4grrML5E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sWKbM-0035Le-Kq; Tue, 23 Jul 2024 20:51:08 +0200
Date: Tue, 23 Jul 2024 20:51:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATH v5 2/3] vdpa_sim_net: Add the support of set mac address
Message-ID: <aa52dd0c-a5a7-4416-ba15-6527f5490044@lunn.ch>
References: <20240723054047.1059994-1-lulu@redhat.com>
 <20240723054047.1059994-3-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723054047.1059994-3-lulu@redhat.com>

> +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev,
> +				struct vdpa_device *dev,
> +				const struct vdpa_dev_set_config *config)
> +{
> +	struct vdpasim *vdpasim = container_of(dev, struct vdpasim, vdpa);
> +	struct virtio_net_config *vio_config = vdpasim->config;
> +
> +	mutex_lock(&vdpasim->mutex);
> +
> +	if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +		memcpy(vio_config->mac, config->net.mac, ETH_ALEN);

ether_addr_copy()

	Andrew

