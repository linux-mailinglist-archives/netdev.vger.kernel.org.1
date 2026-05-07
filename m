Return-Path: <netdev+bounces-285146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFGXCscf/Gk8LwAAu9opvQ
	(envelope-from <netdev+bounces-285146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 07:14:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6A04E30EF
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 07:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E75030252B3
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 05:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B55E32AAA0;
	Thu,  7 May 2026 05:14:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A108C1B4257
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 05:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778130864; cv=none; b=ll4GQTcvyEa6yDyHxek8HCl+Evy17H2NnRiPhKR/RDJXq5gR6JxhW7U+m9FlHB2vHbbCPUVkjBnnHc6Djmslp4KQEVF7S9TZykFB2qsKUbDQQoWKCLoJe4ruP8aVp5zR4dTQQY9r2Gudnf3NOEy6k9K8Uf5v9snwbfJX5t4rU/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778130864; c=relaxed/simple;
	bh=vGykLeLTi2D+nlzGa2x/h5//HeZHnJS5Sgihc8zqRtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUWo9ElIKFrT9oTX/rQxBiGZLI+DPPLaMLfv+2qhq+HyBQdaO7eLvfU45B8w33dLw+Lz3A0sfLp1y8mqMKx7qNMq0z6AKvAQ0EWybR4PowL1SBjvRu//BuVJ/21KgaFQI5N5jRu3DLorQbeuw3ADG0IEYLKK+SyonskVVbpoI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wKr3u-0000W0-1f; Thu, 07 May 2026 07:14:14 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wKr3t-000rc3-0Z;
	Thu, 07 May 2026 07:14:13 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wKr3t-00000005d90-26XP;
	Thu, 07 May 2026 07:14:13 +0200
Date: Thu, 7 May 2026 07:14:13 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v1 0/7] ARM: dts: stm32: Fix mecio1 hardware revisions
 and ADC/GPIO mappings
Message-ID: <afwfpST_NNAWSo1l@pengutronix.de>
References: <20260318105123.819807-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260318105123.819807-1-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Queue-Id: 7E6A04E30EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285146-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,foss.st.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Alexandre,

Can you please take a look at this patch stack :)

Best Regards,
Oleksij

On Wed, Mar 18, 2026 at 11:51:16AM +0100, Oleksij Rempel wrote:
> This series updates the STM32MP15x MECIO1 device trees to properly
> account for the physical hardware changes between the R0 and R1 board
> revisions.
> 
> David Jander (7):
>   ARM: dts: stm32: stm32mp15x-mecio1-io: Enable internal ADC reference
>   ARM: dts: stm32: stm32mp15x-mecio1-io: Fix ADC sampling times
>   ARM: dts: stm32: stm32mp15x-mecio1-io: Move divergent mecio1 ADC
>     channels to board files
>   ARM: dts: stm32: stm32mp15x-mecio1-io: Fix GPIO names typo
>   ARM: dts: stm32: stm32mp15x-mecio1-io: Move gpio-line-names to board
>     files
>   ARM: dts: stm32: stm32mp15x-mecio1-io: Fix expander gpio line typo
>   ARM: dts: stm32: stm32mp15x-mecio1-io: Move expander gpio-line-names
>     to board files
> 
>  arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts | 128 +++++++++++++++
>  arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts | 144 +++++++++++++++++
>  .../arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi | 146 ++----------------
>  3 files changed, 288 insertions(+), 130 deletions(-)
> 
> --
> 2.47.3
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

