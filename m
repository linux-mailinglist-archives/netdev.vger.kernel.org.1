Return-Path: <netdev+bounces-149612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D10A59E6745
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 07:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F04163FB1
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF761D5AB8;
	Fri,  6 Dec 2024 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ew4ArJeN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21917CA1D;
	Fri,  6 Dec 2024 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733466189; cv=none; b=H1KcNhCMozwVGklerCposjyIC65+f/apAkm1WaSpHRmfLE6XBPO+/x+RxAIuBEGBgK/s/MU2FopNVpg/GpUVPtJPcwqMCf0clyADimxu9wY67N6lrBgb4XCT+1SBirK6MsabgamXkSkCR3q4VUsp/BGWtVWxtcICFBY4wZEOaM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733466189; c=relaxed/simple;
	bh=MkeuBrC406SRMMNMVpBw/NLIAbufzkCKSKGch2ynNwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRVxeVDj4EdE1PZ8zquiKv4+RvUGWlUIbvFgRa+hRvv6Q6ZRaF19SdiThc+nBAFP5I7YlNXptSRyvZ2pK5X7/IwSz1lmtWDCClwhcroihSlfVDKGQYDW5PhIVI8WJ7hJWq3X5IKVnItAlpstqJHPm+UAXblfjectWaaFs8NrWqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ew4ArJeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11245C4CED1;
	Fri,  6 Dec 2024 06:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733466188;
	bh=MkeuBrC406SRMMNMVpBw/NLIAbufzkCKSKGch2ynNwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ew4ArJeNKM626zYU0Oj9uJXhA+eQA0Yj1qn6gOQGEr2HkJEm8A9B7Eq4A5xdIc8fG
	 PaPU4wz5PrYrMuTXzLwXq9k3AaZeFuIe0ZGJ/bCBfqHLwoB+Ee0hy8zVmbqqNbVCcN
	 XNWeYnZXQNu4j3jVfhE4A6/kMhXnBLSURMud9NCw=
Date: Fri, 6 Dec 2024 07:23:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, hkelam@marvell.com
Subject: Re: [PATCH V4 RESEND net-next 1/7] net: hibmcge: Add debugfs
 supported in this module
Message-ID: <2024120644-swapping-laxative-48e5@gregkh>
References: <20241203150131.3139399-1-shaojijie@huawei.com>
 <20241203150131.3139399-2-shaojijie@huawei.com>
 <20241205175006.318f17d9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205175006.318f17d9@kernel.org>

On Thu, Dec 05, 2024 at 05:50:06PM -0800, Jakub Kicinski wrote:
> On Tue, 3 Dec 2024 23:01:25 +0800 Jijie Shao wrote:
> > +static void hbg_debugfs_uninit(void *data)
> > +{
> > +	debugfs_remove_recursive((struct dentry *)data);
> > +}
> > +
> > +void hbg_debugfs_init(struct hbg_priv *priv)
> > +{
> > +	const char *name = pci_name(priv->pdev);
> > +	struct device *dev = &priv->pdev->dev;
> > +	struct dentry *root;
> > +	u32 i;
> > +
> > +	root = debugfs_create_dir(name, hbg_dbgfs_root);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(hbg_dbg_infos); i++)
> > +		debugfs_create_devm_seqfile(dev, hbg_dbg_infos[i].name,
> > +					    root, hbg_dbg_infos[i].read);
> > +
> > +	/* Ignore the failure because debugfs is not a key feature. */
> > +	devm_add_action_or_reset(dev, hbg_debugfs_uninit, root);
> 
> There is nothing specific to this driver in the devm action,
> also no need to create all files as devm if you remove recursive..
> 
> Hi Greg, are you okay with adding debugfs_create_devm_dir() ?

Seems like overkill, but if you can find multiple users of it, sure,
that would be fine to add.

thanks,

greg k-h

