Return-Path: <netdev+bounces-105018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB1190F715
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F291C23A97
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FE415886B;
	Wed, 19 Jun 2024 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTQvHTYx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEBC524B4;
	Wed, 19 Jun 2024 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825855; cv=none; b=SgNRCT+F3kKsVKuUgOQPxhaF2ZqasKc35JysKWHFEvDv9uIdxYxcQi5KE4O/fqFULPIliSXothg2L5Z20qP9sJvBU+uNEgUIAyli7hqNX8YLS45RZPXx7po4mlQe8p3i6bRkz/h64XiCV1BH9xF/uQi2ESdb2XkTXJ4u8JoAVP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825855; c=relaxed/simple;
	bh=7ZPs3tYloFOklfomR6gjf1ojP8TvvwuSW5jDnGW2zVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzWYGpkSUOeZWjBnUYRUGR8fv/iAd4s4NvqMhXx33MQUCAURJsQxHOThHMqiis6pWcmb/CLmxuZdbs1sWF+w+xOGdnAmxtZkRunGsTeQoeFLEVfLaHt/EMYjGmorgmwKgzbQCytGA6EofVB0yY5LXlzjWWrI3FU77ZGXfBZqMsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTQvHTYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3346BC4AF08;
	Wed, 19 Jun 2024 19:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718825855;
	bh=7ZPs3tYloFOklfomR6gjf1ojP8TvvwuSW5jDnGW2zVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTQvHTYxmZaU2tGTprqeMPMiyLd9eVQRh9F/JtEkTDM3KCOzWqPzVwpgtEvMYXOhL
	 8PXC2331ipOw8EV9+yH8zlLUQLHArm/ZDnNXcQpsKoyivoqlXO2dk6EDqtfI1x3ZgT
	 1+9Ifgkrkydy7OrxejBVVNx9/o5Xr2U8RNgodhyBVMIpgYXVbpUncJ3jDZtMFQXF+y
	 MMfeAcfsyCiBWjaOMTwjoBAhmPtmwLkWILG4BoHVX5qU3syB3A/bzlwA+bolHMEz/p
	 6Ff8BArQY2/a/pYgzRrVuzx8Nzhj8H7TGog6/BjHapCMoY39XeP4LJOA3WGiOXDL0E
	 8n4pb/xyMArug==
Date: Wed, 19 Jun 2024 20:37:30 +0100
From: Simon Horman <horms@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Cc: heiko@sntech.de, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] net: ethernet: arc: remove emac_arc driver
Message-ID: <20240619193730.GW690967@kernel.org>
References: <0b889b87-5442-4fd4-b26f-8d5d67695c77@gmail.com>
 <10d8576f-a5da-4445-b841-98ceb338da0d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d8576f-a5da-4445-b841-98ceb338da0d@gmail.com>

On Tue, Jun 18, 2024 at 06:14:14PM +0200, Johan Jonker wrote:
> The last real user nSIM_700 of the "snps,arc-emac" compatible string in
> a driver was removed in 2019. The use of this string in the combined DT of
> rk3066a/rk3188 as place holder has also been replaced, so
> remove emac_arc.c to clean up some code.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


