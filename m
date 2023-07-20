Return-Path: <netdev+bounces-19343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223C175A52E
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 06:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF38281C3F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924AE17E8;
	Thu, 20 Jul 2023 04:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519C3D6E
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1EC9C433CA;
	Thu, 20 Jul 2023 04:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689828019;
	bh=k3v51fIb1waD23fz+LHL6DPkooAQAO9qQfeF3wy+310=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YZ4Z0Q+V//9W6AkQog8sKHcu1WYtY8FVTLLZm3GXw5yM7bvemXeyU+nztYWEtyWQw
	 Dci4DeneI1EVYL99JF++P7ujNHzreVhK9CFrsHvt94fF+H+5BeP+OEgaIZtvsGiOJI
	 aOmx4rw8ewuF5PX+fVqw+5UTCtnsHm07cxsBQSXdoFD2EzRb7WqI7OJAHYqItPLvSh
	 XCIHGSEyMtq1gGd4zLBg2lX9FZq0jMD5EdHNoU4JZ8NYlSJhC2cY9Kjvk37QbMg0Of
	 GUajkbdk4S2yLNpezJ1i9YhkS8Sg5lLtOyNNM+jfJ2IdiP7YuJwxnQAu9S8h68Ti1t
	 oXKuSoD6kkunQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C77FEE21EFE;
	Thu, 20 Jul 2023 04:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: remove tcp_send_partial()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168982801981.27392.18301948177849432233.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 04:40:19 +0000
References: <20230718161620.1391951-1-edumazet@google.com>
In-Reply-To: <20230718161620.1391951-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jul 2023 16:16:20 +0000 you wrote:
> This function does not exist.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/tcp.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] tcp: remove tcp_send_partial()
    https://git.kernel.org/netdev/net-next/c/730b9051b8bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



