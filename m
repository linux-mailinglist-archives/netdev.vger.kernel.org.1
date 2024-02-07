Return-Path: <netdev+bounces-69954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9410F84D203
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DDCB2355A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0A685269;
	Wed,  7 Feb 2024 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBrulVvE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E6B84FC7
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332991; cv=none; b=SNvVU79kDIhIxSk+2e66eyPGLMkguUZPMinRxmt3eqbmQ42CHg1P8gYSJ6ASF3fO0Fu/zuP7OYdvglyGeNelVzPTJsP3HEfS463fEgGfjfmcIcPvTAqW3tyus1Upm9IsM49RLRbkXZ9dZsYR+WBwoC9kcLI7t0v0/psqsNZvaKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332991; c=relaxed/simple;
	bh=0wOevUa8Hq+NCdSQA77L/3rni2nMLeELr3nYKe6mh/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBAFshObSzXCpOsYm3VuXynRS5Vzdaogr9/FiayTcHKGb+fUjYKEXdMJzyVghMnxYvNxMsYNxnFR570w8Xpn23q5Gv74vsElasrIRfOBNmAsnnRF6SvjIQYuFf+y/dG9PPztwoEoQzD6FUAPLawyLSIq9yL5XjsqiUI6+E/GvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBrulVvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F45AC433F1;
	Wed,  7 Feb 2024 19:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707332990;
	bh=0wOevUa8Hq+NCdSQA77L/3rni2nMLeELr3nYKe6mh/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBrulVvEK2PkkbhppodfHZaR2118MPZU3H3ckyU47V2wotxmstyRLUE/Leqw1kVda
	 aQKWs/Tz9I4dEtfuhZnEo++SRDIugpZ+60AEXLHsC1FwJjDsfRhwmCxiXWHdCVMNzc
	 pJR8kwpEjw+cr0Ss1fqkd7yoYw33MT6dSHHIvKgbBm6n6ilmtuIkuMZCdsT4YLCFOR
	 CtwPB6X3OqX60k2pmiT5tOABzE3395Xjy0sQunxZoR64zvabIBeaF+XXLFdSXWIcg0
	 oFYn8zfW1nSDq2MB5NpdTAznV32EWvEniJRyDNbW2TcvXDVrPb5F4hfMft8K/Rive/
	 JuLlWKN+y6JRA==
Date: Wed, 7 Feb 2024 19:09:46 +0000
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com,
	Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: Re: [PATCH v4 net-next 2/2] amd-xgbe: add support for Crater
 ethernet device
Message-ID: <20240207190946.GM1297511@kernel.org>
References: <20240205204900.2442500-1-Raju.Rangoju@amd.com>
 <20240205204900.2442500-3-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205204900.2442500-3-Raju.Rangoju@amd.com>

On Tue, Feb 06, 2024 at 02:19:00AM +0530, Raju Rangoju wrote:
> Add the necessary support to enable Crater ethernet device. Since the
> BAR1 address cannot be used to access the XPCS registers on Crater, use
> the smn functions.
> 
> Some of the ethernet add-in-cards have dual PHY but share a single MDIO
> line (between the ports). In such cases, link inconsistencies are
> noticed during the heavy traffic and during reboot stress tests. Using
> smn calls helps avoid such race conditions.
> 
> Suggested-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-common.h |   5 +
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c    |  57 ++++++++
>  drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |  33 ++++-
>  drivers/net/ethernet/amd/xgbe/xgbe-smn.h    | 139 ++++++++++++++++++++
>  drivers/net/ethernet/amd/xgbe/xgbe.h        |   7 +
>  5 files changed, 240 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h

Hi Raju,

This patch seems to be doing a lot.

* Add support for XGBE_RN_PCI_DEVICE_ID to xgbe_pci_probe()
* Add fallback implementations of amd_smn_(write|read)()
* Add XGBE_XPCS_ACCESS_V3 support to xgbe_(read|write)_mmd_regs()
* Add XGBE_XPCS_ACCESS_V3 support to xgbe_pci_probe()
* Add support for PCI_VDEVICE(AMD, 0x1641)

So a similar theme to my comment on patch 1/1,
I wonder if it could be broken up into separate patches.

I will also say that I am surprised to see this driver using
full licence preambles rather than SPDX headers. I assume that
is due to direction from legal. And if so, I accept that you may not
be in a position to change this. But my comment stands.

...

