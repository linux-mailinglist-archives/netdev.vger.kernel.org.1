Return-Path: <netdev+bounces-252378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGejKo9CcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:30:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2840468DAE
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B25B784C7F3
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A4E34D4FB;
	Thu, 22 Jan 2026 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WibVxrQi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F41629CB3A;
	Thu, 22 Jan 2026 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092127; cv=none; b=fsxj6u3OvwMImnxd1isZd3YG3CQegQwVmpbq3XFXHBmEgMXMax1EsI8ZzMihhTj2L5f/4EUj7Kqy1prFCIbf85dqXhoXGe/kS4fw3tBbCoMpJTGUY6lk98a8So3MN+Dggvvr1TCA2t2dJu8Qot3FnTd6Gc2msxe+pbbD1NYowzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092127; c=relaxed/simple;
	bh=q+1sYBA9PQtb89RfW6pjRHDbl1q/Q0h/ZePbba5ii7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtEJbch6LV7t5Gjc42Itfi2LxbCemxetUnQrypAovoiZ6RHddbW+52cLwhKi3NlY/mtIbMj64bCIYupZ4vFas9ZMNm+VXAXB8tWUge4vUtAOI0rLLyOdqRCf2YHkL9Am75eZjtk+XOVlE4l5l5tMeDeDtIsbtVtGjcnGn807tss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WibVxrQi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769092125; x=1800628125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q+1sYBA9PQtb89RfW6pjRHDbl1q/Q0h/ZePbba5ii7U=;
  b=WibVxrQiDMSgws6vqRl9nqs2CZLTPvWbUkDht/cW7xFuS3zNFivJfW23
   omaQyojJrONog65fmJ2PIUFqAuPPw4rD5IDFYO5M5tggcx9ltulQgDXfk
   jDH4BuLnRv/3IPuN0to/190Ucu5Z+1gKZIWoWfk30i/UXJF/3xR4hR0Cp
   e8I90OWW6jg9J5v5BS/J6de1OyTnSftP6vprx3nv8VK6Hhb7rBh6gQaXY
   IZhUhqLMWfitWdq0KHzmAF836p/OsvENlUZL95JGvIPh4d4PobTVdn363
   nwDCuxwR7YG4GPaelt0CfJY4d2llvxCRyPXSME9ih7RKYkdbho3kqxOxE
   w==;
X-CSE-ConnectionGUID: zgrHAWwpRnaeWVi6SFpaxQ==
X-CSE-MsgGUID: vbXOMJK7QzK0O2DVQ+1rEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70389188"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70389188"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 06:28:44 -0800
X-CSE-ConnectionGUID: MtVen+tNTfmkXZF5GblPbA==
X-CSE-MsgGUID: WloQCkRlSz69zIISyvigYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206648487"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 06:28:39 -0800
Date: Thu, 22 Jan 2026 16:28:37 +0200
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
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 net-next 01/15] net: mdio-regmap: permit working with
 non-MMIO regmaps
Message-ID: <aXI0FdE66sejdvng@smile.fi.intel.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-2-vladimir.oltean@nxp.com>
 <aXISv3Acm1v6yS4V@smile.fi.intel.com>
 <20260122121301.cyxyevi7xvqw2axk@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122121301.cyxyevi7xvqw2axk@skbuf>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,linux.intel.com,trustnetic.com];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-252378-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,bootlin.com:email,intel.com:dkim,smile.fi.intel.com:mid,nxp.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 2840468DAE
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 02:13:01PM +0200, Vladimir Oltean wrote:
> On Thu, Jan 22, 2026 at 02:06:23PM +0200, Andy Shevchenko wrote:
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > 
> > FWIW, Cc list may be located after --- line. It will have the same effect on
> > emails (as regular tooling will parse and put them into email headers), but
> > will reduce unneeded noise in the commit message. List will be still available
> > on lore.kernel.org in the mail archives.
> 
> Thanks for the comment. I know it may be located after ---, but for me,
> doing that implies an extra step which I find unnecessary (moving them
> there after the git format-patch stage). I keep the Cc: in the commit
> message in git so that it's preserved across revisions.

You can keep them in your commit message. Many --- lines are also allowed!

> > > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > ---
> > 
> >   Cc: ...
> >   ...

...

> > > +	unsigned int base;
> > 
> > Hmm... resource_size_t ?
> 
> Well, regmap_read() takes "unsigned int reg".
> https://elixir.bootlin.com/linux/v6.18.6/source/include/linux/regmap.h#L1297
> So in practice, a truncation will be done somewhere if the register base
> exceeds unsigned int storage capacity. But I didn't feel that it's worth
> handling that.

Maybe a comment near to the assignment?

-- 
With Best Regards,
Andy Shevchenko



