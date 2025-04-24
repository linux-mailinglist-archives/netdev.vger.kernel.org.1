Return-Path: <netdev+bounces-185617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03384A9B27C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233A21B87107
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA10C27F73A;
	Thu, 24 Apr 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaVQycdF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D30223DFF;
	Thu, 24 Apr 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508880; cv=none; b=saaaJ5Ju8XUibaXhd5zqzPr2aFjJnNaw7pkm6zHf+BDSKeQOOpl4ChU7FbZOLYvYIC09pnl8ODGzpneU+sQpqs/BHtWZQMmf6ey5l8xBM1DF4HKTLMzpQ+ZLE0OwHWIowl6KIqieigzI8+OXwWQV+0OlR2v/w+N1i2oI5te6iDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508880; c=relaxed/simple;
	bh=bxClbLQLTNjuI9XodLLxLGe6sAL6f77wxXbHj6qSftg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hoz0myVcp5q05RfzYHTl1Hfecl5i+705rKsu4TsUNv+RmWBNry6eINuOYtcs+RkxGvDXVdLfnYADi9Knt1nXOluYAFI0KLMY42DaF8Yn5Gp+lJR1k+klZ830i1hjTuTiDKD8l4CFDDjFGe7Khtil8Ryi4HaRdZdGfkae5qccnOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaVQycdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45CFC4CEE3;
	Thu, 24 Apr 2025 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745508880;
	bh=bxClbLQLTNjuI9XodLLxLGe6sAL6f77wxXbHj6qSftg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kaVQycdFEh57ptKQMkU3phV47PdSHrqw0ImT/A/ChbtZXARReZjSQcAo0qAg9ou/4
	 8ytM9dvOcEt/+ZXzgqtGyWM1G+lAn+A2bnYWcAOnz98SDiCWZpj6kpUJTjv7SxdOu+
	 JJ33e60tOTDzmKdxSksrmc6lm2BEOmqrqX8NfAqQieXqN5sDmAcbrjpT7OsnHg+Vqx
	 lMx5PukWerWoacnvxQ01VK75QM3Pc46vCRuKUvwN15DcjnRqbja8OfeYXUWQNNoyw6
	 I5DHIajSgutzhGjRzJoJcwZ7gpdn5JkSB6I54A0t5cZJkgniFPohYoi6rDYw71NDcU
	 uiU+3EV9YqqkA==
Date: Thu, 24 Apr 2025 16:34:34 +0100
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
Message-ID: <20250424153434.GF8734@google.com>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-9-ivecera@redhat.com>
 <20250417162044.GG372032@google.com>
 <335003db-49e5-4501-94e5-4e9c6994be7d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <335003db-49e5-4501-94e5-4e9c6994be7d@redhat.com>

On Thu, 17 Apr 2025, Ivan Vecera wrote:

> 
> 
> On 17. 04. 25 6:20 odp., Lee Jones wrote:
> > On Wed, 16 Apr 2025, Ivan Vecera wrote:
> > 
> > > Register DPLL sub-devices to expose this functionality provided
> > > by ZL3073x chip family. Each sub-device represents one of the provided
> > > DPLL channels.
> > > 
> > > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > > ---
> > >   drivers/mfd/zl3073x-core.c | 15 +++++++++++++++
> > >   1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
> > > index 0bd31591245a2..fda77724a8452 100644
> > > --- a/drivers/mfd/zl3073x-core.c
> > > +++ b/drivers/mfd/zl3073x-core.c
> > > @@ -6,6 +6,7 @@
> > >   #include <linux/device.h>
> > >   #include <linux/export.h>
> > >   #include <linux/math64.h>
> > > +#include <linux/mfd/core.h>
> > >   #include <linux/mfd/zl3073x.h>
> > >   #include <linux/mfd/zl3073x_regs.h>
> > >   #include <linux/module.h>
> > > @@ -774,6 +775,20 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
> > >   	if (rc)
> > >   		return rc;
> > > +	/* Add DPLL sub-device cell for each DPLL channel */
> > > +	for (i = 0; i < chip_info->num_channels; i++) {
> > > +		struct mfd_cell dpll_dev = MFD_CELL_BASIC("zl3073x-dpll", NULL,
> > > +							  NULL, 0, i);
> > 
> > Create a static one of these with the maximum amount of channels.
> 
> Like this?
> 
> static const struct mfd_cell dpll_cells[] = {
> 	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 1),
> 	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 2),
> 	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 3),
> 	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 4),
> 	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 5),
> };
> 
> rc = devm_mfd_add_devices(zldev->dev, PLATFORM_DEVID_AUTO, dpll_cells,
>                           chip_info->num_channels, NULL, 0, NULL);

Yes, looks better, thank you.

-- 
Lee Jones [李琼斯]

