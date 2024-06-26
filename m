Return-Path: <netdev+bounces-106705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 698D2917536
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 02:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1804A1F22D68
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 00:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9F815C0;
	Wed, 26 Jun 2024 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCTEZpfM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4491862
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719361303; cv=none; b=XdpiZlH8yFTQp3V1Q0EuAN3FERqsbcqHWej0Y4yd5P+QvTzeqA7KBHGv9JsfwJ81vd8yhGvOh3jOkPIKoGPBeqjyGC12O7T1BqV2ISoXw8L9ZAQ9MduU5pXpv4lPvqJGOdU9+a4UBlOLqkvF9MmfYOaA3awlaIR07/w52oWKaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719361303; c=relaxed/simple;
	bh=R7TwSFSu/jA3q1cl9o4uOF+ehcp2PfD8FCIWhAGyMCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXozyIskwJ4/lr8ENICpOMweAau3pXogCKcZIyEOqyKwANXDeqXfmxoC6hBhCdllKtFNqk7rcuGxNYEU4Y8jKKZHwh/+M/yok5f8Y3OmiNj1KcUQCK9W3JEi+DeUSp1Opei+NzFxoorctmClNnI99y+XutxBY7sE/mDiPOYxvtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCTEZpfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDA4C32781;
	Wed, 26 Jun 2024 00:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719361302;
	bh=R7TwSFSu/jA3q1cl9o4uOF+ehcp2PfD8FCIWhAGyMCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oCTEZpfMaLLfURWupsviEmKfZYEtamSbc+M5JBnwCTuPxVIIW96bB686nzicjNy0E
	 sxlgCQOyeadplBLGh/vL3cXjb1QEDqeVylpvCBSaKVLkRBseVehGT0PzXgkVPRkOFF
	 tNPW28yB3zBcnzQ0IypkponLs9NnOBkg3bpAvaQDjqVXwBMdSmR1E3k/ZAnNMc0tKv
	 lIjzDxh3fLXK5D3dn9E1Yv29JXQQnI3hoKeBcnyO0MS+pNwhAs7JSd05gHvZ9abMsI
	 KpGm+S83BXFGjLJFy4AJrpQwuQFClSL8jetpoiRWRA6k3Wlup/4pBAvpNOEdEk1frm
	 lZORUKcIESzmg==
Date: Tue, 25 Jun 2024 17:21:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net 6/7] net/mlx5e: Present succeeded IPsec SA bytes and
 packet
Message-ID: <20240625172141.51d5af12@kernel.org>
In-Reply-To: <20240624073001.1204974-7-tariqt@nvidia.com>
References: <20240624073001.1204974-1-tariqt@nvidia.com>
	<20240624073001.1204974-7-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 10:30:00 +0300 Tariq Toukan wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> IPsec SA statistics presents successfully decrypted and encrypted
> packet and bytes, and not total handled by this SA. So update the
> calculation logic to take into account failures.
> 
> Fixes: c8dbbb89bfc0 ("net/mlx5e: Connect mlx5 IPsec statistics with XFRM core")

wrong commit ID, I think that it should be:

Fixes: 6fb7f9408779 ("net/mlx5e: Connect mlx5 IPsec statistics with XFRM core")
-- 
pw-bot: cr

