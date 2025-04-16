Return-Path: <netdev+bounces-183409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37446A909A9
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272A01888A83
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3513217651;
	Wed, 16 Apr 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FKV154VC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8422215F58;
	Wed, 16 Apr 2025 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823486; cv=none; b=e2sNykYsv+ukjkdAbzHyZaTCaVodg8J51cuoNr8bNE856HE2eQTW18fz07gY+3ovIn6in3Ly6OMfN7eC1saQwbbleTd0tu6NEJfc91ACz3YETe2dueMiDDqrDWLJbmXMc0mpUpIBU0nNRkmbd9MdWDGhm/2SEnnln3PUKn3gDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823486; c=relaxed/simple;
	bh=skWqHxqYGGmOuvoixGIuo+FphnkgtdJftOmi9b4Z+4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+kkIaWqucbCUNzB9s6DWx1MUC7eFg+jXfm10kQooJ1S1Tdi/yZVNV51loDzuEatH07kZZcy6I/nd6mF6rllaFgYnd7LwA65NqM6c8pqQqVz7vL+5CNKJzh8YPJZ6hilw89g5yhSiuM/Zc3yMng607o177KQnLjDXMWFqIjbGdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FKV154VC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PwH0xQ4TGHfYspbMLh4NhtU8AvejjRlDTyqMnMx+8PA=; b=FKV154VCzY5M6jCgFvLpavuq5M
	ptyRaHLtLQ6QPAP3fVgzkmxeuejMrccAq+aNcewvAK73Xr/jarzm3G/L6gTC8VO/iV0XseXlJfMe9
	VJt58BSvwSMKuWWw55ps1PZmH2tcyNXld0OwxMJw4DhyQs1xy7vqFSsW0crGYeP4Shh4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u56I1-009g7N-O3; Wed, 16 Apr 2025 19:11:09 +0200
Date: Wed, 16 Apr 2025 19:11:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 net-next 3/8] mfd: Add Microchip ZL3073x support
Message-ID: <8fc9856a-f2be-4e14-ac15-d2d42efa9d5d@lunn.ch>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416162144.670760-4-ivecera@redhat.com>

> +++ b/include/linux/mfd/zl3073x_regs.h
> @@ -0,0 +1,105 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __LINUX_MFD_ZL3073X_REGS_H
> +#define __LINUX_MFD_ZL3073X_REGS_H
> +
> +#include <asm/byteorder.h>
> +#include <linux/lockdep.h>

lockdep?

> +#include <linux/mfd/zl3073x.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +
> +/* Registers are mapped at offset 0x100 */
> +#define ZL_RANGE_OFF	       0x100
> +#define ZL_PAGE_SIZE	       0x80
> +#define ZL_REG_ADDR(_pg, _off) (ZL_RANGE_OFF + (_pg) * ZL_PAGE_SIZE + (_off))
> +
> +/**************************
> + * Register Page 0, General
> + **************************/
> +
> +/*
> + * Register 'id'
> + * Page: 0, Offset: 0x01, Size: 16 bits
> + */
> +#define ZL_REG_ID ZL_REG_ADDR(0, 0x01)
> +
> +static inline __maybe_unused int
> +zl3073x_read_id(struct zl3073x_dev *zldev, u16 *value)
> +{
> +	__be16 temp;
> +	int rc;
> +
> +	rc = regmap_bulk_read(zldev->regmap, ZL_REG_ID, &temp, sizeof(temp));
> +	if (rc)
> +		return rc;
> +
> +	*value = be16_to_cpu(temp);
> +	return rc;
> +}

It seems odd these are inline functions in a header file.

> +
> +/*
> + * Register 'revision'
> + * Page: 0, Offset: 0x03, Size: 16 bits
> + */
> +#define ZL_REG_REVISION ZL_REG_ADDR(0, 0x03)
> +
> +static inline __maybe_unused int
> +zl3073x_read_revision(struct zl3073x_dev *zldev, u16 *value)
> +{
> +	__be16 temp;
> +	int rc;
> +
> +	rc = regmap_bulk_read(zldev->regmap, ZL_REG_REVISION, &temp,
> +			      sizeof(temp));
> +	if (rc)
> +		return rc;
> +
> +	*value = be16_to_cpu(temp);
> +	return rc;
> +}
> +
> +/*
> + * Register 'fw_ver'
> + * Page: 0, Offset: 0x05, Size: 16 bits
> + */
> +#define ZL_REG_FW_VER ZL_REG_ADDR(0, 0x05)
> +
> +static inline __maybe_unused int
> +zl3073x_read_fw_ver(struct zl3073x_dev *zldev, u16 *value)
> +{
> +	__be16 temp;
> +	int rc;
> +
> +	rc = regmap_bulk_read(zldev->regmap, ZL_REG_FW_VER, &temp,
> +			      sizeof(temp));
> +	if (rc)
> +		return rc;
> +
> +	*value = be16_to_cpu(temp);
> +	return rc;
> +}

Seems like it would make sense to add a zl3073x_read_b16() helper.
Then all these functions become one liners.

	Andrew

