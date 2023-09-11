Return-Path: <netdev+bounces-32779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D0D79A6B1
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 11:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E861C209C6
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 09:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E90BE7C;
	Mon, 11 Sep 2023 09:25:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8714BBE6D
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14996C433C9;
	Mon, 11 Sep 2023 09:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694424342;
	bh=WpA2HSmOVnDSDp9vUx/6sCnejIWAz21QU/ikOzyuZyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J1bK6F0j/wB+fJQr4Kt2LbjQu31XTnJldrWV6fRSwa+M1taFaNRtmK7Retp2iW85v
	 QGnjIcPDSaM1GBi7GploYD2QGH9LX/gKrnIfTZtrZOlw/5MNF8Ayf+yNas4tQGcbG0
	 LWPnw6BjjSOEQe+b7Eo3A/zRUghv0FV9bR6fdcBCbFHLiworBLw4tpVW0x0+/O9XqR
	 oKQcs0VGmGGKl0yr8HEX4wx/FiEB8GX61ExY77SncAOG+ZsbGSKkACDS+y5wBiCdHl
	 +zGc7DeZR7ssi4fVNxh6JxMDun1HstF8CZvwLYHLePZKa/iwokQD3dnWDni7I3myN4
	 qV7PsihENvfaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03E26E1C280;
	Mon, 11 Sep 2023 09:25:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8152: check budget for r8152_poll()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169442434201.22330.8875438731088949212.git-patchwork-notify@kernel.org>
Date: Mon, 11 Sep 2023 09:25:42 +0000
References: <20230908070152.26484-422-nic_swsd@realtek.com>
In-Reply-To: <20230908070152.26484-422-nic_swsd@realtek.com>
To: Hayes Wang <hayeswang@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 8 Sep 2023 15:01:52 +0800 you wrote:
> According to the document of napi, there is no rx process when the
> budget is 0. Therefore, r8152_poll() has to return 0 directly when the
> budget is equal to 0.
> 
> Fixes: d2187f8e4454 ("r8152: divide the tx and rx bottom functions")
> Signed-off-by: Hayes Wang <hayeswang@realtek.com>
> 
> [...]

Here is the summary with links:
  - [net] r8152: check budget for r8152_poll()
    https://git.kernel.org/netdev/net/c/a7b8d60b3723

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



