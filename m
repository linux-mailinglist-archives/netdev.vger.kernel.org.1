Return-Path: <netdev+bounces-253079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 631rMJXHdGnu9gAAu9opvQ
	(envelope-from <netdev+bounces-253079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 14:22:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DACF57DB31
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 14:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B38A03002D0B
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 13:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A90318B9F;
	Sat, 24 Jan 2026 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUywvX5x"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE00263899;
	Sat, 24 Jan 2026 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769260942; cv=none; b=XIJ56WabTXgV0s7uGmcBaHO546hjhDS4ml+GjzcfIIAsLdph6JuCJxhXRZUykga3DW2dzIhZiNdtpCaGnVQXT7M5igTPTckVMmLSVMyNsgNQPDgdskHNZEQ01jibb5+PtKUKmdv4fTJRCAMfrQjebGBlUvVzX+COYjG+qfgBJuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769260942; c=relaxed/simple;
	bh=ToIaOZgqAD9RJ+1Uhj8Ob1zhp9ZLsHIZHDqohWQufXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJLvd/e90L3D3j0RHZf4VUR9ChhO20IyvgxOq+x8r3i7D9SNnnPHPZXag83+BE+wY+aCgKutyBMHcSum71MRQ1icW6R2U/Ce+H5BABzq/aQNIbfmxLnm5aEPZUrACVf6p0ZsSoB6KdryupDdpaWEsFnqsx5cxOhki4QYg1ZxCXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUywvX5x; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769260940; x=1800796940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ToIaOZgqAD9RJ+1Uhj8Ob1zhp9ZLsHIZHDqohWQufXk=;
  b=HUywvX5xDBeV2Gn0J9W2lzp3oTY28Ub5qKGTnoVyyhdSGuSR6B9ql7o4
   rt4XG1qvgg4yXvadb9EzlUPzeVgHzu1pFqx35xtkb4aEYF0XeulqAx/PH
   di35/VtFtgpd3ySPeqheOYREIE/zaDlymDL532pFVTAKq32qtKIGmIfH8
   uuntB/c5bj67GYoarlYyfvNlwuV0fkhA+iahBgfn/rOCpx9lU3gpOCOG4
   Yi/6S3Hj/1nf+JY2KIiSdoO1odgHe8WV2CMLW6oMdaOgGb5piCF1aNnf4
   I89jv5MwI/85r2QGMxwxTNpIKsZw/gA6WPpp/vrGtQt7OdGYhw4RZWhWN
   w==;
X-CSE-ConnectionGUID: NX6pJ8czSrymIt4PrCYlGg==
X-CSE-MsgGUID: Ot3lphe5Sea5QGux5nL3dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11681"; a="74122886"
X-IronPort-AV: E=Sophos;i="6.21,250,1763452800"; 
   d="scan'208";a="74122886"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 05:22:19 -0800
X-CSE-ConnectionGUID: PcdYSi6FQLmV/XWr5T9vpw==
X-CSE-MsgGUID: sCj+0JBFSj6T+skUwozrVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,250,1763452800"; 
   d="scan'208";a="211723635"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 05:22:14 -0800
Date: Sat, 24 Jan 2026 15:22:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Petko Manolov <petkan@nucleusys.com>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Oliver Neukum <oneukum@suse.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Max Schulze <max.schulze@online.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 net-next] net: usb: remove unnecessary get_drvinfo
 code and driver versions
Message-ID: <aXTHhI710LK1EsTG@smile.fi.intel.com>
References: <20260124102042.112101-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124102042.112101-1-enelsonmoore@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,korsgaard.com,nucleusys.com,shawell.net,microchip.com,fintech.ru,suse.com,piap.pl,gmail.com,pengutronix.de,online.de];
	TAGGED_FROM(0.00)[bounces-253079-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: DACF57DB31
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 02:19:45AM -0800, Ethan Nelson-Moore wrote:
> Many USB network drivers define get_drvinfo functions which add no
> value over usbnet_get_drvinfo, only setting the driver name and
> version. usbnet_get_drvinfo automatically sets the driver name, and
> separate driver versions are now frowned upon in the kernel. Remove all
> driver versions and replace these get_drvinfo functions with references
> to usbnet_get_drvinfo where possible. Where that is not possible,
> remove unnecessary code to set the driver name. Also remove two
> unnecessary initializations from aqc111_get_drvinfo, an inaccurate
> comment in pegasus.c, and an unused macro in catc.c.

There are three problems with this version:
1) you haven't taken my tag, why?
2) there is no changelog to understand what's going on;
3) the v2 was sent too quickly (usually should be 24h+ between the versions).

-- 
With Best Regards,
Andy Shevchenko



