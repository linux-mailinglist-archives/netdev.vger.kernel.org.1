Return-Path: <netdev+bounces-14320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B177401DD
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 19:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D59E1C20B44
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ECB1307F;
	Tue, 27 Jun 2023 17:04:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78213064
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 17:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58B55C433C0;
	Tue, 27 Jun 2023 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687885445;
	bh=WktUtzQgyKhGuN+DwlGY0IILBQcbGYEDvZmLf2FeL9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V/0Fc8SKZKGqRdQ1nq9ozoJFz6O0k4AlNy2/AyIMYbrKmrG/j4k75sCpR1MHxbKsW
	 tG09PAJxQpjv0nzOZj6A0aI5xUV0MW3oSTdHi+GqNeh6ybkGq6/2QJH2EKfReMo74w
	 mWHZxYvOmOETr6f6gdYi6PY9/hTgc2SkgKyRLVhYMca0/znyf9VQmmnRDlz2Wt4Dxq
	 1Ma8C/1gGThGfQidd0KIKqLxAiCcEXnq5DOgJK6ykIbi3AC+NAfE+sLIMOdrHs5Tjo
	 dP3FZw6u95r4VtUU+vdpE7xylR7C/sO3XbGfGQat7qz4eeb3inrccWY58OOOBGqFDf
	 3ZBfe/Gtviw/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 362A1E53807;
	Tue, 27 Jun 2023 17:04:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: lan743x: Simplify comparison
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168788544521.32757.7129863928208205686.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jun 2023 17:04:05 +0000
References: <20230627035432.1296760-1-moritzf@google.com>
In-Reply-To: <20230627035432.1296760-1-moritzf@google.com>
To: Moritz Fischer <moritzf@google.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, mdf@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jun 2023 03:54:32 +0000 you wrote:
> Simplify comparison, no functional changes.
> 
> Cc: Bryan Whitehead <bryan.whitehead@microchip.com>
> Cc: UNGLinuxDriver@microchip.com
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Moritz Fischer <moritzf@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: lan743x: Simplify comparison
    https://git.kernel.org/netdev/net-next/c/30ac666a2fcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



