Return-Path: <netdev+bounces-221507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A02CB50AE9
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 04:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BBC4641AA
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 02:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734E92367A0;
	Wed, 10 Sep 2025 02:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skPq3z/K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4021E6DC5
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 02:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470439; cv=none; b=Sy9+Ire5NaYCLmlSzBs5QR6d9xjvywnTl30ZxPRqFzEZBrd69SBk3zhjXIKaiq/oiBfw9bPWG5k2ZZW3yki78UY8/Nel7c0aBp2VLcOCxIljj91mvvZZqaUoSw8UOVYodC+GN0FjQtKJU2oNIxBi5+RenZc6yDYKD1DQsy1jxXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470439; c=relaxed/simple;
	bh=DkEfFRz4+XdtM0e2tMvgisn3OOmTMLMofxJnuOqqmKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lUmcqt9Q/uAXDAiCG+UstDDSHB/plfUepOnTlWTIsaYBojItKP0oCg5tLD8rPilUW2QDGyN3hhUYTCgN18sVK9G+n/4b0/RDkGJ186x7ZxQeF2TcN+dRXoqLXQtNCbTw6h4SAP/51VQt9Jjx5EG0CUE8LBZtkEMJ9rP2AGL7Nww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skPq3z/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF291C4CEF8;
	Wed, 10 Sep 2025 02:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757470439;
	bh=DkEfFRz4+XdtM0e2tMvgisn3OOmTMLMofxJnuOqqmKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=skPq3z/KHwaSbKz2RZ38gKbvyeR2DbTi5zQw6/YBuhNI3qKR/CMx9cX8P41Obzavj
	 puixlplOMfREpVUBwOqQDtPiaXTs6mj4ySqfYdUylaFtxgFUBFhmCeYxXq3ssbyj0Z
	 oxcefilIiHVc7NukSky5qAXaqq0o7ZHjHAzW/JMUb6oaKBrx0k/sTV/WNV99oYmhUV
	 ITx72zYcxUTCIO7YD0WByZ0V6ndZP6MjYZycJp7ON82s9OhjjywN4Ix1WMYJIYbry/
	 ukxyx5incYAGrPB+8AEivJ6GvnxiLxjL6+4374Bo97EiJI6Fliu6T0kS0Y+mp2gXau
	 cSSh2jhU4zTYg==
Date: Tue, 9 Sep 2025 19:13:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH V7 net-next 00/11] *devlink, mlx5: Add new parameters
 for link management and SRIOV/eSwitch configurations
Message-ID: <20250909191357.1992b750@kernel.org>
In-Reply-To: <20250907012953.301746-1-saeed@kernel.org>
References: <20250907012953.301746-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Sep 2025 18:29:42 -0700 Saeed Mahameed wrote:
> This patch series introduces several devlink parameters improving device
> configuration capabilities, link management, and SRIOV/eSwitch, by adding
> NV config boot time parameters.

Let me take the first 4 patches so we can make some progress here.
The per-port params have no user in this series?!

