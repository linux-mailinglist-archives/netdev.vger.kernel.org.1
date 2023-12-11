Return-Path: <netdev+bounces-55972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0192880D01D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0770B1C212E1
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700144BABE;
	Mon, 11 Dec 2023 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O66Rya1C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7CCBF;
	Mon, 11 Dec 2023 07:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wVEjEb06rD+lG6dnUzenVA4WNOv1EJB9eXPQT0PIboU=; b=O66Rya1CBNfxt3AjlpLbQtJ4WS
	5fsygvNy28wdoUQC5ZbwupD/G6B2rP+28++H2zukRXy/VAMRx7nFuUkbuULooa0UQ918+/RjAxgR8
	e00JQYlPo21OLubrjy7m/z4IWi2/jcz/lbHjX5y3V3adslYgTwRFp66XMjQiiVbo01Bg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rCibk-002dU2-K9; Mon, 11 Dec 2023 16:54:12 +0100
Date: Mon, 11 Dec 2023 16:54:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] dt-bindings: Document QCA808x PHYs
Message-ID: <74b7fc4f-88d2-41c0-8d98-6530f0fc2d70@lunn.ch>
References: <20231209014828.28194-1-ansuelsmth@gmail.com>
 <242759d9-327d-4fde-b2a0-24566cf5bf25@lunn.ch>
 <65772f36.050a0220.678b6.ef84@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65772f36.050a0220.678b6.ef84@mx.google.com>

> Mhhh with a generic property and LED core or phylib handling it... How
> it would work applying that setting on PHY side?

Add a .led_set_polarity callback to the PHY driver structure?

Take a look at other LED drivers. Does anything similar already exist?
It is unlikely that PHYs are the only sort of LED to have a polarity.

   Andrew

