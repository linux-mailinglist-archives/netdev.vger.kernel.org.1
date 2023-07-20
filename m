Return-Path: <netdev+bounces-19634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC6E75B82C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258A8281FB7
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119F61BE64;
	Thu, 20 Jul 2023 19:41:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6C1BE63
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 19:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B477C433C7;
	Thu, 20 Jul 2023 19:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689882073;
	bh=Tjl37HbgJReCne8I9oWLUfLMWMECxjVNTak6ZTPLD0k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lRLa1IQ2fIZXFzrU2LGJtKathN3AJ8fJkaqg5gRtECfS38ZteMIEE4cy7vCYCLa1C
	 909IPOW4fQ0PhUH7THSkWlqiJVpG1JRQValVj7jYN+CCvOsvldsUC5Ghu31NS8qPqT
	 a3jSc3h4GrV3Jx61+Qfr5ALLtkruufVQDLOTvraN7NQcpRlMY1x5mhgb3Bxwm/jHS2
	 Ed7YlxnTp/sGlPLYpkVQojT63Gpm9Rg/dB8VaRKg7S0+GJUotOmukuQaooWDGVgss9
	 p4spWm6L3uyhs+om/T20UtcdwMJbMcDDYNnKOfYS/SBeOCX4+vcETKAEk/Y6w0lR1m
	 uJWw5YOZlZnGw==
Message-ID: <2c9f7a88-1a99-73ce-e924-0effef399719@kernel.org>
Date: Thu, 20 Jul 2023 22:41:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXTERNAL] Re: [PATCH v10 2/2] net: ti: icssg-prueth: Add ICSSG
 ethernet driver
Content-Language: en-US
To: Md Danish Anwar <a0501179@ti.com>, Jakub Kicinski <kuba@kernel.org>,
 MD Danish Anwar <danishanwar@ti.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Simon Horman <simon.horman@corigine.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230719082755.3399424-1-danishanwar@ti.com>
 <20230719082755.3399424-3-danishanwar@ti.com>
 <20230719213543.0380e13e@kernel.org>
 <17cd1e70-73bc-78d5-7e9d-7b133d6f464b@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <17cd1e70-73bc-78d5-7e9d-7b133d6f464b@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Danish,

On 20/07/2023 14:42, Md Danish Anwar wrote:
> Hi Jakub,
> 
> On 20/07/23 10:05 am, Jakub Kicinski wrote:
>> The patch is too big to review.
>>
>> Please break it apart separating into individual features, targeting
>> around 10 patches in the series. That will make it easier for reviewers
>> to take a look at the features in which they have expertise.
>>
> 
> Sure Jakub. I will try to break this patch in multiple patches as below.
> 
> Patch 1: Introduce Firmware mapping for the driver (icss_switch_map.h)
> 
> Patch 2: Introduce mii helper APIs. (icssg_mii_rt.h and icssg_mii_cfg.h). This
> patch will also introduce basic prueth and emac structures in icssg_prueth.h as
> these structures will be used by the helper APIs.
> 
> Patch 3: Introduce firmware configuration and classification APIs.
> (icssg_classifier.c, icssg_config.h and icssg_config.c)
> 
> Patch 4: Introduce APIs for ICSSG Queues (icssg_queues.c)
> 
> Patch 5: Introduce ICSSG Ethernet driver. (icssg_prueth.c and icssg_prueth.h)
> This patch will enable the driver and basic functionality can work after this
> patch. This patch will be using all the APIs introduced earlier. This patch
> will also include Kconfig and Makefile changes.

DT binding documentation patch can come here.

> 
> Patch 6: Enable standard statistics via ndo_get_stats64
> 
> Patch 7: Introduce ethtool ops for ICSSG
> 
> Patch 8: Introduce power management support (suspend / resume APIs)
> 

<snip>

-- 
cheers,
-roger

