Return-Path: <netdev+bounces-222743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB0AB55A78
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 01:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB5677A2CB6
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 23:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F3428469B;
	Fri, 12 Sep 2025 23:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DinqVdA/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB87494;
	Fri, 12 Sep 2025 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757721284; cv=none; b=tH5mmENQ1MfaMR5b+KEsJ9sQkjocULU8ZZfsBHYfrEK17+o/CQNpoXuCJJIC2WoTliwawUFPdczu4qScM+KtGSHRAJqJ6bfQKjgZREuDZmN+91BKjbHarga1wwHc36ImXse/rxAvHSW+MgXCZonuDvtA2MjeHx3VI+QcstTQn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757721284; c=relaxed/simple;
	bh=1yk++boy0iy5FJE0t4WFA49gcNkY6JHhuQy9y+mC7s8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6PMGQNyYFlqkZyq9aCK0F1gYvMyZlJCYKm1Bpo6nMMKuPBM84SOALQEIgiATKbMsgZqoAMaG9OdDbe+KZkBGcGXQTdMgpv8UMrWfHks5w7eawxzcE/ppmOJybDL+QTD2EGYGOvsFQS5byakobstV26eIZFdowZB8KYKb8sA7JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DinqVdA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAF0C4CEF1;
	Fri, 12 Sep 2025 23:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757721283;
	bh=1yk++boy0iy5FJE0t4WFA49gcNkY6JHhuQy9y+mC7s8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DinqVdA/NUdddf35zIasPzhhnDNZvjTjHqquGLCkxiqYF8HqWwqMezy839j5TXILw
	 7Q4obwimADA8rCmIfiGqxnDRD3jVvqAUHRqu6imtJ6SDd0x1viimgmbURitTz8MXTQ
	 ISwqb5xSLVES3IZRqoI5bKoms4M2EeoFq6q/KTrnpd2QSs9oQLQeaoaEZmjeCVjl4x
	 roJp7fxb+qFvQbtp4tI27UZbsdnK81Zjm3w4WX2rRSufiaKc9TLvyTJ9a5io4pLOM2
	 lw2F0SDsEag8k0ofO6P9nMxj6BMIYTRy5itkm3OJRCss525eRMu7EvKVemx8qE+3LH
	 xSDfamdCUeJbA==
Date: Fri, 12 Sep 2025 16:54:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Kory Maincent
 <kory.maincent@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Nishanth Menon <nm@ti.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 linux-doc@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk
 <roan@protonic.nl>
Subject: Re: [PATCH net-next v5 1/5] ethtool: introduce core UAPI and driver
 API for PHY MSE diagnostics
Message-ID: <20250912165442.2e3bc13e@kernel.org>
In-Reply-To: <aMP0F0NVrIHk7jBY@pengutronix.de>
References: <20250908124610.2937939-1-o.rempel@pengutronix.de>
	<20250908124610.2937939-2-o.rempel@pengutronix.de>
	<20250911192318.0628831f@kernel.org>
	<aMP0F0NVrIHk7jBY@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 12:21:11 +0200 Oleksij Rempel wrote:
> > > All investigated devices differ in MSE configuration parameters, such
> > > as sample rate, number of analyzed symbols, and scaling factors.
> > > For example, the KSZ9131 uses different scaling for MSE and pMSE.
> > > To make this visible to userspace, scale limits and timing information
> > > are returned via get_mse_config().  
> > 
> > But the parameter set is set by the standard? If not we should annotate
> > which one is and which isn't.  
> 
> Do you mean we should show which parameters are defined by a standard
> (for example Open-Alliance - MSE/pMSE) or which parts of the measurement
> method - like how many samples in what time - are vendor or product
> specific?

Yes. Your call if it really makes sense, but if we have a mix it's good
to mention which ones are safe(r) to depend on in mixed environments.
One way to do this would be to annotate the standard ones with standard
references but doesn't seem like the OA standard lends itself to
concise ways of referring to it (like IEEE standards do).

> And should we only write this in comments/docs, or add a flag/enum so
> user space can detect it?

Just comments/docs

