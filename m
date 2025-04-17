Return-Path: <netdev+bounces-183812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2277A921CF
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7B43A9C82
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1C6253F05;
	Thu, 17 Apr 2025 15:42:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954CA23F405;
	Thu, 17 Apr 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744904570; cv=none; b=pGmRcVfSGxkeg+JZbHZ69utbFqKFgTHUTQxkcOV5b9FJrzbtlNu4fmC7+7bbC+4UmtdYcv36PZb28rTAy22YeUcJ1AJb3K/9Atq0OHp/wxfg2lUGKYXd5GUCE+VLuRfQrgV+hxMDpkioLrOUBEY4WBP0kZwxPMsx8Sgm6LITP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744904570; c=relaxed/simple;
	bh=mKjn5eIbNwGR/xZufF2gLJLVRPVR1sSf5yjcxMCPa9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEjXaGzToMRbnMQAg+Ree/CvVQUYHI90kMfuiDp5H6AV4c+TkOOxVCQ4fvsHxvtVeKIGP89ZvjePx8MBfYfnkbixDQgONVVSmL+yhjJBWxVUchoPE3hTtC7TWUrcx/p5SNYUePWDP1mZePfjfCcijByci3NguUgavkfPIKoG46g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: mHW9S22RSaKlrK8RlZunJw==
X-CSE-MsgGUID: /zPK3vKDS7e/+intr2GRyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46426759"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="46426759"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:42:46 -0700
X-CSE-ConnectionGUID: jF7N0wi5TjSrcpvTp5YgAQ==
X-CSE-MsgGUID: 5baL8cTUSZCIAI5SVSUleg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="134937092"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:42:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u5RNv-0000000DF1N-3Krg;
	Thu, 17 Apr 2025 18:42:39 +0300
Date: Thu, 17 Apr 2025 18:42:39 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 net-next 3/8] mfd: Add Microchip ZL3073x support
Message-ID: <aAEhb-6QV2m21pm2@smile.fi.intel.com>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-4-ivecera@redhat.com>
 <8fc9856a-f2be-4e14-ac15-d2d42efa9d5d@lunn.ch>
 <CAAVpwAsw4-7n_iV=8aXp7=X82Mj7M-vGAc3f-fVbxxg0qgAQQA@mail.gmail.com>
 <894d4209-4933-49bf-ae4c-34d6a5b1c9f1@lunn.ch>
 <03afdbe9-8f55-4e87-bec4-a0e69b0e0d86@redhat.com>
 <eb4b9a30-0527-4fa0-b3eb-c886da31cc80@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb4b9a30-0527-4fa0-b3eb-c886da31cc80@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 17, 2025 at 05:12:35PM +0200, Ivan Vecera wrote:
> On 17. 04. 25 4:50 odp., Ivan Vecera wrote:
> > On 17. 04. 25 3:13 odp., Andrew Lunn wrote:
> > > On Wed, Apr 16, 2025 at 08:19:25PM +0200, Ivan Vecera wrote:
> > > > On Wed, Apr 16, 2025 at 7:11 PM Andrew Lunn <andrew@lunn.ch> wrote:

...

> > > Anyway, look around. How many other MFD, well actually, any sort of
> > > driver at all, have a bunch of low level helpers as inline functions
> > > in a header? You are aiming to write a plain boring driver which looks
> > > like every other driver in Linux....
> > 
> > Well, I took inline functions approach as this is safer than macro usage
> > and each register have own very simple implementation with type and
> > range control (in case of indexed registers).
> > 
> > It is safer to use:
> > zl3073x_read_ref_config(..., &v);
> > ...
> > zl3073x_read_ref_config(..., &v);
> > 
> > than:
> > zl3073x_read_reg8(..., ZL_REG_REF_CONFIG, &v);
> > ...
> > zl3073x_read_reg16(..., ZL_REG_REF_CONFIG, &v); /* wrong */
> > 
> > With inline function defined for each register the mistake in the
> > example cannot happen and also compiler checks that 'v' has correct
> > type.
> > 
> > > Think about your layering. What does the MFD need to offer to sub
> > > drivers so they can work? For lower registers, maybe just
> > > zl3073x_read_u8(), zl3073x_read_u16() & zl3073x_read_read_u32(). Write
> > > variants as well. Plus the API needed to safely access the mailbox.
> > > Export these using one of the EXPORT_SYMBOL_GPL() variants, so the sub
> > > drivers can access them. The #defines for the registers numbers can be
> > > placed into a shared header file.
> > 
> > Would it be acceptable for you something like this:

V4L2 (or media subsystem) solve the problem by providing a common helpers for
reading and writing tons of different registers in cameras. See the commit
613cbb91e9ce ("media: Add MIPI CCI register access helper functions").

Dunno if it helps here, though.

-- 
With Best Regards,
Andy Shevchenko



