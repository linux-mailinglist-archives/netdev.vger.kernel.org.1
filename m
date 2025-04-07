Return-Path: <netdev+bounces-179522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53408A7D513
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F2617286E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 07:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9DE225A29;
	Mon,  7 Apr 2025 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="fxZJWd3T"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F0225403
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744009819; cv=none; b=BcbTITjZW9/iTxf/hUAkNo2k6Q7Sz9vgbdS+I1BfCRM8IHjQmcAct7xvxlg8gFepWBjbB5USScL5frFGZRroBMaBI//vZFwwUiFNU5VG9AXxnxFQDjdvL5JRLFxIqzh2w2ca6f8oFXMXvbwf8kfJD6YdEb0alMvyWIPfrAGsqtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744009819; c=relaxed/simple;
	bh=nfpPY1X5tmnzcqw/MzHCKftk1OWFRNZ+dd8GLUhKi8s=;
	h=Cc:Date:In-Reply-To:References:To:Subject:Message-Id:From:
	 Mime-Version:Content-Type; b=UGIM+XgffU1f8ICBZeZnvBdmp3fYbz4NeJnj1DBQQy3psHM2e0Fg18Ng62/bTQVWRdp1uujzRddRAzhqeYaB9FllE4JYnjpqpa96T2gjP5T1DczPcZHcjCkKb3hVnBfOyl0IwcbmJcA1z3+0N3AHPlz1UYaQPNvGa/fY9kqGWSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=fxZJWd3T; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1744008992; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=4AVdVkQRZeWLwL0m28ODgoKJTO+xC3dHgFx/UIT1gcI=;
 b=fxZJWd3TqRG4ENWj/d58sf6bnWb5T88izPgHldsIC8aMrujvelS4PKJXSe5DxCOz5zeCcP
 TT9rfUyj3FJSc9J+kSa6kfENsKIkE3303czKhaXY5MUcePPtcjCzMxcKcZwlmKcDat5aNl
 p54fCKlxJPBK0GzkAU2y5LmpGbQZ2l2GkJHCUJq4iMJx57C//BfcVT6BX4jPKDGlmRuBzn
 Wa16PPC7R4WeKmZWjuNOJI+ZMdnM6Lz+kmu87O3PM9MeA5UfUTdyJDPvrkOzxRst0vPw1B
 PPTm5obbCivOeTcMfRhAFyDqwvPsv0YIk1qb2yQF75cG7K9TrkdBEzjYCor1Yw==
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <geert@linux-m68k.org>
Date: Mon, 7 Apr 2025 14:56:34 +0800
In-Reply-To: <20250325051150.65c02e32@kernel.org>
References: <20250318151449.1376756-1-tianx@yunsilicon.com> <20250318151459.1376756-6-tianx@yunsilicon.com> <20250325051150.65c02e32@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Subject: Re: [PATCH net-next v9 05/14] xsc: Add eq and alloc
Message-Id: <8b64c52d-38bd-46ed-b327-59f5ca5ada52@yunsilicon.com>
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+267f3771e+1d5011+vger.kernel.org+tianx@yunsilicon.com>
User-Agent: Mozilla Thunderbird
From: "Xin Tian" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Received: from [127.0.0.1] ([116.231.163.61]) by smtp.feishu.cn with ESMTPS; Mon, 07 Apr 2025 14:56:29 +0800

On 2025/3/25 20:11, Jakub Kicinski wrote:
> On Tue, 18 Mar 2025 23:15:00 +0800 Xin Tian wrote:
>> +		for (i =3D 0; i < buf->nbufs; i++) {
>> +			buf->page_list[i].buf =3D
>> +				dma_alloc_coherent(&xdev->pdev->dev, PAGE_SIZE,
>> +						   &t, GFP_KERNEL | __GFP_ZERO);
> DMA allocations are always zeroed, no need for GFP_ZERO.
OK=EF=BC=8C will remove that.
>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h b/drivers/n=
et/ethernet/yunsilicon/xsc/pci/alloc.h
>> new file mode 100644
>> index 000000000..a1c4b92a5
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> + * All rights reserved.
>> + */
>> +
>> +#ifndef __ALLOC_H
>> +#define __ALLOC_H
> Please use less generic names for header guards.

I'll add "XSC_" prefix in next version.

Thanks

