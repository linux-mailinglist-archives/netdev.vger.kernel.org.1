Return-Path: <netdev+bounces-281286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YADxCPox72mb8wAAu9opvQ
	(envelope-from <netdev+bounces-281286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:52:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7891B4702BA
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2972B301D06E
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D7F3B3884;
	Mon, 27 Apr 2026 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGJTX6Ow"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17652FFDE1;
	Mon, 27 Apr 2026 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283531; cv=none; b=BfO8th1ioKPcewPZ10v3I6JLLMMv4pL+qEnugAtMQvfv3VFmSQ3pWhtzgo2agHsd09KGH2QW4TTJP6prPs2SSTxVx1ml4NhMNHQqjq/BARGY9qjpEbhuTESWZVvCHKglOD4v8qd2WZwkQkKlXBQhSgKHIvxUn7lSYTU1K6U8DX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283531; c=relaxed/simple;
	bh=3ScpVu6cd+qG8bDqwMH9nLLo7ljJEm+ttcCR8fkeroc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3LCG2yxOulLXQPy1LdXhJeoYiDWNB5yFv5ShavNDBPnYkl5J7qDQ1MglorBO23jQtkj5iLhaxzNAvRjVgc5XluAzBodJa8F8kehRvv7jdAFDBGyXEtp1thB4EsTTBQrmt0IXPS2YeOmUnQq4A1N4kNGnBso5zPIqkQ+e3WWpSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGJTX6Ow; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777283530; x=1808819530;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3ScpVu6cd+qG8bDqwMH9nLLo7ljJEm+ttcCR8fkeroc=;
  b=eGJTX6OwZL70AybYuQkg8EkqIya8P1IU5fynQ86fd91jrB56kzKmKxq4
   JeiKT7Dl/fJQsLKUOYoJNR/Y8/N35G2hUQd+jreDXWoWmv/VyyTIUlSWr
   qgsiKheoFAn9ITkE+xaGeP9KVasuP3XZnvLw3LPw7IXkrmCQO6FsK9JqJ
   ObsZSvDOJQH/Cl/xDndSMBOlVlNRgy06yhUP/uHcXqPj/XRoNnfG+/t+U
   McMxElDxGD1kPopsFInJL4nqR83s8cfsxLfLvJquwWVkVhKPAPRzosUEe
   B/mhdxJaPsf47zyPkhngnbQwiMllngfN1RWkLgOPm9OIN416s1cv+R86w
   A==;
X-CSE-ConnectionGUID: eMJ3aHQkTZa4nY+mcm2oXQ==
X-CSE-MsgGUID: kU9HqWK3QHGRdDdsxLdxIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="81775654"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="81775654"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:52:10 -0700
X-CSE-ConnectionGUID: x6YF+sgUTPGQwgPOysOEng==
X-CSE-MsgGUID: 34g8Pw/aRW+Zn8ka784p5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="237916743"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.80.101]) ([10.247.80.101])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:52:05 -0700
Message-ID: <7b10fe32-4f3f-4473-ae69-82af901b7a1f@linux.intel.com>
Date: Mon, 27 Apr 2026 17:52:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 3/3] igc: add support for forcing link speed
 without autonegotiation
To: Simon Horman <horms@kernel.org>, KhaiWenTan <khai.wen.tan@linux.intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 faizal.abdul.rahim@intel.com, hong.aun.looi@intel.com,
 khai.wen.tan@intel.com, Looi@web.codeaurora.org
References: <20260422155701.7420-1-khai.wen.tan@linux.intel.com>
 <20260422155701.7420-4-khai.wen.tan@linux.intel.com>
 <20260424135958.GL900403@horms.kernel.org>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20260424135958.GL900403@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7891B4702BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281286-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[faizal.abdul.rahim@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]



On 24/4/2026 9:59 pm, Simon Horman wrote:
> On Wed, Apr 22, 2026 at 11:57:01PM +0800, KhaiWenTan wrote:
>> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>>
>> Allow users to force 10/100 Mb/s link speed and duplex via ethtool
>> when autonegotiation is disabled. Previously, the driver rejected
>> these requests with "Force mode currently not supported.".
>>
>> Forcing at 1000 Mb/s and 2500 Mb/s is not supported.
>>
>> Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> 
> ...
> 
>> @@ -2000,6 +2013,41 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
>>   	return 0;
>>   }
>>   
>> +/**
>> + * igc_handle_autoneg_disabled - Configure forced speed/duplex settings
>> + * @adapter: private driver structure
>> + * @speed: requested speed (must be SPEED_10 or SPEED_100)
>> + * @duplex: requested duplex
>> + *
>> + * Records forced speed/duplex when autoneg is disabled.
>> + * Caller must validate speed before calling this function.
>> + */
>> +static void igc_handle_autoneg_disabled(struct igc_adapter *adapter, u32 speed,
>> +					u8 duplex)
>> +{
>> +	struct igc_mac_info *mac = &adapter->hw.mac;
>> +
>> +	switch (speed) {
>> +	case SPEED_10:
>> +		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
>> +			IGC_FORCED_10F : IGC_FORCED_10H;
>> +		break;
>> +	case SPEED_100:
>> +		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
>> +			IGC_FORCED_100F : IGC_FORCED_100H;
>> +		break;
>> +	default:
>> +		WARN_ONCE(1, "Unsupported speed %u\n", speed);
>> +		return;
>> +	}
>> +
>> +	mac->autoneg_enabled = false;
>> +
>> +	/* Half-duplex cannot support flow control per IEEE 802.3 */
>> +	if (duplex != DUPLEX_FULL)
>> +		adapter->hw.fc.requested_mode = igc_fc_none;
>> +}
>> +
>>   /**
>>    * igc_handle_autoneg_enabled - Configure autonegotiation advertisement
>>    * @adapter: private driver structure
>> @@ -2038,6 +2086,7 @@ static void igc_handle_autoneg_enabled(struct igc_adapter *adapter,
>>   						  10baseT_Half))
>>   		advertised |= ADVERTISE_10_HALF;
>>   
>> +	hw->mac.autoneg_enabled = true;
>>   	hw->phy.autoneg_advertised = advertised;
>>   	if (adapter->fc_autoneg)
>>   		hw->fc.requested_mode = igc_fc_default;
>> @@ -2071,14 +2120,20 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
>>   		}
>>   	}
>>   
>> +	if (cmd->base.autoneg == AUTONEG_DISABLE &&
>> +	    cmd->base.speed != SPEED_10 && cmd->base.speed != SPEED_100) {
>> +		netdev_info(dev, "Unsupported speed for forced link\n");
>> +		return -EINVAL;
>> +	}
> 
> The condition above verifies speed only if autoneg is AUTONEG_DISABLE.
> 
>> +
>>   	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
>>   		usleep_range(1000, 2000);
>>   
>> -	if (cmd->base.autoneg == AUTONEG_ENABLE) {
>> +	if (cmd->base.autoneg == AUTONEG_ENABLE)
>>   		igc_handle_autoneg_enabled(adapter, cmd);
>> -	} else {
>> -		netdev_info(dev, "Force mode currently not supported\n");
>> -	}
>> +	else
>> +		igc_handle_autoneg_disabled(adapter, cmd->base.speed,
>> +					    cmd->base.duplex);
> 
> But here igc_handle_autoneg_disabled, which relies on speed having been
> verified, is called if autoneg is not AUTONEG_ENABLE.
> 
> If autoneg is AUTONEG_DISABLE here, then all is good.
> But if it is neither AUTONEG_DISABLE nor AUTONEG_ENABLE then we
> are in trouble.
> 
> I suggest verifying autoneg is either AUTONEG_ENABLE or AUTONEG_DISABLE
> earlier in this function.

Will update, thanks.

