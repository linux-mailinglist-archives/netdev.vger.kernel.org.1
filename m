Return-Path: <netdev+bounces-55913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1BE80CCCD
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4A91F2109A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758D8482F5;
	Mon, 11 Dec 2023 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eraxT1UA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAC34C3B;
	Mon, 11 Dec 2023 06:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Oq7uN0UA4e29OD1T/vJ5LTgmVczpGSvVwmcHIE/xouM=; b=eraxT1UAAa6Sj6qX+sOaBE8kHv
	fce9Pos6BoTdmvZDq+hOl4chP+zWCLsbnvjLCgt6qaMBnYfO3mHSY/2WcMU7Q9qZdHAyLKebQ8nVn
	52Vc0fgtZKOmHXVqHDAxJA1qV94bRxsow/e/230BJgXz3O2lMmI6DnyZU6SjtWZvfKIQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rCgsq-002coy-7j; Mon, 11 Dec 2023 15:03:44 +0100
Date: Mon, 11 Dec 2023 15:03:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: tsbogend@alpha.franken.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
	chenhuacai@loongson.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v1 net 1/3] stmmac: dwmac-loongson: Make sure MDIO is
 initialized before use
Message-ID: <0fb4ecea-9db9-4cea-b8f0-3f3b210b1ced@lunn.ch>
References: <cover.1702289232.git.siyanteng@loongson.cn>
 <b6059c83049c7a4c97b2c9dfd348b198a8ec1b14.1702289232.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6059c83049c7a4c97b2c9dfd348b198a8ec1b14.1702289232.git.siyanteng@loongson.cn>

On Mon, Dec 11, 2023 at 06:33:11PM +0800, Yanteng Si wrote:
> Generic code will use mdio. If it is not initialized before use,
> the kernel will Oops.
> 
> Fixes: 30bba69d7db4 ("stmmac: pci: Add dwmac support for Loongson")
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

