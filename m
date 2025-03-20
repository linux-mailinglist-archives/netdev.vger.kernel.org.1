Return-Path: <netdev+bounces-176477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBDCA6A7A2
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C544D48752B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D37223304;
	Thu, 20 Mar 2025 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVhp6o0E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3001C222592
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478654; cv=none; b=dIQSqhPv5fM0c4kePGR1ja8k7f5VDs0CZnDT8XYNKO/Vyasr9BDd6iyBO035o7XG+A9Lc4gNLpkMob5gzBCNOI4z7Iyvfu0/9DP3hnxMhMG67lbXRKga0DXP5svOuqenTVubdmPXT30/2uiqfp++pdsMhq+Y1uv3+AHm8SkMYwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478654; c=relaxed/simple;
	bh=4M1A4kLYeQa3yc4kDRW7oNsbvWt+zlo0I9WGtpBCr3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAJF5ixhehdvFucVaYi0S9OZ1qbUUBtq9xpyW3ktfPYfzv9nnQxl1jG/uJ3nid3tgUlgO/TdYSX60wBK+VYZP6zuGM8q/2Sv+u7M4NI8uJhIgeWZ0vHG5tD9968KkASPVnpPBn+HdnD2N6UeD5vZYjmyw9vJVOD0wXcHVhrjvks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVhp6o0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED49C4CEDD;
	Thu, 20 Mar 2025 13:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742478653;
	bh=4M1A4kLYeQa3yc4kDRW7oNsbvWt+zlo0I9WGtpBCr3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVhp6o0EHniB/tlYN0pPe0QKgd8ylw1LiGdDd9XK5xqbvwRSE3M+oVtU6xXh6cWG7
	 IPmM7PewN9y/aCS3sf0sMKg4EGDrqnlpa02nZltOL17h/dAb6RmufQ3EkWhnZGN85Q
	 /mLf50bDhOhIFXxxb85pZk2PE6hqlCjEqvJifp6m5klftiUVRwLXvHWI8K7S+wgTxD
	 gq/80fUDRfNEtjCgo5qmucCb0DNe6HDNg4x2PTbm8Rds39BrpTM6gIRi6f0mYdMIYM
	 jjcSb8+UuSM+NPz6/4kKzv0LQE3hRiFWEHeuai6tg+cDiJiQv0eHtsrL6UbZxemwie
	 Dp5tva3fNTJuA==
Date: Thu, 20 Mar 2025 13:50:49 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
	donald.hunter@gmail.com, parav@nvidia.com
Subject: Re: [PATCH net-next 2/4] net/mlx5: Expose serial numbers in devlink
 info
Message-ID: <20250320135049.GW280585@kernel.org>
References: <20250318153627.95030-1-jiri@resnulli.us>
 <20250318153627.95030-3-jiri@resnulli.us>
 <20250318173858.GS688833@kernel.org>
 <xtt6lkxht2ewaa7wncf2pq6rkgp7x5deoszfvh3hswrerqzfof@hvlgtcws6qx5>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xtt6lkxht2ewaa7wncf2pq6rkgp7x5deoszfvh3hswrerqzfof@hvlgtcws6qx5>

On Wed, Mar 19, 2025 at 12:39:59PM +0100, Jiri Pirko wrote:
> Tue, Mar 18, 2025 at 06:38:58PM +0100, horms@kernel.org wrote:
> >On Tue, Mar 18, 2025 at 04:36:25PM +0100, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Devlink info allows to expose serial number and board serial number
> >> Get the values from PCI VPD and expose it.
> >> 
> >> $ devlink dev info
> >> pci/0000:08:00.0:
> >>   driver mlx5_core
> >>   serial_number e4397f872caeed218000846daa7d2f49
> >>   board.serial_number MT2314XZ00YA
> >
> >Hi Jiri,
> >
> >I'm sorry if this is is somehow obvious, but what is
> >the difference between the serial number and board serial number
> >(yes, I do see that they are different numbers :)
> 
> Quoting Documentation/networking/devlink/devlink-info.rst:
> 
>    * - ``serial_number``
>      - Serial number of the device.
> 
>        This is usually the serial number of the ASIC, also often available
>        in PCI config space of the device in the *Device Serial Number*
>        capability.
> 
>        The serial number should be unique per physical device.
>        Sometimes the serial number of the device is only 48 bits long (the
>        length of the Ethernet MAC address), and since PCI DSN is 64 bits long
>        devices pad or encode additional information into the serial number.
>        One example is adding port ID or PCI interface ID in the extra two bytes.
>        Drivers should make sure to strip or normalize any such padding
>        or interface ID, and report only the part of the serial number
>        which uniquely identifies the hardware. In other words serial number
>        reported for two ports of the same device or on two hosts of
>        a multi-host device should be identical.
> 
>    * - ``board.serial_number``
>      - Board serial number of the device.
> 
>        This is usually the serial number of the board, often available in
>        PCI *Vital Product Data*.

Thanks, I should have known that :)

