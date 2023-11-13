Return-Path: <netdev+bounces-47469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6DA7EA59D
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB88B1C20950
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB0C2D624;
	Mon, 13 Nov 2023 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rHpLefQR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A2F224D9;
	Mon, 13 Nov 2023 21:51:28 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE1AD50;
	Mon, 13 Nov 2023 13:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3aT7QK8o88vrmPUcB7VTL9Qnh9dcOMl39JPfA9/XTkg=; b=rHpLefQRGvxmtGG7XJUFflr0Vc
	sFcRHeFR0PvoOer0FlGCSfcWVkV6ShOZ0wFq932rCGTM/iobrbK46M/W4NJTwLUYt8ZxXbdr9sFlh
	/0mPACbxIehp1IpxkHgSKdpsBLRFsHn0ynE9EP5oKZSnNQqCoHZou/llIMnX6O425Qks=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r2epy-0006ik-1d; Mon, 13 Nov 2023 22:51:18 +0100
Date: Mon, 13 Nov 2023 22:51:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH net-next] dt-bindings: net: snps,dwmac: Do not make
 'phy-mode' required
Message-ID: <43d176e2-d95f-40dd-8e42-8d7d5ed6492c@lunn.ch>
References: <20231113204052.43688-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113204052.43688-1-festevam@gmail.com>

On Mon, Nov 13, 2023 at 05:40:52PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> The property 'phy-connection-type' can also be used to describe
> the interface type between the Ethernet device and the Ethernet PHY
> device.
> 
> Mark 'phy-mode' as a non required property.

Hi Fabio

What does the driver actually require? Will it error out if neither is
provided?

Maybe we should be changing the condition that one or the other is
required?

	Andrew

