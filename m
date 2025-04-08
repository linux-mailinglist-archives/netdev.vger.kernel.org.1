Return-Path: <netdev+bounces-180026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB90CA7F29C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE3A177021
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36A5192B86;
	Tue,  8 Apr 2025 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NFCY8Y1d"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D76E4A21
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744078835; cv=none; b=ooXHPVwREZsvAMM7o/tQZJzzs7u3xlt4Ln2P9D4h8txT13HRhv2fNEub3hwPQ8OQbwE03hwe3s0eHzET9K388J3A19Zb+WzJ26N7RpLT8AZjK0wnRG6kESvb6OBGw3b7Ru8JYLOOip2TgFF/c4Qk7duyvaCa9ILaQWMY23htUYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744078835; c=relaxed/simple;
	bh=fcsXNAqVONFErcWct0p5f6TRoJic4GOHW8vfQwN5c3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSUnKrITTx+6m1hn0AAV2YkhDm1AxumfsHMwDACuMNrbzQjbZIzigIIOB6xxZr1W9YmbfjAtRznYm29KwFwP4EC+GTxb/lIJSin9MEw5SOT+uPjgAIBNYJ6gNOtjkYLZlzjbWdVKsZC21osz6Qn+SKP36trQa0cjpJEawR/WlW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NFCY8Y1d; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6c463f96-18e7-4ee9-ba74-524772e008b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744078831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTadr6hlfyyWPFYhpnPzSUF00n3EJeBKU1nvkMa6B0k=;
	b=NFCY8Y1dz+KkzOURdbfKAdoFb/kvpmtBEKKkSOhVv/lWdHckn8yhFGmrio62gou0llqR8F
	nNZD1lvurUHtiBwoPdFh/RlO6qSkOpkSk5gefPoSfRzaI+AeVRMMhHIT7oRWeoYo60qlDp
	8oNKKm8SHQ1AtqnSrzpKmESCeexcwSU=
Date: Tue, 8 Apr 2025 10:19:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-net v2] ice: Check VF VSI Pointer Value in
 ice_vc_add_fdir_fltr()
To: Simon Horman <horms@kernel.org>
Cc: przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250325020149.2041648-1-xuanqiang.luo@linux.dev>
 <20250407140242.GK395307@horms.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20250407140242.GK395307@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/4/7 22:02, Simon Horman 写道:
> On Tue, Mar 25, 2025 at 10:01:49AM +0800, Xuanqiang Luo wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> As mentioned in the commit baeb705fd6a7 ("ice: always check VF VSI
>> pointer values"), we need to perform a null pointer check on the return
>> value of ice_get_vf_vsi() before using it.
>>
>> v2: Add "iwl-net" to the subject and modify the name format.
>>
>> Fixes: 6ebbe97a4881 ("ice: Add a per-VF limit on number of FDIR filters")
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> index 14e3f0f89c78..53bad68e3f38 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> @@ -2092,6 +2092,12 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
>>   	dev = ice_pf_to_dev(pf);
>>   	vf_vsi = ice_get_vf_vsi(vf);
>>   
> nit, but not need to repost because of this: it's seems nicer
> not to have not to have a blank line here. And instead, if one is
> really wanted, put it above the ice_get_vf_vsi() line.
>
Thank you for the reminder. I will take this into consideration when
submitting other patches next time. Since vf_vsi and its judgment logic
are logically adjacent, it's better not to separate them with blank
lines.

>> +	if (!vf_vsi) {
>> +		dev_err(dev, "Can not get FDIR vf_vsi for VF %u\n", vf->vf_id);
>> +		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
>> +		goto err_exit;
>> +	}
>> +
>>   #define ICE_VF_MAX_FDIR_FILTERS	128
>>   	if (!ice_fdir_num_avail_fltr(&pf->hw, vf_vsi) ||
>>   	    vf->fdir.fdir_fltr_cnt_total >= ICE_VF_MAX_FDIR_FILTERS) {
>> -- 
>> 2.27.0
>>
>>

