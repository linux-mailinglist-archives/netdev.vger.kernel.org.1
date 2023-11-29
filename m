Return-Path: <netdev+bounces-52002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB247FCDD2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 05:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA90281EA5
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9CD6FA5;
	Wed, 29 Nov 2023 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWFCWlaZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45DD6ABB
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 04:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91411C433CD;
	Wed, 29 Nov 2023 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701231626;
	bh=MVxXeTN1syVaaJHILjEn56a+3g8fP3nbmSmtVv++sUk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tWFCWlaZ8VDUoQEEluQ76BP8EPoI/6fOIlc8iwX++rSIp7umsZgJT398XDZomvgmF
	 rbH1MB0kfKooVvu5rC37dSQRU5vFkXAxTzbODhdhKBFzuR7skt7luQ9ay6GYPqvL8h
	 RpceWuMT7UdG0LbnkpILQnjOrlOc9XPnMIT+LEkhgptChgVR8LD/rr3ewZ+j/0p81q
	 wjUTlTcbxbxOCVFRAxCfbgtZk5mlQLTJaAb8I5fu3r1Vc/2FE1WhnCnSwYgCvTJQxn
	 fc5JcxHAOwbrRl4B4+gXFgTsk5zGY0fwKHbUV7P03zBxqB530BSosPIKzm1W9HpkHK
	 lQ/+CKr5uiIUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70778DFAA8C;
	Wed, 29 Nov 2023 04:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] nfp: ethtool: support TX/RX pause frame on/off
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170123162645.8478.13072834934939672705.git-patchwork-notify@kernel.org>
Date: Wed, 29 Nov 2023 04:20:26 +0000
References: <20231127055116.6668-1-louis.peens@corigine.com>
In-Reply-To: <20231127055116.6668-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 yinjun.zhang@corigine.com, netdev@vger.kernel.org, oss-drivers@corigine.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Nov 2023 07:51:16 +0200 you wrote:
> From: Yu Xiao <yu.xiao@corigine.com>
> 
> Add support for ethtool -A tx on/off and rx on/off.
> 
> Signed-off-by: Yu Xiao <yu.xiao@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>
> 
> [...]

Here is the summary with links:
  - [net-next] nfp: ethtool: support TX/RX pause frame on/off
    https://git.kernel.org/netdev/net-next/c/4540c29ab9cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



