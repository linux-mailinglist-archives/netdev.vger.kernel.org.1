Return-Path: <netdev+bounces-19572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7EF75B3B6
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BDC281EAB
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222E918C35;
	Thu, 20 Jul 2023 16:01:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621118B03
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 16:01:22 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97321B3;
	Thu, 20 Jul 2023 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b/Q5LH8Vx4RXXAUf5NvptwW1+upppvK6QOM9s4GLMbc=; b=L6rwvBSArzeKLXQhRy2LmZ3aku
	BLGn1d8hcuCWTJU1aNIw929TxeA42xnWhAey4w51M6KE79VTxdy9sVTAKPB+vQDQxEqs9/iyeqrbs
	fvjcvrPY/KbDpYQDxPV9O778EGd5G3S8WcOYXLrbHMiClkCeWKbw0ByFq5J+eI91hCVA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qMW5f-001p0L-R2; Thu, 20 Jul 2023 18:01:19 +0200
Date: Thu, 20 Jul 2023 18:01:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Samin Guo <samin.guo@starfivetech.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
	Frank <Frank.Sae@motor-comm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: Re: [PATCH v5 2/2] net: phy: motorcomm: Add pad drive strength cfg
 support
Message-ID: <4081af9e-650f-433e-a520-b5417cabe695@lunn.ch>
References: <20230720111509.21843-1-samin.guo@starfivetech.com>
 <20230720111509.21843-3-samin.guo@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720111509.21843-3-samin.guo@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 07:15:09PM +0800, Samin Guo wrote:
> The motorcomm phy (YT8531) supports the ability to adjust the drive
> strength of the rx_clk/rx_data, and the default strength may not be
> suitable for all boards. So add configurable options to better match
> the boards.(e.g. StarFive VisionFive 2)
> 
> When we configure the drive strength, we need to read the current
> LDO voltage value to ensure that it is a legal value at that LDO
> voltage.
> 
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

