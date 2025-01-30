Return-Path: <netdev+bounces-161576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B09DA2274C
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 01:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2797188521A
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 00:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458FD20DF4;
	Thu, 30 Jan 2025 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBiuGoBY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A995168B1;
	Thu, 30 Jan 2025 00:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738197910; cv=none; b=p9PqYxdPxV4gIZi8rp1egTzOzuIcI52HE1E4MkiMWsRe4LDiI8myuBG/BaH/oFhkkJ29+JhRxe9CuFxS3yWlplVfXZ1Wr8G9iVR6QND+i0HQP+oUgYt8hF6XaEW63NJtpxThQ6W49+nsAPBLwkxQMQxYTwWjXZRGhrLdCDhzikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738197910; c=relaxed/simple;
	bh=rNCHKpukraGPY9nw8zrXwFCyXJM6fihAiBVS4Ahaxlc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOWOoeV3agkd5O6+vY4Xcxd1SrLjAIKxEzvcm/tmHqtA+rfGd8kCKcTXVaLhA9JATLltFatcPGR1vtkWvJGQ2yPkx1YNJJtLfR69WE6FYogiRH5F29E1HFczzDWy0q6EYgSAtKxmtqXjUYI3iXdNnlurnCmfLyEJDoOoelFuYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBiuGoBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D68C4CED1;
	Thu, 30 Jan 2025 00:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738197909;
	bh=rNCHKpukraGPY9nw8zrXwFCyXJM6fihAiBVS4Ahaxlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pBiuGoBYyDYOriNJGvD7ZIdIaE5W5eejASMEgvgeO1Oxyo40yLeyHbMuJltTm+asd
	 IHCewg7OwgAO61k5eh35BUSHlMclBIIES7i3Uldl23VxQt5+pm7Or0jLphNL6FeUJQ
	 +msxUpZrbzx4c/FMSVD4rNds+1uHtdyuZEeaGhWxTRNYPKuAJejEmj4tTIpcljSbHJ
	 SNNDe/dV+lbbSJ7jaUcEKYVNC3rmi1ifHkGxfUqfIPIt6LPuixMppj2dUKBaRKfNt9
	 wEFW1JvqlQn/U21DJ8psnDeprYLXjcNBCJJQSXFHJNpexAwmO0YJWxVx0nEoHjB4NT
	 U3w7cM476bylA==
Date: Wed, 29 Jan 2025 16:45:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: ethtool: tsconfig: Fix ts filters and
 types enums size check
Message-ID: <20250129164508.22351915@kernel.org>
In-Reply-To: <20250128-fix_tsconfig-v1-2-87adcdc4e394@bootlin.com>
References: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
	<20250128-fix_tsconfig-v1-2-87adcdc4e394@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 16:35:47 +0100 Kory Maincent wrote:
> Fix the size check for the hwtstamp_tx_types and hwtstamp_rx_filters
> enumerations.

This is just a code cleanup, the constants are way smaller than 32
today. The assert being too restrictive makes no functional difference.

> Align this check with the approach used in tsinfo for
> consistency and correctness.

First-principles based explanation of why 32 is the correct value would
be much better than just alignment. Otherwise reviewer has to figure out
whether we should be changing from >= to > or vice versa...

> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
-- 
pw-bot: cr

