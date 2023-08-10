Return-Path: <netdev+bounces-26310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E060D7777D6
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8BA1C2154D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2371FB22;
	Thu, 10 Aug 2023 12:05:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D6442C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 12:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F02C433B7;
	Thu, 10 Aug 2023 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691669144;
	bh=i0cmE0TIm+1MbdD3rP69KYhR9J0vOVc6iWr6PA13760=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hCW+BTVsmjd8dw6pq6If2YoFA1KdhSimtg+FZaT3zqKerq6Qhkw1Ly+60YkzEaETs
	 DTK9yrde5/cAxjoRtAcf1f3azCGEv2haaST6qJNFA/UZhYnptKLJ3za2GvunrNCGSm
	 YPHGc7cTL3SY9D7a0yj1w0OHQUWelRf//khk2CT7l4RB6xKy+eFvgM2of4RDzJ+X4c
	 HSI0pmZF9xQqYDDjKGuB0hPTK3OHF+klMws3GDB/qTbuFThxNyxroohXnJPajnIapg
	 6Dc9tHQYI8HP34AI77YhG4DP9QZrnpc6cvbxoNdlfdNtq4J9F/3ekSsPP7NW9fwf0a
	 4tqlBwiAhgDwg==
Message-ID: <1b05b4ae-00e7-0f90-9c63-7da8797bdb6a@kernel.org>
Date: Thu, 10 Aug 2023 15:05:36 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 3/5] net: ti: icss-iep: Add IEP driver
Content-Language: en-US
To: Md Danish Anwar <a0501179@ti.com>, Andrew Davis <afd@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Randy Dunlap <rdunlap@infradead.org>,
 Simon Horman <simon.horman@corigine.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230809114906.21866-1-danishanwar@ti.com>
 <20230809114906.21866-4-danishanwar@ti.com>
 <b43ee5ca-2aab-445a-e24b-cbc95f9186ea@ti.com>
 <c7ddb12d-ae18-5fc2-9729-c88ea73b21d7@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <c7ddb12d-ae18-5fc2-9729-c88ea73b21d7@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/08/2023 14:50, Md Danish Anwar wrote:
> Hi Andrew,
> 
> On 09/08/23 8:30 pm, Andrew Davis wrote:
>> On 8/9/23 6:49 AM, MD Danish Anwar wrote:
>>> From: Roger Quadros <rogerq@ti.com>
>>>
>>> Add a driver for Industrial Ethernet Peripheral (IEP) block of PRUSS to
>>> support timestamping of ethernet packets and thus support PTP and PPS
>>> for PRU ethernet ports.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>>   drivers/net/ethernet/ti/Kconfig          |  12 +
>>>   drivers/net/ethernet/ti/Makefile         |   1 +
>>>   drivers/net/ethernet/ti/icssg/icss_iep.c | 935 +++++++++++++++++++++++
>>>   drivers/net/ethernet/ti/icssg/icss_iep.h |  38 +
>>>   4 files changed, 986 insertions(+)
>>>   create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.c
>>>   create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.h
>>>
>>> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
>>> index 63e510b6860f..88b5b1b47779 100644
>>> --- a/drivers/net/ethernet/ti/Kconfig
>>> +++ b/drivers/net/ethernet/ti/Kconfig
>>> @@ -186,6 +186,7 @@ config CPMAC
>>>   config TI_ICSSG_PRUETH
>>>       tristate "TI Gigabit PRU Ethernet driver"
>>>       select PHYLIB
>>> +    select TI_ICSS_IEP
>>
>> Why not save selecting this until you add its use in the ICSSG_PRUETH driver in
>> the next patch.
>>
> 
> The next patch is only adding changes to icssg-prueth .c /.h files. This patch
> is adding changes to Kconfig and the Makefile. To keep it that way selecting
> this is added in this patch. No worries, I will move this to next patch.
> 
>> [...]
>>
>>> +
>>> +static u32 icss_iep_readl(struct icss_iep *iep, int reg)
>>> +{
>>> +    return readl(iep->base + iep->plat_data->reg_offs[reg]);
>>> +}
>>
>> Do these one line functions really add anything? Actually why
>> not use the regmap you have here.
> 
> These one line functions are not really adding anything but they are acting as
> a wrapper around readl /writel and providing some sort of encapsulation as
> directly calling readl will result in a little complicated code.
> 
> /* WIth One line function */
> ts_lo = icss_iep_readl(iep, ICSS_IEP_COUNT_REG0);
> 
> /* Without one line function */
> ts_lo = readl(iep->base, iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG0]);
> 
> Previously regmap was used in this driver. But in older commit [1] in
> 5.10-ti-linux-kernel (Before I picked the driver for upstream) it got changed
> to readl / writel stating that regmap_read / write is too slow. IEP is time
> sensitive and needs faster read and write, probably because of this they
> changed it.

This is true. Can you please pick the exact reasoning mentioned there
and put it as a comment where you use read/writel() instead of regmap()
so we don't forget this and accidentally switch it back to regmap()
in the future.

I think this is only required for read/write to the IEP count register and
SYNC_CTRL_REG when doing gettime/settime.

-- 
cheers,
-roger

