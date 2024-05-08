Return-Path: <netdev+bounces-94536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FE18BFCB0
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7F1285F6E
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF85D82876;
	Wed,  8 May 2024 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="LxTz7Km0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CDF823D1
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169207; cv=none; b=mTn+VI6BJBbilo30sF1FqE+6nXP49EiktE9+al8knYtMgoajSjCvYdfWm67w4IQ2CLdNwoQG4fA1niW1jWv9DibntIq6icJIVHPcEuuXXrmV0XB809E/O97NNT2uHsYtcml8TCl5lzjLImf7P3I93Jtfqsk6gquQY4pZgVlYvL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169207; c=relaxed/simple;
	bh=3vlV/UT8Lz7AZ0zWr7NTiNZWlDGBoZmP3MuofEiQPCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GH8QdeVYgEIDjdr05/56CGEdBLPbEo1Ve+qhzvKavJth2P4keGvWNCgrtqZHu7xM/OeR1bFTiwF4NMjKEhlDRjMZyScAi09HpIh+/5wUKZhH1fbMOSYBMntS0pBfasAfqFR5H8E/ZMDCjmX4+jLhc7YSiW0jE74BB2nvewHa0PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=LxTz7Km0; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.0.106] (unknown [114.249.184.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 650764211B;
	Wed,  8 May 2024 11:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715169195;
	bh=kHXiE4/6/Qns30RL6w55nzWStI9TW1oLIKxwXtctZhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=LxTz7Km0+6VK7u8Fgn0fh009jO7b0dUH6hNmG+kXRF2AQ5aNFzaTubJQvNoCjnFLT
	 rZJuWOQjuGoUkfko7VB80tBERGi9Lo2pCB0wiZY7gaNGeAvVOKMyKo1L5uHhF2kg3j
	 Qh+mBL5phJ7eZEX/C/eZ9kx0nko7sOPqNBrnLPd2PNseW/1UtC4Zas/ZNLj5vWmePC
	 INCG6+48g4VDiffenD34VjGZZV0+nZ2VvqELdBEwiZ3vaxjHsJMvBqafBUvI8U1f+T
	 S/uWA8ILM1umkvTOMWummxSqEzh22ZACSEWXswvUOlAoeCTqqtABKLOn/msQmtG2nW
	 1EEqoh5ljPVRw==
Message-ID: <71001a25-34f1-48ea-b35b-049ee35335c1@canonical.com>
Date: Wed, 8 May 2024 19:53:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] e1000e: move force SMBUS near the end of enable_ulp
 function
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, sasha.neftin@intel.com, dima.ruinskiy@intel.com,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Naama Meir <naamax.meir@linux.intel.com>
References: <20240506172217.948756-1-anthony.l.nguyen@intel.com>
 <20240507192112.3c3ee4f2@kernel.org>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20240507192112.3c3ee4f2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/8/24 10:21, Jakub Kicinski wrote:
> On Mon,  6 May 2024 10:22:16 -0700 Tony Nguyen wrote:
>> The commit 861e8086029e ("e1000e: move force SMBUS from enable ulp
>> function to avoid PHY loss issue") introduces a regression on
>> CH_MTP_I219_LM18 (PCIID: 0x8086550A). Without this commit, the
> Referring to the quoted commit as "this commit" is pretty confusing.
>
Will change it in the v2.
>> ethernet works well after suspend and resume, but after applying the
>> commit, the ethernet couldn't work anymore after the resume and the
>> dmesg shows that the NIC Link changes to 10Mbps (1000Mbps originally):
>> [   43.305084] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 10 Mbps Full Duplex, Flow Control: Rx/Tx
>>   release:
>> +	/* Switching PHY interface always returns MDI error
>> +	 * so disable retry mechanism to avoid wasting time
>> +	 */
>> +	e1000e_disable_phy_retry(hw);
>> +
>> +	/* Force SMBus mode in PHY */
>> +	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
>> +	if (ret_val)
>> +		goto release;
> Looks like an infinite loop waiting to happen.

Correct, will fix it in the v2.

Thanks.


