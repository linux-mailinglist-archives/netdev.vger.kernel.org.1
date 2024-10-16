Return-Path: <netdev+bounces-136264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5189A1219
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0255B23809
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28B4212627;
	Wed, 16 Oct 2024 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnJBVvy/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03F18C33E;
	Wed, 16 Oct 2024 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105024; cv=none; b=KhLzZwEDhGPTbbdrBKlO8IpZAyr0XQlYh7wxIJpdD2IQaABrZSIRMd66aH8OfdwfFCabSANe/R0x6tJQyL1Z/dPUIVDEIyTi1337Xq5U0i7qxxQdWFZBO5HgXkASEY141i3K7cE/CegwgUQUhji0spbjRpxWPPkx2uYL0U/PseM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105024; c=relaxed/simple;
	bh=aLx5exvwCMwUHMjOQzWN3FTZL1Y1ITLH9PNEYeCCTvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxHzxgZaIbr464L8p9P2BxKKUCWqhtnXsXD5cNqYyobwMxRJo+q6uMomUcAd0n32wIezskZDGnkUwqIKe+mxKiIFMEnyGyOeCvtKoJ/gM+9iLZx6gZbejSbp9WX8x2f6A9Al+5NHoDVmt+oN4APU5GB+wO1L2epQLgTOG9Oge0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnJBVvy/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941F8C4CEC5;
	Wed, 16 Oct 2024 18:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729105024;
	bh=aLx5exvwCMwUHMjOQzWN3FTZL1Y1ITLH9PNEYeCCTvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnJBVvy/IYQNQpy5UOVTlfz/LOLpHsW+GiBLc4QLhx13yLMFZvvtZ+WpW66+cZCKo
	 CmVO1c2VhK1o1coDgzWwhQTAwLWH3SFyp2T+aEl48JYmBtIWXMU0m2NejTEJnyELsb
	 tIDHY9o6gIzLn8X/3M15sUg7KkbjMZLjOWhoMB7FdgiWPKw2Xv0/DnywKiUf9wzIl/
	 E8xFs97RPnNci4fZVjDaYrQ8H3zQ7CaKasyUcozHVc75a25YX58pcwyb1AS4CA6jr4
	 FVaNfMvh1M+D/SthEENSDrf2La3qZU94ZkQhhigNOJyHnNwEW9GGNXyYP0QZcBMod5
	 50O0krgBzug2w==
Date: Wed, 16 Oct 2024 19:57:00 +0100
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 1/1] net: ks8851: use %*ph to print small
 buffer
Message-ID: <20241016185700.GM2162@kernel.org>
References: <20241016132615.899037-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016132615.899037-1-andriy.shevchenko@linux.intel.com>

On Wed, Oct 16, 2024 at 04:25:26PM +0300, Andy Shevchenko wrote:
> Use %*ph format to print small buffer as hex string. It will change
> the output format from 32-bit words to byte hexdump, but this is not
> critical as it's only a debug message.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: wrapped on 80 (Simon), elaborated the format change (Simon)

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

