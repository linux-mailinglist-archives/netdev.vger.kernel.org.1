Return-Path: <netdev+bounces-204682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB06AFBB9B
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D553AF610
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9EC202997;
	Mon,  7 Jul 2025 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOmVkdSJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643942E3716;
	Mon,  7 Jul 2025 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915809; cv=none; b=EJ73GJ0VIIFUKnuSHzWUwW+9nj/mF0UO6Ih1gBedG/GwwilvuQ9wKPZ72s8Qa/cV+xupSNKN6DhWzWBaS3ywb4A77ic22e2aoZT9NE3NstQfreizNCWJgHzt+8OjUi5daIiSUpY+ghM5N4+42Xf4v0+3HROKxv2QIyZfGTUQ4WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915809; c=relaxed/simple;
	bh=NarcBfymvbhJkXFt0N1R9Pad6pw+hlSq8V8tsPduM5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6MpaSc/XjnZZcMUJ4qNUBZGKnitR5fo2Z0z4tGWlSIqgQ8ocBWFI8m5eIW/eTkXGJGTYLWNDWViLjuenCUqTuoZiYPdHaK1qf26a+vKlhMmrEbmfM+n61PFr/j2nfavSJs8btSIlKZHEetVUzDVHqWJMVLSuZYLt+NOk2rCL8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOmVkdSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEAEC4CEE3;
	Mon,  7 Jul 2025 19:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751915808;
	bh=NarcBfymvbhJkXFt0N1R9Pad6pw+hlSq8V8tsPduM5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uOmVkdSJJx+g32aZ7Cd3tzvKPvjuJupHAF9Xlqd5qdTN6o69DozdHyLuG8odDbjML
	 kCfjy3uH0/RNHx1umv8xPXj1ZX6DahZuMwRSQsE4Tv1n0OZFJ0qceiDDpKXM2dAfaq
	 uEjeMfxRQXFoqWFz815ZqG+1xgCauJUcBDjzjthrotM4ifHaMFRbeX1fMaX3HPsW70
	 tZYSLtKk8qjqRj9fOlO4vWjUEWvEbATTJK32/eAvM4VIt7NzEcdVeRwY1JePXvmqfJ
	 ylVuIu8QEv6FgJ2tTWKHnYCzjcwHIEp1gQVCW4pgLA/dgoSJclaSTYIavJdbLcrLxE
	 pXMNxA87v2LPA==
Date: Mon, 7 Jul 2025 20:16:44 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	darren.kenny@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: thunderx: Fix format-truncation warning in
 bgx_acpi_match_id()
Message-ID: <20250707191644.GC452973@horms.kernel.org>
References: <20250706195145.1369958-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250706195145.1369958-1-alok.a.tiwari@oracle.com>

On Sun, Jul 06, 2025 at 12:51:42PM -0700, Alok Tiwari wrote:
> The buffer bgx_sel used in snprintf() was too small to safely hold
> the formatted string "BGX%d" for all valid bgx_id values. This caused
> a -Wformat-truncation warning with Werror enabled during build.
> 
> Increase the buffer size from 5 to 8 and use sizeof(bgx_sel) in
> snprintf() to ensure safety and suppress the warning.
> 
> Build warning:
>   CC      drivers/net/ethernet/cavium/thunder/thunder_bgx.o
>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function
> ‘bgx_acpi_match_id’:
>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:27: error: ‘%d’
> directive output may be truncated writing between 1 and 3 bytes into a
> region of size 2 [-Werror=format-truncation=]
>     snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
>                              ^~
>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:23: note:
> directive argument in the range [0, 255]
>     snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
>                          ^~~~~~~
>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:2: note:
> ‘snprintf’ output between 5 and 7 bytes into a destination of size 5
>     snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
> 
> compiler warning due to insufficient snprintf buffer size.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks Alok,

I agree this is a good change.

However, by my reading the range of values of bgx->bgx_id is 0 - 8
because of the application of BGX_ID_MASK which restricts the
value to 3 bits.

If so, I don't think this is a bug and it should be targeted at net-next.
With a description of why it is not a bug.

Conversely, you think it is a bug, then I think an explanation as to why
would be nice to add to the commit description.  And A fixes tag is needed.

-- 
pw-bot: changes-requested


