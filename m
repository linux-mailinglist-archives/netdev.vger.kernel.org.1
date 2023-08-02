Return-Path: <netdev+bounces-23781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B4A76D815
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4069C281CA9
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3586010979;
	Wed,  2 Aug 2023 19:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C1410945
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40E57C433C8;
	Wed,  2 Aug 2023 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691005223;
	bh=zUueExu5WDGBWQd1w9sj56kh+ML1CD93mif0h3gMPok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PQa2Y76ChPxNNBgsAiV8xquDldPkVJOnLarI736wosyXRo51DDbF1yymCBKJ7c6s/
	 vLnAuo1FBvnsimVpBpc4sqTQbAs345XbNdpZbU4Pi33B9TikUmrUayT3JPvzJWIQx2
	 UBXCeRjkwKfJb7UTitOx11w+iBntKHblF7RbU1KdYgjBhS4wkFi4y4q46n5OgIoaoy
	 LKyin5FeEHYsyqjELzE3nfctbpqw81L+xvij0rDk2J1MxBhQ5neQR0gYDspVoMOb54
	 9vZOQ5KodgIll4HB05bnL3wv+quC51M0poy6kbx3IVVT3VkcSuVP9u9mMYzLzl0Bas
	 fOFYUck8G2EwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21C3BE96ABD;
	Wed,  2 Aug 2023 19:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] pds_core: Fix documentation for pds_client_register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169100522313.7181.15941728276497117005.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 19:40:23 +0000
References: <20230801165833.1622-1-brett.creeley@amd.com>
In-Reply-To: <20230801165833.1622-1-brett.creeley@amd.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 alex.williamson@redhat.com, shannon.nelson@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Aug 2023 09:58:33 -0700 you wrote:
> The documentation above pds_client_register states that it returns 0 on
> success and negative on error. However, it actually returns a positive
> client ID on success and negative on error. Fix the documentation to
> state exactly that.
> 
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> [...]

Here is the summary with links:
  - [net-next] pds_core: Fix documentation for pds_client_register
    https://git.kernel.org/netdev/net-next/c/30ff01ee99bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



