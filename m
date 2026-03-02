Return-Path: <netdev+bounces-262589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M7UJy9epWlc+QUAu9opvQ
	(envelope-from <netdev+bounces-262589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:53:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AF71D5CEB
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61B173004203
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 09:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBB9329395;
	Mon,  2 Mar 2026 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LW8HbHsi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4622A1DC9B3;
	Mon,  2 Mar 2026 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445097; cv=none; b=Va39a8xMv9ELEocXiC+ScUsV2r9HVMBZSMJfa5NFmy0YToALzzk4CTCIeQMABjWe22wIXqp6gsxAtsrVfKtbcNthnsqhtnDcCRTpdk+2Jzn5tndLKP/ms/1tJ7LTX8x85qjECbvsRuzm/s2nw+I9rJVPQBvCj8VULJC1bCKFyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445097; c=relaxed/simple;
	bh=nnwGUvYXlWH+Q1fp3tDFhLknwZKLytF4NV2bc0HOwcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBaDjElHolKgDQsdU9dI8ZQUS3rbmbZJkoL+JplH1R9BGGKsOX0Am437LYZ0cnWmk6sNXq+j327xJ9KwRSFO4Kx6xNqN4vWDnfODed8vWw6K2dLffT122IE1DhnW7CYiMGUVOtGaf/mMVjeskVXz5vwxukox+mj7LTXtEXPBrhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LW8HbHsi; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772445097; x=1803981097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nnwGUvYXlWH+Q1fp3tDFhLknwZKLytF4NV2bc0HOwcw=;
  b=LW8HbHsink4J5MUSxXqNIrBJKtxS4jr/feO7HcxTjicSZnOP44ZyR38X
   f+EbJP9gorehotd27F5u9FnC1JSzH+qMHZMzf4jSMJRGpsUugBUf1RKi1
   Epq+47uIV7fWWIzEySUIOijtdwq8LjlhlkNVY21YAQcBfULGy5XtEaOO6
   eCJvKY0tBBh0xcZZnJnpTeQvMUKjVGBdTeuyTvcXq2tn1ifYCezGn5f//
   RH1LyrScXAUoXBfL3zs3jme13dM2KQARr/l7jckzh4xxMo80cdHpVWnsT
   y3IHibglLigKS/klqZcfyIjwZRtg/V6sUudf6EnqavPUWqcD/yZsA3OMf
   A==;
X-CSE-ConnectionGUID: cXdnMo+NRVKqWBgjyIqdoQ==
X-CSE-MsgGUID: X8OK+uqSReSi8oBZJXIHrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="76051563"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="76051563"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:51:36 -0800
X-CSE-ConnectionGUID: 1M43xfSJTH+iKykTElvJXA==
X-CSE-MsgGUID: FgbJBCdfTpSZ7loro2hQrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="240620934"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:51:33 -0800
Date: Mon, 2 Mar 2026 11:51:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v1 1/1] i40e: Add missing
 header
Message-ID: <aaVdo_FmncYXUQes@ashevche-desk.local>
References: <20260302090305.2193349-1-andriy.shevchenko@linux.intel.com>
 <IA3PR11MB8986BF4BB6AB02FDB0F84658E57EA@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986BF4BB6AB02FDB0F84658E57EA@IA3PR11MB8986.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262589-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,osuosl.org:email,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 00AF71D5CEB
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 09:45:46AM +0000, Loktionov, Aleksandr wrote:
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Andy Shevchenko
> > Sent: Monday, March 2, 2026 10:03 AM

> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Thanks!
I sent a v2 with fixed Subject already, please review that one.

-- 
With Best Regards,
Andy Shevchenko



