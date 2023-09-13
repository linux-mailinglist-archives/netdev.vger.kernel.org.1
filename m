Return-Path: <netdev+bounces-33535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FB879E69D
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AD0282505
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541A81E52F;
	Wed, 13 Sep 2023 11:24:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F5D1E51A
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A68AC433C7;
	Wed, 13 Sep 2023 11:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694604275;
	bh=oI4QxwIa+0uVLswqbMXCEUfXoMeGy9kLfMbzOPVMnSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/Oc24iBJ4+HgMYPoSR27YwkCDiN0OKkNl7sgo5ZEb7+CQOCIMHDbvjpU/JKBaK9d
	 qUsSXu+rao6MYzkxXtGk2HD4513pcMhG1E4N4Sn3OQ+o01fDDAuar496X9mVD5aKJi
	 FE20LEcdXfyHDcI6GDIhmPWKstY2HBiGFW+78FiPGgy0EzFEHRHdI++34KQBBEW3CR
	 mA7qB9DQGkO+D+LXC99MnqTrSkxwmPPwEECJIQYarGVl0GTgx7HSarX4loI+ZA51rS
	 4Bfj52SZI9bQwq7RSi0B1OEMSaajfHFthpUSZV7wbKBiXgkJ3j9SDVZ7ldCq3yKT2b
	 rRCeKy+MRgy8g==
Date: Wed, 13 Sep 2023 13:24:29 +0200
From: Simon Horman <horms@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net 0/2] net: renesas: rswitch: Fix a lot of redundant
 irq issue
Message-ID: <20230913112429.GQ401982@kernel.org>
References: <20230912014936.3175430-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912014936.3175430-1-yoshihiro.shimoda.uh@renesas.com>

On Tue, Sep 12, 2023 at 10:49:34AM +0900, Yoshihiro Shimoda wrote:
> After this patch series was applied, a lot of redundant interrupts
> no longer occur.
> 
> For example: when "iperf3 -c <ipaddr> -R" on R-Car S4-8 Spider
>  Before the patches are applied: about 800,000 times happened
>  After the patches were applied: about 100,000 times happened
> 
> Yoshihiro Shimoda (2):
>   net: renesas: rswitch: Fix unmasking irq condition
>   net: renesas: rswitch: Add spin lock protection for irq {un}mask
> 
>  drivers/net/ethernet/renesas/rswitch.c | 20 ++++++++++++++++----
>  drivers/net/ethernet/renesas/rswitch.h |  2 ++
>  2 files changed, 18 insertions(+), 4 deletions(-)

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


