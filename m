Return-Path: <netdev+bounces-82819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B3688FDE8
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98CA1C2398D
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86BB51C5F;
	Thu, 28 Mar 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy22PFvZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD5A7E116
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624731; cv=none; b=IKUwEMqln6aPZQ10SIFS37Uf05CFChuiXd5aC13var3NnTmCebrKRL9XN4tBYHnYDzc9dHcmIi1JndoSpmpw/bELi4xfDz36U14HZgsw2cZGuGwqUNAYOoEgcKsGCWtYGHPj6zATX6GNxhYNIGu40U4oh8EbgjYQqdvwD+rQeic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624731; c=relaxed/simple;
	bh=fb0DzkbW5OpklSikYcDNYzw0BDPRQCdpcNaT1HJwJ48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHBs5tz9xv+ciLQuWOgXh/Y7/XYTpBykt3q6xQRzJppOBs756ZsLJsgHgZtBchE+yMLDUjQJCZO04c6F9ZmG1+8zrKN4ZMmHcchiAMxBl5bSVG/2sdqD26YXD/g7b4hyPPsZCkZdUttkuSnqcuD9AAa8Q86YVCjpGk21Y7VNHqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy22PFvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646BAC433F1;
	Thu, 28 Mar 2024 11:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711624731;
	bh=fb0DzkbW5OpklSikYcDNYzw0BDPRQCdpcNaT1HJwJ48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iy22PFvZkfC/qcOxvQkycd0/B4Fu7RhqjCf1/3wGwaSP0QjDyfty5cbA0y6FC8Ws3
	 Ow7rwuhSTZEnGe7RX3NTDoS1DvfShIQPDfmnodQ3Okp/I6+vOT7RWrSa6pmxNg6DuK
	 RT4jStwqHGswlFEg1KRDKVHDuH/WFO2mG0uTjXDWj/zpiyy4+J1dEY3wx8rbmOiSVW
	 KSvNgJGKLlUFPP32y9oaYIxIPNJxxtVJw52v/HzH8gC+sX3BfQeOA1bKb34xegTtis
	 0hv6NoUiG2FFrdANn6/1YQxg65tzbiS3CUIVDykDf4q9AAKYL/ML4wBrhVYWvAqvsQ
	 zqkvEL6s6bZ4g==
Date: Thu, 28 Mar 2024 11:18:47 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 2/8] net/mlx5e: Use ethtool_sprintf/puts() to
 fill selftests strings
Message-ID: <20240328111847.GB403975@kernel.org>
References: <20240326222022.27926-1-tariqt@nvidia.com>
 <20240326222022.27926-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326222022.27926-3-tariqt@nvidia.com>

On Wed, Mar 27, 2024 at 12:20:16AM +0200, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> Use ethtool_sprintf/puts() helper functions which handle the common
> pattern of printing a string into the ethtool strings interface and
> incrementing the string pointer by ETH_GSTRING_LEN.
> 
> The int return value in mlx5e_self_test_fill_strings() is not removed as
> it is still used to return the number of selftests.
> 
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


