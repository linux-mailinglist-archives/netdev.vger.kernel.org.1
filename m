Return-Path: <netdev+bounces-243763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78052CA7724
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 12:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 663113148E8A
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0809F2D7805;
	Fri,  5 Dec 2025 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWsdHqIu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92160311972;
	Fri,  5 Dec 2025 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925405; cv=none; b=g8pG5+Q7MI4E2k2uZm3T7Z0mzryFlVOLP0QJGpxs20fSPeaFEo2tdDdaagnxa4wiXp/i/q6JYv1XnADotcAizFmrdk+sVWFG0XI53Jag8R6KLReMAhxjUovB/uo6Ec3vHgc6BseU3CORx5OK3SkE2wJjZ4qvha/yXutkBZ/rZ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925405; c=relaxed/simple;
	bh=cUJbSdYsszENJE/XwOV+fw3KjDANMjWcyos4YuUBrLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ongf6cJvsa5AsqZToDWTauYD1rxWmv2bo1KEOcTlgbhWeDqwBsuS2AWVss/Bu7fqdAUa4og4TPszJDCUZIPRWEP3Mr4HPB+7o86qBC1fVZeueEiEbFil4uDZQGiiUFQd30WPGGjStLQKp1Pvw+GGf4IhmzmDpXDlav2ULGppOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWsdHqIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B64C4CEF1;
	Fri,  5 Dec 2025 09:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764925404;
	bh=cUJbSdYsszENJE/XwOV+fw3KjDANMjWcyos4YuUBrLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kWsdHqIugmVmPY+VbnfkbCXhop8js9VWsxJwwWB4MQ5fTnU+PcQXjGP7JyX6yu2an
	 2bDKT+COhRAJEPcODRdr5qZhs2D8xfr2A1o+BLqqDN+1PI07jHrEwodRDumwMa2f9b
	 a8HoIfHrVwTamm+CUrGfZtP5/G+1ac1i8Uujf0nTIF4vnQC0TSB9VGeMF9CUantARF
	 0fYsOjtWg1tZuh4XI7ydKo1F8rE8CZs0DpplogNMIg3tx1Bn7dWqwZuPvlyeTaJU8N
	 0VayU26AKuZr53w2fU52KkjkjXTKMgQQmrM043LwH3+NChwWUf1NtRAQTRbz3JPjtZ
	 tgW1VkC9x4zIA==
Date: Fri, 5 Dec 2025 10:03:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Ivan Galkin <ivan.galkin@axis.com>, 
	Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	devicetree@vger.kernel.org
Subject: Re: [net-next,PATCH v2 1/3] dt-bindings: net: realtek,rtl82xx: Keep
 property list sorted
Message-ID: <20251205-adamant-unselfish-cormorant-aa5acb@quoll>
References: <20251203210857.113328-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251203210857.113328-1-marek.vasut@mailbox.org>

On Wed, Dec 03, 2025 at 10:08:04PM +0100, Marek Vasut wrote:
> Sort the documented properties alphabetically, no functional change.

That's just churn, we don't do this for bindings.

Best regards,
Krzysztof


