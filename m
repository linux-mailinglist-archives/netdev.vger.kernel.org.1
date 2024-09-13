Return-Path: <netdev+bounces-128100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5208E97805B
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57126B220A1
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7B71DA10D;
	Fri, 13 Sep 2024 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw6LM+0i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C18187849;
	Fri, 13 Sep 2024 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231644; cv=none; b=aMc9cpN5otO54S5bp/Z15PA9DaieaSvUcgbGEUrtfpuZ6xuLQMMkjeSnDXLRLlbyV949gE0iic7H9mvSwzFR/KJzWZh7lMeT7zaPp22rkuRLbQgyCymnZzbb3wODnuYZAEbFlwkdYlyzfh0iWhS/VEkxVdu95q1PYmaa9d98DzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231644; c=relaxed/simple;
	bh=dytsdhDN/9pGMh6yc+9ZYSvQ7kBiCiIouvoAmRRF9L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8vv10whe36Rc+wsqwI+z80VUi/qpJtZHtspRPDaJ1w0/AMDJMs7N0AXYhx6eDGxGAftSTUpKVpsrkYkmzlpLCtCbAo+u5xmALt0j9CDQEx7jDb2g2vXj1iRmSRFVDcMMIYaalWFDoQRmwZPlsS0T5T84MMMH1bL9K2Uk7O5RSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw6LM+0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88653C4CECC;
	Fri, 13 Sep 2024 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726231644;
	bh=dytsdhDN/9pGMh6yc+9ZYSvQ7kBiCiIouvoAmRRF9L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bw6LM+0ifzfgUKnzzoWJ9wGowtFMPySe9V/kk/pH2orG208I5yCkg+8QQn4UXzK4l
	 PiP+0kZGdvVgVAho+jx5QCNh466EuDpBADn2Cd6+2FDmN+E9UofniIIR3wAuf4Xq3c
	 JNZmrvMXWoHiWCKFgnDot/rKvd5GoYLbgIfGiVvDkNqubNX3M92y0dLWQdeBGJyzQZ
	 LLUMlE7EeYxBxFa+GErwhi01hKXelQ+PEP6+4VFiQz8raHEQ4Su9M8l4G0MAEAWP/d
	 7HboiDDiSQ5fc35OTQeAQ5JB1PBtd75LPkZQRumUL9CrKvZ7tsfTINNFKkDvlMCZ8j
	 iut7YU+OBLVVw==
Date: Fri, 13 Sep 2024 13:47:20 +0100
From: Simon Horman <horms@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v1] memory-provider: disable building dmabuf mp
 on !CONFIG_PAGE_POOL
Message-ID: <20240913124720.GA572255@kernel.org>
References: <20240913060746.2574191-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913060746.2574191-1-almasrymina@google.com>

On Fri, Sep 13, 2024 at 06:07:45AM +0000, Mina Almasry wrote:
> When CONFIG_TRACEPOINTS=y but CONFIG_PAGE_POOL=n, we end up with this
> build failure that is reported by the 0-day bot:
> 
> ld: vmlinux.o: in function `mp_dmabuf_devmem_alloc_netmems':
> >> (.text+0xc37286): undefined reference to `__tracepoint_page_pool_state_hold'
> >> ld: (.text+0xc3729a): undefined reference to `__SCT__tp_func_page_pool_state_hold'
> >> ld: vmlinux.o:(__jump_table+0x10c48): undefined reference to `__tracepoint_page_pool_state_hold'
> >> ld: vmlinux.o:(.static_call_sites+0xb824): undefined reference to `__SCK__tp_func_page_pool_state_hold'
> 
> The root cause is that in this configuration, traces are enabled but the
> page_pool specific trace_page_pool_state_hold is not registered.
> 
> There is no reason to build the dmabuf memory provider when
> CONFIG_PAGE_POOL is not present, as it's really a provider to the
> page_pool.
> 
> In fact the whole NET_DEVMEM is RX path-only at the moment, so we can
> make the entire config dependent on the PAGE_POOL.
> 
> Note that this may need to be revisited after/while devmem TX is
> added,  as devmem TX likely does not need CONFIG_PAGE_POOL. For now this
> build fix is sufficient.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409131239.ysHQh4Tv-lkp@intel.com/
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

