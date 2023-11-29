Return-Path: <netdev+bounces-52194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA2E7FDDA0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1231C20AA1
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F343B2B1;
	Wed, 29 Nov 2023 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCZ9dY0h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB43B28F
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 16:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8557C433C8;
	Wed, 29 Nov 2023 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701276627;
	bh=Gcqm/GMOqBz5sCvyS845tTHRXuQP69w5bv1aMCFhUBo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MCZ9dY0h/33A1iWrEGgxK/IDMQVyXHvhPuyQ3/JztB2DvLBaPPSRqFnY3C3nYBFxo
	 ulyRFD0y0OyMaAJTC8BRz2fQheKcSNoopAGMfaprxH+fWLAVljgKc5afF6ikm2L5Qk
	 YZ7QL9ViGfIuxvZshGmftBst1eGdzW2yrYd8hs4qXrujPGJrlOcRToUlcHE6VMP3sk
	 FvWqlIBdcKEMCO6N52P7q2kJfDpfwt71GVQVR4xqllozsiKlyOS+st+Kn722tAmzUn
	 rTrnlDIONtl0n3J6cFFJCB9ejgiR4UabBaWBBwQ+3G8X7Y/lDzpjPARWGhIDGr1kJj
	 UcuA7/yB3fe5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9844EDFAA82;
	Wed, 29 Nov 2023 16:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools: ynl-gen: always construct struct ynl_req_state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170127662761.14566.593097773218186223.git-patchwork-notify@kernel.org>
Date: Wed, 29 Nov 2023 16:50:27 +0000
References: <20231126225858.2144136-1-kuba@kernel.org>
In-Reply-To: <20231126225858.2144136-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 26 Nov 2023 14:58:58 -0800 you wrote:
> struct ynl_req_state carries reply-related info from generated code
> into generic YNL code. While we don't need reply info to execute
> a request without a reply, we still need to pass in the struct, because
> it's also where we get the pointer to struct ynl_sock from. Passing NULL
> results in crashes if kernel returns an error or an unexpected reply.
> 
> Fixes: dc0956c98f11 ("tools: ynl-gen: move the response reading logic into YNL")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] tools: ynl-gen: always construct struct ynl_req_state
    https://git.kernel.org/netdev/net/c/83f2df9d66bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



