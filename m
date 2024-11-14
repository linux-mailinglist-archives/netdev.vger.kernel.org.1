Return-Path: <netdev+bounces-144934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7AD9C8CD0
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06C4B25032
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E867A2C182;
	Thu, 14 Nov 2024 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xE2vifck"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097199476
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593944; cv=none; b=H/llhO42KId59Z0bbljkN85Q81QEiWTNX2pIOTcJDgIj6C69ZxLugxJfqG6Mx2R+38pTbNKRx8yT/kk+owh/v899k4y/AD8/lrerbN3ZQtgKrdGLAfnoKtxJRw3JB4Gv893kJ2jEsz3pP+z1keDxIdWDFR5LvyFKlGGnAgGIASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593944; c=relaxed/simple;
	bh=LcTLgyfnb1Ea1YPLkPJHVwMMba8t8/q1tCyICmpWHVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q3pGEVnVGtp35v/zeiSGkg7Xj5FHpAJ+tsnQM9QzkUUF69MF4uGSXENK55RvsbH1FDvO1SkKZcfu+08JU/UP9Z2HUsTAVZpMolkU7rst3F8cQMKqlr8b7VAZsY4qu3FhZZ5aylMwp4Z7GwXmYqhm7VGF7pvUt3seg4WmNtojYaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xE2vifck; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <40e94126-0ee9-4073-aeda-2bf024c4f393@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731593941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNawCI4EK2F66XUuXrlUiCaSNPW2Fe4RNAH/Rw9xKxE=;
	b=xE2vifcka66SMcT82Nzll4i2SHCP7l7D2xCh1y3BqUrqtFyKtIiiW9dm/a+43+WWitNBmu
	ncwzqUTarP0NNK4w+oaVzBJEZ+xsKNk3YZC5D03xK/38HHr45/DVX5fQGieDp1syMCtE6p
	4/fEtyijJIi9xxsQnxfgsPkRoQDP3BA=
Date: Thu, 14 Nov 2024 14:18:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 2/5] net: phy: microchip_ptp : Add ptp library
 for Microchip phys
To: Divya Koppera <divya.koppera@microchip.com>, andrew@lunn.ch,
 arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com
References: <20241114120455.5413-1-divya.koppera@microchip.com>
 <20241114120455.5413-3-divya.koppera@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241114120455.5413-3-divya.koppera@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/11/2024 12:04, Divya Koppera wrote:
> Add ptp library for Microchip phys
> 1-step and 2-step modes are supported, over Ethernet and UDP(ipv4, ipv6)
> 
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> ---
> v3 -> v4
> - Fixed coccicheck errors
> 
> v2 -> v3
> - Moved to kmalloc from kzalloc
> - Fixed sparse errors related to cast from restricted __be16
> 
> v1 -> v2
> - Removed redundant memsets
> - Moved to standard comparision than memcmp for u16
> - Fixed sparse/smatch warnings reported by kernel test robot
> - Added spinlock to shared code
> - Moved redundant part of code out of spinlock protected area
> ---

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

