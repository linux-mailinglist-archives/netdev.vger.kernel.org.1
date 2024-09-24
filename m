Return-Path: <netdev+bounces-129440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D76983E1B
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29D9281FE4
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 07:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764B51448DC;
	Tue, 24 Sep 2024 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb07iLpg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD02126C0B;
	Tue, 24 Sep 2024 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162324; cv=none; b=rbd8mXxp5qP/Mc4QicuM7irHlG3YoS2f0NpWU4fW/T5Z6N9ZqnypRzrDhNYKfseM7XcnV1cDFZn8gALBK9XBbkOKFhGJ8twCyFLqFt6Vqexqs/CLJ5iI85NofuAR/R7/+Ts+7qpKydzZOOPOL0uo0F2pMKNyApiC92HGDi4uXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162324; c=relaxed/simple;
	bh=WEWPWhg1iI44D8WkJyN4SmQUz83Q960xJ2LUu70HgMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cj4bC5pj2dVoZDyIPLulUV+N1p+dgPMVYsNnQdnlz5Gj+Bn8G6L4SUXosyxWk5/93n+rpuYfzP5yIqY2kL3riGfnPvwqMzBc3a3XrEKR6DWczWLNStvZs94FxBjYP6TR9ntBWvfWRWWfROaIsCnWuzKdcBRlfxbMeHLtCvOklsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb07iLpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233BDC4CEC6;
	Tue, 24 Sep 2024 07:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727162324;
	bh=WEWPWhg1iI44D8WkJyN4SmQUz83Q960xJ2LUu70HgMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cb07iLpgPNMeKhhU1A0t8wvGbg4Ohx7PM7Kjrxh5GgMFqleEJE4Y+0KvIp2mnTHwO
	 FoU83oFWCKD8MUohvCGNRtAo2Mb577lmfcp9d4Heg1ziJt2Pjf0NR4+K3ynv/arSbx
	 QtK1/xnR6keHj2jxI5KMD3jWqwRqmGMbKU0VPmx+Fx/AAIk+T+RMdzHiwHjJ40kKHD
	 TKiVtF9NSQ9ndcYATuNlumIYwjECEs/sitxgFaMg26xt1BHNYkTCofDDRWJQEPZa9s
	 5K/ftKrK15D4j1AttU70gAonsDQmb4CSYvnRMMqak68onVT93ozcv3G6xANcC/qw2S
	 O+gMK+UoMK+Fw==
Date: Tue, 24 Sep 2024 08:18:39 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: tps23881: Fix boolean evaluation for
 bitmask checks
Message-ID: <20240924071839.GD4029621@kernel.org>
References: <20240923153427.2135263-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923153427.2135263-1-kory.maincent@bootlin.com>

On Mon, Sep 23, 2024 at 05:34:26PM +0200, Kory Maincent wrote:
> Fixed potential incorrect boolean evaluation when checking bitmask values.
> The existing code assigned the result of bitwise operations directly to
> boolean variables, which could lead to unexpected values.
> This has been corrected by explicitly converting the results to booleans
> using the !! operator.
> 
> Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Thanks Kory,

I agree that these changes are correct.
But are they fixes; can this manifest in a bug?
(If so, I suspect the Kernel is riddled with such bugs.)

...

