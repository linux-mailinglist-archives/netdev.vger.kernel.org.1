Return-Path: <netdev+bounces-34085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4C27A2074
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 16:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40369282873
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3F910A36;
	Fri, 15 Sep 2023 14:05:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C6F10A31;
	Fri, 15 Sep 2023 14:05:23 +0000 (UTC)
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Sep 2023 07:05:20 PDT
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12052724;
	Fri, 15 Sep 2023 07:05:20 -0700 (PDT)
Date: Fri, 15 Sep 2023 15:56:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
	t=1694786268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=Ux5xZRDiOjiMz+hImc9jtfpq/h9ISkG9PxE6ObbWyIw=;
	b=IpNjFulOG7+2aIpsDgLTFB3n7bccNHyZIC2aJjCR7MV1ivDTikTmWi9LDt+4UocDr+xEEA
	QnxUg3mDCdux39o7o0g9NE5mcpoilHi4B2DvgzoVuQCBZWF2Jy3GBkfR53q7ZOQmKsl5JX
	sy9jsMSVZRMUQIONQyq2OvjrM6QO6jHQObK0nBMnwCfa5p/cAraDqW/nCnfJ14NgpAep9O
	J8iOP/8fMyn+/Ml1zS4Ldom/Fh9a7UGyhkMzxyOKc56hKB+MOa5mS2/JPknDsFL1AJ0OJT
	83IhqCAeZYREp5MfOj74yVaM8WxUm1kaerde9Cs988ac7qUdnKt7aPDwXiH+2w==
From: Alexander Dahl <ada@thorsis.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, steen.hegelund@microchip.com, rdunlap@infradead.org,
	horms@kernel.org, casper.casan@gmail.com, andrew@lunn.ch,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
	Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com,
	Alexandru Tachici <alexandru.tachici@analog.com>
Subject: Re: [RFC PATCH net-next 0/6] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <20230915-wizard-junction-b58f2aad64c5@ifak-system.com>
Mail-Followup-To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, steen.hegelund@microchip.com, rdunlap@infradead.org,
	horms@kernel.org, casper.casan@gmail.com, andrew@lunn.ch,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
	Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com,
	Alexandru Tachici <alexandru.tachici@analog.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Hello,

this is interesting, by chance I just looked at a chip claiming
similar features today, which already has a driver in kernel: Analog
Devices ADIN1110.

Am Fri, Sep 08, 2023 at 07:59:13PM +0530 schrieb Parthiban Veerasooran:
> This patch series contain the below updates,
> - Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
>   net/ethernet/oa_tc6.c.

So this implements the "10BASE-T1x MAC-PHY Serial Interface
Specification" which is Ethernet over SPI if I understand correctly?
The above mentioned chip claims do use the same interface and the same
standard.  How does its driver work then?  Do you add code for a thing
already present in the kernel or does the other driver do something
completely different and I just misunderstood?

Can the drivers for ADIN1110 and for LAN865X share code because they
use the same specified interface?  The patch set does not look like
it?

(Added the other driver author to Cc.)

Greets
Alex

> - Adds driver support for Microchip LAN8650/1 Rev.B0 10BASE-T1S MACPHY
>   Ethernet driver in the net/ethernet/microchip/lan865x.c.
> 
> Parthiban Veerasooran (6):
>   net: ethernet: implement OPEN Alliance control transaction interface
>   net: ethernet: add mac-phy interrupt support with reset complete
>     handling
>   net: ethernet: implement OA TC6 configuration function
>   net: ethernet: implement data transaction interface
>   microchip: lan865x: add driver support for Microchip's LAN865X MACPHY
>   microchip: lan865x: add device-tree support for Microchip's LAN865X
>     MACPHY
> 
>  .../bindings/net/microchip,lan865x.yaml       |  54 ++
>  Documentation/networking/oa-tc6-framework.rst | 231 +++++
>  MAINTAINERS                                   |  15 +
>  drivers/net/ethernet/microchip/Kconfig        |  10 +
>  drivers/net/ethernet/microchip/Makefile       |   3 +
>  drivers/net/ethernet/microchip/lan865x.c      | 589 +++++++++++++
>  drivers/net/ethernet/oa_tc6.c                 | 807 ++++++++++++++++++
>  include/linux/oa_tc6.h                        | 130 +++
>  8 files changed, 1839 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/microchip,lan865x.yaml
>  create mode 100644 Documentation/networking/oa-tc6-framework.rst
>  create mode 100644 drivers/net/ethernet/microchip/lan865x.c
>  create mode 100644 drivers/net/ethernet/oa_tc6.c
>  create mode 100644 include/linux/oa_tc6.h
> 
> -- 
> 2.34.1
> 
> 

