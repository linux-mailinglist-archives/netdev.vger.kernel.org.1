Return-Path: <netdev+bounces-205235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E21A0AFDDC9
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 05:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A8B1C26A86
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225211AAE17;
	Wed,  9 Jul 2025 03:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsngK2uH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2089188A0C
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 03:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030273; cv=none; b=nD/fiFbm/96gij58s9+QSs5ig2gbsvHws0M/4EGyMBt4aoNrerZ6mGK3Ap2nfwsMa4zn4H1KrMPB4gU+gxby5b2sV1yTqUugkMbq0YYZ7vavzkWR1UrXfQyo1Nd7t4GYdFgCXXmHZSZ4zRopTdE/097QKV7RMWwvjIQInze0jcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030273; c=relaxed/simple;
	bh=wuAErupuiEYf5tR4T1nl1riOnIjQi4zJzBtqpJBL+sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOEdZh8/E+tMbwxoTfwTtkPzLKC/nSus/5Yz07S7znMU3wloqZUb1U+plQ2dTe+6GXCHtjo72uY3dz6jy+qYhBxSGJQKpSa6FZeWuj6N/Q+fRsctN9rkTQuc5ccyGj16bBA+jzbd0v8AM34D4S0ZfK5UxPqdWam0MM226P0g+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsngK2uH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C396C4CEED;
	Wed,  9 Jul 2025 03:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752030271;
	bh=wuAErupuiEYf5tR4T1nl1riOnIjQi4zJzBtqpJBL+sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lsngK2uHX0RSe1bsgigz4j+8WaVLc12F2AvMgFCSOtIcklUDfRasqaopHFceq23wB
	 Iw2ATDQx6Q/79EkKlGGxMRaFvu01dPvr4RnnxTsZnKsOZwRfu+bh7bLp96FpYEw9dC
	 PDPz6eIqe6TFoFCflmY6tmmVkxJkJylLFmJpcO5nVV46mpqyzoS2xN2EeSs5B7xa6O
	 zHnDKDyi7p+bze3RHHH6bUGqCpWE89hNHjKpjfXwRSxDfSkaW4PZq1tbheA+ySHHZi
	 lv/grGWARRQfaazWxDxuaJE9aUou2qDznFd6MYKderfmZjKSq3H7rQeis9/G13e85M
	 yFFAE9gcJhvVg==
Date: Tue, 8 Jul 2025 20:04:30 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V5 00/13] devlink, mlx5: Add new parameters for
 link management and SRIOV/eSwitch configurations
Message-ID: <aG3cPvni2Lhwye7R@x130>
References: <20250706020333.658492-1-saeed@kernel.org>
 <20250707162546.GN89747@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250707162546.GN89747@horms.kernel.org>

On 07 Jul 17:25, Simon Horman wrote:
>On Sat, Jul 05, 2025 at 07:03:20PM -0700, Saeed Mahameed wrote:
>> From: Saeed Mahameed <saeedm@nvidia.com>
>>
>> This patch series introduces several devlink parameters improving device
>> configuration capabilities, link management, and SRIOV/eSwitch, by adding
>> NV config boot time parameters.
>
>...
>
>Thanks Saeed.
>
>Overall this patchset looks good to me.
>And, importantly, I believe review of earlier versions has been addressed.
>
>But unfortunately it does not apply cleanly against current net-next.
>Could you rebase?

Done, posting v6 now, Thanks Simon for the review.


