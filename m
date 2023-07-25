Return-Path: <netdev+bounces-20615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A67603D7
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 02:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF62A1C20CA5
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C19B622;
	Tue, 25 Jul 2023 00:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F039623
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19243C433CA;
	Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690244421;
	bh=c4koAYBLWCLFaCl6oJI8e3L8bVloUKS234LsXnYHSjs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EJ57Lhf7sRZ3RNtrl51hquWLBbhPCJIfg9y3CgngMK6ZRgFmJNGO4URoMWn8Q4dz3
	 H4X1WOTa2YCQb9FhwmE1vaab362KettEvV49+hy4wqfuu3P1tZxTCKRkqCfGFtmrWA
	 q+MBxLDttqX8IiF2hyqC3KDVB2xu9Uc0VolulXf0QfiKD+P6xuyNGi/4ADcxdgaRbM
	 /PhaS7YP9UzOvzpIcWv8A9yotPlPYHjM5iZ7bQY3O22nMlmQ8fyVw69vfRAaOMim8K
	 3xL9W8yjm2q4gf7dnh2MBS80KtqacYq1CltNw3S6r4se4JStFjpm8JMXJvKCIwJD73
	 G+57Dz2759RRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00C49E1F658;
	Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ice: Fix memory management in ice_ethtool_fdir.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169024442099.15014.18441439373607513249.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 00:20:20 +0000
References: <20230721155854.1292805-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230721155854.1292805-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, jedrzej.jagielski@intel.com,
 mschmidt@redhat.com, przemyslaw.kitszel@intel.com, leonro@nvidia.com,
 himasekharx.reddy.pucha@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Jul 2023 08:58:54 -0700 you wrote:
> From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> 
> Fix ethtool FDIR logic to not use memory after its release.
> In the ice_ethtool_fdir.c file there are 2 spots where code can
> refer to pointers which may be missing.
> 
> In the ice_cfg_fdir_xtrct_seq() function seg may be freed but
> even then may be still used by memcpy(&tun_seg[1], seg, sizeof(*seg)).
> 
> [...]

Here is the summary with links:
  - [net] ice: Fix memory management in ice_ethtool_fdir.c
    https://git.kernel.org/netdev/net/c/a3336056504d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



