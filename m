Return-Path: <netdev+bounces-32371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2495C79723B
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 14:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6877B2814F5
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 12:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97B8569E;
	Thu,  7 Sep 2023 12:20:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A65363A3
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 12:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0889BC32785;
	Thu,  7 Sep 2023 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694089210;
	bh=/knj0cY9pD418AkfsvYT3H54+KzQoQzdGurHAgnQcsQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j3YQcBv+nTe637rwvoD9/L7K8cUFoWNS1cRLESGlkHLvhVBpU9nC/hPjHDr0/cNP4
	 qGtSeu4IdTAM/K2tZ+pcQw7MqLbujx3gBTemGFImJYF2XNzou/WX7y4tdy/PG3zN0w
	 77UStc42wrE6d8sfgn6oxKpOQBoi44KB0kn2m+cw7si0OLLzPpDxd79zxYk1a3Bks6
	 bt/9zVQkskhX18x8ibrskrsCb0ONjbiMmFV7wUYAIlwnz42+OavIuwfXpinjL4eLmP
	 iuXTkZExF+eyuEwjg4vPc72jA0Ip2GwjoyaQv6zoX5vd3z+EaiGWsFbkq5dzqhmG/y
	 1EvMSi8AuIe5w==
Message-ID: <5f762b3b-c4f2-d0e8-aba7-2cd184465d12@kernel.org>
Date: Thu, 7 Sep 2023 15:20:04 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next 0/2] Add Half Duplex support for ICSSG Driver
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
References: <20230830113134.1226970-1-danishanwar@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230830113134.1226970-1-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/08/2023 14:31, MD Danish Anwar wrote:
> This series adds support for half duplex operation for ICSSG driver.
> 
> In order to support half-duplex operation at 10M and 100M link speeds, the
> PHY collision detection signal (COL) should be routed to ICSSG
> GPIO pin (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal
> and apply the CSMA/CD algorithm applicable for half duplex operation. A DT
> property, "ti,half-duplex-capable" is introduced for this purpose in the
> first patch of the series. If board has PHY COL pin conencted to
> PRGx_PRU1_GPIO10, this DT property can be added to eth node of ICSSG, MII
> port to support half duplex operation at that port.
> 
> Second patch of the series configures driver to support half-duplex
> operation if the DT property "ti,half-duplex-capable" is enabled.
> 
> This series depends on [1] which is posted as RFC.
> 
> [1] https://lore.kernel.org/all/20230830110847.1219515-1-danishanwar@ti.com/
> 
> Thanks and Regards,
> Md Danish Anwar
> 
> MD Danish Anwar (2):
>   dt-bindings: net: Add documentation for Half duplex support.
>   net: ti: icssg-prueth: Add support for half duplex operation
> 
>  .../bindings/net/ti,icssg-prueth.yaml           |  7 +++++++
>  drivers/net/ethernet/ti/icssg/icssg_config.c    | 14 ++++++++++++++
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c    | 17 +++++++++++++++--
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h    |  2 ++
>  4 files changed, 38 insertions(+), 2 deletions(-)
> 

For this series:

Reviewed-by: Roger Quadros <rogerq@kernel.org>

