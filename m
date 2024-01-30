Return-Path: <netdev+bounces-67108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75DE842141
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 11:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77923285DAA
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FBF60DDB;
	Tue, 30 Jan 2024 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cuwmIq+P"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1784929D03
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610548; cv=none; b=dk/eIhBBxJo+lbmg701OHEK7Gz7WyNc8jltAlNhhKxIpwKs+NFjQuLc2Xp7+5K7LPxN2VdX7oRVBiYe+/Bo2qxlTyY67faXKIxu3DJMPXqaCzOsZZDWs+YrElKnv2XmVO9l3MvjsWtxKqSReP6AQr6aV6Gd9U1gn8n7FZrbLsQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610548; c=relaxed/simple;
	bh=8K8bhyD6PMNKlGlBWjPd9V+qMPI5kqJnt6RENjDzrrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMcXretS7GHDDHsSo60PW0UbQZaqsxPtwyfdwuJGRkrBY73M2G6jfY+WWI45mkkIKkzCW/0/S7fPc7J6Clum66wuRSQYSCy8qb08lr70i8+GC37SndqVUH87lDpmi95xSYLbTvTsPT5onKUS6pgjaFgzbGb16wEhvquxcaqbD7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cuwmIq+P; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b213297b-53f6-4c66-8c0b-5b3fbafdbccd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706610543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4MDwIsz/51ydoQBF8XYbyl0+NpNiOkbyGxsM19gaKpg=;
	b=cuwmIq+PxA+EpyjKFG93Gg6Zro1Q2r4AO0Ce4SjmDj0mUSRGrmiKzEMYb0C6E0GsPj89aP
	7Sjmw9tgLkk+skUD7FiVzekfR3KW8sPBY7PmEzX/2FiUPtrIu3xxTxpaZSXZKxrRlX2A6O
	EPr9FueR9wJGTEMh7zeq5Nsv7KUA89k=
Date: Tue, 30 Jan 2024 10:28:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch net-next 0/3] dpll: expose lock status error value to user
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, arkadiusz.kubalewski@intel.com, saeedm@nvidia.com,
 leon@kernel.org, jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 rrameshbabu@nvidia.com
References: <20240129145916.244193-1-jiri@resnulli.us>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240129145916.244193-1-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/01/2024 14:59, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Allow to expose lock status errort value over new DPLL generic netlink
> attribute. Extend the lock_status_get() op by new argument to get the
> value from the driver. Implement this new argument fill-up
> in mlx5 driver.

The list of errors shows that the focus is on SyncE devices here. What
do you think about extending it to PPS devices too? Like loss of input
frequency, or high phase offset?

But the series overall looks good,

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


> Jiri Pirko (3):
>    dpll: extend uapi by lock status error attribute
>    dpll: extend lock_status_get() op by status error and expose to user
>    net/mlx5: DPLL, Implement lock status error value
> 
>   Documentation/netlink/specs/dpll.yaml         | 39 +++++++++++++++++++
>   drivers/dpll/dpll_netlink.c                   |  9 ++++-
>   drivers/net/ethernet/intel/ice/ice_dpll.c     |  1 +
>   .../net/ethernet/mellanox/mlx5/core/dpll.c    | 32 +++++++++++++--
>   drivers/ptp/ptp_ocp.c                         |  9 +++--
>   include/linux/dpll.h                          |  1 +
>   include/linux/mlx5/mlx5_ifc.h                 |  8 ++++
>   include/uapi/linux/dpll.h                     | 30 ++++++++++++++
>   8 files changed, 120 insertions(+), 9 deletions(-)
> 


