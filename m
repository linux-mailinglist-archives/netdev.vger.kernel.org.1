Return-Path: <netdev+bounces-125232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E89496C5B2
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D146A1C20324
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B45E1E1A23;
	Wed,  4 Sep 2024 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZxuJeXDH"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9361E132C;
	Wed,  4 Sep 2024 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472051; cv=none; b=Lpj7nnTx3cXapowFbIkQyt8UnSlVp0KkM0NfGq6ukP5dz7HjjlOq8zuROmLAZGLXfMSsU34ey8wV8+dLP0x2cqRaAJ69EJb9x/W/mofrTJ/ZOAocexaMkW0cEnjOPunz5fqH/HF70W0hrlApUttFcAPxi0bXzE2Cw3qzxUI9xNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472051; c=relaxed/simple;
	bh=psNQgG7k6QzVycEcqOGul+y9Q1/orlCLyOVGi7JufEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xc9UvY23EnBfA6prtFdHqmM3GpDPc+C5ya0bmgzzNhrEQX3P3ta2XIL8V1avAt+I3T/Mk1UHS7o8Laj4w29sMXIgq+BHQKW8sDgx+gvTpZXgbgy21qlbuB3rdwDbXQhTRL4fBr5A52COfLCa4wv7PO6EHC+4Vt3gogAnmr/aoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZxuJeXDH; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 399DBFF803;
	Wed,  4 Sep 2024 17:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725472041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5lrAIY666kuXUBCi+wo5/zYldvxY9h3q7HZm7kbftVA=;
	b=ZxuJeXDHi359wklqIU/J/WmVpxaFuHD6eG7XzZrdZDJOXnAwfp8uHoXsFSauy2mWdqFZrC
	+V3fF83Qo1UkmljlOLa5HGSTG1uSPZHv0LZASkIyTQ1t8ZCQ5gF2s3T9ATKfO1ji+zUcG0
	wT4NOK9YJrh7hPsKcZsceuXZQYYm/zWFcQqHNAwkmn1G6agd5626GLhLkivPHvoJPFR6U7
	B34NeuWmvCX5MHANfGxrbT5sZvbWMDP4aLsUoPuUaZRN2F3FH4vsb1hFs8f3p3pW61hq7J
	d/wSdpKVTNiaU2UxLvRT0EkaCfzzKpVp/CW034Q4G+ClmLUyDnSPprUjEtcNOQ==
Date: Wed, 4 Sep 2024 19:47:17 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jonathan Corbet
 <corbet@lwn.net>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH ethtool-next v2 3/3] ethtool: Introduce a command to
 list PHYs
Message-ID: <20240904194717.60ba4df6@fedora.home>
In-Reply-To: <7fpbxztptolcuz4ppppkmpmblel7mv4nh4jgkjqbdedo4hrcjc@6oo6acqfejas>
References: <20240828152511.194453-1-maxime.chevallier@bootlin.com>
	<20240828152511.194453-4-maxime.chevallier@bootlin.com>
	<7fpbxztptolcuz4ppppkmpmblel7mv4nh4jgkjqbdedo4hrcjc@6oo6acqfejas>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Michal,

On Mon, 2 Sep 2024 00:07:56 +0200
Michal Kubecek <mkubecek@suse.cz> wrote:

> On Wed, Aug 28, 2024 at 05:25:10PM +0200, Maxime Chevallier wrote:
> > It is now possible to list all Ethernet PHYs that are present behind a
> > given interface, since the following linux commit :
> > 63d5eaf35ac3 ("net: ethtool: Introduce a command to list PHYs on an interface")
> > 
> > This command relies on the netlink DUMP command to list them, by allowing to
> > pass an interface name/id as a parameter in the DUMP request to only
> > list PHYs on one interface.
> > 
> > Therefore, we introduce a new helper function to prepare a interface-filtered
> > dump request (the filter can be empty, to perform an unfiltered dump),
> > and then uses it to implement PHY enumeration through the --show-phys
> > command.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---  
> [...]
> > diff --git a/netlink/extapi.h b/netlink/extapi.h
> > index c882295..fd99610 100644
> > --- a/netlink/extapi.h
> > +++ b/netlink/extapi.h
> > @@ -56,6 +56,7 @@ int nl_set_mm(struct cmd_context *ctx);
> >  int nl_gpse(struct cmd_context *ctx);
> >  int nl_spse(struct cmd_context *ctx);
> >  int nl_flash_module_fw(struct cmd_context *ctx);
> > +int nl_get_phy(struct cmd_context *ctx);
> >  
> >  void nl_monitor_usage(void);
> >    
> 
> Please add also a fallback to !ETHTOOL_ENABLE_NETLINK branch, similar
> to other netlink handlers, so that a build with --disable-netlink does
> not fail.

You're right, I'll add a fallback for that. I actually just faced that
exact issue trying to build this patchset using a fresh buildroot
setup, having forgotten to add netlink libraries.

Thanks for the reviews,

Maxime

