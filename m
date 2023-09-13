Return-Path: <netdev+bounces-33443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B12BC79DFED
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 08:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1C128193F
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 06:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D447C168AF;
	Wed, 13 Sep 2023 06:20:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636DB168B9
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 06:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7DEEC433CC;
	Wed, 13 Sep 2023 06:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694586031;
	bh=gP/W6TOTLfGRrMBKIQA3cM9ZLFKCh+BrIEaksJWClkc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AoO0EZSHdke6IQpTbbPq3iSL1cppjElwLbmoxWMWdsjevh8UBn9wxudWQDpthnQ04
	 km0uIN71KZxKqAn9cMudJ4G9/tIsqZ2GQ6/CTyBHTRFtNj8P1nMJFBKi2YdznCGevR
	 TCPLMU2h0RwXWGOgLz2Dktmiwk4WCpZBwyzLluRTtcQX2kcAgRzyGV/sztK7IujN+n
	 9w4dxwg8/yhvNMcSX9tEcqHfni7k5WZ0aYI+WAtXACNwaCKWwEV55MzTA7M6J4yFNN
	 pFdnd/amMT2j65rMgi0I6tc7dbbuxwvq5c22EG/XifVlyX1l0zFjvsc6PTgSVWHtbs
	 JYoTvfz/IS+3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1E94E330A7;
	Wed, 13 Sep 2023 06:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2][pull request] Intel Wired LAN Driver Updates
 2023-09-11 (i40e, iavf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169458603085.26932.18118013727470310007.git-patchwork-notify@kernel.org>
Date: Wed, 13 Sep 2023 06:20:30 +0000
References: <20230911202715.147400-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230911202715.147400-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 11 Sep 2023 13:27:13 -0700 you wrote:
> This series contains updates to i40e and iavf drivers.
> 
> Andrii ensures all VSIs are cleaned up for remove in i40e.
> 
> Brett reworks logic for setting promiscuous mode that can, currently, cause
> incorrect states on iavf.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] i40e: fix potential memory leaks in i40e_remove()
    https://git.kernel.org/netdev/net-next/c/5ca636d927a1
  - [net,v2,2/2] iavf: Fix promiscuous mode configuration flow messages
    https://git.kernel.org/netdev/net-next/c/221465de6bd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



