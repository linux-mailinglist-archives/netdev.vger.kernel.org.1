Return-Path: <netdev+bounces-210302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B58B12BA6
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 19:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACDE17D70E
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 17:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C001E7C38;
	Sat, 26 Jul 2025 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8YMpN7d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE41C861F;
	Sat, 26 Jul 2025 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753551267; cv=none; b=vBgualmsnOS45eK8Naklbmmwwjiw2brApvmJpnQZVxS2q1iN7pH6w8q5BMmnywVeAdLsWIKojhHgUE6tdCsqQLxUv49mTcaKz45fossSo9AfDVEzYnTC2972CG/KOOJWjVfaxE9lQ0yz/9akhZ3X5EncfnFdFVx2U1ftWyar2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753551267; c=relaxed/simple;
	bh=FQMygfGFdyHWfvYj/l1Q6wT7EkBQRs6phhoLiEUeuXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+YYExAs5jaAmFhTzBmJ4MLnlg10Hi8GbLNoff29q3nxVS22Yv7Z69k+CR5xJgNYDVST/2u4i99Uu/+/D8Uvk54H4M7RhgMyPz75arsRdPBfHewdxmkSFebi2OMuM2VH/Zf9oUwBMSOUJVB6CAJQseE47TkL4h8IOLQ4oHDrRwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8YMpN7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B4FC4CEED;
	Sat, 26 Jul 2025 17:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753551267;
	bh=FQMygfGFdyHWfvYj/l1Q6wT7EkBQRs6phhoLiEUeuXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8YMpN7dmaD0J8ZoANApqeCLuKTKbyAKhAIexIp8yjJeDmR2XAEMi34ms++OAxWT0
	 3EagcupFOaVKpq5lDwPC1MxdIRQa4SxBZyfqqCud0L14Mk7gqeLqBU1vD40Ksh+4Wi
	 dXbAnKWJCruy3+aTUCNza8DmlmNMtFWFRakc3XNPewEoNuThF3x1TGM2XVf5B8S2cT
	 ZJ2vZ/3VgU8gnaF32KBTP7SbqbAzOQvk9MfK94Gs2w/NPN0cx2AEibHWMFpU2KHHwA
	 V3mFV9otYZCd5JWPBEmSg94WKYgtyltKbjixBYxyogeVEW+W2xWE8NohurXBzxFooW
	 x8C+JoiczoShA==
Date: Sat, 26 Jul 2025 18:34:23 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: fsl_pq_mdio: use dev_err_probe
Message-ID: <20250726173423.GK1367887@horms.kernel.org>
References: <20250725055615.259945-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725055615.259945-1-alexander.stein@ew.tq-group.com>

On Fri, Jul 25, 2025 at 07:56:13AM +0200, Alexander Stein wrote:
> Silence deferred probes using dev_err_probe(). This can happen when
> the ethernet PHY uses an IRQ line attached to a i2c GPIO expander. If the
> i2c bus is not yet ready, a probe deferral can occur.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Simon Horman <horms@kernel.org>

