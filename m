Return-Path: <netdev+bounces-126603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAC5971FC7
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04925284A11
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6052316EB55;
	Mon,  9 Sep 2024 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6VEsaTz+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671218C31;
	Mon,  9 Sep 2024 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901249; cv=none; b=e6mY8/4xoeh7F81AHMvBzqT55szvSI1AbIDibAtO8JfBgUpz4R2oxZog/CAeMnqn8F5KMR5OSfu1tf0lIsBM6c1+5+TP+j5ajTRQCYellb+hSaHEY7Y++NDe6WP9TbeLseL2ma2caHym0gx6BSBpuQq7ci63Ssvbnc3xP0H3J50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901249; c=relaxed/simple;
	bh=0F99EAMggZ7bVwLZxp3FQPd3x+WbTU0lTTF3YgclEeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABxbg5vBY9WTtzJ3d/rF6USjOQjAGXOP9uhfr67JiAnosLQBaKcMP6zzcVQu3blYNobrlIWG6cdM9eDZ+phn1wpmjrnMNp1NgOSvMSbv/fL0i37sjj3eHVCdS1V2OFvAmtQbv2WRi5Tje1ygbH1Yf6RSLqxa5hRGVwzApjPIyh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6VEsaTz+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SeXTB0UFigKuByTesi4WYdQQrB66kXq7eQyBV2wgCsQ=; b=6VEsaTz+LhZNoVAt3x0hhiyCd0
	yEReHlp40emTquf7EAZy6XnOF9EbCGBx4qPQVzIZ0MpGW7TkZIpJiaitN2PiVtiz4hYrefIyIE3GL
	LN6ECWba3Hd9hg0fcP66EQtBHP/+ihDLJ0SS6hmzChK5wEUkZWeN1D0qFEovuqPRdqF0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1snhkg-0071oz-Fu; Mon, 09 Sep 2024 19:00:34 +0200
Date: Mon, 9 Sep 2024 19:00:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Herring <robh@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: ethernet-phy: Add
 master-slave role property for SPE PHYs
Message-ID: <c2e4539f-34ba-4fcf-a319-8fb006ee0974@lunn.ch>
References: <20240909124342.2838263-1-o.rempel@pengutronix.de>
 <20240909124342.2838263-2-o.rempel@pengutronix.de>
 <20240909162009.GA339652-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909162009.GA339652-robh@kernel.org>

On Mon, Sep 09, 2024 at 11:20:09AM -0500, Rob Herring wrote:
> On Mon, Sep 09, 2024 at 02:43:40PM +0200, Oleksij Rempel wrote:
> > Introduce a new `master-slave` string property in the ethernet-phy
> > binding to specify the link role for Single Pair Ethernet
> > (1000/100/10Base-T1) PHYs. This property supports the values
> > `forced-master` and `forced-slave`, which allow the PHY to operate in a
> > predefined role, necessary when hardware strap pins are unavailable or
> > wrongly set.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> > changes v2:
> > - use string property instead of multiple flags
> > ---
> >  .../devicetree/bindings/net/ethernet-phy.yaml      | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > index d9b62741a2259..025e59f6be6f3 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > @@ -158,6 +158,20 @@ properties:
> >        Mark the corresponding energy efficient ethernet mode as
> >        broken and request the ethernet to stop advertising it.
> >  
> > +  master-slave:
> 
> Outdated terminology and kind of vague what it is for...
> 
> The usual transformation to 'controller-device' would not make much
> sense though. I think a better name would be "spe-link-role" or
> "spe-link-mode".

This applies to more than Single Pair Ethernet. This property could
also be used for 2 and 4 pair cables. So spe-link-mode would be wrong.

Also:

https://grouper.ieee.org/groups/802/3/dc/comments/P8023_D2p0_comments_final_by_cls.pdf

On 3 December 2020, the IEEE SA Standard Board passed the following resolution. (See
<https://standards.ieee.org/about/sasb/resolutions.html>.)

  "IEEE standards (including recommended practices and guides) shall
  be written in such a way as to unambiguously communicate the
  technical necessities, preferences, and options of the standard to
  best enable market adoption, conformity assessment,
  interoperability, and other technical aspirations of the developing
  standards committee. IEEE standards should be written in such a way
  as to avoid non-inclusive and insensitive terminology (see IEEE
  Policy 9.27) and other deprecated terminology (see clause 10 of the
  IEEE SA Style Manual) except when required by safety, legal,
  regulatory, and other similar considerations.  Terms such as
  master/slave, blacklist, and whitelist should be avoided."

  In IEEE Std 802.3, 1000BASE-T, 10BASE-T1L, 100BASE-T1, 1000BASE-T1,
  and MultiGBASE-T PHYs use the terms "master" and "slave" to indicate
  whether the clock is derived from an external source or from the
  received signal. In these cases, the terms appear in the text,
  figures, state names, variable names, register/bit names, etc. A
  direct substitution of terms will create disconnects between the
  standard and the documentation for devices in the field (e.g., the
  register interface) and also risks the introduction of technical
  errors. Note that "master" and "slave" are also occasionally used to
  describe the relationship between an ONT and an ONU for EPON and
  between a CNT and a CNU for EPoC.

  The approach that other IEEE standards are taking to address this
  issue have been considered. For example, IEEE P1588g proposes to
  define "optional alternative suitable and inclusive terminology" but
  not replace the original terms. (See
  <https://development.standards.ieee.org/myproject-web/public/view.html#pardetail/8858>.)
  It is understood that an annex to the IEEE 1588 standard has been
  proposed that defines the inclusive terminology. It is also
  understood that the inclusive terminology has been chosen to be
  "leader" and "follower".

  The IEEE P802.1ASdr project proposes to align to the IEEE P1588g
  inclusive terminology.  (See
  <https://development.standards.ieee.org/myprojectweb/public/view.html#pardetail/9009>.)
  Based on this, it seems reasonable to include an annex that defines
  optional alternative inclusive terminology and, for consistency, to
  use the terms "leader" and "follower" as the inclusive terminology

The 2022 revision of 802.3 still has master/slave when describing the
registers, but it does have Annex K as described above saying "leader"
and "follower" are optional substitutions.

The Linux code has not changed, and the uAPI has not changed. It seems
like the best compromise would be to allow both 'force-master' and
'force-leader', as well as 'force-slave' and 'force-follower', and a
reference to 802.3 Annex K.

As to you comment about it being unclear what it means i would suggest
a reference to 802.3 section 1.4.389:

  1.4.389 master Physical Layer device (PHY): Within IEEE 802.3, in a
  100BASE-T2, 1000BASE-T, 10BASE-T1L, 100BASE-T1, 1000BASE-T1, or any
  MultiGBASE-T link containing a pair of PHYs, the PHY that uses an
  external clock for generating its clock signals to determine the
  timing of transmitter and receiver operations. It also uses the
  master transmit scrambler generator polynomial for side-stream
  scrambling. Master and slave PHY status is determined during the
  Auto-Negotiation process that takes place prior to establishing the
  transmission link, or in the case of a PHY where Auto-Negotiation is
  optional and not used, master and slave PHY status

	Andrew

