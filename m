Return-Path: <netdev+bounces-166203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE88A34ECD
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1FF3AC306
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A195F24BBEC;
	Thu, 13 Feb 2025 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W4mfyfic"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5C8266B62;
	Thu, 13 Feb 2025 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476505; cv=none; b=f8jz1U7Pvh0hL5Zg6A5m/nvVkCzxTfB3JkOyEqCOJ1YoyAIvOXvlSvmsbdXS+scDBIpQFEPUwCh6/OokATlkysbdwDxQfuD8PnSwxEfD+DJtsJZz5x4UM9VgKxnNHlZsWfd3s/1DdNRHV1i1XC4UtImCkzLnS0UOyvyhU2k7pis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476505; c=relaxed/simple;
	bh=3ph/sVj9uFbBjTAgcfcM1g7k+e3uf+Q4Jk8v0dYrjlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/fb2JJ8OBD1IRohBjMT0cGq5xCti3Pd7U8ZrXcNJ6OfLWsBMFXaw2QOCJKEVrtNXyMCnKHEAROFJib6/a68YJKLCMUEw681e6YiHMNY4KqF01n4IZC1wvDpdbZ5iE+VXTAKDTvsovCTNL7UL/AlEbHPkSrzMnbFoqo2szVqaPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W4mfyfic; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k2ipZEKqxXNF4XLP52ASASuGbRiJWj39yrm5/DIG5rQ=; b=W4mfyficfnZaIx5BOl7wBgMGoy
	2vYXN+02xuLAAT6Mghfe7A+RzA5os+3vs6vh/cUaepdil/VuwyDeC8FFMkdpLudtprrRQLgQA5qqa
	mtCYjVmFcJcpcXf1FmbrYIkpxXsPWPQGXINQuBPSV3xZt1omYB/6d0qGeacZscnhMMAU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tifIQ-00DqQQ-Nn; Thu, 13 Feb 2025 20:54:50 +0100
Date: Thu, 13 Feb 2025 20:54:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/7] net: hibmcge: Add dump statistics supported
 in this module
Message-ID: <47e8bab3-61cb-4c5a-9b40-03011b6267b3@lunn.ch>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
 <20250213035529.2402283-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213035529.2402283-2-shaojijie@huawei.com>

On Thu, Feb 13, 2025 at 11:55:23AM +0800, Jijie Shao wrote:
> The driver supports many hw statistics. This patch supports
> dump statistics through ethtool_ops and ndo.get_stats64().
> 
> The type of hw statistics register is u32,
> To prevent the statistics register from overflowing,
> the driver dump the statistics every 5 minutes
> in a scheduled task.

u32 allows the counter to reach 4294967295 before wrapping. So over 5
minutes, that is around 14,316,557 per second. Say this is your
received byte counter? That means your line rate cannot be higher than
114Mbps? Is this device really only Fast Ethernet?

	 Andrew

