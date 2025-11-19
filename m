Return-Path: <netdev+bounces-240156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A74BC70D6A
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4B0332BB54
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DDA35BDDB;
	Wed, 19 Nov 2025 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhAJoSW2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F110B1DE3DC;
	Wed, 19 Nov 2025 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580964; cv=none; b=MQ0oxHjna8845FwKGnlwFX6wDjftt99tPKCoJU4R493EgNJEdiD9c20pSBjyEpLLMDuHfXjYzPIaoMBzVcxNrSmcMLNhN1VeSYdZuRq1jd/Il+a4oOQ3Zef6IngwfjDy15LI0zIxZhAFCBcCg5lFVsTg+6jpO3gM67EYX8KNk+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580964; c=relaxed/simple;
	bh=bez+CQkfaww081dvqDXAVsriAvoJSfA+OSquu+Hh7Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX/E2hEjqwX5xaWkQbRaXOcK7CdlQ6zZHmtvgsdXMPxIUPzYAr5PBHyemrJmnYOcRVWxz+RJtjTnuujdudSItNP/JG3VtgZ/x3PNNSjnDmrrwC/DzLFRB42L+ludzuEOKVULQweahvh8b48Ie55YGl5Aef06yQj0pDmMv2ViTVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhAJoSW2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763580962; x=1795116962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bez+CQkfaww081dvqDXAVsriAvoJSfA+OSquu+Hh7Sw=;
  b=VhAJoSW2Vqfcl/fhJGN4qZL3ORhnVYbmCDa/N5dxD4UsmTezRoOcROFU
   MGICjX1shpPIUimjMREdyPRjihf5UcWbAvB3kk1sVcRXGGNL7jWV7G6Wr
   8xpi7NQqJvUk163veM6RaLT3arrJJEqefoW0PPVVL4ih2403mKfA/cRQE
   7ij5ha7vyVm2SmrvCPwJ5+xIvKRZDfFi6ve1/zGNqLJIhQ3lZNa3ZnVaj
   WnDWOR/fGUIeCAZMefoik8I+OvS1P17FhzKBGDTmZc4W7UD+C7om56ur4
   GO3UqIlQviJ2s/rqE6/OXd8FbAUMUUEiIcX7j5rJAywF17iC8HrjAfInf
   A==;
X-CSE-ConnectionGUID: quAJagxyTfC8XZzG1futsw==
X-CSE-MsgGUID: yB0UyPTxRVmYSg8FfQif4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="75963434"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="75963434"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 11:34:01 -0800
X-CSE-ConnectionGUID: kVqpp2tRQVC4cQ8KvhjPjQ==
X-CSE-MsgGUID: BDavac7vSIi1Oji14uiDqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="195640151"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 11:33:58 -0800
Date: Wed, 19 Nov 2025 21:33:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <aR4bo4cPwWdapr7j@smile.fi.intel.com>
References: <20251118164130.4e107c93@kernel.org>
 <20251118164130.4e107c93@kernel.org>
 <20251119095942.bu64kg6whi4gtnwe@skbuf>
 <aR2cf91qdcKMy5PB@smile.fi.intel.com>
 <20251119112522.dcfrh6x6msnw4cmi@skbuf>
 <20251119081112.3bcaf923@kernel.org>
 <aR3trBo3xqZ0sDyr@smile.fi.intel.com>
 <aR39JBrqn5PC911s@shell.armlinux.org.uk>
 <aR4A1MaCn9fStNdm@smile.fi.intel.com>
 <20251119103545.53c13aac@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119103545.53c13aac@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 19, 2025 at 10:35:45AM -0800, Jakub Kicinski wrote:
> On Wed, 19 Nov 2025 19:39:32 +0200 Andy Shevchenko wrote:
> > On Wed, Nov 19, 2025 at 05:23:48PM +0000, Russell King (Oracle) wrote:
> > > On Wed, Nov 19, 2025 at 06:17:48PM +0200, Andy Shevchenko wrote:  
> > > > On Wed, Nov 19, 2025 at 08:11:12AM -0800, Jakub Kicinski wrote:  
> > > I can say that stuff such as unused const variables gets found by
> > > nipa, via -Wunused-const-variable, which as I understand it is a
> > > W=1 thing.
> > > 
> > > I suspect CONFIG_WERROR=y isn't used (I don't know) as that would
> > > stop the build on warnings, whereas what is done instead is that
> > > the output of the build is analysed, and the number of warnings
> > > counted and reported in patchwork. Note that the "build" stuff
> > > reports number of errors/warnings before and after the patch.
> > > 
> > > Hope this answers your question.  
> > 
> > Pretty much, thanks!
> 
> We do:

A-ha, thanks!

> prep_config() {
>   make LLVM=1 O=$output_dir allmodconfig
>   ./scripts/config --file $output_dir/.config -d werror
>   ./scripts/config --file $output_dir/.config -d drm_werror
>   ./scripts/config --file $output_dir/.config -d kvm_werror
> }
> 
> I have strong feelings about people who think Werror is an acceptable
> practice in 2025, but let me not violate the CoC here..

WERROR=y by default was introduced you-know-by-whom :-)

-- 
With Best Regards,
Andy Shevchenko



