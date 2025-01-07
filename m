Return-Path: <netdev+bounces-155848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F47A040BE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EEF91886D1B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BA41EBFE4;
	Tue,  7 Jan 2025 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwV+6TJg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943C1F5EA;
	Tue,  7 Jan 2025 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256196; cv=none; b=Hfv3I/J9Ar7YzxX2hCszsWRzgs5noqEXx4+lBqur41ovWOhwCocNgev/snKJt/WNNldpztnMcwNnDcHcrit31dkTJJq89JfkSfO66kNL6Gcw5Bzsd6m/EWJIWH8v0ftk0x39T1dK4hcFy7/YAbqdqlozGRbga1F+qP++pUc6z0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256196; c=relaxed/simple;
	bh=F0vo+yqr82MXK+Bq+lhmhLwnRvzNafAM1xPRuhI+YQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTBx+UOyaHg25HRw+PaXgymBVCrekQpnmjpWiWRb/rsnM7Juh4TStS/x4m/amWFoX4mnsxccYzDYdHFLv07DS9gfsGvb7bJgYu2mP9nug4HEDBMW/VnaGAo4s7z4WPhwMEFTx/i/Bn4teKYzw+w+8VUzbdO6jSgmFZfyXY/mezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwV+6TJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3F4C4CED6;
	Tue,  7 Jan 2025 13:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736256195;
	bh=F0vo+yqr82MXK+Bq+lhmhLwnRvzNafAM1xPRuhI+YQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bwV+6TJgnqx8Xiavvmd0/PBvgUQWFF5LKjbUCMCD2JbDtZSEEDBupEwFSgzZKTDGa
	 C5DsXZO8t1PACkI/ugQpy702izB8mpRuFrRd+Eijpnsqz+NzTNfCGQwber3oI0I8pk
	 wTQacQA5LjpAbiDu6s6g4+YBoZw4GF5BZvxYjYRZgaiSEN4Tew+RLHvZ2pThaYnFWi
	 t/ehDxwrMJmaDM/juYdJ6jhPg2rcMjsSWIs/zLROnBuiJk1Zf4nuvFqwA+IYgln3AQ
	 RuflzTYRrBJkxl4/9W8LW8SlrmuWYOmiZyLljcRklItv8p8DSn97Id2g7Dc2x/xruS
	 Nd5mfe/tt9lnQ==
Message-ID: <31bb8a3e-5a1c-4c94-8c33-c0dfd6d643fb@kernel.org>
Date: Tue, 7 Jan 2025 15:23:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add Support for
 Multicast filtering with VLAN in HSR mode
To: MD Danish Anwar <danishanwar@ti.com>, Jeongjun Park
 <aha310510@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Lukasz Majewski <lukma@denx.de>, Meghana Malladi <m-malladi@ti.com>,
 Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>
References: <20250103092033.1533374-1-danishanwar@ti.com>
 <20250103092033.1533374-4-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250103092033.1533374-4-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/01/2025 11:20, MD Danish Anwar wrote:
> Add multicast filtering support for VLAN interfaces in HSR offload mode
> for ICSSG driver.
> 
> The driver calls vlan_for_each() API on the hsr device's ndev to get the
> list of available vlans for the hsr device. The driver then sync mc addr of
> vlan interface with a locally mainatined list emac->vlan_mcast_list[vid]
> using __hw_addr_sync_multiple() API.
> 
> The driver then calls the sync / unsync callbacks.
> 
> In the sync / unsync call back, driver checks if the vdev's real dev is
> hsr device or not. If the real dev is hsr device, driver gets the per
> port device using hsr_get_port_ndev() and then driver passes appropriate
> vid to FDB helper functions.
> 
> This commit makes below changes in the hsr files.
> - Move enum hsr_port_type from net/hsr/hsr_main.h to include/linux/if_hsr.h
>   so that the enum can be accessed by drivers using hsr.
> - Create hsr_get_port_ndev() API that can be used to get the ndev
>   pointer to the slave port from ndev pointer to the hsr net device.
> - Export hsr_get_port_ndev() API so that the API can be accessed by
>   drivers using hsr.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 83 +++++++++++++++-----
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 +
>  include/linux/if_hsr.h                       | 18 +++++
>  net/hsr/hsr_device.c                         | 13 +++
>  net/hsr/hsr_main.h                           |  9 ---

Should we be splitting hsr core changes into separate patch first,
then followed by a patch with icssg driver changes?

>  5 files changed, 97 insertions(+), 28 deletions(-)

-- 
cheers,
-roger


