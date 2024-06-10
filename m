Return-Path: <netdev+bounces-102216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F27901F1B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F3F1C203BC
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B690D77F2F;
	Mon, 10 Jun 2024 10:19:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2377838DEC
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 10:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014755; cv=none; b=oUyY8/ClfxEHLlcnlx2PuzlqNXgPu87a8J34SDYKBKgA8kR6ErCGa5YKyXm7CJ2/M2I0hGrSknMUrISHx7aO2z3FgxYhNq4OXfCo98S2L9kXA0oDBEuwjqbhEgue9FD0wfVJFfyJexnygODr/0QgQTE1/f3nQfbm4YNobWKXMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014755; c=relaxed/simple;
	bh=e+f9c8WDB5Klp6YySXK6jipqRFVoLrAC7d9ZkIj2jCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3wjX284xzhkNsaT2Xp3v2ZrW2w7jjYsTzx2IwARLfbIHNu9iUOzUEye1Bd0guZadUsRJZRS61CLJCyD5/rBSX97olz9ZV8clWQf7MXwGv+oAQXad92G8xWDB4OkT7CUPuYBjnqXtilHPaKdT37bbRICTZK7S6w1ewljQgnCeqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8542061E5FE01;
	Mon, 10 Jun 2024 12:18:44 +0200 (CEST)
Message-ID: <fefc72e6-5546-4485-b7c0-7f40c6fb95ce@molgen.mpg.de>
Date: Mon, 10 Jun 2024 12:18:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: fix hot issue NVM content
 is corrupted after nvmupdate
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Kelvin Kang <kelvin.kang@intel.com>
Cc: Jan Sokolowski <jan.sokolowski@intel.com>, netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Anthony L Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, Leon Romanovsky <leonro@nvidia.com>
References: <20240610092051.2030587-1-aleksandr.loktionov@intel.com>
 <a2ad5189-10d1-4e6b-8509-b1ce4e1e7526@molgen.mpg.de>
 <SJ0PR11MB5866360BDA97A03298A4A637E5C62@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <SJ0PR11MB5866360BDA97A03298A4A637E5C62@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Aleksandr,


Thank you for your prompt reply.

Am 10.06.24 um 12:14 schrieb Loktionov, Aleksandr:

>> -----Original Message-----
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Monday, June 10, 2024 11:45 AM

[…]

>> Am 10.06.24 um 11:20 schrieb Aleksandr Loktionov:
>>> After 230f3d53a547 patch all I/O errors are being converted into
>>> EAGAIN which leads to retries until timeout so nvmupdate sometimes
>>> fails after more than 20 minutes!
>>>
>>> Remove misleading EIO to EGAIN conversion and pass all errors as is.
>>>
>>> Fixes: 230f3d53a547 ("i40e: remove i40e_status")
>>
>> This commit is present since v6.6-rc1, released September last year
>> (2023). So until now, nobody noticed this?
>>
> Really, really. The regression affects users only when they update F/W,
> and not all F/W are affected, only that generate I/O errors while update.

Thank you for the clarification.

> Not cars are affected, but the consequences are serous as in subj.

Please details this also in the commit message (body) as asked for below.

>>> Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
>>> Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
>>> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>
>> Please give more details about your test setup. For me it’s also
>> not clear, how the NVM content gets corrupted as stated in the
>> summary/title. Could you please elaborate that in the commit
>> message.
>>
>>> ---
>>>    drivers/net/ethernet/intel/i40e/i40e_adminq.h | 4 ----
>>>    1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
>>> b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
>>> index ee86d2c..55b5bb8 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
>>> @@ -109,10 +109,6 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
>>>    		-EFBIG,      /* I40E_AQ_RC_EFBIG */
>>>    	};
>>>
>>> -	/* aq_rc is invalid if AQ timed out */
>>> -	if (aq_ret == -EIO)
>>> -		return -EAGAIN;
>>> -
>>>    	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
>>>    		return -ERANGE;
>>
>> The referenced commit 230f3d53a547 does:
>>
>> ```
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
>> b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
>> index ee394aacef4d..267f2e0a21ce 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
>> @@ -5,7 +5,6 @@
>>    #define _I40E_ADMINQ_H_
>>
>>    #include "i40e_osdep.h"
>> -  #include "i40e_status.h"
>>    #include "i40e_adminq_cmd.h"
>>
>>    #define I40E_ADMINQ_DESC(R, i)   \
>> @@ -117,7 +116,7 @@ static inline int i40e_aq_rc_to_posix(int
>> aq_ret, int aq_rc)
>>           };
>>
>>           /* aq_rc is invalid if AQ timed out */
>> -       if (aq_ret == I40E_ERR_ADMIN_QUEUE_TIMEOUT)
>> +       if (aq_ret == -EIO)
>>                   return -EAGAIN;
>>
>>           if (!((u32)aq_rc < (sizeof(aq_to_posix) /
>> sizeof((aq_to_posix)[0]))))
>> ```
>>
>> So I do not see yet, why removing the whole hunk is the solution.


Kind regards,

Paul

