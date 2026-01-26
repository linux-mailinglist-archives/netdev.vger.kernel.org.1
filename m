Return-Path: <netdev+bounces-253400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JGmNks3d2nhdAEAu9opvQ
	(envelope-from <netdev+bounces-253400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:43:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD6986240
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C50F33001F94
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD99D32AAC4;
	Mon, 26 Jan 2026 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0EP/Lbf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A187329385;
	Mon, 26 Jan 2026 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420614; cv=none; b=lq4hFvRaELzb1O+3nZSkoaJ/6SY2+YZ+FdVV1hYLieEroS3+CCfASLx/nslO7srytqfYwGHaByxD67YJyavyo2gIRQKFswbommTATFzX0tyEtaU2l8nHA3o1Ii61qQaoNfQz+tXljXcVDegSstPU/MThcov9AA22tTIehFZMue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420614; c=relaxed/simple;
	bh=9mXg2jTfgyWBybaitGS2vBDWPLyKiB7GX8JOHssgPnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHdfawhUwxMG31DzAbvlg5yrECzCPO3EOYE3Cvtn2F62ZjzTt/DD2HlqD6xoCWemiutcKMzIowjRT6zeuc5U3CBDzqztk+ZbyCNa/f/els9GOtoWnaMw2ZIW03cnZe7mik8c4nFGJmNXizlgvL1PTQampJfaSpxK3DDn3WWwoYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0EP/Lbf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769420613; x=1800956613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9mXg2jTfgyWBybaitGS2vBDWPLyKiB7GX8JOHssgPnA=;
  b=J0EP/Lbf/S3j4a2CyRNWeqiswr7TjUPfk/RdC8+sjgEtIPUQQyYKyk1b
   FJ4mdvvDLfcvDtqNgwl7gU8gidI0nfbV78FysaLmcgH9YaCDjZNK6OfYq
   Q7GfFCWFULUv3TFO4M5ltt9Uz7XX7EHtWEPR3zPFJs9dv/AKKg5p1Jsg+
   DVtKW0yIJidF9cKtFSRk9MwCjPVFHFNUe/d4hv2fQtJGYyiQhBVbldJ1Z
   amE8Su4MTpK/5OuFQslJeQ88NvDExA3f1pQYs1Ht6lnvVaD2raoCdvkzk
   07ag6jKYTO6WV+alYuSGc+zfQW+VaJBvBV++zpXB1uAi9VyvTvLIKV64k
   Q==;
X-CSE-ConnectionGUID: nlanYt68QIGnbtsFOlax8g==
X-CSE-MsgGUID: k1obXmj+Q7iXP7tBizIE5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="70310416"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="70310416"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 01:43:33 -0800
X-CSE-ConnectionGUID: ElrawaLISRCec0tEz+c6Cg==
X-CSE-MsgGUID: yHTjrlRXTsCZ1JfGA7k2+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="208068190"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 01:43:27 -0800
Date: Mon, 26 Jan 2026 11:43:25 +0200
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
Message-ID: <aXc3PUbofartuTS-@smile.fi.intel.com>
References: <20260124102042.112101-1-enelsonmoore@gmail.com>
 <aXTHhI710LK1EsTG@smile.fi.intel.com>
 <CADkSEUjwCmowmo_AwZ7TNS2gDt0CLz6buvfjjXz7BrLfuokM4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUjwCmowmo_AwZ7TNS2gDt0CLz6buvfjjXz7BrLfuokM4Q@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-253400-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 1AD6986240
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 01:11:06PM -0800, Ethan Nelson-Moore wrote:
> On Sat, Jan 24, 2026 at 5:22 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > There are three problems with this version:
> > 1) you haven't taken my tag, why?
> > 2) there is no changelog to understand what's going on;
> > 3) the v2 was sent too quickly (usually should be 24h+ between the versions).
> 
> Sorry about that. The only change is that I had overlooked smsc[79]5xx
> in the original patch because they had a version definition but didn't
> use it in get_drvinfo. I will follow these procedures even for trivial
> changes in the future.

So, it sounds like v3 will be seen soon?

-- 
With Best Regards,
Andy Shevchenko



