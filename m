Return-Path: <netdev+bounces-124820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9AB96B0E6
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5246B1F266A7
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 06:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97A784A5C;
	Wed,  4 Sep 2024 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OUterwV8"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E907F9
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725429767; cv=none; b=LrLYYXdjlacDGnB5k7u2dzYFk0TO4FFRrNL0vUwa9euuRwR3W2buDrlpxhcTkfBXE56XdecasUEUFjUfOfZXg7WiOMq2Jp7j6ObNm3GZIkX8IKCppjSEwte34DSE++zLcnzYGS5cwctHocv0ehjca+b5ac3moaCzROOXaCU9LDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725429767; c=relaxed/simple;
	bh=HzEvWlKvksN/zPt68FjMHxvx+sIX0Y+awhwXofG4Ipc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsW6+ZjZl0tmfpVO2L2jdrW6IDm/6UWL9Zg7AspfFr5iumnazDNjUXU34WqdV09J8Z/iOzXA5V0/Ve2s7AmnZCsExAakQIsrdiQWy/vvqgg/cFtLdDN8uZB45+wVhWucrk+pfAsDKLKf4BOQoDczP2XMVM0x1ED8sA4nwNcqu28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OUterwV8; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <829ac3ed-a338-4589-a76d-77bb165f0608@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725429762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VplJowlwUHkxbOtIka1lBspa4LGEnbwTD6GYsRWVesA=;
	b=OUterwV8m+D7FoeupQ/cGiky34F5U8VcTLoTJBta+D03U+8EzCGHbFfqq9HxR9cLesstuw
	akfjXXbzoYPkAWnaEBI7a/PEqDln4UnL/2NV0f7tIyi09Sn8yyRyoKuo9qUs/RDqOY4Xp1
	fUKN+r/IeoBHBboX4msIHxdmY68qzPQ=
Date: Wed, 4 Sep 2024 14:02:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 0/2] Introduce mlx5 data direct placement (DDP)
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
References: <cover.1725362773.git.leon@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <cover.1725362773.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/9/3 19:37, Leon Romanovsky 写道:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This series from Edward introduces mlx5 data direct placement (DDP)
> feature.
> 
> This feature allows WRs on the receiver side of the QP to be consumed
> out of order, permitting the sender side to transmit messages without
> guaranteeing arrival order on the receiver side.
> 
> When enabled, the completion ordering of WRs remains in-order,
> regardless of the Receive WRs consumption order.
> 
> RDMA Read and RDMA Atomic operations on the responder side continue to
> be executed in-order, while the ordering of data placement for RDMA
> Write and Send operations is not guaranteed.

It is an interesting feature. If I got this feature correctly, this 
feature permits the user consumes the data out of order when RDMA Write 
and Send operations. But its completiong ordering is still in order.

Any scenario that this feature can be applied and what benefits will be 
got from this feature?

I am just curious about this. Normally the users will consume the data 
in order. In what scenario, the user will consume the data out of order?

Thanks,
Zhu Yanjun

> 
> Thanks
> 
> Edward Srouji (2):
>    net/mlx5: Introduce data placement ordering bits
>    RDMA/mlx5: Support OOO RX WQE consumption
> 
>   drivers/infiniband/hw/mlx5/main.c    |  8 +++++
>   drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>   drivers/infiniband/hw/mlx5/qp.c      | 51 +++++++++++++++++++++++++---
>   include/linux/mlx5/mlx5_ifc.h        | 24 +++++++++----
>   include/uapi/rdma/mlx5-abi.h         |  5 +++
>   5 files changed, 78 insertions(+), 11 deletions(-)
> 


