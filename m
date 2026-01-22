Return-Path: <netdev+bounces-252338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCHDF4AncmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:34:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F00E7675A6
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18DD6389F14
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD383F23A1;
	Thu, 22 Jan 2026 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYIou064"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA783D6465;
	Thu, 22 Jan 2026 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084609; cv=none; b=N2uv/0FtpPkRKo1b1kyakmlOjSi75n04QyPYNH/e7n1YOUGiBa1LoaN426nho/D+ou0FHIAfxbuwwr3IEVDqsHBzzbx0UTSW1/lM8ox3KQcOTQpo/+q+cFHrw3c6AT+inzsgqSPmPggfPY0/5TyNrWBX7nS5GMXNlvHON5PxX0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084609; c=relaxed/simple;
	bh=Cj2+/kcs97ULFQET2IYCmmZHMP/yfxbtQCjdqvLuw0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBq/eB9+uGp7763fp+/+1wwk6oXLSOTzEcdJ+kJszuQ1vQ6iiEomzl1kfmEIX4frW1QMkfZyGR2UT8tsuas+HOK2+haA2OI1oGfQkOFdQJxclBtq3cYQKg5KGmxPJv+NDtdxdZu7gTeLh9HbJMN7BA1yhpSw/rGPDeQXJYmhqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYIou064; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769084607; x=1800620607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cj2+/kcs97ULFQET2IYCmmZHMP/yfxbtQCjdqvLuw0o=;
  b=DYIou064g5Iob5DGp0X3pl1m4cvpHcX9Y6kACfttvjHZBQ0RtrqUGzIL
   vLKlZuEQxOsXTjn8TA4MpQx1Ame7qvgpIuyEWVMkLv4yG2bH9mZ/hvSPh
   06XnUQhIitZDz8ybmtLD7c4L7tKSlgza9s2jQ5Ccgz+Vw2ftHhO4noc/M
   8XNRTWUMYlpiMVlXr7S8fYUvv4qVEp0j3foMJmZ6Vo+VY44Hj/4iWbHVa
   sH5Ps5H+tFWv9NhjTPlmJkHw/BTiHZp8vAyI3ILXCWVi7fDrOOOC4XU2x
   qGN0cQFL9cx+t8uWSVu4Vne5FdeJ3WCM1yV5SEB3WsZO4nFTlKZGDQOsa
   g==;
X-CSE-ConnectionGUID: PHNAjXiwRC2ndBPgRtjsQQ==
X-CSE-MsgGUID: MzF4PramRFiPxG63ZwgYkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70295924"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70295924"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 04:23:26 -0800
X-CSE-ConnectionGUID: U6vzPU6nT++c7MhEOW0iJg==
X-CSE-MsgGUID: RMhjbgxdTk25LjYGF6jUeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211236098"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 04:23:20 -0800
Date: Thu, 22 Jan 2026 14:23:18 +0200
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
Subject: Re: [PATCH v2 net-next 04/15] net: dsa: sja1105: prepare regmap for
 passing to child devices
Message-ID: <aXIWttaIcR-yq0nx@smile.fi.intel.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-5-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122105654.105600-5-vladimir.oltean@nxp.com>
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
	DKIM_TRACE(0.00)[intel.com:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252338-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F00E7675A6
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 12:56:43PM +0200, Vladimir Oltean wrote:
> Prepare a single regmap covering the entire SPI address space of the
> SJA1105 and SJA1110 switches which can be given to MDIO buses, XPCS,
> irqchip drivers etc.
> 
> This regmap is address-zero-based (can access the entire switch address
> space) and child devices are supposed to access their respective memory
> region with the help of struct resource (IORESOURCE_REG, to be precise).
> 
> Nothing is currently done with the regmap, it is just allocated and
> added to the device's devres list, so it doesn't need to be freed.

...

> --- a/drivers/net/dsa/sja1105/sja1105.h
> +++ b/drivers/net/dsa/sja1105/sja1105.h

>  #include <linux/dsa/8021q.h>
>  #include <net/dsa.h>
>  #include <linux/mutex.h>
> +#include <linux/regmap.h>
> +
>  #include "sja1105_static_config.h"

It looks to me that somebody missed grouping above (not this change) and it's
better to have it done:

#include <linux/dsa/8021q.h>
#include <linux/mutex.h>
#include <linux/regmap.h>

#include <net/dsa.h>

#include "sja1105_static_config.h"

...

> +	rc = devm_sja1105_create_regmap(priv);
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to create regmap: %pe\n", ERR_PTR(rc));
> +		return rc;
> +	}

Hmm... Perhaps return dev_err_probe(...); ?

-- 
With Best Regards,
Andy Shevchenko



