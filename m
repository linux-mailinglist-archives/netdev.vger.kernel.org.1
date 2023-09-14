Return-Path: <netdev+bounces-33823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3DA7A0642
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1218B20B05
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA62921A00;
	Thu, 14 Sep 2023 13:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B40DCA6C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 13:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAD52C433C9;
	Thu, 14 Sep 2023 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694698827;
	bh=qz3vptSBmIvfTcD37v+a7fNlvhBjMcQT+YDrkAGELp4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u3AMgoEg76lkmcjMy7tXlYVdzELukhMd1dK7UaDlvLJzt+/8qQfV0E4a2JWH/ooIY
	 LqjBVgN5h9+f2aHaGxAkVZDupadkaB3ucL7a0ZUV3uV7xZbXcGq6PiGdFpg1ZyCF0y
	 QEgDeitNDJWmj+AOH5Wv2KlKTg5g0aF7Ik0tHyDOa/Mtw7eVhn67YtMtMj27XjZdA3
	 wrSqpjw2RbFPZjXtM20xWse3b9W4Z2GuGN4hvoHsBYLecblH8rkk8g94iTcHSuoRlP
	 fau2eYF7T338ruLJBscprcDJG/vizIu1811iIflSYN7B7h9crVTaWNxuK/7G1XRzx3
	 rvgaHIFgJbe2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CEE41E1C292;
	Thu, 14 Sep 2023 13:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: check update_wo_rx_stats in
 mtk_wed_update_rx_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169469882684.12542.4332794850808123363.git-patchwork-notify@kernel.org>
Date: Thu, 14 Sep 2023 13:40:26 +0000
References: <b0d233386e059bccb59f18f69afb79a7806e5ded.1694507226.git.lorenzo@kernel.org>
In-Reply-To: <b0d233386e059bccb59f18f69afb79a7806e5ded.1694507226.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
 john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Sep 2023 10:28:00 +0200 you wrote:
> Check if update_wo_rx_stats function pointer is properly set in
> mtk_wed_update_rx_stats routine before accessing it.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_wed_mcu.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [net-next] net: ethernet: mtk_wed: check update_wo_rx_stats in mtk_wed_update_rx_stats()
    https://git.kernel.org/netdev/net-next/c/486e6ca6b48d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



