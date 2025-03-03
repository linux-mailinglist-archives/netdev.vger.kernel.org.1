Return-Path: <netdev+bounces-171322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2857DA4C899
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FDE3B25C5
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B0F27CCE8;
	Mon,  3 Mar 2025 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ag8yve5r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7927C167
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019558; cv=none; b=HelJekk0xvH75UA7ayY0IYyC6ZU/qVvdqyhWKxhMAT59m8HqGbMFXquSX9dgQzikpxzuwYnaS5mm+q0lmCjVcQukqqhMAIz/FXQokWaZUHdSB0Oe3azM+j24wF0CpTJ6tWLxNeHXJbFVwQ5sO9fgw4y7pIeSXRpIB2lX0dLpwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019558; c=relaxed/simple;
	bh=bWw2/6JZlD9vW2ZsnAAmWxo6GNqij5KLd6pwKV6TiVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBB/GSvSuEEcVLdUgmvLMaJat2eqpOze1oXoP2km1VjwSI56S0doRpqB8HulXZs4SxdHOjWqtv+Uhuy5V18oJh5TaT/KfzvpyzSRKhwm3GZVaCBHca/1P85JrHgld7hb/5ZpHKx1UrU/UWxIACVVYocb3NAnOKtrlypBnHeloRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ag8yve5r; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741019558; x=1772555558;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bWw2/6JZlD9vW2ZsnAAmWxo6GNqij5KLd6pwKV6TiVQ=;
  b=ag8yve5r1rB2ysAR1PsqdRyFfYt9BY+HmvKxBwKvCGSE0FiCAjtehQ9J
   BYSyTV+s3FBzBKA7e4FuebDYIIdepc7fisLQvm/PcL5i7bKJs3rMgtIhK
   DrpNeiU/v6djblKtm86w+0FSyQM8IXsHjOSpqAMxwTEJBAVI+8kOcfZqJ
   vaii7IrmXXHuGCgfGzMeGe3/j/kyv+1EV+FOOKUMtIgUBhOnyJCPgmoJF
   L1757wVc2bzRoARjtrz6GmVQv5vElmxHhXk4N1Fj2G4jbyTLSrFF/EJ4x
   YkO0AJY2fXoFeVcSfTr2E6dpohMYt6pcTwHQmBAhduxbytiGY6q7Ahvm4
   g==;
X-CSE-ConnectionGUID: 86llPCp5Q8S2OdgSNrpOQA==
X-CSE-MsgGUID: 3wwIInI/ThqdIYsdunXjag==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41815005"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41815005"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:32:37 -0800
X-CSE-ConnectionGUID: 92mCBtiZSJa9iZbrhP2Djw==
X-CSE-MsgGUID: Yur+Ikr8Rk24f7/GN7K9yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148981684"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.84.226]) ([10.245.84.226])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:32:35 -0800
Message-ID: <e3fa9d6b-abb7-4b35-8467-7fae4581a981@linux.intel.com>
Date: Mon, 3 Mar 2025 17:32:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-net v2 5/5] ice: fix using untrusted value of pkt_len in
 ice_vc_fdir_parse_raw()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
References: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250225090847.513849-8-martyna.szapar-mudlaw@linux.intel.com>
 <20250228171753.GL1615191@kernel.org>
 <68c841b7-fb5b-4c52-bd55-b98c80ad8667@intel.com>
Content-Language: en-US
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <68c841b7-fb5b-4c52-bd55-b98c80ad8667@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/3/2025 11:00 AM, Przemek Kitszel wrote:
> On 2/28/25 18:17, Simon Horman wrote:
>> On Tue, Feb 25, 2025 at 10:08:49AM +0100, Martyna Szapar-Mudlaw wrote:
>>> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>>>
>>> Fix using the untrusted value of proto->raw.pkt_len in function
>>> ice_vc_fdir_parse_raw() by verifying if it does not exceed the
>>> VIRTCHNL_MAX_SIZE_RAW_PACKET value.
>>>
>>> Fixes: 99f419df8a5c ("ice: enable FDIR filters from raw binary 
>>> patterns for VFs")
>>> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>>> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar- 
>>> mudlaw@linux.intel.com>
>>> ---
>>>   .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 25 +++++++++++++------
>>>   1 file changed, 17 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/ 
>>> drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>>> index 14e3f0f89c78..6250629ee8f9 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>>> @@ -835,18 +835,27 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
>>>       u8 *pkt_buf, *msk_buf __free(kfree);
>>>       struct ice_parser_result rslt;
>>>       struct ice_pf *pf = vf->pf;
>>> +    u16 pkt_len, udp_port = 0;
>>>       struct ice_parser *psr;
>>>       int status = -ENOMEM;
>>>       struct ice_hw *hw;
>>> -    u16 udp_port = 0;
>>> -    pkt_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
>>> -    msk_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
>>> +    if (!proto->raw.pkt_len)
>>> +        return -EINVAL;
>>
>> Hi Martyna,
>>
>> It seems to me that the use of __free() above will result in
>> kfree(msk_buf) being called here. But msk_buf is not initialised at this
>> point.
>>
>> My suggest would be to drop the use of __free().
>> But if not, I think that in order to be safe it would be best to do this
>> (completely untested;
>>
>>     u8 *pkt_buf, *msk_buf __free(kfree) = NULL;
> 
> Oh yeah!, thank you Simon for catching that.
> 
> I would say "naked __free()" was harmful here.
> 

Thank you for suggestions, will send fixed v3


