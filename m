Return-Path: <netdev+bounces-124399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C70096939C
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 08:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C080FB23EAD
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 06:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29E41CEADF;
	Tue,  3 Sep 2024 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DUKQxRok"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809351CCEF5;
	Tue,  3 Sep 2024 06:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725344735; cv=none; b=u0enkgg6N5xiDuXh2uwuRW9dUQogBwM6FTHzJv0KfVpQCTH6sWRVYaEKP6OlwYK7KGlH3cAdI65phPC+QTnyf56RuyzgC9xhJhLsDDikhnSAva99V8mnV/uU6ptwDueyXwT1jFjC/H/0l0E9FZE/fIFcQ7WAZW2XQEYoyCKxlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725344735; c=relaxed/simple;
	bh=L0BzdpBTag84LeEkQ/b0SYi8kwEwBszZzTIL8k4dgjs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma5SmWvDhhkimVgNtbC+wfBTP2roLkUEK4LhmVu3VDvLWBjjshCredv7aknxQbm+duIBPUaorg6/edfDD1WIVDwtlumEf/4OB1QDP0lfm5Zogv50XRyAA/E/fKOHbd82nkn4XixCETECbhekFcqCqJ/zcdF3Ht+ZG8KN97Ipldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DUKQxRok; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725344734; x=1756880734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L0BzdpBTag84LeEkQ/b0SYi8kwEwBszZzTIL8k4dgjs=;
  b=DUKQxRokhL/xVESdGkv3WNHkOqBsn1tXlMa3moUHBnZKu2sAo4uOapdg
   ATbX2Pf38OrHeWwti+m1iGorfgt/rGhW6DCUA9cuolacU/A4jpHa/sT0m
   7M3XicAn9BoJgVLSyyjW2ZmKKrqXaO3495teoQjJtoKMUorKHOSHnsLKj
   B59SM5shwb4znqk/eUx4zFcQE71S68f/EHI8Gd33B/UwZJbHWzOP/MLEV
   torBDInBKNTAUNxB/z0p8MbrLkxYYZRNTI57gXl2XfEoEgLbvDbVYkC6+
   /7IgydUdLnuM6d+tfTBMlYupI9+lc3tk7J8Lm/Rg79g772TjzX4D2+qDj
   Q==;
X-CSE-ConnectionGUID: 8oTXQlsbTn2KC0ti4Inaeg==
X-CSE-MsgGUID: LbwKEOMAQXeOVxAiwi1iog==
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="31215250"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 23:25:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 23:25:01 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 23:25:01 -0700
Date: Tue, 3 Sep 2024 08:24:41 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v2 0/7] microchip_t1s: Update on Microchip
 10BASE-T1S PHY driver
Message-ID: <20240903062441.otbn6qcrhjisovhy@DEN-DL-M31836.microchip.com>
References: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>

The 09/02/2024 20:04, Parthiban Veerasooran wrote:

Hi Parthiban,

> This patch series contain the below updates,
> 
> v1:

You usually use v1, v2, v3 to say what is the difference between series.
But in your case you already had v1 already in first patch series which
it is strange to be used. I think you wanted to just describe the
features of this patch series.
So, my suggestion is to drop v1 because those are the features not
changes between version, and put ':' instead of ',' after updates.

Also almost all your patches in this series start with 'This patch',
please change this to imperative mode:
https://www.kernel.org/doc/html/v4.10/process/submitting-patches.html

> - Restructured lan865x_write_cfg_params() and lan865x_read_cfg_params()
>   functions arguments to more generic.
> - Updated new/improved initial settings of LAN865X Rev.B0 from latest
>   AN1760.
> - Added support for LAN865X Rev.B1 from latest AN1760.
> - Moved LAN867X reset handling to a new function for flexibility.
> - Added support for LAN867X Rev.C1/C2 from latest AN1699.
> - Disabled/enabled collision detection based on PLCA setting.
> 
> v2:
> - Fixed indexing issue in the configuration parameter setup.
> 
> Parthiban Veerasooran (7):
>   net: phy: microchip_t1s: restructure cfg read/write functions
>     arguments
>   net: phy: microchip_t1s: update new initial settings for LAN865X
>     Rev.B0
>   net: phy: microchip_t1s: add support for Microchip's LAN865X Rev.B1
>   net: phy: microchip_t1s: move LAN867X reset handling to a new function
>   net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C1
>   net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C2
>   net: phy: microchip_t1s: configure collision detection based on PLCA
>     mode
> 
>  drivers/net/phy/Kconfig         |   4 +-
>  drivers/net/phy/microchip_t1s.c | 299 +++++++++++++++++++++++++-------
>  2 files changed, 239 insertions(+), 64 deletions(-)
> 
> 
> base-commit: 221f9cce949ac8042f65b71ed1fde13b99073256
> -- 
> 2.34.1
> 

-- 
/Horatiu

