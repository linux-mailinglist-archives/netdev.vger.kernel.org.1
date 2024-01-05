Return-Path: <netdev+bounces-61910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD72B82530E
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 12:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523FC282A95
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF802C852;
	Fri,  5 Jan 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tWleMR8p"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E12C6AC
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <71ab339e-0d6e-4a9d-93fd-d9d291e5e3ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704455067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTWqR6eDBmNRxHBgFhMSkTseDcG3pmiGmm0u2mGiLuM=;
	b=tWleMR8pVqZqdaJj9RMkj6EMA0/9EErbRR6/IcSvZtl3qFd5CvomnIqDHnnij7f7q1I/Ub
	iWzsd3ijBk3I/+IFi5ZPYeDifT4vj79GY6X8kC5Xk7P1DIWObEx8X+oSaPe2iw/4et+LKK
	iX9sXfxfVlx4CKbFiUj94nIZOn2fYWE=
Date: Fri, 5 Jan 2024 11:44:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch net-next 0/3] dpll: expose fractional frequency offset
 value to user
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, arkadiusz.kubalewski@intel.com, saeedm@nvidia.com,
 leon@kernel.org, michal.michalik@intel.com, rrameshbabu@nvidia.com
References: <20240103132838.1501801-1-jiri@resnulli.us>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240103132838.1501801-1-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03/01/2024 13:28, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Allow to expose pin fractional frequency offset value over new DPLL
> generic netlink attribute. Add an op to get the value from the driver.
> Implement this new op in mlx5 driver.
> 
> Jiri Pirko (3):
>    dpll: expose fractional frequency offset value to user
>    net/mlx5: DPLL, Use struct to get values from
>      mlx5_dpll_synce_status_get()
>    net/mlx5: DPLL, Implement fractional frequency offset get pin op
> 
>   Documentation/netlink/specs/dpll.yaml         | 11 +++
>   drivers/dpll/dpll_netlink.c                   | 24 +++++
>   .../net/ethernet/mellanox/mlx5/core/dpll.c    | 94 ++++++++++++-------
>   include/linux/dpll.h                          |  3 +
>   include/uapi/linux/dpll.h                     |  1 +
>   5 files changed, 98 insertions(+), 35 deletions(-)
> 

Interesting attribute, it's good that hardware can expose this info.

Did you think about building some monitoring/alerts based on it?

For the series (I'm not sure if it's enough for mlx5, but the
refactoring looks nice):

Acked-By: Vadim Fedorenko <vadim.fedorenko@linux.dev>

