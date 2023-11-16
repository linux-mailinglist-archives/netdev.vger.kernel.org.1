Return-Path: <netdev+bounces-48314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6677EE06A
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1C31C2084C
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 12:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E0529430;
	Thu, 16 Nov 2023 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzzR9siz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E553C45957
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 12:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B59CC433C9;
	Thu, 16 Nov 2023 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700136623;
	bh=CB+Z9KhjNuxIpYBv3s7uWPXwG45KTeyo1+mDiNPYoKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rzzR9sizziRCyySRurTHP/DzjfttVHGD5LoetKUw3YZe0HGhDKNURQE0r1bMh1HWN
	 BbU6Ydsw9rkwpTK6J4xNPV1CJPB/MAYf04Pp2YxiryFOnDq0XkDjZIQPdp46fTYdGm
	 LKrJRTzhv1zOvAWr/u/A2hEj+7IIi/6/dBsrLMqtrR4IsCkyJCDJRVNe2JsscT0y0S
	 4ofoXN0A+Bw+A0h7WY+VOfRxbCZHtVRAzdPQMaSWfcxZzc6+9c0IqVSv/+NtxNPZoz
	 6zUfAtAD/TxUwJDx1/XOX7yiwYeRNq8Uwf3LlwgFaxXEBhQo+E/R8TPZgneF93yLUk
	 kCa3G91qnjctA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A1F0E1F666;
	Thu, 16 Nov 2023 12:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] indirect_call_wrapper: Fix typo in INDIRECT_CALL_$NR
 kerneldoc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170013662329.21544.14620842715409880928.git-patchwork-notify@kernel.org>
Date: Thu, 16 Nov 2023 12:10:23 +0000
References: <20231114104202.4680-1-tklauser@distanz.ch>
In-Reply-To: <20231114104202.4680-1-tklauser@distanz.ch>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 14 Nov 2023 11:42:02 +0100 you wrote:
> Fix a small typo in the kerneldoc comment of the INDIRECT_CALL_$NR
> macro.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  include/linux/indirect_call_wrapper.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] indirect_call_wrapper: Fix typo in INDIRECT_CALL_$NR kerneldoc
    https://git.kernel.org/netdev/net-next/c/3185d57cfcd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



