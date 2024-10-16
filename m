Return-Path: <netdev+bounces-136034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC4C9A009B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 07:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D49BDB2418D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D448B16A94A;
	Wed, 16 Oct 2024 05:28:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FDF188013
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 05:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056506; cv=none; b=ocrLX4zB3ZVZQNax5GCOJaL9ZGV4iPyt0RYUaK1Pj9MAw/T3iPuMs58dVTJYyq3kDkvLWYbnwJN34UHNTi4s50RYK4zSyTZ5azPoa3Yz+fpEkvVPDXkRJVAsOYxSBflek+dSZaNq2p/kCfaFqS0/66xsQxDfSY/uBe6RvKeFU7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056506; c=relaxed/simple;
	bh=o1XhTxj3dSEFMKnpxv/1tMNeP8mQmYquEo9yEEL8Zpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwTlG8ePTKCq87wvOoKjkoAA8zruj8/bdhh9lTcEMDpCm7XNZaRU7AhrrC50q3yNk08ujhLnl5WMRHSWqka4450pdXOsD5zKiBZajgmZDtQIVGrYCmGGhTbO3C7qsWx3NE4IQ/X9K5K5BIPUM8XGN0ympEKenxVsIgqamONBl/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5ae84f.dynamic.kabel-deutschland.de [95.90.232.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5115E61E5FE05;
	Wed, 16 Oct 2024 07:28:05 +0200 (CEST)
Message-ID: <054b84a1-fd70-4abe-b1aa-18c0882c05f5@molgen.mpg.de>
Date: Wed, 16 Oct 2024 07:28:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] i40e: fix "Error
 I40E_AQ_RC_ENOSPC adding RX filters on VF" issue
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: Anthony L Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20241015070450.1572415-1-aleksandr.loktionov@intel.com>
 <011cfa1f-d7df-4d38-ba5d-7820176ebf8b@molgen.mpg.de>
 <SJ0PR11MB586684C1B9995B605D83CF71E5452@SJ0PR11MB5866.namprd11.prod.outlook.com>
 <4435dade-5c41-43a1-aeab-58e2d262545f@molgen.mpg.de>
 <SJ0PR11MB5866C7F03A6F794EEDC2295BE5452@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <SJ0PR11MB5866C7F03A6F794EEDC2295BE5452@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Aleksandr,


Am 15.10.24 um 13:05 schrieb Aleksandr Loktionov:

>> -----Original Message-----
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Tuesday, October 15, 2024 12:33 PM

[…]

>> Am 15.10.24 um 11:45 schrieb Loktionov, Aleksandr:
>>
>>>> -----Original Message-----
>>>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>>> Sent: Tuesday, October 15, 2024 10:24 AM
>>
>>>> Thank you for your patch. For the summary I’d make it more about the
>>>> action of the patch like “Add intermediate filter to …”.
>>>
>>> Sorry, I don't get your point. This patch fixes bug that can stop
>>> vfs to receive any traffic making them useless. The first and most
>>> visible effect of the bug is a lot of "Error I40E_AQ_RC_ENOSPC
>>> adding RX filters on VF XX,..." errors from F/W complaining to add
>>> MAC/VLAN filter. So I've mentioned it in the title to be easy found.
>>> I don't add any filter in the driver, we have to add one more
>>> intermediate state of the filter to avoid the race condition.
>>
>> In my opinion, having the log in the body is good enough for search
>> engines and the summary should be optimized for `git log --oneline`
>> consumption. I am sorry about the confusion with my example. Maybe:
>>
>> Add intermediate sync state to fix race condition
>
> I just wonder why do you insist on "ADD" which usually means
> implementing a new feature. When this patch FIXes the bug?

Some projects use this interpretation/structure, but to my knowledge not 
the Linux kernel.

> If I'd want to add a new feature I'd rather send my patch to net-next,
> isn't it?

*Add*, how I used it, does not imply a new feature addition.

> For me 'fix race condition by adding filter's intermediate sync
> state'
> Can you explain your strong argument for the Add?
I am fine with your suggestion, and do not oppose to start with *Fix*. 
Also, thank you for your elaborate answer, so I could understand the 
point of view you came from.
>>>> Am 15.10.24 um 09:04 schrieb Aleksandr Loktionov:
>>>>> Fix a race condition in the i40e driver that leads to MAC/VLAN filters
>>>>> becoming corrupted and leaking. Address the issue that occurs under
>>>>> heavy load when multiple threads are concurrently modifying MAC/VLAN
>>>>> filters by setting mac and port VLAN.
>>>>>
>>>>> 1. Thread T0 allocates a filter in i40e_add_filter() within
>>>>>            i40e_ndo_set_vf_port_vlan().
>>>>> 2. Thread T1 concurrently frees the filter in __i40e_del_filter() within
>>>>>            i40e_ndo_set_vf_mac().
>>>>> 3. Subsequently, i40e_service_task() calls i40e_sync_vsi_filters(), which
>>>>>            refers to the already freed filter memory, causing corruption.
>>>>>
>>>>> Reproduction steps:
>>>>> 1. Spawn multiple VFs.
>>>>> 2. Apply a concurrent heavy load by running parallel operations to change
>>>>>            MAC addresses on the VFs and change port VLANs on the host.
>>>>
>>>> It’d be great if you shared your commands.
>>
>>> Sorry, I'm pretty sure it's quite impossible to reproduce the issue
>>> with bash scripts /*I've tried really hard*/. Reproduction is
>>> related to user-space/kernel code which might be not open-sourced.
>>> So as I've explained in the commit title the race condition
>>> possibility that was introduced from the very beginning.
>>
>> Could you please ask to get clearance to publish it. My naive view
>> wonders, why legal(?) should oppose publication.
> 
> Simply the defect can come from development tools or from external
> customer. And being tract as a commercial secret, which even doesn't
> belong to Intel sometimes.
I know, that these are general problems. But in this specific case you 
should know the circumstances, and be able to document it in the commit 
message, why a test case cannot be published.


Kind regards,

Paul

