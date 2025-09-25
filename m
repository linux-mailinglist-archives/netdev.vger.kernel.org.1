Return-Path: <netdev+bounces-226432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3952ABA0445
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE2F3B7BC5
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9557305068;
	Thu, 25 Sep 2025 15:10:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC85305050
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813053; cv=none; b=IizkshqeRSWAEkH5I3ugsUmqXvHS7GltMcWDwJ2oT2/BjSait64XuCL6WMXl7BOsyKRAus42xnyH/dd4B3IWRnG0qCnKoB7cBE0PBg1N6tx3bZNcQA8dovQ8iIGfMypaXYnUVH+NavXN38cKGTqfmEXvaNMTG/APMpLhMA4g5ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813053; c=relaxed/simple;
	bh=OL7jojLeKQE6iSoWJ81v+KSjAjTKYwtKJwHgcWiKL+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/SpsPWFuxzmnKvRJyTQhbSZ4pDmaCxMC+jAo8xqn+GDxTrb9Kj6xTHoZJSvl8mq7MsFuyvcM/P6S7jqK8ERCTHxVLUmMXYDb+N39A4bTBqrcg9LWXKHFLwIm3VlKA+RJPLeYcFY5YRMI5hBOvf+n660VmQ9cEG9VhNdZ7kPWz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1v1ncM-0003PJ-O1; Thu, 25 Sep 2025 17:10:46 +0200
Message-ID: <3a0ba202-23e5-41d1-8b0c-5501a6d73bb4@pengutronix.de>
Date: Thu, 25 Sep 2025 17:10:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Mainline Protonic PRT8ML board
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-sound@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 imx@lists.linux.dev, Vladimir Oltean <olteanv@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Conor Dooley
 <conor+dt@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 David Jander <david@protonic.nl>, Lucas Stach <l.stach@pengutronix.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20250924-imx8mp-prt8ml-v3-0-f498d7f71a94@pengutronix.de>
 <175876283065.3268812.10851892974485151512.robh@kernel.org>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <175876283065.3268812.10851892974485151512.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi,

Regarding the warnings:

On 2025-09-25 03:18, Rob Herring (Arm) wrote:
> arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: codec@11 (asahi-kasei,ak4458): '#sound-dai-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/sound/asahi-kasei,ak4458.yaml#

Updated bindings have already been applied to broonie/sound for-next.

> arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e10000 (fsl,imx8mp-isp): 'power-domain-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
> arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e10000 (fsl,imx8mp-isp): power-domains: [[77, 6], [77, 1]] is too long
> 	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
> arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e20000 (fsl,imx8mp-isp): 'power-domain-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
> arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e20000 (fsl,imx8mp-isp): power-domains: [[77, 6], [77, 4]] is too long
> 	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#

This is an issue in imx8mp.dtsi, introduced in commit 9c60bc7f10d0
("arm64: dts: imx8mp: Add pclk clock and second power domain for the
ISP").

Regards,
Jonas

