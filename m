Return-Path: <netdev+bounces-138636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB12A9AE6E0
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181041C23CB1
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976AE1D63C1;
	Thu, 24 Oct 2024 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arBXWtlQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A0D1CBA12
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777159; cv=none; b=C1rcXQW8IJ6gSX1Vg7OC/jgS5Q1E8rXWCx5mqy8jpcv17c+mcGfyhFoUOB074dJ12YMh1ha9rNmZSXzDgs0CqNz/ZJ5bAew1j4OcEZ/1jTtZC8K+04yX6/VUx0dR5xCDbb7jiiGk0vZorf8U1KJ1UaOYLVYa6i57XrrMn4NL8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777159; c=relaxed/simple;
	bh=3M9i7GhKjuaIzAYVTEEtcjwAA0cxScexGSaX2Mrj9+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxd6++ofHTJSqDc1FZMjgN/yt4L7OMXyZyZRM4uv8yEHUeIfnCZmBJgafBx5Jfr0+ihFuS4GY/p1PKZDezCgAOb6XIV1Ck3KOizatvsJPpdPTjoZsnhdPWkSa410GnXWZUkv3B3rlfVgqQVICBQ0VLs/VjEGwFmLLvBYLGTossg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arBXWtlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C13FC4CECC;
	Thu, 24 Oct 2024 13:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729777158;
	bh=3M9i7GhKjuaIzAYVTEEtcjwAA0cxScexGSaX2Mrj9+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=arBXWtlQNeSAQ0/U4XcsTbkZLXOtZrQ1YZ7WqDDUtqsUrztpfa4ukpnGtReP6C4Um
	 wdhFKg5mDGPswL3i5vP5OisdQAo9p736DbKDBjDCMqJmTXhoDkcj0TwxrzODufplUY
	 vV3FbiIa/xS3nCqyRbJruN1UdcpNHNd3qSi9WkFagiTbtSCOVKPRobRYTeuOytCkhd
	 5wE2V7pkWptKiajxZmtWtTOrp/7k+O8r6J/sRLwZPgzr2CazcNQJsQHA7AYDhmM4sv
	 qCYT31SROVE6gDDHX/C6bvV7H5I4chlQtf0DkFCaTgeoRa++3GHgI7zJ2doMu5VCLf
	 TnLlDmncwFfhw==
Date: Thu, 24 Oct 2024 14:39:15 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v10 5/7] ixgbe: Add ixgbe_x540 multiple header
 inclusion protection
Message-ID: <20241024133915.GP1202098@kernel.org>
References: <20241023124358.6967-1-piotr.kwapulinski@intel.com>
 <20241023124358.6967-6-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023124358.6967-6-piotr.kwapulinski@intel.com>

On Wed, Oct 23, 2024 at 02:43:56PM +0200, Piotr Kwapulinski wrote:
> Required to adopt x540 specific functions by E610 device.
> 
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


