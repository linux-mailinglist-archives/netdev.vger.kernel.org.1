Return-Path: <netdev+bounces-252875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN2hF/OZc2nNxQAAu9opvQ
	(envelope-from <netdev+bounces-252875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:55:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE0678121
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00DB7302D5AB
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD3730FC37;
	Fri, 23 Jan 2026 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYgkOqnZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994FC3016F2;
	Fri, 23 Jan 2026 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183654; cv=none; b=RrWSfqHAGHsKELmDCDfN/GahNM7VK2yAE7j74XLvu9T7ZylpJpelNwIudn1smQfQ1pFQofMpHENQ2fU2G+FMrOq6Wsfme4YiuI9NcoDdx8wsA0eZzqF18J7Ru7stscCGElRSTZchWNkRpYUBzvxt0RbohlOnV77hYODxd7Kq1us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183654; c=relaxed/simple;
	bh=cghKvZlvGo+Rdg7lCtRKFUqD8erdVh0YIBaDW8WUSwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDYFat72PBvaHhrugKfFR/RyEBK6GqqDDL/haiiPFpXeo2Ut1+DdrPCqERRwSqQKhduCJ9XEfoucf5DEYSDgJtoRyFS7L+1tbLdXve2qxVHuCVr0dVPjh8vd9MB+o2hWlzdVfzlu9LC+P/7vnjbbU/1w7HuQMsMlGbg0VdZkaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYgkOqnZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769183649; x=1800719649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cghKvZlvGo+Rdg7lCtRKFUqD8erdVh0YIBaDW8WUSwI=;
  b=gYgkOqnZ3O29LdNtNTFSDrEZTIlsSIT/0PCn37gv4N+sF26f0GwiQycw
   tvLjFizeNQRmU1mpKQYRz/gq3py7y9QHrJv+sErExn3f2VmDj93XI/HQS
   mo7ULjwYvFd5HmnlurdHzxV96TvMCBYmmDv5AltVYph9f8ZydVmoCkjlv
   /Ckku4OsyogD6RXYyKmCjOX6m1jOmzE11TDFFeXYGehhYgPtJwQSRnHdE
   cGQK1gnKyi4Lu/txmRLMHYSdeMNLv0kv34tp5Ju1pHKIWQA2obuIGKclx
   h7U0XpesLNlhqoGAWQmAbbIBxAYmiy5SEmrY3NJS0EfRevWyJ1OpikTY6
   A==;
X-CSE-ConnectionGUID: vr0gCqwfTgqsTEh/UcEI7g==
X-CSE-MsgGUID: vUPgXjWBTuS8IP07dm11VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="69635620"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="69635620"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 07:54:09 -0800
X-CSE-ConnectionGUID: fT/mte+ZSbaR4uxx54cegA==
X-CSE-MsgGUID: HUS4CAtVTAaq2M/1qPM2Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211557209"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 07:54:04 -0800
Date: Fri, 23 Jan 2026 17:54:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 net-next 01/15] net: mdio-regmap: permit working with
 non-MMIO regmaps
Message-ID: <aXOZmrmff4Krx5dy@smile.fi.intel.com>
References: <20260122121301.cyxyevi7xvqw2axk@skbuf>
 <20260122134704.pxeikyk4q7nhay55@skbuf>
 <aXI2bWhDtNNfr8M8@smile.fi.intel.com>
 <20260122221848.py4p7mwxzybicnsq@skbuf>
 <aXMhWo0NpPK-BELG@smile.fi.intel.com>
 <20260123121529.inik6xrfdianljq6@skbuf>
 <20260123135501.7m5wqkcfluxqeowb@skbuf>
 <aXOGPUP5pfGeAQKN@smile.fi.intel.com>
 <20260123151049.zv7uyn4rgr75bmog@skbuf>
 <aXOWGuNhm27bit2A@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXOWGuNhm27bit2A@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,trustnetic.com];
	TAGGED_FROM(0.00)[bounces-252875-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: BFE0678121
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 05:39:13PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 23, 2026 at 05:10:49PM +0200, Vladimir Oltean wrote:

...

> I'm fine with regmap_range, but I'm not a regmap maintainer.

Also TIL the range_*() APIs in overflow.h.

-- 
With Best Regards,
Andy Shevchenko



