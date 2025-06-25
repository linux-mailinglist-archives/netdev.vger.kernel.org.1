Return-Path: <netdev+bounces-201309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1636CAE8E0B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 21:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DCD1C26BB1
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 19:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD78B2E0B6F;
	Wed, 25 Jun 2025 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBIWj6da"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D32E0B6C;
	Wed, 25 Jun 2025 19:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878396; cv=none; b=KN28uGRkk5zcseMr3hl1nc4OREw8aTxPlYDlBZz2pfh6EvWmQmiDVZJnRToHlsuauFNvfbSNR2brUDOEOPMMsAfXZKJMpwqHmLC8fsMN+cycwJhFM/H8n2panykWk4AgZJrP5ER1bMGMO3DjBraASw+Wbbi6e8jH7LzL8yRhuc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878396; c=relaxed/simple;
	bh=mt41Fb0q1YhHKfjDtHyYRotEsd67rfLrbLZk+qxV9gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiQYNa3IGMe3HJijgbaYS9Ycp7VsM7Jc7DlCYn3VNyOt/oVyyNEAIddXsGxaDpIIE7QyuvGwPhe7xQ+JTXYrTduwberrUyk0bultiiBzBYXYu9jYeWtejLE0l2A9e3P18v9RZrrzzNMHSDqXtHEDP5koOXG5mrkXMwtL0stkzMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBIWj6da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF815C4CEEA;
	Wed, 25 Jun 2025 19:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750878395;
	bh=mt41Fb0q1YhHKfjDtHyYRotEsd67rfLrbLZk+qxV9gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBIWj6daJ2/j7eMRSz1WZoK1fQzvuFIbKA3ujFVOwzwFQgQUFqRzb4VcI/0TzmRi1
	 MQbK8UqQ6+wrYd03mjrTGw5QunO6u3fJv7XIqGo4REHjwJVmoC4FsonsRF+f49FB1o
	 Qcc9662DGCUZjVJc+4CmJZ+ZvmbuAgOidrrSsdfAoNBaMcfXgEgtngQKc+DbgoO4f4
	 HDGvy/v3iBv6jZH8P0oU4gs5s5LZe+3SJ2X0lgDObx2FLzYmT3dHpaQE5LqDWvwkKy
	 iMrGDmDFZyR9l7ask/n02TT40PPBSKyfUaJx6tbPFoFg13B7F0d0r+7RXB+Ubv0BJP
	 lNCjQgJv5rH1A==
Date: Wed, 25 Jun 2025 14:06:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: ieee802154: Convert at86rf230.txt
 yaml format
Message-ID: <175087839356.2050766.5864325742697685736.robh@kernel.org>
References: <20250606155638.1355908-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606155638.1355908-1-Frank.Li@nxp.com>


On Fri, 06 Jun 2025 11:56:33 -0400, Frank Li wrote:
> Convert at86rf230.txt yaml format.
> 
> Additional changes:
> - Add ref to spi-peripheral-props.yaml.
> - Add parent spi node in examples.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v3
> - add maximum: 0xf for xtal-trim
> - drop 'u8 value ...' for xtal-trim's description
> 
> change in v2
> - xtal-trim to uint8
> ---
>  .../bindings/net/ieee802154/at86rf230.txt     | 27 --------
>  .../net/ieee802154/atmel,at86rf233.yaml       | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
>  create mode 100644 Documentation/devicetree/bindings/net/ieee802154/atmel,at86rf233.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


