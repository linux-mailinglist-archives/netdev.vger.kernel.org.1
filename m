Return-Path: <netdev+bounces-119689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1ED956987
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD8C1F223D7
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56D7166F0D;
	Mon, 19 Aug 2024 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="kvpFPjnz"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4996A15ADB1
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067688; cv=none; b=EIbrj5qenVp6BRSth80SOvRN8NI1OucGRggu3Cq6oNJWzzZc3Dd6lKZeVdKJGitglsZn0rU42bW79rA84NbTUw954COa8GPtRBZnVTzs/xnzlt4yQUGwkeXs3O8cjCH453gXUYrtFD4/5AsoF5DzkBZiXYhnGXBQCL7bSVapWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067688; c=relaxed/simple;
	bh=StiwBl7gcsKPM4QUqdzPmLaOQDatwYYOr4RXGOWzdJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j1j4XCSwOq9kFaYrP7RNf9LG3c6SvRu5jfCW0vT385zFprbnuRYZlS5FHCXh6IgwLx8XxkUtk3FYDGzhk4SZ935lVix7Mz2YxZxEAsz0gV3uSWF1Tzie63aSoa7XIQW1APTrOE+7mm266scLMs9tAti3/ysZdb6JBUgD0+atE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=kvpFPjnz; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724067686;
	bh=M3gESBvhy0PNBB/+wlGjnZP9di3TeOOVucipNeSD7H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=kvpFPjnzBoAxLz8VSNgZ8WtfdAMsgcSvB0r6OYe49PS9D60oLV4fzsQXyz1gQDxHC
	 zIikMIP1OzDNKQ11XoYMtszN0mKKYZYvdCKUtSXXfNEXGweQvgHGXIEpYdHUfcP1kW
	 9HXcVSeN4AqQZTFg7LKN6YOxojU68qfwbYOpHNbJ0sben1gjHEajIuOR5SkL12xarW
	 3NMp9OZ2fT2SiMMYgxO42t+PITCWrSBU2WYwm3f03iDtecwT8dlEdAHDhfyi+d2TOx
	 yHlm1ohFRofzGG+bVuO9Nwdx0fPc0GCroVh6g5sZlIe9np/9MwmYpYeeTNoBtO9jjp
	 n2h5OE4ZYDcyA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 6F2BD20103D2;
	Mon, 19 Aug 2024 11:41:19 +0000 (UTC)
Message-ID: <25131af2-17f2-4e3d-a11f-247cb1c4fff4@icloud.com>
Date: Mon, 19 Aug 2024 19:41:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] firewire: core: Prevent device_find_child() from
 modifying caller's match data
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240819085847.GA252819@workstation.local>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20240819085847.GA252819@workstation.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PKojMI1yXK7Etn5C1lLExPn4o5PTW2nf
X-Proofpoint-ORIG-GUID: PKojMI1yXK7Etn5C1lLExPn4o5PTW2nf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_10,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2408190078

On 2024/8/19 16:58, Takashi Sakamoto wrote:
> 
> Hi,
> 
> On 2024/8/18 22:34, Zijun Hu wrote:
>> On 2024/8/17 17:57, Takashi Sakamoto wrote:
>>> ======== 8< --------
>>>
>>> From ceaa8a986ae07865eb3fec810de330e96b6d56e2 Mon Sep 17 00:00:00 2001
>>> From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>>> Date: Sat, 17 Aug 2024 17:52:53 +0900
>>> Subject: [PATCH] firewire: core: update fw_device outside of
>>>  device_find_child()
>>>
>>> When detecting updates of bus topology, the data of fw_device is newly
>>> allocated and caches the content of configuration ROM from the
>>> corresponding node. Then, the tree of device is sought to find the
>>> previous data of fw_device corresponding to the node, since in IEEE 1394
>>> specification numeric node identifier could be changed dynamically every
>>> generation of bus topology. If it is found, the previous data is updated
>>> and reused, then the newly allocated data is going to be released.
>>>
>>> The above procedure is done in the call of device_find_child(), however it
>>> is a bit abusing against the intention of the helper function, since the
>>> call would not only find but also update.
>>>
>>> This commit splits the update outside of the call.
>>> ---
>>>  drivers/firewire/core-device.c | 109 ++++++++++++++++-----------------
>>>  1 file changed, 54 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
>>> index bc4c9e5a..62e8d839 100644
>>> --- a/drivers/firewire/core-device.c
>>> +++ b/drivers/firewire/core-device.c
>>> ...
>>> @@ -1038,6 +988,17 @@ int fw_device_set_broadcast_channel(struct device *dev, void *gen)
>>>  	return 0;
>>>  }
>>>  
>>> +static int compare_configuration_rom(struct device *dev, void *data)
>>> +{
>>> +	const struct fw_device *old = fw_device(dev);
>>> +	const u32 *config_rom = data;
>>> +
>>> +	if (!is_fw_device(dev))
>>> +		return 0;
>>> +
>>> +	return !!memcmp(old->config_rom, config_rom, 6 * 4);
>>
>> !memcmp(old->config_rom, config_rom, 6 * 4) ?
> 
> Indeed.
> 
>> is this extra condition old->state == FW_DEVICE_GONE required ?
>>
>> namely, is it okay for  below return ?
>> return  !memcmp(old->config_rom, config_rom, 6 * 4) && old->state ==
>> FW_DEVICE_GONE
> 
> If so, atomic_read() should be used, however I avoid it since the access
> to state member happens twice in in the path to reuse the instance.
> 

it sounds good to not append the extra condition.

>>> +}
>>> +
>>>  static void fw_device_init(struct work_struct *work)
>>>  {
>>>  	struct fw_device *device =
>>> @@ -1071,13 +1032,51 @@ static void fw_device_init(struct work_struct *work)
>>>  		return;
>>>  	}
>>>  
>>> -	revived_dev = device_find_child(card->device,
>>> -					device, lookup_existing_device);
>>> +	// If a device was pending for deletion because its node went away but its bus info block
>>> +	// and root directory header matches that of a newly discovered device, revive the
>>> +	// existing fw_device. The newly allocated fw_device becomes obsolete instead.
>>> +	//
>>> +	// serialize config_rom access.
>>> +	scoped_guard(rwsem_read, &fw_device_rwsem) {
>>> +		// TODO: The cast to 'void *' could be removed if Zijun Hu's work goes well.
>>
>> may remove this TODO line since i will simply remove the cast with the
>> other patch series as shown below:
>> https://lore.kernel.org/all/20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com/
> 
> Of course, I won't apply this patch as is. It is just a mark to hold
> your attention.
> 
>>> +		revived_dev = device_find_child(card->device, (void *)device->config_rom,
>>> +						compare_configuration_rom);
>>> +	}
>>>  	if (revived_dev) {
>>> -		put_device(revived_dev);
>>> -		fw_device_release(&device->device);
>>> +		struct fw_device *found = fw_device(revived_dev);
>>>  
>>> -		return;
>>> +		// serialize node access
>>> +		guard(spinlock_irq)(&card->lock);
>>> +
>>> +		if (atomic_cmpxchg(&found->state,
>>> +				   FW_DEVICE_GONE,
>>> +				   FW_DEVICE_RUNNING) == FW_DEVICE_GONE) {
>>> +			struct fw_node *current_node = device->node;
>>> +			struct fw_node *obsolete_node = found->node;
>>> +
>>> +			device->node = obsolete_node;
>>> +			device->node->data = device;
>>> +			found->node = current_node;
>>> +			found->node->data = found;
>>> +
>>> +			found->max_speed = device->max_speed;
>>> +			found->node_id = current_node->node_id;
>>> +			smp_wmb();  /* update node_id before generation */
>>> +			found->generation = card->generation;
>>> +			found->config_rom_retries = 0;
>>> +			fw_notice(card, "rediscovered device %s\n", dev_name(revived_dev));
>>> +
>>> +			found->workfn = fw_device_update;
>>> +			fw_schedule_device_work(found, 0);
>>> +
>>> +			if (current_node == card->root_node)
>>> +				fw_schedule_bm_work(card, 0);
>>> +
>>> +			put_device(revived_dev);
>>> +			fw_device_release(&device->device);
>>> +
>>> +			return;
>>> +		}
>>
>> is it okay to put_device() here as well ?
>> put_device(revived_dev);
> 
> Exactly. The call of put_device() should be done when the call of
> device_find_child() returns non-NULL value.
> 
> Additionally, I realize that the call of fw_device_release() under
> acquiring card->lock causes dead lock.
> 
>>>  	}
>>>  
>>>  	device_initialize(&device->device);
> 
> Anyway, I'll post take 2 and work for its evaluation.
> 
great
> 
> Thanks
> 
> Takashi Sakamoto


