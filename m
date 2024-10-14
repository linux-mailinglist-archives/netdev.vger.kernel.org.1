Return-Path: <netdev+bounces-135286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CFB99D6AC
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA5B28583C
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 18:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34451C6895;
	Mon, 14 Oct 2024 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="mmMTD3q6"
X-Original-To: netdev@vger.kernel.org
Received: from mx07lb.world4you.com (mx07lb.world4you.com [81.19.149.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D937231C95
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728931321; cv=none; b=nhFTWWamVFnAQwjqnvEln5e/30+bJyaXe8ij+SnPLNk/WSRMQENbRwUsnDTXIjrmEWzzOMdKbIuWcm6KTY2EWNPdgsRSx4sdLxl6oc9agbgJEx7FZnXs4iuBDG1DHPldCryD7Hbvw2U8p+ZC6w3TmiveEEbaNQ8k1Gkiy6i5Hbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728931321; c=relaxed/simple;
	bh=se43G3DkvAHHqQYhyavSttgY1OhE1U5EspsV0myGisk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQm2o0EmcRCmURWV7cHFb/FU5pCbV7GRXwYmMgtqGuphpgMwPNjZHA/q/yjZ3d0p6kbPF3gaU+Nwhq/VInd9XOI1djDTevNik5Cy58FA7qoTuGb/vReK+lS0FSmClzecoE+AZ4FMgoObcz8eduOTwOftzCtL4FTnJ9FtevyBNuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=mmMTD3q6; arc=none smtp.client-ip=81.19.149.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K1sCuendBhY4oo5tpTh3PC3aFGRXjnm5e2BE6K4Hj7Q=; b=mmMTD3q6q49oWanANcigC67B0g
	Yeuh2m0eK3wGs1dhJ3Yt/GYRivjLy4LA2wsQbyOyMmzJ63LnsiHbfKgxKq2I8a981fTWlhopMmEWj
	3pt5UGGw+l4QfknrYACoEJDkPrTwwrSVSjitIfjuUEaXi9DnB/py4YFwjHa2rGN+2GsI=;
Received: from [88.117.56.173] (helo=[10.0.0.160])
	by mx07lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1t0PLY-0000000035S-3mN2;
	Mon, 14 Oct 2024 19:59:09 +0200
Message-ID: <f5515472-21d0-4a56-a6a1-8431c1d60f7e@engleder-embedded.com>
Date: Mon, 14 Oct 2024 19:59:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] e1000e: Fix real-time violations on link up
To: Andrew Lunn <andrew@lunn.ch>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Gerhard Engleder <eg@keba.com>
References: <20241011195412.51804-1-gerhard@engleder-embedded.com>
 <f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 12.10.24 20:42, Andrew Lunn wrote:
> On Fri, Oct 11, 2024 at 09:54:12PM +0200, Gerhard Engleder wrote:
>> From: Gerhard Engleder <eg@keba.com>
>>
>> Link down and up triggers update of MTA table. This update executes many
>> PCIe writes and a final flush. Thus, PCIe will be blocked until all writes
>> are flushed. As a result, DMA transfers of other targets suffer from delay
>> in the range of 50us. The result are timing violations on real-time
>> systems during link down and up of e1000e.
>>
>> Execute a flush after every single write. This prevents overloading the
>> interconnect with posted writes. As this also increases the time spent for
>> MTA table update considerable this change is limited to PREEMPT_RT.
>>
>> Signed-off-by: Gerhard Engleder <eg@keba.com>
>> ---
>>   drivers/net/ethernet/intel/e1000e/mac.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
>> index d7df2a0ed629..f4693d355886 100644
>> --- a/drivers/net/ethernet/intel/e1000e/mac.c
>> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
>> @@ -331,9 +331,15 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
>>   	}
>>   
>>   	/* replace the entire MTA table */
>> -	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
>> +	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
>>   		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
>> +#ifdef CONFIG_PREEMPT_RT
>> +		e1e_flush();
>> +#endif
>> +	}
>> +#ifndef CONFIG_PREEMPT_RT
>>   	e1e_flush();
>> +#endif
> 
> #ifdef FOO is generally not liked because it reduces the effectiveness
> of build testing.
> 
> Two suggestions:
> 
> 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> 		e1e_flush();

I will do that.

> This will then end up as and if (0) or if (1), with the statement
> following it always being compiled, and then optimised out if not
> needed.
> 
> Alternatively, consider something like:
> 
> 	if (i % 8)
> 		e1e_flush()
> 
> if there is a reasonable compromise between RT and none RT
> performance. Given that RT is now fully merged, we might see some
> distros enable it, so a compromise would probably be better.

Yes, read/flush after every posted write is likely too much. I will
do some testing how often flush is required.

Thank you for your feedback Andrew!

Any comments from Intel driver maintainers?

Gerhard

