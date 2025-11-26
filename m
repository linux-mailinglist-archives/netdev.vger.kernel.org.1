Return-Path: <netdev+bounces-241798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D6AC884A6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2975C4E19BB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7842730EF62;
	Wed, 26 Nov 2025 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6FFcu54"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B34C9D;
	Wed, 26 Nov 2025 06:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764139194; cv=none; b=dCgWXqQHf9sD1sSvnmkSSmpC0hRRr1jLBwaTgbyTqRpoJ4F35hYyX5lKZIN+ZdPoVX1pLltWcYe/aGmDEGPpUQQgGIZ5w7Tca3SPvdTyyTQBwhKf/jnomKsLLqlkzYwyrDxPpvHeX83oz01g1fD/elS/9qe1YP/vOX0UvEbA9sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764139194; c=relaxed/simple;
	bh=cmHqlZLrccBE/De0C42TuewRzFkW23E9YbzAIfFHCb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtBbe/Myxn5eGxQ8SZOysGosP+LwguJD1MI6A3QFsreY/QgQQtiD2DxD1gTD2J8n3VhrzzNoj83eqEkHm2QvXCaiOP/nJWnVs5S8sJiX9ayjrt9nGdZxY2MjrGkTf3JmS8J9PmnqdxD94DPtr1DF8CH3UnuEv947XD+uGNtHlSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M6FFcu54; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764139193; x=1795675193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cmHqlZLrccBE/De0C42TuewRzFkW23E9YbzAIfFHCb8=;
  b=M6FFcu54JCzC075YCDW0tZGxWrMahu4MKCv+VI4/59T9QYeWgDY23UnB
   YmgLrSOEu1q2I8UYtiv/PQmxAJWDPRBVWKv1u1ZivZipMhQXfiL+QRpBm
   9o8jDPz2GBlNoywzM4jcrywdtfRJukSU+Ad4IoGQVLE2vh/orFSIRbeAY
   p/jYCJ47H/9b/K5H0lC4GCf9EDAqNRhkC1g9h4+ou3h4Wj5gV6QKBRdy7
   FK2dtRcwvSW6FAdDj0ZMazgoGV3/8dKEPXfnsZKPV+G7yu3qeXHZcETvm
   CikEdCvFUm/E/ywb6h3SbP14mdrNPjchK2QVCQH5+eUr0iWbqb5/MQZAX
   g==;
X-CSE-ConnectionGUID: VI5XWpluRF2fbsVIieRmLg==
X-CSE-MsgGUID: 3ZnLQM5bSoafXvs5kDKwsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="65876006"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="65876006"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 22:39:50 -0800
X-CSE-ConnectionGUID: Vy/WidHvQaKLNKHMSx02UA==
X-CSE-MsgGUID: jyiVWWu/TAiiaYdOp/sulg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="192490808"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.22])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 22:39:43 -0800
Date: Wed, 26 Nov 2025 08:39:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v1 1/1] idpf: Fix kernel-doc descriptions to avoid
 warnings
Message-ID: <aSagrR6mxkRexUDe@smile.fi.intel.com>
References: <20251124174239.941037-1-andriy.shevchenko@linux.intel.com>
 <abf25d3d-30af-479f-9342-9955ec23d92f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abf25d3d-30af-479f-9342-9955ec23d92f@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 07:30:18AM +0100, Przemek Kitszel wrote:
> On 11/24/25 18:42, Andy Shevchenko wrote:
> > In many functions the Return section is missing. Fix kernel-doc
> > descriptions to address that and other warnings.
> > 
> > Before the change:
> > 
> > $ scripts/kernel-doc -none -Wreturn drivers/net/ethernet/intel/idpf/idpf_txrx.c 2>&1 | wc -l
> > 85

> this is small change and leaves the driver good for long future to come
> I think it is net-positive in terms of minor annoyances for rebase or
> backports, so:
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Thank you!

> side note:
> Alex did analogous work for the ice driver, and I stopped him going
> public, as it was counted in thousands lines changes for little benefit
> 
> usual rant about kdoc warnings:
> agghr!!

(And usual rant about warnings in Linux Next unrelated to my code)

Yes, the problem is that there are warnings and, if your tree is in Linux Next,
make Stephen's and others lives easier by not having / producing new ones.

So, please, send fixes for ice as well at some point. It can be just a single
change (in case one wants to backport it). In _long term_ it's much better than
(what is happening with ice case) increasing a technical debt.

-- 
With Best Regards,
Andy Shevchenko



