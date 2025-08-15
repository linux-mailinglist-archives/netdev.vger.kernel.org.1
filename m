Return-Path: <netdev+bounces-213996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB93B27A48
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 09:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310F67B6E62
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 07:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F23C2512C8;
	Fri, 15 Aug 2025 07:42:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6757F2253E9
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243732; cv=none; b=Aph1jZFfSM80CS0RvHB2kwf3TDq+GoFDOoyMSnjuFZOI/+C25GYm/O8OQX6mvkYzxqqSy0b7y750ec1rml9RwYVzEyQR48vzdVRdyvpwKoxytKiEP0ILi5sX/oij5Y6Vp8ib3sIMUCsZSoN6h8q5AckGYHhfD6HQEMlJmsWuzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243732; c=relaxed/simple;
	bh=ahGdGzcaYmhAtZHU/ftSieKH0YeDjqbbw7mMoaMcg10=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=I2ch0Etbli/AzXqANoF+kya4hyNVPHRH5rV2sGHhyE3G/uYVe4Ps++QaNLO1TYBhGCaWynpxtVYy95Z6F0BWsHbAGsDj0tLRLwrhnW5VBg0xS6yfS+ynQNBOSaBpwSuyyUn0WEMUzqfbV+r3uxABZWCmjYyAVQIqSzIuvpTEemo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.1.9] (dynamic-077-183-003-144.77.183.pool.telefonica.de [77.183.3.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E383C61E647AC;
	Fri, 15 Aug 2025 09:41:29 +0200 (CEST)
Message-ID: <01054bc5-74b6-4472-b7b6-78febaaf575f@molgen.mpg.de>
Date: Fri, 15 Aug 2025 09:41:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-net] igb: fix link test skipping
 when interface is admin down
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Kohei Enju <enjuk@amazon.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexander Duyck <alexanderduyck@fb.com>, kohei.enju@gmail.com
References: <20250815062645.93732-2-enjuk@amazon.com>
 <9ee14d54-b680-4b1a-82c2-56c0c1b26fa1@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <9ee14d54-b680-4b1a-82c2-56c0c1b26fa1@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Correct Alexander’s email address]

Am 15.08.25 um 09:38 schrieb Paul Menzel:
> Dear Kohei,
> 
> 
> Thank you very much for your patch.
> 
> Am 15.08.25 um 08:26 schrieb Kohei Enju:
>> The igb driver incorrectly skips the link test when the network
>> interface is admin down (if_running == false), causing the test to
>> always report PASS regardless of the actual physical link state.
>>
>> This behavior is inconsistent with other drivers (e.g. i40e, ice, ixgbe,
>> etc.) which correctly test the physical link state regardless of admin
>> state.
> 
> I’d collapse the above two sentences into one paragraph and add an empty 
> line here to visually separate the paragraph below.
> 
>> Remove the if_running check to ensure link test always reflects the
>> physical link state.
> 
> Please add how to verify your change, that means the command to run.
> 
>> Fixes: 8d420a1b3ea6 ("igb: correct link test not being run when link is down")
>> Signed-off-by: Kohei Enju <enjuk@amazon.com>
>> ---
>>   drivers/net/ethernet/intel/igb/igb_ethtool.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/ 
>> net/ethernet/intel/igb/igb_ethtool.c
>> index ca6ccbc13954..6412c84e2d17 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
>> @@ -2081,11 +2081,8 @@ static void igb_diag_test(struct net_device 
>> *netdev,
>>       } else {
>>           dev_info(&adapter->pdev->dev, "online testing starting\n");
>> -        /* PHY is powered down when interface is down */
>> -        if (if_running && igb_link_test(adapter, &data[TEST_LINK]))
>> +        if (igb_link_test(adapter, &data[TEST_LINK]))
>>               eth_test->flags |= ETH_TEST_FL_FAILED;
>> -        else
>> -            data[TEST_LINK] = 0;
>>           /* Online tests aren't run; pass by default */
>>           data[TEST_REG] = 0;
> 
> Regardless of my style comments above:
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul

