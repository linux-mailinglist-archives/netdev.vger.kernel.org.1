Return-Path: <netdev+bounces-50478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C3E7F5E96
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE72A1C20F05
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 12:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255A2241E1;
	Thu, 23 Nov 2023 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klcCoWSW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0865A23760
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 12:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74B07C433C9;
	Thu, 23 Nov 2023 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700740824;
	bh=JCWrs5cVuVcR54HYAaTKJE3mQgsm/AnZMIY74GUVuhE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=klcCoWSW/aIgW58vbQKs1JkGIzwvSp7ApLj2BsmMB5CQGTu9PhKH0/Q2Os6T8pqyh
	 PCDXOy00Po0PMpEGD/6I3glDz+fmQ2+esLevtC7l8PAk7K6ojF9Uc72vKBNWaMIsrE
	 P490W/M54qHMwDEVRvReOIJPQBw1xsZ0DxGxrL1Gpmb4YXcC4/x85tHws+jBx0mWGh
	 zF5NYw0eY1ss1VsP8066QmrwrHkY2EPBQx11GnsbqVSyO9xvPD3XmRYEC0PzRRmHd7
	 mq3LehqsHvfqHuqq+K9STqg8UjGRtQktGb9nrH8dxOVX2V1NJZ1Y8v8WXIUP6QMu3A
	 GAb9St2H0fZFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58E10E00087;
	Thu, 23 Nov 2023 12:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] octeontx2-pf: Fix ntuple rule creation to direct
 packet to VF with higher Rx queue than its PF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170074082435.27332.7452962954462258378.git-patchwork-notify@kernel.org>
Date: Thu, 23 Nov 2023 12:00:24 +0000
References: <20231121165624.3664182-1-sumang@marvell.com>
In-Reply-To: <20231121165624.3664182-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 wojciech.drewek@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 Nov 2023 22:26:24 +0530 you wrote:
> It is possible to add a ntuple rule which would like to direct packet to
> a VF whose number of queues are greater/less than its PF's queue numbers.
> For example a PF can have 2 Rx queues but a VF created on that PF can have
> 8 Rx queues. As of today, ntuple rule will reject rule because it is
> checking the requested queue number against PF's number of Rx queues.
> As a part of this fix if the action of a ntuple rule is to move a packet
> to a VF's queue then the check is removed. Also, a debug information is
> printed to aware user that it is user's responsibility to cross check if
> the requested queue number on that VF is a valid one.
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-pf: Fix ntuple rule creation to direct packet to VF with higher Rx queue than its PF
    https://git.kernel.org/netdev/net/c/4aa1d8f89b10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



