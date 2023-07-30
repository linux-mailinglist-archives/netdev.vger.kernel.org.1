Return-Path: <netdev+bounces-22627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB097685A8
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 15:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841C62816EE
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7D120F5;
	Sun, 30 Jul 2023 13:36:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEB5363
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 13:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AB6C433C7;
	Sun, 30 Jul 2023 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690724164;
	bh=EL/7NnbhV0zU3XbAJ6pGEfOkDAUFGN74kqWqHTyaDEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G5McIjQ5EY2E7OJo2euO6jK35ftDKap9pcVqONeEVHyEt68E8VIyaH7XRhH6NsoxK
	 XahsZewzhGguKQlPo6CYGQqBqJV1aoJkvoeqw2ZurkxlA3IpmI83l9yPGERw6htrJG
	 /bz/jk6u6iSOoqIL+qbuomUNvx0S/WKQSf1cBPWM/VZNq7WYhD4yDWzW6u+Yt2o1e7
	 VTcdskz5jpvl3Ivw79Wsjr9dkpmIsNpsN7smR6Z4GfkGr4rLuHPce99OohrNeWt7d3
	 uxY3AbvaMN4kKNM9ishSLdX3ZqnuAKEtOVPBuyIFllcWteoZmAlcCFIwlHyNZCfxok
	 hYCfwyUqEDBuQ==
Date: Sun, 30 Jul 2023 16:36:00 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: netdev@vger.kernel.org, Abhijit Ayarekar <aayarekar@marvell.com>,
	Veerasenareddy Burru <vburru@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net] octeon_ep: initialize mbox mutexes
Message-ID: <20230730133600.GI94048@unreal>
References: <20230729151516.24153-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729151516.24153-1-mschmidt@redhat.com>

On Sat, Jul 29, 2023 at 05:15:16PM +0200, Michal Schmidt wrote:
> The two mbox-related mutexes are destroyed in octep_ctrl_mbox_uninit(),
> but the corresponding mutex_init calls were missing.
> A "DEBUG_LOCKS_WARN_ON(lock->magic != lock)" warning was emitted with
> CONFIG_DEBUG_MUTEXES on.
> 
> Initialize the two mutexes in octep_ctrl_mbox_init().
> 
> Fixes: 577f0d1b1c5f ("octeon_ep: add separate mailbox command and response queues")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> ---
>  drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

