Return-Path: <netdev+bounces-82964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE64689051B
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F431F27B58
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9067E580;
	Thu, 28 Mar 2024 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN7D5jhm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3D2D792
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643103; cv=none; b=NBfeITQ7ddA7WV1yeKgVSU07gQi8GsBi/IYBVsRz4KHSy7HQsBugjw36w5/Z5TiNueTVq6fUPyTayp07s9y9z4YnqpBrPzn+ot3hGYpG266bdinpYedCJUIxfQzOCquNiar6QiE9jZrtgMhJ7wkuRvkVD5jBADtFXBBKeCL4S0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643103; c=relaxed/simple;
	bh=TrDncR2+QTLt5cwJocHguh1aocxOaZjHCNZgtuJ7I9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i//sSLta2IOfEqRxHEumSGd5uFrBCAB+Zmqg2spWaPUh7E2A2/jsum4SHXbCCK4xw8xeFo1keNl7p/CsW3jukwcoPuv5ltDA+XuGJg6uH75MQjw7IqE29Fql5WxlvE3abWt5u+Yg8dkzEe3egQ6rz7BI4XsjFyHqgyFSsYiHeR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN7D5jhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354BBC433C7;
	Thu, 28 Mar 2024 16:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711643102;
	bh=TrDncR2+QTLt5cwJocHguh1aocxOaZjHCNZgtuJ7I9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vN7D5jhmC6TwH0ot5lL59cz1qrKz34UDSJpYP/wjYIPBecH0hNTSqOB0b+/ZrqDPC
	 UdZTa27eiLu3Cp5aZilsIWpHDfUeBS8tT7iDKzF4Tl3Qimk2sOtWNGM2HopfNVMPpy
	 RVqxpCXAauXMxJBLVsFxYSn0aO3aqeiUx9tn1kqjUIzZqqpXUjTvDEutrTNjEc8+QS
	 S8MV2M1GnkZyqlG3Ne0Q81F+ZX068LzURWF/Oqw64d66NUHUaY4/xVq8wanHSZx/SE
	 +jGsaCi7bYgKgMRz1asKfGgLlA93hYxezAcv7Yf9ULi0wvfp5PM5z4MXn2yduUwUiJ
	 Z699gYm0OSX7Q==
Date: Thu, 28 Mar 2024 09:25:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 0/8] mlx5e misc patches
Message-ID: <20240328092501.3a2e5531@kernel.org>
In-Reply-To: <20240326222022.27926-1-tariqt@nvidia.com>
References: <20240326222022.27926-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 00:20:14 +0200 Tariq Toukan wrote:
> This patchset includes small features and misc code enhancements for the
> mlx5e driver.
> 
> Patches 1-4 by Gal improves the mlx5e ethtool stats implementation, for
> example by using standard helpers ethtool_sprintf/puts.
> 
> Patch 5 by Carolina adds exposure of RX packet drop counters of VFs/SFs
> on their representor.
> 
> Patch 6 by me adds a reset option for the FW command interface debugfs
> stats entries. This allows explicit FW command interface stats reset
> between different runs of a test case.
> 
> Patches 7 and 8 are simple cleanups.

This is purely mlx5 changes, since you're not listed as the maintainer
it'd be good to add an note to the cover letter explaining your
expectations. Otherwise you may have just typo'ed the subject and
have actually meant it for mlx5-next.

