Return-Path: <netdev+bounces-28982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B0A781560
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB6D281E92
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5201C2AB;
	Fri, 18 Aug 2023 22:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA481C281
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1026C433C9;
	Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692397227;
	bh=YNlQRxa/mKyD8QS/GUbr6Fdj6pip2WDQvxzOzrid+S0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ARToZ2lDFvUNHxQ2H7E1Nq74OiPbLEDZfrQz84b7RkoNO9MFN5Pz6TsQEZS1qp9He
	 H0xpDQhGusTJw9vgPplxyVW9OmAoYyDvYx7ZxsSjfkfgqF2sktFvd5VogFxMEaYhLb
	 YSjYkxlT7iHVuzqOWQx1CvQVAegwx2wwMN2wPGBQAI5lRJJ5fsLNQXRyJjgTUAMBnv
	 3CZwe7Bqxu72WtlpPkI8kpPneaAt0rX1Eg+u0ea/qcwgxArzeV+9l2KKlzA9PZ4BU+
	 d8ZkWPFkzdYlkGQZdJDTyDtpZzAB64TsxEg/3Lty2d3gW98V5niX6m4MYmV+QxkqkK
	 lxPCeMBdzU9zA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83320E26D33;
	Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sfc: Remove unneeded semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169239722753.24641.8158983251543000115.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 22:20:27 +0000
References: <20230816004944.10841-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230816004944.10841-1-yang.lee@linux.alibaba.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Aug 2023 08:49:44 +0800 you wrote:
> ./drivers/net/ethernet/sfc/tc_conntrack.c:464:2-3: Unneeded semicolon
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/net/ethernet/sfc/tc_conntrack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] sfc: Remove unneeded semicolon
    https://git.kernel.org/netdev/net-next/c/5cce781484ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



