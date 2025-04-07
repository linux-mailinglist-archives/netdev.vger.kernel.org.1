Return-Path: <netdev+bounces-179746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4DEA7E6CC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396D91661CA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F9420A5CF;
	Mon,  7 Apr 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skO9Z74L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508AD209F59;
	Mon,  7 Apr 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043455; cv=none; b=kdv2ShXLw8GJINZMI/bZOWDUwC5BksbyKNZwNXlCjt1Gx9hu6QJS2kozlmdmXfWwv9xmVv6Lmir9n25tQ0YwJBlwrtVq+Pud3mcXNhw5jCBtSokYaK8ZZsVUQUeJ70VwtKi1twd6FRLWo3zjewY892txXWG2sAFmO9gO7s4f348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043455; c=relaxed/simple;
	bh=/TutFamz++e9Ol2BnfqwTlYdT8/rOGbQ5Wci+oxPL90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIhZFsMat4m49mXT06xHAsAVwInlpGMdZfp6FPm8MbO+c4t8O8StU2591YjZEfWCo1c0IxOdu+B7fYJnpCkAY+AV6uy7eVrI9r9qpAZqBd3d39hVbngmiCERiGZ2nB+zuz8nI3UAoARQtaLNbjHkbjFgjHfkyd4IDCIyOufw5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skO9Z74L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4647DC4CEDD;
	Mon,  7 Apr 2025 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744043455;
	bh=/TutFamz++e9Ol2BnfqwTlYdT8/rOGbQ5Wci+oxPL90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skO9Z74LvwgZqxXLqkgxLFPE8VSvxn6JVjP2UZju0T4h6wfnyJkwoaBvcZ/KM3DWD
	 M/+k5D458oDCzRfZHpkSEeZI6W8k6FuetwkelIlQgq55IjmneseaoaZpi0ZJdtsrhm
	 oYciipfbBhWx233JqrsSmonMy9Q5KlHHNt2iwzj7b2agUHvLPYfIpBdBGyvEcK4+wq
	 yAWWSKZPv1d5K1YdmedCsSuecmF4oG7NVJHjrGsOtQ4FyBO4L/pwmRoeGD2VpNEu4v
	 W1u3R0RVhnqbxN5jeeLcW/p2lfXaMPs1fSp+yoxytgRHVjephrvq3puNuzqtKF7tms
	 ZDJkY6e2mPf7Q==
Date: Mon, 7 Apr 2025 17:30:51 +0100
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH net] amd-xgbe: Convert to SPDX identifier
Message-ID: <20250407163051.GS395307@horms.kernel.org>
References: <20250407102913.3063691-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407102913.3063691-1-Raju.Rangoju@amd.com>

On Mon, Apr 07, 2025 at 03:59:13PM +0530, Raju Rangoju wrote:
> Use SPDX-License-Identifier accross all the files of the xgbe driver to
> ensure compliance with Linux kernel standards, thus removing the
> boiler-plate template license text.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

I note that this patch changes both the licences and copyright information,
and not just the representation of that information, for the files it
updates. And that the patch is from and reviewed by people at AMD. So I
assume those changes are intentional.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-common.h   | 117 +-----------------
>  drivers/net/ethernet/amd/xgbe/xgbe-dcb.c      | 117 +-----------------
>  drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c  | 117 +-----------------
>  drivers/net/ethernet/amd/xgbe/xgbe-desc.c     | 117 +-----------------
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c      | 117 +-----------------
>  drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 117 +-----------------
>  drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  | 117 +-----------------
>  drivers/net/ethernet/amd/xgbe/xgbe-i2c.c      | 117 +-----------------
>  drivers/net/ethernet/amd/xgbe/xgbe-main.c     | 117 +-----------------
>  drivers/net/ethernet/amd/xgbe/xgbe-mdio.c     | 117 +-----------------
>  drivers/net/ethernet/amd/xgbe/xgbe-pci.c      | 117 +-----------------
>  drivers/net/ethernet/amd/xgbe/xgbe-phy-v1.c   | 117 +-----------------
>  drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c   | 117 +-----------------
>  drivers/net/ethernet/amd/xgbe/xgbe-platform.c | 117 +-----------------
>  drivers/net/ethernet/amd/xgbe/xgbe-ptp.c      | 117 +-----------------
>  drivers/net/ethernet/amd/xgbe/xgbe.h          | 117 +-----------------
>  16 files changed, 64 insertions(+), 1808 deletions(-)

...

