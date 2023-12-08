Return-Path: <netdev+bounces-55303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B802F80A43F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 14:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2496DB20C8F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B5D1C6AF;
	Fri,  8 Dec 2023 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ger+sbf5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B42ED54;
	Fri,  8 Dec 2023 05:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZyIwn9UadV4oPIAt3Iw42rESNqNPVByooLrrQQomUoM=; b=ger+sbf5lz0mDcCnoWzUZY5VJZ
	331/0+XOXQ3TDJx6pxgjZkvNXuIOKiSXl0bnfVoKevRgfS8+oOwPYLaOzzBF9oSFaSCUI4q7beqp6
	xaWGCzgV5R4wM4L4ANuvF+WoOTV6mxqDlrWxirqTZbivw+YSflI8rsYmr9IKKRdU3oKw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rBagj-002PvD-33; Fri, 08 Dec 2023 14:14:41 +0100
Date: Fri, 8 Dec 2023 14:14:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH net-next v2] net: stmmac: don't create a MDIO bus if
 unnecessary
Message-ID: <9eddb32d-c798-4e1b-b0ea-c44d31cc29bf@lunn.ch>
References: <20231206-stmmac-no-mdio-node-v2-1-333cae49b1ca@redhat.com>
 <e64b14c3-4b80-4120-8cc4-9baa40cdcb75@lunn.ch>
 <nx2qggr3aget4t57qbosj6ya5ocq47t6w33ve5ycabs5mzvo7c@vctjvc5gip5d>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nx2qggr3aget4t57qbosj6ya5ocq47t6w33ve5ycabs5mzvo7c@vctjvc5gip5d>

> I know you said the standard is to make the MDIO bus unconditionally, but
> to me that feels like a waste, and describing say an empty MDIO bus
> (which would set the phy_mask for us eventually and not scan a
> bunch of phys, untested but I think that would work) seems like a bad
> description in the devicetree (I could definitely see describing an
> empty MDIO bus getting NACKed, but that's a guess).

DT describes the hardware. The MDIO bus master exists. So typically
the SoC .dtsi file would include it in the Ethernet node. At the SoC
level it is empty, unless there is an integrated PHY in the SoC. The
board .dts file then adds any PHYs to the node which the board
actually has.

So i doubt adding an empty MDIO node to the SoC .dtsi file will get
NACKed, it correctly describes the hardware.

	Andrew

