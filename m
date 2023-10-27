Return-Path: <netdev+bounces-44645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699EB7D8DFD
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 07:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D2F28229D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 05:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357925249;
	Fri, 27 Oct 2023 05:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6OaOrIy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1696A5241
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6EC3C433CD;
	Fri, 27 Oct 2023 05:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698383450;
	bh=TyXcPDcA7TTQbRhs/9lOlcg1EO9AahL5ljNgx/nBR9c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e6OaOrIyiQeYIS2CC12RNOaS5wYkAEw0l9jnf8ZPhZq6cNj38I53cGpPca+Do0tK9
	 opMnQ1WbG8/Vcy0IWhRZ8bJpAr0dGLiIB+AG3fUoYwmXlmWEnVuTlGxx6yGhd8/rjN
	 glZrvc8UAOKupIletQBrm8BxjMgbimfSY5ApAvp6XGrs907aZgQUcdEqcWmuFrTZGS
	 o87t+D1v1fk/xzHAMbNmov1MGq851RLmH3a+7MH0Vt2oTkb01XFmMjebMr+PO7LO6w
	 aqq0krkieVqZ+NCRIN/DhWBTF3E00NAwp5RTXSr8DfdCVJMX/95NOkTXD3JP9JydoF
	 w3V4fiSLUUexw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93302E11F57;
	Fri, 27 Oct 2023 05:10:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2023-10-26
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169838345059.10513.5353747529284282144.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 05:10:50 +0000
References: <20231026090411.B2426C433CB@smtp.kernel.org>
In-Reply-To: <20231026090411.B2426C433CB@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Oct 2023 09:04:11 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2023-10-26
    https://git.kernel.org/netdev/net-next/c/edd68156bccf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



