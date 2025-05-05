Return-Path: <netdev+bounces-187678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A312AA8D5D
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 09:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7653F3B5F3D
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 07:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0364C1DDC1B;
	Mon,  5 May 2025 07:50:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EAD1DE4E1
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431431; cv=none; b=HAjVQJjY7diiWsicGIslZtYC5p6LQlMwlisHMkHS2/88Wll02ytRx2zsAOB3XuSDGfGK5u3ty/ZtX6FTU4p5j7LBUyvYQPC9RZm5LhH+HpBs5H4yCmc/ZzWuvOUAiAv3rbFH7c2Ns3RnliTt/pkzPj6nisPzwBhiqT2YlHXt2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431431; c=relaxed/simple;
	bh=s1tPNrFQVa+he+GL0iqA/bpIpDXE5fUgW0C4vmtsLuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNgDJ1cXv9wwpb9gnldVxWmVN27bajysuPm2KAFkwo0RDHNeTFcwH364RkN7FfwO/2BRQJZAACMoJ8nLUAe9e4bA67Ap93VE2BVV8yN6KXjj8gYc5ymALuZy3MW9E7r52zy6NC1hoZb738xfm8H4PpTv7WrKLSxknkCSBK94OC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uBqa2-0002c0-Mb; Mon, 05 May 2025 09:49:38 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uBqZy-001C1T-34;
	Mon, 05 May 2025 09:49:34 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uBqZy-004X3I-2a;
	Mon, 05 May 2025 09:49:34 +0200
Date: Mon, 5 May 2025 09:49:34 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] Documentation: networking: expand and
 clarify EEE_GET/EEE_SET documentation
Message-ID: <aBhtjnwIKkskuC6x@pengutronix.de>
References: <20250427134035.2458430-1-o.rempel@pengutronix.de>
 <f82fe7ac-fc12-4d50-98d4-4149db2bffa0@redhat.com>
 <aBSnRZEGTnHxnMaI@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBSnRZEGTnHxnMaI@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, May 02, 2025 at 12:06:45PM +0100, Russell King (Oracle) wrote:
> On Fri, May 02, 2025 at 10:46:02AM +0200, Paolo Abeni wrote:
> > On 4/27/25 3:40 PM, Oleksij Rempel wrote:
> > > Improve the documentation for ETHTOOL_MSG_EEE_GET and ETHTOOL_MSG_EEE_SET
> > > to provide accurate descriptions of all netlink attributes involved.
> > > 
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > 
> > This looks like an almost complete rewrite WRT v1, a changelog would
> > have helped reviewing. I'm unsure if it captures all the feedback from
> > Russell,
> 
> Indeed, because I'm still of the opinion that we shouldn't be trying to
> document the same thing in two different places, but differently, which
> will only add confusion, and over time the two descriptions will diverge
> making the problem harder.
> 
> We need to document this in exactly one place, not two places.
> 
> So please, choose one of:
> 
> * Documentation/devicetree/bindings/net/ethernet-phy.yaml
> * Documentation/networking/phy.rst
> 
> and reference one from the other, if necessary improving the
> documentation.
> 
> Given that phylib is not a DT thing, I believe it should not be
> documented in the DT bindings, but people directed to the phylib
> documentation (the second) for the clarification of our implementation.

Ok, I see - I wrongly interpreted previous mail. phy.rst - is a good
option. It should replace (extend) documentation in:
Documentation/networking/ethtool-netlink.rst
include/uapi/linux/ethtool.h

Are there any other missing documentation artifacts which should be
replaced?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

