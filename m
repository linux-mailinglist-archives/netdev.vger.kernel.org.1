Return-Path: <netdev+bounces-139019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CC39AFD2F
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 10:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D16BB210B9
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908121D2708;
	Fri, 25 Oct 2024 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmG8ctyb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8A71D2226
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846345; cv=none; b=c4C+FXzwjUmZyMEkTJuFhl9mLOMMIQhR9S9qym3jRCRT7J1NCUTBjurS8agMq0mgMZh93VULjeUIr5RFJTdWz3bVAcD/Ehy2O0BkHnw1ddZbTASFceyh8b4Hux8GbjiMylnJwElBmeCAdO+mJwkMEC6xoT/PaDZzL3XV7RXBzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846345; c=relaxed/simple;
	bh=WtI9/UE7OdXmJi84F0doCmg9pqgL+0uWtbvSui6MHxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM/aiOqn5Xxxa4ihQBrT7IbGA6F214Z8R1orP0j6Wibh5Nu//agl+/uEhjTA1nsm/v9gpdf/mMKHwjIvEBiamwRydBku4/3Qwrs5hplvsbuxyyW9WV+4pKaW/RJ3yf5KRQFcjKRNVUGei2mLtcXwAQvPY48QG7V+B9r5eK2tj5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmG8ctyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268E9C4CEC3;
	Fri, 25 Oct 2024 08:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729846345;
	bh=WtI9/UE7OdXmJi84F0doCmg9pqgL+0uWtbvSui6MHxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmG8ctybaM/E5uKBBRyUJ5X1cnlfAJ30uQUQ5e3p3WpUBsMWF0xJjPVWKSBEtAmzs
	 A1TREqjyiboK2kaKZa6A0uzZQXVPzpD632cGBIiF7VjNFEqwk5w2FxK4nmNlXi2wG6
	 7GY9KDUyMYhS9+SDKzstWykEcn4dghNK6me+HXUTkWQjnrxbUb1RhQJhGaHcp9HLbA
	 dcgfBTu72vhxsAQrYL0Hq0RBFfDkd9vRv4IPBlmXR/SRPZaMDHwwz8mlcJj4WK0RA0
	 XDbzs8sgmLMehzrna2SAqoROgSUBcgfMSqNPMX+HxrQRQnav0g04a/9f4+Pll0B5qU
	 4TTp4OfnuRg2A==
Date: Fri, 25 Oct 2024 09:52:20 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5e: Update features on ring size
 change
Message-ID: <20241025085220.GF1202098@kernel.org>
References: <20241024164134.299646-1-tariqt@nvidia.com>
 <20241024164134.299646-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024164134.299646-3-tariqt@nvidia.com>

On Thu, Oct 24, 2024 at 07:41:33PM +0300, Tariq Toukan wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> When the ring size changes successfully, trigger
> netdev_update_features() to enable features in wanted state if
> applicable.
> 
> An example of such scenario:
> $ ip link set dev eth1 up
> $ ethtool --set-ring eth1 rx 8192
> $ ip link set dev eth1 mtu 9000
> $ ethtool --features eth1 rx-gro-hw on --> fails
> $ ethtool --set-ring eth1 rx 1024
> 
> With this patch, HW GRO will be turned on automatically because
> it is set in the device's wanted_features.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


