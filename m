Return-Path: <netdev+bounces-117088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAD794C991
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 07:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DF91F23C21
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B160516B75D;
	Fri,  9 Aug 2024 05:19:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDFC166318
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 05:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723180768; cv=none; b=ryf7ryUzaBpuJHYz9rj9tnAg3zDJKtByhq0AOy1z/r+0Z2WL2FYwuQBBvM6RRnFW5wl2Ph3j0lZDiMw+fM9iGXU4lixGfTYyxgnwR7TlEGB5hMPih3ao/6mpykFLroZ9f7mRgWy6exT/lmocNzqSmoAB8O+LLqv2WeSRo5XFDus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723180768; c=relaxed/simple;
	bh=WmtGRW23E6H25mY78wpEEdecv8Cvo6e0yeRhQTIWOm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZQ9c0+IBpIgMPAO6rle4JLPQu0mDK5TAP9NaBtzuPzgycpKnf3QijDB/BCc94RJHUk6ArhQPecOLUHyXt1/AisfWw/9puFbefPQHLuGTjx7bBHHIlAhSbHdpkF2h02RYabEM/sUlN1m7Vpc10gUSGYIvTJgQt4fCWjpUaJnhg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af7c9.dynamic.kabel-deutschland.de [95.90.247.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7F13261E64862;
	Fri,  9 Aug 2024 07:18:41 +0200 (CEST)
Message-ID: <08fbb337-d2f1-47a7-871e-3890b34a782f@molgen.mpg.de>
Date: Fri, 9 Aug 2024 07:18:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-next v3 1/8] ice: devlink PF MSI-X max and
 min parameter
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: wojciech.drewek@intel.com, marcin.szycik@intel.com,
 netdev@vger.kernel.org, konrad.knitter@intel.com,
 pawel.chmielewski@intel.com, intel-wired-lan@lists.osuosl.org,
 nex.sw.ncis.nat.hpm.dev@intel.com, pio.raczynski@gmail.com,
 sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com
References: <20240808072016.10321-1-michal.swiatkowski@linux.intel.com>
 <20240808072016.10321-2-michal.swiatkowski@linux.intel.com>
 <ZrTli6UxMkzE31TH@nanopsycho.orion> <ZrWlfhs6x6hrVhH+@mev-dev.igk.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ZrWlfhs6x6hrVhH+@mev-dev.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Michal,


Thank you for your patch.

Am 09.08.24 um 07:13 schrieb Michal Swiatkowski:
> On Thu, Aug 08, 2024 at 05:34:35PM +0200, Jiri Pirko wrote:
>> Thu, Aug 08, 2024 at 09:20:09AM CEST, michal.swiatkowski@linux.intel.com wrote:
>>> Use generic devlink PF MSI-X parameter to allow user to change MSI-X
>>> range.
>>>
>>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>> ---
>>> .../net/ethernet/intel/ice/devlink/devlink.c  | 56 ++++++++++++++++++-
>>> drivers/net/ethernet/intel/ice/ice.h          |  8 +++
>>> drivers/net/ethernet/intel/ice/ice_irq.c      | 14 ++++-
>>> 3 files changed, 76 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>>> index 29a5f822cb8b..bdc22ea13e0f 100644
>>> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
>>> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>>> @@ -1518,6 +1518,32 @@ static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
>>> 	return 0;
>>> }
>>>
>>> +static int
>>> +ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
>>> +				 union devlink_param_value val,
>>> +				 struct netlink_ext_ack *extack)
>>> +{
>>> +	if (val.vu16 > ICE_MAX_MSIX) {
>>> +		NL_SET_ERR_MSG_MOD(extack, "PF max MSI-X is too high");
>>
>> No reason to have "PF" in the text. Also, no reason to have "max MSI-X".
>> That is the name of the param.
> 
> Ok, will change both, thanks.

Maybe also print both values in the error message?

>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	return 0;
>>> +}

[…]


Kind regards,

Paul

