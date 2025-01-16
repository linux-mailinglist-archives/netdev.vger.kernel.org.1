Return-Path: <netdev+bounces-159108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A712EA146BF
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815F41887FA4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A8C1F1508;
	Thu, 16 Jan 2025 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lohg3xrx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ABC1F1509
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070963; cv=none; b=HBKiwOW9CuKQEC2r+D8gNL8c+mgcOzXbIxe6prW1glhis3hxbeXocgcbCp5/vWeFEE1HU+mY2FR4jxB/MQL+HWtFbp9zEEuJ1Uh6qh5FCHidSwe3Dmh3nb8mI8WjuCINSNjnPvjUYCqmdY5zVfjdBtZaDwBumuprRViffjc+Azg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070963; c=relaxed/simple;
	bh=6JC4NQDkQ0VO6aKZ9QfAlfW0reDmeddohHswYnclaBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9GZ3UtBgiP3tIS1wT5hVAyZj6AI6tsqJxHMff/Ozr9GQaJBcGbehlDvMgIWXOfo0G1RCHEV8X3Auao91lV4XJPYAvmB5OYZnoPvk2FIjBkreAvEzncdjAvudmhvrCmvisl/V969VSxE4iaf+6JgIol+62sEwbFk08xGOZcPJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lohg3xrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E84C4CED6;
	Thu, 16 Jan 2025 23:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737070962;
	bh=6JC4NQDkQ0VO6aKZ9QfAlfW0reDmeddohHswYnclaBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lohg3xrx5jkuTIpHxtyTuh5dRuBGU5vaxL73/TAPRyiBGkYs2Ec1hD7epImLRGGh2
	 YsFjCUE8eQjeoB2qffEfAFna6aTFnCK1jA2jw7pDFWSuFu5lpR7yUqTKbCgAm7bWQc
	 8rONEN5rfe6R2DdZ/C+HwdkKS503lYKnLsqS1t/6rqbSmhjLzbHIBQqS9vvnDP8tM9
	 q4s0TBB53dX3BD7QCZKprnklTC40ePEF9J/7RuG09bEzO6z2X8I9tIyzf7/tzNouf4
	 gh/rohFCTDQqv1oWY5KwVjO3fgdmoMJiGOBnxciCbZgRSfnkgeGjvzIIKtTZWil/GK
	 Mzz04WknAXqBA==
Date: Thu, 16 Jan 2025 15:42:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, gregkh@linuxfoundation.org, mhocko@suse.com,
 stephen@networkplumber.org
Subject: Re: [RFC PATCH net-next 1/4] net-sysfs: remove rtnl_trylock from
 device attributes
Message-ID: <20250116154241.5e495e24@kernel.org>
In-Reply-To: <173703457791.6390.1011724914365700977@kwain>
References: <20231018154804.420823-1-atenart@kernel.org>
	<20231018154804.420823-2-atenart@kernel.org>
	<20250102143647.7963cbfd@kernel.org>
	<173626740387.3685.11436966751545966054@kwain>
	<20250107090641.39d70828@kernel.org>
	<173703457791.6390.1011724914365700977@kwain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 14:36:17 +0100 Antoine Tenart wrote:
> While refreshing the series, especially after adding the dev_isalive()
> check, I found out we actually do not need to drop the sysfs protection
> and hold a reference to the net device during the whole rtnl locking
> section. This is because after getting the rtnl lock and once we know
> the net device dismantle hasn't started yet, we're sure dismantle won't
> start (and the device won't be freed) until we give back the rtnl lock.
> 
> This makes the new helpers easier to use, does not require to expose
> the kernfs node to users, making the code more contained; but the
> locking order is not as perfect.
> 
> We would go from (version 1),
> 
> 1. unlocking sysfs
> 2. locking rtnl
> 3. unlocking rtnl
> 4. locking sysfs
> 
> to (version 2),
> 
> 1. unlocking sysfs
> 2. locking rtnl
> 3. locking sysfs
> 4. unlocking rtnl
> 
> This is actually fine because the "sysfs lock" isn't a lock but a
> refcnt, with the only deadlock situation being when draining it.
> 
> Version 1: https://github.com/atenart/linux/commit/596c5d9895ccdb75057978abd6be1a42ee4b448e
> Version 2: https://github.com/atenart/linux/commit/c6659bb26f564f1fd63d1c279616f57141e9f2bf
> 
> Thoughts? Apart from that question, either series is ready for
> submission.

Nice, yes, I think that works!

