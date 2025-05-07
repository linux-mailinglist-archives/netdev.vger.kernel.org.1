Return-Path: <netdev+bounces-188695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C01AAE3B5
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D026E1893BF3
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E16C1940A1;
	Wed,  7 May 2025 15:00:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722853C3C;
	Wed,  7 May 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630039; cv=none; b=jCjJv7P7k5lOSks5bJwW/qvbhgvO+w/eyJnn7jHeUtP9plN53knvXmexhjfsrI47nJdRdOTyH+HZMNCLbQivIV6L5DuYoDjH314wvRSbVx1VQ/0rcYYbqZqWy4GF8Lig0bwTIOOm9ZB2HHGFqN6T6Oa0zkLKqS2fuZVdxQmD+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630039; c=relaxed/simple;
	bh=JNpvPZbMb+aYwY2flVYylEzU1bQHVJ+UY3EW6wGWxvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYvSWTimAaHCY3nzPOawPVRz6n/baWFTCn9Sij/0KhLRUOAx/3bxMbFQESnx7Q858QhQmt5/OATgsi81s9A3xnBld9Aijit6UgkAkEqbYtwZTX9OIhQW2DHLogEAh9IemQ9zWYmHDziiwdJ6Oo3j1gfr6wyMCw3xGZhx+JJI1y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: fv6uz3trSMSel/jU0A3+Ag==
X-CSE-MsgGUID: VuZ2oFvYSe6eAyxoDYcm/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59721998"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="59721998"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 08:00:37 -0700
X-CSE-ConnectionGUID: vcQCR8GQTTORGFgGMOxvfw==
X-CSE-MsgGUID: E89KBisHRieep0v+NdvTPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="140029623"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 08:00:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1uCgG6-00000003lLs-0Ogl;
	Wed, 07 May 2025 18:00:30 +0300
Date: Wed, 7 May 2025 18:00:29 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Lee Jones <lee@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v7 8/8] mfd: zl3073x: Register DPLL sub-device
 during init
Message-ID: <aBt1jXNRgtNVDcWC@smile.fi.intel.com>
References: <20250507124358.48776-1-ivecera@redhat.com>
 <20250507124358.48776-9-ivecera@redhat.com>
 <CAHp75Ven0i05QhKz2djYx0UU9E9nipb7Qw3mm4e+UN+ZSF_enA@mail.gmail.com>
 <7e7122b1-b5ff-4800-8e1d-b1532a7c1ecf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e7122b1-b5ff-4800-8e1d-b1532a7c1ecf@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 07, 2025 at 04:19:29PM +0200, Ivan Vecera wrote:
> On 07. 05. 25 3:41 odp., Andy Shevchenko wrote:
> > On Wed, May 7, 2025 at 3:45 PM Ivan Vecera <ivecera@redhat.com> wrote:

...

> > > +static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
> > > +       { .channel = 0, },
> > > +       { .channel = 1, },
> > > +       { .channel = 2, },
> > > +       { .channel = 3, },
> > > +       { .channel = 4, },
> > > +};
> > 
> > > +static const struct mfd_cell zl3073x_devs[] = {
> > > +       ZL3073X_CELL("zl3073x-dpll", 0),
> > > +       ZL3073X_CELL("zl3073x-dpll", 1),
> > > +       ZL3073X_CELL("zl3073x-dpll", 2),
> > > +       ZL3073X_CELL("zl3073x-dpll", 3),
> > > +       ZL3073X_CELL("zl3073x-dpll", 4),
> > > +};
> > 
> > > +#define ZL3073X_MAX_CHANNELS   5
> > 
> > Btw, wouldn't be better to keep the above lists synchronised like
> > 
> > 1. Make ZL3073X_CELL() to use indexed variant
> > 
> > [idx] = ...
> > 
> > 2. Define the channel numbers
> > 
> > and use them in both data structures.
> > 
> It could be possible to drop zl3073x_pdata array and modify ZL3073X_CELL
> this way:
> 
> #define ZL3073X_CHANNEL(_channel)                               \
>         &(const struct zl3073x_pdata) { .channel = _channel }
> 
> #define ZL3073X_CELL(_name, _channel)                           \
>         MFD_CELL_BASIC(_name, NULL, ZL3073X_CHANNEL(_channel),  \
>                        sizeof(struct zl3073x_pdata), 0)
> 
> WDYT?

Fine with me as it looks not ugly and addresses my point.

-- 
With Best Regards,
Andy Shevchenko



