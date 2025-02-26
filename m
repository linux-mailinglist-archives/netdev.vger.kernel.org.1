Return-Path: <netdev+bounces-169725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE055A4562E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 08:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75B83A4976
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E030826A1BD;
	Wed, 26 Feb 2025 07:01:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5818326A1B6
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553318; cv=none; b=cZqjCFlrQAU0VPx6PKYyt7umeqqEIPZiODROHyb8omLBJ6rssdBSEQBJ6i8keN45bN21b0C2I0w8wJAYjwAZvkq/HtdDigc3ytkhJkJjea2d3O3vDN5GtxcFdw6dd/Dmvw7y+zxjjQWTKINe0bNG+dW8CjUvfviTicRz2QCS5mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553318; c=relaxed/simple;
	bh=2r5kCgFjlcqbLdfKsNvqCFsfvYadyfAOQs/dLrv4vys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oe9LRzdSN8/Rragbl3JLa9tQepLeGa/WvyDN+Kg99PwGe3Z0WX06/IVZrYy5utunlGn4K15fVfpmsQ+KomargCI4DXPDTedRSDGYxjLVomxe+KehZRw2ok/FY2ZASVhsIkoneRaS3eb4UDV/2QmoPLgoq0Pz6XQ3nXj8ZiLTgiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tnBQI-0004TO-Bu; Wed, 26 Feb 2025 08:01:38 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tnBQH-002uEE-0Y;
	Wed, 26 Feb 2025 08:01:37 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tnBQH-001TNf-0A;
	Wed, 26 Feb 2025 08:01:37 +0100
Date: Wed, 26 Feb 2025 08:01:37 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 0/3] Add support for Plymovent AQM board
Message-ID: <Z768USN3iYrnz84G@pengutronix.de>
References: <20250220090155.2937620-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220090155.2937620-1-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Alexandre,

Just wanted to check if there’s anything needed from my side for this
patch. Let me know if further input is required.

Best Regards,
Oleksij

On Thu, Feb 20, 2025 at 10:01:52AM +0100, Oleksij Rempel wrote:
> This patch series adds support for the Plymovent AQM board based on the
> STM32MP151C SoC. Additionally, the ICS-43432 device tree binding is
> converted to YAML to address a validation warning.
> 
> The ICS-43432 patch resolves one of the devicetree validation warnings.
> However, the false-positive warning:
> 
>   "audio-controller@44004000: port:endpoint: Unevaluated properties are
>    not allowed ('format' was unexpected)"
> 
> remains unresolved. The "format" property is required for proper
> functionality of this device.
> 
> Best regards,
> 
> Oleksij Rempel (3):
>   dt-bindings: sound: convert ICS-43432 binding to YAML
>   dt-bindings: arm: stm32: Add Plymovent AQM board
>   arm: dts: stm32: Add Plymovent AQM devicetree
> 
>  .../devicetree/bindings/arm/stm32/stm32.yaml  |   1 +
>  .../devicetree/bindings/sound/ics43432.txt    |  19 -
>  .../bindings/sound/invensense,ics43432.yaml   |  51 ++
>  arch/arm/boot/dts/st/Makefile                 |   1 +
>  arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts   | 669 ++++++++++++++++++
>  5 files changed, 722 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/ics43432.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/invensense,ics43432.yaml
>  create mode 100644 arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts
> 
> --
> 2.39.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

