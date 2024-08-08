Return-Path: <netdev+bounces-116670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E986C94B570
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D16B2276D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29532CCC2;
	Thu,  8 Aug 2024 03:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKdogcg0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18F8BF0
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 03:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087701; cv=none; b=gDJgaxxbi8+paWbSZFFJTraRYfr1n7EmBTYYtOJXbA8WyBHyZ9r+GQ4dLs89u53b7MiPKPdyrUUhvK+ZtHXqXb4oDu/e7Dox23nH9v7IXb2JXCBHkUNVf+UST9HHb3vdVeATtuxIWdddQxotCRnmCbx4VEfVd4uHL+D+smpViYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087701; c=relaxed/simple;
	bh=ktkOq9+4ea01uDNOmGVJ55tOm/JmaQ6x0hST87bC63k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4E5V1py/aNixpdD0wnuZd3sufBcsFzLMpp+L4AyfgMXuVFy/W1WHjfddyWkJN36yJT/KgbV86/xKETy6+6r7R1MnXorTrimx8w2Jmx4Nbz4xWr6eU1hoBZubeyg28xA/7i1u+ElemP4ZjeshsGZlybFjGWzw9y11d8c4fiv4F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKdogcg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBF5C32781;
	Thu,  8 Aug 2024 03:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723087701;
	bh=ktkOq9+4ea01uDNOmGVJ55tOm/JmaQ6x0hST87bC63k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MKdogcg0ew7g9BNTA362FLXQlrNsBly8J0MhPZq9Xduyqa1iC/v5fSv6sOoMXHERC
	 3twgWLgHl3kjwaaVVbOU4PHrs6xM64UgcsGXnVy2HQTSmWHBYrfzuFHkbBFxCcyXvl
	 1TdG+wfkU0n643yzxRpAMXYC+bE92vae/kzmpStVU3SwgBZ84PJCE/Gfj4sowZ3uyZ
	 ZvZl46AT3DThtJwiDwFCNSRZEMJxQNaUCHpnKKpdtWXhUnGUa0DZhSRwwSSTrGl55M
	 zot5t2bhnzQ0zIuABMFFZoGDAFla050+AZl2BK8xoLzb5tigYdnrtGS7YnYuvaPekF
	 g2Rqxlaeojfxg==
Date: Wed, 7 Aug 2024 20:28:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, aleksander.lobakin@intel.com, horms@kernel.org
Subject: Re: [PATCH net 0/3][pull request] idpf: fix 3 bugs revealed by the
 Chapter I
Message-ID: <20240807202818.12a0069a@kernel.org>
In-Reply-To: <20240806220923.3359860-1-anthony.l.nguyen@intel.com>
References: <20240806220923.3359860-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Aug 2024 15:09:19 -0700 Tony Nguyen wrote:
> The libeth conversion revealed 2 serious issues which lead to sporadic
> crashes or WARNs under certain configurations. Additional one was found
> while debugging these two with kmemleak.
> This one is targeted stable, the rest can be backported manually later
> if needed. They can be reproduced only after the conversion is applied
> anyway.
> ---
> iwl-net: https://lore.kernel.org/intel-wired-lan/20240724134024.2182959-1-aleksander.lobakin@intel.com/
> 
> The following are changes since commit 3e7917c0cdad835a5121520fc5686d954b7a61ab:
>   net: linkwatch: use system_unbound_wq
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Hm, my script doesn't like this branch, not sure why, I think it's
a bug in the script itself. But not enough time to investigate now,
I'll apply from the list.

