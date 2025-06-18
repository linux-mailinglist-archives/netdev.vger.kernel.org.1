Return-Path: <netdev+bounces-198894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCD8ADE39F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 08:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE181179EC0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 06:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE435202998;
	Wed, 18 Jun 2025 06:27:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDFF207E1D
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750228042; cv=none; b=GLBuve3o3fkCp6PjqM8IJR3Dx+cxwCw0sqDNP16Nxewe1E25vGTcwWjFhIRaRz5NluZiWRMjH7PqIypjDf1wWjLkjjFM9zpKmsTpLZSICTcmuU7FuMW8mI30AM/CTitpZ4MD3lCgQtkDt537kPti5cNIFpzMFCTlTQvWPb7cM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750228042; c=relaxed/simple;
	bh=HEuAFWDbY0aFm8Fjh8WwsnQEHbP6Qamrrpb/BiDGO+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LF8FHjOZ4EdnadZjH3fxTLsokUTMYKb4gywpzAF+dcG83YyBWHanlu119HmAzKB7wahHnPjMHFrM+Mje+7GpbWW2IVj+aKUk6dVN2A32nrRnsOfJHY9/0+Sw5RrofOXNcvtQ9pLmQ0tG1aRbWu58u1N5nKe45gieVLO9n8eB1D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uRmGP-0008CB-0S; Wed, 18 Jun 2025 08:27:13 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uRmGO-0045o7-08;
	Wed, 18 Jun 2025 08:27:12 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uRmGN-003Lh3-2w;
	Wed, 18 Jun 2025 08:27:11 +0200
Date: Wed, 18 Jun 2025 08:27:11 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
	Christian Eggers <ceggers@arri.de>
Subject: Re: [PTP][KSZ9477][p2p1step] Questions for PTP support on KSZ9477
 device
Message-ID: <aFJcP74s0xprhWLz@pengutronix.de>
References: <20250616172501.00ea80c4@wsk>
 <aFD8VDUgRaZ3OZZd@pengutronix.de>
 <b4f057ea-5e48-478d-999b-0b5faebc774c@linux.dev>
 <aFJJlGzu4DrmqH3P@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aFJJlGzu4DrmqH3P@hoboy.vegasvil.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Jun 17, 2025 at 10:07:32PM -0700, Richard Cochran wrote:
> On Tue, Jun 17, 2025 at 05:10:11PM +0100, Vadim Fedorenko wrote:
> > On 17/06/2025 06:25, Oleksij Rempel wrote:
> > > No, this will not work correctly. Both sides must use the same timestamping
> > > mode: either both "one step" or both "two step".
> > 
> > I'm not quite sure this statement is fully correct. I don't have a
> > hardware on hands to make this setup, but reading through the code in
> > linuxptp - the two-step fsm kicks off based on the message type bit. In case
> > when linuxptp receives 1-step sync, it does all the calculations.
> 
> Correct.
> 
> > For delay response packets on GM side it doesn't matter as GM doesn't do
> > any calculations. I don't see any requirements here from the perspective
> > of protocol itself.
> 
> Running on a PTP client, ptp4l will happily use either one or two step
> Sync messages from the server.

Thank you for clarification! In this case, something else was wrong, and
I made a wrong assumption. I had a non-working configuration, so I made
the assumption without verifying the code.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

