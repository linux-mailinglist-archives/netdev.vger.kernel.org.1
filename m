Return-Path: <netdev+bounces-127053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCCC973DBB
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B2AB261C6
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAF71A2561;
	Tue, 10 Sep 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwO0v2Mf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31661A254C;
	Tue, 10 Sep 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987033; cv=none; b=U4GFTHDRK6TNrW3SUKXF5AaglvaqKnVFYC82c57jeBW++kWJk49hsPNTTeUu3DX8S57H2xjTYYhCQoKnq4Oz4jiZo3vvo4dzRAqD8mSxNS30EBR+9rGcF+AR80fWVowHhxhTkalSdStkXXfq6dg10/yYX8E7yyPJdHBFL46H4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987033; c=relaxed/simple;
	bh=3GXiXzvaqFBmERAsv64yuufzluLlGycAIo86m4m72u0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y5mdG+7r1MclxGRbiIYqYcspNmnqnOvKJC1drZOQGriZ4MQ6XnZAHkUZCbfZ4Refwki2VYRApuq5ycUJ+V8sPNeUBI60T4YMPfXWaBx7Vb8cAgGP8yF4Lk4aKuoz9hvLh/rtITtkjMI2qvEyUUTu1u50E3++xDJ/0vnMHwDQnaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwO0v2Mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1D7C4CEC4;
	Tue, 10 Sep 2024 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725987032;
	bh=3GXiXzvaqFBmERAsv64yuufzluLlGycAIo86m4m72u0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BwO0v2Mfi75ENiOoubZfqb9ZOb9ILYdsKT8tP+iUEOrZdw2MAHEVrwfNOtFP+mY94
	 KicarYFGPE9HHE5Crr4KDHqmibe5+Cr4eB7f+QxYyqzSE68uJ48JE9d684Tm4sYafi
	 JuUA1fS1wacBb84aLlBQ57usDohLgGfInJmDQdmenGMlSGwrjP3p0x38qCWZCSd4j7
	 LuuATGEle6nCLIH8TiVyrej+WmZ26qfiV/6GUUY7T2nUl9JmZTSZ7AWICqqgzyn4Rq
	 e4pLtqxDEsXFcynkSHbWxEE+G2gam4DSd/OY/2Mqi2UCCVCkgcpjHsicEPdLMrRj8i
	 pCqltqYaNFCwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71B623804CAB;
	Tue, 10 Sep 2024 16:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by default"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172598703326.321180.8254311782129735485.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 16:50:33 +0000
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 darren.kenny@oracle.com, si-wei.liu@oracle.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Sep 2024 20:31:34 +0800 you wrote:
> Regression: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> 
> I still think that the patch can fix the problem, I hope Darren can re-test it
> or give me more info.
> 
>     http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> 
> [...]

Here is the summary with links:
  - [1/3] Revert "virtio_net: rx remove premapped failover code"
    https://git.kernel.org/netdev/net/c/dc4547fbba87
  - [2/3] Revert "virtio_net: big mode skip the unmap check"
    https://git.kernel.org/netdev/net/c/38eef112a8e5
  - [3/3] virtio_net: disable premapped mode by default
    https://git.kernel.org/netdev/net/c/111fc9f517cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



