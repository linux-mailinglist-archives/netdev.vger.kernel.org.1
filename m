Return-Path: <netdev+bounces-244064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EE7CAF177
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 08:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49512301176D
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 07:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ED5258CD9;
	Tue,  9 Dec 2025 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzYlI+ww"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44FE1A9FA7;
	Tue,  9 Dec 2025 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765264093; cv=none; b=nlBD4Z+fd79ZvxNsZLz3/hiuyNCChcsAa4/MjBSO8VKO6XQ1iov6uqFZtQ4lGLEAVOSFnXgQGLKeKbV7g2plTyqesNFWYsGWheRXyuZ878xdEpkbnSQ8OuGZZyUkjgSgJLQxsqEgCAUUuEPr4th9kuvxP2n39vnBX37BCqwcBEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765264093; c=relaxed/simple;
	bh=XUk8c97smgUycZ+dUUGpaqenwZ1xCSXNi6QZTKrj3zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1/EYRP0ojYroqMBQ/BQbidsiPZVrz7RcCII5NTwqJBqU2kHbnNgFeQTuAgd4KZahGnH/kj27369O9QexrulsxnlDV98sFnPDE5NHFwiUEvNGMFOxZmumRZQ5ZCuM3idHjIHxGAzouNjmRQoQtqjgheFlIhtt5Vxt5hNTzKMLIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzYlI+ww; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765264091; x=1796800091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XUk8c97smgUycZ+dUUGpaqenwZ1xCSXNi6QZTKrj3zI=;
  b=SzYlI+wwNHtLuY/pyyF561jZTE3isE2O977sZSTvUfaCXMylgNNUnPJX
   yQS6rfOG/RUrbCBtteKvRW0n/0a6xHUaTAqh/+wa4+bU9v96QJhUa0wJO
   9IX2sq02I8bUyRC37NiEDizgOqGoho/A8pcxUFYYZfD8NTL2mhIQ3AWCl
   rUCK7nIfK+tM/eE7mjKQIBAH6JHHAFFcJoDczZ/yPuB2Su9BNT3vwEtdW
   MWaiOTRLqXM/8jNLWMyHbopROwyz4kJIBMnzEWHxiF91kqGzD6nA57ez3
   omZs+Twz0XoRXVK+GfHJvXr6UPaXmXChAqW3YMRQCmJ1YtWnyryDOQJqU
   Q==;
X-CSE-ConnectionGUID: S/nQKAYQTAeXdGHLjdeMaQ==
X-CSE-MsgGUID: 9MNLPOo7RP+fg5O3tmNawg==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67099569"
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="67099569"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 23:08:11 -0800
X-CSE-ConnectionGUID: /glDrjHiSxC1TRmfUayU/g==
X-CSE-MsgGUID: V2s5QJoRRAWbHWcjfsAb+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="196050485"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 08 Dec 2025 23:08:07 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 5426D93; Tue, 09 Dec 2025 08:08:06 +0100 (CET)
Date: Tue, 9 Dec 2025 08:08:06 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: david.laight.linux@gmail.com
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@netronome.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH 0/9] bitfield: tidy up bitfield.h
Message-ID: <20251209070806.GB2275908@black.igk.intel.com>
References: <20251208224250.536159-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251208224250.536159-1-david.laight.linux@gmail.com>

Hi David,

On Mon, Dec 08, 2025 at 10:42:41PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> I noticed some very long (18KB) error messages from the compiler.
> Turned out they were errors on lines that passed GENMASK() to FIELD_PREP().
> Since most of the #defines are already statement functions the values
> can be copied to locals so the actual parameters only get expanded once.
> 
> The 'bloat' is reduced further by using a simple test to ensure 'reg'
> is large enough, slightly simplifying the test for constant 'val' and
> only checking 'reg' and 'val' when the parameters are present.
> 
> The first two patches are slightly problematic.
> 
> drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c manages to use
> a #define that should be an internal to bitfield.h, the changed file
> is actually more similar to the previous version.
> 
> drivers/thunderbolt/tb.h passes a bifield to FIELD_GET(), these can't
> be used with sizeof or __auto_type. The usual solution is to add zero,
> but that can't be done in FIELD_GET() because it doesn't want the value
> promoted to 'int' (no idea how _Generic() treated it.)
> The fix is just to add zero at the call site.
> (The bitfield seems to be in a structure rad from hardware - no idea
> how that works on BE (or any LE that uses an unusual order for bitfields.)

Okay but can you CC me the actual patch too? I only got the cover letter
;-)

> Both changes may need to to through the same tree as the header file changes.
> 
> The changes are based on 'next' and contain the addition of field_prep()
> and field_get() for non-constant values.
> 
> I also know it is the merge window.
> I expect to be generating a v2 in the new year (someone always has a comment).
> 
> David Laight (9):
>   nfp: Call FIELD_PREP() in NFP_ETH_SET_BIT_CONFIG() wrapper
>   thunderblot: Don't pass a bitfield to FIELD_GET
>   bitmap: Use FIELD_PREP() in expansion of FIELD_PREP_WM16()
>   bitfield: Copy #define parameters to locals
>   bitfield: FIELD_MODIFY: Only do a single read/write on the target
>   bitfield: Update sanity checks
>   bitfield: Reduce indentation
>   bitfield: Add comment block for the host/fixed endian functions
>   bitfield: Update comments for le/be functions
> 
>  .../netronome/nfp/nfpcore/nfp_nsp_eth.c       |  16 +-
>  drivers/thunderbolt/tb.h                      |   2 +-
>  include/linux/bitfield.h                      | 278 ++++++++++--------
>  include/linux/hw_bitfield.h                   |  17 +-
>  4 files changed, 166 insertions(+), 147 deletions(-)
> 
> -- 
> 2.39.5

