Return-Path: <netdev+bounces-205743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFD7AFFF23
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 12:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203765A179A
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830232D8397;
	Thu, 10 Jul 2025 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBtiq0V9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595268821;
	Thu, 10 Jul 2025 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143122; cv=none; b=ZZSPfgogkaBqHoYKveR6RaRwiJhl4hT7dy9iEz5vc44OHvKFnMfhX8tPNQ0qX5qDfFZ9NuiCMYiPZIfzhN50hvxpIL0I1u0YUVjbFpjYNNKIvzwWR/4zbVRH2qUc8/JomXNf9oqUxJoLovVdM15054LdJazbUIkPaQIWQMmlJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143122; c=relaxed/simple;
	bh=OTAGDJehumguZ7HzBQgsD4oSk+XeA3SFo2ualcXHoFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvFhc1xEAovSUMmQj67+LQJwG6XfkBUdbpeHEHhr9lAXFTAECtDHrevEa8bPGTDjRwZEqIumqlyT4RGynnyknavV8hbCCKQp1gAZD5tfbZAOy5BmDjg6bzwkW17PLEXhWCOiXnvfEs1V3k2ENvs3DO39YTObwx4V++nxWQElp/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBtiq0V9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5854C4CEE3;
	Thu, 10 Jul 2025 10:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752143121;
	bh=OTAGDJehumguZ7HzBQgsD4oSk+XeA3SFo2ualcXHoFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBtiq0V93Bn4LCgxW0oTzpvlEGWQj8N+TEn4YVJ4fdJDY749R5a5Xw2WCC2kCVG/l
	 RjhNv6CwJWj37mSehFEdbwYoiuJf6cEprxkiJLQVm9rHTpSglVSj+TWjjFk20PsQ3u
	 INwORcIC5HfgWfZ56/4gzFwPMvI7juiR2/H6rORFzZhdh0tJFZMv2ccARuJJFNAMre
	 gRoGYcjWGG6PRwPxUOgNAvuFUQQuCK5c3YNLLdvY/fkgXy7WAczxihBrZYcbM8gCaf
	 H6ryobFI2N7WAMGPJ4L0DjJM2Yr891hGcNPHhJp6wrFIRn4yI9ERabALC/vcGsOsjM
	 uFOrV4+KumfTQ==
Date: Thu, 10 Jul 2025 11:25:16 +0100
From: Simon Horman <horms@kernel.org>
To: Markus =?utf-8?Q?Bl=C3=B6chl?= <markus@blochl.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	markus.bloechl@ipetronik.com, John Stultz <jstultz@google.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] e1000e: Populate entire system_counterval_t in
 get_time_fn() callback
Message-ID: <20250710102516.GP721198@horms.kernel.org>
References: <20250709-e1000e_crossts-v2-1-2aae94384c59@blochl.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709-e1000e_crossts-v2-1-2aae94384c59@blochl.de>

On Wed, Jul 09, 2025 at 07:28:07PM +0200, Markus Blöchl wrote:
> get_time_fn() callback implementations are expected to fill out the
> entire system_counterval_t struct as it may be initially uninitialized.
> 
> This broke with the removal of convert_art_to_tsc() helper functions
> which left use_nsecs uninitialized.
> 
> Assign the entire struct again.
> 
> Fixes: bd48b50be50a ("e1000e: Replace convert_art_to_tsc()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Blöchl <markus@blochl.de>
> ---
> Notes:
>     Related-To: <https://lore.kernel.org/lkml/txyrr26hxe3xpq3ebqb5ewkgvhvp7xalotaouwludjtjifnah2@7tmgczln4aoo/>
> 
> Changes in v2:
> - Add Lakshmi in Cc:
> - Add Signed-off-by: trailer which was lost in b4 workflow
> - Link to v1: https://lore.kernel.org/r/20250709-e1000e_crossts-v1-1-f8a80c792e4f@blochl.de

Reviewed-by: Simon Horman <horms@kernel.org>


