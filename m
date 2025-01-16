Return-Path: <netdev+bounces-158913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79694A13BC8
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648D8188CF54
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18C622ACCA;
	Thu, 16 Jan 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1i1wq9H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89321F37DD;
	Thu, 16 Jan 2025 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036549; cv=none; b=h8sEjHvOIk0FBre/uxITpYlONs1PVgvYyyIXu9RrVzSOeHRlqK4CbSnmP4tVEu3NqqaIrXs+MS9AfezSyVWMRs5Zr+VR1+61W3oxwg/vTZDKJbSlfLhndtsupFpRhghym99CPnxqbcOEfcBuFPGkSNcPqCtCVd1cJA4J2eM+Fh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036549; c=relaxed/simple;
	bh=B2Ld/4xKkr2AKck1jg/lJNVGmJgDBTKb+T+RRb8sqL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X18OWrj1g9lXmiVVxgoB2w4jEpRnQ7+Zvwvp6keQkKbGt1Y5izRfavGooCvpozGlfM9HMqhBuA/YpminA9lF9kgKgF2jL0gyaYIaI5iRIygYiu9XQZWCnHqOR4x5IYsiycCvZ6copabhQ2VUqbdrn8snD/u1WzRfjaF6f1e0xqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1i1wq9H; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737036548; x=1768572548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B2Ld/4xKkr2AKck1jg/lJNVGmJgDBTKb+T+RRb8sqL4=;
  b=F1i1wq9HAcWf4JiOGGcAAKt42aSDFUEPOR2EsqN9PdDqRDqHSqL3sSan
   67rR1pZMS/8dPtK4O0BdOxf/WhzbSvCYKNicElghv4E0LPJg7hBkycWmC
   amcrb6jPmkfqE00HJsZ+5TQcSbAAnmXUVdeOtjTxBprCQZrUH3nOjAUah
   dC15frZYTR3QAmnTEAKd2Bgx++Sg5O7KES4UaRFDBlQ/4oK4YFOHnuAPS
   /hDAPVWaK0PuUAbUZ0f6CrB7fRHK3mr9ZY9sLAZzkhMimB3GTyfDJdbvO
   mBHxjcVKWVm04d4wP2mrD9f7qF8nOhd1cAkJ/PgnKLXqXECbYgURPkHEn
   A==;
X-CSE-ConnectionGUID: OBpGF4hOQJS79d/ZqjavjA==
X-CSE-MsgGUID: d0LfdF5STfuti2KFROOVQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="25023994"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="25023994"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 06:09:07 -0800
X-CSE-ConnectionGUID: nDISIQaxTH27HEtEJ9rHjQ==
X-CSE-MsgGUID: Ju2B5wgjTOCzk1RgaVxyiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105963926"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 06:09:05 -0800
Date: Thu, 16 Jan 2025 15:05:43 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: phy: realtek: clear master_slave_state if
 link is down
Message-ID: <Z4kSLaU8DNSOqJv5@mev-dev.igk.intel.com>
References: <cover.1736951652.git.daniel@makrotopia.org>
 <2155887c3a665e4132a034df1e9cfdeec0ae48c9.1736951652.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2155887c3a665e4132a034df1e9cfdeec0ae48c9.1736951652.git.daniel@makrotopia.org>

On Wed, Jan 15, 2025 at 02:43:43PM +0000, Daniel Golle wrote:
> rtlgen_decode_physr() which sets master_slave_state isn't called in case
> the link is down and other than rtlgen_read_status(),
> rtl822x_c45_read_status() doesn't implicitely clear master_slave_state.
> 
> Avoid stale master_slave_state by always setting it to
> MASTER_SLAVE_STATE_UNKNOWN in rtl822x_c45_read_status() in case the link
> is down.
> 
> Fixes: 081c9c0265c9 ("net: phy: realtek: read duplex and gbit master from PHYSR register")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/phy/realtek.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index 26b324ab0f90..93704abb6787 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -1038,8 +1038,10 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (!phydev->link)
> +	if (!phydev->link) {
> +		phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
>  		return 0;
> +	}
>  
>  	/* Read actual speed from vendor register. */
>  	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL_VND2_PHYSR);

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.47.1

