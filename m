Return-Path: <netdev+bounces-12868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E409B739373
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 02:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971162816B4
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 00:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E79DDA2;
	Thu, 22 Jun 2023 00:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD16DDA3
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71213C43397;
	Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687392021;
	bh=yZrAdNwWtgDHw+tFjhrL08lNU2dXLHjvwtacUaya9RU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XaGA+rX0xFfkBjXhDg1XDP7zY9fccj60A4XOBgig50x4W4atPQr/oSj9RuNSjAYUl
	 UaH7cn6hHSWcmxhMlM36unc6qhuiv7TJzIwVBjs3OOn5G82ubjgMU9I+LOet+xAxOb
	 G8NwxsNRplf0f0gYWy239Vu94sUMvXm39vCWTLhzBNIFc586AbNRz1MfIBzNZg8FUF
	 j86Tnc+u63ooZ8e4lWiqSrIVu/M282TdMk56wVYDDTYUFsh7/dLg/iobJKBN2hDOz5
	 ExDPIcpJXdQGIePYXE8i6Q+Wx2hgijEVQ4ipVoJENJgN19mRwrzaZDKgdaKdxCnk2Z
	 CsJQqC4sDyJKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DF90E4D027;
	Thu, 22 Jun 2023 00:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: hsr: Disable promiscuous mode in offload
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168739202131.22621.267223043566352469.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 00:00:21 +0000
References: <20230614114710.31400-1-r-gunasekaran@ti.com>
In-Reply-To: <20230614114710.31400-1-r-gunasekaran@ti.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bigeasy@linutronix.de, simon.horman@corigine.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, rogerq@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jun 2023 17:17:10 +0530 you wrote:
> When port-to-port forwarding for interfaces in HSR node is enabled,
> disable promiscuous mode since L2 frame forward happens at the
> offloaded hardware.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: hsr: Disable promiscuous mode in offload mode
    https://git.kernel.org/netdev/net-next/c/e748d0fd66ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



