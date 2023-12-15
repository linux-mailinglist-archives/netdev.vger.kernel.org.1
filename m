Return-Path: <netdev+bounces-57893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAE68146D2
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D891C2314E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD10624A15;
	Fri, 15 Dec 2023 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tjU2DB2w"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE2A2C698;
	Fri, 15 Dec 2023 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dw5pweRuSlfkLQEGXeQwxUMxSRNgHjntBvvtfrs4n0U=; b=tjU2DB2wYK/Xi+QtyUhuecMtcx
	tb8gCMhXf938cdjBSYfDFdhO/eb63JT5oq0x1qXOJxIvjmIh5QVshJrEAvj5SdcBOZv+FjPEfiseu
	35m8pJlRxXWp4CqtXr90POk7+gRqRS5hppHTFRQa00efsej/eL8C7SUjsrZ4DIiS4WKE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rE6JR-0030zs-KA; Fri, 15 Dec 2023 12:25:01 +0100
Date: Fri, 15 Dec 2023 12:25:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk, corbet@lwn.net,
	p.zabel@pengutronix.de, f.fainelli@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
Message-ID: <4cb2bd57-f3d3-49f9-9c02-a922fd270572@lunn.ch>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <bdfba8a7-9197-4aae-a7f9-6075a375f60b@linaro.org>
 <c3391e33-e770-4c61-855e-d90e82b95f75@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3391e33-e770-4c61-855e-d90e82b95f75@quicinc.com>

> The "maxItems: 1" of the property resets is defined in ethernet-phy.yaml
> that is referenced by qca,ar803x.yaml, but i have 11 reset instances
> used for qca8084 PHY

11!?!?? Really? Why?

I assume the order and timer matters, otherwise why would you need
11? So the PHY driver needs to handle this, not phylib framework. So
you will be adding vendor properties to describe all 11 of them. So
ethernet-phy.yaml does not matter.

	Andrew

