Return-Path: <netdev+bounces-14316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A3B74019B
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 18:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892011C209CB
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0B013071;
	Tue, 27 Jun 2023 16:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCED13069
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 16:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE9D4C433C9;
	Tue, 27 Jun 2023 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687884620;
	bh=DcBFHXhRAWFmRLSZK2RajKpsfjr2KTMlxNIK0yzVQZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IiZxg11iz2NXInO20/34IniSrFfhWL7Pw2bbjGU6m4lq8d28RXgUICpWOTt+mXruH
	 TTl3hkS2f9K4aa0ijDhZ7HusVR1xwBW4/Ocwk+BoW+b/QW5XJgod/0AGppGATjTEMK
	 /YvceUb7XjrojDkfcOFpPCjKeJvXOdd16DXab4+XEWy6dLijHt+qRg2yFZt+tM4w6f
	 U69nxVoAMvWxaMyaAKjd8TfwQ9WMopdSfXDSsAPsRobr69fJtsmQ51q4KzPxJP0GfP
	 HOwZIS3ef9+7d+QCqWtxe9zIkrVFDuv9Zj5Kr/AnMgtpm4BhXbgcwlE4949R5rws0M
	 Cltegzdq2cPPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A08EAE53800;
	Tue, 27 Jun 2023 16:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: avoid suspicious RCU usage for synced
 VLAN-aware MAC addresses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168788462065.27533.11355169093087204068.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jun 2023 16:50:20 +0000
References: <20230626154402.3154454-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230626154402.3154454-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 simon.horman@corigine.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Jun 2023 18:44:02 +0300 you wrote:
> When using the felix driver (the only one which supports UC filtering
> and MC filtering) as a DSA master for a random other DSA switch, one can
> see the following stack trace when the downstream switch ports join a
> VLAN-aware bridge:
> 
> =============================
> WARNING: suspicious RCU usage
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: avoid suspicious RCU usage for synced VLAN-aware MAC addresses
    https://git.kernel.org/netdev/net/c/d06f925f1397

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



