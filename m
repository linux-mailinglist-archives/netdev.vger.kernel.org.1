Return-Path: <netdev+bounces-19570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AAA75B3B0
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7C2281EE4
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C2118C32;
	Thu, 20 Jul 2023 16:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1518B11
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 16:00:25 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF49BCE;
	Thu, 20 Jul 2023 09:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V11+xyj3JzOnQEprdsM1XI5W3c+hh54wJgw0Bk25suE=; b=QG63nbQFGlzHgtHwh3WrtbNx7F
	MUwBNdm4r22BBGbRq52zsyKJHPvd+oyrFmC4T6TcbhpTywuPxTC+ixkFjFGNuuKgL3VTPUMeUYHJr
	CO5O+Xm4fSlwQ+mEfwwfzHI1bUzv7RllQz+qjEPrzMuzUcHBYoZxhx+nYtmnJCmsJqx0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qMW4d-001ozN-AV; Thu, 20 Jul 2023 18:00:15 +0200
Date: Thu, 20 Jul 2023 18:00:15 +0200
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
Subject: Re: [PATCH v5 1/2] dt-bindings: net: motorcomm: Add pad driver
 strength cfg
Message-ID: <0cd8b154-d255-4c16-b76d-9d3b036f3093@lunn.ch>
References: <20230720111509.21843-1-samin.guo@starfivetech.com>
 <20230720111509.21843-2-samin.guo@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720111509.21843-2-samin.guo@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +  motorcomm,rx-clk-drv-microamp:
> +    description: |
> +      drive strength of rx_clk rgmii pad.
> +      The YT8531 RGMII LDO voltage supports 1.8V/3.3V, and the LDO voltage can
> +      be configured with hardware pull-up resistors to match the SOC voltage
> +      (usually 1.8V).
> +      The software can read the registers to obtain the LDO voltage and configure
> +      the legal drive strength(curren).
> +      =====================================================
> +      | voltage |        curren Available (uA)            |

current has a t.

> +      =====================================================
> +      | voltage |        curren Available (uA)            |

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

