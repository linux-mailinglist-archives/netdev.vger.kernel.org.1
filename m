Return-Path: <netdev+bounces-212701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 743BDB21A17
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB781A2340D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4252D3EDD;
	Tue, 12 Aug 2025 01:23:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44226E6FA;
	Tue, 12 Aug 2025 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754961834; cv=none; b=QJ/p+yg+/TMubRhfq005dAKi5/zlq6aSvIsbpJJtbzzscK4xfezqRTtrnnNst7fLb7upwMAb29bICUOvve9tOTEEgjoDthHXq9Ukl6NhEGcO8TsXsv6utsZklI2yeuHWgaxm6zKlm1AvN/e0zHgtIhazPMR8IGEV65TG3/rb9rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754961834; c=relaxed/simple;
	bh=0yONG3eZrM8wICgC9F+BkDl0wX99y6jKioS9uF9Q4FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0upstQPXoCozY3Pbao9IyBNVww2ob9osuIG/4JUVQ/ka7iwyR7+jPDzb8y5gNzm+1cHGkCzDXebZlsKR8EL8LsnmAJuQIPYsQQcZCIbgmd3P+qzQWhADsFi7wQNt1wCIphIFmFFj12U13maMP5awqZUamW0Dr5uInw9ErBxfKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uldjh-000000005N3-3xYI;
	Tue, 12 Aug 2025 01:23:34 +0000
Date: Tue, 12 Aug 2025 02:23:28 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH/RFC net] net: dsa: lantiq_gswip: honor dsa_db passed to
 port_fdb_{add,del}
Message-ID: <aJqXkPHhsOXaOJ-D@pidgin.makrotopia.org>
References: <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
 <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
 <20250810130637.aa5bjkmpeg4uylnu@skbuf>
 <aJixPn_7gYd1o69V@pidgin.makrotopia.org>
 <20250810163229.otapw4mhtv7e35jp@skbuf>
 <aJjO3wIbjzJYsS2o@pidgin.makrotopia.org>
 <20250810210200.6n3xguqi5ukbybm2@skbuf>
 <20250811153242.znhebimdzc2erznt@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811153242.znhebimdzc2erznt@skbuf>

On Mon, Aug 11, 2025 at 06:32:42PM +0300, Vladimir Oltean wrote:
> Hi Daniel,
> 
> On Mon, Aug 11, 2025 at 12:02:00AM +0300, Vladimir Oltean wrote:
> > I suggest tools/testing/selftests/net/forwarding/local_termination.sh
> > once dsa_switch_supports_uc_filtering() returns true.
> 
> Since you're working with the lantiq_gswip driver which receives
> relatively few patches...
> 
> I would like to submit this patch to remove the legacy behavior:
> 
> diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
> index 6b8a5101b0e7..7e11f198ff2b 100644
> --- a/drivers/net/dsa/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq_gswip.c
> @@ -886,8 +886,6 @@ static int gswip_setup(struct dsa_switch *ds)
> 
>  	ds->mtu_enforcement_ingress = true;
> 
> -	ds->configure_vlan_while_not_filtering = false;
> -
>  	return 0;
>  }
> 
> however I'm sure that the driver will break, so I have more, in an
> attempt to avoid that :)

This honourable endeavour deserves my full support :)

> 
> Would you please look at the patches I've prepared on this branch and
> reviewing with extra info you might have / giving them a test, one by one?
> I was only able to compile-test them. I also lack proper documentation
> (which I'm sure you lack too), I only saw the "developer resources" from
> Martin Blumenstingl's Github (which lack actual PCE register descriptions)
> https://github.com/xdarklight/ltq-upstream-status
> and the Maxlinear PRPLOS code at
> https://github.com/maxlinear/linux/tree/UPDK_9.1.90/drivers/net/datapath/gswip/switchcore/src
> (which I think is what you were also referencing)

There is also a DSA driver for the newer standalone GSW1xx switch ICs
which are connected to a CPU using either MDIO or SPI for management and
2500Base-X/SGMII or RGMII/RMII for the datapath. I'm working on merging
that with the existing lantiq_gswip driver as those newer switch ICs have
a lot in common with the older Lantiq/Intel in-SoC switches.

You can see my work-in-progress first cleaning up the reference mxl-gsw1xx
driver and then preparing the lantiq_gswip driver for a potential merge
with that driver here:

https://github.com/dangowrt/linux/commits/mxl-gsw1xx-cleanup/

The old Lantiq VRV20x turned out to be difficult to even undergo proper testing
using tools/test/selftest/drivers/net/dsa scripts due to most boards coming with
only 64 MiB or DDR2 RAM -- even with nothing else running and the root
filesystem on-flash tcpdump quickly causes oom when trying to run
local_termination.sh.

In the next days I'm going to receive two boards with 256 MiB of RAM which
I found used for little money on ebay which will allow me to at least test
GSWIP 2.1 (xrx200) and GSWIP 2.2 (xrx330).
I don't think any of those boards comes with an old enough xrx200 SoC to
still contain the GSWIP 2.0 IP...

> 
> The branch over net-next is here:
> https://github.com/vladimiroltean/linux/commits/lantiq-gswip/

Nice, I'll happily take a look tomorrow and can do basic testing on my
TL-W8970 (VRV200, but only 64 MiB of DDR2 RAM), and hopefully the full
DSA selftest suite (or rather the part of it which covers features
actually supported by the driver/hardware) starting with
local_termination.sh once I receive the more resourceful boards with
VRV200 and VRV330 in the next couple of days.


