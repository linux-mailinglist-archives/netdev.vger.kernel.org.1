Return-Path: <netdev+bounces-119473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 335C2955CF6
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 16:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B168A1F21746
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997B0126F1E;
	Sun, 18 Aug 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ST2oh08o"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3E1FDA
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723991083; cv=none; b=hmmszP54Q5GGeRx9zafPPszFj1yFIM0nNrIxAf6IakJXWFhDr0s4VA0PfPHPMrXDnvAydj7E7cZlBFbdpc02vUXeoZLYVpUi/54cCZ356aH7pwIJnGbcrCHyYzoofhIOsURULLbrX2IFAoovNF1Nxs3VksVDRtxw4oUHXa/dOU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723991083; c=relaxed/simple;
	bh=z+tfOpQbN5fJ3NhByqRml2Dj0aHW5tbD/YrQgELNBLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BUmurlm6r4LUdhpFoBB1CcTE1Z6AK/Vj2eI2OwGrXWrhkHjHjD1FtjHN4qhSlURO3FOQICkPEmv6IqUqnfmqls5d35Lcn2QOz0ck2QRGFw3x2C4LWqPu7Sl6dRi8gE2KarQYF54BhOZUB1WU80LZTeWYhMTRKwpQwwoIFldLnn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ST2oh08o; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723991081;
	bh=dVKb0+xiVWMJj1VKLV7FqP+s7uyL5WIaFvx+KYYzJUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=ST2oh08ofn4CjXGcQ5aTFulOYQERimyUK7LuXS8wbtT8HBsOpVuzGCvxBEqd+Qnj+
	 /ZV/1oHnVpAhndhvqx36190mrlnw+duOiW5jKqRBY07hjvFapQ5Z27Govj1Ze1djUw
	 C7rBZgGTryGVHvF6x6XyXupdOurN+2fpds/UfqCbiWAx2iFLv07oU3e4tvH0FTCTFD
	 VCDWQmZv8pw5EHqGBiBFEckp2QyEYF7zjhcOybn6mKSDdDeRaB2Ux2DJyK4madj0q/
	 izLYivmlCSCbFFLgrdt7K3CSt87fKtIKMCC/QDYuxdX+fUc8okHyqI68lmLVJi5gsP
	 6TBiFuVvo4xkQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id A51D78E0437;
	Sun, 18 Aug 2024 14:24:34 +0000 (UTC)
Message-ID: <11efcbb2-f69a-49b4-a593-34fce42d49ea@icloud.com>
Date: Sun, 18 Aug 2024 22:24:30 +0800
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
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-3-8316b87b8ff9@quicinc.com>
 <20240817095713.GA182612@workstation.local>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20240817095713.GA182612@workstation.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BHc0WGEMQ2Lt9gpcmxuvj_aj9GbKxoD7
X-Proofpoint-ORIG-GUID: BHc0WGEMQ2Lt9gpcmxuvj_aj9GbKxoD7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-18_14,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408180105

On 2024/8/17 17:57, Takashi Sakamoto wrote:
> Hi,
> 
> On Thu, Aug 15, 2024 at 10:58:04PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> To prepare for constifying the following old driver core API:
>>
>> struct device *device_find_child(struct device *dev, void *data,
>> 		int (*match)(struct device *dev, void *data));
>> to new:
>> struct device *device_find_child(struct device *dev, const void *data,
>> 		int (*match)(struct device *dev, const void *data));
>>
>> The new API does not allow its match function (*match)() to modify
>> caller's match data @*data, but lookup_existing_device() as the old
>> API's match function indeed modifies relevant match data, so it is not
>> suitable for the new API any more, fixed by implementing a equivalent
>> fw_device_find_child() instead of the old API usage.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/firewire/core-device.c | 37 +++++++++++++++++++++++++++++++++++--
>>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> Thanks for the patch.
> 
>> Why to constify the API ?
>>
>> (1) It normally does not make sense, also does not need to, for
>> such device finding operation to modify caller's match data which
>> is mainly used for comparison.
>>
>> (2) It will make the API's match function and match data parameter
>> have the same type as all other APIs (bus|class|driver)_find_device().
>>
>> (3) It will give driver author hints about choice between this API and
>> the following one:
>> int device_for_each_child(struct device *dev, void *data,
>>                 int (*fn)(struct device *dev, void *data));
> 
> I have found another issue in respect to this subsystem.
> 
> The whole procedure in 'lookup_existing_device()' in the call of
> 'device_find_child()' is a bit superfluous, since it includes not only
> finding but also updating. The helper function passed to
> 'device_find_child()' should do quick finding only.
> 
> I think we can change the relevant codes like the following patch. It
> would solve your concern, too. If you prefer the change, I'm going to
> evaluate it.
> 

thanks for your reply.
of course, i prefer your change.

> ======== 8< --------
> 
> From ceaa8a986ae07865eb3fec810de330e96b6d56e2 Mon Sep 17 00:00:00 2001
> From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Date: Sat, 17 Aug 2024 17:52:53 +0900
> Subject: [PATCH] firewire: core: update fw_device outside of
>  device_find_child()
> 
> When detecting updates of bus topology, the data of fw_device is newly
> allocated and caches the content of configuration ROM from the
> corresponding node. Then, the tree of device is sought to find the
> previous data of fw_device corresponding to the node, since in IEEE 1394
> specification numeric node identifier could be changed dynamically every
> generation of bus topology. If it is found, the previous data is updated
> and reused, then the newly allocated data is going to be released.
> 
> The above procedure is done in the call of device_find_child(), however it
> is a bit abusing against the intention of the helper function, since the
> call would not only find but also update.
> 
> This commit splits the update outside of the call.
> ---
>  drivers/firewire/core-device.c | 109 ++++++++++++++++-----------------
>  1 file changed, 54 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
> index bc4c9e5a..62e8d839 100644
> --- a/drivers/firewire/core-device.c
> +++ b/drivers/firewire/core-device.c
> @@ -928,56 +928,6 @@ static void fw_device_update(struct work_struct *work)
>  	device_for_each_child(&device->device, NULL, update_unit);
>  }
>  
> -/*
> - * If a device was pending for deletion because its node went away but its
> - * bus info block and root directory header matches that of a newly discovered
> - * device, revive the existing fw_device.
> - * The newly allocated fw_device becomes obsolete instead.
> - */
> -static int lookup_existing_device(struct device *dev, void *data)
> -{
> -	struct fw_device *old = fw_device(dev);
> -	struct fw_device *new = data;
> -	struct fw_card *card = new->card;
> -	int match = 0;
> -
> -	if (!is_fw_device(dev))
> -		return 0;
> -
> -	guard(rwsem_read)(&fw_device_rwsem); // serialize config_rom access
> -	guard(spinlock_irq)(&card->lock); // serialize node access
> -
> -	if (memcmp(old->config_rom, new->config_rom, 6 * 4) == 0 &&
> -	    atomic_cmpxchg(&old->state,
> -			   FW_DEVICE_GONE,
> -			   FW_DEVICE_RUNNING) == FW_DEVICE_GONE) {
> -		struct fw_node *current_node = new->node;
> -		struct fw_node *obsolete_node = old->node;
> -
> -		new->node = obsolete_node;
> -		new->node->data = new;
> -		old->node = current_node;
> -		old->node->data = old;
> -
> -		old->max_speed = new->max_speed;
> -		old->node_id = current_node->node_id;
> -		smp_wmb();  /* update node_id before generation */
> -		old->generation = card->generation;
> -		old->config_rom_retries = 0;
> -		fw_notice(card, "rediscovered device %s\n", dev_name(dev));
> -
> -		old->workfn = fw_device_update;
> -		fw_schedule_device_work(old, 0);
> -
> -		if (current_node == card->root_node)
> -			fw_schedule_bm_work(card, 0);
> -
> -		match = 1;
> -	}
> -
> -	return match;
> -}
> -
>  enum { BC_UNKNOWN = 0, BC_UNIMPLEMENTED, BC_IMPLEMENTED, };
>  
>  static void set_broadcast_channel(struct fw_device *device, int generation)
> @@ -1038,6 +988,17 @@ int fw_device_set_broadcast_channel(struct device *dev, void *gen)
>  	return 0;
>  }
>  
> +static int compare_configuration_rom(struct device *dev, void *data)
> +{
> +	const struct fw_device *old = fw_device(dev);
> +	const u32 *config_rom = data;
> +
> +	if (!is_fw_device(dev))
> +		return 0;
> +
> +	return !!memcmp(old->config_rom, config_rom, 6 * 4);

!memcmp(old->config_rom, config_rom, 6 * 4) ?

is this extra condition old->state == FW_DEVICE_GONE required ?

namely, is it okay for  below return ?
return  !memcmp(old->config_rom, config_rom, 6 * 4) && old->state ==
FW_DEVICE_GONE

> +}
> +
>  static void fw_device_init(struct work_struct *work)
>  {
>  	struct fw_device *device =
> @@ -1071,13 +1032,51 @@ static void fw_device_init(struct work_struct *work)
>  		return;
>  	}
>  
> -	revived_dev = device_find_child(card->device,
> -					device, lookup_existing_device);
> +	// If a device was pending for deletion because its node went away but its bus info block
> +	// and root directory header matches that of a newly discovered device, revive the
> +	// existing fw_device. The newly allocated fw_device becomes obsolete instead.
> +	//
> +	// serialize config_rom access.
> +	scoped_guard(rwsem_read, &fw_device_rwsem) {
> +		// TODO: The cast to 'void *' could be removed if Zijun Hu's work goes well.

may remove this TODO line since i will simply remove the cast with the
other patch series as shown below:
https://lore.kernel.org/all/20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com/


> +		revived_dev = device_find_child(card->device, (void *)device->config_rom,
> +						compare_configuration_rom);
> +	}
>  	if (revived_dev) {
> -		put_device(revived_dev);
> -		fw_device_release(&device->device);
> +		struct fw_device *found = fw_device(revived_dev);
>  
> -		return;
> +		// serialize node access
> +		guard(spinlock_irq)(&card->lock);
> +
> +		if (atomic_cmpxchg(&found->state,
> +				   FW_DEVICE_GONE,
> +				   FW_DEVICE_RUNNING) == FW_DEVICE_GONE) {
> +			struct fw_node *current_node = device->node;
> +			struct fw_node *obsolete_node = found->node;
> +
> +			device->node = obsolete_node;
> +			device->node->data = device;
> +			found->node = current_node;
> +			found->node->data = found;
> +
> +			found->max_speed = device->max_speed;
> +			found->node_id = current_node->node_id;
> +			smp_wmb();  /* update node_id before generation */
> +			found->generation = card->generation;
> +			found->config_rom_retries = 0;
> +			fw_notice(card, "rediscovered device %s\n", dev_name(revived_dev));
> +
> +			found->workfn = fw_device_update;
> +			fw_schedule_device_work(found, 0);
> +
> +			if (current_node == card->root_node)
> +				fw_schedule_bm_work(card, 0);
> +
> +			put_device(revived_dev);
> +			fw_device_release(&device->device);
> +
> +			return;
> +		}

is it okay to put_device() here as well ?
put_device(revived_dev);

>  	}
>  
>  	device_initialize(&device->device);


