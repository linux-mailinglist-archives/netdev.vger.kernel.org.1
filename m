Return-Path: <netdev+bounces-229535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E31BDDC5F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD1019C2DD0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C3831B813;
	Wed, 15 Oct 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+4DSMFd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5AE31A540;
	Wed, 15 Oct 2025 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520449; cv=none; b=ZlcaLKgoeBRNxgC+21YRCgZM8W6bFByeYtLVgziZWacaF8l6xmcEksww9THVwkB79Re8dsc5VXlFizsq1+ti76CazoKWTnSVbBe+rKw0aqBgtoicrNFDwJSynQWCTXyQHuME8AGyLqvpA5EG94Vkr3IcXARhgVbVlvjsOig6mdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520449; c=relaxed/simple;
	bh=gZe1e09hVuaR1sUWbD0Oq/hA7F1zI+b/HwrTz36fKx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsbYiAIZvn4JTpgyQ+Mq3W2bpbp9cmTCYVypm9jOMlEyRzLcagz0651I4e9MtW6ZAKvnnxEiIkQp5IS37j45B+OlaLsSmRRbXW7BlwCe1fJ6DHuza3w7ohXzFcmTKCg77liIMbr44n2bzczNqE7JFL82jXv0ErPz/BVETm1nkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+4DSMFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441C5C4CEF8;
	Wed, 15 Oct 2025 09:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760520449;
	bh=gZe1e09hVuaR1sUWbD0Oq/hA7F1zI+b/HwrTz36fKx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+4DSMFdr+8fjclwLcrQFg7iZRMkmjopeDUjCd/f4hB4Q89zEroFCm1oDtp1Epkax
	 bSG+9N3uBquAmNjoajMVg8yZdb2OPlqbxPPK9QBmKSZL+RPdC5blgazvE4L837NsEJ
	 RaPnykb/DouscYnwwGXIUAMshZ/ks0siDrVtnthVUZ3N0KBo53UuSImWJc86EbIvVM
	 dbaVXA8V7Q7T2phXQPZIsj4CGZ2nS/dAbANCUYf7Ac8yU2GgokODw0FJzw1jBeHXvq
	 7oqn/6ZETGGx2piQGGRijAEOu84h/HAAUA6uqBOOsHCtqj8D2KY7eDuH+Y879sdujh
	 4ClRYmeQ4PU9A==
Date: Wed, 15 Oct 2025 10:27:24 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: usb: rtl8150: Fix frame padding
Message-ID: <aO9o_Fn3TGJNcJG6@horms.kernel.org>
References: <20251014203528.3f9783c4.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014203528.3f9783c4.michal.pecio@gmail.com>

On Tue, Oct 14, 2025 at 08:35:28PM +0200, Michal Pecio wrote:
> TX frames aren't padded and unknown memory is sent into the ether.
> 
> Theoretically, it isn't even guaranteed that the extra memory exists
> and can be sent out, which could cause further problems. In practice,
> I found that plenty of tailroom exists in the skb itself (in my test
> with ping at least) and skb_padto() easily succeeds, so use it here.
> 
> In the event of -ENOMEM drop the frame like other drivers do.
> 
> The use of one more padding byte instead of a USB zero-length packet
> is retained to avoid regression. I have a dodgy Etron xHCI controller
> which doesn't seem to support sending ZLPs at all.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
> ---
> 
> v2: update TX stats when dropping packets
> 
> v1: https://lore.kernel.org/netdev/20251012220042.4ca776b1.michal.pecio@gmail.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


