Return-Path: <netdev+bounces-135582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF59899E41C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AFB8B22E78
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265FD1E412E;
	Tue, 15 Oct 2024 10:33:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1611E491B
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988383; cv=none; b=mnphdfUE2jTjfUbSJNJgXfi5H8T3Hsy4ardZ2pQQHutf+2ndBWM9XvIvO3lfnEweOPrXPUxb0N4YZ9kpysrMdtY1SBKxEfd0zSzMXiZEaNwBptPJbLhDpyJeWAZU10b1Ox9tWxgbmQln+i1DqQjkX7ELGVIYfFGMviMh1pgOr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988383; c=relaxed/simple;
	bh=+hR3mhfvX9mo9D0wW+IwI+unNU6NDIuqnDvjbSjRbVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnd65i5RVid0x9Ji3xToNIjBGlT66ZtGN6zVY194FxKh5GhL+pLqPD383GIY/fKZO6Df9Dt9HZlnsDBAYDk/KB9K1+dK2JwA6U4Dw5Nh2EqgdVV3cgfIRHM0LILkixS5rtoiVRz2J0dShrM5mtdJAQbZv4MtYqNN0nmTPwcYasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 88A1361E5FE05;
	Tue, 15 Oct 2024 12:32:38 +0200 (CEST)
Message-ID: <4435dade-5c41-43a1-aeab-58e2d262545f@molgen.mpg.de>
Date: Tue, 15 Oct 2024 12:32:38 +0200
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
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Anthony L Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org
References: <20241015070450.1572415-1-aleksandr.loktionov@intel.com>
 <011cfa1f-d7df-4d38-ba5d-7820176ebf8b@molgen.mpg.de>
 <SJ0PR11MB586684C1B9995B605D83CF71E5452@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <SJ0PR11MB586684C1B9995B605D83CF71E5452@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Aleksandr,


Thank you for your reply. Just a note at the beginning, that your mailer 
seems to wrap lines without preserving the right citation level. It’d be 
great if you used a mailer following standards. (I know, it’s hard in a 
corporate environment, but other Intel developers seem to have found 
solutions for this.)


Am 15.10.24 um 11:45 schrieb Loktionov, Aleksandr:

>> -----Original Message-----
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Tuesday, October 15, 2024 10:24 AM

>> Thank you for your patch. For the summary I’d make it more about the
>> action of the patch like “Add intermediate filter to …”.
> 
> Sorry, I don't get your point. This patch fixes bug that can stop
> vfs to receive any traffic making them useless. The first and most
> visible effect of the bug is a lot of "Error I40E_AQ_RC_ENOSPC
> adding RX filters on VF XX,..." errors from F/W complaining to add
> MAC/VLAN filter. So I've mentioned it in the title to be easy found. 
> I don't add any filter in the driver, we have to add one more
> intermediate state of the filter to avoid the race condition.

In my opinion, having the log in the body is good enough for search 
engines and the summary should be optimized for `git log --oneline` 
consumption. I am sorry about the confusion with my example. Maybe:

Add intermediate sync state to fix race condition

>> Am 15.10.24 um 09:04 schrieb Aleksandr Loktionov:
>>> Fix a race condition in the i40e driver that leads to MAC/VLAN filters
>>> becoming corrupted and leaking. Address the issue that occurs under
>>> heavy load when multiple threads are concurrently modifying MAC/VLAN
>>> filters by setting mac and port VLAN.
>>>
>>> 1. Thread T0 allocates a filter in i40e_add_filter() within
>>>           i40e_ndo_set_vf_port_vlan().
>>> 2. Thread T1 concurrently frees the filter in __i40e_del_filter() within
>>>           i40e_ndo_set_vf_mac().
>>> 3. Subsequently, i40e_service_task() calls i40e_sync_vsi_filters(), which
>>>           refers to the already freed filter memory, causing corruption.
>>>
>>> Reproduction steps:
>>> 1. Spawn multiple VFs.
>>> 2. Apply a concurrent heavy load by running parallel operations to change
>>>           MAC addresses on the VFs and change port VLANs on the host.
>>
>> It’d be great if you shared your commands.

> Sorry, I'm pretty sure it's quite impossible to reproduce the issue
> with bash scripts /*I've tried really hard*/. Reproduction is
> related to user-space/kernel code which might be not open-sourced.
> So as I've explained in the commit title the race condition
> possibility that was introduced from the very beginning.

Could you please ask to get clearance to publish it. My naive view 
wonders, why legal(?) should oppose publication.

>>> 3. Observe errors in dmesg:
>>> "Error I40E_AQ_RC_ENOSPC adding RX filters on VF XX,
>>>    please set promiscuous on manually for VF XX".
>>
>> I’d indent it by eight spaces and put it in one line.
> Ok, I'll fix it in v2
> 
>>> The fix involves implementing a new intermediate filter state,
>>> I40E_FILTER_NEW_SYNC, for the time when a filter is on a tmp_add_list.
>>> These filters cannot be deleted from the hash list directly but
>>> must be removed using the full process.
>>
>> Please excuse my ignorance. Where is that done in the diff? For me it
>> looks like you only replace `I40E_FILTER_NEW` by `I40E_FILTER_NEW_SYNC`
>> in certain places, but no new condition for this case.
>
> Here are below the code which adds new I40E_FILTER_NEW_SYNC enum. 
> And additional conditions for this I40E_FILTER_NEW_SYNC state. All
> other places in the driver just tract I40E_FILTER_NEW_SYNC as not
> just I40E_FILTER_NEW by default.
Thank you. For me it’s not so obvious from the diff, and indeed, it’s 
done in `i40e_sync_vsi_filters()`. Thank you again.

>>> Fixes: 278e7d0b9d68 ("i40e: store MAC/VLAN filters in a hash with the MAC Address as key")
>>> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>> ---
>>>    drivers/net/ethernet/intel/i40e/i40e.h         |  2 ++
>>>    drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  2 ++
>>>    drivers/net/ethernet/intel/i40e/i40e_main.c    | 12 ++++++++++--
>>>    3 files changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
>> b/drivers/net/ethernet/intel/i40e/i40e.h
>>> index 2089a0e..a1842dd 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e.h
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
>>> @@ -755,6 +755,8 @@ enum i40e_filter_state {
>>>    	I40E_FILTER_ACTIVE,		/* Added to switch by FW */
>>>    	I40E_FILTER_FAILED,		/* Rejected by FW */
>>>    	I40E_FILTER_REMOVE,		/* To be removed */
>>> +	/* RESERVED */
>>
>> Why the reserved comment? Please elaborate in the commit message.
> 
> This is for not breaking compatibility with different driver
> versions. Between OOT, net-next and plain old net. Isn't it obvious
> from the comment, it's "RESERVERD"?

Apparently not, otherwise I wouldn’t ask. ;-)

> Can you provide me example commit message what I should follow?

There are people reading the code not familiar with the ecosystem, that 
there is an out of tree driver fore example. So the code or the commit 
message should have an explanation why `I40E_FILTER_NEW_SYNC = 6` and 
what the reserved is used for.

>>> +	I40E_FILTER_NEW_SYNC = 6,	/* New, not sent, in sync task */

Also mention the hash list in the comment?

>>>    /* There is no 'removed' state; the filter struct is freed */
>>>    };
>>>    struct i40e_mac_filter {
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
>>> index abf624d..1c439b1 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
>>> @@ -89,6 +89,8 @@ static char *i40e_filter_state_string[] = {
>>>    	"ACTIVE",
>>>    	"FAILED",
>>>    	"REMOVE",
>>> +	"<RESERVED>",
>>> +	"NEW_SYNC",
>>>    };
>>>
>>>    /**
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>>> index 25295ae..55fb362 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>>> @@ -1255,6 +1255,7 @@ int i40e_count_filters(struct i40e_vsi *vsi)
>>>
>>>    	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
>>>    		if (f->state == I40E_FILTER_NEW ||
>>> +		    f->state == I40E_FILTER_NEW_SYNC ||
>>>    		    f->state == I40E_FILTER_ACTIVE)
>>>    			++cnt;
>>>    	}
>>> @@ -1441,6 +1442,8 @@ static int i40e_correct_mac_vlan_filters(struct i40e_vsi *vsi,
>>>
>>>    			new->f = add_head;
>>>    			new->state = add_head->state;
>>> +			if (add_head->state == I40E_FILTER_NEW)
>>> +				add_head->state = I40E_FILTER_NEW_SYNC;
>>>
>>>    			/* Add the new filter to the tmp list */
>>>    			hlist_add_head(&new->hlist, tmp_add_list);
>>> @@ -1550,6 +1553,8 @@ static int i40e_correct_vf_mac_vlan_filters(struct i40e_vsi *vsi,
>>>    				return -ENOMEM;
>>>    			new_mac->f = add_head;
>>>    			new_mac->state = add_head->state;
>>> +			if (add_head->state == I40E_FILTER_NEW)
>>> +				add_head->state = I40E_FILTER_NEW_SYNC;
>>>
>>>    			/* Add the new filter to the tmp list */
>>>    			hlist_add_head(&new_mac->hlist, tmp_add_list);
>>> @@ -2437,7 +2442,8 @@ static int
>>>    i40e_aqc_broadcast_filter(struct i40e_vsi *vsi, const char *vsi_name,
>>>    			  struct i40e_mac_filter *f)
>>>    {
>>> -	bool enable = f->state == I40E_FILTER_NEW;
>>> +	bool enable = f->state == I40E_FILTER_NEW ||
>>> +		      f->state == I40E_FILTER_NEW_SYNC;
>>>    	struct i40e_hw *hw = &vsi->back->hw;
>>>    	int aq_ret;
>>>
>>> @@ -2611,6 +2617,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
>>>
>>>    				/* Add it to the hash list */
>>>    				hlist_add_head(&new->hlist, &tmp_add_list);
>>> +				f->state = I40E_FILTER_NEW_SYNC;
>>>    			}
>>>
>>>    			/* Count the number of active (current and new) VLAN
>>> @@ -2762,7 +2769,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
>>>    		spin_lock_bh(&vsi->mac_filter_hash_lock);
>>>    		hlist_for_each_entry_safe(new, h, &tmp_add_list, hlist) {
>>>    			/* Only update the state if we're still NEW */
>>> -			if (new->f->state == I40E_FILTER_NEW)
>>> +			if (new->f->state == I40E_FILTER_NEW ||
>>> +			    new->f->state == I40E_FILTER_NEW_SYNC)
>>>    				new->f->state = new->state;
>>>    			hlist_del(&new->hlist);
>>>    			netdev_hw_addr_refcnt(new->f, vsi->netdev, -1);
Thank you again for your work and explanations.


Kind regards,

Paul

