Return-Path: <netdev+bounces-37296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB57B4905
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 20:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0DA962819C9
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 18:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE2118C28;
	Sun,  1 Oct 2023 18:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D7318C18
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 18:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8448EC433C9;
	Sun,  1 Oct 2023 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696183824;
	bh=qUjOQ1NO/389X856xo2f7ZphJPr5J5BqTviNC+jbX3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O6yyyQawzDFnonculnvgu30p1d39wHGPnQXD/TALW6KNatgxtOZZYfciUvpX/aS1d
	 XxqeKlbeUYFJXuK50gezACXd5Rp4Zf6GozJTQRyKXVjpKjtgXscLJGMLF5spQQICrx
	 MZBt9sLUrc6fKg+QirgJH+w79pnlixh0l/EP8o6/56mRJNbVg7Z9TLu/AUV3OGTXMS
	 SscOK0Xc2Y9jbXYN9rcRfEvFac/xOCVmrT6vXVWZ255Bw5Jdt7yAb2Y+Ts9FJCeRu/
	 MJT6Mg+8YSky4eRVLfoIpxaFKk3BqCTI58tEKhhCfYc/Y1wtyb0wFUrAXxf3Ybhob4
	 +IVCztUoD6DtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 675DCC43170;
	Sun,  1 Oct 2023 18:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] openvswitch: reduce stack usage in
 do_execute_actions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169618382441.7639.12391501552902895614.git-patchwork-notify@kernel.org>
Date: Sun, 01 Oct 2023 18:10:24 +0000
References: <20230921194314.1976605-1-i.maximets@ovn.org>
In-Reply-To: <20230921194314.1976605-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 dev@openvswitch.org, pshelar@ovn.org, echaudro@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Sep 2023 21:42:35 +0200 you wrote:
> do_execute_actions() function can be called recursively multiple
> times while executing actions that require pipeline forking or
> recirculations.  It may also be re-entered multiple times if the packet
> leaves openvswitch module and re-enters it through a different port.
> 
> Currently, there is a 256-byte array allocated on stack in this
> function that is supposed to hold NSH header.  Compilers tend to
> pre-allocate that space right at the beginning of the function:
> 
> [...]

Here is the summary with links:
  - [net-next,v2] openvswitch: reduce stack usage in do_execute_actions
    https://git.kernel.org/netdev/net-next/c/06bc3668cc2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



