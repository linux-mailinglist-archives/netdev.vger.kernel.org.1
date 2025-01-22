Return-Path: <netdev+bounces-160419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D90A19993
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 21:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E3E7A47EC
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 20:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D36215769;
	Wed, 22 Jan 2025 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ECvxqBxO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5283C17DE36;
	Wed, 22 Jan 2025 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737576981; cv=none; b=ExrMOo9YxIsY9bPWheGU+IFMwiO94bjoHA/BuFfR2WIS462d3Hq3NcXUMhq6ktRWd7asRkiLE4NDIxnfgTz/L66RLo9FP8zzRGhchPVOROuXr3/ULYwfCkIpPKynADR1NCkPQF2R8+rAZ4q4/ORnNPSCqYYp6gZ91GtCHUAVACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737576981; c=relaxed/simple;
	bh=PUJ84auehYsRgfdxYZQxDKopanyz3Xlzr2nu8NzgkLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NagHOvOyBXFSzwZP75LgOEC7cRO798ztm3ONHOEz3U/uXyBz0MlWJpNJUuXovZ6GYFeRUXpYyMvaTk5bwVEqK2TKM367A2Aw31iEn5WNktjABS1f9MKHwPRE3zaWLRpvbZmSYHvTsbsVbo1ZNxJhI5y7hUqRzCQVCv2CzWmosA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ECvxqBxO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Uvex5e6pxn9WjTg+8tgFaEeT8EWGYbla2zLRi8ei0vU=; b=ECvxqBxOD0UQYqU745zOkC8kqV
	GU0uaQ/iOnKqSb4C4pQUiYXZGrrxl7aGurYPqTCNxR8I3pShWNVaRYOb/fd+e6rpmLU5E2mst0iIu
	BQjVKs75+8Hu0eS3tp7PzMVa8Fob84KRUqjCaBXNOPbX73+TaE1grEzZszt52cqKiirkcszyVkMKa
	XJGnHHC52zQmZy+d77rcM6cmPpR6u6qzLlv4oUEs0UROkz+OXRI0SJoFAdacBex0w/dpxU0hQZGnc
	KpeSF5lQ6gdA3YdJDym3HxgvwGK67Umcmb5qqVha0UdO87GAi2+dxrK7ZCjwVXhB5UHrhBCPahTrH
	UjKJd24A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48414)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tah92-0000G3-1x;
	Wed, 22 Jan 2025 20:16:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tah8y-0005CZ-11;
	Wed, 22 Jan 2025 20:16:08 +0000
Date: Wed, 22 Jan 2025 20:16:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next RFC v2 0/6] net: phy: Introduce a port
 representation
Message-ID: <Z5FSCF7u5a7r-ssD@shell.armlinux.org.uk>
References: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 22, 2025 at 06:42:45PM +0100, Maxime Chevallier wrote:
> First, a short disclaimer. This series is RFC, and there are quite a lot of
> shortcomings :
> 
>  - The port representation is in a minimal form
>  - No SFP support is included, but it will be required for that series to come
>    out of RFC as we can't gracefully handle multi-port interfaces without it.

Agreed - because I think SFP brings with it a whole host of issues that
describing the media facing port would be error prone - and to do it
accurately, we'd need a table of quirks to fix lots of broken modules.

For example, many SFP modules with RJ45 connectors describe themselves
as having a LC connector!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

