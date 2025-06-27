Return-Path: <netdev+bounces-201978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D85FAEBC33
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 17:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153044A35E7
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0DE2D662C;
	Fri, 27 Jun 2025 15:46:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6121171C9
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039162; cv=none; b=WM1AE2Zj8SvSS1xfT5baiBiv2zFBQkxb3ZTr5TB+R7/kvpM3ufg+mUHR+UUT3fdQuD9l7OIDyv9Ycq6zah8iygO1yeZuf7GOeMKzywTVGoe5JrDM2yvtqyL+veAkQC/SMEf99QUkf+mW+6sF5d11RHoNfvqfMdXUQdlJYXHqKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039162; c=relaxed/simple;
	bh=BiIbeOmUeRO0AU6RuqdDm9kIvmbX5U9hAIstbN8vuSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5C98BPhT/a9boOx1jw48GvfaHcWM6JW97rOfyMRAlFIj+ejaD42Mhau3JL01mc7c7MKRQuX52tTV1cWdrS1oSTRuaI7V4f2HHhY1QBGVQm/5fS2tJ9OiSISRjlzNDxcxurm5MXfEWPGjx9t/EQzFS4OGJj5xlzPltQ5I82HMvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uVBGw-0004cf-KM; Fri, 27 Jun 2025 17:45:50 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uVBGv-005dlG-0h;
	Fri, 27 Jun 2025 17:45:49 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uVBGv-003coG-0M;
	Fri, 27 Jun 2025 17:45:49 +0200
Date: Fri, 27 Jun 2025 17:45:49 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/1] phy: micrel: add Signal Quality
 Indicator (SQI) support for KSZ9477 switch PHYs
Message-ID: <aF68rU2XQQ8a3ww4@pengutronix.de>
References: <20250627112539.895255-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250627112539.895255-1-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Jun 27, 2025 at 01:25:39PM +0200, Oleksij Rempel wrote:
> Add support for the Signal Quality Indicator (SQI) feature on KSZ9477
> family switches, providing a relative measure of receive signal quality.
> 
> The hardware exposes separate SQI readings per channel. For 1000BASE-T,
> all four channels are read. For 100BASE-TX, only one channel is reported,
> but which receive pair is active depends on Auto MDI-X negotiation, which
> is not exposed by the hardware. Therefore, it is not possible to reliably
> map the measured channel to a specific wire pair.
> 
> This resolves an earlier discussion about how to handle multi-channel
> SQI. Originally, the plan was to expose all channels individually.
> However, since pair mapping is sometimes unavailable, this
> implementation treats SQI as a per-link metric instead. This fallback
> avoids ambiguity and ensures consistent behavior. The existing get_sqi()
> UAPI was designed for single-pair Ethernet (SPE), where per-pair and
> per-link are effectively equivalent. Restricting its use to per-link
> metrics does not introduce regressions for existing users.
> 
> The raw 7-bit SQI value (0–127, lower is better) is converted to the
> standard 0–7 (high is better) scale. Empirical testing showed that the
> link becomes unstable around a raw value of 8.
> 
> The SQI raw value remains zero if no data is received, even if noise is
> present. This confirms that the measurement reflects the "quality" during
> active data reception rather than the passive line state. User space
> must ensure that traffic is present on the link to obtain valid SQI
> readings.

Update for this statement: it is valid only if EEE is active. With
disabled EEE, SQI provide correct value even if no data is transferred.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

