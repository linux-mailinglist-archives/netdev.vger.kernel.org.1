Return-Path: <netdev+bounces-139018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8109AFD2E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 10:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF540B21091
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 08:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C32B1D2207;
	Fri, 25 Oct 2024 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZruZ9oO3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C451B6D00
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846330; cv=none; b=sb69OUpy1k6+7OECDZrxJwhRBLCqDW1Uf3eHVMw2hC4qaRfqc+MlDXc75iYFphaUulTAjtAJXe3M1GtnN0IOJAuz+mhY5P81fd/hf/pltkpA11iSbVFITqydstMbo0mGjwSxZ5/4lg5CsN7A32IGURjMdIY0nk9cjeu5qSpuX+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846330; c=relaxed/simple;
	bh=QiVbOv8Ax3Y1FaSq8B1XnRhJrzzZ6xy9lbvfDKaay6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWk4v/821SBPvKTgKv7kbrjhCiN1tWRWYZAwsSgd/3S1ETWtCY+eyYtyl3wKChYf0ULTesmx4+fMUcYZ6tio7ehtsRQvuUu8ENAMxG8oU9VVYt1/80L2jJOvjFbgY8qh4E4xfgqR0pSEQGi7DyJgtZOYWTb5LorWclMrUs1Ct/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZruZ9oO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4B0C4CEC3;
	Fri, 25 Oct 2024 08:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729846329;
	bh=QiVbOv8Ax3Y1FaSq8B1XnRhJrzzZ6xy9lbvfDKaay6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZruZ9oO3yyMjZbOkFbV3YLmuV5dL1GWCKFgIhmDRDIQl09rgsc9Er4qA1F5zeJ+XP
	 dpPT/SbHXdBqjtvW/xz46ahPGKNVVsd0sbPt+x8FzmZjWPf7j9AZ6zF3zWxs8ROnJj
	 9l4embtCsbrobqhCNgvBT/uaAO8JcJpMOZ8K2vxRMBU9n7gnnhHSibWreRPET9fmkw
	 VF07KNXPDlc08hXqh8QVXqJhCGmeloJeoXX7mel9kiArLA0vMoJNKFQTijkHQ0WY/B
	 wKcG/0JhhrlQrFQ+Kq6Mk2D8K7IkNmjthNDWZu+Y9xoGbtR14ss20Xqh3yKysz/Rc9
	 y7gJ4aBa8W70A==
Date: Fri, 25 Oct 2024 09:52:05 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 1/2] net/mlx5e: Update features on MTU change
Message-ID: <20241025085205.GE1202098@kernel.org>
References: <20241024164134.299646-1-tariqt@nvidia.com>
 <20241024164134.299646-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024164134.299646-2-tariqt@nvidia.com>

On Thu, Oct 24, 2024 at 07:41:32PM +0300, Tariq Toukan wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> When the MTU changes successfully, trigger netdev_update_features() to
> enable features in wanted state if applicable.
> 
> An example of such scenario:
> $ ip link set dev eth1 up
> $ ethtool --set-ring eth1 rx 8192
> $ ip link set dev eth1 mtu 9000
> $ ethtool --features eth1 rx-gro-hw on --> fails
> $ ip link set dev eth1 mtu 7000
> 
> With this patch, HW GRO will be turned on automatically because
> it is set in the device's wanted_features.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


