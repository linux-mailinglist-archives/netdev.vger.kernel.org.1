Return-Path: <netdev+bounces-109028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDC89268E0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585831F23094
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D38188CAE;
	Wed,  3 Jul 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut843I53"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A9741A81;
	Wed,  3 Jul 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033959; cv=none; b=bJ5u0PfgAr5K+lGTXtIaCYHzzlEmaXpcxUR3THv3enBbE7ItFR14YLCmUKxfkrrXFPlntUONz9qQxlLUqULYGw0Uik1rGBRaSwHhPNSZX2B9UCNZEVaw6YSkPIyWisFSIP7Iyl19SY6+tVBxSK+oFBbpfpRdYy2+7v4Ex5rLXe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033959; c=relaxed/simple;
	bh=W2TV0tGrwkg2U2nDDi7LC0UCR05ZRDjKA7OZgxB/bVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9iuUiliXBOcMlXX9Z5bCSW2pQ6coto6XkkYMHk84z+nmXLYblm88yCGPdMKFOTU7GBxF0vSnevYCGP7pwQTr6PhMgg2erb7j1O+YyVxm14IMWMTrHLc/B0YQ7e8k4WsRDAy+NEGMrAQ1hwLgUH/4DoCDqdk0eQwPdgQ4I136+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut843I53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F97C2BD10;
	Wed,  3 Jul 2024 19:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720033959;
	bh=W2TV0tGrwkg2U2nDDi7LC0UCR05ZRDjKA7OZgxB/bVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ut843I53JZz/Ny77u61NsPKMd05t/m3FYzT2+ZkMRPxjY/MxqdRQ/gw7sHX/UpSsF
	 gojYoZk14OiQ6e8ysFX47iaSLTbknKTI81QMsOfzWqRxoDJFb0Y4oF9rukqa5G9sPv
	 FcKwPfBwvFY95L1Xa7zv4mpcdRaFhI50qdozouxDA7Nq5vStsgacIDJp+d6fah+AcV
	 DGTVxZ1AIUa58R1k6+b1LpBdkDXpISKIoOU3eTUhIE+oxKV+c4Ba3SeP3nfjesDbis
	 Yk1KcZqQq/i5EtxGSl0EfVfBf33S5qg+TtrCgP/P0GUG7AQRvr+sh6E0hEXRySGxnk
	 5GvvCZoRpzwIw==
Date: Wed, 3 Jul 2024 12:12:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, mwojtas@chromium.org, Nathan Chancellor
 <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>, Marc Kleine-Budde
 <mkl@pengutronix.de>
Subject: Re: [PATCH net-next v14 12/13] net: ethtool: strset: Allow querying
 phy stats by index
Message-ID: <20240703121237.3f8b9125@kernel.org>
In-Reply-To: <20240703085515.25dab47c@fedora-2.home>
References: <20240701131801.1227740-1-maxime.chevallier@bootlin.com>
	<20240701131801.1227740-13-maxime.chevallier@bootlin.com>
	<20240702105411.GF598357@kernel.org>
	<20240703085515.25dab47c@fedora-2.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 08:55:15 +0200 Maxime Chevallier wrote:
> > Elsewhere in this function it is assumed that info may be NULL.
> > But here it is dereferenced unconditionally.  
> 
> Hmm in almst all netlink commands we do dereference the genl_info *info
> pointer without checks.
> 
> I've looked into net/netlink/genetlink.c to backtrack call-sites and it
> looks to be that indeed info can't be NULL (either populated from
> genl_start() or genl_family_rcv_msg_doit(). Maybe Jakub can confirm
> this ?
> 
> If what I say above is correct, I can include a small patch to remove
> the un-necessary check that makes smatch think the genl_info pointer can
> be NULL.

The info used to be null during dumps, but I think we fixed that in
f946270d05c2 ("ethtool: netlink: always pass genl_info to .prepare_data")
Perhaps I should have cleaned up existing code :S

