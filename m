Return-Path: <netdev+bounces-97742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA32D8CCF9A
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C32D1F210CB
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBB113CFB2;
	Thu, 23 May 2024 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLouKiVK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9813CFA3
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457672; cv=none; b=S2ojilXL9QJ0S74RJHT4PbYnIVjpYPC7MBnNjbtgHd13XtImKjS2+OWsX8GvalyWAoeTLRd8bvyhe+6I4MIUq1a37oKcWprZ9ubJ2hRqR9pWRq0n9dWSEo9YhFaETgCGsIYUTWseLlORf+Iy8zpIvcDuCzekt7BhA8QRHUvrzxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457672; c=relaxed/simple;
	bh=iIYBMgpB87SJDbBagkTXcpjP1a1F52CLjk0kcqZGwYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZ+SDOvewJ3dguo7ba6wHcTluexel6LUEq6oKJ4/VvXBQ9SODleQezIgrPn1LST7J87YwjyWUazNRUz3CutelchiLRDcSkLYVICB4w2gj37YRoP/VbOJHJ0fE0BMT1NO7RQowvtGs9uoHnrB2eAUG8k78Z44MC5rKup46kEEaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLouKiVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C3BC2BD10;
	Thu, 23 May 2024 09:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716457672;
	bh=iIYBMgpB87SJDbBagkTXcpjP1a1F52CLjk0kcqZGwYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLouKiVKs2y0QOhxjKPqUCFg39OCKlKPyuuOXEhg9oj+IyFrcdlecV4RVJq9PfijU
	 PYyDnedE+r6NjS2qlMxoO/9uF1kqjzkFbUpw81Z7psLhg5IXbQOnW6JLFT6iBPxDd6
	 Sx4t3ZnOdTqRLOfUsyaOE8djizu9NikeHz7YPy7LhdmVqHHzxJ3k22lVO22090NnGx
	 xTQJZkJ0h1zWKywwUAVLpSU9Pcre+NnpTPqOI/CwIHRDyVSmwl2mF3yIMPHc/TMbw3
	 lEav3y2ku2PcIVGLrWw5ljzFUFkREdUqXROJSfU2MHZxPFJnpnibKDPGBYS5U+H6tb
	 dQ2gLCGMSFOmA==
Date: Thu, 23 May 2024 10:47:47 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net 4/8] net/mlx5: Use mlx5_ipsec_rx_status_destroy to
 correctly delete status rules
Message-ID: <20240523094747.GG883722@kernel.org>
References: <20240522192659.840796-1-tariqt@nvidia.com>
 <20240522192659.840796-5-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522192659.840796-5-tariqt@nvidia.com>

On Wed, May 22, 2024 at 10:26:55PM +0300, Tariq Toukan wrote:
> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> 
> rx_create no longer allocates a modify_hdr instance that needs to be
> cleaned up. The mlx5_modify_header_dealloc call will lead to a NULL pointer
> dereference. A leak in the rules also previously occurred since there are
> now two rules populated related to status.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 109907067 P4D 109907067 PUD 116890067 PMD 0
>   Oops: 0000 [#1] SMP
>   CPU: 1 PID: 484 Comm: ip Not tainted 6.9.0-rc2-rrameshbabu+ #254
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.16.3-1-1 04/01/2014
>   RIP: 0010:mlx5_modify_header_dealloc+0xd/0x70
>   <snip>
>   Call Trace:
>    <TASK>
>    ? show_regs+0x60/0x70
>    ? __die+0x24/0x70
>    ? page_fault_oops+0x15f/0x430
>    ? free_to_partial_list.constprop.0+0x79/0x150
>    ? do_user_addr_fault+0x2c9/0x5c0
>    ? exc_page_fault+0x63/0x110
>    ? asm_exc_page_fault+0x27/0x30
>    ? mlx5_modify_header_dealloc+0xd/0x70
>    rx_create+0x374/0x590
>    rx_add_rule+0x3ad/0x500
>    ? rx_add_rule+0x3ad/0x500
>    ? mlx5_cmd_exec+0x2c/0x40
>    ? mlx5_create_ipsec_obj+0xd6/0x200
>    mlx5e_accel_ipsec_fs_add_rule+0x31/0xf0
>    mlx5e_xfrm_add_state+0x426/0xc00
>   <snip>
> 
> Fixes: 94af50c0a9bb ("net/mlx5e: Unify esw and normal IPsec status table creation/destruction")
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


