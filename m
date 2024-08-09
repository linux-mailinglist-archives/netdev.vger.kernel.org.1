Return-Path: <netdev+bounces-117089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A0E94C9A0
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 07:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCC32814F9
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8A62030A;
	Fri,  9 Aug 2024 05:30:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEDC4414
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 05:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723181451; cv=none; b=IvFjBbQSzhTVvnFK8/i8HDPkHjQDTd+6Z2WDRh2lg6Yozc+oCHhYlJ/VTxRXlf8oI2VUrE5S8dU1ylCc0w7HRivzrmbWVmgcKxPoinCwKEKcpA1up5cEglFrkykWGrY7ifjMMnaw0o5CQzTlQdetyEJkswkYpo5VLfViuSIRquQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723181451; c=relaxed/simple;
	bh=J88YXH8uUuWrujayoNVT47VUhIcAuGDdZKjgGO+wV7w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tA+Y+S2MU06mmtz4YXX7INPaNLxDtevgkAcVrJeafF2g9EMs+1PTvsblvyPEryJpySaYVZN+oiPh9EhDDM6dlGnryA1Zc70oFeg9Gw4nS3Y6FeIXY7PpKfeChrEsVK0lf7c+VYYRpzLrF7uBMuK1ws02FJai4IAmnF8dp5+Ueqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af7c9.dynamic.kabel-deutschland.de [95.90.247.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C431761E64862;
	Fri,  9 Aug 2024 07:30:16 +0200 (CEST)
Message-ID: <3975b135-25ae-4576-ba61-db0f51fcf987@molgen.mpg.de>
Date: Fri, 9 Aug 2024 07:30:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-next v3 1/8] ice: devlink PF MSI-X max and
 min parameter
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: wojciech.drewek@intel.com, marcin.szycik@intel.com,
 netdev@vger.kernel.org, konrad.knitter@intel.com,
 pawel.chmielewski@intel.com, intel-wired-lan@lists.osuosl.org,
 pio.raczynski@gmail.com, sridhar.samudrala@intel.com,
 jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com
References: <20240808072016.10321-1-michal.swiatkowski@linux.intel.com>
 <20240808072016.10321-2-michal.swiatkowski@linux.intel.com>
 <ZrTli6UxMkzE31TH@nanopsycho.orion> <ZrWlfhs6x6hrVhH+@mev-dev.igk.intel.com>
 <08fbb337-d2f1-47a7-871e-3890b34a782f@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <08fbb337-d2f1-47a7-871e-3890b34a782f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: -nex.sw.ncis.nat.hpm.dev@intel.com (550 #5.1.0 Address rejected.)]

Am 09.08.24 um 07:18 schrieb Paul Menzel:
> Dear Michal,
> 
> 
> Thank you for your patch.
> 
> Am 09.08.24 um 07:13 schrieb Michal Swiatkowski:
>> On Thu, Aug 08, 2024 at 05:34:35PM +0200, Jiri Pirko wrote:
>>> Thu, Aug 08, 2024 at 09:20:09AM CEST, 
>>> michal.swiatkowski@linux.intel.com wrote:
>>>> Use generic devlink PF MSI-X parameter to allow user to change MSI-X
>>>> range.
>>>>
>>>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>>>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>>> ---
>>>> .../net/ethernet/intel/ice/devlink/devlink.c  | 56 ++++++++++++++++++-
>>>> drivers/net/ethernet/intel/ice/ice.h          |  8 +++
>>>> drivers/net/ethernet/intel/ice/ice_irq.c      | 14 ++++-
>>>> 3 files changed, 76 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/ 
>>>> drivers/net/ethernet/intel/ice/devlink/devlink.c
>>>> index 29a5f822cb8b..bdc22ea13e0f 100644
>>>> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
>>>> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>>>> @@ -1518,6 +1518,32 @@ static int 
>>>> ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
>>>>     return 0;
>>>> }
>>>>
>>>> +static int
>>>> +ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
>>>> +                 union devlink_param_value val,
>>>> +                 struct netlink_ext_ack *extack)
>>>> +{
>>>> +    if (val.vu16 > ICE_MAX_MSIX) {
>>>> +        NL_SET_ERR_MSG_MOD(extack, "PF max MSI-X is too high");
>>>
>>> No reason to have "PF" in the text. Also, no reason to have "max MSI-X".
>>> That is the name of the param.
>>
>> Ok, will change both, thanks.
> 
> Maybe also print both values in the error message?
> 
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
> 
> […]
> 
> 
> Kind regards,
> 
> Paul

