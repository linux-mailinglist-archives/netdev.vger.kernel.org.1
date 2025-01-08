Return-Path: <netdev+bounces-156106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD15A04EA6
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602BD1881563
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AA01442F2;
	Wed,  8 Jan 2025 01:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9Kdg1cI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC978F34;
	Wed,  8 Jan 2025 01:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299117; cv=none; b=cJtDJtOe4TjMShZa7v3Kqs9G1HELZUZJtdg2Whe7Odu7neQJzZMQLHKOCR7cSh4kiYg1oOdIpgrcrIdYHeTnvdoaGKW4+tviOTuLdPTmXMF6BgOsXx1oS4Z9i/+t8fEbNtxUsXKSVC/hjNz9M0oeTlaxve0DclUZLWQzfCTO1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299117; c=relaxed/simple;
	bh=nX0iAW6/+B1eNuypkCG5XfChB0i8LGUhX1WVqc0aSHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1BJX9Nuk0248SrX71+k5M6ZCe6yqCNnXZO78PH3EfFfKWFG/fj3X6Pyc9cCQJhvliRawjpIaYUZ3DAk+D1vS4QjXkCs+4zSM3ECgb59xDmrrqDyWSkH8vI/JQRDHLREmU0wGZ8PdynHdmDzi8JYbUIG1UOGYqqcFqyvqadcg1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9Kdg1cI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDBEC4CED6;
	Wed,  8 Jan 2025 01:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736299116;
	bh=nX0iAW6/+B1eNuypkCG5XfChB0i8LGUhX1WVqc0aSHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O9Kdg1cI2danTHBYaMYTGLyrE8J6xSz6PybylseMWLyS1q6ysjQWJ6W6B6K+CfeOz
	 caJAuscDDFsByig+GWjAC669EWGP5k0I7Q2mEtJfcYFloIKEJfafP6e4nyHQOgKSTd
	 T9KuRq3Muth8fee09Kpk/jOronPvXYXphXeM2IYw37EFFDjO+U1cPfgzkU2iQAMeq/
	 VnOsGvNSfJ8DFPMuKnsfJpsGuRPlv2mpSRjv7VLzdT6txvKqhzJXB38Wov3YSl7Ry6
	 vhLEYEHUByrJwllFD2zYCt/K7FaOAaJy4k/rp5Dv7jM/jxuoVgb2mEtL3ulTsfXP8U
	 brhecGZwVwKnQ==
Date: Tue, 7 Jan 2025 17:18:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 11/14] net: pse-pd: Add support for PSE device
 index
Message-ID: <20250107171834.6e688a6b@kernel.org>
In-Reply-To: <20250104-b4-feature_poe_arrange-v1-11-92f804bd74ed@bootlin.com>
References: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
	<20250104-b4-feature_poe_arrange-v1-11-92f804bd74ed@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 04 Jan 2025 23:27:36 +0100 Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Add support for a PSE device index to report the PSE controller index to
> the user through ethtool. This will be useful for future support of power
> domains and port priority management.

Can you say more? How do the PSE controllers relate to netdevs?
ethtool is primarily driven by netdev / ifindex.
If you're starting to build your own object hierarchy you may be
better off with a separate genl family.

