Return-Path: <netdev+bounces-32370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8495797237
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 14:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A6E281510
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 12:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1EF569E;
	Thu,  7 Sep 2023 12:16:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149C5698
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 12:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B19C32784;
	Thu,  7 Sep 2023 12:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694089010;
	bh=bZ4uLbhRoZOPWAEmsqNOnRz9+u/PupzleFxvX2AobWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ghoNWzMkYYeE0rUfRIj004rJCEncEEyUTO5LYa1DBfOsgluQFHHealltp3/Hx4K/E
	 0G4AW80xlHB+UBd84Nn90nFRRfwu5fmmGkRLtGFh/hBwrnXuK+T0HRJ7CrUvY/q+Pk
	 aSF7LCNEJncPplg3MIIExgCXiPYh6IW8QWuU0F7Ip+BfAu9OKkZYjgdZWIHRc9x05K
	 U6qhyt85rBUkEgOfI9ecb9ZMmt6s3XUVgP9CC2N+xuoboYyD5w8i9GAR2wDt0rPFwH
	 EnN16SRpz+J/qjpTxFMyR9Lf1RHMXFC0Lz6Tv1PSVm1Cac1QL+Ll4kMQ5Tx6g1lf/9
	 unufpWzVTbKAw==
Message-ID: <f4431158-c177-8d09-4125-3fb01062f1fd@kernel.org>
Date: Thu, 7 Sep 2023 15:16:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next 1/2] dt-bindings: net: Add documentation for
 Half duplex support.
Content-Language: en-US
To: Md Danish Anwar <a0501179@ti.com>, Rob Herring <robh@kernel.org>,
 MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
References: <20230830113134.1226970-1-danishanwar@ti.com>
 <20230830113134.1226970-2-danishanwar@ti.com>
 <20230831181636.GA2484338-robh@kernel.org>
 <90669794-2fc1-bff1-104b-cf1daa2e9998@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <90669794-2fc1-bff1-104b-cf1daa2e9998@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/09/2023 08:21, Md Danish Anwar wrote:
> Hi Rob,
> 
> On 31/08/23 11:46 pm, Rob Herring wrote:
>> On Wed, Aug 30, 2023 at 05:01:33PM +0530, MD Danish Anwar wrote:
>>> In order to support half-duplex operation at 10M and 100M link speeds, the
>>> PHY collision detection signal (COL) should be routed to ICSSG
>>> GPIO pin (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal
>>> and apply the CSMA/CD algorithm applicable for half duplex operation. A DT
>>> property, "ti,half-duplex-capable" is introduced for this purpose. If
>>> board has PHY COL pin conencted to PRGx_PRU1_GPIO10, this DT property can
>>> be added to eth node of ICSSG, MII port to support half duplex operation at
>>> that port.
>>
>> I take it the GPIO here is not visble to the OS and that's why it's not 
>> described in DT?
>>  
> 
> Yes the GPIO here is not visible in the OS and we need to indicate whether the
> PHY COL signal is routed to PRGx_PRU0/1_GPI10 pin or not by setting the
> property "ti,half-duplex-capable" as true.
> 
>>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>>> index 13371159515a..59da9aeaee7e 100644
>>> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>>> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>>> @@ -107,6 +107,13 @@ properties:
>>>                phandle to system controller node and register offset
>>>                to ICSSG control register for RGMII transmit delay
>>>  
>>> +          ti,half-duplex-capable:
>>
>> capable or...
>>
>>> +            type: boolean
>>> +            description:
>>> +              Enable half duplex operation on ICSSG MII port. This requires
>>
>> enable the mode?
>>
> 
> I think capable is good here. The property "ti,half-duplex-capable" indicates
> that the board is capable of half duplex operation. This doesn't necessarily
> means we have to enable the half duplex mode. The user can modify the duplex
> settings from ethtool and enable / disable is controlled by the user. This
> property basically let's the driver know that it can support half duplex
> operations and when user enables half duplex mode through ethtool, the driver
> can do the necessary configurations.
> 
> When this property is false, half duplex is not supported. If user still wants
> to change the duplex mode, it will get an error saying half duplex is not
> supported.
> 
> So the property "ti,half-duplex-capable" let's the driver know whether half
> duplex is supported or not. Enable / disable is controlled by user through ethtool.
> 
>> Maybe too late if it's already been assumed not supported, but shouldn't 
>> supporting half duplex be the default? I guess half duplex isn't too 
>> common any more.
>>
> 
> Unfortunately ICSSG doesn't support half duplex by default. Routing the PHY COL
> signal is necessary.

But the half-duplex advertising is always enabled by default. Whether it gets
used or not will depend on negotiation with link partner.

That's why you had to explicitly disable them in your next patch with

+	if (!emac->half_duplex) {
+		dev_dbg(prueth->dev, "half duplex mode is not supported\n");
+		phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
+		phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
+	}

-- 
cheers,
-roger

