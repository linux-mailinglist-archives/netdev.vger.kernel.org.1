Return-Path: <netdev+bounces-103557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C1C908A29
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45C9283AA1
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26381946AC;
	Fri, 14 Jun 2024 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jkmv/G7U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92591946A5;
	Fri, 14 Jun 2024 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361452; cv=none; b=gy9QWtPKoKkmr0NbH5XpmygJX/Iz5MCfBodsAJWr4MHdktKVE2FIcTlmaeiGSQ0FuETopgY7+U8QjV5Mv7ZVsAUYWrwdAk3DsU8G19fQPnGvUhW/WwlbvAMvMfLNTwCE0AeJJnMt25KjyRPsYfqVKrmd1klxisBaaJyQBl9lJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361452; c=relaxed/simple;
	bh=+q2RlQAdVgdcD7AQbJOtLwiTAjYWxXhNfVMHcCdt47s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtC0Ug+OOWeCE0zYz/HyrZCK28o04v8p/UHuQdx8sbpXE8p4GcgMlpOwR8WgjU2rs8Iub059SwEBbvAVx5zarKKWmqIJIHW//m6yc7I2icM+887o+mHjycdFfPlZ7rFIZA6abF7EyAwN7K/nwrypUBJ0HInF7Xt9LAacgRxnp+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jkmv/G7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1E9C4AF1C;
	Fri, 14 Jun 2024 10:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718361452;
	bh=+q2RlQAdVgdcD7AQbJOtLwiTAjYWxXhNfVMHcCdt47s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jkmv/G7UQwCww3A7gKYCwCzaqdV/3YI7QGVymYARIVdiv3dgSuh6Y4mfSy1/E2SeJ
	 04/B2wZaKiUC7acnz5JIMOiJ+giB7G2DveKOCpJULd6F4GAQWQmd0XoattYdwpua+r
	 rrLr8+k0p+ubQ9Knuf4Z+tpA+x6Dxz6bmqBCG9FU+nFe83JirhAB+e6tz+SBG4us4w
	 333l2fXIOs3VnqZvU4/wbqwSPVYC42qlnuaU+8phHUIq0m6dHSkEebZkxlK1y3BvkA
	 Th0o5jfqNseh2qstXl5WrN6Hzs/WvJlUeizwMJkIVWsuTFJDZfVlrTlYGZiHsALXzX
	 hjvHkx/5vzitQ==
Date: Fri, 14 Jun 2024 11:37:28 +0100
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	corbet@lwn.net, linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH iwl-next v2 5/5] ice: refactor to use helpers
Message-ID: <20240614103728.GB8447@kernel.org>
References: <20240606224701.359706-1-jesse.brandeburg@intel.com>
 <20240606224701.359706-6-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606224701.359706-6-jesse.brandeburg@intel.com>

On Thu, Jun 06, 2024 at 03:46:59PM -0700, Jesse Brandeburg wrote:
> Use the ice_netdev_to_pf() helper in more places and remove a bunch of
> boilerplate code. Not every instance could be replaced due to use of the
> netdev_priv() output or the vsi variable within a bunch of functions.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Hi Jesse,

The minor nit below notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c

...

> @@ -938,9 +931,8 @@ static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
>   */
>  static u64 ice_loopback_test(struct net_device *netdev)
>  {
> -	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	struct ice_vsi *orig_vsi = np->vsi, *test_vsi;
> -	struct ice_pf *pf = orig_vsi->back;
> +	struct ice_pf *pf = ice_netdev_to_pf(netdev);
> +	struct ice_vsi *test_vsi;
>  	u8 *tx_frame __free(kfree) = NULL;
>  	u8 broadcast[ETH_ALEN], ret = 0;
>  	int num_frames, valid_frames;

nit: If you end up respinning for some other reason,
     please consider arranging things reverse xmas tree order here.

...

