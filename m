Return-Path: <netdev+bounces-155412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BDBA0247C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F333A3122
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2991DBB37;
	Mon,  6 Jan 2025 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0RvsR5C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919131917E9;
	Mon,  6 Jan 2025 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163855; cv=none; b=hw1BKPcskIBwuMOjY0z+eWNFkg8M/YYJXd/u2vnUEq7DwmUejRTJ+Pskb0X4NxlbEAkwy36xSU5Yfs6gBDoBeJpnSWjUbWGmQ+XeSqaTpE+G2UzZN35YTyg3tW3oNI/tqOdheOSWKX+fauUf8KEHyRsDVIGqBM5lD1LGJjkC7QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163855; c=relaxed/simple;
	bh=6LYg1rlA0MJ220qd2hqANamMYWZBrpRvFVIe/2qfi6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnWITwEkcUYJiOImoKC5NLwy0NryRWu1h+/veiS8bGNjxULcozjzzschWPzBJAHPFj7KD3rmNUvGTCe1JqUQ7cCPXPivO5K46IFRsQQXkcZVJy412aiR0u4FVTB2qM8a9ko9ABM3pf//tKlK3KVhhWFtk7NXUdWXKqoW29wmUAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0RvsR5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F152DC4CED2;
	Mon,  6 Jan 2025 11:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736163855;
	bh=6LYg1rlA0MJ220qd2hqANamMYWZBrpRvFVIe/2qfi6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0RvsR5CIV7R7UsKEJJRo9gD7+BnowjDSbVyq+HtWzBxlKItiI9feN/ZOyKOw9+IZ
	 nHFuK0TiP3DATmPbrYEQO4D4Lxzt0utztQzplWGKuKla8Ampu8l5pN7uDHPbZ6a4tO
	 vxrxbmLmnuVSp7LCjul2xLXxKY8ohP22TY8gigHfpZLoj2TqLCrGeJxPtHYnUZeeSt
	 w0/bGe6Rb8XoLfz8BWP9x51zlbiAPsWCG3Ckhsb84b4cS1RezDiPKirkh5X5NynaH2
	 deIBKXtnCl37pw/K/1VIobLlo4TLZaEheCPemKhYJV/ZehZGByTfZ2KrzsPaB4D08e
	 jSKXNthc2Yc2A==
Date: Mon, 6 Jan 2025 11:44:10 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 4/9] i40e: Deadcode profile code
Message-ID: <20250106114410.GF4068@kernel.org>
References: <20241221184247.118752-1-linux@treblig.org>
 <20241221184247.118752-5-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221184247.118752-5-linux@treblig.org>

On Sat, Dec 21, 2024 at 06:42:42PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> i40e_add_pinfo_to_list() was added in 2017 by
> commit 1d5c960c5ef5 ("i40e: new AQ commands")
> 
> i40e_find_section_in_profile() was added in 2019 by
> commit cdc594e00370 ("i40e: Implement DDP support in i40e driver")
> 
> Neither have been used.
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


