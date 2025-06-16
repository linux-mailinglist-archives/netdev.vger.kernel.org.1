Return-Path: <netdev+bounces-198050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71226ADB105
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E751887068
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C63D285C9A;
	Mon, 16 Jun 2025 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cc1YTGGd"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2AE264A9D
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079068; cv=none; b=BAz8vBIN3kBo1lsWxsEBEz6gXaZm8M5PMfkGV1QZ3SffqQ0SNWLAfhQSOSHtOcap1Fg//sRtGDYnrlyRaosSq/x6VmIznrnLJ8/uuyCYz6lDlMHBZ6VQgECInISrhkKJnKI4Y3tgARnLLI9/W5yaXBoefo2jJlRNTeeHsmwwuJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079068; c=relaxed/simple;
	bh=2VLxKu0NSWdjjWfNhhjVvp1kjTv89OQClqD3z18Xu+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUSkG4ItmChL/jkjoN3Rn2WwIDFk1rvQc7age9tWoOO/l3WV/xXGoi8RoijSF52Sz2DkmLe5m2eRmunPagxDfH+7phA6J4bUpDpOCGg00BZ8qEYZtT+HQbHnpJcM102fNwIZuZifcAXuTtvLA9SqTlJTqlu30TK5jyLNRPGgoCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cc1YTGGd; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e41513d-ba2e-49f2-9e3e-af29874cac41@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750079058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rujyH1t6vY0cQ6LiXyseN0+yF/6S2Le4E97EcNLFkcs=;
	b=Cc1YTGGd3mUGgJbouiKuknTAoAAGBJnKpzb1ZVQ2/A9KQWM4sTvFFPHt9U4FuF7E8S0x4C
	oCfciCe9YyK7V5kgV5RGNKtNWV0v3E6ooA5rl+1qIvTLNo6rtzyhESqM+m/ZD5QOgrY3y4
	GQ7t9DYmezXnczOhTdgTaYvgBrle014=
Date: Mon, 16 Jun 2025 14:04:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] dpll: remove documentation of rclk_dev_name
To: Simon Horman <horms@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
References: <20250616-dpll-member-v1-1-8c9e6b8e1fd4@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250616-dpll-member-v1-1-8c9e6b8e1fd4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/06/2025 13:58, Simon Horman wrote:
> Remove documentation of rclk_dev_name member of dpll_device which
> doesn't exist.
> 
> Flagged by ./scripts/kernel-doc -none
> 
> Introduced by commit 9431063ad323 ("dpll: core: Add DPLL framework base
> functions")
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/dpll/dpll_core.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
> index 2b6d8ef1cdf3..9b11e637397b 100644
> --- a/drivers/dpll/dpll_core.h
> +++ b/drivers/dpll/dpll_core.h
> @@ -45,7 +45,6 @@ struct dpll_device {
>    * @dpll_refs:		hold referencees to dplls pin was registered with
>    * @parent_refs:	hold references to parent pins pin was registered with
>    * @prop:		pin properties copied from the registerer
> - * @rclk_dev_name:	holds name of device when pin can recover clock from it
>    * @refcount:		refcount
>    * @rcu:		rcu_head for kfree_rcu()
>    **/
> 

Thanks!
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

