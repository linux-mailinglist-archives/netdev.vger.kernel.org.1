Return-Path: <netdev+bounces-164957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4928A2FE2D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB0E3A50AB
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 23:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C683925B696;
	Mon, 10 Feb 2025 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YniOKWZd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDF22586FA;
	Mon, 10 Feb 2025 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739228862; cv=none; b=lqUjqfeJlwE1TvJMW+KARg+Nz9sf9n31BK8u4fwHKaO3+x3t1D0oX2wK9/rTmz4rlUv9vEWNXG1AnWobN1B2+lR2cmWC7sFuppCzylFxvdiFObJZiXN5+Cz+Sn3QghD8+GbYwm0vpe+AH58yqzIRClAkFysBZF5vJlx084VNtuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739228862; c=relaxed/simple;
	bh=5Ad+mDP0f4rkKnJARYGaDv1lwZ6hbqhdNqwk2x11ziE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKS02BTFm3y6bk0KgDVLAI4D1dB+M1mK7xYhDLwcTJ7/qKPrEpPn9N9i9n4RhwLXk0nfESUHDloMavgAC4CU3Rim2tc/XjFXdxPVIYgy5+tkmm0stSIZMvCj1daakApIfRl7QyIwhZ2H05O0EPhifzBt9xHuIrGk1zrKB4QJZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YniOKWZd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739228861; x=1770764861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Ad+mDP0f4rkKnJARYGaDv1lwZ6hbqhdNqwk2x11ziE=;
  b=YniOKWZdnVEZsPmFZDJdqF3C1dpHEReZkUcOFYDpk5G5eftMUqFqt5JY
   3Z+9FF1K8l8H+9TpyhS6qCa9U0MNHdl55TcQML+zcc7lGP1xP6G6fmlzD
   c0wWtSYDM4+kf63rs19R4mYEwFxGeOxQpGC00dAS36gCkzNwjFpu3NIRE
   M8P0DHn6GOTjpf5MqPw2EIt7XZnW8exIWUnoo1Ajq7axj4Zgp3p8kIaXn
   CuIDXe8ZUM2dRTHIQ43LVeV6wPYhBdyC0Mzv2y8L3q0uNTDSGpJuUsDlt
   Md02+D3BFhUQkN2C4jgQIMVev8dHMAJJ+REAK/MqyeTbgN50ZVg9YZq2X
   w==;
X-CSE-ConnectionGUID: unn9jk2+RCSzK2ex47ldXQ==
X-CSE-MsgGUID: GDmhlwVbQGOYO200/H3Kug==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="40099706"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="40099706"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 15:07:40 -0800
X-CSE-ConnectionGUID: W+uTPteqRxaqvriAKsP9+Q==
X-CSE-MsgGUID: Zkib2YFtSS+773YNKGPQMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="112303550"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.246.18])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 15:07:38 -0800
Date: Tue, 11 Feb 2025 00:07:34 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Markus Theil <theil.markus@gmail.com>, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, netdev@vger.kernel.org,
	tytso@mit.edu
Subject: Re: [PATCH] prandom: remove next_pseudo_random32
Message-ID: <Z6qGtsEdjpz4ETvl@ashyti-mobl2.lan>
References: <20250210133556.66431-1-theil.markus@gmail.com>
 <CAHmME9oqvWp_Nd1Gwgyw52qy8wxztMyCpNsjByH=VnRaXqczww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oqvWp_Nd1Gwgyw52qy8wxztMyCpNsjByH=VnRaXqczww@mail.gmail.com>

Hi,

On Mon, Feb 10, 2025 at 02:39:43PM +0100, Jason A. Donenfeld wrote:
> Hey Markus,
> 
> Thanks for this. I hadn't realized that next_pseudo_random32() only
> had two users left. Excellent.
> 
> I'll queue this up in the random tree (unless there are objections
> from the maintainers of that test code).

actually would be better if we apply the i915 part in drm-tip
rather than waiting for kernel releases to receive this change in
our branch. It has been source of conflicts and headaches.

May I ask Markus to split the patch in two parts and we handle
the i915 side?

Thanks,
Andi

