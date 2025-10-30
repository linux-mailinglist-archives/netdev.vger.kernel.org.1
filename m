Return-Path: <netdev+bounces-234333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F3EC1F7F9
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A333B660B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE8233B955;
	Thu, 30 Oct 2025 10:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D226B2C8
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819755; cv=none; b=I7bH4M4dcwNnxXRpir2+B6ZCrqkvX5qceKM6/98MgFCxmVidZGJu4+RmMm/+Ig5cEVrUYHi67njqL2X4Nru+EvFISmLxPQf+LhIwT/F02lc4s4jOuFPdxS+IcatUuoAdYPVeRg1DY882FcjhnoEgBPL3cfY/Pnbi7QS85ajpIFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819755; c=relaxed/simple;
	bh=h6ZeZMm+kh/ZMKD2CWbwzRP0dY/DOi2RxLvBAU5tIYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFul14qvb3tDXwTuaE2P3afgxe3BtUDXlUFN5jG9gct+2WMDWEeINK5gMgg9o8NQvd3UBL3af5fbO9fUxMjaX9hlDzXrIhKawyEYtG0XmWl3d0ODFzEeETgsN6jKGdX0+3tSEE/do1qlGnpiNlEHyL6pruifxK9/J0nYKPcgV+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vEPnK-00035h-B2; Thu, 30 Oct 2025 11:22:14 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vEPnI-006C7e-30;
	Thu, 30 Oct 2025 11:22:12 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vEPnI-008rEb-2Z;
	Thu, 30 Oct 2025 11:22:12 +0100
Date: Thu, 30 Oct 2025 11:22:12 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Wismer <thomas.wismer@scs.ch>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: pse-pd: tps23881: Add support for
 TPS23881B
Message-ID: <aQM8VF2YN7fACzNm@pengutronix.de>
References: <20251029212312.108749-1-thomas@wismer.xyz>
 <20251029212312.108749-2-thomas@wismer.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029212312.108749-2-thomas@wismer.xyz>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Oct 29, 2025 at 10:23:09PM +0100, Thomas Wismer wrote:
> From: Thomas Wismer <thomas.wismer@scs.ch>
> 
> The TPS23881B uses different firmware than the TPS23881. Trying to load the
> TPS23881 firmware on a TPS23881B device fails and must be omitted.
> 
> The TPS23881B ships with a more recent ROM firmware. Moreover, no updated
> firmware has been released yet and so the firmware loading step must be
> skipped. As of today, the TPS23881B is intended to use its ROM firmware.
> 
> Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you.
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

