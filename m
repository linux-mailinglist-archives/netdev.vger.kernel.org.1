Return-Path: <netdev+bounces-147809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6904B9DBF66
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 07:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D68281BAD
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 06:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021DB155725;
	Fri, 29 Nov 2024 06:11:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C444184F
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732860705; cv=none; b=e6K6hrbx3QgQUDGgL0TvbzgXRGuH41c9f5/YOZyZGe/9V8UgCbQy7rTF4H3I2Mhxfdms2wRHUpKTLL5Y6yNWqRgTQWNVgcvJAXQ49Bl+WhQKyvvqtOhrlpvogeg70Fa5FkeMB7ldG4hRMSMZcD38dAg9Nqn98yX/jlQJOmXrsgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732860705; c=relaxed/simple;
	bh=AdFWKGROZioHW+VOs9N941lFd3bSyi3wZz3Re8FhT0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehgFDr1VhVSzyUnTjuttG/loRf3b25Pz+mM8I/bUApjoKc1V7/Y6nt7ae27gow20rO2K4WZ4HbK6pbWNeqLPG6KUuTYbh+K7FDBxNLbC97OFWBedGsz9LbZt6mnvGGyKm/ThwOLoYUHCzCNb3dRDgPtP+GR6eP2nAq+qmDuND9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tGuE8-0008Hb-29; Fri, 29 Nov 2024 07:11:40 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGuE7-000jza-08;
	Fri, 29 Nov 2024 07:11:39 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGuE7-004juv-2K;
	Fri, 29 Nov 2024 07:11:39 +0100
Date: Fri, 29 Nov 2024 07:11:39 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michal Kubecek <mkubecek@suse.cz>, kernel@pengutronix.de,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] ethtool: add support for
 ETHTOOL_A_CABLE_FAULT_LENGTH_SRC and ETHTOOL_A_CABLE_RESULT_SRC
Message-ID: <Z0lbGyg99mNN4V7L@pengutronix.de>
References: <20241128090111.1974482-1-o.rempel@pengutronix.de>
 <919a9842-f719-41ac-96fb-ae24d2f0798f@lunn.ch>
 <eajj4mhvqkwrl7lmsrmjy32sncanymqefhxkv4cpnjvxnf2v7o@o6vtfpu7pyym>
 <9d8b7d97-75b8-4e39-91c5-dd56b157ce84@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d8b7d97-75b8-4e39-91c5-dd56b157ce84@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Nov 28, 2024 at 06:41:11PM +0100, Andrew Lunn wrote:
> > > ETHTOOL_A_CABLE_RESULT_SRC is a new property, so only newer kernels
> > > will report it. I think you need an
> > > if (tb[ETHTOOL_A_CABLE_RESULT_SRC]) here, and anywhere else you look for
> > > this property?
> > 
> > Looks like a forgotten edit of copy&pasted text
> 
> Duh! Yes, i did forget.

Arrr... i check existence of wrong field...  (-‸ლ)

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

