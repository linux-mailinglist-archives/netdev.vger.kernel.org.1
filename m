Return-Path: <netdev+bounces-161774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5349A23E5F
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 14:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A0E161176
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442221B6CFA;
	Fri, 31 Jan 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jW5JgLtj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49272744E;
	Fri, 31 Jan 2025 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738330518; cv=none; b=cVz00IYttFRgqq+lTv82uUh/Hh72UL9Pfww7LXuqYqtRwgEo/8TElM1MBuxi0npf9lioKqxnAkBuYNzAgiCLjIxXxwci8Y4Mq4+Gvl6gUa+cnfc7Lnl+dyvbOHSKEGp70qE/92IMNWH02iwv6r3DlY7FbU4tokMAqt9S7ktSoU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738330518; c=relaxed/simple;
	bh=sBx6Lp3Z3vX6guoh2rGM1YOzdzROZMt9Ny+YeM0r1LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKSglHsZ5Eskv3X9JdO4nOyK/Y1gH6b1wvLi6gsTaxhmYyQD/V3Z7s/h9VhMpwrY3TFoZUWmc3mdNKYnedry8nMjQK36mzzhd1ljcEEKWX3UwIsys0t35YJDFJf10C5RzgLSP1ZyoagWWK8+Z8qNIwQdAYQAJWNYQuHNKABeUGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jW5JgLtj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PxZj02JGvJPKVIuRsnn0LpE6ElYq5muFkD78aLQpUK4=; b=jW5JgLtjrGN8PwSgm6lOA1EPcW
	WOrjgwzt2a/Wv3mHIPU/OxPCVlPT+gSudVsiOPslty20FGpbisCzUCTLM4v3tAWt5k0tQm/NjaihX
	jMCSWovzMzvAnEtFDXB4Kc40ZGNAH4yXFXcYFw1zHf6l1eRO/f1M+8EVkX+JWM2qeZX8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tdrAl-009hi9-6M; Fri, 31 Jan 2025 14:35:03 +0100
Date: Fri, 31 Jan 2025 14:35:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: linux@armlinux.org.uk, olteanv@gmail.com, Woojung.Huh@microchip.com,
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Message-ID: <8866e9ba-642c-4b09-a6da-e352936956c5@lunn.ch>
References: <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
 <DM3PR11MB873652D36F1FC20999F45772ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
 <Z5tRM5TYuMeCPXb-@shell.armlinux.org.uk>
 <DM3PR11MB8736A58E065BF24C2CEA5808ECE82@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB8736A58E065BF24C2CEA5808ECE82@DM3PR11MB8736.namprd11.prod.outlook.com>

> > So I'm going to say it clearly: never operate the link with dis-similar
> > negotiation protocols. Don't operate the link with 1000base-X at one end
> > and Cisco SGMII at the other end. It's wrong. It's incorrect. The
> > configuration words are different formats. The interpretation of the
> > configuration words are different. Don't do it. Am I clear?
> 
> I do not quite follow this.  The link partner is out of control.  The
> cable is a regular Ethernet cable.  It can be plugged into another PHY, a
> 100Mbit switch, and so on.  Currently using 1000Base-T SFP running in
> 1000BASEX mode and 10/100/1000Base-T SFP running in Cisco SGMII mode
> works in establishing network communication.

Russell is talking about PCS to PHY, the signalling over the SERDES
bus. You are talking PHY-to-PHY signalling over the media, 4 pairs of
copper. These are different signalling protocols, code words in the
in-band signalling of the SERDES data stream, and pulses on the
copper.

Russell is saying you should not mix a Cisco SGMII and 1000Base-X
between the PCS and the PHY. The code words are different format,
which might appear to work in some conditions, but in general is
broken. This is why phylink will try to talk to the PHY within the
SFP, and set is host side interface to Cisco SGMII, and configure the
PCS to Cisco SGMII.

> > If it's still that 1000base-X mode to another 1000base-X partner doesn't
> > generate a link-down interrupt, then you will have no option but to use
> > phylink's polling mode for all protocols with this version of XPCS.
> 
> It is always that case when running in 1000BASEX mode using fiber SFP or
> 1000Base-T copper SFP.

So in general, you would not use 1000BaseX between the PCS and the PHY
in the SFP. It gets tricky doing 10/100Mbps. Since 1000BaseX is hard
coded to 1G, there is no in-band signalling to say to the MAC to only
send at 10/100. So the PHY generally has back to back MACs, the host
side running at 1000, and the line side at 10/100, with a packet
buffer in the middle. As the buffer fills up, the host side MAC
generates pause frames to slow down the MAC to stop the buffer
overflowing.

	Andrew

