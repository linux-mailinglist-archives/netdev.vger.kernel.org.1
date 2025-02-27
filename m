Return-Path: <netdev+bounces-170072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5FBA47323
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 03:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8569E1612B2
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 02:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348A813A3F2;
	Thu, 27 Feb 2025 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjOJqUhc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0204F38FA6;
	Thu, 27 Feb 2025 02:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740624180; cv=none; b=FiOFlI1hhjuZ8k0kUqeLLkZ2qiumV7/u+61JS2i12YK/NSpIk9az1fnryhHCK6NmJxcIasZdBrmDducw93CZ+fibdRTE0SN//KbZKSVW9ZFkEHLUmPCfQbG2QBGASIw6xcH4nHGSZyCUfOI8rLW4erIUU7jyNfflm19GQ2PWUKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740624180; c=relaxed/simple;
	bh=li2iweD8ayjzhajKjBDQU/GJ/ss1c888QNKpO0jKR5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Alv3gAhVEiSEW2FGjoxF7N8I13m+iy9S8bCEM0uFyYlno3S7d/MsCpzMu7qpq7n5ldkmyOeDgw3TzAXJBe2Te8REj32nH8VCLN/YREVAvZOiVnFm+bXs8FNjuVuZeNbwyGfm+5ty5Mo6YTdbniz+Q2bEyeoFrVVnLTTlEN0Ae7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjOJqUhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93937C4CED6;
	Thu, 27 Feb 2025 02:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740624179;
	bh=li2iweD8ayjzhajKjBDQU/GJ/ss1c888QNKpO0jKR5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NjOJqUhcQXVFuo0ldSHpo6By1r3YFYYo3rkU1CeLNZyfipXDOgVZhQo6DTXWuQLT5
	 /K4bYsU/V8MmD4hS9eKk/rX5zO4GeJiPEBe9QO9KfRE6DIFaIMKaaHAWPthja/rtOA
	 g5YkGlQuzuW47ZMh90tcpQ/N8UFcvri1SGC0WfC/bufpnuLGbV8ngoZ4m00az11g46
	 /gG3s7jWgTzFiBJn+pKmTyY/EPINeXWoklGiBgbdIfeR/ZSLYxyUWy5P54ekUzW1fq
	 4FQ3x+PcuVPaWUb9FMfZtWh8EIiXqKIMMpWJaZ/RcwUznGeIBnghwtnHmSN3Nc7RTR
	 q479WWuy/tHxg==
Date: Wed, 26 Feb 2025 18:42:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250226184257.7d2187aa@kernel.org>
In-Reply-To: <Z76vfyv5XoMKmyH_@pengutronix.de>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
	<20250218-feature_poe_port_prio-v5-6-3da486e5fd64@bootlin.com>
	<20250220165129.6f72f51a@kernel.org>
	<20250224141037.1c79122b@kmaincent-XPS-13-7390>
	<20250224134522.1cc36aa3@kernel.org>
	<20250225102558.2cf3d8a5@kmaincent-XPS-13-7390>
	<20250225174752.5dbf65e2@kernel.org>
	<Z76t0VotFL7ji41M@pengutronix.de>
	<Z76vfyv5XoMKmyH_@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 07:06:55 +0100 Oleksij Rempel wrote:
> Here is one example how it is done by HP switches:
> https://arubanetworking.hpe.com/techdocs/AOS-CX/10.08/HTML/monitoring_6200/Content/Chp_PoE/PoE_cmds/pow-ove-eth-all-by.htm
> 
> switch(config)# interface 1/1/1    <---- per interface
> switch(config-if)# power-over-ethernet allocate-by usage
> switch(config-if)# power-over-ethernet allocate-by class
> 
> Cisco example:
> https://www.cisco.com/c/en/us/td/docs/switches/datacenter/nexus9000/sw/93x/power-over-ethernet/configuration/configuring-power-over-ethernet/m-configuring-power-over-ethernet.html
> 
> switch(config)# interface ethernet1/1   <---- per interface
> switch(config-if)# power inline auto

I don't see any mention of a domain in these docs.
This patchset is creating a concept of "domain" but does 
not expose it as an object.

