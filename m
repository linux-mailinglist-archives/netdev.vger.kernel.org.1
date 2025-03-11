Return-Path: <netdev+bounces-173778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6F5A5BA63
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B0797A2CA9
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 08:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0543B224882;
	Tue, 11 Mar 2025 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maBd35ox"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE5822257B
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680244; cv=none; b=Vab5l7WgIZ07GnqpUrAXeZcjyWWcMTqbKy/hq4x0qgMCfRmjsxVcyUSYf46+hf9tnmPVbaJGt34RF8aPGkxC/3lcPSe56DFwWp2GSdXiwDuRjZKYPZdIsjgerLmapl5Pb3hJlM5yQANd233nmYXnlV5JDucXqYsufYDWl3CMtyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680244; c=relaxed/simple;
	bh=Wwj9xuWqFgi4/fNw7ALhUHz5l5PslVh8FksuTOaW3K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQxm+MXFFtkRp2hnEhpZyfBrKR7ev4Su6M33JgyhRAA6yFnA1rqcMmxT3J9SFKxIhCc7cl2WfdyFDAp/LipP38aq1L2+b06GKk52kWRlj4JeQwOaisUVjcz+B7pkcL4QXDmThi/kJalDh02S43dUMMUfO8ZzKl2KMotJhq0fF+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maBd35ox; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741680243; x=1773216243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wwj9xuWqFgi4/fNw7ALhUHz5l5PslVh8FksuTOaW3K4=;
  b=maBd35oxw3RseZGjeuYqe4YkGItRxBqPQePTyzjeHAfq2zoy6+jjHJOx
   DMt9uKpFzeeCA8onwWNpAZyKDmmbmEozrlVlgnlTKFjz3IGKkjefa7Q2z
   2vCI7GD7Y6I6+Uk6u3RPcOaNvUurnsOd02FmG42QwVtPmX3RzJM2pMLcI
   RBYp02rBeGN8z28vz7Gw6YUTJHWAZcvbFmW2IR2rlxe/MN7bKSVZ5y1cT
   +WF8hiOMR+pRu9lFcNQ4dKK4MGbqGDIKLz2+7DJq7yUawrZfbAltwZPtM
   unNPq9xEJrrYcWsTlFMqvdGUFVUKiOKQjBO0TLU4tDmj7KfZzMIXH1dwo
   w==;
X-CSE-ConnectionGUID: FeR4vORDTJOZJaZWY9nowg==
X-CSE-MsgGUID: Z05vnpc8RuuU7HFwOwFa1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42578400"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="42578400"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 01:04:02 -0700
X-CSE-ConnectionGUID: /dr7UqHmQAqqV9hHUp+3Bg==
X-CSE-MsgGUID: +NRjllwISn6ESt2MUCIVjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="125292705"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.64.210]) ([10.247.64.210])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 01:03:59 -0700
Message-ID: <5ebcf4b7-ed17-4cd6-ba1d-c35562a32899@linux.intel.com>
Date: Tue, 11 Mar 2025 16:03:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3] igc: Change Tx mode for MQPRIO offloading
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250307150231.pc3dl4aavb2vdp7i@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250307150231.pc3dl4aavb2vdp7i@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/3/2025 11:02 pm, Vladimir Oltean wrote:
> On Mon, Mar 03, 2025 at 10:16:33AM +0100, Kurt Kanzenbach wrote:
>> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
>> index cd1d7b6c1782352094f6867a31b6958c929bbbf4..16d85bdf55a7e9c412c47acf727bca6bc7154c61 100644
>> --- a/drivers/net/ethernet/intel/igc/igc.h
>> +++ b/drivers/net/ethernet/intel/igc/igc.h
>> @@ -388,11 +388,9 @@ extern char igc_driver_name[];
>>   #define IGC_FLAG_RX_LEGACY		BIT(16)
>>   #define IGC_FLAG_TSN_QBV_ENABLED	BIT(17)
>>   #define IGC_FLAG_TSN_QAV_ENABLED	BIT(18)
>> -#define IGC_FLAG_TSN_LEGACY_ENABLED	BIT(19)
>>   
>>   #define IGC_FLAG_TSN_ANY_ENABLED				\
>> -	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED |	\
>> -	 IGC_FLAG_TSN_LEGACY_ENABLED)
>> +	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED)
> 
> How do you and Faizal plan to serialize your changes on these flags?
> You delete IGC_FLAG_TSN_LEGACY_ENABLED and he adds
> IGC_FLAG_TSN_PREEMPT_ENABLED.

 From what I’ve experienced before, when there’s a conflict like this, the 
Intel maintainer handles it and gets both authors to review the resolution 
(this has happened to both of us before) before they proceed to submit the 
patch.

But if one patch gets merged first, the other person can just rebase and 
submit a new version ?


