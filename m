Return-Path: <netdev+bounces-256222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN3EDxfFgWnZJgMAu9opvQ
	(envelope-from <netdev+bounces-256222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:51:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B72C9D71B7
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20EA4306E83C
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD7F39902A;
	Tue,  3 Feb 2026 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwGYWHD3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63CE30FF1E;
	Tue,  3 Feb 2026 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112175; cv=none; b=cLE8xB0I6HZQf8MpZURgyBCdIFGcwT56C9rjDZfg4iFKIXhihXf7HmialQ1TpqltzCVTVOUeq0ur5aEIFeQ6mCu1sT25YF+4Y2/nT9E7tt0vfZ1/W49A0FOqluHALGVIJvdbA7yQlAnPnVsIrRgbEGvtYnAMSH/ZSwVW4SC7KRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112175; c=relaxed/simple;
	bh=Yvv8PdiJk4vferQPdXd1xsgzuanXzMbWFOfsBrfoLOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsIneYq/A3jHhRRifOa9B4vIaLBjNSqZfqGP6ZzcEGdEtb0SU0KP3X4UeiP/NWHxMlubpeDbXJ4DtgqkJt8lLm6zfCct0L3zJgR5wHl7NrySvNw1q4Jgo4nEmHOsLYNizgjNnexP+TJN/uOJgIIDkQeEvTv0pa2yFsmTRYeQgS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RwGYWHD3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770112174; x=1801648174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Yvv8PdiJk4vferQPdXd1xsgzuanXzMbWFOfsBrfoLOM=;
  b=RwGYWHD3p4M8FuP4t0+vNRw5G5jEV+xh9vXqhmgUy/cXJ4Sdo4yFuOPa
   L7vVjJeu3vn7Un+JjHUwQT18Lrn/w3rHDVzCwGtkkg7nUsG2LvdIIhbV5
   LSKDkIqRTQJby/OXJS4s9nPSx7bpFQWs2wJZZCBHXxeJyzWvDLDeSik7U
   u+5NhbxfC24np5+3HUVdTFbvEtqs0HZONPx9tlFazWotJsUsMgl/KINdO
   /FaI/vMvOvyEGwD8Cve4U8pltebk5CMv9Rd7bkkzpWH6QzY8G6GVIpbRN
   hOXEnVCSc5rpdE7qyseoIFqBLjiX1CBvKzEoO2RWSVr2PeWDp9nmXpsgB
   g==;
X-CSE-ConnectionGUID: WkrSdiQtTBKvXc9hs5InSw==
X-CSE-MsgGUID: Zh+znDpTSHWx3dW/IabATA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71185739"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71185739"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 01:49:33 -0800
X-CSE-ConnectionGUID: xOfB06JITtCoOp841Qer0w==
X-CSE-MsgGUID: wVyZksmhT5GQwaBw3xZcoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="247406072"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 01:49:29 -0800
Date: Tue, 3 Feb 2026 11:49:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Max Schulze <max.schulze@online.de>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Subject: Re: [PATCH net-next v4] net: usb: introduce usbnet_mii_ioctl helper
 function
Message-ID: <aYHEplTvRrfhCRQu@smile.fi.intel.com>
References: <20260203013517.26170-1-enelsonmoore@gmail.com>
 <aYGw80IvE0TG7WOx@smile.fi.intel.com>
 <CADkSEUgmX1tk-qJ7ee=P3EYcvriW91nVJZ6AFDpVEVjj7O8pJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUgmX1tk-qJ7ee=P3EYcvriW91nVJZ6AFDpVEVjj7O8pJg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256222-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: B72C9D71B7
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 12:49:57AM -0800, Ethan Nelson-Moore wrote:
> On Tue, Feb 3, 2026 at 12:25 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > > +extern int usbnet_mii_ioctl(struct net_device *net, struct ifreq *rq, int cmd);
> >
> > Do we still need to populate 'extern'? Can we get rid of this redundancy?
> In my opinion, while you're right that it isn't necessary because all
> functions (unlike variables) are implied to be extern, the use of
> extern to indicate functions that are exported/intended to be part of
> the API is a good idea.

I'm not sure. This makes it harder to read for no benefit. All non-static
functions are part of the API.

-- 
With Best Regards,
Andy Shevchenko



