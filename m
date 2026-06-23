Return-Path: <netdev+bounces-301359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9hcqAQl6OmqI9wcAu9opvQ
	(envelope-from <netdev+bounces-301359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:20:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0697B6B7067
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:20:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=GeTwnJr6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301359-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301359-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 139A030C595F
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571623D45CF;
	Tue, 23 Jun 2026 12:17:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C626F2BF;
	Tue, 23 Jun 2026 12:17:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217072; cv=none; b=fShk68R6+rlb6xRDbZTrbgAL8BKta7c7HcbU9SPSTP703PsQ8EqkAeVKlzdxNKqXKoWJ7HycfNfRCsVZxMzEYPx6ZEP1YNHLJuS9RaQ2Sb1HO+7X727gWhIYc0UYtiRhQ8IaATdLveRkjnqo+wRh2n7LBsOsb2fl21eRZOL/zJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217072; c=relaxed/simple;
	bh=L1fmSH/ngeQavYEYr07Dz490+UJrqa9tBu7ExUZOitg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgUFMjdGpOUX0YovKY1eKjXmsqpR85YRgZgWf2x0gllVDXndLNOvrqwT3WxkB73A7sxBx5xpt7zTh9nHr8Hzo/zo1h95ht0qXSzFAz+mmKipWvHzitU7JsB7PB9FuWkBTgo7/BmI9ZUMq/rqPVZFfYgpdq2tTtGmpsBLW6gxsD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeTwnJr6; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782217071; x=1813753071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=L1fmSH/ngeQavYEYr07Dz490+UJrqa9tBu7ExUZOitg=;
  b=GeTwnJr62DC98UCWnjq+4pk4o6Cg8Nw4BCfTtPMLIqa9TlW+X6wxPO1b
   ek+TD6TWYDRHvuYz0MGOkZi8NdcmAwL0oPrVWBaDB6lNu8uNAfRYAzSuk
   U81yXrk9wGgCzeUyiDwmnw+0U7AZG3ox4DUsvc+glteAv7hF8Zs7eCptq
   LRNS4bxHaGG9MNKUBqxY7ZTZWVsmaPyMZ2Jdu2VcmypnWi7udAaBDjrM8
   3pphkCONuytPoD1aesSgTL7RZp5vhiSS8vviBAjP53iJQggFTsVTd08kC
   95Uejor0thjqslpztacrlDNjNDybDP2yAxNGF/IyElidtiJtQORv6mnNE
   w==;
X-CSE-ConnectionGUID: 4WSLVIARQOaMt/D2JOhxIg==
X-CSE-MsgGUID: MYXCnIgGQTCHUY35DctRbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82999146"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82999146"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 05:17:50 -0700
X-CSE-ConnectionGUID: Izw3kUsBS7yuTBUSDff/mw==
X-CSE-MsgGUID: q4sWQ8K3QhOczEFYXY7V/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="254486432"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 23 Jun 2026 05:17:47 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 9CB5F95; Tue, 23 Jun 2026 14:17:46 +0200 (CEST)
Date: Tue, 23 Jun 2026 14:17:46 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 0/3] thunderbold: A few cleanups
Message-ID: <20260623121746.GD3066@black.igk.intel.com>
References: <cover.1781776904.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781776904.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301359-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:westeri@kernel.org,m:YehezkelShB@gmail.com,m:andreas.noever@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andreasnoever@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[black.igk.intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0697B6B7067

Hi,

On Thu, Jun 18, 2026 at 12:14:49PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Hello,
> 
> I'm currently working on a project that includes looking at all device
> ID structures from <linux/mod_devicetable.h>. While doing that for
> tb_service_id, I spotted these patch opportunities.
> 
> These are all non-critical and also my quest doesn't depend on this, so
> there is no urge to apply these patches. My suggestion is to apply them
> via the thunderbold tree during the next merge window with an ack from
> the network guys.
> 
> The first patch touches drivers/net and drivers/thunderbold. It could
> theretically be split, but then this results in at least 3 commits which
> seems excessive to handle three drivers, so I kept it as a single patch.
> 
> The third patch is a style change and so is subjective. Drop it, if you
> don't like it. Here splitting would be easy, but given that patch #1
> already touches the same files, letting these go in together without
> splitting seems to be sensible.
> 
> Best regards
> Uwe
> 
> Uwe Kleine-König (The Capable Hub) (3):
>   thunderbold: Stop passing matched device ID to .probe()
>   thunderbold: Assert that a service driver has a probe callback
>   thunderbold: Drop comma after device id array terminator

Fixed the typo "thunderbold" -> "thunderbolt" and applied all to
thunderbolt.git/next. I also took the networking patch, let me know if
that's not okay (I'm the maintainer of that driver too and it looked fine).

Thanks!

