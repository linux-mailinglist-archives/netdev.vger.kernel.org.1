Return-Path: <netdev+bounces-210914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51612B15706
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 03:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807BE548007
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 01:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4452D22318;
	Wed, 30 Jul 2025 01:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoyrOd7g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6722E36E0
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 01:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753839931; cv=none; b=VPATbsQPGnhjJATb1wjhxZkka2zNgpkPg9ubhAx88aTsSZRH+6ZnGxo/hq7zp7XiIbKgF6rqadli7s59Zw2X5uv2DBh71T3NOPi+u2JHuUYnMPH9Gp1Z4oURd3r3mdWvoUzs0rOIW+8mHc9x9FGD1AfZjZWMCP6yB8AZWnXcoAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753839931; c=relaxed/simple;
	bh=zKh6Ix9H+F184fAKB9LOEXmgZa9PaVCbMzYZi0p0yqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Id+L7MseIbxjur4B6Qrm+kRM1hiE26oXqGsWWmwVOI0tg/fLQcgkYiisLtd17LmGP1zbR4fjbBhEG28z/LLoHkykAK9WcL6sjidJjk84jdShOoLuY4e3UvwOyTGjl3hXpCxiyWZoYF2dE4wA5APFaWVk/7/8sTTsL2neThz3t5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoyrOd7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52730C4CEF4;
	Wed, 30 Jul 2025 01:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753839930;
	bh=zKh6Ix9H+F184fAKB9LOEXmgZa9PaVCbMzYZi0p0yqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MoyrOd7gBgpSeukLaTrwUdf2chz3B+865rPM1N3v5fh54S87swhX4WmqU7U87i0U+
	 fXCQpGwf+n04TPbYNs9nInzuVh3ZNfry1jgPAT0J9KNBieQ1uoyH7Njya1bI6aRVTP
	 pQfnrjB3jhO6wxr/a+vmEqjH505UR9KWTkSrVA1em+9Vbyvl0UEbakzi3LnPmPrmhS
	 z5C6GGXedG8YPcpESCOpSSGTsYdxgx2FO0aJb56gv10AnHdK4NxJQBrVdQv80UFjTe
	 9CX33AehdYuwriubfW8avww/gisnxI69ucGjZMF6D4w6gvQmzFs7qPiAP0SSfmH537
	 Q443k+QCkQQnw==
Date: Tue, 29 Jul 2025 18:45:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, <intel-wired-lan@lists.osuosl.org>, Donald
 Hunter <donald.hunter@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
Message-ID: <20250729184529.149be2c3@kernel.org>
In-Reply-To: <20250729102354.771859-1-vadfed@meta.com>
References: <20250729102354.771859-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Jul 2025 03:23:54 -0700 Vadim Fedorenko wrote:
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 1063d5d32fea2..3781ced722fee 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -1239,6 +1239,30 @@ attribute-sets:
>          name: corr-bits
>          type: binary
>          sub-type: u64
> +      -
> +        name: hist
> +        type: nest
> +        multi-attr: True
> +        nested-attributes: fec-hist
> +      -
> +        name: fec-hist-bin-low
> +        type: s32
> +      -
> +        name: fec-hist-bin-high
> +        type: s32
> +      -
> +        name: fec-hist-bin-val
> +        type: u64
> +  -
> +    name: fec-hist
> +    subset-of: fec-stat

no need to make this a subset, better to make it its own attr set

> +    attributes:
> +      -
> +        name: fec-hist-bin-low
> +      -
> +        name: fec-hist-bin-high
> +      -
> +        name: fec-hist-bin-val
>    -
>      name: fec
>      attr-cnt-name: __ethtool-a-fec-cnt

> +static const struct ethtool_fec_hist_range netdevsim_fec_ranges[] = {
> +	{  0,  0},
> +	{  1,  3},
> +	{  4,  7},
> +	{ -1, -1}
> +};

Let's add a define for the terminating element?

> +/**
> + * struct ethtool_fec_hist_range - byte range for FEC bins histogram statistics

byte range? thought these are bit errors..

> + * sentinel value of { -1, -1 } is used as marker for end of bins array
> + * @low: low bound of the bin (inclusive)
> + * @high: high bound of the bin (inclusive)
> + */

> +		len += nla_total_size_64bit(sizeof(u64) * ETHTOOL_FEC_HIST_MAX);

I don't think it's right, each attr is its own nla_total_size().
Add a nla_total_size(8) to the calculation below

> +		/* add FEC bins information */
> +		len += (nla_total_size(0) +  /* _A_FEC_HIST */
> +			nla_total_size(4) +  /* _A_FEC_HIST_BIN_LOW */
> +			nla_total_size(4)) * /* _A_FEC_HIST_BIN_HI */
> +			ETHTOOL_FEC_HIST_MAX;

