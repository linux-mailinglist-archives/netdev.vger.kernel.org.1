Return-Path: <netdev+bounces-41624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 846777CB7A0
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 02:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C0528151A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 00:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E17E10EB;
	Tue, 17 Oct 2023 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVuSvDVM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EADF10E9
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C69F9C433C7;
	Tue, 17 Oct 2023 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697503822;
	bh=/pGdAm7PXGj9anP5SKs4K42VM25v0gGyZYaa8W3Bo4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EVuSvDVM7xs/ez5ZfhaChA8kw4DL14lD4S11lNFQ0S8W5WIuFs2eVbMASEPPrZ4eh
	 tlb8Uku0XBMiEhKYTpAy5T8JJ2Saeg0fkVwgMd+/Qg7qIaCSaVsBF07p1HN9Xk/+Qe
	 ZDm3fzGWQUl8GAhwcKoameJUbMVpto5qYX9fMmV/YdBmCzeg+V1f7/Jbyy4QwPQNhE
	 I4n/tfj6F6YmhB1Yzmh3gYaVe1Yu+48tTSkLJqoqPXSgIROyht/bKjTTHlKh/ArO9c
	 nkYSKMpo05SJcDJ8SAUuS3Zx4Flg9fCDrB1dH+iWEcpHqR+Mg988Y1996oDB+lVkBr
	 0uVqwhuoLExJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B22C6E4E9B6;
	Tue, 17 Oct 2023 00:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] nfc: nci: fix possible NULL pointer dereference in
 send_acknowledge()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169750382271.30000.6808834861432208355.git-patchwork-notify@kernel.org>
Date: Tue, 17 Oct 2023 00:50:22 +0000
References: <20231013184129.18738-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231013184129.18738-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sameo@linux.intel.com, frederic.danis@linux.intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, huangsicong@iie.ac.cn,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Oct 2023 20:41:29 +0200 you wrote:
> Handle memory allocation failure from nci_skb_alloc() (calling
> alloc_skb()) to avoid possible NULL pointer dereference.
> 
> Reported-by: 黄思聪 <huangsicong@iie.ac.cn>
> Fixes: 391d8a2da787 ("NFC: Add NCI over SPI receive")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] nfc: nci: fix possible NULL pointer dereference in send_acknowledge()
    https://git.kernel.org/netdev/net/c/7937609cd387

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



