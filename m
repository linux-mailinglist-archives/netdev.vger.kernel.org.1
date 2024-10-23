Return-Path: <netdev+bounces-138207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DBE9AC9A8
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43881F2130B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809DB1AB6FA;
	Wed, 23 Oct 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPLkPYI/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5326B14D2AC;
	Wed, 23 Oct 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685204; cv=none; b=UC0ooxIWtM8yXqSYiedQ2jDEuKFW6fI6pvZMfAwhSHEPHFkvkq1HwianqMQ9kE6d6ky2JD8GVwHsot0IuNSJ3R6JZDqDHHAbrUNz7YRAHDdqnHzLkkcHHsmhj3Nz8tDArpeUvCA/NkHc/W7vnomV2vimMTgxaFnkXowXj3Otf3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685204; c=relaxed/simple;
	bh=LKQ21pc9rfUpxmCt54SLodZJTZsUwzL5GF8xuvnlKGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8Bwgp7cPUHNvkmiDE/H971z1jvjRepNXUu9ylrQCGYivI7W8jiapc/Qwl7vjvkJNvSLyh9Ge2fVgDTnPnFcZN6blOCXosJjd462IAOjh+7OExqR83v9FjUto4Xj4B0ekvKhJPB4Puyzgf8F9/jhwKZTpr2jlGUmGQGLQXeMG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPLkPYI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03398C4CEC6;
	Wed, 23 Oct 2024 12:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729685203;
	bh=LKQ21pc9rfUpxmCt54SLodZJTZsUwzL5GF8xuvnlKGI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oPLkPYI/LsWBNDpCH6Uvom7YJfiYxJTGckNL+11zN+l+wEg/8ClGot4Ui59bPgh+C
	 ijTFf2agEbtby+eYDjnLzkGA9tE5C8y1/25dFhxwd+JmQ3AMqpfTLXdxCaTRcLG9wX
	 K8ipKNLoeLzHvOrFxW266hwPEl17zGFAJDdPL4qliYm3Cxzyp4RbsPiEEd3AtKmj2x
	 MKyT0NCWwXsORpXlDBQq86MJm7g69bOW+0HzCp7pUK0qZtP4W4f1Fj9lMEgdXUNBiJ
	 WNXL+U/grAAuvzIOLR24BNe2yJkkQbgncNGmHDeRoD60BWCcAgBkYmKmV6NUXBPPF7
	 MVLeYsvGcwtCQ==
Message-ID: <24b18f9e-6fbd-48cc-96bd-e634d0af9824@kernel.org>
Date: Wed, 23 Oct 2024 14:06:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 14/15] net: sparx5: add compatible strings for
 lan969x and verify the target
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, andrew@lunn.ch,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, horatiu.vultur@microchip.com,
 jensemil.schulzostergaard@microchip.com,
 Parthiban.Veerasooran@microchip.com, Raju.Lakkaraju@microchip.com,
 UNGLinuxDriver@microchip.com, Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, jacob.e.keller@intel.com,
 ast@fiberby.net, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
 <20241021-sparx5-lan969x-switch-driver-2-v1-14-c8c49ef21e0f@microchip.com>
 <cetor3ohhg6rzf3w2cm6hqxsqukh52nm54mp7tizb2qc3x44j4@n53v6btq6t6r>
 <20241023110034.jpwoblwrds3ln5nr@DEN-DL-M70577>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241023110034.jpwoblwrds3ln5nr@DEN-DL-M70577>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/10/2024 13:00, Daniel Machon wrote:
> Hi Krzysztof,
> 
>>> Add compatible strings for the twelve lan969x SKU's (Stock Keeping Unit)
>>> that we support, and verify that the devicetree target is supported by
>>> the chip target.
>>>
>>> Each SKU supports different bandwidths and features (see [1] for
>>> details). We want to be able to run a SKU with a lower bandwidth and/or
>>> feature set, than what is supported by the actual chip. In order to
>>> accomplish this we:
>>>
>>>     - add new field sparx5->target_dt that reflects the target from the
>>>       devicetree (compatible string).
>>>
>>>     - compare the devicetree target with the actual chip target. If the
>>>       bandwidth and features provided by the devicetree target is
>>>       supported by the chip, we approve - otherwise reject.
>>>
>>>     - set the core clock and features based on the devicetree target
>>>
>>> [1] https://www.microchip.com/en-us/product/lan9698
>>>
>>> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
>>> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
>>> ---
>>>  drivers/net/ethernet/microchip/sparx5/Makefile     |   1 +
>>>  .../net/ethernet/microchip/sparx5/sparx5_main.c    | 194 ++++++++++++++++++++-
>>>  .../net/ethernet/microchip/sparx5/sparx5_main.h    |   1 +
>>>  3 files changed, 193 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
>>> index 3435ca86dd70..8fe302415563 100644
>>> --- a/drivers/net/ethernet/microchip/sparx5/Makefile
>>> +++ b/drivers/net/ethernet/microchip/sparx5/Makefile
>>> @@ -19,3 +19,4 @@ sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o
>>>  # Provide include files
>>>  ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
>>>  ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/fdma
>>> +ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/lan969x
>>> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
>>> index 5c986c373b3e..edbe639d98c5 100644
>>> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
>>> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
>>> @@ -24,6 +24,8 @@
>>>  #include <linux/types.h>
>>>  #include <linux/reset.h>
>>>
>>> +#include "lan969x.h" /* lan969x_desc */
>>> +
>>>  #include "sparx5_main_regs.h"
>>>  #include "sparx5_main.h"
>>>  #include "sparx5_port.h"
>>> @@ -227,6 +229,168 @@ bool is_sparx5(struct sparx5 *sparx5)
>>>       }
>>>  }
>>>
>>> +/* Set the devicetree target based on the compatible string */
>>> +static int sparx5_set_target_dt(struct sparx5 *sparx5)
>>> +{
>>> +     struct device_node *node = sparx5->pdev->dev.of_node;
>>> +
>>> +     if (is_sparx5(sparx5))
>>> +             /* For Sparx5 the devicetree target is always the chip target */
>>> +             sparx5->target_dt = sparx5->target_ct;
>>> +     else if (of_device_is_compatible(node, "microchip,lan9691-switch"))
>>> +             sparx5->target_dt = SPX5_TARGET_CT_LAN9691VAO;
>>> +     else if (of_device_is_compatible(node, "microchip,lan9692-switch"))
>>> +             sparx5->target_dt = SPX5_TARGET_CT_LAN9692VAO;
>>> +     else if (of_device_is_compatible(node, "microchip,lan9693-switch"))
>>> +             sparx5->target_dt = SPX5_TARGET_CT_LAN9693VAO;
>>> +     else if (of_device_is_compatible(node, "microchip,lan9694-switch"))
>>> +             sparx5->target_dt = SPX5_TARGET_CT_LAN9694;
>>> +     else if (of_device_is_compatible(node, "microchip,lan9695-switch"))
>>> +             sparx5->target_dt = SPX5_TARGET_CT_LAN9694TSN;
>>> +     else if (of_device_is_compatible(node, "microchip,lan9696-switch"))
>>> +             sparx5->target_dt = SPX5_TARGET_CT_LAN9696;
>>> +     else if (of_device_is_compatible(node, "microchip,lan9697-switch"))
>>> +             sparx5->target_dt = SPX5_TARGET_CT_LAN9696TSN;
>>> +     else if (of_device_is_compatible(node, "microchip,lan9698-switch"))
>>> +             sparx5->target_dt = SPX5_TARGET_CT_LAN9698;
>>> +     else if (of_device_is_compatible(node, "microchip,lan9699-switch"))
>>> +             sparx5->target_dt = SPX5_TARGET_CT_LAN9698TSN;
>>> +     else if (of_device_is_compatible(node, "microchip,lan969a-switch"))
>>> +             sparx5->target_dt = SPX5_TARGET_CT_LAN9694RED;
>>> +     else if (of_device_is_compatible(node, "microchip,lan969b-switch"))
>>> +             sparx5->target_dt = SPX5_TARGET_CT_LAN9696RED;
>>> +     else if (of_device_is_compatible(node, "microchip,lan969c-switch"))
>>> +             sparx5->target_dt = SPX5_TARGET_CT_LAN9698RED;
>>> +     else
>>> +             return -EINVAL;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/* Compare the devicetree target with the chip target.
>>> + * Make sure the chip target supports the features and bandwidth requested
>>> + * from the devicetree target.
>>> + */
>>> +static int sparx5_verify_target(struct sparx5 *sparx5)
>>> +{
>>> +     switch (sparx5->target_dt) {
>>> +     case SPX5_TARGET_CT_7546:
>>> +     case SPX5_TARGET_CT_7549:
>>> +     case SPX5_TARGET_CT_7552:
>>> +     case SPX5_TARGET_CT_7556:
>>> +     case SPX5_TARGET_CT_7558:
>>> +     case SPX5_TARGET_CT_7546TSN:
>>> +     case SPX5_TARGET_CT_7549TSN:
>>> +     case SPX5_TARGET_CT_7552TSN:
>>> +     case SPX5_TARGET_CT_7556TSN:
>>> +     case SPX5_TARGET_CT_7558TSN:
>>> +             return 0;
>>
>> All this is weird. Why would you verify? You were matched, it cannot be
>> mis-matching.
> 
> We are verifying that the match (target/compatible string) from the
> device tree is supported by the chip. Maybe I wasn't too clear about the
> intend in v1.
> 
> Each target supports different bandwidths and features. If you have a
> lan9698 chip, it must, obviously, be possible to run it as a lan9698
> target. However, some targets can be run on chip targets other than
> themselves, given that the chip supports the bandwidth and features of
> the provided target. In contrary, trying to run as a target with a
> feature not supported by the chip, or a bandwidth higher than what the
> chip supports, should be rejected.

But you are not supposed to compare DT with what you auto-detected.
Detect your hardware, test if it is supported and then bail out.

None of above explains the code.

> 
> Without this logic, the chip id is read and a target is determined. That
> means on a lan9698 chip you will always match the lan9698 target.

That's not the job of kernel.

> 
> With the new logic, it is possible to run as a different target than
> what is read from the chip id, given that the target you are trying to
> run as, is supported by the chip.

So just run on different target.

> 
>>
>>> +     case SPX5_TARGET_CT_LAN9698RED:
>>> +             if (sparx5->target_ct == SPX5_TARGET_CT_LAN9698RED)
>>
>> What is "ct"? sorry, all this code is a big no.
> 
> In this case we were matched as a SPX5_TARGET_CT_LAN9698RED target. We
> are verifying that the chip target (target_ct, which is read from the
> chip) supports the target we were matched as.
> 
>> Krzysztof
>>
> 
> This is a feature that we would like, as it gives the flexibility of
> running different targets on the same chip. Now if this is something
> that cannot be accepted, I will have to ditch this part.

I have no clue what the "target" is but so far it looks like you try to
validate DT against detected device. That's not how it should work.

Best regards,
Krzysztof


