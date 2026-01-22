Return-Path: <netdev+bounces-252380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIyzL785cmlMfAAAu9opvQ
	(envelope-from <netdev+bounces-252380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:52:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E32E68299
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB57488CB58
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BDE2EFDA2;
	Thu, 22 Jan 2026 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PToFGCwC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9306C314D03;
	Thu, 22 Jan 2026 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092726; cv=none; b=m3xnYnpPrhFKtAO7aKcIuyIYccigoAJqGb4gbUKV2xuadSwKcoHVWS6AG681CVvuWgMKvVdhYKsR4fpk0QQsiz+BTu1FotqdaVtaLOJOgHC5AOGmzfLc6rJgXzhLFHrAwFxqqvWLB5VqeRtYVOKblW2M+qXRqX3BwealrGSN/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092726; c=relaxed/simple;
	bh=KtZZpyl9pEcc1bhKq2hcSBFmtlut5n1uOTpvrtP6wi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZmM9BhWkJcwMBFxgu4KhiZs8VXmRSKKn40tuac8FNjeJacpsLTmwNFJakujAFg8mwfFLYJrUOinvBNlrIZkSgUxijLVBgPiMLbiKyQbz2UdevDpLoNRgYFGmTSOwajBTGr+43ysE0pMRDk2jP382uK7dbmgCItE3Pc61wbymc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PToFGCwC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769092724; x=1800628724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KtZZpyl9pEcc1bhKq2hcSBFmtlut5n1uOTpvrtP6wi0=;
  b=PToFGCwC2fq52atNEig3HwX+j3+FWojNNTvNqP7KO0d9oy3uOShOuNCh
   Bs7BanuPGz6nzUULwOkMCsIYaMZupF0GMePMaSjdsvpmxma3iCzzHcAoq
   nLjtgQZ+kXhyQYhCNC15YWO3QXt3aeoQBnA/pXaJmdHaX7rr7pH1DtN0C
   41uLHmMqh2fKEQGflrx8c2IAXpPQCkYCUjrZWgznjNN36/LaNHJoKlcrB
   aF2GgToaYuTzkn6tmDe83v7fy+vkVcGAi0y7ojvnSsWYJsZpwr7dW0gl0
   pxsfC4ZmIuVF6YkKeokkCibU2pL+L24qKE0ju38g7C6kfIvBMKaJh3WQS
   Q==;
X-CSE-ConnectionGUID: cp+apLRRT9eeZk2vZqibAA==
X-CSE-MsgGUID: odLG9keKS1WYuJpR0k8GgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="80960995"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="80960995"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 06:38:43 -0800
X-CSE-ConnectionGUID: 1KXmE5QlREG6g0Q8Cb6ilw==
X-CSE-MsgGUID: p0JWiMHeSoq0rGS9N2MNng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211606126"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 06:38:39 -0800
Date: Thu, 22 Jan 2026 16:38:37 +0200
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
Message-ID: <aXI2bWhDtNNfr8M8@smile.fi.intel.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-2-vladimir.oltean@nxp.com>
 <aXISv3Acm1v6yS4V@smile.fi.intel.com>
 <20260122121301.cyxyevi7xvqw2axk@skbuf>
 <20260122134704.pxeikyk4q7nhay55@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122134704.pxeikyk4q7nhay55@skbuf>
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
	TAGGED_FROM(0.00)[bounces-252380-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,bootlin.com:url,intel.com:dkim]
X-Rspamd-Queue-Id: 2E32E68299
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 03:47:04PM +0200, Vladimir Oltean wrote:
> On Thu, Jan 22, 2026 at 02:13:01PM +0200, Vladimir Oltean wrote:

...

> > > > +	unsigned int base;
> > > 
> > > Hmm... resource_size_t ?

> > Well, regmap_read() takes "unsigned int reg".
> > https://elixir.bootlin.com/linux/v6.18.6/source/include/linux/regmap.h#L1297
> > So in practice, a truncation will be done somewhere if the register base
> > exceeds unsigned int storage capacity. But I didn't feel that it's worth
> > handling that.
> 
> Would this address your feedback?

Yes and no. See my remarks below.

> diff --git a/drivers/net/mdio/mdio-regmap.c b/drivers/net/mdio/mdio-regmap.c
> index 2a0e9c519fa3..416ff4e13e8f 100644
> --- a/drivers/net/mdio/mdio-regmap.c
> +++ b/drivers/net/mdio/mdio-regmap.c
> @@ -67,8 +67,15 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
>  	mr = mii->priv;
>  	mr->regmap = config->regmap;
>  	mr->valid_addr = config->valid_addr;
> -	if (config->resource)
> +	if (config->resource) {

Btw, this might be not enough, one should check size and flags as well
before use. There was a discussion about this recently. Maybe we should
just move to a simple unsigned int in the config for now? Because handling
resources maybe considered as over engineering in this case.

> +		if (config->resource->start > U32_MAX ||
> +		    config->resource->end > U32_MAX) {

Ideally it should be resource_overlaps() check. But see above.

> +			dev_err(config->parent,
> +				"Resource exceeds regmap API addressing possibilities\n");
> +			return ERR_PTR(-EINVAL);
> +		}
>  		mr->base = config->resource->start;
> +	}

-- 
With Best Regards,
Andy Shevchenko



