Return-Path: <netdev+bounces-116686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C22D94B5C7
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EC72818B9
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E02280C13;
	Thu,  8 Aug 2024 04:14:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0024E2E419
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 04:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723090462; cv=none; b=MljZJ7620ILCSvx7Jn9iwuPI4es6QmTsTmplSeoxc+GXWfVhMHaggLTtH5gCQNdowxKj2MwYjjbdTTOXn0tnbY4gTtEx5BZ0ceiGK3IpI77vduDv1+luR/PCr5nfj/TccP6ScQdMqgdza6d/FqN1ZErWwEMmybHXv3wTuiNISUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723090462; c=relaxed/simple;
	bh=OG6cX3d/4bHZEqZtMQEllynmVc20w1bjA3kVyiNWtq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsLP10wioKjF+jE7r8yZkqyz9JJ9JcROtv+m0w05t2wJM3EAfH5qLZrlGEYwjgNdzNr4k5TelO4C7o5HOfTgNDZsj80FfDFW1FSc4n6/sf29YBxGQ5PRIk5aD6Vmr91xJ05jPJD7mSRQ0p0BJZO/vd5rozvgfyohAlfJPlPQR2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sbuXX-0005MW-CW; Thu, 08 Aug 2024 06:14:15 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sbuXW-005LFT-NA; Thu, 08 Aug 2024 06:14:14 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sbuXW-008jWJ-1z;
	Thu, 08 Aug 2024 06:14:14 +0200
Date: Thu, 8 Aug 2024 06:14:14 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Martin Whitaker <foss@martin-whitaker.me.uk>
Cc: netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Woojung.Huh@microchip.com, lukma@denx.de,
	Arun.Ramadoss@microchip.com, kuba@kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: disable EEE for
 KSZ8567/KSZ9567/KSZ9896/KSZ9897.
Message-ID: <ZrRGFsZI49jJ67tx@pengutronix.de>
References: <20240807205209.21464-1-foss@martin-whitaker.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807205209.21464-1-foss@martin-whitaker.me.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Aug 07, 2024 at 09:52:09PM +0100, Martin Whitaker wrote:
> As noted in the device errata [1-8], EEE support is not fully operational
> in the KSZ8567, KSZ9477, KSZ9567, KSZ9896, and KSZ9897 devices, causing
> link drops when connected to another device that supports EEE. The patch
> series "net: add EEE support for KSZ9477 switch family" merged in commit
> 9b0bf4f77162 caused EEE support to be enabled in these devices. A fix for
> this regression for the KSZ9477 alone was merged in commit 08c6d8bae48c2.
> This patch extends this fix to the other affected devices.
> 
> [1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/KSZ8567R-Errata-DS80000752.pdf
> [2] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/KSZ8567S-Errata-DS80000753.pdf
> [3] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/KSZ9477S-Errata-DS80000754.pdf
> [4] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/KSZ9567R-Errata-DS80000755.pdf
> [5] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/KSZ9567S-Errata-DS80000756.pdf
> [6] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/KSZ9896C-Errata-DS80000757.pdf
> [7] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/KSZ9897R-Errata-DS80000758.pdf
> [8] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/KSZ9897S-Errata-DS80000759.pdf
> 
> Fixes: 69d3b36ca045 ("net: dsa: microchip: enable EEE support") # for KSZ8567/KSZ9567/KSZ9896/KSZ9897
> Link: https://lore.kernel.org/netdev/137ce1ee-0b68-4c96-a717-c8164b514eec@martin-whitaker.me.uk/
> Signed-off-by: Martin Whitaker <foss@martin-whitaker.me.uk>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

