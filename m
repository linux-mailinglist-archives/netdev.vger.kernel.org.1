Return-Path: <netdev+bounces-182178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627CAA8814C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2C7177D99
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E19F2BD5BC;
	Mon, 14 Apr 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igrcAXJs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648DF2D3A74
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636358; cv=none; b=qdaasyvceYFTa5EKoIQ942o7jHPpPXAADyE/Nw/AOf4+NOt+qK8uw0gtObbf57d38iooe68bwjOrjBhHgLtfJJ17IFbRdarxy0Q2VuQUH0MZvLtuTh2z0VyDPnT8wEAEW7ez9QFN0WPcU+S6WqhHfdF9rJLKENjVZTspBnOu97U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636358; c=relaxed/simple;
	bh=zxrmEtApbR1+NFxrh23dKs/vscGUN0aWWypjYeI/it8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDxlcmDpVphh3ustO8cCOfiTd/V4tQd1Z9WpBPVObS7HXfnN6i9Sii2V9fnO4SAfXI3wrLwCvzWnt3n5ipZjNR4lBq4hY36Autbpk2xoOBpW+6exkNTDDang2yQz7ZZp9WSsjELsCiTa4O4Pt18R/kIsk3rAbaaf/+nPeKJch6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igrcAXJs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744636357; x=1776172357;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zxrmEtApbR1+NFxrh23dKs/vscGUN0aWWypjYeI/it8=;
  b=igrcAXJsZc2Ykf3DfJoGdTkIcDYiJiwXgqH65AzPvuQpeuBdHLK0i9RO
   vmOaFNfeRFeGOR0echZKL4w4OSOjt7SrzDuCVRugMYSlACAunCOIw6tci
   W0XIFUD1QcirTaSAcikEZnDH92ki/5TpIgMrhI49QakIVMtxXESdy6qom
   1UtAMAC/Jc1npLyYYg/j8EsZ04m84HuwuCcjrQO2fqHkbBDyuCqvKa1tX
   jVj7TmzD1Uv5WgytmDT6bkx0pcMIYXFpxEc32QalGfdgZf9C44RS87bAk
   ldOcRXS7wgT0NEf+ux60/8fm95oflWqVpIpM4ooEykoUffziG4pkGwL2d
   Q==;
X-CSE-ConnectionGUID: JgRM7N1YSn+sOwbqvap89A==
X-CSE-MsgGUID: nvVz7wKCRWSUlNJMM9lt8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="45240824"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="45240824"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:12:36 -0700
X-CSE-ConnectionGUID: 68LT2WeKQ/6m5FT1X51I3g==
X-CSE-MsgGUID: RhP1dXvoSd27ztQQMQqmFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="134653252"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.98.242]) ([10.245.98.242])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:12:35 -0700
Message-ID: <4012b88a-091d-4f81-92ab-ad32727914ff@linux.intel.com>
Date: Mon, 14 Apr 2025 15:12:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 1/2] ice: add link_down_events
 statistic
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250409113622.161379-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250409113622.161379-4-martyna.szapar-mudlaw@linux.intel.com>
 <55ae83fc-8333-4a04-9320-053af1fd6f46@molgen.mpg.de>
Content-Language: en-US
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <55ae83fc-8333-4a04-9320-053af1fd6f46@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/9/2025 2:08 PM, Paul Menzel wrote:
> Dear Martyna,
> 
> 
> Thank you for your patch.
> 
> Am 09.04.25 um 13:36 schrieb Martyna Szapar-Mudlaw:
>> Introduce a new ethtool statistic to ice driver, `link_down_events`,
>> to track the number of times the link transitions from up to down.
>> This counter can help diagnose issues related to link stability,
>> such as port flapping or unexpected link drops.
>>
>> The counter increments when a link-down event occurs and is exposed
>> via ethtool stats as `link_down_events.nic`.
> 
> It’d be great if you pasted an example output.

In v2 (which I just submitted) the generic ethtool statistic is used for 
this, instead of driver specific, so I guess no need to paste the 
example output now.

> 
>> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
>> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar- 
>> mudlaw@linux.intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice.h         | 1 +
>>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
>>   drivers/net/ethernet/intel/ice/ice_main.c    | 3 +++
>>   3 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ 
>> ethernet/intel/ice/ice.h
>> index 7200d6042590..6304104d1900 100644
>> --- a/drivers/net/ethernet/intel/ice/ice.h
>> +++ b/drivers/net/ethernet/intel/ice/ice.h
>> @@ -621,6 +621,7 @@ struct ice_pf {
>>       u16 globr_count;    /* Global reset count */
>>       u16 empr_count;        /* EMP reset count */
>>       u16 pfr_count;        /* PF reset count */
>> +    u32 link_down_events;
> 
> Why not u16?

So now using u32 instead of u16 is more justified, as the v2 uses the 
generic ethtool stat, where this value is also u32 :)

> 
>>       u8 wol_ena : 1;        /* software state of WoL */
>>       u32 wakeup_reason;    /* last wakeup reason */
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/ 
>> net/ethernet/intel/ice/ice_ethtool.c
>> index b0805704834d..7bad0113aa88 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>> @@ -137,6 +137,7 @@ static const struct ice_stats 
>> ice_gstrings_pf_stats[] = {
>>       ICE_PF_STAT("mac_remote_faults.nic", stats.mac_remote_faults),
>>       ICE_PF_STAT("fdir_sb_match.nic", stats.fd_sb_match),
>>       ICE_PF_STAT("fdir_sb_status.nic", stats.fd_sb_status),
>> +    ICE_PF_STAT("link_down_events.nic", link_down_events),
>>       ICE_PF_STAT("tx_hwtstamp_skipped", ptp.tx_hwtstamp_skipped),
>>       ICE_PF_STAT("tx_hwtstamp_timeouts", ptp.tx_hwtstamp_timeouts),
>>       ICE_PF_STAT("tx_hwtstamp_flushed", ptp.tx_hwtstamp_flushed),
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ 
>> ethernet/intel/ice/ice_main.c
>> index a03e1819e6d5..d68dd2a3f4a6 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -1144,6 +1144,9 @@ ice_link_event(struct ice_pf *pf, struct 
>> ice_port_info *pi, bool link_up,
>>       if (link_up == old_link && link_speed == old_link_speed)
>>           return 0;
>> +    if (!link_up && old_link)
>> +        pf->link_down_events++;
>> +
>>       ice_ptp_link_change(pf, link_up);
>>       if (ice_is_dcb_active(pf)) {
> 
> The diff looks good.

Thank you for the review,
Martyna
> 
> 
> Kind regards,
> 
> Paul
> 
> 


