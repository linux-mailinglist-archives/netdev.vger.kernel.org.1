Return-Path: <netdev+bounces-12839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A907673914E
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 23:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E364F1C20EDB
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE581D2B7;
	Wed, 21 Jun 2023 21:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3C1D2AB
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 21:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E425C433AD;
	Wed, 21 Jun 2023 21:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687381826;
	bh=778aFxmB3Fo3K9ZEIoLiqcuiGipuiqZwdEhhMcFYmPw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p66h6MsJxbZUiIox+BDhbQ3cgE6RnguZUarKVrkyWiYFmEqSzEWQw9YR9UT7RkicD
	 Wm5/VqJLj2FHUcTCC4tQm+MWknMpugcV+cfC3oYBlS23T1bDlGDLlGc+WvG1X57YAH
	 D3yvcimHcLjPqyc/bn7fjyC9ddo3XhO1z51Rg+r8WaitVmtXwlYrmXu/IgNXuZ7MdS
	 CX8Pob9N3fKAHcHim8v62eNGjaJ+LXSepZAq1qMNXb3O8cAY0hu6liTGBMKm+6evOz
	 Wg8VC45ek8YvnUPq8J1TTcBXqTwQFcwZBUiHa9GQdyh0LMCFgikDvM1OlTP5EwZ3ea
	 uFiIaekR33TVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A64FC395F1;
	Wed, 21 Jun 2023 21:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bnxt_en: Link representors to PCI device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168738182603.695.15786386736224760669.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jun 2023 21:10:26 +0000
References: <20230620144855.288443-1-ivecera@redhat.com>
In-Reply-To: <20230620144855.288443-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jun 2023 16:48:55 +0200 you wrote:
> Link VF representors to parent PCI device to benefit from
> systemd defined naming scheme.
> 
> Without this change the representor is visible as ethN.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next] bnxt_en: Link representors to PCI device
    https://git.kernel.org/netdev/net-next/c/7ad7b7023fcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



