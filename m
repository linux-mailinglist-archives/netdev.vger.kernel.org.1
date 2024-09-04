Return-Path: <netdev+bounces-125208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BC696C42D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 18:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8961F24408
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49EB1DFE14;
	Wed,  4 Sep 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oloAsxZ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCB24205D;
	Wed,  4 Sep 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467707; cv=none; b=C8h0zv9Ldk3nhdIK1ur1+k75pghB9Nb+PuHQxpll8e2kFXveY8AoYiIqmJGD94TShS3OwM/MF7uV2dI/RRYaQCJceCT0dBYM0RcBrgHcvntmwxT5JyL6cAFbDh4BfLubklDKXb7Ct1zOWBnxidJawbYRO9kAAZSeDeoGa2BIap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467707; c=relaxed/simple;
	bh=+XpmBufS4Qg2AxW/ellAV9Ef4sdz+dYiyI0u6X+EPRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1r8HJdr1ndPpTc2Q+6heOA82Cj6R1112RbyEsYx9RsZPTfFqgtt+S8rX5fgkfPQboyd5nP+BcDGFjwpBl6zpmEhs+rhujdPHw1r1z/L0n+pBnhbdH7J+ETU0U6ctipFfO/kfm9Sa9V3LfK0WazLl7csCwlS8pV4zNA/5t+uhpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oloAsxZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE3CC4CEC2;
	Wed,  4 Sep 2024 16:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725467707;
	bh=+XpmBufS4Qg2AxW/ellAV9Ef4sdz+dYiyI0u6X+EPRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oloAsxZ3IWRPBByz9255WXPOb4W/lObd1foG47n47g3Jl9dnF03D0CkBnjx1zJrlk
	 wFVtOGFH1ejRBg1hitT0fujgsHk8u2bTCgLvk+BB//ZeTfEI2jjhsFswGSdwtokgIR
	 110fH1tZ1ihg2TtWj1sF7QyPSwVIAroTgcAc7yVF53R8kqXoFKVtnOLqFzOIq69vYy
	 5jQULZ7yURAP4hxFbnJNFnjebNJraS/t8e+0hDqJ2p5yEe7J+KU1rilkn6XhbTbcYy
	 RCL1fy8B838hXTZsZhAhMNslqstAHcLR5qVhxKeiMZgZjTo/Id99+r58r3u2M5auOD
	 4fXQfvspHEg+g==
Date: Wed, 4 Sep 2024 17:35:03 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/2] net: xilinx: axienet: Enable adaptive IRQ
 coalescing with DIM
Message-ID: <20240904163503.GA1722938@kernel.org>
References: <20240903192524.4158713-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903192524.4158713-1-sean.anderson@linux.dev>

On Tue, Sep 03, 2024 at 03:25:22PM -0400, Sean Anderson wrote:
> To improve performance without sacrificing latency under low load,
> enable DIM. While I appreciate not having to write the library myself, I
> do think there are many unusual aspects to DIM, as detailed in the last
> patch.
> 
> This series depends on [1].
> 
> [1] https://lore.kernel.org/netdev/20240903180059.4134461-1-sean.anderson@linux.dev/

Hi Sean,

Unfortunately the CI doesn't understand dependencies,
and so it is unable to apply this patchset :(

I would suggest bundling patches for the same driver for net-next
in a single patchset. And in any case, only having one active
at any given time.

-- 
pw-bot: cr

