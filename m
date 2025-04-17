Return-Path: <netdev+bounces-183984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5D9A92E7D
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C1F7B4C00
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0167F221F0A;
	Thu, 17 Apr 2025 23:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDiVew5+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF1622154B
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934258; cv=none; b=sDN44Cv9oH1l+LbbxcxCVhLiYEusDWE10/h8GHy9o4R1hDfr75M0Hf4c4lW5fMjXQ1f5jFuGl5R/UzfGONXH/U56bQ3ncfWmZxbDT1bpx88sj8riwVGDeDavmjAJ7KGmMsdonBsT4hYC6qqPKVZKJF2K1+btRN/waHWOWiQ2puk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934258; c=relaxed/simple;
	bh=BExLuR7qTRAGtFVug4eENokXDY0tsVbwcLmy/5PR030=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K23ZUj5Bk+cPYxp6l+xtWhyxy82NnjVUoBcapKTb8jrh5WLvxemIpeFAxDoAS716L48qFPvDbYx4bcl6OBWNY0sYdNJOEYj6tjXOgHk87BFn32KrnRsohJvVF/kpOGwp5RWajd8tK3b4mcrU3IBEVerygcBMCZ1ciRRj9aBbq7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDiVew5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC93C4CEE4;
	Thu, 17 Apr 2025 23:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744934258;
	bh=BExLuR7qTRAGtFVug4eENokXDY0tsVbwcLmy/5PR030=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sDiVew5+d0ZobPvwfYoWXgLwx5OeQjzALFR+htS13Y6lzPUhcxqhBu6YhsgS+llFA
	 SemY6+VbBA9HGd6k+Vm936C21BtP4CnUU4rfQ1tlCdpbvTwBC2pas6RJKmHesClsNa
	 NtMLu9rwqZGdIWK6q+O9a/DOic9CPxiVFC3zPgHuZW99XDjFKTP+W4swpYDEMwJ3gS
	 ijmBSLb57roMcC6NT6kwpTA5LmCUYOeDTI/U6zeWA0egpTCY4P4S9NoBq2uGAHzzxO
	 sxKSX0o3sFT3j66hsyd72gEOWYJy33eH4IyS2EY0DQFn6MEG+vnXguydgoVZ2GL5RT
	 wOQ1mKZfuDn2Q==
Date: Thu, 17 Apr 2025 16:57:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 dlemoal@kernel.org, jdamato@fastly.com, saikrishnag@marvell.com,
 vadim.fedorenko@linux.dev, przemyslaw.kitszel@intel.com,
 ecree.xilinx@gmail.com, rmk+kernel@armlinux.org.uk,
 mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 1/2] net: txgbe: Support to set UDP tunnel
 port
Message-ID: <20250417165736.15d212ec@kernel.org>
In-Reply-To: <20250417080328.426554-2-jiawenwu@trustnetic.com>
References: <20250417080328.426554-1-jiawenwu@trustnetic.com>
	<20250417080328.426554-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 16:03:27 +0800 Jiawen Wu wrote:
> @@ -392,6 +393,8 @@ static int txgbe_open(struct net_device *netdev)
                                 ^^^^^^^^^^
>  
>  	txgbe_up_complete(wx);
>  
> +	udp_tunnel_nic_reset_ntf(netdev);
        ^^^^^^^^^^^^^^^^^^^^^^^^
>  	return 0;

> +	.flags		= UDP_TUNNEL_NIC_INFO_OPEN_ONLY,

Documentation says:

        /* Device only supports offloads when it's open, all ports
         * will be removed before close and re-added after open.
         */
        UDP_TUNNEL_NIC_INFO_OPEN_ONLY   = BIT(1),

Are you sure you have to explicitly reset?

