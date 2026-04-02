Return-Path: <netdev+bounces-274644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGXiKaCszml+pQYAu9opvQ
	(envelope-from <netdev+bounces-274644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:51:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A127A38CC4C
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 712D9300B2A8
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 17:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38D22D23A6;
	Thu,  2 Apr 2026 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vjwP+VH5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF54259CBD;
	Thu,  2 Apr 2026 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152282; cv=none; b=YQNSow11m0lJEAvBY13vU+wkm/57mtOi5UXn9OjlgnI0dpMGoWIwCLaZrSykkaD9CoGiCT5qKICg3QdvPj6hKeA7YRwC4fRLklHkeQo6COJB6i/PktJSj3nlJ6oyRxZWTHceTASU7SAO4MBQocI9dQxu1l8wHDEaMShOBL22KRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152282; c=relaxed/simple;
	bh=+eZJ72KKEz4oSP9Rvq379h1VmWRnkns+bvCWKc56AwM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpyxNNeNXmzU3xvYgxBHyjNhBRjYS3g7aZKeWy0r/LYVcY2wEJ/PcYCVhEbpAWIfmatk9aWOdmKfTgy7q+6EfuafGihrrtgzHiVe9DSEMzCg3KRkWO84gIEpiEI46uFhthomwCjWCTLsRoJw9jTRdXhbZOKHqWDmy3wnlCd4Xok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vjwP+VH5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775152281; x=1806688281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+eZJ72KKEz4oSP9Rvq379h1VmWRnkns+bvCWKc56AwM=;
  b=vjwP+VH5PQCUpz2CLCxkq2MV9xqyPbeI18YUfFSiG9mMSy+I4+FMvpOt
   zX7HG1zYeA2d++Iuv4+G7mKRCBM5JkVGkoxEJA1picE6ST0MYFk+nhe3+
   Hjfi3SdtUK+QGgldtdL/V4AuAPXHRuta7i/Wus1Otz15F92XMoec2S5rk
   jKpN3axf5LubFEhm1mEX41OH1G11NHy+UUsQx4opuhppFTbs7DJEeL280
   KGzQuecv/ldrPQ0SLh0fsEMNdMCivXlARPN7ZGqS1pH1nLqpYwu4I5KpY
   uftAf5Bp+ZRHc2Yxn+h3aWs8BQ3TaPldlTlkSY2VhOqaUsT9VPWOHPGET
   Q==;
X-CSE-ConnectionGUID: 63LuaJA/RaCcuYiEkLrjSw==
X-CSE-MsgGUID: CyF56s5yQKuQjSluyuOduA==
X-IronPort-AV: E=Sophos;i="6.23,156,1770620400"; 
   d="scan'208";a="286977618"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2026 10:51:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 2 Apr 2026 10:51:09 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 2 Apr 2026 10:51:09 -0700
Date: Thu, 2 Apr 2026 10:51:07 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] net: phy: add a PHY write barrier when
 disabling interrupts
Message-ID: <ac6siwiXWOaw/hfg@bby-cbu-swbuild03.eng.microchip.com>
References: <20260402131229.319599-1-charles.perry@microchip.com>
 <20260402131229.319599-4-charles.perry@microchip.com>
 <6bb3aec4-1635-4287-b7ce-f15b693563ea@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6bb3aec4-1635-4287-b7ce-f15b693563ea@lunn.ch>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	FREEMAIL_CC(0.00)[microchip.com,vger.kernel.org,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274644-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bby-cbu-swbuild03.eng.microchip.com:mid]
X-Rspamd-Queue-Id: A127A38CC4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 03:31:52PM +0200, Andrew Lunn wrote:
> > +static int phy_write_barrier(struct phy_device *phydev)
> > +{
> > +	int err;
> > +
> > +	err = phy_read(phydev, MII_PHYSID1);
> > +	if (err < 0)
> > +		return err;
> 
> There are a small number of MDIO busses which don't implement C22,
> only C45. You are likely to get -EIO or maybe ENODEV, -EOPNOTSUPP,
> -EINVAL for such a read. Returning the error than makes
> phy_disable_interrupts() fail, etc.

Ok, I didn't know about this. Do you think there's any merit in handling
the case where phydev->mdio.bus->read is NULL and doing a C45 access in
that case?

> 
> This is why i suggested throwing away the return value.

Ok

Thanks,
Charles

> 
> Maybe call phydev_info() if there is an error, but i suggest making
> this a void function.
> 
>     Andrew
> 
> ---
> pw-bot: cr

