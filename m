Return-Path: <netdev+bounces-283886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N/RNtmx+GkdzAIAu9opvQ
	(envelope-from <netdev+bounces-283886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:48:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 813E24C00AD
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AED77301F144
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54F13DA7EC;
	Mon,  4 May 2026 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDlh6Lrw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834BD34F483;
	Mon,  4 May 2026 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777905683; cv=none; b=frbn5SyF5aJCr/zQZfdzPCHKLS91EM/4/xdgQaTy6z1xSRi2gyIEkWWaaV2+ll/QYkYxVRpYVZBEm6HyFJTC3YH/IG2DwC47QSKcI2So1AOdMP/laKRNcmvkc00pbLUg87Fi00XAsqwKvRbNElWRQeFSYtfQ9cFKuvanxKrIzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777905683; c=relaxed/simple;
	bh=HhFh0Y8oSLMdmoTCiqbD0O0IMho8tTieWXvFaDViqyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jygp7HAW16QAsj1Ey5l91VyqREbovlQZT6oQggy9aAsQmD295MKdc0RjMq+QhP2jyjC4EcQWdG1atbfet2oxOM0PyqR/whL47qyAuGY3m+dI3ZsDXZopek4al9DqZJQlqnlqHC94FfuL7qr6cB5M1M5T8raJjVcU6VhifY2T4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FDlh6Lrw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777905682; x=1809441682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HhFh0Y8oSLMdmoTCiqbD0O0IMho8tTieWXvFaDViqyo=;
  b=FDlh6Lrw60H+AS70sNssbVTQXxKBJQnhffSi2Z6NeEvntnIKHfWfTa6Y
   kSf6HbKlEJmqppl61VRbafaxBt+toSE/f1PDSrWzbuKXaMlyfSKXcBREj
   uWf6ksjRNMkLyajyjgz6I8HkCy7bcgg8Re29mk0rDI9wh7z3oXFfFa9iF
   NGNzIZrx6N0Z4ljEzYGQ7rEzZpPQIEHKYImsnXN1D743/0I6f+Bgi2rL4
   CX60WJN/rVgmeJ0WkDWbog9+8g+QilUgtP227IR2ogklNEespO1KtPJT6
   b9ligzb6uiotdg8H+Ljxhd7YU7TbcyJPCRcgca3wMe8iPFKwLn0W714p+
   A==;
X-CSE-ConnectionGUID: yeT6kS1TQOCW+ZHBUv/7SQ==
X-CSE-MsgGUID: 9WcsYLX/Tp2IB1XZ4XOqwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="96189578"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="96189578"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:41:21 -0700
X-CSE-ConnectionGUID: 54UoR6i8QVO2wnwTG6nxHg==
X-CSE-MsgGUID: YVLDxv33TEmGg+zjLiGLzg==
X-ExtLoop1: 1
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:41:18 -0700
Date: Mon, 4 May 2026 17:41:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: linux-kernel@vger.kernel.org,
	Linux Kernel Network Developers <netdev@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v1 1/5] net: mdiobus: Provide
 fwnode_mdiobus_register()
Message-ID: <afiwDFilK2fgUoVb@ashevche-desk.local>
References: <CA+NMeC-VCxWfzwHQTiY-eGA=FEmLY7_7AHgBrZ+dK+LC-d7pUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+NMeC-VCxWfzwHQTiY-eGA=FEmLY7_7AHgBrZ+dK+LC-d7pUw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 813E24C00AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-283886-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, May 04, 2026 at 11:16:00AM -0300, Victor Nogueira wrote:
> On 04/05/2026 04:29, Andy Shevchenko wrote:
> > Provide an agnostic helper to register MDIO bus independently on
> > the firmware node provider.

[...]

> > +     if (is_of_node(fwnode))
> > +             return __of_mdiobus_register(mdio, to_of_node(fwnode), owner);
> 
> Build seems to break when CONFIG_OF_MDIO is not defined:
> 
> drivers/net/mdio/fwnode_mdio.c: In function ‘__fwnode_mdiobus_register’:
> drivers/net/mdio/fwnode_mdio.c:198:24: error: implicit declaration of
> function ‘__of_mdiobus_register’; did you mean ‘of_mdiobus_register’?
> [-Wimplicit-function-declaration]
>   198 |                 return __of_mdiobus_register(mdio,
> to_of_node(fwnode), owner);

Ah, thanks for a good catch. I haven't checked OF case to be off.
Yeah, with __acpi_mdiobus_register the compiler sees the prototype
independently on the configuration option. I will think about OF
case (like I said it can also be hidden, the problem is that there
is a huge amount of users, that's why I haven't touched it).

-- 
With Best Regards,
Andy Shevchenko



