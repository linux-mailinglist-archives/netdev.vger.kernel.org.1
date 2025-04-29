Return-Path: <netdev+bounces-186646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 068D4AA00A8
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 05:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6880F3AC05C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 03:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D4A270546;
	Tue, 29 Apr 2025 03:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HnwXSCt9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D10270542;
	Tue, 29 Apr 2025 03:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745897866; cv=none; b=CPbYCXrGeZHo/h+p0mvFWQiBBow5hxBA4uwhMVECjlLwUTiVPQGkoMN2Z4KtI7uNm4JQea56914R21Sd8P3OJyyAD7QK7g/Nxs4D/78vqkJ4jfXwIqdggvKMWUrCsnMdl6dt34/6/Gcu3IvFg/GsMMX//N/zbimDw6MusvzNRmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745897866; c=relaxed/simple;
	bh=Lw15oqLnhXwkvSM1IfzQNus6FFUCQ7g9dkiYGODFx+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPKeGO45Fr6DqiAl+u1GSi567aKrgZrBzmZNj+hLArcQ6nmwSslUYyNvW9ZM41T+SnTC1BJ7NxI5gzbvNfTp463rGMh8K3szcHYRrnAI5cMb4qOHXpXPAs4Zvn2BDpSqMUFzBG+ivaRJbY3mPXOOTTKV8t/aUOjyailu8aKv+ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnwXSCt9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745897865; x=1777433865;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Lw15oqLnhXwkvSM1IfzQNus6FFUCQ7g9dkiYGODFx+s=;
  b=HnwXSCt9uw/2hlXqRg70D64qSBmufhPhErjCljmUXnCuXuSHE/YMYNrx
   PUYZA4kXVi+iaUZqqTe+sO/7L0uuJRr/pmjdr7USZx/aXPFqTIJLq5Kq/
   3VUYIXvpctTdmEUcMTkpsJoZxJnIuQHvqpocG3Mdlb2VxoMo7xpJ58OQ8
   9EguSJ9r7VPOLATI+I3YXFRBaiG9zxc3EG+vurD4jUJGq44RIV4NFcX29
   idBEF5kF2K2A2rYFM1Ll5u0etX9pSQFv51jFfqUqR5vGR8OSBOoDcKBC3
   5Kz3z1N7sDhfdN3Xcb+UcGFtxPpLmyiR6Aad7Wwfk3Ev+ZIhrng3V/qe2
   A==;
X-CSE-ConnectionGUID: VkaRDc+rRWOfrCsVCUotBg==
X-CSE-MsgGUID: oOKhlqlXR+OCnta8p9NS/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58873354"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="58873354"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 20:37:44 -0700
X-CSE-ConnectionGUID: HAZIXdtSQjWvHz2KC+mD2w==
X-CSE-MsgGUID: lsT1kMi0R9KOe9J+zJsXpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="156932034"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.22.166]) ([10.247.22.166])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 20:37:42 -0700
Message-ID: <549c15f4-8bdf-4823-ae2d-95d2861325d3@linux.intel.com>
Date: Tue, 29 Apr 2025 11:37:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 2/8] igc: add TXDCTL prefix
 to related macros
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
 <20250428060225.1306986-3-faizal.abdul.rahim@linux.intel.com>
 <524a13fa-eca1-4741-aa70-265a10cf96cb@intel.com>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <524a13fa-eca1-4741-aa70-265a10cf96cb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28/4/2025 2:57 pm, Ruinskiy, Dima wrote:
> On 28/04/2025 9:02, Faizal Rahim wrote:
>> Rename macros to include the TXDCTL_ prefix for consistency and clarity.
>> This aligns naming with the register they configure and improves code
>> readability.
>>
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc.h      | 6 +++---
>>   drivers/net/ethernet/intel/igc/igc_main.c | 6 +++---
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/ 
>> intel/igc/igc.h
>> index e9d180eac015..bc37cc8deefb 100644
>> --- a/drivers/net/ethernet/intel/igc/igc.h
>> +++ b/drivers/net/ethernet/intel/igc/igc.h
>> @@ -487,10 +487,10 @@ static inline u32 igc_rss_type(const union 
>> igc_adv_rx_desc *rx_desc)
>>    */
>>   #define IGC_RX_PTHRESH            8
>>   #define IGC_RX_HTHRESH            8
>> -#define IGC_TX_PTHRESH            8
>> -#define IGC_TX_HTHRESH            1
>> +#define IGC_TXDCTL_PTHRESH        8
>> +#define IGC_TXDCTL_HTHRESH        1
>>   #define IGC_RX_WTHRESH            4
>> -#define IGC_TX_WTHRESH            16
>> +#define IGC_TXDCTL_WTHRESH        16
>>   /* Additional Transmit Descriptor Control definitions */
>>   /* Ena specific Tx Queue */
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ 
>> ethernet/intel/igc/igc_main.c
>> index 27575a1e1777..725c8f0b9f3d 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -749,9 +749,9 @@ static void igc_configure_tx_ring(struct igc_adapter 
>> *adapter,
>>       wr32(IGC_TDH(reg_idx), 0);
>>       writel(0, ring->tail);
>> -    txdctl |= IGC_TX_PTHRESH;
>> -    txdctl |= IGC_TX_HTHRESH << 8;
>> -    txdctl |= IGC_TX_WTHRESH << 16;
>> +    txdctl |= IGC_TXDCTL_PTHRESH;
>> +    txdctl |= IGC_TXDCTL_HTHRESH << 8;
>> +    txdctl |= IGC_TXDCTL_WTHRESH << 16;
>>       txdctl |= IGC_TXDCTL_QUEUE_ENABLE;
>>       wr32(IGC_TXDCTL(reg_idx), txdctl);
> 
> If you do this, I think you should apply the same change to the RXDCTL 
> macros that are right next to the TXDCTL ones. Otherwise you are trading 
> one inconsistency for another. :)

Will update


