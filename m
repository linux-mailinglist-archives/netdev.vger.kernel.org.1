Return-Path: <netdev+bounces-43693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EB47D441C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 02:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15EE1C20AEE
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 00:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B8F1855;
	Tue, 24 Oct 2023 00:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Nh8j3vef"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BA14C95;
	Tue, 24 Oct 2023 00:37:39 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9551F9F;
	Mon, 23 Oct 2023 17:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IbkFeQ5G28rXN3aE/XpDlcgQ2XTNatnb7axQWP+p/D0=; b=Nh8j3vefZI+3csLTxryBpWR3k8
	cKuTeLWPVL7484mjPb+3/eKHtHWejpfh7sr22uTbdAnBfcTmUP6cI4ztdJzb4XhV/smisVvooS1it
	e+JpeC2TLh5Zd+zPaVru99f3tiMalghv8bZ52x9bbemWVACou7LnHFmp2NJ0BgVkAjwA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qv5QC-0001c2-Iw; Tue, 24 Oct 2023 02:37:24 +0200
Date: Tue, 24 Oct 2023 02:37:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, steen.hegelund@microchip.com, rdunlap@infradead.org,
	horms@kernel.org, casper.casan@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, horatiu.vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 4/9] dt-bindings: net: add OPEN Alliance
 10BASE-T1x MAC-PHY Serial Interface
Message-ID: <fd7f7d62-7921-4aac-9359-ff09449fd20c@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-5-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023154649.45931-5-Parthiban.Veerasooran@microchip.com>

> +  oa-cps:
> +    maxItems: 1
> +    description:
> +      Chunk Payload Size. Configures the data chunk payload size to 2^N,
> +      where N is the value of this bitfield. The minimum possible data
> +      chunk payload size is 8 bytes or N = 3. The default data chunk
> +      payload size is 64 bytes, or N = 6. The minimum supported data chunk
> +      payload size for this MAC-PHY device is indicated in the CPSMIN
> +      field of the CAPABILITY register. Valid values for this parameter
> +      are 8, 16, 32 and 64. All other values are reserved.
> +
> +  oa-txcte:
> +    maxItems: 1
> +    description:
> +      Transmit Cut-Through Enable. When supported by this MAC-PHY device,
> +      this bit enables the cut-through mode of frame transfer through the
> +      MAC-PHY device from the SPI host to the network.
> +
> +  oa-rxcte:
> +    maxItems: 1
> +    description:
> +      Receive Cut-Through Enable. When supported by this MAC-PHY device,
> +      this bit enables the cut-through mode of frame transfer through the
> +      MAC-PHY device from the network to the SPI host.
> +
> +  oa-prote:
> +    maxItems: 1
> +    description:
> +      Control data read/write Protection Enable. When set, all control
> +      data written to and read from the MAC-PHY will be transferred with
> +      its complement for detection of bit errors.

Device tree described hardware. Its not supposed to be used to
describe configuration. So it is not clear to me if any of these are
valid in DT.

It seems to me, the amount of control transfers should be very small
compared to data transfers. So why not just set protection enable to
be true?

What is the effect of chunk payload size ? Is there a reason to use a
lower value than the default 64? I assume smaller sizes make data
transfer more expensive, since you need more DMA setup and completion
handing etc.

An Ethernet driver is allowed to have driver specific private
flags. See ethtool(1) --show-priv-flags and --set-priv-flags You could
maybe use these to configure cut through?

      Andrew



