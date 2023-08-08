Return-Path: <netdev+bounces-25272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFF6773A1C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 14:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC512817A1
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 12:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D34100AC;
	Tue,  8 Aug 2023 12:22:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26348100A6
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 12:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC44C433C8;
	Tue,  8 Aug 2023 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691497376;
	bh=dhLlrUwCQzvrRjQ5imxEgR6Ov8s1gSR9MYGmH4eHroU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=inb2pUnlNEEJgy4+g5toDu6y1uAJzpYq7fGl7Yj5xlru9xEmVuqqiIgunYaYHPZU+
	 mTXTJzGyG32X+d0k4NQAWhwxfMhLY4lxHSGNVN39C1cryrCRDtLExinq9sRWFreoU8
	 Z1fuCZaj5xrM3r+I1Rsr0kiR+PHPeFLJzGQMvnED75JEkphMueQJ2ZXogCRisv/bXU
	 BqtytwaE30LlME+Xoq4BDRh/wq/wydL5Y/MBr5khnGgZR9LjKxNr6xkNAgWcwTkb40
	 Fi6pxDrjA6iYVRzTgzuUdAQd7a6WHwNyuY9eobLIp1kI0QA38nvgyCCipraZrbqPNq
	 L34Q36eKS0Obg==
Message-ID: <529218f6-2871-79a2-42bb-8f7886ae12c3@kernel.org>
Date: Tue, 8 Aug 2023 15:22:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/5] Introduce IEP driver and packet
 timestamping support
Content-Language: en-US
To: Md Danish Anwar <a0501179@ti.com>, Conor Dooley <conor@kernel.org>,
 MD Danish Anwar <danishanwar@ti.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Simon Horman <simon.horman@corigine.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20230807110048.2611456-1-danishanwar@ti.com>
 <20230808-unnerving-press-7b61f9c521dc@spud>
 <1c8e5369-648e-98cb-cb14-08d700a38283@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <1c8e5369-648e-98cb-cb14-08d700a38283@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/08/2023 15:18, Md Danish Anwar wrote:
> On 08/08/23 5:38 pm, Conor Dooley wrote:
>> On Mon, Aug 07, 2023 at 04:30:43PM +0530, MD Danish Anwar wrote:
>>> This series introduces Industrial Ethernet Peripheral (IEP) driver to
>>> support timestamping of ethernet packets and thus support PTP and PPS
>>> for PRU ICSSG ethernet ports.
>>>
>>> This series also adds 10M full duplex support for ICSSG ethernet driver.
>>>
>>> There are two IEP instances. IEP0 is used for packet timestamping while IEP1
>>> is used for 10M full duplex support.
>>>
>>> This is v2 of the series [v1]. It addresses comments made on [v1].
>>> This series is based on linux-next(#next-20230807). 
>>>
>>> Changes from v1 to v2:
>>> *) Addressed Simon's comment to fix reverse xmas tree declaration. Some APIs
>>>    in patch 3 and 4 were not following reverse xmas tree variable declaration.
>>>    Fixed it in this version.
>>> *) Addressed Conor's comments and removed unsupported SoCs from compatible
>>>    comment in patch 1. 
>>
>> I'm sorry I missed responding there before you sent v2, it was a bank
>> holiday yesterday. I'm curious why you removed them, rather than just
>> added them with a fallback to the ti,am654-icss-iep compatible, given
>> your comment that "the same compatible currently works for all these
>> 3 SoCs".
> 
> I removed them as currently the driver is being upstreamed only for AM654x,
> once I start up-streaming the ICSSG driver for AM64 and any other SoC. I will
> add them here. If at that time we are still using same compatible, then I will
> modify the comment otherwise add new compatible.
> 
> As of now, I don't see the need of adding other SoCs in iep binding as IEP
> driver up-streaming is only planned for AM654x as of now.

But, is there any difference in IEP hardware/driver for the other SoCs?
AFAIK the same IP is used on all SoCs.

If there is no hardware/code change then we don't need to introduce a new compatible.
The comment for all SoCs can already be there right from the start.

-- 
cheers,
-roger

