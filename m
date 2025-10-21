Return-Path: <netdev+bounces-231425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505F7BF9301
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7865868E0
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59822BE053;
	Tue, 21 Oct 2025 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnuUWCvJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15329BDAA;
	Tue, 21 Oct 2025 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088489; cv=none; b=HrEZutQ6sgF3Wg0mTGNqnGdlH7z/BlXh7F5OiMVOXPNutV/QiSHN5dPyS+rQGpFR6LqY73BZGga3secWHG1pMqfPBwLYv0l916+zOja1+dDM7QJynUNCYShmd6rkToMrT3ldanzPgGqkQsM8vFVxGGMCMRg4R+4bcnpy6Ep2mxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088489; c=relaxed/simple;
	bh=7QQb4GTgchMrwGuaKApml7J8jP85IbcXmIf/phxMWxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5o1lCwn5tD7Oj7DNhXCuN+2aw2jKV/BkIM59PPOxQJ7OxAOChxMrYkLaHBwc7P2lDL5S8ZLiZG53Up6I7LkPip5W+ZSXGIA3t6VacGUhQ5CKWSHtzR+lue2TMHvNDzX5HKwso1y3hlIkUVrsNDtBhxZh8V1ngYQ1PLj7MZPbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnuUWCvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6070C4CEF1;
	Tue, 21 Oct 2025 23:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761088489;
	bh=7QQb4GTgchMrwGuaKApml7J8jP85IbcXmIf/phxMWxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OnuUWCvJVLQsSu4pWgkWaxOa83IRzjCfhvxs5XaRWnA2ixzq06zRH6n6uGPKM10gw
	 EV6uWJet0KcTtLQDUefCMwEiLnQgNVk6asZ6jUlrxdYnHaIYwUAmZ9EdMFD+bQKXW+
	 8GpiuYEj4oBU+pIw6PvDGDAdlHlwTSGZ7lVOJQeeLKVp3Bbks/90pkarDWfDmKs3I1
	 Fe4dr2QXyEB1YZVWsIgDiehqROnVHNCKL2DzWWJPoTD1GA2C0PBFrV+TT6uU3B+lvA
	 /2ZImK/7Kj0Et3cuVJbU2qMtPIcf+UyYwfAkfknZqzLD+c3IOhlm08NWkkr8gh7AY8
	 MVOXKudu7GfGw==
Date: Tue, 21 Oct 2025 16:14:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for non PTP SKUs
 for lan8814
Message-ID: <20251021161447.311a3e0f@kernel.org>
In-Reply-To: <e0a8830e-6267-4b2a-b1fa-f3cbe34bd3ba@engleder-embedded.com>
References: <20251017074730.3057012-1-horatiu.vultur@microchip.com>
	<79f403f0-84ed-43fe-b093-d7ce122d41fd@engleder-embedded.com>
	<20251020063945.dwqgn5yphdwnt4vk@DEN-DL-M31836.microchip.com>
	<e0a8830e-6267-4b2a-b1fa-f3cbe34bd3ba@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 20:11:13 +0200 Gerhard Engleder wrote:
> >> Hasn't net also switched to the common kernel multiline comment style
> >> starting with an empty line?  
> > 
> > I am not sure because I can see some previous commits where people used
> > the same comment style:
> > e82c64be9b45 ("net: stmmac: avoid PHY speed change when configuring MTU")
> > 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")  
> 
> The special coding style for multi line comments for net and drivers/net 
> has been removed with
> 82b8000c28 ("net: drop special comment style")
> 
> But I checked a few mails on the list and also found the old style in
> new patches.

We removed the check that _suggests_ the use of the superior style.
Aesthetic taste is not evenly distributed within the population.
But we still prefer the old style in netdev.

That said I don't think nit picking on comment style is productive,
in either direction.

