Return-Path: <netdev+bounces-23058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E6476A8AB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423F41C20DBE
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 06:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E0746B9;
	Tue,  1 Aug 2023 06:07:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8926EEA3
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8263DC433C8;
	Tue,  1 Aug 2023 06:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690870025;
	bh=D7MIiOuipl+/CRkm/aVr7dVWacIZdzE4T0lZkjbVk4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o+MAnpIi1+msZkD+E7RzfYpdLraGfr8UWAmZz06KsSzKVlw/McvU9UnBm155wFVVZ
	 +tIhzPoMz6BVREooEtZB3bLaDVfarq1sqtV9pGl5egQUQdz67c7BqUfQzojXOtprEv
	 eovHmaHWtWKME2V/uMwGRiJeziUbXIs4oiDLOVmWh6BjNiUrbg3h1M2Qo+vJa0AE4G
	 g6m5MbWJMDyvlJewxuttqdGg3a9eGdfRC64X2itiy232W0BzM7E4NohDTjqVAyqnqV
	 wXjf0AEYGqWLq1aM+pkAYv9D+5KuJUdlH7WaN36M40SFJuhEvNTfgnyghndeh1eA5a
	 3cdSaJ7dfs9aQ==
Date: Tue, 1 Aug 2023 09:07:00 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v2] net: make sure we never create ifindex = 0
Message-ID: <20230801060700.GA53513@unreal>
References: <20230731171159.988962-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731171159.988962-1-kuba@kernel.org>

On Mon, Jul 31, 2023 at 10:11:58AM -0700, Jakub Kicinski wrote:
> Instead of allocating from 1 use proper xa_init flag,
> to protect ourselves from IDs wrapping back to 0.
> 
> Fixes: 759ab1edb56c ("net: store netdevs in an xarray")
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Link: https://lore.kernel.org/all/20230728162350.2a6d4979@hermes.local/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: leon@kernel.org
> ---
>  net/core/dev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

