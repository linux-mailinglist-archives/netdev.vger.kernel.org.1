Return-Path: <netdev+bounces-152829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9EF9F5DA7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E2316CBDE
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A426314A62A;
	Wed, 18 Dec 2024 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJdAkXQv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E2B35963;
	Wed, 18 Dec 2024 03:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734494278; cv=none; b=SdKjfCfl8m7wgr7gmfJ+Gjr7N1Dk0fgknUz7jm/wM+iSd9JWcJF/NGnnslW7SzsJt0Ymzu7Q1GMK8mofZE2pAh4S3HpOpFKwdY/PfD/jfLEY7EYmJSoEKSRAeN5iKmaZf1av5MPu/ht28YYRkNIZyrOw/P/qf9gQLxnOeqFOUIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734494278; c=relaxed/simple;
	bh=AAaWMipgujI54mRxelTa2hI1sK13puS+twLH4/fj78s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJEZSbwx+Vin9kq1vTiPsGNZuCjyy8MYT6m5jL5TagmAT8v6liS1eMpf+tUgv0X+1+mLPbiSiFJEC8d3Bjf+ywtk1yNkSsYuhAzgzc2rkG2v+o923hpQLiNkSQnljd8bLleUo4nD1jUYUTESabuo+6cRqkE4CI+IZxCntsrOb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJdAkXQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ECCC4CECE;
	Wed, 18 Dec 2024 03:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734494277;
	bh=AAaWMipgujI54mRxelTa2hI1sK13puS+twLH4/fj78s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nJdAkXQvkhrFyitkV631mPnxtthL1oeHgLC0Boqxf5JeIfe/GRBGRO2DiXPTCxRYP
	 lmdfEO+m5T7wAGwNcdMsDdnLe5zOOtJum+aQuUqNxLkz0Vmn5Qcq0e+TF8ohdE1KBY
	 zQGUHGtrMr506WuEkJ24Ih5XkNRu9ATYXaHWJaPf3c4aT5X4sozjIX+pJ4k6FetdWT
	 ZZu568ZbubODIKpBBglaQ4EJ5sV/n1A8VOeE9g7Rybb+fWwEIsDYLKs+1jr/2oLUGX
	 uGXV20T9yDbHYMrRJvtTnh5cxaPpU0mllA5YKfDQQK3gtQSvMaYGoVqVkrNYJ2R+Tp
	 loqn87kFKpAeg==
Date: Tue, 17 Dec 2024 19:57:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Divya Koppera <divya.koppera@microchip.com>, andrew@lunn.ch,
 arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v7 2/5] net: phy: microchip_rds_ptp : Add rds
 ptp library for Microchip phys
Message-ID: <20241217195755.2030f431@kernel.org>
In-Reply-To: <Z2JFwh94o-X7HhP4@hoboy.vegasvil.org>
References: <20241213121403.29687-1-divya.koppera@microchip.com>
	<20241213121403.29687-3-divya.koppera@microchip.com>
	<20241217192246.47868890@kernel.org>
	<Z2JFwh94o-X7HhP4@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 19:47:14 -0800 Richard Cochran wrote:
> > > +static int mchp_rds_ptp_ts_info(struct mii_timestamper *mii_ts,
> > > +				struct kernel_ethtool_ts_info *info)
> > > +{
> > > +	struct mchp_rds_ptp_clock *clock = container_of(mii_ts,
> > > +						      struct mchp_rds_ptp_clock,
> > > +						      mii_ts);
> > > +
> > > +	info->phc_index =
> > > +		clock->ptp_clock ? ptp_clock_index(clock->ptp_clock) : -1;  
> > 
> > under what condition can the clock be NULL?  
> 
> ptp_clock_register() can return PTR_ERR or null.

Fair point. Since this is a PTP library module, and an optional one
(patch 1 has empty wrappers for its API) - can we make it depend
on PTP being configured in?

