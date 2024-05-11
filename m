Return-Path: <netdev+bounces-95715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65AF8C329A
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 18:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A7C1C20C21
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 16:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5007718E1D;
	Sat, 11 May 2024 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dij6wF4+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C67F
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715446582; cv=none; b=lTnVm/etylpPLnjAslh51YWcpKf1eMuu7pa0n7PylJUg0feswLnjV8Ps7UZ08GP8nT7/20n1hgIgpq8Hyz1YBu/RzxbxS8x+V3pzF3phRXlVAgELZmqKXJMUgcs9O2f+XJ4Q3eNQ0MuoQAEChihJjBS4wAnTi1CsJ3FmtKdGYYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715446582; c=relaxed/simple;
	bh=yehxKsTcJixa47K5qCB6QJ5OG1nz+0o9cOwyFMRSRiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+I8YBAhK1BTgsWHmYvaw+5ef6dMsyCuoiWD2WgvsEDtNHc9rVH+ASYRuIfhwQTvgp8W4mfw1t9LNMj0oM1p8NSgaYSqz5vjOflLrOyEJl7wURnzkzn//GA8RviCVqlBoYX0cO3T4xUhIP5F1Bdlg2tenXYDrCsY10LUnxEFmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dij6wF4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E59C2BBFC;
	Sat, 11 May 2024 16:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715446581;
	bh=yehxKsTcJixa47K5qCB6QJ5OG1nz+0o9cOwyFMRSRiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dij6wF4+C7Tt7VycjvdgcMOGqii8D+8fC6sHcpU4FWAvD47lxMYwvBEHZCoCmvXQU
	 KzDcgdFPUtPjl/aiYxA1Zy/tKEZ7anjmn/2wbIrN9nXY+feXm9pJBT+hvmUWl9YY7a
	 aodsqRgmS9OH6goPG6oGRQaKbYGTe570uV2S3KbMi+K3gQD/vjTzZ/fyKpw0qvdsNN
	 tjW0X2JuDbaO6bkZa2XC4GbhkC1AC7Dho5YXjRu0nlat4b7x4vYTZt8oGq8rdtRliS
	 VaeBPX+SdIELf8ApxLGwLnTjrR0nw+6dfeEwiO5zsGB8ivrLhF/+GB977NRpA3Bhil
	 oo/ZzZOdY1QoQ==
Date: Sat, 11 May 2024 17:56:16 +0100
From: Simon Horman <horms@kernel.org>
To: Anil Samal <anil.samal@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	leszek.pepiak@intel.com, przemyslaw.kitszel@intel.com,
	lukasz.czapnik@intel.com,
	Anthony L Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-next v2 3/3] ice: Implement driver functionality to
 dump serdes  equalizer  values
Message-ID: <20240511165616.GO2347895@kernel.org>
References: <20240510065243.906877-1-anil.samal@intel.com>
 <20240510065243.906877-4-anil.samal@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510065243.906877-4-anil.samal@intel.com>

[ Fixed CC list by dropping '--cc=' from start of addresses. ]

On Thu, May 09, 2024 at 11:50:42PM -0700, Anil Samal wrote:
> To debug link issues in the field, serdes Tx/Rx equalizer values
> help to determine the health of serdes lane.
> 
> Extend 'ethtool -d' option to dump serdes Tx/Rx equalizer.
> The following list of equalizer param is supported
>     a. rx_equalization_pre2
>     b. rx_equalization_pre1
>     c. rx_equalization_post1
>     d. rx_equalization_bflf
>     e. rx_equalization_bfhf
>     f. rx_equalization_drate
>     g. tx_equalization_pre1
>     h. tx_equalization_pre3
>     i. tx_equalization_atten
>     j. tx_equalization_post1
>     k. tx_equalization_pre2
> 
> Reviewed-by: Anthony L Nguyen <anthony.l.nguyen@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Anil Samal <anil.samal@intel.com>

The nit below notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c

...

> +/**
> + * ice_get_extended_regs - returns FEC correctable, uncorrectable stats per
> + *                         pcsquad, pcsport
> + * @netdev: pointer to net device structure
> + * @p: output buffer to fill requested register dump
> + *
> + * Return: 0 on success, negative on failure.
> + */
> +static int ice_get_extended_regs(struct net_device *netdev, void *p)
> +{
> +	struct ice_regdump_to_ethtool *ice_prv_regs_buf;
> +	struct ice_netdev_priv *np = netdev_priv(netdev);

nit: Please arrange local variables in reverse xmas tree order -
     longest line to shortest.

     It's probably not necessary to repost just because of this.

     This tool can be of use here: https://github.com/ecree-solarflare/xmastree

> +	struct ice_port_topology port_topology = {};
> +	struct ice_port_info *pi;
> +	struct ice_pf *pf;
> +	struct ice_hw *hw;
> +	unsigned int i;
> +	int err;

...

