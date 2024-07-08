Return-Path: <netdev+bounces-109820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED9A92A042
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFADA1C213F0
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C3674059;
	Mon,  8 Jul 2024 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWa5UxQK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1D51DA303
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720434659; cv=none; b=lbi1S8RPdAu9N+h+FWgCk5PdD0yShxjyl79YfNjM/0l/gEpFtmA/S1auyg3RWOMkxSJSY6aHkQGtBaUETVWgPAYsmXSfUQ7LquUbbhknaHU/riM8pMIiQhYLDjM9fDT4XRopMsO625+b6HFrCY52NLSp2VA61bs+rA+M9tKgkJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720434659; c=relaxed/simple;
	bh=uwWawgGVpEhK1EFmKVNhOB7m1ZVixLYnS/3hexxxwVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFl2LLdsRW2L4jtPK8zktTp5Dwcxp/GJcr1uGKynPNNyD69bmfR5iX52AuyafXHHrDzFoR7tGBNOzaeM6Nhqz+iwMcTWej/kEYVZGo6NU480poSw/PoN8bFH5boNNMaC3JgTOx2EDxqyuy1TeaT2n3PPj0IeTYE4aaP5pc4d52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWa5UxQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1289BC4AF0B;
	Mon,  8 Jul 2024 10:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720434658;
	bh=uwWawgGVpEhK1EFmKVNhOB7m1ZVixLYnS/3hexxxwVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWa5UxQKfrT3gqB4hm5m9Ab3IOwWBhmi9P0CSpEL70C1Xro1uQN86N/K26ef6bB6R
	 7l4jdoij3h4pMRGpe7IGkRCZCIfaFgCq+atbjsqP9NNaK1GA+t5WudbgxLhZeuX5n3
	 YUSPs28Zk4iZcOKqAjdvYYgAmEmMkfmXNj3nu4fvQJgVhcFV3i8fxZHVlP4uZx+fV4
	 0GFFFK+iHzEN5MiQpA6kJMlwK1yj3XeNGSvLWBIhteAp4hFKbnyM2D/E02gDGAG+iW
	 45me41SiAutPjah8HEUyEOTv43e78ImcKHKiEkMKjAbJE8396EkrgorHO3LmEpTF+K
	 ay6QDB1Y0xvKg==
Date: Mon, 8 Jul 2024 11:30:54 +0100
From: Simon Horman <horms@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next] selftests: forwarding: Make vxlan-bridge-1d
 pass on debug kernels
Message-ID: <20240708103054.GK1481495@kernel.org>
References: <20240707095458.2870260-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707095458.2870260-1-idosch@nvidia.com>

On Sun, Jul 07, 2024 at 12:54:58PM +0300, Ido Schimmel wrote:
> The ageing time used by the test is too short for debug kernels and
> results in entries being aged out prematurely [1].
> 
> Fix by increasing the ageing time.
> 
> The same change was done for the VLAN-aware version of the test in
> commit dfbab74044be ("selftests: forwarding: Make vxlan-bridge-1q pass
> on debug kernels").
> 
> [1]
>  # ./vxlan_bridge_1d.sh
>  [...]
>  # TEST: VXLAN: flood before learning                                  [ OK ]
>  # TEST: VXLAN: show learned FDB entry                                 [ OK ]
>  # TEST: VXLAN: learned FDB entry                                      [FAIL]
>  # veth3: Expected to capture 0 packets, got 4.
>  # RTNETLINK answers: No such file or directory
>  # TEST: VXLAN: deletion of learned FDB entry                          [ OK ]
>  # TEST: VXLAN: Ageing of learned FDB entry                            [FAIL]
>  # veth3: Expected to capture 0 packets, got 2.
>  [...]
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


