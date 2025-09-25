Return-Path: <netdev+bounces-226260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76585B9EAC1
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3D4165A78
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E386126CE2E;
	Thu, 25 Sep 2025 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBRtAL2q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5B486359
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796340; cv=none; b=V4VSnKyJkdTwcwMV7lZUyN6ZUX3dNrE6urxfPQvGFCziJLEK8NqQfZikC7RLFubj3bVmzsaHTHGPLkZ2/dPLLYnouSkeiyndfpCcVECil1Kt/Oycr41QILOpDrhpwUfY+5vfgc5T41jinNFsVxuEOQrCb87YI1dVzJ+HO++/Rk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796340; c=relaxed/simple;
	bh=H0egUGOW0b1bAE1bsFhjDgTj6KHri5hPJSZHFp91dpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jf2yY5CugPJUOq2K3AZd5BvDnb8fKykGAjte9MxQB6y8K/7UUCvNxAbZ+YuLUf79yj5897N/HoAptf8FbhJG01eWucVEr6V0foA8GyYn/uz3sBQc1S/hEYu8NaNbm6Ezh/XuGlN94AeHjduDyfkmzCfZpRX6hCHVZw36IQ3A8Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBRtAL2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BECC4CEF4;
	Thu, 25 Sep 2025 10:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796340;
	bh=H0egUGOW0b1bAE1bsFhjDgTj6KHri5hPJSZHFp91dpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uBRtAL2qA90G4Zo+RkcTXU1ZR91Vntlh9LPbRZAAzauuiFHCyOHUSu4qBvgEZuZNu
	 IwEr50QnrurnaiXuafZVIuHRsRwYo1UwXvbft7a2+8hJAS7hOpFB7+c0PpaOFT4KHm
	 JMrEb5qDcMP7nziyjQfmecxy+IXnBuVRxsnV4yRkt8vGF4ikbr/GLV6UgZRc+pN4uh
	 jc4OE2Cor+jhPnzjnAlux3eItUbznRXxBt+hsc7aGlU7z34hGkrtFKyVGvW16CKNvn
	 pFUcRG9OIaO8ihFWqO80nIhSGeoSZr5r9Ccz9i2nHFsnLkwLLFy0aROfdsBoCSsWMD
	 18U07S8gqD67A==
Date: Thu, 25 Sep 2025 11:32:16 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: npu: Add a NPU callback to
 initialize flow stats
Message-ID: <20250925103216.GF836419@horms.kernel.org>
References: <20250924-airoha-npu-init-stats-callback-v1-1-88bdf3c941b2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-airoha-npu-init-stats-callback-v1-1-88bdf3c941b2@kernel.org>

On Wed, Sep 24, 2025 at 11:14:53PM +0200, Lorenzo Bianconi wrote:
> Introduce a NPU callback to initialize flow stats and remove NPU stats
> initialization from airoha_npu_get routine. Add num_stats_entries to
> airoha_npu_ppe_stats_setup routine.
> This patch makes the code more readable since NPU statistic are now
> initialized on demand by the NPU consumer (at the moment NPU statistic
> are configured just by the airoha_eth driver).
> Moreover this patch allows the NPU consumer (PPE module) to explicitly
> enable/disable NPU flow stats.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


