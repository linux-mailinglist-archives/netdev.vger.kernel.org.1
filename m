Return-Path: <netdev+bounces-32156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54987931DD
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 00:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE094281398
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 22:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ED3101DA;
	Tue,  5 Sep 2023 22:17:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28932101D3
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 22:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438B2C433C7;
	Tue,  5 Sep 2023 22:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693952272;
	bh=DcG21snNFyOVFmUjVeQMmqfuI7YGTtdIqztcMnQ8FLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KzRcV+pAxZ8NCPUBKQajPqDs6tidKIroLfgQ3jH8uloPSj9pGyJz3p9Nkj7grMbDs
	 X2ajTC9PETXAbJvZ1USCuaFdjv4Tp59qdD7+fhKAjXVNYqtTxAHpcOpVjDsnni/3fM
	 PdIPnl6pvSXw8PhRGJPNv37EI9kb01qSI1tBhUSuTcxIzcE8V/rw2xKcs4/uRiM7a+
	 QTh2mPKSV+2JEMJZcoA/CzM4on7HgKitmbLyPfnAkCxTt1D/FEFfbHepACbUONscja
	 bac+64crGPPY/h6E4sfihvWGOrYquepL57jtdnu5iLA2jHWL66RiCo5PkjJTNE5FK3
	 lb689mfN2BkuA==
Date: Tue, 5 Sep 2023 15:17:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: remove unneeded stmmac_poll_controller
Message-ID: <20230905151751.1b2148ad@kernel.org>
In-Reply-To: <20230831120004.6919-1-repk@triplefau.lt>
References: <20230831120004.6919-1-repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Aug 2023 14:00:04 +0200 Remi Pommarel wrote:
> Using netconsole netpoll_poll_dev could be called from interrupt
> context, thus using disable_irq() would cause the following kernel
> warning with CONFIG_DEBUG_ATOMIC_SLEEP enabled:

Could you rebase this on top of netdev/net? It does not apply:

Failed to apply patch:
Applying: net: stmmac: remove unneeded stmmac_poll_controller
Using index info to reconstruct a base tree...
M	drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
Recorded preimage for 'drivers/net/ethernet/stmicro/stmmac/stmmac_main.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Patch failed at 0001 net: stmmac: remove unneeded stmmac_poll_controller
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

