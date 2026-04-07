Return-Path: <netdev+bounces-276129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IN45Me5J1Wlg4QcAu9opvQ
	(envelope-from <netdev+bounces-276129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:16:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9DD3B2DA9
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9771C300DE3C
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 18:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235742135C5;
	Tue,  7 Apr 2026 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FZ71mDza"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D3518AE3
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775585772; cv=none; b=YTC72RTi7kJNc8nAKOdQ60S34opR/JHuWK7N2LBzFz/Vzj9IDRc05ALv9SBgTMVrwfXOkUgDTiGP4C+fzOs1jdJu1D9zWf4o9ea/keSbeGKNgsY1EMsYHYP7vd3ExLO1BSCtPfkFRgZ7Xq2JTiRZcjHLCnQNz+o93hM1uXUT7kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775585772; c=relaxed/simple;
	bh=7yzR7MN+zWima1/1USiTtVXatpKFc/V4vVvptG/tFHo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMK/GBzeitCsewi/HdDQCFT7LhvFH6iAq7tbuNE3XwoWr/EYqywTiwRUTJzr5oztjyshf0EGhNY0fJ5emtHX9uM+lXtK78rwB/8GEamWQTS8EMkeclSsoQXFE1y4wYCQrAg336+e52/jazlZovFALZLoTPPKjTwhDv7HzrWTv0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FZ71mDza; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775585770; x=1807121770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7yzR7MN+zWima1/1USiTtVXatpKFc/V4vVvptG/tFHo=;
  b=FZ71mDza0n3qWlcjiWhPkhjXbU/J2sO9MVJiDMuBRLHJWNkr4XwVpwxj
   jQHWABro/8mqkeX5O6L2H8JQYKK6A5xHKckCJse83Zzl04x/TRTV468wq
   BbV/8uuik54cWCC4R3FmCGgxcNKAtWcSf9yniz/eEI/0dk/1B5LVPjp0S
   3dh2SGinrRoG5YxpFs8EOGMUFYj78r2Ds1mPWHKunv2kP7qgZuJhSECPH
   Q7y/FN1xdTvwPBASLuRlS0JMANGpUEY3uXi5whZgfWYvyXPFBPMtNasAc
   SF01wbFxS5TOWEUxXlYLpyMQ3Qf5TqahzexwCAcDQCbkzLKDIKs7Amzdf
   A==;
X-CSE-ConnectionGUID: A4fTM7iVSYqrwUzPcITd8A==
X-CSE-MsgGUID: pTLBd2eCRnm+FD3Y2mjBEA==
X-IronPort-AV: E=Sophos;i="6.23,166,1770620400"; 
   d="scan'208";a="63638843"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 11:16:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 7 Apr 2026 11:15:52 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 7 Apr 2026 11:15:51 -0700
Date: Tue, 7 Apr 2026 11:15:49 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
	<olteanv@gmail.com>, <netdev@vger.kernel.org>, Tim Menninger
	<tmenninger@purestorage.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, <charles.perry@microchip.com>
Subject: Re: [PATCH net-next v2 1/2] net: phy: c45 scanning: Don't consider
 -ENODEV fatal
Message-ID: <adVJ1YpHv1bWCxKL@bby-cbu-swbuild03.eng.microchip.com>
References: <20240204-unify-c22-c45-scan-error-handling-v2-0-0273623f9c57@lunn.ch>
 <20240204-unify-c22-c45-scan-error-handling-v2-1-0273623f9c57@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240204-unify-c22-c45-scan-error-handling-v2-1-0273623f9c57@lunn.ch>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,purestorage.com,broadcom.com,microchip.com];
	TAGGED_FROM(0.00)[bounces-276129-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bby-cbu-swbuild03.eng.microchip.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:dkim]
X-Rspamd-Queue-Id: 2E9DD3B2DA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Feb 04, 2024 at 05:14:14PM -0600, Andrew Lunn wrote:
> When scanning the MDIO bus for C22 devices, the driver returning
> -ENODEV is not considered fatal, it just indicates the MDIO bus master
> knows there is no device at that address, maybe because of hardware
> limitation.
> 
> Make the C45 scan code act on -ENODEV the same way, to make C22 and
> C45 more uniform.
> 
> It is expected all reads for a given address will return -ENODEV, so
> within get_phy_c45_ids() only the first place a read occurs has been
> changed.
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/phy/phy_device.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 52828d1c64f7..962ab53c23ff 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -780,7 +780,7 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
>   * and identifiers in @c45_ids.
>   *
>   * Returns zero on success, %-EIO on bus access error, or %-ENODEV if
> - * the "devices in package" is invalid.
> + * the "devices in package" is invalid or no device responds.
>   */
>  static int get_phy_c45_ids(struct mii_bus *bus, int addr,
>  			   struct phy_c45_device_ids *c45_ids)
> @@ -803,7 +803,11 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
>  			 */
>  			ret = phy_c45_probe_present(bus, addr, i);
>  			if (ret < 0)
> -				return -EIO;
> +				/* returning -ENODEV doesn't stop bus
> +				 * scanning
> +				 */
> +				return (phy_reg == -EIO ||
> +					phy_reg == -ENODEV) ? -ENODEV : -EIO;

Hello Andrew,

Did you meant "ret" instead of "phy_reg" here?

"phy_reg" doesn't make sense here because you would have already returned
in the previous iteration of the loop.

Thanks,
Charles

>  
>  			if (!ret)
>  				continue;
> 
> -- 
> 2.43.0
> 
> 

