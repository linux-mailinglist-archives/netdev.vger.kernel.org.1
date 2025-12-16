Return-Path: <netdev+bounces-244920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA86CC271C
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 12:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BFDE30A8B25
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 11:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47099346780;
	Tue, 16 Dec 2025 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on4ijzMY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB2634676E;
	Tue, 16 Dec 2025 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885080; cv=none; b=RizkMsTCgv0v9gX1rXbhe9gooppquuwWYri81GfQ4ZT2SPp7Cdm7uANkR6Kd4TxPC2xxWbGEmqlcwQNAuGilpXnBt/Ixrgxx0ISGASTmFomIcxbc9sVLK8/blIv3eqD3ZWogM2rILPImWF6miF9c2sG+5RQHAwbNQe/yohOB+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885080; c=relaxed/simple;
	bh=CrdABhYBrcF6U9Ho9bznYsHpDGaFvExEHwYjF1QfUr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo9hmVD7/D08E9RrN4UmgqVk2smXC41tTfokldz41lzn6zQe7Kbov5nFxvjr10EebehwnFMTWiZ88xwstkU/lybqy2oVky3ou4cl8gMmnxDyFw/RA3iWrSL6/gzZIyCzuPOcLvrZ5upyErk0/EB+omfH6wgfuOnfUEN/EuW+K5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on4ijzMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139D0C4CEF1;
	Tue, 16 Dec 2025 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765885079;
	bh=CrdABhYBrcF6U9Ho9bznYsHpDGaFvExEHwYjF1QfUr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=on4ijzMYJ6VhEonLk+l2ceSnk9+dqO3/eUemiwMfoNJ7iX1UA2P2ixbtQAp0XhBYp
	 UbNt9dXw8RO1q542aFQC7hA9MZLZl+crLhFXXpI4pILSC6mtiE3Xhd82u/0u9nxHdS
	 QPUiVIRlPw8cf6lNlDmcxxA4eucBonHi5S19lTB3eR2qjAoSPyMOp7JF6Kwn0pkEoY
	 1/NlGmfCdUKV5P31V5SE9bUZZMNSgtRKPomcJCJFB8g9+K/nT0Efez8V0zarHj8cZy
	 /q8lbyzJX4rX9N859W2I2y8bjH60askOmKtFta0y8cCrwVRpQtQdOPJMkPZh8vrxWz
	 Z4WSLMlrqtrFA==
Date: Tue, 16 Dec 2025 11:37:55 +0000
From: Simon Horman <horms@kernel.org>
To: bestswngs@gmail.com
Cc: security@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xmei5@asu.edu
Subject: Re: [PATCH net v4] net: skbuff: add usercopy region to
 skbuff_fclone_cache
Message-ID: <aUFEk8QPIAIEHcsF@horms.kernel.org>
References: <20251216084449.973244-5-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216084449.973244-5-bestswngs@gmail.com>

On Tue, Dec 16, 2025 at 04:44:53PM +0800, bestswngs@gmail.com wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> skbuff_fclone_cache was created without defining a usercopy region, [1]
> unlike skbuff_head_cache which properly whitelists the cb[] field.  [2]
> This causes a usercopy BUG() when CONFIG_HARDENED_USERCOPY is enabled
> and the kernel attempts to copy sk_buff.cb data to userspace via
> sock_recv_errqueue() -> put_cmsg().

...

Hi Weiming Shi,

Please slow down.

When posting patches to the Netdev ML please allow 24h to 24h should elapse
between versions. This is to allow time for review. And reduce load on
shared CI infrastructure.

See: https://docs.kernel.org/process/maintainer-netdev.html

Also, I do not believe it is appropriate to involve security@kernel.org
in reports that are made public. As there is nothing left for the security
officers to do.

See:
- https://lore.kernel.org/netdev/CANn89i+3_50FX1RWutvipTMROD3FnK-nBeG4L+br86W85fzRdQ@mail.gmail.com/
- https://www.kernel.org/doc/Documentation/process/security-bugs.rst

Thanks!

