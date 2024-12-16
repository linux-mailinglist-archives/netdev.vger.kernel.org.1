Return-Path: <netdev+bounces-152305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84D99F3596
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91A0162BD1
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23492205AC4;
	Mon, 16 Dec 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+4m2dc5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED77A14D6EB;
	Mon, 16 Dec 2024 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365531; cv=none; b=I4rA11kRaPnravTAEg7SMDI0S0axWqPZpmVlQlqX0kXojMO0qSAb9bqia56J04+67ykPHsSevjx73PkdRRSXe+KMWCVtXM96QOvyc95jdn7O0cUG+uEoa1Z4xln0LgcRHBQjy21UaF+IoQ8Q83V78HeyK6KhVHKsobWd59blbw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365531; c=relaxed/simple;
	bh=rjYLStbccgLpnBJXA8Wml3Pk++ymSWDGng8nbzYjaGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKO+rrvel/rVOkI3gsOIHNc7EUrXvAqAYBWBHRe1y+yJ0t7F8dlRgzbUjKdiWZU+mj2KN19mclKqPIOcX4UX/tj623qP05Uvubo0A3V7PQIbb7tM6wcqpyJayRCdA62gFLig0/uSJvBnsbjhLDcLLwUyfaagfKHxYKkW8fpsY+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+4m2dc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779CCC4CEDD;
	Mon, 16 Dec 2024 16:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734365530;
	bh=rjYLStbccgLpnBJXA8Wml3Pk++ymSWDGng8nbzYjaGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+4m2dc5jgKP54bLDjecViW2Q16EfklD+4viNVD1NkMNVTFGJyCSgNDFhgijI7YNR
	 pMr3ctTKFCklZQBgibqYHKg9kJIRUapoC5V5Gcp8cRV2h6lCV/F5y03ctG+sJbnjYP
	 b6W81nXN/lbN9RH/sunpk4lOzJkpM2jRA4Hkwa6UeonB9Tpu+XzjMFgewLBa1iyePm
	 7++oBEaBymoBYSI8hpcQNt8lYM7F+9MZEoMSQDxWs553FQpAkI+LvbIvfUFmrO00zX
	 Qeu+ecfdbFbeqMTMwH8lD9+VdlMhcutLGP/iCitdzzFJSrnd76XxGtj8HXmCw6ijMr
	 NU5zwf/672qeg==
Date: Mon, 16 Dec 2024 16:12:06 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: jes@trained-monkey.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-hippi@sunsite.dk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] hippi: Remove unused hippi_neigh_setup_dev
Message-ID: <20241216161206.GF780307@kernel.org>
References: <20241215022618.181756-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215022618.181756-1-linux@treblig.org>

On Sun, Dec 15, 2024 at 02:26:18AM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> hippi_neigh_setup_dev() has been unused since
> commit e3804cbebb67 ("net: remove COMPAT_NET_DEV_OPS")
> 
> Remove it.
> 
> (I'm a little suspicious it's the only setup call removed
> by that previous commit?)
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Hi David,

There is a dangling comment referring to hippi_neigh_setup_dev
in hippi_setup().

	/*
	 * HIPPI doesn't support broadcast+multicast and we only use
	 * static ARP tables. ARP is disabled by hippi_neigh_setup_dev.
	 */

Could you fix that up too?

pw-bot: changes-requested

