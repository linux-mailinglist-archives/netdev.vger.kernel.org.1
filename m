Return-Path: <netdev+bounces-284236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJtTO2yS+Wm/9wIAu9opvQ
	(envelope-from <netdev+bounces-284236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 08:47:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5FB4C74E0
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 08:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AB35302E7C2
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 06:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5D83CBE7C;
	Tue,  5 May 2026 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K95i7XiR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F3347BD4;
	Tue,  5 May 2026 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777963606; cv=none; b=uHpDvDFviOlvQTMCXcm5hiDHVHibd85fr3TnOk/cC4gTXQzyixeETSwFefkmSpkYBtO/643GpuOGNis3CGYZxXz6+gc8Rszc6AbOeeaIcnodlamPMWl1oJUOOMLLQ92Tme547TqxWx/ryQABrgsDcJ13eFMuKdjrc5FkXphmGSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777963606; c=relaxed/simple;
	bh=fLhr1zWFaI0LfPFHAMsXsogiWg/pdzfl42j7j+mpy7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YI/S1R43+YAjc+p01OGUwrki/2Shjc5Zbe/ARdfbIr1Pc9ftxDfAfH4RTFhtfMu0lNMORx7NrCi+RlfSFkNSA/T4oxFa062RJqKCEU3IO0Fj3N7xAnP0dpnDIYm3yuqcJ5kasgfk5h8yy0piS1EEA3Wl5Zq3PaGEn94ww1wO6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K95i7XiR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777963604; x=1809499604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fLhr1zWFaI0LfPFHAMsXsogiWg/pdzfl42j7j+mpy7c=;
  b=K95i7XiRWJxCQ95R5CZy32j0ozXgTkGm+JqVG62XiqFtdEKmA3eK4LOX
   PbosN9f5HxugS2LszyHABqgMl6JhWQyB/H6Oic+YakohYmnJ0j1b8+FWm
   36+iR1ZUiL+HaS6BP+0EzHXSEYZCFbUbImNJRUj7hDQtgLvelNTYIIrbB
   8K/M9oLPgkoUjBgi/amWh4W24hCTdDyRYzO6i+iqqUN7HBKlRTR/UaPjv
   SBlzxq2LmzEPU8FHNN6M4IoO3Ur4FDJRYkVo9KkIuNd0zowchRunyQkqn
   uhygwNb7pzXGgJ5Jb5597h4qcd7fjfv0slKrP3hD7y34RlXk9TNUWpP9E
   Q==;
X-CSE-ConnectionGUID: GsO2qc6yQq+mWY2Lv9frLA==
X-CSE-MsgGUID: 2A0Qf8YfSUqj2I12eJTLwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78762845"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78762845"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 23:46:43 -0700
X-CSE-ConnectionGUID: a6w9MqnhTpm3XAYLAagLdg==
X-CSE-MsgGUID: ekQwuemARuKVVnF/J7R6dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="240025728"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 23:46:42 -0700
Date: Tue, 5 May 2026 09:46:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH net-next] net: usb: mcs7830: adjust incorrect comment
 implying a vulnerability
Message-ID: <afmST20gS204Q6gO@ashevche-desk.local>
References: <20260505014634.49100-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505014634.49100-1-enelsonmoore@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 2C5FB4C74E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284236-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, May 04, 2026 at 06:46:30PM -0700, Ethan Nelson-Moore wrote:
> The mcs7830 driver contains a comment indicating that mcs7830_get_regs

See, even in the comment the function is referred as func(). Please,
follow this convention everywhere (comments, commit messages, documentation
where it's appropriate).

> leaks uninitialized memory to user space on some devices. If true, this
> would indicate a security vulnerability. However, I investigated the
> issue and found that it is not true because ethtool_get_regs (in

ethtool_get_regs()


> net/ethtool/ioctl.c) uses vzalloc to allocate its buffer, which zeroes

vzalloc()

> the memory. Update the comment to explain this behavior.

...

>   * - implement get_eeprom/[set_eeprom]
>   * - switch PHY on/off on ifup/ifdown (perhaps in usbnet.c, via MII)
>   * - mcs7830_get_regs() handling is weird: for rev 2 we return 32 regs,
> - *   can access only ~ 24, remaining user buffer is uninitialized garbage
> + *   can access only ~ 24; this is not a security vulnerability because
> + *   ethtool_get_regs allocates a zeroed buffer

Same as above.

>   * - anything else?

...

Also, while the patches are not conflicting with or dependent on each other,
they are against the same driver, hence the series is preferable over
individual patches.

-- 
With Best Regards,
Andy Shevchenko



