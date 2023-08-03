Return-Path: <netdev+bounces-24173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7BA76F186
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF322822E5
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F4825915;
	Thu,  3 Aug 2023 18:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90322517B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41177C433C8;
	Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691086228;
	bh=JQ7oC/6/r2+aJtlBU9MJELICSmE7bgUSZdhahmPBdqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RV43oF2lW/2NJ3cQXHiQ1qTcOej2LxtDs+5gS7bHrgmBf3pBR+AGHCQsXClrNn9lN
	 AEQ/zjx6c0OVxm8BuV33JTse8buxWoOnTcuXHSWmPTkFbOyt9swMo4PsRYEXzB1cFL
	 vSc8a0EM/Rd4QDWU991+cI6Sq6HFX7MD2eXsQ/AX8VLIuZ03BYkPQmOSuliCQ1qQJ0
	 GSGBT5nwVQwtxWZLidobi2ZQKKVqXJFFwnyp7O1vMS0uRKjvZ3AiSXREOgA9zAk5vw
	 FfaBR4+4njA+G2GaWsqcgQA5yKK7sq8jkqEdP+OXVgCHQ5gyiKVNt0CNJ781uCFuTu
	 Az57vMrAxmrHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F87EC43168;
	Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2023-08-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169108622806.23543.11800053914524862324.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 18:10:28 +0000
References: <20230803140058.57476C433C9@smtp.kernel.org>
In-Reply-To: <20230803140058.57476C433C9@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Aug 2023 14:00:58 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net tree, more info below. Please let me know if there
> are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2023-08-03
    https://git.kernel.org/netdev/net/c/0d48a84b31f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



