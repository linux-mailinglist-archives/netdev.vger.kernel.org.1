Return-Path: <netdev+bounces-109980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C31992A8F9
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2807FB21353
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5050149DFA;
	Mon,  8 Jul 2024 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUjY2FKm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A404A149C60;
	Mon,  8 Jul 2024 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720463582; cv=none; b=tngZfoUhMGvUFGAInctiVcX0SLFcax+1X6SDwS2DSv4al2yBzS68OBoJusloJXhpZ8D127eM37JuPCHTbEzgQ16cQowEO9NxVl+SzFMMFWBt216q4UZUmwICj1llNMIix9Wy8VhUSQbO/7K1DjrAQ1adDwrsrPpTfhnGaADj/gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720463582; c=relaxed/simple;
	bh=KlhIji6fttN1x/SuLkmgEm0UYEtfE/gtPa7l/csoIQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0aazo6hgJuvHWmzgYen4MbcMTldccjAL3IO1ac7klg+NlITA97HGyjDolaGhcAeZIXtbg6f7OUd0eH8p0QkUsGFKA7IfxDlJQqOWfyXN6SvEPq/ycSJ2uUH66wSh0nuR24ei+6bZmoDE2hf9FlwiliihjzF+3oUCqe+YjhUDTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUjY2FKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90D2C4AF0B;
	Mon,  8 Jul 2024 18:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720463582;
	bh=KlhIji6fttN1x/SuLkmgEm0UYEtfE/gtPa7l/csoIQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fUjY2FKmbf1k3PeDlo0rojuAuNY+XEou808qqCdBFmJrh9+dbwo5rS0WhqHg2OZgl
	 IbzuxmWW1e2LU1w7zP4wCrghMH7EpZRCL7Svzs5tA5gD3oaC5j6gauxu9i6LjFCJwl
	 dWFPb4h856sldakLWBe7Teh95gyyPefGkhlOSke2Lq6GQIHBqljSpo0xqmBV8WabaA
	 T1RFEYh8YdXOp1T1H/pq9cadVNtEtpbAa+bETwd+gQyh+n72RJm/sJs80/0TBiZrtc
	 tavakNtybfK4JjZhdlCqPICLSUFC/imr7szrOYZdYfzd0KGxtYHuEjpfFIxq3DzICS
	 E4POah8BbIDEA==
Date: Mon, 8 Jul 2024 11:33:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/7] net: ethtool: Add new power limit get
 and set features
Message-ID: <20240708113300.3544d36d@kernel.org>
In-Reply-To: <20240708113846.215a2fde@kmaincent-XPS-13-7390>
References: <20240704-feature_poe_power_cap-v6-0-320003204264@bootlin.com>
	<20240704-feature_poe_power_cap-v6-5-320003204264@bootlin.com>
	<20240705184116.13d8235a@kernel.org>
	<20240708113846.215a2fde@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jul 2024 11:38:46 +0200 Kory Maincent wrote:
> > This smells of null-deref if user only passes one of the attributes.
> > But the fix should probably be in ethnl_set_pse_validate() so it won't
> > conflict (I'm speculating that it will need to go to net).  
> 
> Mmh, indeed if the netlink PSE type attribute is different with the supported
> PSE type we might have an issue here.
> 
> I am wondering, if I fix it in net won't it conflict with net-next now that
> this series is merged?

Don't worry I understand the code well enough to resolve any conflicts
(famous last words?). And if we fix as part of ethnl_set_pse_validate()
then there's no conflict, AFAICT.

