Return-Path: <netdev+bounces-188694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2169AAE3B0
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 16:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F92982D0C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE3A289E35;
	Wed,  7 May 2025 14:59:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40309289E1B;
	Wed,  7 May 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629952; cv=none; b=i0Gb4Bkd87Wpi10AaAsZMISApnv6TSUoqZxYWySK9xBDdPA6fFz2uepEsK1GY+4zPE0kupEui5cyyJwl2vGExo/xGlpgq0o5xEUshCs8Ci4qchm9JjctEGCxRGLMIl/8EM51nJfx6MPzT72JIaRvrFvzSz6WuZu9SwgwLJa6Mbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629952; c=relaxed/simple;
	bh=5M9Jjh9uDZo+VHf9DGUueg2942ffkGE/NO0/mkfCAp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8mDuBUKuxJZyqr7ylX6UnlCGEd51EtIUF+VXUK0a2VRS7R4F7lovAgnWJfNH9PoyY50AEN6Vo5FiitgGHTe8dW5kzIoXQl/d2hDSe093LKvak4noF+oHh/5l1eB6zBHipg3+kIux4ceJxphyDsGgVVHD3X1AB3byPoDeG22k4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: tEChOFZsRAWzuAhCUhzBxQ==
X-CSE-MsgGUID: gwTs4j7aRI+UYcC0cBTp9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48478247"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="48478247"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 07:59:11 -0700
X-CSE-ConnectionGUID: ob9JxO7RQ9G1d0CTgF1x2g==
X-CSE-MsgGUID: Hk7wflCUSRuHCcl3F1c2vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="136384725"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 07:59:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1uCgEi-00000003lKU-0Fpf;
	Wed, 07 May 2025 17:59:04 +0300
Date: Wed, 7 May 2025 17:59:03 +0300
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
Message-ID: <aBt1N6TcSckYj23A@smile.fi.intel.com>
References: <20250507124358.48776-1-ivecera@redhat.com>
 <20250507124358.48776-9-ivecera@redhat.com>
 <CAHp75Ven0i05QhKz2djYx0UU9E9nipb7Qw3mm4e+UN+ZSF_enA@mail.gmail.com>
 <2e3eb9e3-151d-42ef-9043-998e762d3ba6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e3eb9e3-151d-42ef-9043-998e762d3ba6@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 07, 2025 at 03:56:37PM +0200, Ivan Vecera wrote:
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
> > ...
> 
> WDYM?
> 
> > OTOH, I'm not sure why we even need this. If this is going to be
> > sequential, can't we make a core to decide which cell will be given
> > which id?
> 
> Just a note that after introduction of PHC sub-driver the array will look
> like:
> static const struct mfd_cell zl3073x_devs[] = {
>        ZL3073X_CELL("zl3073x-dpll", 0),  // DPLL sub-dev for chan 0
>        ZL3073X_CELL("zl3073x-phc", 0),   // PHC sub-dev for chan 0
>        ZL3073X_CELL("zl3073x-dpll", 1),  // ...
>        ZL3073X_CELL("zl3073x-phc", 1),
>        ZL3073X_CELL("zl3073x-dpll", 2),
>        ZL3073X_CELL("zl3073x-phc", 2),
>        ZL3073X_CELL("zl3073x-dpll", 3),
>        ZL3073X_CELL("zl3073x-phc", 3),
>        ZL3073X_CELL("zl3073x-dpll", 4),
>        ZL3073X_CELL("zl3073x-phc", 4),   // PHC sub-dev for chan 4
> };

Ah, this is very important piece. Then I mean only this kind of change

enum {
	// this or whatever meaningful names
	..._CH_0	0
	..._CH_1	1
	...
};

static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
       { .channel = ..._CH_0, },
       ...
};

static const struct mfd_cell zl3073x_devs[] = {
       ZL3073X_CELL("zl3073x-dpll", ..._CH_0),
       ZL3073X_CELL("zl3073x-phc", ..._CH_0),
       ...
};

-- 
With Best Regards,
Andy Shevchenko



