Return-Path: <netdev+bounces-155869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B487A041ED
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7C23A8B4C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7801F238D;
	Tue,  7 Jan 2025 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1+xXhQM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EF11F2370;
	Tue,  7 Jan 2025 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258953; cv=none; b=g84hRULFotsna46n4/9Kpg4lH3bWONiNkNHb6+cqCf76DTmjyTtUvEyQbbYvHV8heex/Gz+bZ09v4oIQ5ozq9LlY7MDjKD8/6/VYDU9hbNIDWj1Z3JHPlQEu9xa5BZUd60w/ULkKGalSCsrJ3ZpCKpfK89VLXbojinkhe1mQNGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258953; c=relaxed/simple;
	bh=8BDLYUYf++vdrqb+LR2+oH4WmfnIOFOg7FweOzpyr30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PL6Z3In5Q5lMSl/KxX6e1wr0j4eQgojx4f3Mp4AlSv+cuYyh2Kevvg3ftwce62K67rw9TTNLjvJWbaNYGyUH+4droZ0dqsu01CgHzJJZXxykpPU27HSyzAUj+P+XTFtqOA+jfV70Cp8x16XtqkuflzqzxpldbQuiUANXPzDuEuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1+xXhQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1FDC4CED6;
	Tue,  7 Jan 2025 14:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736258952;
	bh=8BDLYUYf++vdrqb+LR2+oH4WmfnIOFOg7FweOzpyr30=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A1+xXhQMRlsJ54nJKYiiZ8RmnKFUOnBXEY38VI0i0ytdjVibx+Bcvc4wvkbjYPHn8
	 YMs9zjqn5G2VoJjwr2qeiC+58MKlswK2cIlYFTQwmrY3l+IA8AJR2BTmQ3IHVRdw6z
	 Q2re7J6cgvh2Mv53wiN3yMHdv/AaLLim3pGKOPRV0XaPBXIKuuXLo/SF+VTzEThOYt
	 VtR/LHnBti9ZpAlt1PkuzZL3XbZLpVyYwfNrvhjSH4sI4YxwpFa2enxSdHGMjDv4dM
	 2XoOFIr+aQizk7YQclkKwkEI15sqNH0BJ2o9CJpbUOUsKb/LV8AzLX7QlwoW+/p/PE
	 hRJMqVXnTv+EA==
Message-ID: <db1a2109-9a03-46a3-b24f-fe9fbc74b875@kernel.org>
Date: Tue, 7 Jan 2025 16:09:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add Support for
 Multicast filtering with VLAN in HSR mode
To: "Anwar, Md Danish" <a0501179@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Jeongjun Park <aha310510@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Lukasz Majewski <lukma@denx.de>, Meghana Malladi <m-malladi@ti.com>,
 Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>
References: <20250103092033.1533374-1-danishanwar@ti.com>
 <20250103092033.1533374-4-danishanwar@ti.com>
 <31bb8a3e-5a1c-4c94-8c33-c0dfd6d643fb@kernel.org>
 <5cc13a7f-b3f9-42d5-b9e2-7da5cb54af5b@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <5cc13a7f-b3f9-42d5-b9e2-7da5cb54af5b@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/01/2025 16:01, Anwar, Md Danish wrote:
> 
> 
> On 1/7/2025 6:53 PM, Roger Quadros wrote:
>>
>>
>> On 03/01/2025 11:20, MD Danish Anwar wrote:
>>> Add multicast filtering support for VLAN interfaces in HSR offload mode
>>> for ICSSG driver.
>>>
>>> The driver calls vlan_for_each() API on the hsr device's ndev to get the
>>> list of available vlans for the hsr device. The driver then sync mc addr of
>>> vlan interface with a locally mainatined list emac->vlan_mcast_list[vid]
>>> using __hw_addr_sync_multiple() API.
>>>
>>> The driver then calls the sync / unsync callbacks.
>>>
>>> In the sync / unsync call back, driver checks if the vdev's real dev is
>>> hsr device or not. If the real dev is hsr device, driver gets the per
>>> port device using hsr_get_port_ndev() and then driver passes appropriate
>>> vid to FDB helper functions.
>>>
>>> This commit makes below changes in the hsr files.
>>> - Move enum hsr_port_type from net/hsr/hsr_main.h to include/linux/if_hsr.h
>>>   so that the enum can be accessed by drivers using hsr.
>>> - Create hsr_get_port_ndev() API that can be used to get the ndev
>>>   pointer to the slave port from ndev pointer to the hsr net device.
>>> - Export hsr_get_port_ndev() API so that the API can be accessed by
>>>   drivers using hsr.
>>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 83 +++++++++++++++-----
>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 +
>>>  include/linux/if_hsr.h                       | 18 +++++
>>>  net/hsr/hsr_device.c                         | 13 +++
>>>  net/hsr/hsr_main.h                           |  9 ---
>>
>> Should we be splitting hsr core changes into separate patch first,
>> then followed by a patch with icssg driver changes?
>>
> 
> I wanted to make sure that the changes to hsr core are done with the
> driver change so that any one looking at the commit can understand why
> these changes are done.
> 
> If we split the changes and someone looks at the commit modifying hsr
> core, they will not be able to understand why this is done. We will be
> creating and exporting API hsr_get_port_ndev() but there will be no
> caller for this.

I think you can explain in the commit log why you need the API.

> 
>>>  5 files changed, 97 insertions(+), 28 deletions(-)
>>
> 

-- 
cheers,
-roger


