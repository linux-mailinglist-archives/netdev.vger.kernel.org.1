Return-Path: <netdev+bounces-185618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60AEA9B287
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97533BBFF1
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E2F1D5CC4;
	Thu, 24 Apr 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKgOv7ek"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81F1187FE4;
	Thu, 24 Apr 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508971; cv=none; b=OYFqQcSD3jx7ScRBNi2x7PRYXc7uoiF0to1xSOSEDYk9s/2BdNv1t87eZpSCB/TPsi720o9jIUlsYkih8H72aPeUuEjn4YSaSa1tT5r+43+XKrCojb1w/vD0RhgOtnr2OtgQPYCVm/ohV7JFqOH610fmmoqdGftE5fqyGHEDLWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508971; c=relaxed/simple;
	bh=mdGLiwc9GSUiQbyFTA/wJHANHSo9NTlFVbMloSFkBRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnHAutT+V40DFlsCih5Jk4TDoL4fmR0PAFoCKUwBwl92yi7uqh4zSWrs60OFyLnlh0DIf5i4fTMnzRWGkdmYTMi4r08CLl8Bvogotmh+JWQg9PjzoLl+4kL8nSb8SvCApDTojUSJxAdwOpE3wBQcQQz3xVjYGUJqFKf/1I1YgcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKgOv7ek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3FCC4CEE3;
	Thu, 24 Apr 2025 15:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745508970;
	bh=mdGLiwc9GSUiQbyFTA/wJHANHSo9NTlFVbMloSFkBRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKgOv7ekM8lvqZ5HcVQUvmHod5gAmStmB/a41M+OxXnrcogNdAQJh1PQ7awvtl798
	 Lz3GED8jXAjCOGIncdq+hxlxcdjMCOpszDvx3xWasY6OBHwQ4cgCFsnQR3S9X1qWCv
	 VjUsE5oYJXJVV8yA5FDGZv9bYqYxcF2Xyxhfir+60UgzGxsigJD1x6x1tm8e23mE89
	 agd1XufLEhQyhh1vdF0/YIIWWASCepGRAykF+Q2ewe9pAscYiRF1EskHJ9h/pfaDXb
	 dfPozjNKMdDVZLwFiOPV+fL9cqGP+St5H4IGucFCXdaGIhC6k/2ZYEcZNSUtlCih7E
	 Yq1LGFjWKeJ8g==
Date: Thu, 24 Apr 2025 16:36:04 +0100
From: Lee Jones <lee@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 net-next 8/8] mfd: zl3073x: Register DPLL sub-device
 during init
Message-ID: <20250424153604.GG8734@google.com>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-9-ivecera@redhat.com>
 <20250417162044.GG372032@google.com>
 <335003db-49e5-4501-94e5-4e9c6994be7d@redhat.com>
 <20250424153434.GF8734@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424153434.GF8734@google.com>

On Thu, 24 Apr 2025, Lee Jones wrote:

> On Thu, 17 Apr 2025, Ivan Vecera wrote:
> 
> > 
> > 
> > On 17. 04. 25 6:20 odp., Lee Jones wrote:
> > > On Wed, 16 Apr 2025, Ivan Vecera wrote:
> > > 
> > > > Register DPLL sub-devices to expose this functionality provided
> > > > by ZL3073x chip family. Each sub-device represents one of the provided
> > > > DPLL channels.
> > > > 
> > > > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > > > ---
> > > >   drivers/mfd/zl3073x-core.c | 15 +++++++++++++++
> > > >   1 file changed, 15 insertions(+)
> > > > 
> > > > diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
> > > > index 0bd31591245a2..fda77724a8452 100644
> > > > --- a/drivers/mfd/zl3073x-core.c
> > > > +++ b/drivers/mfd/zl3073x-core.c
> > > > @@ -6,6 +6,7 @@
> > > >   #include <linux/device.h>
> > > >   #include <linux/export.h>
> > > >   #include <linux/math64.h>
> > > > +#include <linux/mfd/core.h>
> > > >   #include <linux/mfd/zl3073x.h>
> > > >   #include <linux/mfd/zl3073x_regs.h>
> > > >   #include <linux/module.h>
> > > > @@ -774,6 +775,20 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
> > > >   	if (rc)
> > > >   		return rc;
> > > > +	/* Add DPLL sub-device cell for each DPLL channel */
> > > > +	for (i = 0; i < chip_info->num_channels; i++) {
> > > > +		struct mfd_cell dpll_dev = MFD_CELL_BASIC("zl3073x-dpll", NULL,
> > > > +							  NULL, 0, i);
> > > 
> > > Create a static one of these with the maximum amount of channels.
> > 
> > Like this?
> > 
> > static const struct mfd_cell dpll_cells[] = {
> > 	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 1),
> > 	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 2),
> > 	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 3),
> > 	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 4),
> > 	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 5),
> > };
> > 
> > rc = devm_mfd_add_devices(zldev->dev, PLATFORM_DEVID_AUTO, dpll_cells,
> >                           chip_info->num_channels, NULL, 0, NULL);
> 
> Yes, looks better, thank you.

Sorry, just a thought.  Since this is non-standard, please make it easy
on the reader by providing a comment to say that this call will register
a variable number of devices depending on the value of num_channels.

-- 
Lee Jones [李琼斯]

