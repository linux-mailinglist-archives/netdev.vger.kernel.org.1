Return-Path: <netdev+bounces-176384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5EFA6A004
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 07:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC79A7B0DAB
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 06:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9371EEA56;
	Thu, 20 Mar 2025 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="hHFWuz+u"
X-Original-To: netdev@vger.kernel.org
Received: from mx23lb.world4you.com (mx23lb.world4you.com [81.19.149.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736401EBFFF
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742453721; cv=none; b=NnKnkk2Tp3x5xUm0gtM5XFrMcNxF06eJSvFFkGBlFmWiqIPBSOf7wuf/dHI59O6YsoMk1fiSPYI0LQUdOLKFsVs2uic6fE5E1SzAq950IcDI4SFiaG89iMhRsLv0a466PhEDBytvRNZyA4t3LkyHGhrzrXOEQJQSfkArNWdKYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742453721; c=relaxed/simple;
	bh=e1wOclOL5bzXvZb+4yPbuF+qVxaILuXqDjuPZCxXuDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhgctRtm1ipF34iJ546SolPCkVK8zR8LCflEYNakMj32rp2vG85P8cFdbmOjBWE1n80Pmaj9thvTlJcwdKvspcUQEsVZufkfpzs4Y/WYDo9ZykZj64I47iwAk+YaAwglPqS6eVI7sDyhOzVj/0chGVf7LxvUw03KVJfiFixV4q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=hHFWuz+u; arc=none smtp.client-ip=81.19.149.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m6lk21RutrjsrkWDVoOVfb1WIpMZ24B9YQYoi8EfxGA=; b=hHFWuz+uDKZ/B8ct+USZiSyWBg
	uHWUPq+qD0w2Ez0r58x7xukNZI5y0hx6V3PlAHkYjizZTKoLfnMhy/lWUag5QsFKKgPTrgshvOF8G
	VASr0e/4g91rASl5qnDDfJuEnu5Yb+peOgvS0OWj/YB2L4aTTKfx5vbfuxoCFOOQGC+k=;
Received: from [80.121.79.4] (helo=[10.0.0.160])
	by mx23lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tv9Mj-000000004QT-1riP;
	Thu, 20 Mar 2025 07:26:53 +0100
Message-ID: <ab02f08f-d294-462e-bbda-bb6909781ce6@engleder-embedded.com>
Date: Thu, 20 Mar 2025 07:26:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 0/5] Support loopback mode speed selection
To: andrew@lunn.ch
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ltrager@meta.com, Jijie Shao <shaojijie@huawei.com>
References: <20250312203010.47429-1-gerhard@engleder-embedded.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250312203010.47429-1-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 12.03.25 21:30, Gerhard Engleder wrote:
> Previously to commit 6ff3cddc365b ("net: phylib: do not disable autoneg
> for fixed speeds >= 1G") it was possible to select the speed of the
> loopback mode by configuring a fixed speed before enabling the loopback
> mode. Now autoneg is always enabled for >= 1G and a fixed speed of >= 1G
> requires successful autoneg. Thus, the speed of the loopback mode depends
> on the link partner for >= 1G. There is no technical reason to depend on
> the link partner for loopback mode. With this behavior the loopback mode
> is less useful for testing.
> 
> Allow PHYs to support optional speed selection for the loopback mode.
> This support is implemented for the generic loopback support and for PHY
> drivers, which obviously support speed selection for loopback mode.
> Additionally, loopback support according to the data sheet is added to
> the KSZ9031 PHY.
> 
> Extend phy_loopback() to signal link up and down if speed changes,
> because a new link speed requires link up signalling.
> 
> Use this loopback speed selection in the tsnep driver to select the
> loopback mode speed depending the previously active speed. User space
> tests with 100 Mbps and 1 Gbps loopback are possible again.
> 
> v10:
> - remove selftests, because Anrew Lunn expects a new netlink API for
>    selftests and the selftest patches should wait for it
>

Hello Andrew,

The patchset now does not touch any selftest code anymore. It now only
fixes the 1Gbps loopback, which requires a link partner since
6ff3cddc365b. tsnep is using the extended phy_loopback() interface
to select the loopback speed. Also the phy_loopback() usage in tsnep
could be simplified, because thanks to your review comments link speed
changes are now signaled correctly by phy_loopback().

I'm curious about the work of Lee Trager and I will definitely take a
look on it. I will take a look to the netdev 0x19 talk as soon as the
slides or the recording is available.

I did not get an answer from you to my last reply of v9. That's the
reason why I decided to post v10 without selftests. How to proceed
with this changes? The development cycle is near the end, so maybe
you want to delay this change to the beginning of the next development
cycle?

Gerhard

