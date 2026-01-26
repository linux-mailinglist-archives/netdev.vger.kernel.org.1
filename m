Return-Path: <netdev+bounces-253493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HPeFK10d2n7ggEAu9opvQ
	(envelope-from <netdev+bounces-253493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:05:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A961C894CF
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF3F9308C50F
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2C933B946;
	Mon, 26 Jan 2026 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZGgq1Us"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F99033ADBF;
	Mon, 26 Jan 2026 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435837; cv=none; b=ssrD+tQPol2z7XWugpjKc4svYL6t6Pn3s05kLGoW3gP3Hpc9V5j9dinbaYbbqS25mF3OdrFr8Q650J896Oz1+SNpqzDrWaXAfwzK06882KJuEzoHezL7J18LH9MRZZQx4Osxb80vTukLj+/TCLu2CkL1KGdWYy1e9h3xbvtBxjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435837; c=relaxed/simple;
	bh=IcGgdv4fYsgKp1wMZsJYK0RHj+EzTDCmN3O++pqKBN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5/K28xmxZ+WHt8YsGAN6S8G3RnVOYEeblbiNK/CZUWgpWjpDS/LeIGag3aABhWa1PnA5WBIFMgNj8X3qnU4vctOdRJLt9B0+Q0Z0+ZZC12z5JJ2zeUXrEObyAPeZVP+GgmptetRCuq0Yifyj9sGFnf9b3ARKBeSpMkexxkJi58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZGgq1Us; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769435835; x=1800971835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IcGgdv4fYsgKp1wMZsJYK0RHj+EzTDCmN3O++pqKBN0=;
  b=PZGgq1Us2ar3s+p6RA/OJj+Rb9j+9jHIhcCXnXEbVpDmJ3i8zkOa2IVq
   CLXiNeoDOTdJ2BmiChc0E2Wh/5g9GklGVOMh7OQm2hGQBwb/nHYsc+cwZ
   cSrOrOjtSmPDWHc7H/lp7oab72O5PbQGXlu85Dej8EfF+8rX1rgOGvvr3
   6TorZXTzkJJgi9ictnY3tk4oR/Z6mqgVPfItZqP9swKlU3oxUPG/zCFy2
   1nQJbS9fgqHN5URC8+9CJ49xuk6QydCeXOkMSEBz8tUO+wBmJiBhCfgP+
   u+kxc3BJbtwI9NMGUMXq98xZg5GXufARax66VsJEZkLHbNdwjJUx1fl/+
   Q==;
X-CSE-ConnectionGUID: sBsOlG4CS/iiD7g/YEDSGg==
X-CSE-MsgGUID: 642OTRYERqyaVTe924liJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="74454048"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="74454048"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 05:57:11 -0800
X-CSE-ConnectionGUID: T4UvcNoaTY6kTxXt/2L0cg==
X-CSE-MsgGUID: AwY9BOBmRSWzu8RAMAIYaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="211777592"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha) ([10.124.223.78])
  by orviesa003.jf.intel.com with SMTP; 26 Jan 2026 05:57:06 -0800
Received: by kuha (sSMTP sendmail emulation); Mon, 26 Jan 2026 15:56:38 +0200
Date: Mon, 26 Jan 2026 15:56:38 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Matt Johnston <matt@codeconstruct.com.au>,
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] i2c: SMBus ARP support
Message-ID: <aXdyll4KVOF6SWni@kuha>
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
 <30ad166e2b3d7f10080356ec232e604f3ac9ea2e.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ad166e2b3d7f10080356ec232e604f3ac9ea2e.camel@codeconstruct.com.au>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253493-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A961C894CF
X-Rspamd-Action: no action

Hi Jeremy,

Sat, Jan 24, 2026 at 04:32:42PM +1100, Jeremy Kerr wrote:
> Hi Heikki,
> 
> Thanks for submitting these. Supporting SMBus ARP for MCTP has been on
> my wishlist for a while, so it's great to have a solid proposal here.
> 
> I'm curious about why you're proposing a kernel approach though; the
> actual ARP protocol implementation would likely be implementable in
> userspace. I think the only kernel facility we would need is a
> notification facility for the possible presence of ARP-able devices (ie,
> through a Notify ARP Master, or another mechanism described by 5.6.3.9).
> I *think* we have existing interfaces for the rest of the ARP process.
> 
> It's entirely possible I've missed something there; perhaps it's neater
> with the match tables and address allocation being all in-kernel. I'm
> keen to hear a bit of the rationale for the in-kernel implementation
> overall.

Since we use kernel mode device drivers, we need the kernel device
instances (struct device) that bind to them. If you want to deal with
user mode drivers then you can always do that with the i2c-dev
interface, but then you will not be using the kernel drivers such as
the mctp-i2c.c in this case. But just to be clear, this is not only
about MCTP. The ARP-capable i2c-clients can be anything.

So even if you still want to scan the ARP-devices in user space
separately, the kernel must enumerate those devices independently in
any case.

I should also point out that to my surprise the i2c-dev interface
(I2C_CHARDEV) isn't always enabled, even when I2C seems to be
otherwise fully supported in the kernel. We simply can't assume that
it's always available.

thanks,

-- 
heikki

