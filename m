Return-Path: <netdev+bounces-27300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A957677B637
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 12:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49EC1C20A35
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 10:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A888AD51;
	Mon, 14 Aug 2023 10:13:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF0AD27;
	Mon, 14 Aug 2023 10:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB8DC433C7;
	Mon, 14 Aug 2023 10:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692007996;
	bh=Tw6xsKFT9/YLilCc8qW/d4Dahue6d9Rwz2kbqcD9t4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJFTC2TSqzm0gkNfWgpvXzM5a662tGAadcpzrNwHL24QqhdQf9dJf2yeVVR6axJzY
	 bV4KZ6xAMtYoA7Obv6jzXOEMmo59SfWfJ+K88bwZ25n9p8uxySGD9QDpGpiSt0Psvg
	 fdWHsh+LQlEbzYEc/UD2Fn9Rg5FsNmIJuFwsG2dQxzvAihX1s4j9VOrFEDfrFd8BD4
	 Xko85h4OV4pf7UfCA283BopFHNWgBAHpiLgeIwspoL310Z90GxCf4PLnmnr2qGWkXF
	 YOQZRgcyB6MZpGhiTxYqrFkUxYFKUdqWc/FVDLSJjt/9SdjFbA9TYmHLsQ1Sil6rO/
	 Bw5IuL1BlGj0A==
Date: Mon, 14 Aug 2023 13:13:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ariel Elior <aelior@marvell.com>, Manish Chopra <manishc@marvell.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Yuval Mintz <Yuval.Mintz@qlogic.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] qed: remove unused 'resp_size' calculation
Message-ID: <20230814101312.GF3921@unreal>
References: <20230814074512.1067715-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814074512.1067715-1-arnd@kernel.org>

On Mon, Aug 14, 2023 at 09:45:03AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Newer versions of clang warn about this variable being assigned but
> never used:
> 
> drivers/net/ethernet/qlogic/qed/qed_vf.c:63:67: error: parameter 'resp_size' set but not used [-Werror,-Wunused-but-set-parameter]
> 
> There is no indication in the git history on how this was ever
> meant to be used, so just remove the entire calculation and argument
> passing for it to avoid the warning.
> 
> Fixes: 1408cc1fa48c5 ("qed: Introduce VFs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_vf.c | 45 +++++++++---------------
>  1 file changed, 17 insertions(+), 28 deletions(-)
> 

I don't think that Fixes tag is really needed here and title should be [PATCH
net] or [PATCH net-next].

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

