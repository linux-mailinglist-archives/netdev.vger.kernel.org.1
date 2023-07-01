Return-Path: <netdev+bounces-14953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516427448DE
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 14:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FE51C208CB
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 12:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9066BE40;
	Sat,  1 Jul 2023 12:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123F279EE
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 12:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A27E7C433C8;
	Sat,  1 Jul 2023 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688214022;
	bh=ctHMUWQ9QGFVCsx0vIGpE9t1lfznwpRpuv0+kVXyFzo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oRLcLjU9kqTVt2yIyE2igQSqq+NU29xA0GqlXmjpJtEushgeJBtF1U5NjH7cA3qD5
	 7xNbmLhQJZOhfQ/ZNoxOR9rlPrm3/EZnZyyT8cwn1L0GmQNSGGAS2eI/UMhHGZx6ov
	 vhdzfuTV/pgAX+kNm5yIc5WqFmfuxj3BwJGwYiaMAIGfUp+hxa3WNc8fTDdhGOh0Lb
	 FtKxzJrvu25TfxAZAFc676hYj5O8ZxGif9KcqOkxbTMyGTJM9cmMfhDDWBa6rkWQDJ
	 LscTgnnKW4JtY7ew2j6zfEL298EZN9CoDGd/siOJw71NnY3Ns8c3c+AayinxlAy2PC
	 h0BpAprlBSOvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8254CE5381B;
	Sat,  1 Jul 2023 12:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] docs: networking: Update codeaurora references for
 rmnet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168821402253.27463.17647123197531595714.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jul 2023 12:20:22 +0000
References: <1688142377-20749-1-git-send-email-quic_subashab@quicinc.com>
In-Reply-To: <1688142377-20749-1-git-send-email-quic_subashab@quicinc.com>
To: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, andersson@kernel.org, quic_jhugo@quicinc.com,
 simon.horman@corigine.com, quic_stranche@quicinc.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 30 Jun 2023 10:26:17 -0600 you wrote:
> source.codeaurora.org is no longer accessible and so the reference link
> in the documentation is not useful. Use iproute2 instead as it has a
> rmnet module for configuration.
> 
> Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
> Signed-off-by: Sean Tranchetti <quic_stranche@quicinc.com>
> Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] docs: networking: Update codeaurora references for rmnet
    https://git.kernel.org/netdev/net/c/26b32974ad2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



