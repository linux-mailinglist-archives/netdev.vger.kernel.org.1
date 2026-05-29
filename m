Return-Path: <netdev+bounces-293037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOMnFxlHGWrHuAgAu9opvQ
	(envelope-from <netdev+bounces-293037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:58:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1395FEE2B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C787300E5E5
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9862939F191;
	Fri, 29 May 2026 07:51:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249753403E4
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041061; cv=none; b=cD6m5tsIEC/RpUvyGAWfrKGgtLhvQHqGnEVcUULsquhmJWwvqKs2Jnt60T0I9Bzeq7K+Xk3v7VXmsD+EQmJbs/U9QR93yqX/QQPRlT+Rqk//h0B4WyO6rOMvTrJNYuCp5tfFEFfuU5k0njpYztaE8flI9sAOisUAQQYp9oKx6co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041061; c=relaxed/simple;
	bh=2/CzlDsL6M4D/2uAPuHj1XTFNWRuvfcQP2MZv8JIQOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6CGe9QiI245Bzr4B1DZeQaNBi3mX+2ZVqn8RxZJTM9UZ++SYfF/re22f/+n4OFJnHz8Eb9l9Yoxxw1Hei9tzqC5O1oAUOVZsCjCCKuWbkEU+SxNQiIgWR0I/fT6rQ4c0f0Siu5+1JLlBKfJXqC+OcBAoPdzxeqaKDjaM6wFeyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wSrzD-0003fa-7B; Fri, 29 May 2026 09:50:31 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wSrz9-0003eI-0Q;
	Fri, 29 May 2026 09:50:27 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wSrz9-00000005ze4-02Kd;
	Fri, 29 May 2026 09:50:27 +0200
Date: Fri, 29 May 2026 09:50:26 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
Message-ID: <ahlFQkjLehH19oDa@pengutronix.de>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <20260526172447.10ca4b9e@kernel.org>
 <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
 <20260527162516.0d012503@kernel.org>
 <b84a5fe0-a080-45fc-87d1-790402d423e4@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b84a5fe0-a080-45fc-87d1-790402d423e4@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,nxp.com,bootlin.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293037-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CB1395FEE2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Fri, May 29, 2026 at 09:42:14AM +0200, Maxime Chevallier wrote:
> Hi
> 
> On 5/28/26 01:25, Jakub Kicinski wrote:
> > On Wed, 27 May 2026 04:47:47 +0200 Andrew Lunn wrote:
> > > > It'd be great to hear from others but IMHO in the current form this is
> > > > not suitable for Documentation/networking/ We can commit the "knowledge"
> > > > part but enumerating the test cases seems odd for Documentation/.
> > > 
> > > Sorry, not looked too deeply at the actual content yet.
> > > 
> > > What i was thinking was a python file, which sphinx can ingest to
> > > produce documentation, and place holders were code would be added to
> > > implement the actual test during the next phase.
> > > 
> > > This is how i've done testing in the past. I would be the evil one who
> > > thought up the tests and described them in detail using sphinx markup
> > > in a python test template file. After some review they got passed off
> > > to a python developer for implementation. And when they got run and
> > > failed, sometimes the feature developer, the test developer and myself
> > > got together to figure who made the error.
> > > 
> > > I'm not sure we even need sphinx. What i find important is that the
> > > test is documented. What kAPI calls should be made with what
> > > parameters. What results we are expected and why? So that when a test
> > > fails, a developer has the information they need to fix their
> > > code. The Why? is important, and often missing from the kernel tests.
> > 
> > All makes sense. The question is primarily how we fit that into
> > the existing project layout we have in the kernel :(
> > 
> > The python tests can be hacked up to print the test case docstring
> > before the failure.
> > 
> > But I think for human and AI reviewer consumption it may be nice
> > to keep the condensed knowledge / common mistakes in Documentation/
> > If we had the ability to exercise the submissions it'd be a different
> > story test output would be a sufficient signal and/or could be fed into
> > the review. But for AI making a guess at whether the submitted driver is
> > correct purely from the driver source - knowledge is useful.
> 
> Also for the knowledge part, we had Oleksij's series that documented
> more aspects of flow control (not just the pause part) :
> 
> https://lore.kernel.org/netdev/20260304094811.2779953-1-o.rempel@pengutronix.de/
> 
> Oleksij, maybe we can merge some of the information here with your
> doc for the Docuentation/networking part ?

I have nothing against it. We need a documentation for proper testing
and implementations too :)

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

