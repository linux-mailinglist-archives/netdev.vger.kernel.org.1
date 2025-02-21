Return-Path: <netdev+bounces-168336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A476EA3E960
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D982A19C33AA
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EDC17BD3;
	Fri, 21 Feb 2025 00:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQJZSY+k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E07AD5A;
	Fri, 21 Feb 2025 00:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099092; cv=none; b=R6oQ/vIRn1FMgUs7CL1M/8eRWevDZaCMnjd2Cl5Pr3rEbEF1rjC79GKYIrn5mlgrO6uN7mY5p3IY5NQVxiLTu0HQdwWppLG7UlXISyZWt4tdEg4KaLYy3NUGcfnQHreakEb08GhDS0yj6mPJKcyjfC0Zhn7SLqiad/MqeLBIGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099092; c=relaxed/simple;
	bh=hW4wGLaf2xdlM07uA+sCXCsxkAV2jQGuYqWF2fHUxHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a62813486PxWZueGDqzaEvtglTIzKy6hNkqtVjqIltM3Lesoei9i0k6h8QcysBin+vcc/RiStN9duZmovzN3l0oh/JIUHpaddj+UT5vDn2gisQsIMzlN0RzDXOC4iq5JO04cpNCzVQenyihGbj0cLLPEjI/G9aMxhN/5LiJabOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQJZSY+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0353EC4CED1;
	Fri, 21 Feb 2025 00:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740099091;
	bh=hW4wGLaf2xdlM07uA+sCXCsxkAV2jQGuYqWF2fHUxHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kQJZSY+kVznhl6ctFk+4yIj2pX/pCM3pmHlvAfd6jRtxyCCWNs+5F/jdM2FBAnMuc
	 RYhWgJLkrjNOIDF0/j3blLHbO2Zd1Q3xrRT2Wd+xzk4p/izw80LWiz/Cgsyd3mdlIG
	 2UsiAKF5i/Q4KoIEr+8S4zan3jEuRpHsLYDWAYcGlQTn5RdLV5W6arVWmz4tmrqi9e
	 fyp8XdSPSv3Ypc7HB2qkUvkuJkIr6eJZcg4NlQvlIT1I0AKArCIb3ZEKbd5vsbtQta
	 OWVatMSq90QdoBE6RDt0C/wpfYf5I1AgKBlT5khxkrtYh6v9TOHpvJ3kVGYMzgo+2D
	 +hDF0wQA4ocVA==
Date: Thu, 20 Feb 2025 16:51:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
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
Message-ID: <20250220165129.6f72f51a@kernel.org>
In-Reply-To: <20250218-feature_poe_port_prio-v5-6-3da486e5fd64@bootlin.com>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
	<20250218-feature_poe_port_prio-v5-6-3da486e5fd64@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 17:19:10 +0100 Kory Maincent wrote:
> This patch introduces the ability to configure the PSE PI budget evaluation
> strategies. Budget evaluation strategies is utilized by PSE controllers to
> determine which ports to turn off first in scenarios such as power budget
> exceedance.
> 
> The pis_prio_max value is used to define the maximum priority level
> supported by the controller. Both the current priority and the maximum
> priority are exposed to the user through the pse_ethtool_get_status call.
> 
> This patch add support for two mode of budget evaluation strategies.
> 1. Static Method:

The "methods" can be mixed for ports in a single "domain" ?
On a quick read I don't see this explained
-- 
pw-bot: cr

