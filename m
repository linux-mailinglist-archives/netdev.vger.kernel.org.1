Return-Path: <netdev+bounces-169354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B691A4391F
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3232819C7C1D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482FB260A54;
	Tue, 25 Feb 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfFQm8D/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2341D25A2DB
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474464; cv=none; b=J7HDa1A83WKr38X4A6zXv4JXNWjKhVAj2wK8NP8aRFqpw10UENjmbQSz8XssOhf7okxJjGDatenq8IPPYeL1l8+MEp1O+jBxlcLsvS3QljbDrTXLPuvns73C+wX3CSbUJ0ZRRvI+tFQRic2xrzj+Qb6SD0iffAL8mFXyiWht/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474464; c=relaxed/simple;
	bh=/ODj0B7Zvh/BLP9a3az8+kioV5DW2jEq7uwPYSSUvaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXF7z93RaQ63isRBrRSuHvjGQDPXopruKUYddor3IJDPJnJs6jOVvMGpbKvAT5bilnvtLdmbITSeN9rLqcqO8vwSxKY+jkRHkwXJKhru8gs20JoQwyg+X3g2D0Ekq0UXiHM5RmBImORR3ssyL9GcNaAcC5dgiH5heQfHzUrpdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfFQm8D/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB55DC4CEE7;
	Tue, 25 Feb 2025 09:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740474463;
	bh=/ODj0B7Zvh/BLP9a3az8+kioV5DW2jEq7uwPYSSUvaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EfFQm8D/wbbZNqDzS/cUBP3qVugMJvMZkMwwVgo2y6yZfIobixlzSOleqeXFNWR4u
	 KV/H2TglHOJtPExffH3HstLrnVsE8oLwxSq1CzEINYNbH0Fyw1frqv2+uDPMUlOYXo
	 OIAmYGNuZzkW1Xi4RW0nirwlJnfNGnphRzXaZ+XieQZExukCf49W7LlorAuWMJAWsK
	 Uqyi7PcQXOXtq25ZwSvQQGZpXUAx1SnQEhcmTu4POKwA1hxihRkm7t33ebQtOJVIG3
	 Di9rrAGOW6hfGwp9WBvz5Fpqep8p+8J8I5hk8/0Iliq6giBPFyI0LxRxGGfTc0GAH2
	 AzPlHTHTv4Wmg==
Date: Tue, 25 Feb 2025 11:07:37 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: Re: [pull-request] mlx5-next updates 2025-02-24
Message-ID: <20250225090737.GF53094@unreal>
References: <20250224212446.523259-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224212446.523259-1-tariqt@nvidia.com>

On Mon, Feb 24, 2025 at 11:24:46PM +0200, Tariq Toukan wrote:
> Hi,
> 
> The following pull-request contains common mlx5 updates for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq

<...>

> ----------------------------------------------------------------
> Patrisious Haddad (1):
>       net/mlx5: Change POOL_NEXT_SIZE define value and make it global
> 
> Shahar Shitrit (1):
>       net/mlx5: Add new health syndrome error and crr bit offset

Thanks, merged to rdma-next.\

