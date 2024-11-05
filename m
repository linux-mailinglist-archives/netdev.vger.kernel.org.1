Return-Path: <netdev+bounces-141766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4947E9BC31D
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0173B1F22A43
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7FB7DA84;
	Tue,  5 Nov 2024 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/KDLTdt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79577DA66
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773227; cv=none; b=DILa87zE4Si79vJVHFoPlCewC3YbHHOw9/lEjHUURBhynVKUCI5yYBx3RpHq2zQeCQcCIfvgfyjnjRkppn5OeTF1zPSmUK9GSTnntTpbmUZZrzshXgMzq+MXh/uSfEHjJHC3A2hoOc+8fWosGHWrQzk8abF0WgCCgvoxoXmzoxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773227; c=relaxed/simple;
	bh=J/OHXoj/cFEnAswZ/YKHOa4ic2fiLGLQQeYxPn38OSs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GHHBPjqy8gezBtJhPlq8PSD+UuwsG4X21+a4T7ji2eoK8I0rJahyQtOpHbkCO/UlBl2awPjNKJPToJ1DNYCycMDMUDPGsjbC1iZKvfe2uLqs9fCx9m9mV5bVkNVIrLZW2aa9gKDkT11PiYKcOb4CXWHW2Dt/+m8gWftd89bxMMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/KDLTdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860C0C4CED4;
	Tue,  5 Nov 2024 02:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730773227;
	bh=J/OHXoj/cFEnAswZ/YKHOa4ic2fiLGLQQeYxPn38OSs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H/KDLTdtbDEFKPT/hjK31aaYbAUkyondai6xiOByfeypNvTuWdqKfQ+exSr53OFOp
	 o5tNg4Nzwp1Rybn48JbkkxLrb23VauGv+5lY/eyl5VcnsKpSwcWcpWEoEoiqE+9oKu
	 XXZXupSfQ3n4y8mPYpBQ94hHdcGde4pFJ6Z1+GENcjYWZUi2Y95a9697eQWgMtxj/g
	 NnvcqixqIHQx7UZ62ibkJO0XyS3rlUpRblnDiLDiZEQPmtTfCPgBT1cHJpE76xsThX
	 Uk5Kg9oHe+2Qa6HAA7pSW77jhiZj+f/n01x4pbKKMkLkO1b4w/QIG5Y7XCgIGM8e4E
	 C0WrW9i8CYI7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CEE3809A80;
	Tue,  5 Nov 2024 02:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-gen: de-kdocify enums with no doc for
 entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173077323626.89867.10240447180731437605.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 02:20:36 +0000
References: <20241103165314.1631237-1-kuba@kernel.org>
In-Reply-To: <20241103165314.1631237-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
 jiri@resnulli.us, donald.hunter@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  3 Nov 2024 08:53:14 -0800 you wrote:
> Sometimes the names of the enum entries are self-explanatory
> or come from standards. Forcing authors to write trivial kdoc
> for each of such entries seems unreasonable, but kdoc would
> complain about undocumented entries.
> 
> Detect enums which only have documentation for the entire
> type and no documentation for entries. Render their doc
> as a plain comment.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl-gen: de-kdocify enums with no doc for entries
    https://git.kernel.org/netdev/net-next/c/690e50dd69ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



