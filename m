Return-Path: <netdev+bounces-241188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E97C810FA
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 15:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C2024E5EA7
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 14:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CD427B34E;
	Mon, 24 Nov 2025 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAmZMGER"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBBD27AC5C;
	Mon, 24 Nov 2025 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994772; cv=none; b=bn4n+OIirl5a6gdA1JcKEGFrPsJNvY4JwjQer4iOJ9qAdj5EWx+TkhXmd8TpZQXWiBJ/Hr/qCz/g2dRkx+9HemoFwL2bNb+l/dbNfqVFuGVc3tKELWuhndP9c9DNUufe57XrHOSwdC/u6N8ZIpKWuKXHkZTPzryeWKsd4B9kepM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994772; c=relaxed/simple;
	bh=oGBz3mP6hQTvEagkpjDr8Yl3ZUBAs7hGNqaLq5wkB+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWR5mJjWHrXNiC0MnUnytQRGq1TaXvNT17SzahMiyKx+0ga8RZi4crP4JXI6T9u0F/sVYiUh8C/iPMbd5uFXO9n7qBEqutghJ/gtfKQw95wDkykAGFoR5KI8ZmrRcJ0bCOmXbjE97OCIczp0PfTwBimnQMA084QfOid8/mBqxqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAmZMGER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4456C4CEF1;
	Mon, 24 Nov 2025 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763994771;
	bh=oGBz3mP6hQTvEagkpjDr8Yl3ZUBAs7hGNqaLq5wkB+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eAmZMGERhHylj4Y+EN0Pghdc/JIKj+r0/WYCEFk42ErRgRYB89p6nguA9y9Ipd+1A
	 i8MeClDX2KbWPseLmkNxgWSREf8tiKiNhIIWga/0DfpSyHFaTVAAj1cEoUAuElKi2J
	 2ac0b0hXaY0VlyVQeOnngTGnHsZtYTvaoCBfkHtbZPr3ds3srHAvhFYeMiODi8Ez13
	 akyACOWoHHe/1uTp9soUsGLPIPmE0GFLdjyUoTeJURZmYBF4fwmyXqiU75sTa5dCre
	 zovj/z3dOV2sBN76rtSuXTGedN/+HEgACrPmAnwiwxOQD6VFVz//nk2ZlVsR0+atr2
	 VpJ9nqvRco1bA==
Date: Mon, 24 Nov 2025 14:32:46 +0000
From: Simon Horman <horms@kernel.org>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Carol Soto <csoto@nvidia.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Dmitry Bogdanov <dbogdanov@marvell.com>,
	Mark Starovoytov <mstarovo@pm.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: aquantia: Add missing descriptor cache
 invalidation on ATL2
Message-ID: <aSRsjhB3vbGdUyg0@horms.kernel.org>
References: <20251120041537.62184-1-kaihengf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120041537.62184-1-kaihengf@nvidia.com>

On Thu, Nov 20, 2025 at 12:15:33PM +0800, Kai-Heng Feng wrote:
> ATL2 hardware was missing descriptor cache invalidation in hw_stop(),
> causing SMMU translation faults during device shutdown and module removal:
> [   70.355743] arm-smmu-v3 arm-smmu-v3.5.auto: event 0x10 received:
> [   70.361893] arm-smmu-v3 arm-smmu-v3.5.auto:  0x0002060000000010
> [   70.367948] arm-smmu-v3 arm-smmu-v3.5.auto:  0x0000020000000000
> [   70.374002] arm-smmu-v3 arm-smmu-v3.5.auto:  0x00000000ff9bc000
> [   70.380055] arm-smmu-v3 arm-smmu-v3.5.auto:  0x0000000000000000
> [   70.386109] arm-smmu-v3 arm-smmu-v3.5.auto: event: F_TRANSLATION client: 0001:06:00.0 sid: 0x20600 ssid: 0x0 iova: 0xff9bc000 ipa: 0x0
> [   70.398531] arm-smmu-v3 arm-smmu-v3.5.auto: unpriv data write s1 "Input address caused fault" stag: 0x0
> 
> Commit 7a1bb49461b1 ("net: aquantia: fix potential IOMMU fault after
> driver unbind") and commit ed4d81c4b3f2 ("net: aquantia: when cleaning
> hw cache it should be toggled") fixed cache invalidation for ATL B0, but
> ATL2 was left with only interrupt disabling. This allowed hardware to
> write to cached descriptors after DMA memory was unmapped, triggering
> SMMU faults. Once cache invalidation is applied to ATL2, the translation
> fault can't be observed anymore.
> 
> Add shared aq_hw_invalidate_descriptor_cache() helper and use it in both
> ATL B0 and ATL2 hw_stop() implementations for consistent behavior.
> 
> Fixes: e54dcf4bba3e ("net: atlantic: basic A2 init/deinit hw_ops")
> Tested-by: Carol Soto <csoto@nvidia.com>
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>

Thanks for addressing my review of v1.

Reviewed-by: Simon Horman <horms@kernel.org>

