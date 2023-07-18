Return-Path: <netdev+bounces-18538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D477578FA
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE1C2811F6
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C082CFBEE;
	Tue, 18 Jul 2023 10:10:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A77C8D8
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB177C433C9;
	Tue, 18 Jul 2023 10:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689675020;
	bh=yZhYdUQhkxWzgx4EVMbSlGIIYCJZSvWKBSoeB+P5USE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uBTH4dmiDnCj9Tj3uBgROcJ9F1BMtagtvLAENPD41UEkO8gobH88x+0POoUBJMoAS
	 g07k5jSO26ZFHLaLzZaV1xM3LAz8VTZPpTza6vKK4lrsD4A7TrN/Gf86eU9nd2NsM9
	 4QAld0sa8VImMmvtEBbewdaHGP/DnC9Pd/0IpiMVXALz9e2Tkwgro1TWGe/c3o2J+U
	 WJrGcw4kN30oRxjPJn57HfkbcMucCr0bwDnbI/OnuNq7OtFxXumDrTfSCP/EUFAufK
	 ZRbt+OMYZNoCin3Nd5bwqIFIIM4P+3Pl1vCcOp2FlV2nwE9E/45ARHiKe9jANITpR6
	 43t/6q0KBq+fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0BECE22AE6;
	Tue, 18 Jul 2023 10:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates
 2023-07-14 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168967501984.22739.6314298851185148910.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jul 2023 10:10:19 +0000
References: <20230714201041.1717834-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230714201041.1717834-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 14 Jul 2023 13:10:39 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Petr Oros removes multiple calls made to unregister netdev and
> devlink_port.
> 
> Michal fixes null pointer dereference that can occur during reload.
> 
> [...]

Here is the summary with links:
  - [net,1/2] ice: Unregister netdev and devlink_port only once
    https://git.kernel.org/netdev/net/c/24a3298ac9e6
  - [net,2/2] ice: prevent NULL pointer deref during reload
    https://git.kernel.org/netdev/net/c/b3e7b3a6ee92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



