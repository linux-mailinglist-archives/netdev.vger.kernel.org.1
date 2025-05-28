Return-Path: <netdev+bounces-193959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8880DAC6A02
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AFAB1BC5359
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 13:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B4B2857E6;
	Wed, 28 May 2025 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rTQMV09z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F52192F1;
	Wed, 28 May 2025 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748437714; cv=none; b=WX2rWVhwGqkPiGlBGMJdqBjDYHPp/+OBtzgsWRqcHvscFm6csWybd3Fp9q7PSoxLp4NV0IxLCdz1oXBIRZHP++pQI18DxxOzRhVUyvbL8cwBYXuDtQ8Mb+bRrVpm2v8D8E/OpaP0edXobVpjHUjR5VbjgZZHA7TM2bPszXLkCps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748437714; c=relaxed/simple;
	bh=LvuTwweVOkXy6LNGPlHmJTdLDN6UIWQ127kpvTnTNZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCIQUe+YLAFFmYE3Xpr2AlAUajUR5Yjz/YWcBbponiuha+riaL65rFGftn35dlLXLnKtgHY1oqi+HNjh65Zndk13VazItVz2TpCKuXLrbTD4P+ZnxQAqmT0VEoOMT67YS/7hDvBVBZSF9tnHSZC517rv7Z1B1RuM7OP2OmQRlB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rTQMV09z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1frZwLooVKoM3mdNMU1fW6HD3+l5Q34lRajwGBwac14=; b=rTQMV09zYs3kFsDij10lnOsTU0
	28koBg7TNZM/ejICs0sIAeGAoHGwbsCwkLnnGmCEvifUpXS7Z+SXwC3uW+fbWUxHGdWCro+QVBrtr
	YVisiTqfcQK9KQc6Zwsk2Ba4mvAHAR4zvAN98gvZ+rhukdRcyTWnBbIitZHWiWKgNUUDMlMSWNvYv
	LMNULSJFA9RqSA6AJbGUGuHRLMgnxJskpCqwfRK4cg+25LiDXcLtEJl1PDXT2QNhIGeBf9YFKhD+X
	KdFFaMVm2e0U9pLjUTQSi1L38YgeHGD5rX+Klkgd/WyoV49v08uIsRWRdYc8v8OtvgK5jzuxy/dIe
	CgRBjCFQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37986)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uKGW4-0000Hf-2B;
	Wed, 28 May 2025 14:08:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uKGVz-0002Qs-1F;
	Wed, 28 May 2025 14:08:15 +0100
Date: Wed, 28 May 2025 14:08:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Add c45_phy_ids sysfs entry
Message-ID: <aDcKvwDaa6_1gZY7@shell.armlinux.org.uk>
References: <20250523132606.2814-1-yajun.deng@linux.dev>
 <2eec1d17-a6d1-4859-9cc9-43eeac23edbd@lunn.ch>
 <fad26dc95cbe08a87b30d98a55b7e3d987683589@linux.dev>
 <aDQkLcfeu8zw8CJ_@shell.armlinux.org.uk>
 <552f550315dc503250cc61fdcd13db38c1ea00f5@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552f550315dc503250cc61fdcd13db38c1ea00f5@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, May 26, 2025 at 08:52:12AM +0000, Yajun Deng wrote:
> May 26, 2025 at 4:19 PM, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > On Mon, May 26, 2025 at 08:11:21AM +0000, Yajun Deng wrote:
> > >  $ ls /sys/class/net/eth0/phydev/c45_phy_ids
> > > 
> > >  mmd10_device_id mmd17_device_id mmd23_device_id mmd2_device_id mmd7_device_id
> > > 
> > >  mmd11_device_id mmd18_device_id mmd24_device_id mmd30_device_id mmd8_device_id
> > > 
> > >  mmd12_device_id mmd19_device_id mmd25_device_id mmd31_device_id mmd9_device_id
> > > 
> > >  mmd13_device_id mmd1_device_id mmd26_device_id mmd3_device_id
> > > 
> > >  mmd14_device_id mmd20_device_id mmd27_device_id mmd4_device_id
> > > 
> > >  mmd15_device_id mmd21_device_id mmd28_device_id mmd5_device_id
> > > 
> > >  mmd16_device_id mmd22_device_id mmd29_device_id mmd6_device_id
> > > 
> > 
> > I suspect you don't have a PHY that defines all these IDs. Are you sure
> > 
> > your .is_visible() is working properly?
> > 
> 
> I'm just determining if it's a c45 device and not filtering PHY ID content now.
> I can add this condition. 

I'm talking about listing all 31 entries, whether they're implemented in
the PHY or not. Look at mmds_present in struct phy_c45_device_ids to
determine which IDs should be exported as well as checking whether the
ID value you're exporting is not 0 or ~0.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

