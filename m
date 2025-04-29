Return-Path: <netdev+bounces-186644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC5BAA009D
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 05:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DF11A8309A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 03:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA4F19F40F;
	Tue, 29 Apr 2025 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOgxxjHf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BA31D540;
	Tue, 29 Apr 2025 03:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745897824; cv=none; b=lA4Sx8gr6fYW7Q9ZcVzxWqwvU08FHKkNdkpzeTxiAvIsUoD/9s1Ausu/DmvgeJHX6tkixWBc0eJbOjxtsBQrBaclBFyO4+DVK5MYetACLThi6YNRGqByFcBJl3KXFDzomNh9k03xR0reBAH56yRB/fcfVhGzhzn0PFZ+sMzrUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745897824; c=relaxed/simple;
	bh=J8ow/rnNH8xEu4UhfA9BOL3uvWtte0jR7ktfsoarV38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=af1Q0dUacxl+y0sL4Euut2z7I6GBj2RpzPIQ61C5CX7iz5btfybZGNFCz71DmxrLs5KhT/ERdvnvMPskPoysi8GjUgixEjSXyRsH52eFWWnPsaTqd+F+sqPFvZEODpEVm+dwnzK0w8ql7gEPwinwufd+mNcifdQAJde76OIAFgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOgxxjHf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745897823; x=1777433823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J8ow/rnNH8xEu4UhfA9BOL3uvWtte0jR7ktfsoarV38=;
  b=hOgxxjHfGZQcSkMv5cerj1GwRZkZDlkpE0k+DSkXtsGZJUaeu7/R7NQ8
   VgkkTMG4oGbZURxz7fI3SrRzmiet+v80v7vFnLc68SLRzYPk1aA+zMJJN
   eNaNI57DfCH6IGt3fbcahOqzd3QpT0Z+s4rZhWXiaIvYZL0BpD43MaF7A
   lSXq94/dFnD+XUbgvfT9sW/VUpQKqcp5AwIg41JlDV9EAriaM7s+zKeHT
   nU93q9QpPSD8yHjCl8Z91W3yyclH4ltFd9J9sVnE1EAmO3RU30e9anhmi
   EK3mYRtzizkFuxBevtnNPulbaKw5yynBUnH3ZajADa5RTPLQopxuAeCAj
   A==;
X-CSE-ConnectionGUID: r/+SkequSKia53K7TD2XCQ==
X-CSE-MsgGUID: g/OW5uPaS3CA7qIQdItUfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="47598863"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="47598863"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 20:37:02 -0700
X-CSE-ConnectionGUID: 0qgXs45zTyKuUWwhvF7+ug==
X-CSE-MsgGUID: 5bB2k/8qQU22LGzgpyvGdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="156932012"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.22.166]) ([10.247.22.166])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 20:37:00 -0700
Message-ID: <dd046c43-1491-4d2c-b4f2-5946ac55441e@linux.intel.com>
Date: Tue, 29 Apr 2025 11:36:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/8] igc: move
 IGC_TXDCTL_QUEUE_ENABLE and IGC_TXDCTL_SWFLUSH
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chwee-Lin Choong <chwee.lin.choong@intel.com>
References: <20250428060225.1306986-1-faizal.abdul.rahim@linux.intel.com>
 <20250428060225.1306986-2-faizal.abdul.rahim@linux.intel.com>
 <cabea2f2-49f7-40f8-a305-2c102ceb4012@intel.com>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <cabea2f2-49f7-40f8-a305-2c102ceb4012@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28/4/2025 3:01 pm, Ruinskiy, Dima wrote:
> On 28/04/2025 9:02, Faizal Rahim wrote:
>> Consolidate TXDCTL-related macros for better organization and readability.
>>
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc.h      | 6 ++++++
>>   drivers/net/ethernet/intel/igc/igc_base.h | 4 ----
>>   2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/ 
>> intel/igc/igc.h
>> index 859a15e4ccba..e9d180eac015 100644
>> --- a/drivers/net/ethernet/intel/igc/igc.h
>> +++ b/drivers/net/ethernet/intel/igc/igc.h
>> @@ -492,6 +492,12 @@ static inline u32 igc_rss_type(const union 
>> igc_adv_rx_desc *rx_desc)
>>   #define IGC_RX_WTHRESH            4
>>   #define IGC_TX_WTHRESH            16
>> +/* Additional Transmit Descriptor Control definitions */
>> +/* Ena specific Tx Queue */
>> +#define IGC_TXDCTL_QUEUE_ENABLE    0x02000000
>> +/* Transmit Software Flush */
>> +#define IGC_TXDCTL_SWFLUSH    0x04000000
>> +
>>   #define IGC_RX_DMA_ATTR \
>>       (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
>> diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ 
>> ethernet/intel/igc/igc_base.h
>> index 6320eabb72fe..4a56c634977b 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_base.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_base.h
>> @@ -86,10 +86,6 @@ union igc_adv_rx_desc {
>>       } wb;  /* writeback */
>>   };
>> -/* Additional Transmit Descriptor Control definitions */
>> -#define IGC_TXDCTL_QUEUE_ENABLE    0x02000000 /* Ena specific Tx Queue */
>> -#define IGC_TXDCTL_SWFLUSH    0x04000000 /* Transmit Software Flush */
>> -
>>   /* Additional Receive Descriptor Control definitions */
>>   #define IGC_RXDCTL_QUEUE_ENABLE    0x02000000 /* Ena specific Rx Queue */
>>   #define IGC_RXDCTL_SWFLUSH        0x04000000 /* Receive Software Flush */
> 
> Is there an intrinsic value for moving these definitions from one H file to 
> another? And if so, why move the Tx defs and leave the Rx defs where they are?

Hi Dima,

I moved and refactored the TXDCTL macros because this patch series
modifies the TXDCTL register, specifically setting new bitfields.
Consolidating `IGC_TXDCTL_QUEUE_ENABLE` and `IGC_TXDCTL_SWFLUSH`
alongside the existing TXDCTL macros improves readability and makes it
easier to cross-reference the TXDCTL bitfield mapping, as documented in
Section 8.11.16 of the i226 Software User Manual. The grouping now
matches that layout directly:

#define IGC_TXDCTL_PTHRESH_MASK       GENMASK(4, 0)
#define IGC_TXDCTL_HTHRESH_MASK        GENMASK(12, 8)
#define IGC_TXDCTL_WTHRESH_MASK        GENMASK(20, 16)
#define IGC_TXDCTL_QUEUE_ENABLE_MASK   GENMASK(25, 25)
#define IGC_TXDCTL_SWFLUSH_MASK        GENMASK(26, 26)
#define IGC_TXDCTL_PRIORITY_MASK       GENMASK(27, 27)

Since RXDCTL is a separate register with its own bitfield mapping
section in the i226 Software User Manual, and this patch series does
not modify it, I left the RXDCTL macros untouched. They are used
independently in separate functions within the driver.

That said, I can move the RXDCTL macros as well for consistency.


