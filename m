Return-Path: <netdev+bounces-204639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB13AFB890
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE0F3BF227
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7A61F8AC8;
	Mon,  7 Jul 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJEvRUlb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3FE155A25
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905551; cv=none; b=PADv0tj3Gsuza0Aw1lVFtSmEEoWqu3+HUizZB+OF/jix3OWE3PTzLyO5K9tBAdn/QjZpfE93meaWZhi/UQSQHLARy0OW3oGe2qGJ2avm5NTaimGXyih7OBJLOych4qhmBmlNMEtZiK/K6zYbb5U5dWvtNNfatNNUj78z3xO9TV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905551; c=relaxed/simple;
	bh=KupsFFRELoq46AWRDLNLGCMh4JaKIzRD5R5Y8vpqhtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbf+sCXOHyEw/EmBe3Dv/opybZoSs3ngX0hYAdVuDgNEoMCAi2ta0Sa7kla1s56Y0AoTQ6yS/PyH3IxudCIYUs92FTM6y3qZU7TcVJOni5aJQ/spZQ8km9OuES+DAtdzvLZR495c2ehp6f5JulGGsyGzGxOB8skv2Qi2BYZj+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJEvRUlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0A2C4CEE3;
	Mon,  7 Jul 2025 16:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751905551;
	bh=KupsFFRELoq46AWRDLNLGCMh4JaKIzRD5R5Y8vpqhtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJEvRUlbVcVE/rNL0Hvta9e7cXXQ3GzJy1MGkZxiekZCUZzpGsPMFfNss9RaWcpQx
	 VZG9cAmifJJuP5+SM8zA44TjBWsk5tSNMsYJM5J9DWXfWKGkZSxizaYDoUGpps42sN
	 6DDMtL1ssxCYrJBheMYJ8PONtJKCeF5LFSWnjCUQBkd6aVJY4KHJdebE0gluNVswpe
	 wS1iV6UXRo8+p9LAnzuEXXhbCpBlPlfBj1Dm0Y3Hzs5nAqwNWxUgjcRKF2Ga/0faDI
	 yrPusVnzTftcDLOi0sBF1+wEH7g5IxjvMP6klu1iedKhqbYcaVFspYAcOTJ+aLv8Uc
	 gZk4NbV6qsItA==
Date: Mon, 7 Jul 2025 17:25:46 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V5 00/13] devlink, mlx5: Add new parameters for
 link management and SRIOV/eSwitch configurations
Message-ID: <20250707162546.GN89747@horms.kernel.org>
References: <20250706020333.658492-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706020333.658492-1-saeed@kernel.org>

On Sat, Jul 05, 2025 at 07:03:20PM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> This patch series introduces several devlink parameters improving device
> configuration capabilities, link management, and SRIOV/eSwitch, by adding
> NV config boot time parameters.

...

Thanks Saeed.

Overall this patchset looks good to me.
And, importantly, I believe review of earlier versions has been addressed.

But unfortunately it does not apply cleanly against current net-next.
Could you rebase?

