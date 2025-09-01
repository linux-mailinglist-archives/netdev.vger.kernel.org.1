Return-Path: <netdev+bounces-218772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B47BFB3E670
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 15:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD6B3BA0B6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AD934167F;
	Mon,  1 Sep 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+IIcDWX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B934167D
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735123; cv=none; b=c6KRgkuKRAPVOGr3llfXOLbuX2fO+uD1ISyEJx9wPRGMW2SGmxFwjUK+imMF4JTR0peh4P7U6dKhMGq4CyJocWy8gWjjG+McNCj1wjZG0wKoHDflm/UjtD9FSk5ATbgVNDN1TCTpMyN2OYjXwQLsBRDKd8fwPtHJ8b9/ivOITyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735123; c=relaxed/simple;
	bh=NH1842dvF9/a6HsKvsjVarKsrYBtCAr61n9u8gaaxbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCIsxAeCrVVIwBpqSpBWi7fyYqZ+bGv87mRfdfZEQUGmD7vjYA3+UHuv0aTcBCFk48AlnvjYc5VhrYrrpJFrPRoR0BYfquMe2PTmt71rUNuObhatKS9mU/E7rv1FsT7Coev5HQzmx15rwT0zH7/ZY+ovp/C6BTc0KEdwJ0GuqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+IIcDWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69680C4CEF0;
	Mon,  1 Sep 2025 13:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756735122;
	bh=NH1842dvF9/a6HsKvsjVarKsrYBtCAr61n9u8gaaxbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+IIcDWXuSLSvmsagqwcT9VXZpA3Ks0uqeLlA/WGCqYEz92f4wU88mzLqKOksH3Oo
	 6DQK5wxDF2v6IDl1BBC2fPeZPJpvkwT4dneOwidFKsFFVhW3RuRVVpEMNhi5vP4eOw
	 0KoDOADeLQj6RCnuCLtxHL1d1oW6/b4ZiliLhfTmmJO2LduvgnksyNnKAMRBoGu6LX
	 qw6b5NPCrZYwIy8XRkKgJftwbURqRYkwqibv0F5H+UB1GrJ7lZdnoK+LrdJ2ug/1Yy
	 4zUq+q1FlrYGjX4nukoK4C+5zRPEZBeh7xFJUlvAs7xj1JmTGMlrBonkYBlIP/8XaI
	 buDbK4UfR8ktQ==
Date: Mon, 1 Sep 2025 14:58:38 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, mbloch@nvidia.com,
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: Re: [PATCH net-next V3 3/7] net/mlx5: E-Switch, Add support for
 adjacent functions vports discovery
Message-ID: <20250901135838.GE15473@horms.kernel.org>
References: <20250829223722.900629-1-saeed@kernel.org>
 <20250829223722.900629-4-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829223722.900629-4-saeed@kernel.org>

On Fri, Aug 29, 2025 at 03:37:18PM -0700, Saeed Mahameed wrote:
> From: Adithya Jayachandran <ajayachandra@nvidia.com>
> 
> Adding driver support to query adjacent functions vports, AKA
> delegated vports.
> 
> Adjacent functions can delegate their sriov vfs to other sibling PF in
> the system, to be managed by the eswitch capable sibling PF.
> E.g, ECPF to Host PF, multi host PF between each other, etc.
> 
> Only supported in switchdev mode.
> 
> Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


