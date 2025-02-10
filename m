Return-Path: <netdev+bounces-164701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D91EA2EC50
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1F016856D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1381F758F;
	Mon, 10 Feb 2025 12:08:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E640221DB7
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739189282; cv=none; b=OIhtwWjoGcLaUu1lsqdfA+0ZdRsC9FUmLnV70bkhUaIx9FVCYvHEdNgJ7MMP9pZfxrbNJhA0zMl2blZNFS/aam13eQxBkuDGlARzxmxqYPNZG/0RgCis+/CE504N2VE4IDMsR2VqsCUe09ii02du5c+OqThbaMzWZN4FyizRqzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739189282; c=relaxed/simple;
	bh=yg8imICANbIwmYGlKLnrkAiSCf6DGkbGfRPQN9qrttU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fh4bSy2k3bMemmHwWirtugYaFPss1OtJmfzc6TGx+6ejfL8GFAIwNIDjv3j784xJ+oPdeffMI2T8ANs1i3vqfz4iJWOW8HgsmMCLmeEVFA98ki/IOUTfMbTvgPthwRIgN/CaSyJlgZL6TcYt+71s/ad0i/XQY+iUddl/oRnIuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 54F2061E647BF;
	Mon, 10 Feb 2025 13:07:29 +0100 (CET)
Message-ID: <442420d6-3911-4956-95f1-c9b278d45cd6@molgen.mpg.de>
Date: Mon, 10 Feb 2025 13:07:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: add support for
 thermal sensor event reception
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
 Anthony L Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
References: <20250210104017.62838-1-jedrzej.jagielski@intel.com>
 <87644679-1f6c-45f4-b9fd-eff1a5117b7b@molgen.mpg.de>
 <DS0PR11MB77854D8F8DEEE0A44BB0E17EF0F22@DS0PR11MB7785.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <DS0PR11MB77854D8F8DEEE0A44BB0E17EF0F22@DS0PR11MB7785.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jedrzej,


Thank you for the quick reply.


Am 10.02.25 um 12:59 schrieb Jagielski, Jedrzej:
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: Monday, February 10, 2025 12:40 PM

>> Am 10.02.25 um 11:40 schrieb Jedrzej Jagielski:
>>> E610 NICs unlike the previous devices utilising ixgbe driver
>>> are notified in the case of overheatning by the FW ACI event.
>>
>> overheating (without n)
>>
>>> In event of overheat when threshold is exceeded, FW suspends all
>>> traffic and sends overtemp event to the driver.
>>
>> I guess this was already the behavior before your patch, and now it’s
>> only logged, and the device stopped properly?

> Without this patch driver cannot receive the overtemp info. FW handles
> the event - device stops but user has no clue what has happened.
> FW does the major work but this patch adds this minimal piece of
> overtemp handling done by SW - informing user at the very end.

Thank you for the confirmation. Maybe add a small note, that it’s not 
logged to make it crystal clear for people like myself.

>>> Then driver
>>> logs appropriate message and closes the adapter instance.
>>> The card remains in that state until the platform is rebooted.
>>
>> As a user I’d be interested what the threshold is, and what the measured
>> temperature is. Currently, the log seems to be just generic?
> 
> These details are FW internals.
> Driver just gets info that such event has happened.
> There's no additional information.
> 
> In that case driver's job is just to inform user that such scenario
> has happened and tell what should be the next steps.

 From a user perspective that is a suboptimal behavior, and shows 
another time that the Linux kernel should have all the control, and 
stuff like this should be moved *out* of the firmware and not into the 
firmware.

It’d be great if you could talk to the card designers/engineers to take 
that into account, and maybe revert this decision for future versions or 
future adapters.


Kind regards,

Paul


>>      drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:static const char ixgbe_overheat_msg[] = "Network adapter has been stopped because it has over heated. Restart the computer. If the problem persists, power off the system and replace the adapter";
>>
>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>>> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>>> ---
>>> v2,3 : commit msg tweaks
>>> ---
>>>    drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 5 +++++
>>>    drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 3 +++
>>>    2 files changed, 8 insertions(+)
>>
>>
>> Kind regards,
>>
>> Paul
>>
>>
>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>> index 7236f20c9a30..5c804948dd1f 100644
>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>> @@ -3165,6 +3165,7 @@ static void ixgbe_aci_event_cleanup(struct ixgbe_aci_event *event)
>>>    static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
>>>    {
>>>    	struct ixgbe_aci_event event __cleanup(ixgbe_aci_event_cleanup);
>>> +	struct net_device *netdev = adapter->netdev;
>>>    	struct ixgbe_hw *hw = &adapter->hw;
>>>    	bool pending = false;
>>>    	int err;
>>> @@ -3185,6 +3186,10 @@ static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
>>>    		case ixgbe_aci_opc_get_link_status:
>>>    			ixgbe_handle_link_status_event(adapter, &event);
>>>    			break;
>>> +		case ixgbe_aci_opc_temp_tca_event:
>>> +			e_crit(drv, "%s\n", ixgbe_overheat_msg);
>>> +			ixgbe_close(netdev);
>>> +			break;
>>>    		default:
>>>    			e_warn(hw, "unknown FW async event captured\n");
>>>    			break;
>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
>>> index 8d06ade3c7cd..617e07878e4f 100644
>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
>>> @@ -171,6 +171,9 @@ enum ixgbe_aci_opc {
>>>    	ixgbe_aci_opc_done_alt_write			= 0x0904,
>>>    	ixgbe_aci_opc_clear_port_alt_write		= 0x0906,
>>>    
>>> +	/* TCA Events */
>>> +	ixgbe_aci_opc_temp_tca_event                    = 0x0C94,
>>> +
>>>    	/* debug commands */
>>>    	ixgbe_aci_opc_debug_dump_internals		= 0xFF08,

