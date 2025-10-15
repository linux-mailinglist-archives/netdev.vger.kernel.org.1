Return-Path: <netdev+bounces-229536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 235E4BDDD1C
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C63A19A2D8B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1E7319857;
	Wed, 15 Oct 2025 09:39:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF53176EF;
	Wed, 15 Oct 2025 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521185; cv=none; b=FeCX3KC4BwRE2MuszTjE+nkp8yjNmsHSoYl4BMVhepiScCfoRvMbf9YdaFkA9gt8bIFHlAptCr6iw8Z0Dvso05Ll5ortm01+nb0YC4yaGgv0ryrdPGaz3hbVcbV7qj2sCUnC2gnxMinvQUOHp2Yj6a1dQBpt5L1cowIuFNXRctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521185; c=relaxed/simple;
	bh=qEi9fDQcS/rkwScoxKyo0yfqMU+XvDYKJbufVzcqJws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/voiVCLSenDxvZxh+uuDlhBMDM9l3EaB+ZQ+GZV+J4F904GzcZdMjZP6szNlvMJUqMDc8jKg1+4xMbz0FIwMOoWcXvOnVxajfD4YHqhIjOuAHlBri4Ws8ywB8Hd+iYS7XeF3+8MiqG64VIHwhGo0eLMfUQPHmrS/spfEhV4wKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.212] (p57bd968e.dip0.t-ipconnect.de [87.189.150.142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3E56760213B36;
	Wed, 15 Oct 2025 11:39:00 +0200 (CEST)
Message-ID: <bf36b4ed-e35f-4943-93ea-b24b27a48ad3@molgen.mpg.de>
Date: Wed, 15 Oct 2025 11:38:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] ixgbe: Add 10G-BX support
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251014-10gbx-v2-1-980c524111e7@birger-koblitz.de>
 <21a53fe4-7cad-4717-87db-2f433659e174@molgen.mpg.de>
 <0d2b88ac-d23d-43a5-813d-2a8c4edaa3eb@birger-koblitz.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <0d2b88ac-d23d-43a5-813d-2a8c4edaa3eb@birger-koblitz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Birger,


Thank you for your prompt reply.

Am 15.10.25 um 11:16 schrieb Birger Koblitz:

> On 15/10/2025 9:59 am, Paul Menzel wrote:
>> Am 14.10.25 um 06:18 schrieb Birger Koblitz:
>>> Adds support for 10G-BX modules, i.e. 10GBit Ethernet over a single strand
>>> Single-Mode fiber
>>
>> I’d use imperative mood, and add a dot/period at the end.
> I will put this into the next patch-version.
> 
>>> @@ -1678,6 +1680,31 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
>>>               else
>>>                   hw->phy.sfp_type =
>>>                       ixgbe_sfp_type_1g_bx_core1;
>>> +        /* Support Ethernet 10G-BX, checking the Bit Rate
>>> +         * Nominal Value as per SFF-8472 to be 12.5 Gb/s (67h) and
>>> +         * Single Mode fibre with at least 1km link length
>>> +         */
>>> +        } else if ((!comp_codes_10g) && (bitrate_nominal == 0x67) &&
>>> +               (!(cable_tech & IXGBE_SFF_DA_PASSIVE_CABLE)) &&
>>> +               (!(cable_tech & IXGBE_SFF_DA_ACTIVE_CABLE))) {
>>> +            status = hw->phy.ops.read_i2c_eeprom(hw,
>>> +                        IXGBE_SFF_SM_LENGTH_KM,
>>> +                        &sm_length_km);
>>> +            if (status != 0)
>>> +                goto err_read_i2c_eeprom;
>>
>> Should an error be logged?
>>
> This needs to be read in the context of the rest of the SFP 
> identification function. Several bytes of the EEPROM have already been 
> read for module identification by the existing code before reaching this 
> point, and failure is handled everywhere by the same goto. What will 
> happen if EEPROM reading fails is that an error message will be logged 
> that the Module is not supported. This is because the type is not filled 
> in and the module therefore considered unsupported. The actual error 
> (ret_val = -ENOENT) is ignored e.g. in ixgbe_52599/ 
> ixgbe_init_phy_ops_82599(). The error logged is probably good enough: 
> the module cannot be positively identified and is not enabled. I say 
> good enough, because this is actually what is the case: the EEPROM is 
> broken and ther
> 
>>> +            status = hw->phy.ops.read_i2c_eeprom(hw,
>>> +                        IXGBE_SFF_SM_LENGTH_100M,
>>> +                        &sm_length_100m);
>>> +            if (status != 0)
>>> +                goto err_read_i2c_eeprom;
>>
>> Should an error be logged?
> Same here.
> 
>>
>>> +            if (sm_length_km > 0 || sm_length_100m >= 10) {
>>> +                if (hw->bus.lan_id == 0)
>>> +                    hw->phy.sfp_type =
>>> +                        ixgbe_sfp_type_10g_bx_core0;
>>> +                else
>>> +                    hw->phy.sfp_type =
>>> +                        ixgbe_sfp_type_10g_bx_core1;
>>
>> I’d prefer the ternary operator, if only the same variable is assigned 
>> in both branches.
> Me, too. But this is merely code that can be found verbosely the same in 
> several places before in this identification function, for each type of 
> module identified basically once. If the same code would be written 
> differently in this place, it would probably confuse readers who would 
> wonder what is different.

You are right in all accounts. Thank you for the explanations.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

