Return-Path: <netdev+bounces-215758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 954FFB30234
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE351887260
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CF03451A5;
	Thu, 21 Aug 2025 18:37:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533F2EC55C;
	Thu, 21 Aug 2025 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801436; cv=none; b=Fgm4FVuzp3n1j4R+RBJP9JUXC3d5skCyXSF2r5rdk2+zvHQ7XAMrQnSv8C5oPFp4dSn4KJsuxOgAGAzXW5JMKfD+2+dOV1tbqu6N7gUzYOsR0FfZ8WUI/84DumAhPxf9FW+h6YYTWkV8BKp5usxUK5VfrXgCvb0EyUhSBC44PnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801436; c=relaxed/simple;
	bh=IBq99vyNZwAHZ/bm4xVJKwYr0fhcGKOPxJqxmkIyqT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUlxDSRsfwrQmp5EYPenkgDoadWAzIBx2SOW7RFPB9ZDOEZAsuF7bnuLcngoF2VAbj/DI7Y/qhi+ftjqU+SFRI7bJkUpBkD8VGf3aCpRXq73N/ioPqeFmN6tyE5nypFEO8QQ1nR0tjjIVR35rdXli5GjxI9rWJhuKHjZyWjLf/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1upA9q-000000001Dn-14LS;
	Thu, 21 Aug 2025 18:37:06 +0000
Date: Thu, 21 Aug 2025 19:37:02 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "hauke@hauke-m.de" <hauke@hauke-m.de>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arkadis@mellanox.com" <arkadis@mellanox.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"john@phrozen.org" <john@phrozen.org>,
	"Stockmann, Lukas" <lukas.stockmann@siemens.com>,
	"yweng@maxlinear.com" <yweng@maxlinear.com>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>,
	"lxu@maxlinear.com" <lxu@maxlinear.com>,
	"jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>,
	"Schirm, Andreas" <andreas.schirm@siemens.com>,
	"Christen, Peter" <peter.christen@siemens.com>,
	"ajayaraman@maxlinear.com" <ajayaraman@maxlinear.com>,
	"bxu@maxlinear.com" <bxu@maxlinear.com>,
	"lrosu@maxlinear.com" <lrosu@maxlinear.com>
Subject: Re: [PATCH RFC net-next 20/23] net: dsa: lantiq_gswip: add registers
 specific for MaxLinear GSW1xx
Message-ID: <aKdnTk7bjWEyty5H@pidgin.makrotopia.org>
References: <aKDief99H-oV0Q7y@pidgin.makrotopia.org>
 <d867cfec3cc144f1404420ab868aefc0779cbcd9.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d867cfec3cc144f1404420ab868aefc0779cbcd9.camel@siemens.com>

Hi Alenxander,

thank you for the thorough review of the RFC series!

On Thu, Aug 21, 2025 at 06:11:36PM +0000, Sverdlin, Alexander wrote:
> On Sat, 2025-08-16 at 20:56 +0100, Daniel Golle wrote:
> > [...]
> > +#define GSW1XX_PORTS				6
>  
> a tricky questions for you ;-)
> 
> There are scarce references to Port 6 across GSW145 datasheet, the 7th port.
> One could also enable/disable it (bit P6) in GSWIP_CFG (0xF400).
> 
> Yes, it's sold as 6-port switch, but the question is, shall the port 6 be
> disabled to save power and avoid unnecessary EMI?

I understood that port 6 can be used for packet injection or monitoring
over the management interface (MDIO or SPI). For a moment I thought it'd
be cool to implement a (very slow) Ethernet netdev allowing to use that
feature in Linux -- but it would be very very slow and also useless on
systems which anyway got either port 4 or 5 connected to the host as CPU
port. I guess it is intended for basic managed switches which come with
a simple microcontroller connected to the GSW1xx chip: ~1 MBit/s
"Ethernet-over-MDIO" or (slightly faster due to duplex)
"Ethernet-over-SPI" can be fast enough to serve a simple Web UI, Telnet,
SSH, or respond to SNMP or LLDP, for example.
I wonder if that port also supports the DSA special tag (insertion and
egress)...

Anyway, fantasies aside, at least for now it does make sense to disable
it, though I wouldn't expect significant power saving or reduced EMI
from that (but you never know...)


