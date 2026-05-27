Return-Path: <netdev+bounces-292091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPqvIdF9FmqOmwcAu9opvQ
	(envelope-from <netdev+bounces-292091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:14:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D49BE5DF5B3
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45230303B4C0
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2B130C14F;
	Wed, 27 May 2026 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="alQlkhRv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942B2DB7A3
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 05:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779858881; cv=none; b=dVIPnC+EenHib8qC3JyT9LCnIz4JEUgBZFNxEokm2HxQSR/fH3aIBkorISB+PpmyXG5h7QLrh7o4szSvmnQOy179QVDAHFSzogPi8RsLbLaFLAoo0LSGvB249Ymw8awKBHblgznDtJcaIAHCUo5BlwqcVdSB2InHYck3fn6ttAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779858881; c=relaxed/simple;
	bh=oJhGmnrwMj1du6rYKDn7HPL9lKpaGLpx8ZVcEbgb8g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyN8CZdtpFllwRxAEomwQGS1esQE/U6D2ULrlLsI5MepfJu9vSw9RmXeL+eFHGV9Stj44mPwo7VLACfIdhl/Nzd67vLhZKbdBszY6+FUMJ1VX46oIDB7ox9JoN52vWn6Z7q33sVUbtdizwS1zNxe3t4oaF4PisaBVIfFw5fG4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=alQlkhRv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49041e84237so40176795e9.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 22:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779858874; x=1780463674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LRw+zoSTyzC4aLH4lQN58f0XhPHdzG/AD+2Qm3ZLpmc=;
        b=alQlkhRvhPsstj1ns2tzI/jvikjmUzg/VtgqjJRh/STWqCgPZ3pc2gtwK/xMw0BaLD
         UEuy5Hn4iHOQ6Pf1zm1ZECQo+8M70TRw89nBZM3j1FgdprFkT2aqJcnfk0D3dmRYXjNx
         HVMVa+4GpxeOPCqgMfami6fxhmIhzPGNEFrIWyWk53yDeay+Q09NtgQk85pcIV64FdhI
         T1x1Ro60lcqDK76PBFYTDeTaF46U+T+s4NCePl8VJ1AUhsXiShBW/ftoYRfiAwSrP935
         ZwCxcghuY5p0t5Y2zvTp1nDwHRAKXRmE5jMGeCeBFcMyeMwD+Q46TZdvlYdpxu2lgB9q
         CpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779858874; x=1780463674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRw+zoSTyzC4aLH4lQN58f0XhPHdzG/AD+2Qm3ZLpmc=;
        b=TPdy4+6T2BR5gRd158Uj/gq2aex4PLt9Z+IfsXrT5L/VVROTlJgI3Vqm2Icr+Yh/q2
         jzCn438KsHkjovs41q06Ib5FimaLDMBE96J1TCVs85oxFmJix7d8Wn2T4cDoOH1aWcMp
         SsxNnBfsZWok1un7DgUnakRxE8b0XkQaIYbYkCVXiJAXx8cGxt0tvR8AnJbWBF3is5rm
         9iHFXhnPJQv5YMCoAN2mCzp48/QOsABjlgYQ4DcUPxGDMxIOjWlHd1gLm4SJXqlfvKWc
         e6pcf5yvuEkR/gNKR2INwC5ZIgr6VCKTOU+Gbj0XBP3glgj1cyoDQb2pfFm3S6LTAwVp
         14Aw==
X-Forwarded-Encrypted: i=1; AFNElJ+6I6UczSGYMwXb3hHlUAUC3I/rzddMbd2qMX/B+PUTEPnk93MjkOFQg/Iun8LjVAQ3d/Tzn70=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzQDAZ4s6HnxPl4NLrkrz4ZAgATKna8wI53e7Nue+JhLpfGArP
	ITJt0pOv9WyJr/So2wKe8T2tjj8ysmE3H8SQ1rJiQHwWwfjWt1+HEjwmHeRfr5H8fDw=
X-Gm-Gg: Acq92OE6oNIDdYq42+/H/2FWUSgr/O49IAk3xu7uWuR/v2unLSxibF0lnBFETqwYHL9
	giCcPyTPc1YqUxgfHSprfUwKM6ZZSeeNBPSKifbLNv35EvJM0fEYXpBmE5UttNGVZqfVhWjN86W
	NvrIS4zrk9E2Rwm1YCR29WJihd/4FjVhmnjKyFd/OpbFutbGFgPm80aSvO4LyPf/Vwz0TPuuLv3
	SE+bi4gmYlEKJSXSK/z+53ez/ntME7+1j7xu21fWZzaHY4J839Ehrjw3zl+EYUnx4OU6Nt+0pzn
	EvIdeMv+2DFBNFBlnzDrD6xfC2/Iz4bmbN1Cim1iUoABX/1zK8n5pzq3NOMlfU5xq/tZi8DZ6nX
	YG1XbB3ifsD1VUcTmVuaJ5qSd37v66/rsPemtN1o6mzr72M7biqTauKhcsoHnN3xR+vqgVK4igP
	/TwkU+VZNg2Pdm9h0/BqGcSo8oc8acjO87
X-Received: by 2002:a05:600c:6992:b0:490:5000:917 with SMTP id 5b1f17b1804b1-49050000ae6mr289406275e9.1.1779858873378;
        Tue, 26 May 2026 22:14:33 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c60b5sm407330815e9.1.2026.05.26.22.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 22:14:32 -0700 (PDT)
Date: Wed, 27 May 2026 07:14:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	Li RongQing <lirongqing@baidu.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next 3/3] net/mlx5: Apply devlink default eswitch
 mode during init
Message-ID: <ahZ9CgIWdjny4N4D@FV6GYCPJ69>
References: <20260521072434.362624-1-tariqt@nvidia.com>
 <20260521072434.362624-4-tariqt@nvidia.com>
 <ahVPASuh4BZGOfx0@FV6GYCPJ69>
 <8c8df8da-62a9-49e8-84eb-572d54cfeb1f@nvidia.com>
 <ahWm4NXph9gdazV_@FV6GYCPJ69>
 <9aa7c295-35cb-428b-9031-13a2f507ae4b@nvidia.com>
 <ahXF2aQZNOwHdCG_@FV6GYCPJ69>
 <b9105eb7-de56-496e-998f-7c49c660b880@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9105eb7-de56-496e-998f-7c49c660b880@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	TAGGED_FROM(0.00)[bounces-292091-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[38];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: D49BE5DF5B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, May 26, 2026 at 07:13:46PM +0200, mbloch@nvidia.com wrote:
>
>
>On 26/05/2026 19:23, Jiri Pirko wrote:
>> Tue, May 26, 2026 at 05:03:57PM +0200, mbloch@nvidia.com wrote:
>>>
>>>
>>> On 26/05/2026 17:07, Jiri Pirko wrote:
>>>> Tue, May 26, 2026 at 11:44:46AM +0200, mbloch@nvidia.com wrote:
>>>>>
>>>>>
>>>>> On 26/05/2026 10:44, Jiri Pirko wrote:
>>>>>> Thu, May 21, 2026 at 09:24:34AM +0200, tariqt@nvidia.com wrote:
>>>>>>> From: Mark Bloch <mbloch@nvidia.com>
>>>>>>>
>>>>>>> Apply devlink default eswitch mode for mlx5 devices after successful
>>>>>>> device initialization while holding the devlink instance lock.
>>>>>>>
>>>>>>> At this point the devlink instance is registered and the mlx5 devlink
>>>>>>> operations are available, so the default eswitch mode can be applied to
>>>>>>> the matching PCI devlink handle.
>>>>>>>
>>>>>>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>>>>>>> Reviewed-by: Shay Drori <shayd@nvidia.com>
>>>>>>> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>>>>>>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>>>>>> ---
>>>>>>> drivers/net/ethernet/mellanox/mlx5/core/main.c | 17 +++++++++++++++++
>>>>>>> 1 file changed, 17 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>>> index 0c6e4efe38c8..4528097f3d84 100644
>>>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>>> @@ -1391,6 +1391,21 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
>>>>>>> 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
>>>>>>> }
>>>>>>>
>>>>>>> +static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
>>>>>>> +{
>>>>>>> +	struct devlink *devlink = priv_to_devlink(dev);
>>>>>>> +	int err;
>>>>>>> +
>>>>>>> +	if (!MLX5_ESWITCH_MANAGER(dev))
>>>>>>> +		return;
>>>>>>> +
>>>>>>> +	devl_assert_locked(devlink);
>>>>>>> +	err = devl_apply_default_esw_mode(devlink);
>>>>>>> +	if (err)
>>>>>>> +		mlx5_core_warn(dev, "Couldn't apply default eswitch mode, err %d\n",
>>>>>>> +			       err);
>>>>>>> +}
>>>>>>> +
>>>>>>> int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>>>>>> {
>>>>>>> 	bool light_probe = mlx5_dev_is_lightweight(dev);
>>>>>>> @@ -1437,6 +1452,7 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>>>>>> 		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
>>>>>>>
>>>>>>> 	mutex_unlock(&dev->intf_state_mutex);
>>>>>>> +	mlx5_devl_apply_default_esw_mode(dev);
>>>>>>
>>>>>> I wonder how we can make this work for all. I mean, other driver would
>>>>>> silently ignore this command like arg, right? Any idea how to make all
>>>>>> drivers follow the arg from very beginning?
>>>>>>
>>>>>
>>>>> I have a follow-up series that adds the call to all drivers which support
>>>>> setting eswitch mode. When going over the other drivers, what I found is
>>>>> that the right point to apply the default is driver specific, drivers
>>>>> I have patch for:
>>>>>
>>>>> 46e16c6d9836 net: Apply devlink esw mode defaults
>>>>> ab4f54102ba9 bnxt_en: Apply devlink default eswitch mode during init
>>>>> b48cce1607bb liquidio: Apply devlink default eswitch mode during init
>>>>> 4ea54b0fe04a ice: Apply devlink default eswitch mode during init
>>>>> b7faddaa1c90 octeontx2-af: Apply devlink default eswitch mode during init
>>>>> 74b0c22c47b9 octeontx2-pf: Apply devlink default eswitch mode during init
>>>>> 5000e4c3d768 nfp: Apply devlink default eswitch mode during init
>>>>> 97a218e95e41 netdevsim: Apply devlink default eswitch mode during init
>>>>>
>>>>> I don't think doing this generically from devlink is realistic. devlink
>>>>> doesn't really know when a given driver is ready to change eswitch mode.
>>>>> Some drivers need SR-IOV state, representor setup, or other init pieces to
>>>>> be ready first, and the locking is not identical across drivers either.
>>>>
>>>>
>>>> Low hanging fruit would be just to call ops->eswitch_mode_set at the end
>>>> of register. Multiple reasons:
>>>>
>>>> 1) end of devl_register is exactly the point userspace is free to issue
>>>>    the eswitch mode set. Driver should be ready to handle it.
>>>> 2) all drivers would transparently get this functionality, without
>>>>    actually knowing this kernel command line arg ever existed, without
>>>>    odd wiring call of related exported function. I prefer that stongly.
>>>> 3) you should add a there warning for the case this arg is passed yet
>>>>    the driver does not implement eswitch_mode_set. User should
>>>>    get a feedback like this, not silent ignore.
>>>>
>>>> The only loose end is see it the void return of devl_register().
>>>> Multiple ways to handle the possibly failed eswitch_mode_set(). I would
>>>> probably just go for pr_warn, seems to be the most correct.
>>>>
>>>> Make sense?
>>>
>>> I see the point, but I don't think devl_register() (at least not the only place)
>>> is the right place.
>>>
>>> There is a small but important difference between userspace doing
>>> "devlink eswitch set" after register is done, and devlink core calling
>>> eswitch_mode_set() from inside the register flow.
>>>
>>> Some drivers call devlink_register() while holding the device lock.
>>> liquidio is one example. If devlink core calls ops->eswitch_mode_set() from
>>> there, we may start the full eswitch mode change while holding that lock.
>>> That mode change can create representors, register netdevs, take rtnl,
>>> allocate resources, etc. I don't think we want this to become an implicit
>>> side effect of devlink registration.
>> 
>> I believe your AI may untagle liquidio locking :)
>
>I didn't try to solve that one with ai. Most drivers were fairly simple 
>so I didn't use ai at all. bnxt was the one where I needed a bit of help :)
>
>> 
>> 
>>>
>>> For mlx5, the placement after intf_state_mutex is also intentional:
>>>
>>> mutex_unlock(&dev->intf_state_mutex);
>>> mlx5_devl_apply_default_esw_mode(dev);
>>>
>>> We can't call it while holding intf_state_mutex because the mode set path
>>> takes it internally, and switchdev mode may also create IB representors.
>>>
>>> Also, devl_register() only covers the first registration. The mlx5 call in
>>> mlx5_load_one_devl_locked() is for reload/fw reset recovery kind of flows.
>>> In those flows devlink is already registered, so devl_register() is not
>>> called again, but the driver state was rebuilt and we may need to apply the
>>> default again.
>> 
>> Call it from reload too, right?
>
>Yes, that was my first thought: apply it from devl_register() for the first
>registration and from devlink_reload() after a successful DRIVER_REINIT.
>
>That covers the clean devlink reload path but....(see bellow)
>
>> 
>> 
>>>
>>> Same for reload, fw reset and pci recovery in general. If the driver tears
>>> down and rebuilds eswitch related state, the place to apply the default is
>>> in that driver's reinit flow, not in devl_register().
>>>
>>> When I went over the other drivers, the right place was not always the same
>>> as devlink registration. I'm not an expert in any of them, so I hope I got
>>> the details right, but for example octeontx2 AF needs sr-iov and the
>>> representor switch state to be initialized first. nfp can do it after
>>> app/vNIC init while the devlink lock is already held. liquidio should do it
>>> only after dropping the PCI device lock.
>> 
>> Idk, perhaps do it from devlink_post_register_work of some kind? That
>> would allow you to have the same locking ordering as a userspace cal
>l.
>
>I thought about a workqueue too, it was actually my first idea.
>
>The problem is that then we race with userspace. In the mlx5 version here the
>default is applied while the devlink lock is still held, before userspace can
>come in and issue its own eswitch set. If we defer it to post-register work,
>the devlink instance is already visible and userspace can get there first
>and then we might change the user configuration.

Figure that out and expose to user by setting xa_mark only after the
work is done? This is doable.


>
>Also, the bigger issue for mlx5 is not only initial registration or devlink
>reload. Some recovery paths, pci resume, and fw reset flows rebuild the driver
>state without going through devlink at all. I did not find a clean way for
>devlink core to infer all those points by itself.

If you don't obey current configuration for example in pci resume, it is
bug and you should fix it. All these flows should obey current eswitch
mode configuration.


>
>To handle that from devlink I would still need to add some api for the driver
>to tell devlink "I just reinitialized, apply the default now". but nce I had
>that driver call , it felt simpler and clearer to let the driver call
>the helper directly at the points where it knows eswitch mode is safe.
>
>I agree that handling all of this inside devlink would be the better option.
>I just couldn't make it work in a clean way.
>
>Mark
>
>> 
>>>
>>> Mark
>>>
>>>>
>>>>
>>>>>
>>>>> Also, since this knob is only about eswitch mode, I don't think we need to
>>>>> touch every devlink driver. Drivers that don't implement eswitch_mode_set()
>>>>> would just ignore it anyway. The follow-up only wires the default into
>>>>> drivers that actually support changing eswitch mode.
>>>>>
>>>>> Mark
>>>>>
>>>>>>
>>>>>>> 	return 0;
>>>>>>>
>>>>>>> err_register:
>>>>>>> @@ -1538,6 +1554,7 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
>>>>>>> 		goto err_attach;
>>>>>>>
>>>>>>> 	mutex_unlock(&dev->intf_state_mutex);
>>>>>>> +	mlx5_devl_apply_default_esw_mode(dev);
>>>>>>> 	return 0;
>>>>>>>
>>>>>>> err_attach:
>>>>>>> -- 
>>>>>>> 2.44.0
>>>>>>>
>>>>>
>>>
>

