Return-Path: <netdev+bounces-159764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A527AA16C56
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45D8161A56
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AB71DF257;
	Mon, 20 Jan 2025 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ghFWYCbA"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F161DFD83
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737376075; cv=none; b=HO5YJIQQWd19IARPGfwSKcnKr8j4rMYu5B5u0zhEl39OmXHYWu69tIOaR6vS8uH/NJCLwgUv/8PaLXG4iCMRkcUkbBzOKelMjpUd+y8cmw3NDjfdSH72UcKsPAl1JlO+7zClOU+P4yQsIuFOQ1/9IvqW8YwijCHIV/tjpFJnpRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737376075; c=relaxed/simple;
	bh=p0o3/+NEj3yqzHjb3nhV/ChT/BDAxOmIswXIBleAU4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebrrjU/X0Ax1gBaLdQIh76SwT35GndjA7wSe0ziZRR17lkk0KCzuEbT8fRFCeo1SEZElzgCetYOjn/kIt95LAb8DIlwP1Wp5viCTiykciIVCMnv9YlIX/+8D/5u/V32mxr/Ky8HH2ZhUn+Z7xzKVBNm8cFJlltcakzuvdFO163w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ghFWYCbA; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <636e3e9c-234a-42c6-a197-8fad2ec6b929@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737376071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBt9oamHnaglLUEcQE+nTSiV0ffc2LJL6Gn6h9uHsSI=;
	b=ghFWYCbAAMFT1UBp23Gk97yyYElsniGSOMum1rxkl21PZtdK37YjJ0IFU7ukYrYOC8IEM3
	13IGQ0DDbzvZXqC7vY9U1u/7XqJtCNU0jGDM0QrRMPxI6gazVRyohIkiXdxUnxPdodw5YX
	0I1C588rGwkbonsp3oExlwCzvQMaON4=
Date: Mon, 20 Jan 2025 04:27:45 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 1/4] net: wangxun: Add support for PTP clock
To: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com
References: <20250117062051.2257073-1-jiawenwu@trustnetic.com>
 <20250117062051.2257073-2-jiawenwu@trustnetic.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250117062051.2257073-2-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/01/2025 06:20, Jiawen Wu wrote:
> Implement support for PTP clock on Wangxun NICs.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>   drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
>   .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   3 +
>   drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  52 +-
>   drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 717 ++++++++++++++++++
>   drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |  19 +
>   drivers/net/ethernet/wangxun/libwx/wx_type.h  |  69 ++
>   drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   8 +
>   drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |  10 +
>   .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  11 +
>   .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   9 +
>   10 files changed, 894 insertions(+), 6 deletions(-)
>   create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.c
>   create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.h
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
> index 42ccd6e4052e..e9f0f1f2309b 100644
> --- a/drivers/net/ethernet/wangxun/libwx/Makefile
> +++ b/drivers/net/ethernet/wangxun/libwx/Makefile
> @@ -4,4 +4,4 @@
>   
>   obj-$(CONFIG_LIBWX) += libwx.o
>   
> -libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o
> +libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o

Kconfig needs "depends on PTP_1588_CLOCK_OPTIONAL" to make it compile
properly.

[...]

