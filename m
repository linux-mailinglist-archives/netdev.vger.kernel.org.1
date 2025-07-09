Return-Path: <netdev+bounces-205318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F45DAFE2DB
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE4E4E7C8C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752CF27AC2E;
	Wed,  9 Jul 2025 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNmrlNY+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BEB2737FA
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050314; cv=none; b=sMBO93MIzSeol+zLSdMlak/Zy+gRCBmqI2McMpGK4O5eKVP7JZg6Y33lWyFkqaQArvYeJO0c6oaJgrldvdfJbvG78vQxGgk5AmJMhMXXH+h0bq43hnbbxU7wfKl4qWHrq2/9VvNd0aaw3sYHG/aoKISFLUCqmptyF3zcQQRgsE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050314; c=relaxed/simple;
	bh=XAm1ddPSV6xuKOZ1K/+JAxSTW4RPOv/7/JpzcQf+xZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwM+CUo7YMDE6PTAf9lRXv6WUAtDz26NnZAeTDeCkkY83MQd38k7E8TvDGLVdSYhLcWCeABiqY93CQSw2+oLrapyqowDz8H6B7/t4tUAMMVbxlssWXsKt054e+Vnb1XUSMC9BeigX7JKmONCN5OQvolcpuhoBjEJ/yk3sI3mdBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNmrlNY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B909FC4CEEF;
	Wed,  9 Jul 2025 08:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050313;
	bh=XAm1ddPSV6xuKOZ1K/+JAxSTW4RPOv/7/JpzcQf+xZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNmrlNY+bQ/jTLubtwGYuYm+p7gjHhk2KnMFGOIcFeVhSjLzLtVQonD1mhNiBZBmK
	 nkwVbpm/iaIlIIWQ1vJWd86B7mDIw9FttG2mVc4sxrxOAWZJZT7ZifpDFTU17SAhvO
	 Ufv5sfwDunrqf+QVEVWugH7rcciRADZ6ZkMvYbDcbSxd33KGbxM3Q2Uqd/mPl4kq6s
	 bH3kY1vK85L9bh6QouNFMIUHQcBZb4aR2ZyQdz/6kk2AEQxCs77SHsBjwKLk5v0w8N
	 wbk8Pabe9Q1SDLC51iJtJ1Pgk3PVYFiJSLZktr3JZIpbj0GOkdL/R9hhPlqxyDeusF
	 h6A54TTAqsufw==
Date: Wed, 9 Jul 2025 09:38:29 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V6 06/13] devlink: Implement port params
 registration
Message-ID: <20250709083829.GH452973@horms.kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-7-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709030456.1290841-7-saeed@kernel.org>

On Tue, Jul 08, 2025 at 08:04:48PM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Port params infrastructure is incomplete and needs a bit of plumbing to
> support port params commands from netlink.
> 
> Introduce port params registration API, very similar to current devlink
> params API, add the params xarray to devlink_port structure and
> decouple devlink params registration routines from the devlink
> structure.
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


