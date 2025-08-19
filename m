Return-Path: <netdev+bounces-214999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B866FB2C8B6
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17635286B3
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DCF2820CE;
	Tue, 19 Aug 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KPCQK9EN"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CF5207A18
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618539; cv=none; b=DR+TW7L7ysKG+aiDayUCDAtHYFkja2gcpby7i6Kdxtn9Z1iuWQG96G5zA0dPdhUYm9wDLLREO2Nv6iccVko8u7H+gHRw8soHp9+FRuDxnmML0iVkcowP7nHJV8FLxbreAMuCnpLo5wBME7SQye71ks5hFc8P+MsTDi9it8rowDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618539; c=relaxed/simple;
	bh=j6wM/SgJMkvJoI+6V8/dUD1+fFpnKMaohYKn6PzgK6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erquXTU0TwZHBfPrsq3e5veOxCCygin6HNWbzDQDuHj6rEkA7AIxNCbem52sO/uKjkoJoSCKu5wHLcCu16OV96/e76cDvnJF2M6hrNZ5PMZzAmK/TTNYSdgoxFu9ftomxFhB7+In5sS4K2wb/FMXwww0Vs3V7B3Q5fLd8Rk6vOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KPCQK9EN; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <41651550-4e63-4699-b10f-ba2e8cfbc0a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755618524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fANgjc2IIsKedMP7E9vOPJjvlcpxmZDjKWRIxAOqvVk=;
	b=KPCQK9ENPL9cG2flPirxiQNDaxft4AQQvBTzXcyr52IqlFf5aeoriOBG7IPgARAiSzbg/I
	FmG2xUQ3IkiyPO8FgDM1WdrGvZ/T4lKn04ynKxRPcfiu+01kMKAoyYdIOwe3F9fm26YGw4
	wcXO3l+JIK3BpMVK2RBc7Uc7NKQhGvg=
Date: Tue, 19 Aug 2025 16:48:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 net-next 04/15] ptp: netc: add NETC V4 Timer PTP driver
 support
To: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Frank.Li@nxp.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, festevam@gmail.com
Cc: fushi.peng@nxp.com, devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, kernel@pengutronix.de
References: <20250819123620.916637-1-wei.fang@nxp.com>
 <20250819123620.916637-5-wei.fang@nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250819123620.916637-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/08/2025 13:36, Wei Fang wrote:
> NETC V4 Timer provides current time with nanosecond resolution, precise
> periodic pulse, pulse on timeout (alarm), and time capture on external
> pulse support. And it supports time synchronization as required for
> IEEE 1588 and IEEE 802.1AS-2020.
> 
> Inside NETC, ENETC can capture the timestamp of the sent/received packet
> through the PHC provided by the Timer and record it on the Tx/Rx BD. And
> through the relevant PHC interfaces provided by the driver, the enetc V4
> driver can support PTP time synchronization.
> 
> In addition, NETC V4 Timer is similar to the QorIQ 1588 timer, but it is
> not exactly the same. The current ptp-qoriq driver is not compatible with
> NETC V4 Timer, most of the code cannot be reused, see below reasons.
> 
> 1. The architecture of ptp-qoriq driver makes the register offset fixed,
> however, the offsets of all the high registers and low registers of V4
> are swapped, and V4 also adds some new registers. so extending ptp-qoriq
> to make it compatible with V4 Timer is tantamount to completely rewriting
> ptp-qoriq driver.
> 
> 2. The usage of some functions is somewhat different from QorIQ timer,
> such as the setting of TCLK_PERIOD and TMR_ADD, the logic of configuring
> PPS, etc., so making the driver compatible with V4 Timer will undoubtedly
> increase the complexity of the code and reduce readability.
> 
> 3. QorIQ is an expired brand. It is difficult for us to verify whether
> it works stably on the QorIQ platforms if we refactor the driver, and
> this will make maintenance difficult, so refactoring the driver obviously
> does not bring any benefits.
> 
> Therefore, add this new driver for NETC V4 Timer. Note that the missing
> features like PEROUT, PPS and EXTTS will be added in subsequent patches.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
[...]

>   drivers/ptp/Kconfig             |  11 +
>   drivers/ptp/Makefile            |   1 +
>   drivers/ptp/ptp_netc.c          | 416 ++++++++++++++++++++++++++++++++
>   include/linux/fsl/netc_global.h |   3 +-
>   4 files changed, 430 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/ptp/ptp_netc.c

[...]

> diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
> index fdecca8c90f0..763b38e05d7d 100644
> --- a/include/linux/fsl/netc_global.h
> +++ b/include/linux/fsl/netc_global.h
> @@ -1,10 +1,11 @@
>   /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> -/* Copyright 2024 NXP
> +/* Copyright 2024-2025 NXP
>    */
>   #ifndef __NETC_GLOBAL_H
>   #define __NETC_GLOBAL_H
>   
>   #include <linux/io.h>
> +#include <linux/pci.h>

What is the reason to include it header file? You need PCI functions
only in ptp_netc.c, but this header is also included in a couple of
other files (netc_blk_ctrl.c, ntmp.c).

>   
>   static inline u32 netc_read(void __iomem *reg)
>   {




