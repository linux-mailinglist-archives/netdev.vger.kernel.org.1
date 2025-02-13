Return-Path: <netdev+bounces-166134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DA3A34B97
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E640165F4D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E4F203710;
	Thu, 13 Feb 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QqkS/4J8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E165203719;
	Thu, 13 Feb 2025 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467161; cv=none; b=QRB8WnQ+ZmNQIdjsUjDllCWmuIThjPE1FF3Gkj35hZMHmi20/l2W/Pgn18R6g155Xva5coJDLxZXBzWBvRuqz1L8auvHLDl7ROfEBZUsAk0ToQFr9BQBdRTMAiYE5KkF4Tl5ZCzG+E68PwN0xGO4AiH7dgZkun4n/0aqPBIqolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467161; c=relaxed/simple;
	bh=9jSHN4ul3ZleLnTMDmLIZOfk8OvNXvpRioZv/TPSV6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg7PfsYJpjO8MRLruAD9416zzGCkCAaHEmRLTrIDIwO9Aqwjm79YnxWuRLwwrK7xPaYPwqbTxFAcp5ZifQ9L4qJHAvrxpJ40DiBqSbD7Bhhb6XZT7gipL19Qb4pTJHPC80qpREcbmAyVpCjzdhCZ8JVxlG2ky+2hIctmLTMJwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QqkS/4J8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739467159; x=1771003159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9jSHN4ul3ZleLnTMDmLIZOfk8OvNXvpRioZv/TPSV6Y=;
  b=QqkS/4J8n5ysXdbooCQUoibIRiv7+6znDjufuE+Y0poa/fxzOu0w7qja
   RbRU5kkk0Esm46pQcSC37aPJ5W1xuUqbggec0fQF0R5GwM7hS6NKc0U8t
   MZZptK/W5iXg8VIS2cs9mwWx2nYuACAWurlkaqXF4yX1biTG9A03SQwww
   XcwTxQBLmhRYeOZsta/vYnRYpHmkRam3X7jhU4hBcQ6AdZEbWGAi+JhGp
   aD7sFnAlUGK3nOLVJHZNJcD8/5aVixckyrai93AQTUIdEErFzPd9mHvCp
   GgIKWrlllpLsov9SPX6chDwF7gYk2ar44jRUxl3zUeQi2khc5PCYg5Aj2
   g==;
X-CSE-ConnectionGUID: XEfdE3R/T/q3JamtQqfJpQ==
X-CSE-MsgGUID: LtPNf76JT8KTcNLz31aPGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40219580"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40219580"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 09:19:18 -0800
X-CSE-ConnectionGUID: 9N4MUBhwQU2v0fAwWmpkiQ==
X-CSE-MsgGUID: MYE75GfASb6bCUWppIhORQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150382550"
Received: from dprybysh-mobl.ger.corp.intel.com (HELO intel.com) ([10.245.246.5])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 09:19:16 -0800
Date: Thu, 13 Feb 2025 18:19:12 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Markus Theil <theil.markus@gmail.com>
Cc: linux-kernel@vger.kernel.org, andi.shyti@linux.intel.com,
	intel-gfx@lists.freedesktop.org, netdev@vger.kernel.org,
	Jason@zx2c4.com, tytso@mit.edu
Subject: Re: [PATCH v2 1/3] drm/i915/selftests: use prandom in selftest
Message-ID: <Z64pkN7eU6yHPifn@ashyti-mobl2.lan>
References: <CAHmME9oqvWp_Nd1Gwgyw52qy8wxztMyCpNsjByH=VnRaXqczww@mail.gmail.com>
 <20250211063332.16542-1-theil.markus@gmail.com>
 <20250211063332.16542-2-theil.markus@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211063332.16542-2-theil.markus@gmail.com>

Hi Markus,

On Tue, Feb 11, 2025 at 07:33:30AM +0100, Markus Theil wrote:
> This is part of a prandom cleanup, which removes
> next_pseudo_random32 and replaces it with the standard PRNG.
> 
> Signed-off-by: Markus Theil <theil.markus@gmail.com>

I merged just this patch in drm-intel-gt-next.

Thanks,
Andi

