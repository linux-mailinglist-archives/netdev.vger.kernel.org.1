Return-Path: <netdev+bounces-236683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F5AC3EE96
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E4F188AA4A
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7E926F46F;
	Fri,  7 Nov 2025 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SP/QZAWe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D0917C211;
	Fri,  7 Nov 2025 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503363; cv=none; b=XX5aBTvKDHqM/vNQ0Q4uEQLVxkqcz5RDad52TOveqm1IIDSWDLZu3i4l7OnX+bLeIitYlsw1Dp0n5b58iI6otC9B/d1ZtaXNrm5AfjxPdJ8soZDIPrLz351nn0861mVG/09uYsxB6HSSmGCifODLUqL+skO+j009McA/Eg+PPKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503363; c=relaxed/simple;
	bh=agrVq+79nHupWS6O7Sz47YpcLvrFagX4JpR/2JLeqco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohAqOmfADTebUi1WvQf7uXSc1DMS8X2Nxbd9sGjmaO8heK8SCBAHDVgM9BbV6zG3vOdvAN6vIbWmrCKKHWwHwmKLur2/faL5n/YDb1ZuYtf7SDJnTnyZylj3b9UBD76Zpoui8k35+UT/X3yspaGfIw9PGBmaHR5lrauBKN24rlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SP/QZAWe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762503351; x=1794039351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=agrVq+79nHupWS6O7Sz47YpcLvrFagX4JpR/2JLeqco=;
  b=SP/QZAWelKxkembeao3C5q6cWQTlubIlkjYSELGqA88h/rQRy/Typ5cf
   zjXGah3ClGQK+NqcMnrjhlEuQdoURxuk5RsCWYLhcpJG4IXs02ypBL4D/
   mBU4BdTgVBpTFCOPSaTr+WsaK1Kmcp/s/P8LCZQQU1P2oayu9lpsqaJct
   r3XrH5h0TcgI1Yb7zU0m6/mgq+JqVjZ3kHToCDu0BAHoSrxX5uEjaqlbj
   Qd2Uz3n77/tqbzMKe+f83JxAkK0O9T+Ka3xMWHVerVVpOVM9znj8QmWfc
   dF0sR7eSCUivKZGMYmIAPbSKukkIdlpmL2xjEvjCptOsGNCZM5/ns3WZG
   Q==;
X-CSE-ConnectionGUID: Tx/+1+MRR92/x9vvOiasCw==
X-CSE-MsgGUID: vx90SC2CQjSDYyn6f9kGjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64567568"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="64567568"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 00:15:47 -0800
X-CSE-ConnectionGUID: MpmFUCnqTkWrBOyxcDfePA==
X-CSE-MsgGUID: oDQ5M/a6R3KiePcyKPBQ/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="187706920"
Received: from vpanait-mobl.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.27])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 00:15:44 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vHHdD-00000006P1A-3c39;
	Fri, 07 Nov 2025 10:15:39 +0200
Date: Fri, 7 Nov 2025 10:15:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: linux-kernel@vger.kernel.org, pmladek@suse.com, rostedt@goodmis.org,
	akpm@linux-foundation.org, tiwai@suse.com, perex@perex.cz,
	linux-sound@vger.kernel.org, mchehab@kernel.org,
	awalls@md.metrocast.net, linux-media@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] Add scnprintf_append() helper
Message-ID: <aQ2qq_Se3_RIBfH0@smile.fi.intel.com>
References: <SYBPR01MB7881F31A023E33A746B0FBFFAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881F31A023E33A746B0FBFFAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 07, 2025 at 01:16:12PM +0800, Junrui Luo wrote:
> This patch series was suggested by Takashi Iwai:
> https://lore.kernel.org/all/874irai0ag.wl-tiwai@suse.de/
> 
> It introduces a generic scnprintf_append() helper function
> to lib/vsprintf.c and converts several users across different subsystems.
> 
> The pattern of building strings incrementally using strlen() + sprintf/snprintf()
> appears frequently throughout the kernel. This helper simplifies such code,
> and provides proper bounds checking.
> 
> Patch 1 adds the scnprintf_append() helper to the kernel's string library.
> This is a common pattern where strings are built incrementally by appending
> formatted text.
> 
> Patches 2-4 convert users in different subsystems:
> - Patch 2: sound/isa/wavefront
> - Patch 3: drivers/media/pci/ivtv
> - Patch 4: drivers/net/ethernet/qlogic/qede
> 
> These conversions demonstrate the helper's applicability.

Something seems went wrong. This email is detached from the series (in terms of
the email thread). When formatting patches, use -v<X> --cover-letter to set
up the version number <X> and generate the cover letter that is chained to
the rest of the series.

-- 
With Best Regards,
Andy Shevchenko



