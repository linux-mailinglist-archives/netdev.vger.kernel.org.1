Return-Path: <netdev+bounces-181091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C47BA83A6B
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC2919E587A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FA7207665;
	Thu, 10 Apr 2025 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXFmO6Cl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57DB206F36;
	Thu, 10 Apr 2025 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269102; cv=none; b=iJABAcM9ZkBct3mHjwl1vhl8ocWPvb+qV6DZgSjG678iDHJObC2Z6vI4/m0YmfHMEXULkQmPAkr0NtLUIRxxc/WuKQGnNcjAgZlFNb6HglD4Y66cz6zT4zFw+ROn0SyPFgO13Yenqv1isq5VlQSfDGY+2sYgRd0Vkbn+iNOvIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269102; c=relaxed/simple;
	bh=lOL/KYAQsMuPcvnLTzDBF0wRTP6K0klZk+sB5D8LC8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0vjj4gt3a6lvzQ/hg4yKYQY2TL+DsZgp5wiLyEUlCfE8wraTGVW8ioO/RPNF9Z7dYHewukaYzgxPHpjDUSHnfUTYOUXJBJIV3uKrOdtdQvW9kuI788VZPfFovKD93tHG0jVY9YM471KjYVbWT1dzg2zV/SWlJnRS4VJJPgQynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXFmO6Cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E11AC4CEE3;
	Thu, 10 Apr 2025 07:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744269102;
	bh=lOL/KYAQsMuPcvnLTzDBF0wRTP6K0klZk+sB5D8LC8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VXFmO6Cll4GUdcWnsU6Vv9AjQGRoxVByRnHC3VmCoQy7gNY7D7NlKB/djhC7vjLJB
	 3fMlAjLc+4rvScaHJu75gnx+pd/MCluP3ivbSYk5FEDrpPYlXa3jNqvMzPL9wuX5qk
	 6jqbldMa/f27U0ASlhHkpKMkCXIQFMqhX/i7uFCE1papumh3q8tG8kVDW3oDNn+XhA
	 t21zKo3T6YCdFgqUc1oibuQqL/+p3LZbX+efMW82va6i92f8CQpuPMMx09wWCHeqma
	 BIC2W7h7Bm0R6CHCaGTHGtXCr7KS0UlZbNWSV1unx6FBQt1bKQHLpZvQc29uU3ViKC
	 C40g3WKq9PNzA==
Message-ID: <5af77349-5a76-4557-839b-d9ac643f5368@kernel.org>
Date: Thu, 10 Apr 2025 09:11:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/28] mfd: zl3073x: Add components versions register defs
To: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407172836.1009461-6-ivecera@redhat.com>
 <a5d2e1eb-7b98-4909-9505-ec93fe0c3aac@lunn.ch>
 <22b9f197-2f98-43c7-9cc9-c748e80078b0@redhat.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <22b9f197-2f98-43c7-9cc9-c748e80078b0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2025 08:44, Ivan Vecera wrote:
> On 07. 04. 25 11:09 odp., Andrew Lunn wrote:
>> On Mon, Apr 07, 2025 at 07:28:32PM +0200, Ivan Vecera wrote:
>>> Add register definitions for components versions and report them
>>> during probe.
>>>
>>> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>> ---
>>>   drivers/mfd/zl3073x-core.c | 35 +++++++++++++++++++++++++++++++++++
>>>   1 file changed, 35 insertions(+)
>>>
>>> diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
>>> index 39d4c8608a740..b3091b00cffa8 100644
>>> --- a/drivers/mfd/zl3073x-core.c
>>> +++ b/drivers/mfd/zl3073x-core.c
>>> @@ -1,10 +1,19 @@
>>>   // SPDX-License-Identifier: GPL-2.0-only
>>>   
>>> +#include <linux/bitfield.h>
>>>   #include <linux/module.h>
>>>   #include <linux/unaligned.h>
>>>   #include <net/devlink.h>
>>>   #include "zl3073x.h"
>>>   
>>> +/*
>>> + * Register Map Page 0, General
>>> + */
>>> +ZL3073X_REG16_DEF(id,			0x0001);
>>> +ZL3073X_REG16_DEF(revision,		0x0003);
>>> +ZL3073X_REG16_DEF(fw_ver,		0x0005);
>>> +ZL3073X_REG32_DEF(custom_config_ver,	0x0007);
>>> +
>>>   /*
>>>    * Regmap ranges
>>>    */
>>> @@ -159,10 +168,36 @@ EXPORT_SYMBOL_NS_GPL(zl3073x_dev_alloc, "ZL3073X");
>>>   
>>>   int zl3073x_dev_init(struct zl3073x_dev *zldev)
>>>   {
>>> +	u16 id, revision, fw_ver;
>>>   	struct devlink *devlink;
>>> +	u32 cfg_ver;
>>> +	int rc;
>>>   
>>>   	devm_mutex_init(zldev->dev, &zldev->lock);
>>>   
>>> +	scoped_guard(zl3073x, zldev) {
>>
>> Why the scoped_guard? The locking scheme you have seems very opaque.
> 
> We are read the HW registers in this block and the access is protected 
> by this device lock. Regmap locking will be disabled in v2 as this is 

Reading ID must be protected by mutex? Why and how?

What is a "device lock"?

> not sufficient.
> 
>>> +		rc = zl3073x_read_id(zldev, &id);
>>> +		if (rc)
>>> +			return rc;
>>> +		rc = zl3073x_read_revision(zldev, &revision);
>>> +		if (rc)
>>> +			return rc;
>>> +		rc = zl3073x_read_fw_ver(zldev, &fw_ver);
>>> +		if (rc)
>>> +			return rc;
>>> +		rc = zl3073x_read_custom_config_ver(zldev, &cfg_ver);
>>> +		if (rc)
>>> +			return rc;
>>
>> Could a parallel operation change the ID? Upgrade the firmware
>> version?
>>
>> 	Andrew
> 
> No, but register access functions require the device lock to be held. 
> See above.

Andrew comments stay valid here. This is weird need of locking and your
explanation is very vague.

BTW, do not send v2 before people respond to your comments in reasonable
time. You just send 28 patchset and expect people to finish review after
one day.

Best regards,
Krzysztof

