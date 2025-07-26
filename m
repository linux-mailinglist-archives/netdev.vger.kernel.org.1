Return-Path: <netdev+bounces-210328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 367FFB12C33
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 22:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D214017EA5A
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 20:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DE8217F36;
	Sat, 26 Jul 2025 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjzuBg2E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31247DA9C;
	Sat, 26 Jul 2025 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753562036; cv=none; b=r86GEHA7b3XYkNR85JavVb9dc/eaVi9H5+jDCSVH19ZkDsN9M0xgXZQTHz+FeUf7Dv3xrsuZtKh1VvZdwYmBDnpSOAjko1h6/sxuFQt8j2c5Prj/zbASu68pV5O1q2zd+pVD+ZEix9mj2+mEFzJLyQs32EsQcNGBv4GiS9WU9r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753562036; c=relaxed/simple;
	bh=x6bDSChl3CH9hrcSrTX/awDg0AMaJqU9jJXWKacrETo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHQM8rzRTKvIpgvbjYCyLaG1l9N+NLyOuUxHH47eyUc+Pf00sEX9rKXGvAjLWQsxAmTEYW3AG7WMHy/1SYLrFiAU5Z4rMzI/ZL+iwsoD/yve6VgdcGEBuZNNhi2X+Y0/Tgc3iON7YBSTEpQf+qgoVE7jin7BU6ZybsetgjJXClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjzuBg2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA57C4CEED;
	Sat, 26 Jul 2025 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753562036;
	bh=x6bDSChl3CH9hrcSrTX/awDg0AMaJqU9jJXWKacrETo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tjzuBg2ExuJ8y8G0XxFBW9EpA34a7+hWV6Zs6qZSd0nWrDZvCITodzmB14jF9WZuz
	 4zusLA06zbFGIAFi5xbTlosTRYoYb1/gbaoDAYaC1gnyUDbHL+vPrJaAS95pWe3VAL
	 UAv57NP1o3DKPmkVNe0Bw71JqWXu33aQTuBpncb1Me1hAnz3uyiemoVn6ClTt+j09g
	 IV6Micr5rai8b1IPnVR78pbxlnYPLs30vdObVdcjo9zrrZFcoiuSp5/jOLpF7nb04j
	 vpdyqTSUNG8YBIWaDpIa9Ng8fDMcaw8FppsjzmI8jxRX+7UwCJbsPVDIXCFrmzyc4D
	 b+2SYEl/4/M1A==
Date: Sat, 26 Jul 2025 21:33:51 +0100
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next 3/5] dpll: zl3073x: Add firmware loading
 functionality
Message-ID: <20250726203351.GP1367887@horms.kernel.org>
References: <20250725154136.1008132-1-ivecera@redhat.com>
 <20250725154136.1008132-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725154136.1008132-4-ivecera@redhat.com>

On Fri, Jul 25, 2025 at 05:41:34PM +0200, Ivan Vecera wrote:
> Add functionality for loading firmware files provided by the vendor
> to be flashed into the device's internal flash memory. The firmware
> consists of several components, such as the firmware executable itself,
> chip-specific customizations, and configuration files.
> 
> The firmware file contains at least a flash utility, which is executed
> on the device side, and one or more flashable components. Each component
> has its own specific properties, such as the address where it should be
> loaded during flashing, one or more destination flash pages, and
> the flashing method that should be used.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Hi Ivan,

Some minor feedback from my side.

...

> diff --git a/drivers/dpll/zl3073x/fw.c b/drivers/dpll/zl3073x/fw.c

...

> +/* Santity check */

Sanity

> +static_assert(ARRAY_SIZE(component_info) == ZL_FW_NUM_COMPONENTS);

...

> +int zl3073x_fw_flash(struct zl3073x_dev *zldev, struct zl3073x_fw *zlfw,
> +		     struct netlink_ext_ack *extack)
> +{
> +	int i, rc;
> +
> +	for (i = 0; i < ZL_FW_NUM_COMPONENTS; i++) {
> +		if (!zlfw->component[i])
> +			continue; /* Component is not present */
> +
> +		rc = zl3073x_fw_component_flash(zldev, zlfw->component[i],
> +						extack);
> +		if (rc)
> +			break;
> +	}

Perhaps it cannot happen in practice.
But Smatch warns that rc may be used uninitialised below.
And that does seem theoretically possible if all
iterations of the loop above hit the "continue" path.

> +
> +	return rc;
> +}

...

