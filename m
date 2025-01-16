Return-Path: <netdev+bounces-159110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD674A146C3
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8B516BA4E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C01025A643;
	Thu, 16 Jan 2025 23:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mccP5JyT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764C25A627
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 23:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737071205; cv=none; b=vAGJczoBZLq+B6a/9o6A4U7FnHU5m72vivmP1i52xJibGK46RE8rOlQK1zDwBDnTv+8CZZTTGYro2WObFn3kSpBfWbT/3mSLdkS+M4wuVrNrsgSh+2YnynhF6APQlU6j9vcnQULysv2rnnF94ZO+B43VNEN4Gw1cddnW9ch85SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737071205; c=relaxed/simple;
	bh=UCr2wYW8trWBYhymycVsETSsjPiOXOLwXv7YD7VtZLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H00D1xTZbfccFTaLX+8a500cNEDXZsJMuyHBDmScwwcWmTHy5qjmYKuBntheg9IcDR2GMjYR7nc619Ky45PuNwRXxRnc3PR/7c34xPWoy1rN8ZWO0w7/4S4SbLwz2UEUZOMcRkcbhFSYLg3DM4mZ9rwvnZHLasnyNktRxgcjnW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mccP5JyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E17C4CED6;
	Thu, 16 Jan 2025 23:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737071204;
	bh=UCr2wYW8trWBYhymycVsETSsjPiOXOLwXv7YD7VtZLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mccP5JyTE0+VuiLc7p7cwbO4AfKrDQ0yuvnNrbGyX4MjjzvxRGSJAXS0iS36E6Ius
	 SVdamKXIksyHoU5S5tdMJc8hkwimowdwdSKrx4ps91v+90EOIVtLEcqv1H+4cNtGJu
	 NjGoDzWMifoc6CHQqpqkRjuNtfgp8HuaW0XVuaCBtnHqTW24eSOPGUh5+nOq0ozqWF
	 JCeEdcYloWPUGsWqolF+aIpTLCZLdz9wpYLco0ZWmDgbAyNCqChlnLooWh2I3t/tPL
	 DPk0asjfiDPKOYTAfBVg/MRdnS3+8d0yCVCUsg4apqfNjvj3c1ZfUheY7DYkbs8Ci/
	 yDl8RmiWfme4Q==
Date: Thu, 16 Jan 2025 15:46:43 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [net-next 10/11] net/mlx5e: Implement queue mgmt ops and single
 channel swap
Message-ID: <Z4maY9r3tuHVoqAM@x130>
References: <20250116215530.158886-1-saeed@kernel.org>
 <20250116215530.158886-11-saeed@kernel.org>
 <20250116152136.53f16ecb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250116152136.53f16ecb@kernel.org>

On 16 Jan 15:21, Jakub Kicinski wrote:
>On Thu, 16 Jan 2025 13:55:28 -0800 Saeed Mahameed wrote:
>> +static const struct netdev_queue_mgmt_ops mlx5e_queue_mgmt_ops = {
>> +	.ndo_queue_mem_size	=	sizeof(struct mlx5_qmgmt_data),
>> +	.ndo_queue_mem_alloc	=	mlx5e_queue_mem_alloc,
>> +	.ndo_queue_mem_free	=	mlx5e_queue_mem_free,
>> +	.ndo_queue_start	=	mlx5e_queue_start,
>> +	.ndo_queue_stop		=	mlx5e_queue_stop,
>> +};
>
>We need to pay off some technical debt we accrued before we merge more
>queue ops implementations. Specifically the locking needs to move from
>under rtnl. Sorry, this is not going in for 6.14.

What technical debt accrued ? I haven't seen any changes in queue API since
bnxt and gve got merged, what changed since then ?

mlx5 doesn't require rtnl if this is because of the assert, I can remove
it. I don't understand what this series is being deferred for, please
elaborate, what do I need to do to get it accepted ?

Thanks,
Saeed.

>-- 
>pw-bot: defer

