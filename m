Return-Path: <netdev+bounces-116324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651A4949F2B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 07:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BF8287745
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 05:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201F818EFFF;
	Wed,  7 Aug 2024 05:29:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE35801
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 05:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008550; cv=none; b=n/ZdOOfrgQ7j5LAhngzaMj7VU3Ohk4sK0FEzwSoVyiJkGctx2oQSrpUNk+QapTsr97FeqTzM9EKSFvK2L9K4lpQjDyLlW2QtQxQv759wi6QOxUbPKk9gsu7MqGcTSe/UGJaFTb1c3/sxVrDj1gusscJKZQ+QeeejAb1Gu8G030s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008550; c=relaxed/simple;
	bh=GsX/VlGw9zFguEQ5Bhn6H3AAYM2djEcPB7s4LVQYrIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zq5YeEBxcbkTGAW5Q8kdemlqL7AJBqJFWoo2bcwUCBu9AmegDoOC7UMIJQL5l+P7XNX6Gf1CkLWOt4/qDDEIOHPIUcE0J0UejkHnHIGMxgbpHhw374lgHYPGPaRvn62JkHB+FJj09iBmtGc6J/CU6rS7xtxql/irS3W0prM9SfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af7d2.dynamic.kabel-deutschland.de [95.90.247.210])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 78B0761E5FE01;
	Wed,  7 Aug 2024 07:28:41 +0200 (CEST)
Message-ID: <9a23f5ec-190c-4525-b2fb-e10fc55b60f6@molgen.mpg.de>
Date: Wed, 7 Aug 2024 07:28:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 4/5] igc: Reduce retry count
 to a more reasonable number
To: Christopher S M Hall <christopher.s.hall@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
 vinschen@redhat.com, vinicius.gomes@intel.com, netdev@vger.kernel.org,
 rodrigo.cadore@l-acoustics.com
References: <20240807003032.10300-1-christopher.s.hall@intel.com>
 <20240807003032.10300-5-christopher.s.hall@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240807003032.10300-5-christopher.s.hall@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Christopher,


Thank you for your patch.

In the summary, I’d add specific values:

igc: Reduce retry count to from 100 to reasonable 8


Am 07.08.24 um 02:30 schrieb christopher.s.hall@intel.com:
> From: Christopher S M Hall <christopher.s.hall@intel.com>
> 
> Setting the retry count to 8x is more than sufficient. 100x is unreasonable
>  and would indicate broken hardware/firmware.

I’d remove the leading space.

Is using a 100 causing so much more delay and debugging an issue is harder?

> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ptp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
> index fb885fcaa97c..f770e39650ef 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
> @@ -1008,8 +1008,8 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
>   	u32 stat, t2_curr_h, t2_curr_l;
>   	struct igc_adapter *adapter = ctx;
>   	struct igc_hw *hw = &adapter->hw;
> -	int err, count = 100;
>   	ktime_t t1, t2_curr;
> +	int err, count = 8;

Is there data available that no more than 8 retries were needed?

>   	/* Doing this in a loop because in the event of a
>   	 * badly timed (ha!) system clock adjustment, we may


Kind regards,

Paul

