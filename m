Return-Path: <netdev+bounces-183829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E20FA92290
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6741763E4
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E828D254867;
	Thu, 17 Apr 2025 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FB18s3Z3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B552236EF;
	Thu, 17 Apr 2025 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906850; cv=none; b=GkS69UpgHVPZjQvz+k+w+FVze0oEzJsps1or9x8Oco4z1cbTkLV/29LzPaaGH3mA5pS0umaXk2JP70HUUjWfLx53LNnGTTZ5nyIjfpfWtWOn2qgJgFwOwWfzPi0MNa6oV7mx3Do/iYXJpYYmJYf9C9PZBycjAW8HSvbefXARX3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906850; c=relaxed/simple;
	bh=lE3km04V0huNl5/idlnm7EDpwXke3d0J3Xk+VcvgftQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YX8FnEH/09KKkP2vk9WOe+pd5N4fPtlgCOuvtQwVHxYTmLwPa5st9dx2t4pxFgzg3aRpSxCKw5ePEkJjKrgdUa9aO7fRuNT0B8hFHAtCcetOFPafCOuuHserurM11jajKmBtDnebCW/am5nkqNhdn3lCoyZfhqWVpXFL38i+d38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FB18s3Z3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214E6C4CEE4;
	Thu, 17 Apr 2025 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744906850;
	bh=lE3km04V0huNl5/idlnm7EDpwXke3d0J3Xk+VcvgftQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FB18s3Z31fz8pl7IzUQvYSyIoEd5m6RV3Kp7+tkglkF6sN44yobYBd6H06mJHwFSa
	 pMdq7VUEGBo36ErDYV5KFCkuLQBbOVDOupIbMe32FM8F5eKYuaEdzaCvKA1AMK42o5
	 SEFW9wY4iJTVsa5RBXdMjsWToxlUMvFgu5eN9sfjGEMoLDqYFSv1OKFkVcBr2yVnXF
	 xhRFk9zF7eb3MViUHIkqy5Vuhyk/H3f3LaE786JtTWIwIOlwwjMLUgdHSyP90o/rjK
	 kgA7tzbKdETi4BKZXxvBAQYFVssi88iSRsMACz54o+T1erOVdvXvQ6Z6m6s+hdtM9n
	 M+TxVG/ujo5Yg==
Date: Thu, 17 Apr 2025 17:20:44 +0100
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
Message-ID: <20250417162044.GG372032@google.com>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-9-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416162144.670760-9-ivecera@redhat.com>

On Wed, 16 Apr 2025, Ivan Vecera wrote:

> Register DPLL sub-devices to expose this functionality provided
> by ZL3073x chip family. Each sub-device represents one of the provided
> DPLL channels.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/mfd/zl3073x-core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
> index 0bd31591245a2..fda77724a8452 100644
> --- a/drivers/mfd/zl3073x-core.c
> +++ b/drivers/mfd/zl3073x-core.c
> @@ -6,6 +6,7 @@
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/math64.h>
> +#include <linux/mfd/core.h>
>  #include <linux/mfd/zl3073x.h>
>  #include <linux/mfd/zl3073x_regs.h>
>  #include <linux/module.h>
> @@ -774,6 +775,20 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
>  	if (rc)
>  		return rc;
>  
> +	/* Add DPLL sub-device cell for each DPLL channel */
> +	for (i = 0; i < chip_info->num_channels; i++) {
> +		struct mfd_cell dpll_dev = MFD_CELL_BASIC("zl3073x-dpll", NULL,
> +							  NULL, 0, i);

Create a static one of these with the maximum amount of channels.

> +
> +		rc = devm_mfd_add_devices(zldev->dev, PLATFORM_DEVID_AUTO,
> +					  &dpll_dev, 1, NULL, 0, NULL);

Then pass chip_info->num_channels as the 4th argument.

> +		if (rc) {
> +			dev_err_probe(zldev->dev, rc,
> +				      "Failed to add DPLL sub-device\n");
> +			return rc;
> +		}
> +	}
> +
>  	/* Register the device as devlink device */
>  	devlink = priv_to_devlink(zldev);
>  	devlink_register(devlink);
> -- 
> 2.48.1
> 

-- 
Lee Jones [李琼斯]

