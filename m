Return-Path: <netdev+bounces-167049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E43FA388FA
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F8116686E
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6667222489E;
	Mon, 17 Feb 2025 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6ZT7Owl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404FB2236FE
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809028; cv=none; b=rYZb9DHTMWi3EIYTjMFpYpD3Mz9dHtzCOmyL3epH1keKL9/wOqj5m0uP3CUPbtfXDrNt/Pw7Os7s73gNH5dBX4vPusewc4gYqiqFUnM9TY7Jf49Q2DGLL34uH24rESWYDX86PfustuCV2UuvAZscM7/y6kpE0mfaeuFHDweDwzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809028; c=relaxed/simple;
	bh=dbN+k2q6EShMVUAh4Ch1jkSdAxdn32s4LBsHWf0F1dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nih1keyzdRu50KkRTGAJXK7fYgrIQod7MC+WN79gS7ZAXnDE3n7Gu3FEOIgSm2fypGeSRDcxLP9OzRmPNGlCFB9Ry2Qv+1u6ktE9tjEF8vkWhE5ONG2Hz1iVj/CEYLO5KcCr5SXoDqN5Qhon5vBjEH08RFE4V5ZNkifx3g/mfHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6ZT7Owl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDFCC4CED1;
	Mon, 17 Feb 2025 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739809027;
	bh=dbN+k2q6EShMVUAh4Ch1jkSdAxdn32s4LBsHWf0F1dM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6ZT7Owl77PCw1wceouhGsK6E/A95VPA5IbW0E/cpdtIX5vm6RxC8p5246AACe7Ay
	 wSzwHzHULZEk3fQ3/8PaYZBuxui6x8tx+dGLcrFZMM327nJY6Gin7rkzh3WGWMdOBQ
	 OkE+jvLxVEeN+fYwT/9WQGX5qTVUXk9qAbswIopCdfam0PkYc3xwiiZ2acKm5g2ETw
	 P6MEkkh0+mVdI+78Bi0AxO3ShmlGRytI3Z1i+L8Dr5cIBnadqRX79vvpISRbc24tok
	 JNZL4R//bAfbNoie4gko94pI3fHsUmuQhNREMOoVCKHyPnsgGd9Env2V2zRKavsQga
	 kiroYxa3LSsvQ==
Date: Mon, 17 Feb 2025 16:17:03 +0000
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	decot@google.com, willemb@google.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, madhu.chittim@intel.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-net v2] idpf: check error for register_netdev() on
 init
Message-ID: <20250217161703.GO1615191@kernel.org>
References: <20250214171816.30562-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214171816.30562-1-emil.s.tantilov@intel.com>

On Fri, Feb 14, 2025 at 09:18:16AM -0800, Emil Tantilov wrote:
> Current init logic ignores the error code from register_netdev(),
> which will cause WARN_ON() on attempt to unregister it, if there was one,
> and there is no info for the user that the creation of the netdev failed.
> 
> WARNING: CPU: 89 PID: 6902 at net/core/dev.c:11512 unregister_netdevice_many_notify+0x211/0x1a10
> ...
> [ 3707.563641]  unregister_netdev+0x1c/0x30
> [ 3707.563656]  idpf_vport_dealloc+0x5cf/0xce0 [idpf]
> [ 3707.563684]  idpf_deinit_task+0xef/0x160 [idpf]
> [ 3707.563712]  idpf_vc_core_deinit+0x84/0x320 [idpf]
> [ 3707.563739]  idpf_remove+0xbf/0x780 [idpf]
> [ 3707.563769]  pci_device_remove+0xab/0x1e0
> [ 3707.563786]  device_release_driver_internal+0x371/0x530
> [ 3707.563803]  driver_detach+0xbf/0x180
> [ 3707.563816]  bus_remove_driver+0x11b/0x2a0
> [ 3707.563829]  pci_unregister_driver+0x2a/0x250
> 
> Introduce an error check and log the vport number and error code.
> On removal make sure to check VPORT_REG_NETDEV flag prior to calling
> unregister and free on the netdev.
> 
> Add local variables for idx, vport_config and netdev for readability.
> 
> Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
> Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
> Changelog:
> v2:
> - Refactored a bit to avoid >80 char lines.
> - Changed the netdev and flag check to allow for early continue in the
>   max_vports loop, which also helps to reduce the identation.
> 
> v1:
> https://lore.kernel.org/intel-wired-lan/20250211023851.21090-1-emil.s.tantilov@intel.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


