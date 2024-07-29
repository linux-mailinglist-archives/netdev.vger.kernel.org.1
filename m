Return-Path: <netdev+bounces-113774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C41693FE1F
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16933283FED
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 19:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F49F17C7CE;
	Mon, 29 Jul 2024 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jd4HSP14"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B784D34;
	Mon, 29 Jul 2024 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722280540; cv=none; b=MugMTu96LttpusfAoM73AbGCPzm56YZ4oIFsWkOhAED1HrNe9QDLs3O0lzrFFw0rDFGx/wVNsBQspOb6015svIedSIDtbsJNhSDZyNYJ6iwKmVbwR0B9j8Boe8BJkLFz1mt8I2bXhJTuERdomDYqdNDMBII0JZsII2CFjm4Oa6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722280540; c=relaxed/simple;
	bh=qq2DO28hcKeyDuon/L08bnLzinZyM8SrFE8xrk6i86I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zgp/Zz7xdPc26vR6YLSK0Nk/Ay8XkbGQAxQDHZa2NcJOPt5AwIk6+S5pmKA3hLfrGy+2Vd28inI1lrkyu6kp8c6TqTHYO/BfRQ6qT/odhtKIU3n9mXPpJj5HdRqlU1hwo8z7VwX0t59Is/HegJSIMIfxWYp8wnrgCK83pBF3YlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jd4HSP14; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JUswwxAcJrKXhGjojB6xZnwDm90M314QmoVFTw2vIsw=; b=jd4HSP14ku2WtGso/OwOCG74Nb
	kS29pr8fW3NUgjEx5qyzQathZ+HLZB3C6jfDDFSFmVAEe/Vw/vm4lG3R6MdOZG+8lvAryd0+f3qVh
	So7S3IeHAJi1Usd5ZOn4rLQOA4UC4LQEIMJBqmoZ76usMZ3tq0B+PP+Oa85Yy6V+0ZBE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYVqG-003UxQ-DI; Mon, 29 Jul 2024 21:15:32 +0200
Date: Mon, 29 Jul 2024 21:15:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] vdpa_sim_net: Add the support of set mac address
Message-ID: <a5898ab7-a2ad-412a-85e6-9c7ad590704c@lunn.ch>
References: <20240729052146.621924-1-lulu@redhat.com>
 <20240729052146.621924-3-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729052146.621924-3-lulu@redhat.com>

> +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
> +				const struct vdpa_dev_set_config *config)
> +{
> +	struct vdpasim *vdpasim = container_of(dev, struct vdpasim, vdpa);
> +	struct virtio_net_config *vio_config = vdpasim->config;
> +
> +	mutex_lock(&vdpasim->mutex);
> +
> +	if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +		ether_addr_copy(vio_config->mac, config->net.mac);
> +		mutex_unlock(&vdpasim->mutex);
> +		return 0;
> +	}
> +
> +	mutex_unlock(&vdpasim->mutex);
> +	return -EINVAL;

EOPNOTSUPP would be more appropriate.

	Andrew

