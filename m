Return-Path: <netdev+bounces-243764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B177CA6CC2
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 10:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 008C930FF052
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 09:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404AC314D18;
	Fri,  5 Dec 2025 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIMB1onV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A143148C7;
	Fri,  5 Dec 2025 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925450; cv=none; b=lNuHw1wJ679oFLwXG+lEjRVWtadoGWRbnadhsW/wgYHTFh+LBYujjUj8l1NJCDYOpgCdOe6jwyY/ZI74hc0yO9wuuETgtAh1TClN+uK7cSFlMKy3AAOCLw4Ek3ldpWRip3iXzy1n/accMkP4Yuo78C9YN6ddc6cMC//huzzNHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925450; c=relaxed/simple;
	bh=BxE0e+caw3Snb3Rg48meeXbs3obscY/tAU3AAvuIk6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVG0jwm16Cr/X4WmboiQP4x1ItsJryvXEhbxtuItUikI0IV0bKOeJzMC+BmG+hSDNUK7vmpK04cgbMhkerz9KmIDqQqCkfYabNGqxOMaPmeYC5udMXiALwMEqV0tLLVxFB/fiKQpuohKbQRkAtWWjX15TuxmdqIhJbYN+WFRurQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIMB1onV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF881C4CEF1;
	Fri,  5 Dec 2025 09:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764925449;
	bh=BxE0e+caw3Snb3Rg48meeXbs3obscY/tAU3AAvuIk6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIMB1onVT6FJYzJrxtTgU+gSwTRoz6PSYiwUgh0JQjvXDFoS4u+moLhnpYdW8kgON
	 Gomu+aPCpkhgCPVI8x0EiV77csrfM6b4TwBnmRdqoKQbhVdF8A3/JAuDgxfppTBmf3
	 urU79klX3twc6jPskpt8nVIfVFcAueXOFQDpF69NXQYyTiGEyXHnSw5JDgNPuQGRA1
	 lMA1wikmop7h+leZup4df3tJc422z4HXBLrT+5FgUSEescUCavmRe6NVX1qAAwtdQl
	 Fb5PKbU+WkiTEJeJO+pZl44j4S6IuNQ7JhEbMpsw+7N5Q6XSIi5GBPdtG6Vs3odvqn
	 t6XpEw+8T4FjQ==
Date: Fri, 5 Dec 2025 10:04:06 +0100
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
Subject: Re: [net-next,PATCH v2 2/3] dt-bindings: net: realtek,rtl82xx:
 Document realtek,ssc-enable property
Message-ID: <20251205-sly-nano-barnacle-ca25fe@quoll>
References: <20251203210857.113328-1-marek.vasut@mailbox.org>
 <20251203210857.113328-2-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251203210857.113328-2-marek.vasut@mailbox.org>

On Wed, Dec 03, 2025 at 10:08:05PM +0100, Marek Vasut wrote:
> Document support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
> RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. Introduce DT properties
> 'realtek,clkout-ssc-enable', 'realtek,rxc-ssc-enable' and
> 'realtek,sysclk-ssc-enable' which control CLKOUT, RXC and SYSCLK
> SSC spread spectrum clocking enablement on these signals. These
> clock are not exposed via the clock API, therefore assigned-clock-sscs
> property does not apply.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


