Return-Path: <netdev+bounces-172086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C315A5029E
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A72188B88C
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 14:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CA22505B6;
	Wed,  5 Mar 2025 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jW9wJ7/p"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC792505A3;
	Wed,  5 Mar 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185858; cv=none; b=shF5yICROgrAKPAJ1ypI6j6ydme4bu+FJAIvMO13YqAwRrHXjzwNd9qIqHcTL2LqfyZGnimqwIUcrW9XorDjXnPwRE+MRtmWd+oP49Y7Dc84p+oYMIZ9MHh4Fz2lktZ0Gw8H9ZV87ze9rhzY9zZBVTCpjE+iMcm31Jqc3Qgeeqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185858; c=relaxed/simple;
	bh=HDAKKlonGba8rX1tjbow73YK4MXTBgC+sezxw2K7eec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh4kob52hejA/1PIIsGJBVJ/RQLskKkGqluc4eZAzfvjkVU+J7Ld5+AFgv/nPlqVAWo6rMVYdvXCyJIh4HNVktimp9zcQekq9eZL+e2cgGV0h6GBijEO6P0gq6q32AwBfWGdMFAgXlwS2LWQ+aNCzyJwrds8cXbyGcclEpS2GJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jW9wJ7/p; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ezfHGj2cBWaEtzI2GUJQGGe0pXWbLGhCMJSGAb0XXr4=; b=jW9wJ7/ppvRin+Y4JUSWXTLaM1
	yehJW1Smm4DGYwEuwb5ZvnlCk/wtdsusMLbKAZjT74M3C2oeSJFjV1z67c8sepbl0eBldOJOSZQdq
	JShkPG3qy+eEoQwya185JoDQGas0okfzmC29Q6E+26u5/JB4hlyr6S5VfDe9Ch25F8I4Prf86oI2G
	T7OAdYOsXBDpahK2sJya6ri14yku28ZMfZ2PIEqjK0tfSFMvKSDAUdxE3d3nqbI9oi+Qg8e/SAtY2
	pS8pI8x/yJhA8HBfvyDWjao6InfAmpX3NHEWmFtK97D06F3vJMQd+CAkQPfOy5VeVYS6rNCf6tRCg
	0A+NQqJw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45016)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tppyZ-0004Sc-2H;
	Wed, 05 Mar 2025 14:43:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tppyS-0005rB-2p;
	Wed, 05 Mar 2025 14:43:52 +0000
Date: Wed, 5 Mar 2025 14:43:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v8 2/2] net: stmmac: dwc-qos: Add FSD EQoS support
Message-ID: <Z8hjKI1ZqU19nrTP@shell.armlinux.org.uk>
References: <20250305091246.106626-1-swathi.ks@samsung.com>
 <CGME20250305091856epcas5p4228c09989c7acfe45a99541eef01fbcd@epcas5p4.samsung.com>
 <20250305091246.106626-3-swathi.ks@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305091246.106626-3-swathi.ks@samsung.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 05, 2025 at 02:42:46PM +0530, Swathi K S wrote:
> The FSD SoC contains two instance of the Synopsys DWC ethernet QOS IP core.
> The binding that it uses is slightly different from existing ones because
> of the integration (clocks, resets).
> 
> Signed-off-by: Swathi K S <swathi.ks@samsung.com>

This looks much better!

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

