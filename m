Return-Path: <netdev+bounces-162910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC74A28653
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 10:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5702B188974C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 09:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D890222A7EA;
	Wed,  5 Feb 2025 09:17:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2A205E3C
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738747059; cv=none; b=Ngw0qc9uFemLXiabr1JZZWLQMethZpzhI/wHPBKrZBlsUBEkbhpPW1ijbL+1xeDf9MJZ5RwR+Uf8AT9Kjvzg3vXAUZL+bphqHQ6ybph5uiL/Yg8z9PgvD8XruiW6EnY3P5s+D7Yv5RN4guCpu1I+l+lDi1u6n4OPZijr1VvGvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738747059; c=relaxed/simple;
	bh=o36WOV/0qnJVcad9POlQZ7XqwgrvW3fEwoOlVYAxl8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPVGoX+MeoQQiBy6jMo4za/pS97fpfv3kE40u+sK8id+3xbO6GZ2hmJ+aoC/iucq5KzO7ANZZl7XTAIXKgiaq+rKNXcweuGKT7zbFzqFNOMnR50L5baOxbNi79bmWNiEePfRHFPMGeBj92BKUkqmEiFnD+spUlckLmIVbFpRd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tfbX6-00012e-JN; Wed, 05 Feb 2025 10:17:20 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tfbX5-003buj-0t;
	Wed, 05 Feb 2025 10:17:19 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tfbX5-00FToZ-0V;
	Wed, 05 Feb 2025 10:17:19 +0100
Date: Wed, 5 Feb 2025 10:17:19 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 0/4] Add support for Priva E-Measuringbox board
Message-ID: <Z6Msn8AxgG_JTVNs@pengutronix.de>
References: <20250203085820.609176-1-o.rempel@pengutronix.de>
 <173859694746.2601652.11244969424431209545.robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <173859694746.2601652.11244969424431209545.robh@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Alexandre,

On Mon, Feb 03, 2025 at 09:37:06AM -0600, Rob Herring (Arm) wrote:
> 
> On Mon, 03 Feb 2025 09:58:16 +0100, Oleksij Rempel wrote:
> > This patch series introduces support for the Priva E-Measuringbox board
> > based on the ST STM32MP133 SoC. The set includes all the necessary
> > changes for device tree bindings, vendor prefixes, thermal support, and
> > board-specific devicetree to pass devicetree validation and checkpatch
> > tests.
> > 

...

> arch/arm/boot/dts/st/stm32mp133c-prihmb.dtb: adc@48004000: adc@0:interrupts: 0 was expected
> 	from schema $id: http://devicetree.org/schemas/iio/adc/st,stm32-adc.yaml#
> arch/arm/boot/dts/st/stm32mp133c-prihmb.dtb: adc@48003000: adc@0:interrupts: 0 was expected
> 	from schema $id: http://devicetree.org/schemas/iio/adc/st,stm32-adc.yaml#
> 

Can I please get your attention here. The reported issue is not related
to this patch set. adc@0:interrupts are set in the dtsi file.

Kind regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

