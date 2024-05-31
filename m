Return-Path: <netdev+bounces-99736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E14058D6283
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 648CCB262E5
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9285158D97;
	Fri, 31 May 2024 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWktP+cA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ADA158D95
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161103; cv=none; b=Z60ixewKqzLu250ttsd2pU9XOcm5c1QGhgNEu+/tVXO4DFWaHd4UOZzoXgMkE7DPnzTWwyM4z3C9l5TA9WfD4D1nAqecAoTG5t7CsTsyWV6w0vyfxsM6BMxJT9/a0j0nvZ8i/LAS/YePdurMGb6hpLbe9TqXtrHnfh3p+A1QeRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161103; c=relaxed/simple;
	bh=+RxMHhYO/X4eUxC++M6brEN8NylFcxLydIy0tUrLLHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRh/+OT5cDhlztABfKtBFJ8VdZlHbRJvJbsE3tiebxFTU+OSxA8kwhEj6sVieLfY+XiOaciBtpQy/vzsVxEZfRkHwNx2RVN/AWzQzuT2sTK4IFUncKLPSuqgzS4exUVIAoz/3h87CPbPeur+25hMeREvLbcwBcxEF1pgOzuJgxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWktP+cA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2E3C116B1;
	Fri, 31 May 2024 13:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717161103;
	bh=+RxMHhYO/X4eUxC++M6brEN8NylFcxLydIy0tUrLLHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWktP+cA9ArMwKmdhpAPp+xzW+J6qnw7HK6IaT5DPMGQKTdhtQ9svUid06xCLX49R
	 UPHcQa2PCDTeoaf9c1E1OmOwlxroOQfkMZPqQ1ezCoCO9wXax8Z3LYaX4roHdGJdF0
	 RdWeCfuHNZNAJBKwQDa1ictEr6nGRmQltAf/zJAS5m0/6ZOaiLlnaSNMZJvT8BliEY
	 hjG69xo3g+g6NRcxv/NIxSPyfaGVnpW7wD4JqJQ7E5drnBcv2fa/jiZa1NK3N0cqXL
	 74eVIE/5G11pM2lfsZkHq3MOdbTaHEjd38KTjMCgppa0RFAbO8hYBs+KH9+zyFeIxf
	 Z1x4VfKPG1N4w==
Date: Fri, 31 May 2024 14:11:39 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, anthony.l.nguyen@intel.com,
	Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH iwl-next v2 01/13] ice: add parser create and destroy
 skeleton
Message-ID: <20240531131139.GD123401@kernel.org>
References: <20240527185810.3077299-1-ahmed.zaki@intel.com>
 <20240527185810.3077299-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527185810.3077299-2-ahmed.zaki@intel.com>

On Mon, May 27, 2024 at 12:57:58PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Add new parser module which can parse a packet in binary and generate
> information like ptype, protocol/offset pairs and flags which can be later
> used to feed the FXP profile creation directly.
> 
> Add skeleton of the create and destroy APIs:
> ice_parser_create()
> ice_parser_destroy()
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
> new file mode 100644
> index 000000000000..b7865b6a0a9b
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2024 Intel Corporation */
> +
> +#include "ice_common.h"
> +
> +/**
> + * ice_parser_create - create a parser instance
> + * @hw: pointer to the hardware structure
> + *
> + * Return a pointer to the allocated parser instance

Hi Ahmed,

A minor nit from my side.

I think that in order to keep ./scripts/kernel-doc -none -Wall happy
this should be:

 * Return: pointer to the allocated parser instance

And perhaps it would be best to mention the error case too

 * Return: pointer to the allocated parser instance, or an error pointer


> + */
> +struct ice_parser *ice_parser_create(struct ice_hw *hw)
> +{
> +	struct ice_parser *p;
> +
> +	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	if (!p)
> +		return ERR_PTR(-ENOMEM);
> +
> +	p->hw = hw;
> +	return p;
> +}

...

