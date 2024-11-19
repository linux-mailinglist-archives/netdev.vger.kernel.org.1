Return-Path: <netdev+bounces-146122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C75889D20BD
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 08:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780BB1F25364
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 07:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F814E2E2;
	Tue, 19 Nov 2024 07:26:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423AF1EA90
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732001180; cv=none; b=cwsbOX7EAiAXBgIJ2JWCGMu0dgea1TrFMCHbOfSUzRqnQ9hQuOhzmmZ3QEZJsx8D37cKrVSWVOUYtD2/jRc1Y+qdN5NeMXdfXH/zX7H8wVTn9RXte/OjlF1kqfpA55utzNHkVSFUe7KZqtHUMRsAhfGIHKedHjhx0mqKHkejti0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732001180; c=relaxed/simple;
	bh=6tenO636zM6ZdOQEdZmbiy13W2dPeB/DyFYR0CWY8xo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JGXiDfGVrzvjqgYrjqOWdzDQK2PlHR43PDg6UiJUhUdZlwcLQsI4qYdO5lMTykvs6pFZVblqdI1rE7TM/rxFHDfVwEATAR1QRIqszRhg53DEzTyW/at6CQxnyBFSH79CWnepwZEtSBuikFL9eAIvvwhNY3MGPMBKkP3XPukWPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1tDIco-0003uQ-Py; Tue, 19 Nov 2024 08:26:14 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Dinh Nguyen <dinguyen@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Richard Cochran <richardcochran@gmail.com>,
  Michael Turquette <mturquette@baylibre.com>,  Stephen Boyd
 <sboyd@kernel.org>,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  linux-clk@vger.kernel.org,  kernel@pengutronix.de
Subject: Re: [PATCH 4/4] arm64: dts: agilex5: initial support for Arrow
 AXE5-Eagle
In-Reply-To: <3f55a225-7d09-486a-818f-307c1f1ba806@lunn.ch> (Andrew Lunn's
	message of "Wed, 30 Oct 2024 14:41:21 +0100")
References: <20241030-v6-12-topic-socfpga-agilex5-v1-0-b2b67780e60e@pengutronix.de>
	<20241030-v6-12-topic-socfpga-agilex5-v1-4-b2b67780e60e@pengutronix.de>
	<3f55a225-7d09-486a-818f-307c1f1ba806@lunn.ch>
User-Agent: mu4e 1.12.7; emacs 30.0.92
Date: Tue, 19 Nov 2024 08:26:13 +0100
Message-ID: <87iksj7kh6.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On 2024-10-30 at 14:41 +01, Andrew Lunn <andrew@lunn.ch> wrote:

> > +&gmac2 {
> > +	status = "okay";
> > +	phy-mode = "rgmii-id";
> > +	phy-handle = <&emac2_phy0>;
> > +
> > +	max-frame-size = <9000>;
> > +
> > +	mdio0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		compatible = "snps,dwmac-mdio";
> > +		emac2_phy0: ethernet-phy@1 {
> > +			reg = <0x1>;
> > +			adi,rx-internal-delay-ps = <2000>;
> > +			adi,tx-internal-delay-ps = <2000>;
>
> You have rgmii-id and 2000ps delay? Are these two lines actually
> required?

The binding states that these lines are for rgmii-id (and rgmii-rxid) mode, so why not?
Or am I misunderstanding and you mean setting the default values here is unnecessary?


Best regards,
Steffen

--
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

