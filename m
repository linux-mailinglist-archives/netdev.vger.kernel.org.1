Return-Path: <netdev+bounces-160128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D538A1862F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 21:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47829188AD72
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 20:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45751F75AB;
	Tue, 21 Jan 2025 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFtynvTk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E301B808;
	Tue, 21 Jan 2025 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737491906; cv=none; b=TCRs3hnZM8/vemHM+yo47T7A1QZ8R1V9gXrz/EbwfrWCwK3IplPL7ClEqVMB5pzmBGepRGsyUJKhapLGTw41IBvvaFKJ7pnYV1NK0n+ym/B55rLUazatrDeLSkycexaGfCYHpmoq7UzEYJRVQX4Ruzs4pVs4FJCWUqnGUSQRgJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737491906; c=relaxed/simple;
	bh=e+dFX819daWsRhigdFpl01k4/NZV1QYsLroSQ01P+R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWBNQ6N+YvkNKnGUsMZXFWpB26Y0VnGyy0liRQb0g52QaJSmdBE04oUxQNKgLcYzLMRzImjp21XTpZrrjw6/4+axtfAIQlJuKIp/3PaPjlX0sCMgpdQypnnrAs79Ph/LAss2l5cu7xmsLFhgjMFTnC+ZEKZf14QcNTDq2c0dEPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFtynvTk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737491905; x=1769027905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=e+dFX819daWsRhigdFpl01k4/NZV1QYsLroSQ01P+R8=;
  b=oFtynvTkxDfGvv3wox9R+GayWz1TwPF6z0f5EiAdFFsjNaTD5gowk6g2
   jH18U67OGqzYWD6+HMw5GVFCnV91lM2U1utQGG9NYfoC/EHv8VlC1yLx8
   3VasF16aL2xpRdDa7P7HylCoUhulNSwuIYT0aFKheC+6iFvhc3hFZcZFx
   rTJa1CmyvdXL85uP6wmQoaehJ7/9KpfERapxv1AqcjDQUEEx913s1kzC0
   TXKWfLZ66Ob4uQmNTzRXa9MdBxKv+CCguWFjPlYJVLpxrZSZweY1x5NM4
   weCAqimrBaDim5ZeTEZtQ28bmch512zyQArnAt2mJbr5npOgIGoM5pwnX
   g==;
X-CSE-ConnectionGUID: FebSb3iuQDevhRmsdQn6iA==
X-CSE-MsgGUID: u6ENrYE4QK29jxFcdnWgaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37801588"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="37801588"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 12:38:24 -0800
X-CSE-ConnectionGUID: KgMm+4BHRhiCjFtZdFzDoQ==
X-CSE-MsgGUID: WOW83UjlRWilx0amOr1Xrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="107459209"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.76])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 12:38:23 -0800
Date: Tue, 21 Jan 2025 12:38:21 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
	linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	bhelgaas@google.com
Subject: Re: [PATCH v9 10/27] resource: harden resource_contains
Message-ID: <Z5AFvRl87OFtfF8-@aschofie-mobl2.lan>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-11-alejandro.lucero-palau@amd.com>
 <678b0c0ca40ca_20fa29484@dwillia2-xfh.jf.intel.com.notmuch>
 <fe48e2e9-5a13-78fe-d8f6-6c3faeecebcc@amd.com>
 <09d6b529-57f3-290f-7e92-0291cdd461cc@amd.com>
 <a97f50df-5b0f-6ab5-80c6-531d4654c0b3@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a97f50df-5b0f-6ab5-80c6-531d4654c0b3@amd.com>

On Mon, Jan 20, 2025 at 04:26:42PM +0000, Alejandro Lucero Palau wrote:
> 
> On 1/20/25 16:16, Alejandro Lucero Palau wrote:
> > Adding Bjorn to the thread. Not sure if he just gets the email being in
> > an Acked-by line.
> > 
> > 
> > On 1/20/25 16:10, Alejandro Lucero Palau wrote:
> > > 
> > > On 1/18/25 02:03, Dan Williams wrote:
> > > > alejandro.lucero-palau@ wrote:
> > > > > From: Alejandro Lucero <alucerop@amd.com>
> > > > > 
> > > > > While resource_contains checks for IORESOURCE_UNSET flag for the
> > > > > resources given, if r1 was initialized with 0 size, the function
> > > > > returns a false positive. This is so because resource start and
> > > > > end fields are unsigned with end initialised to size - 1 by current
> > > > > resource macros.
> > > > > 
> > > > > Make the function to check for the resource size for both resources
> > > > > since r2 with size 0 should not be considered as valid for
> > > > > the function
> > > > > purpose.
> > > > > 
> > > > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > > > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> > > > > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > > > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > ---
> > > > >   include/linux/ioport.h | 2 ++
> > > > >   1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > > > > index 5385349f0b8a..7ba31a222536 100644
> > > > > --- a/include/linux/ioport.h
> > > > > +++ b/include/linux/ioport.h
> > > > > @@ -296,6 +296,8 @@ static inline unsigned long
> > > > > resource_ext_type(const struct resource *res)
> > > > >   /* True iff r1 completely contains r2 */
> > > > >   static inline bool resource_contains(const struct resource
> > > > > *r1, const struct resource *r2)
> > > > >   {
> > > > > +    if (!resource_size(r1) || !resource_size(r2))
> > > > > +        return false;
> > > > I just worry that some code paths expect the opposite, that it is ok to
> > > > pass zero size resources and get a true result.
> > > 
> > > 
> > > That is an interesting point, I would say close to philosophic
> > > arguments. I guess you mean the zero size resource being the one
> > > that is contained inside the non-zero one, because the other option
> > > is making my vision blurry. In fact, even that one makes me feel
> > > trapped in a window-less room, in summer, with a bunch of
> > > economists, I mean philosophers, and my phone without signal for
> > > emergency calls.
> > > 
> 
> I forgot to make my strongest point :-). If someone assumes it is or it
> should be true a zero-size resource is contained inside a non zero-size
> resource, we do not need to call a function since it is always true
> regardless of the non zero-size resource ... that headache is starting again
> ...
> 
> 

Maybe start using IORESOURCE_UNSET flag -

Looking back on when we first discussed this -
https://lore.kernel.org/linux-cxl/Zz-fVWhTOFG4Nek-@aschofie-mobl2.lan/
where the thought was that checking for zero was helpful to all.

If this path starts using the IORESOURCE_UNSET flag can it accomplish
the same thing?  No need to touch resource_contains().

Is that an option?

-- Alison



> > > 
> > > But maybe it is just  my lack of understanding and there exists a
> > > good reason for this possibility.
> > > 
> > > 
> > > Bjorn, I guess the ball is in your side ...
> > > 
> > > > Did you audit existing callers?
>

