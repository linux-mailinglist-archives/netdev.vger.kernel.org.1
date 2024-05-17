Return-Path: <netdev+bounces-96956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEC48C86E6
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FF9282631
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F90E4F894;
	Fri, 17 May 2024 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Aljr7yDn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA303AC10
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715950855; cv=none; b=coJdFXGb9NUy5pQSdWT+4+HYz4sp49ZuQ7rsuMGGADC84ybXJt0JA29CS4wqAnXL2NE3jHGBbaz9tcRsEb8dFUvm1Wq7OoFpKcp1vHi2UWceo47aqvTfhd29aaNaa4zwJQROc3YlIYBxQJpRSGnuO8gJEJjBfB7qsFNe9TFSB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715950855; c=relaxed/simple;
	bh=UIkuizklu5c5g73OTrA9x4jnuv1iZjs5q3Zr4yBj9R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6MSareEBjUvLgd+IFGHoJIyQlV8r0acaTDFudXVAlbIHJtoe3lL+TY8Hr4MeC0urVU4GrY80ucQvsKbMxOpbibdHFPFdkukaiPZxLo+cYumMfXeBtNzJZJ2Bcdklm4l9KWb/OwzxRsILEjFT1HkdikQiYzoQdXbK1TH2b2g4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Aljr7yDn; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.55.5.117] (unknown [149.11.192.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DF10440EA3;
	Fri, 17 May 2024 13:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715950848;
	bh=myvPLjv4bFMc1kb4GvTbprFTOmVtT8sz1hqU3fBSfJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Aljr7yDnAGOaoT+bT63vj+O2dd1EaUlHGy7vQyLQrkvSN6jtuHCF0LymqOM0QRZAd
	 dhhd/xdRaV52khnhBoeu1kAAv9j15IgwlERhV1wR78n935ZcpVWcCQBP6TFZZtXwel
	 mzcvSkpNkgb+Si7f7ZnEQ5LhBI5ITJ60Nm46udLEVZINMN//Y+HlVFzhIssgRYTGVr
	 YAnbvxoOmFea5jBPgvtXi0l4VuyN7Bh7nFwZfG+3Ln2Z4zqTIwGGcVbg1SMgfFhIvk
	 WGdvSqgD863ji6O6aJJhw0LUZiMpspo9rgWT0zZtVGYIvbBca629G7+9vwyUbG/IU+
	 nEUkdAJjS4uKw==
Message-ID: <2493e4f7-7043-4408-be99-9ee329cb3db9@canonical.com>
Date: Fri, 17 May 2024 21:00:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2] e1000e: move force SMBUS near the
 end of enable_ulp function
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 kuba@kernel.org, anthony.l.nguyen@intel.com, vitaly.lifshits@intel.com,
 dima.ruinskiy@intel.com, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, sasha.neftin@intel.com, naamax.meir@linux.intel.com,
 Jacob Keller <jacob.e.keller@intel.com>, Oliver Sang
 <oliver.sang@intel.com>, Zhang Rui <rui.zhang@intel.com>,
 regressions@lists.linux.dev
References: <20240508120604.233166-1-hui.wang@canonical.com>
 <cdab9b76-e935-4b38-9b5c-496ff8fdfb64@molgen.mpg.de>
 <7b0a36a5-4265-41e7-b66a-2cd1f01aed42@canonical.com>
 <8bc68316-fef4-47c0-ad08-ad93f6a4fb30@molgen.mpg.de>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <8bc68316-fef4-47c0-ad08-ad93f6a4fb30@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/17/24 18:07, Paul Menzel wrote:
> Dear Hui,
>
>
> Thank you for your response.
>
>
> Am 17.05.24 um 11:45 schrieb Hui Wang:
>>
>> On 5/17/24 13:45, Paul Menzel wrote:
>
>>> Am 08.05.24 um 14:06 schrieb Hui Wang:
>>>> The commit 861e8086029e ("e1000e: move force SMBUS from enable ulp
>>>> function to avoid PHY loss issue") introduces a regression on
>>>> CH_MTP_I219_LM18 (PCIID: 0x8086550A). Without the referred commit, the
>>>
>>> *P*CH
>>>
>>>> ethernet works well after suspend and resume, but after applying the
>>>> commit, the ethernet couldn't work anymore after the resume and the
>>>> dmesg shows that the NIC Link changes to 10Mbps (1000Mbps originally):
>>>
>>> 1.  s/Link/link/
>>> 2.  “couldn’t work” means the reduced bandwidth?
>>
>> On my side, once the link changes to 10Mbps, I couldn't ping the 
>> machine anymore. And as you said, it probably has sth to do with 
>> switch/router configuration.
>>
>>> 3. Please add a blank line and maybe indent the past with four spaces.
>>>
>>>> [   43.305084] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 10 
>>>> Mbps Full Duplex, Flow Control: Rx/Tx
>>>>
>>>> Without the commit, the force SMBUS code will not be executed if
>>>> "return 0" or "goto out" is executed in the enable_ulp(), and in my
>>>> case, the "goto out" is executed since FWSM_FW_VALID is set. But after
>>>> applying the commit, the force SMBUS code will be ran unconditionally.
>>>>
>>>> Here move the force SMBUS code back to enable_ulp() and put it
>>>> immediate ahead of hw->phy.ops.release(hw), this could allow the
>>>
>>> immediate*l*?
>
> Sorry, I meant immediate*ly*.
Got it.
>
>>>> longest settling time as possible for interface in this function and
>>>> doesn't change the original code logic.
>>>
>>> Re-ordering code to achieve some waiting time sounds like, it’s not 
>>> 100 % sure, that the problem won’t occur again?
>>
>> Actually this patch not only adds the waiting time, but also restore 
>> the original code logic:
>>
>>   original: On a machine with the CSME, the SMBUS will not be forced, 
>> accordingly the SMBUS will not be unforced after resume.
>>
>>   wrong: On a machine with the CSME, the SMBUS is forced, but the 
>> SMBUS is not unforced after resume, there is an unbalance. My patch 
>> could fix this case.
>
> Thank you for elaborating. In my opinion, then two commits would be 
> better. One revert with a description of the problem and documentation 
> of the test systems. Then the second patch with the fix.

What you said makes sense. But for this particular case, I think it is 
not necessary since the patch is not that complicated and explanation is 
already in the commit header.

Anyway, I will address the rest comment of you and send a v3 patch.

Thanks,

Hui.

>
>>> Could you please document your test system?
>> Lenovo Thinkpad P16Gen2 with ethernet card:
>>
>> 00:1f.6 Ethernet controller [0200]: Intel Corporation Device 
>> [8086:550a] (rev 20)
>>
>>> Just a side note: Booting Linux 6.9-rc5+ *with kexec* on Supermicro 
>>> Super Server/X13SAE, BIOS 2.0 10/17/2022 with the network device 
>>> below, it also came up only with 10 Mbps and Ethernet did not work, 
>>> for example `ping`. I conjectured though, that the non-working part 
>>> was due to the switch configuration not allowing 10 Mbps.
>>>
>>>     00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet 
>>> Connection (17) I219-LM [8086:1a1c] (rev 11)
>>>
>> My test and result are same as yours.
>>
>> Thanks.
>
> Thank you for the confirmation.
>
>>> I didn’t find the time to further analyze and report the issue.
>>>
>>> Also could this also be related to the regression reported by the 
>>> kernel test robot [1]?
>>>
>>>     00:19.0 Ethernet controller: Intel Corporation Ethernet 
>>> Connection (3) I218-V (rev 03)
>>>
>>>> Fixes: 861e8086029e ("e1000e: move force SMBUS from enable ulp 
>>>> function to avoid PHY loss issue")
>>>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>>>> Acked-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
>>>> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
>>>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>>> ---
>>>> In the v2:
>>>>   Change "this commit" to "the referred commit" in the commit header
>>>>   Fix a potential infinite loop if ret_val is not zero
>>>>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 22 
>>>> +++++++++++++++++++++
>>>>   drivers/net/ethernet/intel/e1000e/netdev.c  | 18 -----------------
>>>>   2 files changed, 22 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c 
>>>> b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>> index f9e94be36e97..2e98a2a0bead 100644
>>>> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>> @@ -1225,6 +1225,28 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw 
>>>> *hw, bool to_sx)
>>>>       }
>>>>     release:
>>>> +    /* Switching PHY interface always returns MDI error
>>>> +     * so disable retry mechanism to avoid wasting time
>>>> +     */
>>>> +    e1000e_disable_phy_retry(hw);
>>>> +
>>>> +    /* Force SMBus mode in PHY */
>>>> +    ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, 
>>>> &phy_reg);
>>>> +    if (ret_val) {
>>>> +        e1000e_enable_phy_retry(hw);
>>>> +        hw->phy.ops.release(hw);
>>>> +        goto out;
>>>> +    }
>>>> +    phy_reg |= CV_SMB_CTRL_FORCE_SMBUS;
>>>> +    e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
>>>> +
>>>> +    e1000e_enable_phy_retry(hw);
>>>> +
>>>> +    /* Force SMBus mode in MAC */
>>>> +    mac_reg = er32(CTRL_EXT);
>>>> +    mac_reg |= E1000_CTRL_EXT_FORCE_SMBUS;
>>>> +    ew32(CTRL_EXT, mac_reg);
>>>> +
>>>>       hw->phy.ops.release(hw);
>>>>   out:
>>>>       if (ret_val)
>>>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c 
>>>> b/drivers/net/ethernet/intel/e1000e/netdev.c
>>>> index 3692fce20195..cc8c531ec3df 100644
>>>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>>>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>>>> @@ -6623,7 +6623,6 @@ static int __e1000_shutdown(struct pci_dev 
>>>> *pdev, bool runtime)
>>>>       struct e1000_hw *hw = &adapter->hw;
>>>>       u32 ctrl, ctrl_ext, rctl, status, wufc;
>>>>       int retval = 0;
>>>> -    u16 smb_ctrl;
>>>>         /* Runtime suspend should only enable wakeup for link 
>>>> changes */
>>>>       if (runtime)
>>>> @@ -6697,23 +6696,6 @@ static int __e1000_shutdown(struct pci_dev 
>>>> *pdev, bool runtime)
>>>>               if (retval)
>>>>                   return retval;
>>>>           }
>>>> -
>>>> -        /* Force SMBUS to allow WOL */
>>>> -        /* Switching PHY interface always returns MDI error
>>>> -         * so disable retry mechanism to avoid wasting time
>>>> -         */
>>>> -        e1000e_disable_phy_retry(hw);
>>>> -
>>>> -        e1e_rphy(hw, CV_SMB_CTRL, &smb_ctrl);
>>>> -        smb_ctrl |= CV_SMB_CTRL_FORCE_SMBUS;
>>>> -        e1e_wphy(hw, CV_SMB_CTRL, smb_ctrl);
>>>> -
>>>> -        e1000e_enable_phy_retry(hw);
>>>> -
>>>> -        /* Force SMBus mode in MAC */
>>>> -        ctrl_ext = er32(CTRL_EXT);
>>>> -        ctrl_ext |= E1000_CTRL_EXT_FORCE_SMBUS;
>>>> -        ew32(CTRL_EXT, ctrl_ext);
>>>>       }
>>>>         /* Ensure that the appropriate bits are set in LPI_CTRL
>
>
> Kind regards,
>
> Paul
>
>
>>> [1]: 
>>> https://lore.kernel.org/intel-wired-lan/202405150942.f9b873b1-oliver.sang@intel.com/

