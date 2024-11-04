Return-Path: <netdev+bounces-141453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0CF9BAF54
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749AE1F20F43
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289B31AB6F1;
	Mon,  4 Nov 2024 09:12:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF6E185B4D
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711565; cv=none; b=a+DOOvXC0MJKxuDgtqJIgT6vcZ+U7HJq1Tl8QomSHpduNyjme/3VEs65f1EZYizLufPAQBS153eno+tA4RygEe7Y3mxXjs4IbdxHH7FRms8E/odPIcWtdVSBUX9qIHFFbPXB6WLCKJtxLX/1F8zIcFDdjxM0xyvkZYTyGKMYink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711565; c=relaxed/simple;
	bh=z+5VE5uvTf7gIOcAHifjL06y182YByBEIcr+Dc0DLik=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ABBKt7eOA9bvuF+IGzgTro7oPTYMtL0Y27hWhGIBHTdGTH1h05vXL3V6BcCA9iRk1wnuiJlnxGcreB/sSRPze5cMaqPUZCwhaTBLVLiceIGtHUzneuhv+WcphSmWA9eiEpe5K+ABz9vDxsoSK4WsPj8VlsEHJiVh0QznYudFki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (unknown [95.90.234.35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 145BC61BF4882;
	Mon, 04 Nov 2024 10:12:15 +0100 (CET)
Message-ID: <478248d8-559b-4324-a566-8ce691993018@molgen.mpg.de>
Date: Mon, 4 Nov 2024 10:12:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] Small Integers: Big Penalty
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: David Laight <David.Laight@ACULAB.COM>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: wojciech.drewek@intel.com, marcin.szycik@intel.com,
 netdev@vger.kernel.org, konrad.knitter@intel.com,
 pawel.chmielewski@intel.com, horms@kernel.org,
 intel-wired-lan@lists.osuosl.org, pio.raczynski@gmail.com,
 sridhar.samudrala@intel.com, jacob.e.keller@intel.com, jiri@resnulli.us,
 przemyslaw.kitszel@intel.com
References: <20241028100341.16631-1-michal.swiatkowski@linux.intel.com>
 <20241028100341.16631-3-michal.swiatkowski@linux.intel.com>
 <CADEbmW0=G8u7Y8L2fFTzan8S+Uz04nAMC+-dkj-rQb_izK88pg@mail.gmail.com>
 <ZyhxmxnxPcLk2ZcX@mev-dev.igk.intel.com>
 <ad5bf0e312d44737a18c076ab2990924@AcuMS.aculab.com>
 <840b32a0-9346-4576-97ba-17af12eb4db4@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <840b32a0-9346-4576-97ba-17af12eb4db4@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Cc: -nex.sw.ncis.nat.hpm.dev@intel.com (550 #5.1.0 Address rejected.)]

Am 04.11.24 um 10:09 schrieb Paul Menzel:
> Dear David, dear Michal,
> 
> 
> Am 04.11.24 um 09:51 schrieb David Laight:
>> From: Michal Swiatkowski
>>> Sent: 04 November 2024 07:03
>> ...
>>>> The type of the devlink parameters msix_vec_per_pf_{min,max} is
>>>> specified as u32, so you must use value.vu32 everywhere you work with
>>>> them, not vu16.
>>>>
>>>
>>> I will change it.
>>
>> You also need a pretty good reason to use u16 anywhere at all.
>> Just because the domain of the value is small doesn't mean the
>> best type isn't [unsigned] int.
>>
>> Any arithmetic (particularly on non x86) is likely to increase
>> the code size above any perceived data saving.
> 
> In 2012 Scott Duplichan wrote *Small Integers: Big Penalty* [1]. Of 
> course you always should measure yourself.
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://notabs.org/coding/smallIntsBigPenalty.htm

