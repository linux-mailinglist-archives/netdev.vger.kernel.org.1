Return-Path: <netdev+bounces-61598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 861B28245C9
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631C71C21F4D
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D7424A0C;
	Thu,  4 Jan 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3zfecvj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B2E24B3D
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d4a222818so9797785e9.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 08:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704384416; x=1704989216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVxO3X+ccGWrdx8Ekh7/PXa9BRBTpuQW99Oblr58WQM=;
        b=R3zfecvjYbzyFyMRDa8wokTcBtdRBDKZrTGnEAhlEMtfF4rM9i5iiKpv2oIRe689zv
         D7243UNCZiCNz5ukw4UHAbFzLtu+GJQiD95N5Soloq4r7jZk64UWzKVSSRBkZmGaQp/w
         bkKcBuAXZLFkI8ShBpFVjbsNx9JnMZ5ErjXDIB9xomrpXqmkNaSQagw5Dp3IIO5z6xpA
         WAKpxKFhQZGDJ9J3fBQDJ85zUWJL/kp12d1ewgHM6rEj1LsItkLF25F5gBDh5eJRTMX9
         70KoiYfSsO8acprjOVvRjdwRuddXmXPvOzkW+lsMNR1ltrpMKh2VKQcyYK38BOktZBzG
         iddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704384416; x=1704989216;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVxO3X+ccGWrdx8Ekh7/PXa9BRBTpuQW99Oblr58WQM=;
        b=iP9oy3cR1goBh+hdSI34ZzK9B/wH4PLAjjy6N6FYgOgF6IvzG5WFOJOuzARcFv7dZ1
         UKl2FV3BB/d8+i+XXzaMxJfOhjtMrUMcGt+G+eM6zwGQxziuH3+x2eIPEngbVjYlqsC/
         sUjii19E47mMXDecyNwK3+46F7xluvt9zeBZpBmeUFyMr4tv63rFLjjxWvIXqEyXLoxv
         6957dVa4PXwfzMWUJNIDytkWXMZdW5Y33mE0oHRvK3jokXI/DVUthYTE7HoCEKPFx3Z6
         t5j4gwGf5f9xxMpA2xcVZUDaeY6tfDFhFaBDSXMxkSb9FFvYrkMNy+3+vTOPs5C7uoKN
         buag==
X-Gm-Message-State: AOJu0YyjL6O0DasCOAIIieYUKlZMlybFFvxcsaR/1vhq35KJVBMSWcx2
	RQsisMv+TsW5DSfGKf4eynU=
X-Google-Smtp-Source: AGHT+IEhqV/poQROJWRT9i0lkVGrWFgMxgYiD46SIcozsE+xHk8sBPS5CHi9NF/LyOcmxhodIu4Blg==
X-Received: by 2002:a05:600c:1da9:b0:40d:88ba:b1a4 with SMTP id p41-20020a05600c1da900b0040d88bab1a4mr456614wms.97.1704384415616;
        Thu, 04 Jan 2024 08:06:55 -0800 (PST)
Received: from ?IPV6:2a01:c22:6ffe:b000:1d0:e6df:b486:c903? (dynamic-2a01-0c22-6ffe-b000-01d0-e6df-b486-c903.c22.pool.telefonica.de. [2a01:c22:6ffe:b000:1d0:e6df:b486:c903])
        by smtp.googlemail.com with ESMTPSA id c1-20020a05600c0a4100b0040d81c3343bsm6157415wmq.42.2024.01.04.08.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 08:06:55 -0800 (PST)
Message-ID: <ceaee76d-d785-4931-ad4a-ddba06365308@gmail.com>
Date: Thu, 4 Jan 2024 17:06:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ethtool ioctl ABI: preferred way to expand uapi structure
 ethtool_eee for additional link modes?
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>
Cc: Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>
References: <20240104161416.05d02400@dellmb>
 <d3f3fca4-624c-4001-9218-6bf69ca911b3@lunn.ch>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <d3f3fca4-624c-4001-9218-6bf69ca911b3@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04.01.2024 16:36, Andrew Lunn wrote:
> On Thu, Jan 04, 2024 at 04:14:16PM +0100, Marek Behún wrote:
>> Hello,
>>
>> the legacy ioctls ETHTOOL_GSET and ETHTOOL_SSET, which pass structure
>> ethtool_cmd, were superseded by ETHTOOL_GLINKSETTINGS and
>> ETHTOOL_SLINKSETTINGS.
>>
>> This was done because the original structure only contains 32-bit words
>> for supported, advertising and lp_advertising link modes. The new
>> structure ethtool_link_settings contains member
>>   s8 link_mode_masks_nwords;
>> and a flexible array
>>   __u32 link_mode_masks[];
>> in order to overcome this issue.
>>
>> But currently we still have only legacy structure ethtool_eee for EEE
>> settings:
>>   struct ethtool_eee {
>>     __u32 cmd;
>>     __u32 supported;
>>     __u32 advertised;
>>     __u32 lp_advertised;
>>     __u32 eee_active;
>>     __u32 eee_enabled;
>>     __u32 tx_lpi_enabled;
>>     __u32 tx_lpi_timer;
>>     __u32 reserved[2];
>>   };
>>
>> Thus ethtool is unable to get/set EEE configuration for example for
>> 2500base-T and 5000base-T link modes, which are now available in
>> several PHY drivers.
>>
>> We can remedy this by either:
>>
>> - adding another ioctl for EEE settings, as was done with the GSET /
>>   SSET
>>
>> - using the original ioctl, but making the structure flexible (we can
>>   replace the reserved fields with information that the array is
>>   flexible), i.e.:
>>
>>   struct ethtool_eee {
>>     __u32 cmd;
>>     __u32 supported;
>>     __u32 advertised;
>>     __u32 lp_advertised;
>>     __u32 eee_active;
>>     __u32 eee_enabled;
>>     __u32 tx_lpi_enabled;
>>     __u32 tx_lpi_timer;
>>     s8 link_mode_masks_nwords; /* zero if legacy 32-bit link modes */
>>     __u8 reserved[7];
>>     __u32 link_mode_masks[];
>>     /* filled in if link_mode_masks_nwords > 0, with layout:
>>      * __u32 map_supported[link_mode_masks_nwords];
>>      * __u32 map_advertised[link_mode_masks_nwords];
>>      * __u32 map_lp_advertised[link_mode_masks_nwords];
>>      */
>>   };
>>
>>   this way we will be left with another 7 reserved bytes for future (is
>>   this enough?)
>>
>> What would you prefer?
> 
> There are two different parts here. The kAPI, and the internal API.
> 
> For the kAPI, i would not touch the IOCTL interface, since its
> deprecated. The netlink API for EEE uses bitset32. However, i think
> the message format for a bitset32 and a generic bitset is the same, so
> i think you can just convert that without breaking userspace. But you
> should check with Michal Kubecek to be sure.
> 
> For the internal API, i personally would assess the work needed to
> change supported, advertised and lp_advertised into generic linkmode
> bitmaps. Any MAC drivers using phylib/phylink probably don't touch
> them, so you just need to change the phylib helpers. Its the MAC
> drivers not using phylib which will need more work. But i've no idea
> how much work that is. Ideally they all get changed, so we have a
> uniform clean API.
> 
In case you missed it: Few days ago I posted a series that adds full
EEE linkmode bitmap support to the ethtool netlink interface.
The good news is that no changes to the userspace tool are needed.

https://lore.kernel.org/netdev/783d4a61-2f08-41fc-b91d-bd5f512586a2@gmail.com/T/

>     Andrew

Heiner


