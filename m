Return-Path: <netdev+bounces-168405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5D5A3ED4E
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 08:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BFD189F4BE
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 07:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6D71FECDD;
	Fri, 21 Feb 2025 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D93FxB8W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2CC1FE443
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740122605; cv=none; b=tQjwmckEaB1Cf2jiB0dr8AoscxHykCJousNS04Wero2Kypm4haoVe3K5NYA0w3q7pRRfndkiv9Ei335v7x23Ql0qP9v1iDUL3Bnl1msQC7E+T5NH+P3rFn52wify4pXg0hEzpyoS7n88qTUYlL4As1t65zAs0Kzd0t69nnrxovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740122605; c=relaxed/simple;
	bh=sq/x43yJb850psvaY5dsqL9/rnJ1afk9ad6fQQPp8Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLsKpgm9fYW7/r9rpNPkP9Ml7adXzal3W3XQZxypDsPffagHWU3Ql1Ldt2MsT1iYd4e8azniG1916Z3mwxZjINu1IL/M+hh7du+/xI9s+PtApabhSe65pSjjr88C79azLPekWXXxQuhYqwA8URg3GMmCf5h/VvrmgJ+SWBZ2xhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D93FxB8W; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740122604; x=1771658604;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sq/x43yJb850psvaY5dsqL9/rnJ1afk9ad6fQQPp8Oc=;
  b=D93FxB8W8KElMMMG2YkXas1cLyRadrgCeyuw5OIx0F972T0brtubws+5
   JMjm5QYZc8HV2gWapBkyHgJHhwod+v4AdGm4vJWJHrum8nJH5wRfB8rmY
   FIcLdOIa7ccciEx4noZ8bFw1fdbp4hVmgbL55pG1BYs9c+aoukDpK4qMf
   B5b9oqsbu82mBftuLdycvscMxUbmcFGR4gHNb7zpVqAGHdt+8+0AEKtxT
   hnBhvtAQUNPDNn+6+ErANhUbwiH8SDSaXvK3Hka1Tfal+chzOk0FvsBB+
   S/vh9EGkrULvk5EvgJxNMsTQkr4JVTYHIwTAynndVj+T+OlN70vvhSHmv
   A==;
X-CSE-ConnectionGUID: lJI/AS10T+m6mNLgQVE/Aw==
X-CSE-MsgGUID: HIm6baacRhGjpXCprNbYgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="63406457"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="63406457"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 23:23:24 -0800
X-CSE-ConnectionGUID: PC3qtnJgQOKSviv4qp0jnw==
X-CSE-MsgGUID: 3+U8oABgRKSWkpnWec7krQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="120224189"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.60.175]) ([10.247.60.175])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 23:23:20 -0800
Message-ID: <6ff37238-ff0e-43c9-a88d-1258fd4ce7ef@linux.intel.com>
Date: Fri, 21 Feb 2025 15:23:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] igc: Change Tx mode for MQPRIO offloading
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250217-igc_mqprio_tx_mode-v1-1-3a402fe1f326@linutronix.de>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250217-igc_mqprio_tx_mode-v1-1-3a402fe1f326@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/2/2025 7:45 pm, Kurt Kanzenbach wrote:
> The current MQPRIO offload implementation uses the legacy TSN Tx mode. In
> this mode the hardware uses four packet buffers and considers queue
> priorities.
> 
> In order to harmonize the TAPRIO implementation with MQPRIO switch to the
Missed "," ?
In order to harmonize the TAPRIO implementation with MQPRIO, switch to the

> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index 1e44374ca1ffbb86e9893266c590f318984ef574..6e4582de9602db2c6667f1736cc2acaa4d4b5201 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -47,7 +47,7 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
>   		new_flags |= IGC_FLAG_TSN_QAV_ENABLED;
>   
>   	if (adapter->strict_priority_enable)
> -		new_flags |= IGC_FLAG_TSN_LEGACY_ENABLED;
> +		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;
>   
>   	return new_flags;
>   }

IGC_FLAG_TSN_QBV_ENABLED is set multiple times in different lines:

	if (adapter->taprio_offload_enable)
		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;

	if (is_any_launchtime(adapter))
		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;

	if (is_cbs_enabled(adapter))
		new_flags |= IGC_FLAG_TSN_QAV_ENABLED;

	if (adapter->strict_priority_enable)
		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;

	return new_flags;
}

We can combine the conditions to simplify:
	if (adapter->taprio_offload_enable ||
             is_any_launchtime(adapter) ||
             adapter->strict_priority_enable)
		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;

