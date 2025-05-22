Return-Path: <netdev+bounces-192744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21E6AC1015
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84B617A8EC
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37A6299952;
	Thu, 22 May 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBx2kQX/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA750539A;
	Thu, 22 May 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747928377; cv=none; b=mu0+ndphmQUqj3nKoDrXShWP2MnDtaGnA4Ll/8a9DuuDW9QAlGzosIHd1WVBmlzTbjN5VyNMRO07k7mRLYL7UeeRWDVdbf0FJyp2mdoy4kUBttxDUnjPzLg42POi08TSsTfHJGWNxqlSRb138GqQ3fAqjoK8lrg/1UdaZfQPCOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747928377; c=relaxed/simple;
	bh=m48VDzvZxngsVThl7qEq+eGRhpEyzPfbTWTjwFWJ7sY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzPU3/5gpfX3CNKWxcm1Yjzf6tswFgnweSg5LiDf7fLLNiaHgLHYoIZ9ff+/PxXbmCe8TUzxa8jQxtMZGqd/INx5cZD5JZ3rIQ53Lqw34L/+jpK1iJZwkfvpWC4cjgpL3ivT6iEOqMI4T/PPjLCj2+Qf4ZwwF3z8MClJJ7eznu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBx2kQX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC80C4CEE4;
	Thu, 22 May 2025 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747928377;
	bh=m48VDzvZxngsVThl7qEq+eGRhpEyzPfbTWTjwFWJ7sY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YBx2kQX/Ge7poDRWNwFgzb8zQEJ1vnCJp0YhI5Aft6QT0MVMMpUC4j6KIAgzxXCPy
	 /uFWEkc3dorlKv41FkxtffkdgVaSrrPaAw7R8TSaA8Yo3liQDpH7/JCoQPqb3DPKaS
	 7n+CJKEuvpXKI4uuxa3Aj7zOihp8VIZElK83Vn6Fm/eO0dzEMkQhth4+apkjqgqYOu
	 +7yKjVGFANkH65TUasCoqo+qRjRioKqbZ96vvg0X8Cykvm0pCrBBKU9HrNzLkO38GQ
	 1Pe/igHx5cpvFecgWROV8Wh0oD+MvCGtUs/eZ5yS/F//9ISHkeuXrHSB+uHG0l4u2w
	 XkQTbNP1U0+kA==
Date: Thu, 22 May 2025 08:39:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dlink: add Kconfig option for RMON
 registers
Message-ID: <20250522083936.6ad10f45@kernel.org>
In-Reply-To: <aC7CR1ZTaJ7m_Dna@mythos-cloud>
References: <20250519214046.47856-2-yyyynoom@gmail.com>
	<20250519165758.58157a0b@kernel.org>
	<aC7CR1ZTaJ7m_Dna@mythos-cloud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 May 2025 15:20:55 +0900 Moon Yeounsu wrote:
> On Mon, May 19, 2025 at 04:57:58PM -0700, Jakub Kicinski wrote:
> > On Tue, 20 May 2025 06:40:45 +0900 Moon Yeounsu wrote:
> > Kconfig is not a great choice for chip specific logic.
> > You should check some sort of chip ID register or PCI ID
> > to match the chip version at runtime. Most users don't compile
> > their own kernels.  
> 
> Just to confirm. are you suggesting that RMON MMIO should be enabled
> only on hardware known to support it correctly, instaed of exposing it
> via Kconfig?
> 
> Then, I'll drop the Kconfig option and enable RMON MMIO only for
> known-good devices via a runtime check. Currently, that's limited to
> DGE-550T (`0x4000`) with revision A3 (`0x0c`).
> 
> The `dw32(RmonStatMask, 0x0007ffff);` line will also be skipped
> accordingly.

Yes, sounds like that's along the lines of my suggestion.

