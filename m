Return-Path: <netdev+bounces-177347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A33A6FAD7
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CB218888AB
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62E6255E55;
	Tue, 25 Mar 2025 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAereTTf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13A5254B1B
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904720; cv=none; b=oU/i0LbysNgV5nZaOYiASawEqASEan1t1Z/cPCCNz7o7N4kjXGObdVa24pk20mNF3dOYXtRr3f3TASkBph9fuzp17jlAxJdPG0EwWVtR1ncDNNyJ1Ww+DwaOISdL7GZgOnbVF0yQhFU7ULmdaFI9kWsW5FKeao4nWsuvCNi8p8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904720; c=relaxed/simple;
	bh=nxT3ML/ym4QnKP9a5thYuG2XTuoO0UJapx0Bw0I3eVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpBWY1VEg3zugDGaVuKqHLyE4fqFYrmJIcvfhYqlso8rvDjTJD4BEmukbJmDyDuuwHtgGsT+qcpsG9l3h7V/i4XEkiZEek7onS2w9NM7fxQvqnwMM7bA4FH17/pPUlJFvDNiGCR4TCIYdZYiJcSyyzxRoiDRGdXfOcUzsNk4Onw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAereTTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491E0C4CEED;
	Tue, 25 Mar 2025 12:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742904720;
	bh=nxT3ML/ym4QnKP9a5thYuG2XTuoO0UJapx0Bw0I3eVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hAereTTfHXHwDT6Vu0d5ucy10BxN/wk0x7+yNrhJChHAyHImTl8b6Up/Lc1gF9KyR
	 1FRD3WbO3OkjDWof3bjd5jZr4hwXgoOCdXGNX5jCTS5zQTTDPidfPgxSu54y0ytIgL
	 8ekxHUPmQTbz+KQU5Bo+4F53xiJXO/nSkAhGwsv9sfNms0MamESjiAqQRKGxEECJQL
	 oEhvr2yCHUYeM4KkRbIhcMzrwy0nLOOS17sVhVzhI90VWB0lyuATDRNKiRYnEjP0Wl
	 fv5bV7Es3Xj1HVUVUww38OqKUJgA2J5rc1Wu+3caZjObAFby1s0kRVaQuG9x0UD/Dr
	 uDGAsqQ6F09Sw==
Date: Tue, 25 Mar 2025 05:11:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Xin Tian" <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>,
 <weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>,
 <horms@kernel.org>, <parthiban.veerasooran@microchip.com>,
 <masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
 <geert+renesas@glider.be>, <geert@linux-m68k.org>
Subject: Re: [PATCH net-next v9 05/14] xsc: Add eq and alloc
Message-ID: <20250325051150.65c02e32@kernel.org>
In-Reply-To: <20250318151459.1376756-6-tianx@yunsilicon.com>
References: <20250318151449.1376756-1-tianx@yunsilicon.com>
	<20250318151459.1376756-6-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 23:15:00 +0800 Xin Tian wrote:
> +		for (i = 0; i < buf->nbufs; i++) {
> +			buf->page_list[i].buf =
> +				dma_alloc_coherent(&xdev->pdev->dev, PAGE_SIZE,
> +						   &t, GFP_KERNEL | __GFP_ZERO);

DMA allocations are always zeroed, no need for GFP_ZERO.

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
> new file mode 100644
> index 000000000..a1c4b92a5
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + */
> +
> +#ifndef __ALLOC_H
> +#define __ALLOC_H

Please use less generic names for header guards.
-- 
pw-bot: cr

