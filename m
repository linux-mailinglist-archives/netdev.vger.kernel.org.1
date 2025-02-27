Return-Path: <netdev+bounces-170357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF264A484F4
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1660D18921D7
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94E514F9F4;
	Thu, 27 Feb 2025 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbwZe4ej"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F11A9B29
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673398; cv=none; b=nbB/rh0YjZtaWNypS5lQ2zvww7AXjS9pWUalkpLNXUzA0EeTuVEvhE/MUnMXUekbhm0p1x63XxnkQ5pbfGgztYsKonfnZCEfC+AXjroBW8S/Gl5vBjRnFAMpPcR/DfS7pxaRHqoY9DxiAR3mPSONLxUNjdDC6EfkGr5Dvdy2f8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673398; c=relaxed/simple;
	bh=FyT0kqJbEPCvtf7m4BO+xl6iAo8J2v/GA5IY4v/8OAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpK602HPh9Oe/DoSumUR2aPNQQUadBIR7ltL36DLEeuCLsD9hEQD4Lb5WRlkNclN4gcKq0NmLKRU7IK6xQwXj6cYwN/C1Ovh2d2Z0W7tTh8jZQjETeGBS7g8mLmHaxS8aRjy6ICxzexP1VC1ng5e0BLOVx7OkKmjZEoRwymYvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbwZe4ej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF58C4CEDD;
	Thu, 27 Feb 2025 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740673398;
	bh=FyT0kqJbEPCvtf7m4BO+xl6iAo8J2v/GA5IY4v/8OAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WbwZe4eju/JVxAeqOBx+qZlmsC+Fd85DnhWxTdrtreyh8Gp2K/yBEFvWGmcl2MZcX
	 7V3Hl8YW+ZazF+USvVLm0adhAZ+/eO9SZ9mG36ep6AljYdSb8rW6dnhjVndd/liPXx
	 cHYerNls59iavnXNUMLqCWlKPS6z7AOtmW/9mF/JoJEw19AZz6X8JVK7dzyLat/8N+
	 duGtMTUxhBPYZYctXzdBt2R2xmQUuSYALi4uzGlsfXK8bKCM99LJphiG+kEfogHF4x
	 jLdYig27PBiBQ2rc0UjddYIUf2KSXfO2mriKZF7nugl6SCPeDTuO0QhN5vVgxAh2Ul
	 oVjR2XkT3oB7Q==
Date: Thu, 27 Feb 2025 08:23:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Xin Tian" <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>,
 <weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <horms@kernel.org>,
 <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>
Subject: Re: [PATCH net-next v6 00/14] xsc: ADD Yunsilicon XSC Ethernet
 Driver
Message-ID: <20250227082316.5bd669a3@kernel.org>
In-Reply-To: <20250227082558.151093-1-tianx@yunsilicon.com>
References: <20250227082558.151093-1-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 16:26:36 +0800 Xin Tian wrote:
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

drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c:525:14-15: WARNING: *_pool_zalloc should be used for mailbox -> buf, instead of *_pool_alloc/memset
drivers/net/ethernet/yunsilicon/xsc/pci/hw.c:40:17-24: WARNING: vzalloc should be used for board_info [ i ], instead of vmalloc/memset
drivers/net/ethernet/yunsilicon/xsc/net/main.c:1946:21-22: WARNING kvmalloc is used to allocate this memory at line 1933
drivers/net/ethernet/yunsilicon/xsc/net/main.c:1968:22-28: ERROR: adapter is NULL but dereferenced.
drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c:284:14-21: WARNING: Unsigned expression compared with zero: num_dma < 0
-- 
pw-bot: cr

