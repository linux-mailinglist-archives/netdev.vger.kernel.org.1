Return-Path: <netdev+bounces-42198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7BC7CDA30
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 13:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6775E1C20C8C
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C665F1A737;
	Wed, 18 Oct 2023 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gac/avRU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1315AFE
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46762C433C8;
	Wed, 18 Oct 2023 11:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697628201;
	bh=zGcIF5GoO6x/N42YRaVgRPAAKcpwa7a1gHrol4w9fQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gac/avRUdZwcnCZoRKGKSyxANSdAgc6KT9VYo65AEjn+rV0rD6q7CL9HtwoaWcAD9
	 EFSXvxP5fAFdVmZNI+T3Jubza1NL3effDB4aV+gay2HtmvdkR3ByYxaDQf4SUd6nv7
	 Evt8kzawXvYU9FCx61KbYpuGUBmy0qMuHGoRgbgGrmu6/G/BgkoYoPJNVCneikD7I6
	 hbx4HKB2/6kLyYmXjoSDe9reOsuJCAr6mtcxCKSI96QmqfeTwifHl6Vsp39Ro75HUV
	 3sGByN5FgCVHLn+sdlWNCrvrnDJxJsY29udbTtAo2gtxaKOAtYnjnU89PP1mhg9WDb
	 6OuXwLR6q56pQ==
Date: Wed, 18 Oct 2023 13:23:17 +0200
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH] net: wangxun: remove redundant kernel log
Message-ID: <20231018112317.GJ1940501@kernel.org>
References: <20231017100635.154967-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017100635.154967-1-jiawenwu@trustnetic.com>

On Tue, Oct 17, 2023 at 06:06:35PM +0800, Jiawen Wu wrote:
> Since PBA info can be read from lspci, delete txgbe_read_pba_string()
> and the prints. In addition, delete the redundant MAC address printing.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   5 -
>  drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c | 108 ------------------
>  drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h |   1 -
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   8 --
>  .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   6 -
>  5 files changed, 128 deletions(-)

Thanks, this is a nice cleanup.

Reviewed-by: Simon Horman <horms@kernel.org>


