Return-Path: <netdev+bounces-168063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4284DA3D405
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D5B7A454C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2B01EB1A6;
	Thu, 20 Feb 2025 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqLSDVzg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50981B3927
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041995; cv=none; b=KQztq4lIq4nZR7etXRmd6guK9Bcd4vndg5RvpouOJi2nmK2nqQpAtbM+Ma6kG5gCTgQFYNPneXio1U+MYZ1m4c97SWI3cZqEFxyKKdF9Uke4XYEscW+9qSwjQzkOnLhquBST/iAHpGVpv4xQz1Y7q4mCp1pDd/0hmLb3gYlT5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041995; c=relaxed/simple;
	bh=3Ubl3ns17CKpaPgNxOJL10nntVn3JWMbG2pySqgNZvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNTRQde3rJhaBN9/fch+73o6CmNqgZ+C6853cDlE+fH1jT7Dcov78bsLdeUgDvw+Pj0PiyqGlfhF6zVhx2sHR0UDZEpspe0fmQVNHN2Hd9DSm3gnnuyEqkzovVkyMRXEhzgOKi9w2Fqubz9VWKs6ClLU6hzAWY9v3icK28CNGXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqLSDVzg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740041994; x=1771577994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Ubl3ns17CKpaPgNxOJL10nntVn3JWMbG2pySqgNZvQ=;
  b=IqLSDVzgZ7JCpSe9mROUDoz5tzXFkAK9lGZ3aWFU8wQH5kceW0i+EJ/T
   iQYmgGhTxBQ84vwAE5bdaBQW7OTNjtcHhn9DQnIZy+id+ePqo0BXQo3s9
   qSnnJC2OmkeE5oeFILm0iXQy16ONvMKaRKzRvzlUJrhaFmdnFobDCbgXM
   mx/OiE2RhBA5tAbNiSGHNORKeFwBla1JREDJxX3sp0/jzGELSG+Dy8/zx
   mrX5aF+QMIB9tIc9vEaH553F6vdP+yfTtDcTu9E1Z35idofAsCcgKUVs1
   mJMpq/SRDnPJgAAP7CCvPEjhCBl/uB6iTBvyCqus6UUZZ+JKYJA4MK/19
   Q==;
X-CSE-ConnectionGUID: S6tfjh4eS1ShtJ4e8FfWRg==
X-CSE-MsgGUID: oTtVxrTrQH+PIls8bBqecw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58218787"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="58218787"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 00:59:53 -0800
X-CSE-ConnectionGUID: ecIZtj1sT3GJPfozYDKgHA==
X-CSE-MsgGUID: sakqFLARTlqXddSWHiw8Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120205244"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 00:59:51 -0800
Date: Thu, 20 Feb 2025 09:56:11 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: remove unused feature array
 declarations
Message-ID: <Z7buKyQkBpIIlBgW@mev-dev.igk.intel.com>
References: <b2883c75-4108-48f2-ab73-e81647262bc2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2883c75-4108-48f2-ab73-e81647262bc2@gmail.com>

On Wed, Feb 19, 2025 at 09:15:05PM +0100, Heiner Kallweit wrote:
> After 12d5151be010 ("net: phy: remove leftovers from switch to linkmode
> bitmaps") the following declarations are unused and can be removed too.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  include/linux/phy.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 3076b4caa..e36eb247c 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -37,10 +37,7 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_t1_features) __ro_after_init;
>  extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_t1s_p2mp_features) __ro_after_init;
>  extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_features) __ro_after_init;
>  extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_fibre_features) __ro_after_init;
> -extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_all_ports_features) __ro_after_init;
>  extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_features) __ro_after_init;
> -extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_fec_features) __ro_after_init;
> -extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_full_features) __ro_after_init;
>  extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap1_features) __ro_after_init;
>  extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap2_features) __ro_after_init;
>  

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.48.1

