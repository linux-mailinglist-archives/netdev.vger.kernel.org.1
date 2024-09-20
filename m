Return-Path: <netdev+bounces-129131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA95C97DAC6
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 01:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4392838ED
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 23:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD93187331;
	Fri, 20 Sep 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VTGVcK6/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9D61531E1;
	Fri, 20 Sep 2024 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726874577; cv=none; b=XQpaEPY+ntGzDLiAkLR1GLzY6QtHgomnc2khkq7exa35pCEjRQz7H4tMW+D1ALZLo/Hco/ABPK5gydpmeXDB6F/wGnRaT3WwddXPiLmsEuT5o8O194VXmArKHEGBIz5VSKth+FlhbBh8FsjCrNqLrmhkzeaE3tJC09IRf77lo5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726874577; c=relaxed/simple;
	bh=M8wjtrpNrvCnP385XjaEF5STK8Qo/y9Z5rIxlYHEl54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocyiS94dTWU4yRlO2z8Nz0xR6TZAecz8Rxu3Q9FG2M4Et8N+ajRelaiYcT2ABqtuOzp2Me9f5T7bQvcQW3l9+YoNfBsaipTenlcQQLQbpbjthrUwen2z3CWWJazq9SDO9KJEDD1KhVoIN2ZsLBSd/IWPitDZrtQCl7rX1F+Isd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VTGVcK6/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5+TVLbYfVRT8NLkF05JjoAdiCr5BuJ0yliYxVMsjdUQ=; b=VTGVcK6/s809xWxyOplbott3br
	YdF47TjYOJiA+bTOilXXRNsgZaiYYl6KYDu24oe66F1SZUWbU0N0lWtNNLFhIjKF0DT+JmQZ4NGmJ
	mUy98QdEh54+cVK2vmGPlyRp0MEhVwxt5PH6M6J25BWUnGbNJBIK1BVYkwum8jLa+05c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1srmxY-007xhe-VT; Sat, 21 Sep 2024 01:22:44 +0200
Date: Sat, 21 Sep 2024 01:22:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Sae <Frank.Sae@motor-comm.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com, fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: Re: [RFC] net:yt6801: Add Motorcomm yt6801 PCIe driver
Message-ID: <8dad36e2-88c0-4c10-a629-be032353fac2@lunn.ch>
References: <20240913124113.9174-1-Frank.Sae@motor-comm.com>
 <20240920230534.GA1071655@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920230534.GA1071655@bhelgaas>

> > +static int fxgmac_change_mtu(struct net_device *netdev, int mtu)
> > +{
> > +	struct fxgmac_pdata *pdata = netdev_priv(netdev);
> > +	int old_mtu = netdev->mtu;
> > +	int ret, max_mtu;
> > +
> > +	max_mtu = FXGMAC_JUMBO_PACKET_MTU - ETH_HLEN;
> > +	if (mtu > max_mtu) {
> > +		yt_err(pdata, "MTU exceeds maximum supported value\n");
> 
> Always nice to include the offending value (mtu) instead of just a
> constant string with no real information other than "we were here".

This is actually pointless, the core will do this check and never
actually call this function if the MTU is out of range.

FYI: Networking people have not taken any sort of serious look at the
code, it needs breaking up into smaller patches.

Feel free to review PCI parts, but i suggest you ignore networking
for the moment.

	Andrew

