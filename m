Return-Path: <netdev+bounces-113280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D24793D798
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 19:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9201C23162
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 17:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA4D17C9E1;
	Fri, 26 Jul 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwgILJXC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2B811C83
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014908; cv=none; b=It3ecwUz8soIWR8cSGCuDEojevQKifsjUVwSTTcSr9ZjBS97PUa0BKNfFf0FvXX0SPK0Asu/04bRGGkAWdJFY9UMtKf59RzpXJk/t+q3L0smAJ4DqfTShPlhf52VjyWyziVQD2gHqSxfPTuVbSFLlZTZJ6QhQt6VX4Tutg81/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014908; c=relaxed/simple;
	bh=LWnLwuV8oe2vBX2TVbJ2qUu/Jv8nP26LMaZlcXzTRf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPm5NQK1qw7+ThGGBVKZGXb1xX3wK8WlpOb6JhjgdJLE3r9XZv9vw1S6ia/d/G3VH5sBDnEEUAspyAGPacXTjXno8UgYdwnLr5BNbAW66Cs/Prk/FT17r6DA9+rYUe0rzpY6CaXZn+ABEtZCCZo7Hs6YC1K4NL98Yzu8H8r3Sxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwgILJXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A435C32782;
	Fri, 26 Jul 2024 17:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722014907;
	bh=LWnLwuV8oe2vBX2TVbJ2qUu/Jv8nP26LMaZlcXzTRf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IwgILJXCbWuFD9NP18tPLnp5RjlTvAtCiR7IiyCPYvI5hdGqSyAPUMHM8o2wfy4ym
	 4auXvHsIgdcBeJXR8yDzlgsN4eRsLc49uwDV0IO7ZTlcpBEKQtxpN/ZHQWZa9cbhH0
	 sk89UpUp0M6GRKGUjHOBMWdgNoHYRHU/mLYnB2AnFV1NDxlRa9xAGcqg0L/OzfJQX+
	 /shWJFeDi5Htq3qeTlzmqZXd7Fgow3Mvd5Ys0Yy+zYA5GevEtNbF8mup0l6G5ci3gr
	 LkGRfb5txbLmwdVk9xL/mtTdC5U/uu1bU4CEPmcyv6EnTLxyU0SvQRSY05pDNZ+MZb
	 vbnB9IJ2XogIw==
Date: Fri, 26 Jul 2024 18:28:23 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v4 iwl-next 0/4] ice: Implement PTP support for E830
 devices
Message-ID: <20240726172823.GA1699125@kernel.org>
References: <20240726113631.200083-6-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726113631.200083-6-karol.kolacinski@intel.com>

On Fri, Jul 26, 2024 at 01:34:42PM +0200, Karol Kolacinski wrote:
> Add specific functions and definitions for E830 devices to enable
> PTP support.
> Refactor processing of timestamping interrupt and cross timestamp
> to avoid code redundancy.
> 
> Jacob Keller (1):
>   ice: combine cross timestamp functions for E82x and E830
> 
> Karol Kolacinski (2):
>   ice: Process TSYN IRQ in a separate function
>   ice: Add timestamp ready bitmap for E830 products
> 
> Michal Michalik (1):
>   ice: Implement PTP support for E830 devices
> 
>  drivers/net/ethernet/intel/Kconfig            |  10 +-
>  drivers/net/ethernet/intel/ice/ice_common.c   |  17 +-
>  drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |  12 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |  25 +-
>  drivers/net/ethernet/intel/ice/ice_osdep.h    |   3 +
>  drivers/net/ethernet/intel/ice/ice_ptp.c      | 356 ++++++++++++------
>  drivers/net/ethernet/intel/ice/ice_ptp.h      |   9 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 208 +++++++++-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  25 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>  11 files changed, 508 insertions(+), 159 deletions(-)
> 
> V3 -> V4: Further kdoc fixes in "ice: Implement PTP support for
>           E830 devices"
> V2 -> V3: Rebased and fixed kdoc in "ice: Implement PTP support for
>           E830 devices"
> V1 -> V2: Fixed compilation issue in "ice: Implement PTP support for
>           E830 devices"

As the recent changes are about kdoc, please consider running
kernel-doc -none -Wall and ensuring no new warnings are introduced:
ice_is_e830 needs a short description.

And, perhaps things crossed in flight.
But please address the review by Jacob and Alexander of v3.

Thanks!

