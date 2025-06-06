Return-Path: <netdev+bounces-195441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 209D0AD02E4
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27C5175A9D
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC2C288C3D;
	Fri,  6 Jun 2025 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3cq+q9T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB4288C21
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749215628; cv=none; b=M9btNPRF7geFO6oNGicHqmyTWGbpaEFkXxg0blq8UJG9PsU35U9o4QDrWPwZicbWyDQz7qt+oRKnC+/gytO4uhZnWwg6ksmIvd2C2LGxiAbOkdOwvN7IIBL3aLAEB/DPS/KG2Ce5guU+9mEEYHws05JdlREyoNZ1129vhR5zEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749215628; c=relaxed/simple;
	bh=7BK4cAFFZwhiO806eROooZ9YTqB5zUfT9rGu7osftt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXpuZ/4zpgtcbXJqh5ICl8/amo1aDd0umOde0Vj8OVFhXfepCMfK0YFxYCj8HeHdKjddFlS/Gfm/N/VmuqWoHwNUjbcQ4IMb94JyWDHxw9Q3KdEZj1YwxJ0TrbVDK7U/S8HQeHOasFCtURN5GBBmmTOrQbPs5MmNz+PmN1KnYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3cq+q9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E18C4CEEB;
	Fri,  6 Jun 2025 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749215628;
	bh=7BK4cAFFZwhiO806eROooZ9YTqB5zUfT9rGu7osftt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3cq+q9THjl29nfM/uFJwRTwAPwwffIHJW1xUR8aTD4dNdQDYV1MoCZzW8HF6kekz
	 n/K4lQhjjg01fKhSbnOtwx8Ybh0O00Tn76mLPF1ayA93F8R0rgcC57U6AYYBu3XAqq
	 ay3DgWAcMKm0LYa/OuMbZCG0RO5m36dXHcpAlBU1ljYOuYwrd6ORFyWcGvp/KnwxVK
	 yu8dTrMsBI5wmdI+YGGCyzS8tyLaLDv5pCoPRZupn/OgM09y5G/4FG7lYWA7GI0pU8
	 R/5PC8umPQiYDEVSboXNhAW2/mcNvF1MnNsqahsltskyiInGmMI1N5yTw/Pa3t8if3
	 va4ZOHw12GjNw==
Date: Fri, 6 Jun 2025 14:13:42 +0100
From: Simon Horman <horms@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com, jacky@yunsilicon.com,
	parthiban.veerasooran@microchip.com, masahiroy@kernel.org,
	kalesh-anakkur.purayil@broadcom.com, geert+renesas@glider.be,
	geert@linux-m68k.org
Subject: Re: [PATCH net-next v12 00/14] xsc: ADD Yunsilicon XSC Ethernet
 Driver
Message-ID: <20250606131342.GG120308@horms.kernel.org>
References: <20250606100132.3272115-1-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606100132.3272115-1-tianx@yunsilicon.com>

On Fri, Jun 06, 2025 at 06:02:15PM +0800, Xin Tian wrote:
> The patch series adds the xsc driver, which will support the YunSilicon
> MS/MC/MV series of network cards. These network cards offer support for
> high-speed Ethernet and RDMA networking, with speeds of up to 200Gbps.
> 
> The Ethernet functionality is implemented by two modules. One is a
> PCI driver(xsc_pci), which provides PCIe configuration,
> CMDQ service (communication with firmware), interrupt handling,
> hardware resource management, and other services, while offering
> common interfaces for Ethernet and future InfiniBand drivers to
> utilize hardware resources. The other is an Ethernet driver(xsc_eth),
> which handles Ethernet interface configuration and data
> transmission/reception.
> 
> - Patches 1-7 implement the PCI driver
> - Patches 8-14 implement the Ethernet driver
> 
> This submission is the first phase, which includes the PF-based Ethernet
> transmit and receive functionality. Once this is merged, we will submit
> additional patches to implement support for other features, such as SR-IOV,
> ethtool support, and a new RDMA driver.
> 
> Changes v11->v12
> Link to v11: https://lore.kernel.org/netdev/20250423103923.2513425-1-tianx@yunsilicon.com/
> - patch01: modify NET_VENDOR_YUNSILICON depends on: "ARM64 || X86_64" -> "64BIT" (Jakub)
> - patch12: TSO byte stats include headers added after hardware segmentation (Jakub)

Hi Xin Tian,

Thanks for the updates. Unfortunately the timing of this submission is
not ideal.

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.

-- 
pw-bot: defer

