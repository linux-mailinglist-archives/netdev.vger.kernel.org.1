Return-Path: <netdev+bounces-111559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F159318DC
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86EBEB22489
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3834C1D531;
	Mon, 15 Jul 2024 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="N4iLTXsR"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80434446D2
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062545; cv=none; b=GhHZW0uot53KEAZzLm/gE82TqLjfn8w1y3tVtpAkEHNe99mCKpH4XMsGZP2zWYlshgSsuoxlJMHPF8UGvDTmQ8bgrdufPH8fzeh2eJfTNXlh3LkeQV34iRiKsOxFxBVlFfPfp01bk/70scIDbjAemjqUGHwMUadUZfatPDUTkeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062545; c=relaxed/simple;
	bh=kS0fwxUH/JUKLTIiU2CiR8HRF9SdfEDnRNZgjvea2O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZY/nt7sRPdqjPldddZdCLPFaJN8v+kP6duW0leA+6Et3m+m7ml6a7SoRd8v/e9UVKs10z5B79/tCcWsgb2xiMCu5qVf+FXfKtR+PUbEpg2VxiLltvWujFKFDftHI36mzS6oUmJcrRLnInDRXxi+osx1Du3VIZDJQLmtDRbdV9vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=N4iLTXsR; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 24655 invoked from network); 15 Jul 2024 18:55:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1721062533; bh=9KE2JDUcNrmeHQCDFpPFbwwq+eLfcwh1/bc9mtWbaXk=;
          h=Subject:To:Cc:From;
          b=N4iLTXsRnGqRcNaRDDF8PO4SFQtUiCFBLSGlLcr5MT7zmKIskESa5uY0I2/ArBAHH
           xJrtGBKBYQYRJdzn7ghZyzn6YIH+HxlyQ9tI4Dl52rJTLDiNhP9722TiX0O8hVpsDx
           W9PwoSKaxYGgchLyAH2AScLcZX6uhnzgqRTfCyw4=
Received: from 83.24.148.52.ipv4.supernova.orange.pl (HELO [192.168.3.174]) (olek2@wp.pl@[83.24.148.52])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 15 Jul 2024 18:55:33 +0200
Message-ID: <475f4e18-5595-4761-ad3c-f792e6dc60a2@wp.pl>
Date: Mon, 15 Jul 2024 18:55:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ethernet: lantiq_etop: remove redundant
 device name setup
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jacob.e.keller@intel.com, horms@kernel.org,
 u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240713170920.863171-1-olek2@wp.pl>
 <92570003-ddcd-482b-80e1-1da1fa0cc91f@lunn.ch>
Content-Language: en-US
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <92570003-ddcd-482b-80e1-1da1fa0cc91f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: 1da0bff9ba1eba8cac3f37dd5dcfd54e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [ccPQ]                               


On 13.07.2024 20:02, Andrew Lunn wrote:
> On Sat, Jul 13, 2024 at 07:09:20PM +0200, Aleksander Jan Bajkowski wrote:
>> The same name is set when allocating the netdevice structure in the
>> alloc_etherdev_mq()->alloc_etherrdev_mqs() function. Therefore, there
>> is no need to manually set it.
> If this one is not needed:
>
> grep -r "eth%d" *
> 3com/3c515.c:		sprintf(dev->name, "eth%d", unit);
> 8390/smc-ultra.c:	sprintf(dev->name, "eth%d", unit);
> 8390/wd.c:	sprintf(dev->name, "eth%d", unit);
> 8390/ne.c:	sprintf(dev->name, "eth%d", unit);
> amd/lance.c:	sprintf(dev->name, "eth%d", unit);
> atheros/atlx/atl2.c:	strcpy(netdev->name, "eth%d"); /* ?? */
> cirrus/cs89x0.c:	sprintf(dev->name, "eth%d", unit);
> dec/tulip/tulip_core.c:		strcpy(dev->name, "eth%d");			/* un-hack */
> intel/ixgbe/ixgbe_main.c:	strcpy(netdev->name, "eth%d");
> intel/ixgbevf/ixgbevf_main.c:	strcpy(netdev->name, "eth%d");
> intel/e100.c:	strcpy(netdev->name, "eth%d");
> intel/igbvf/netdev.c:	strcpy(netdev->name, "eth%d");
> intel/e1000e/netdev.c:	strscpy(netdev->name, "eth%d", sizeof(netdev->name));
> intel/igb/igb_main.c:	strcpy(netdev->name, "eth%d");
> intel/igc/igc_main.c:	strscpy(netdev->name, "eth%d", sizeof(netdev->name));
> intel/e1000/e1000_main.c:	strcpy(netdev->name, "eth%d");
> lantiq_etop.c:	strcpy(dev->name, "eth%d");
> micrel/ks8842.c:	strcpy(netdev->name, "eth%d");
> smsc/smc9194.c:		sprintf(dev->name, "eth%d", unit);
>
> maybe you can remove all these as well?

Added to my todo list.


>        Andrew

