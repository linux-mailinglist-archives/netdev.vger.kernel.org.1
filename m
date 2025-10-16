Return-Path: <netdev+bounces-230138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89308BE45CA
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83A5B507D20
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F383934F48C;
	Thu, 16 Oct 2025 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkPbaxnu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AEB2FBE1A;
	Thu, 16 Oct 2025 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629903; cv=none; b=H88K386DCdeMTP2B9i2LonDDEaWnph9DmRaGtNFuKV6RUlA+pwpUaEMd4cdC3zfra375iL/ZDe5n/QRY4FCRd2Y5tEQJKFWKBjquC4qyGbH5htAK2fxINHZYK6bnVWW12iCj0uPinfgUILBK7oBvemgiAwfeG/NmTgvSrvQhOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629903; c=relaxed/simple;
	bh=OcSVZKHnTKiUOAlAdlFVsXlqkl0i0CIXsFjepstzdwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6B3Ou8m7FfbZV4PLe5eLJdzFpzXcW3SmB9GfPRPTjqG1OAp0/JjmRED7DIeBmf5Y2lvaelNFKsrU2ZKbUwiPpuDpPBvRbR+xPcHfLe5FQwF4i0fVzPT+a415LOSMSupN4y6dCFfC5oXYSilHQuxMPwRkPsuT2JJiMFx3WffJ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkPbaxnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2386C4CEF1;
	Thu, 16 Oct 2025 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629903;
	bh=OcSVZKHnTKiUOAlAdlFVsXlqkl0i0CIXsFjepstzdwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkPbaxnu47gRXO3S18DQSwlbqpOntJ1U6ut1KaqigasbhAFuoFlBEXOMApiIfj3KC
	 FM3aciq64+uR1d+mUg4piRnY+iUEHuIZi9cp+m6tF+Zodc8M4N8kIr+2SnYQ0NiuzV
	 aQNU1xG2AVnfvEt77rtGgq2v2DvfNaWkRDUSQUmyFiTitJZaZxcluixQgNPzvTE2NF
	 OODmsBzJZwKXhmlVFFaQHr1sRaGKJcoUQ5XZjeLeIGYTk8pcgHu//A9rlEEMcB6C+C
	 ZOFOYRwSbESgQwJmwvV86m67zCKd7HLNG2fk64kPUOzW2J8fhKfuMqq05oe6RYOsG6
	 2H2i93MZK4hoQ==
Date: Thu, 16 Oct 2025 16:51:38 +0100
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Krishna Kumar <krikku@gmail.com>,
	Vasudev Kamath <vasudev@copyninja.info>
Subject: Re: [PATCH net v2] Documentation: net: net_failover: Separate
 cloud-ifupdown-helper and reattach-vf.sh code blocks marker
Message-ID: <aPEUiuelF8LSBmdi@horms.kernel.org>
References: <20251016093936.29442-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016093936.29442-2-bagasdotme@gmail.com>

On Thu, Oct 16, 2025 at 04:39:37PM +0700, Bagas Sanjaya wrote:
> cloud-ifupdown-helper patch and reattach-vf.sh script are rendered in
> htmldocs output as normal paragraphs instead of literal code blocks
> due to missing separator from respective code block marker. Add it.
> 
> Fixes: 738baea4970b ("Documentation: networking: net_failover: Fix documentation")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> Changes since v1 [1]:
> 
>   - Place code block marker at the end of previous paragraph (Simon)
> 
> [1]: https://lore.kernel.org/linux-doc/20251015094502.35854-2-bagasdotme@gmail.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

