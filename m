Return-Path: <netdev+bounces-150246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C699B9E993A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43445188641F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E371B4245;
	Mon,  9 Dec 2024 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="MpvFD+rC"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002F1B423B
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755505; cv=none; b=JrMPsKWydErytWEVBgitcdRndzI0Km8DYXO+2dB3voJKN8+djRhEOAC39qpvAzxCuZyzF9odFpH+XocSRMb/H5sq8swwhEQy/MRpPtFaqwqjQ34AT/QTKKed2uw168t0RNDR+RqswkYcH5OEyNNn2EDO94SZCYoYlspPPOWFhjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755505; c=relaxed/simple;
	bh=u7NA73GY8jgYwiGRtfvoA2jwmRSjtj17Sc8PPBrpK/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=On5RTpFFVJ+ZvSDRXMKapRcazHNQI/AlRyB5urEdYpm9W5HvNGlSQuC6WNGhDNT+QPS4YCMLb0gWuOUlqfo3P0IA/WF1LEmNETUNvw2ZbRTtFo9SQox9ojkz0eRUmBDGaiDL/S78kmit4xwMZpBvdzw2Boh7+1pqzTAEuypMqcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=MpvFD+rC; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202412091444588a20b3f99265f4aebc
        for <netdev@vger.kernel.org>;
        Mon, 09 Dec 2024 15:44:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/dEgr6OpgHZjVc2Im78pfKS7HysoQJSF6iVpM5jFCQU=;
 b=MpvFD+rCvxzx8xva5hr3nsUvs2LKTdXkzEfM04rBRDxpPIIPYXnkeC3YZFdVgfvEZdoAgw
 z61x8EOUQjPlhsAanQBmDeesAimgmGKPZAnJAhXPKcrkXJqyCJ357X9C0PQ1fW/hI43vZyB/
 ZF2dIWpjCBEya6UJ2O2qoCKKK4y89XUEpMfE10IShP8ruEVFsaVC3L9/0yz1HE0qc4iZwmI4
 WROiTw8NYdq2c7bLB9mzW9/zOM+CgbO3bK440lUvbKTeriqZbsbdr6lRG4OE/vpWLYQ9yWFq
 vQs3O/tT2BtR0TGsNSQpu6dl+6olTg95I8iGlJrsQnB32nM0UdIEsdFQ==;
Message-ID: <320d8f96-fcff-48e7-9814-6586f7f642ca@siemens.com>
Date: Mon, 9 Dec 2024 14:44:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3 1/2] net: ti: icssg-prueth: Fix firmware load
 sequence.
To: Meghana Malladi <m-malladi@ti.com>, Roger Quadros <rogerq@kernel.org>,
 vigneshr@ti.com, jan.kiszka@siemens.com, javier.carrasco.cruz@gmail.com,
 jacob.e.keller@intel.com, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, danishanwar@ti.com
References: <20241205082831.777868-1-m-malladi@ti.com>
 <20241205082831.777868-2-m-malladi@ti.com>
 <a86bc0b1-8bb4-477e-b7e1-13921bf47b53@kernel.org>
 <64621290-2488-474d-b2ed-597a1f4ac85f@ti.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <64621290-2488-474d-b2ed-597a1f4ac85f@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

Hi all,

On 12/9/24 10:34 AM, Meghana Malladi wrote:
> 
> 
> On 05/12/24 18:38, Roger Quadros wrote:
>> Hi,
>>
>> On 05/12/2024 10:28, Meghana Malladi wrote:
>>> From: MD Danish Anwar <danishanwar@ti.com>
>>>
>>> Timesync related operations are ran in PRU0 cores for both ICSSG SLICE0
>>> and SLICE1. Currently whenever any ICSSG interface comes up we load the
>>> respective firmwares to PRU cores and whenever interface goes down, we
>>> stop the resective cores. Due to this, when SLICE0 goes down while
>>> SLICE1 is still active, PRU0 firmwares are unloaded and PRU0 core is
>>> stopped. This results in clock jump for SLICE1 interface as the timesync
>>> related operations are no longer running.
>>>
>>> As there are interdependencies between SLICE0 and SLICE1 firmwares,
>>> fix this by running both PRU0 and PRU1 firmwares as long as at least 1
>>> ICSSG interface is up. Add new flag in prueth struct to check if all
>>> firmwares are running.
>>>
>>> Use emacs_initialized as reference count to load the firmwares for the
>>> first and last interface up/down. Moving init_emac_mode and 
>>> fw_offload_mode
>>> API outside of icssg_config to icssg_common_start API as they need
>>> to be called only once per firmware boot.
>>>
>>> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>>> ---
>>>
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/ 
>>> net/ethernet/ti/icssg/icssg_prueth.h
>>> index f5c1d473e9f9..b30f2e9a73d8 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>> @@ -257,6 +257,7 @@ struct icssg_firmwares {
>>>    * @is_switchmode_supported: indicates platform support for switch 
>>> mode
>>>    * @switch_id: ID for mapping switch ports to bridge
>>>    * @default_vlan: Default VLAN for host
>>> + * @prus_running: flag to indicate if all pru cores are running
>>>    */
>>>   struct prueth {
>>>       struct device *dev;
>>> @@ -298,6 +299,7 @@ struct prueth {
>>>       int default_vlan;
>>>       /** @vtbl_lock: Lock for vtbl in shared memory */
>>>       spinlock_t vtbl_lock;
>>> +    bool prus_running;
>>
>> I think you don't need fw_running flag anymore. Could you please 
>> remove it
>> from struct prueth_emac?
>>
> 
> This flag is still being used by SR1, for which this patch doesn't 
> apply. So I prefer not touching this flag for the sake of SR1.

Currently for SR1.0 this flag is set but not used anywhere in the code, 
so it can be removed.

Best regards,
Diogo

