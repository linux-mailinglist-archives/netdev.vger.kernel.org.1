Return-Path: <netdev+bounces-180024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51052A7F297
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D4A177F5F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B8111CAF;
	Tue,  8 Apr 2025 02:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E1xlKyIc"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1444A21
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744078572; cv=none; b=YQRfSTMPY6/g5xMNYLxWnU4gDbVt4sbIWkdeBE2z6a94BMCM8TLnj+8b6WxDdz8onvCDlcEj8R5zldBtOYKFnj7EtB3L4eXbOabjWLekrZIcm+NKAXPSvSsqfgv7LOGOu2gYeNqljh1BK4v5PnWAxXBxWfbfmgaJHjHbzNpE+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744078572; c=relaxed/simple;
	bh=zZEN8oL1l+gv/80LdORRYJSaXl8V0y6n/MmArK+Jd3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqNlgRs9uxWuo888Wx9MKie3pqrVq//qDz1V7k+ZscrPc+rI254jBU+hMw3Dzd8/wDOPubF6VzNWFc85fiLgm/UsC1Y+eEiBKDqyHfBmvfq4xZMXiqKHKZIney+BL//nihZ8itRO7f6kccFFStTbFIO7s6AGy1BwToajQI8E0Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E1xlKyIc; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b209be10-2653-4a9e-bb9d-683fc9c0cf50@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744078566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPjoLTdoallsCTo09suEBRnN2BCJJBA5YHjIc4x9f54=;
	b=E1xlKyIcR69jh405rRGhisEKnGfRwzmSoeTe/aS8yt3OOGp3JLUINTh0nhqxVEtDDJyyFz
	Zs/dOfYr7S4QTnsgPHhq04WcOjmwtcvodR50TtN9Hq1mUnsoqSxXA90JXEcusWyYWotMZ7
	9F6ZWcEFi4pnWpG5YWS9Z9+pLszonbQ=
Date: Tue, 8 Apr 2025 10:15:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-net v2] ice: Check VF VSI Pointer Value in
 ice_vc_add_fdir_fltr()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250325020149.2041648-1-xuanqiang.luo@linux.dev>
 <4a960ad6-6118-4db8-9511-a1e3bb5b66f3@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <4a960ad6-6118-4db8-9511-a1e3bb5b66f3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/3/27 18:22, Przemek Kitszel 写道:
> On 3/25/25 03:01, Xuanqiang Luo wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> As mentioned in the commit baeb705fd6a7 ("ice: always check VF VSI
>> pointer values"), we need to perform a null pointer check on the return
>> value of ice_get_vf_vsi() before using it.
>>
>> v2: Add "iwl-net" to the subject and modify the name format.
>>
>> Fixes: 6ebbe97a4881 ("ice: Add a per-VF limit on number of FDIR 
>> filters")
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>
> (technically the changelog (v2:...) should be placed here, with 
> additional "---" line afterwards; no need to resubmit just for that)
>
Thank you for your guidance. I'll keep this in mind. :) BRs! Xuanqiang

>> drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c 
>> b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> index 14e3f0f89c78..53bad68e3f38 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> @@ -2092,6 +2092,12 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 
>> *msg)
>>       dev = ice_pf_to_dev(pf);
>>       vf_vsi = ice_get_vf_vsi(vf);
>>   +    if (!vf_vsi) {
>> +        dev_err(dev, "Can not get FDIR vf_vsi for VF %u\n", vf->vf_id);
>> +        v_ret = VIRTCHNL_STATUS_ERR_PARAM;
>> +        goto err_exit;
>> +    }
>> +
>>   #define ICE_VF_MAX_FDIR_FILTERS    128
>>       if (!ice_fdir_num_avail_fltr(&pf->hw, vf_vsi) ||
>>           vf->fdir.fdir_fltr_cnt_total >= ICE_VF_MAX_FDIR_FILTERS) {

