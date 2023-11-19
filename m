Return-Path: <netdev+bounces-48982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD037F0442
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 04:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82215B20927
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 03:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631D1877;
	Sun, 19 Nov 2023 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0ukeFBQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B904A22
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 03:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B300C433C9;
	Sun, 19 Nov 2023 03:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700365827;
	bh=ItPzV8+ubQTa9qu2x5RDe5SnmoWrVLGhuzsP44gJgTc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u0ukeFBQYdc8Y1u5+ZBBYjcNNW9HCy18eD+NiZ4i5QskG9/DQQkOlinepaJ3LmZXe
	 cZFnjRCKwNBoqxq6FyJ+5WahtPCqqqfMUbiQYtoyffc3VV8+BTDD3nfmA4wp2M9/1h
	 zs1u/PeVFF4NY6552e9c6YPAe1q5qDJ7R7Kzahm5GhwXadQnUzqtdabwinqpxkTyrd
	 6yEnEr6mY8S00O6E7oMqULCp0e3+vuQ/ghxopoKwU1jjubun2774U6WHEm0lDHUZ+8
	 GEkmFvq+efkGYFnIiznrDYNYp92jy6BkkxnXWzNL9m+CR+JEq8GHf5XwN3zvZ9jP6S
	 KExEzeTQo5iDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC683C4316B;
	Sun, 19 Nov 2023 03:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15][pull request] ice: one by one port
 representors creation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170036582689.8585.5797152260444122288.git-patchwork-notify@kernel.org>
Date: Sun, 19 Nov 2023 03:50:26 +0000
References: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org,
 michal.swiatkowski@linux.intel.com, wojciech.drewek@intel.com,
 marcin.szycik@intel.com, piotr.raczynski@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 14 Nov 2023 10:14:20 -0800 you wrote:
> Michal Swiatkowski says:
> 
> Currently ice supports creating port representors only for VFs. For that
> use case they can be created and removed in one step.
> 
> This patchset is refactoring current flow to support port representor
> creation also for subfunctions and SIOV. In this case port representors
> need to be created and removed one by one. Also, they can be added and
> removed while other port representors are running.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] ice: rename switchdev to eswitch
    https://git.kernel.org/netdev/net-next/c/5a841e4eb8ed
  - [net-next,02/15] ice: remove redundant max_vsi_num variable
    https://git.kernel.org/netdev/net-next/c/ab5fe17cbb06
  - [net-next,03/15] ice: remove unused control VSI parameter
    https://git.kernel.org/netdev/net-next/c/ff21a4e6193f
  - [net-next,04/15] ice: track q_id in representor
    https://git.kernel.org/netdev/net-next/c/7c37bf99a60c
  - [net-next,05/15] ice: use repr instead of vf->repr
    https://git.kernel.org/netdev/net-next/c/5c53c1224f24
  - [net-next,06/15] ice: track port representors in xarray
    https://git.kernel.org/netdev/net-next/c/af41b1859024
  - [net-next,07/15] ice: remove VF pointer reference in eswitch code
    https://git.kernel.org/netdev/net-next/c/e4c46abc7291
  - [net-next,08/15] ice: make representor code generic
    https://git.kernel.org/netdev/net-next/c/604283e95eb0
  - [net-next,09/15] ice: return pointer to representor
    https://git.kernel.org/netdev/net-next/c/deb53f2030e7
  - [net-next,10/15] ice: allow changing SWITCHDEV_CTRL VSI queues
    https://git.kernel.org/netdev/net-next/c/292e0154006f
  - [net-next,11/15] ice: set Tx topology every time new repr is added
    https://git.kernel.org/netdev/net-next/c/86197ad5800b
  - [net-next,12/15] ice: realloc VSI stats arrays
    https://git.kernel.org/netdev/net-next/c/5995ef88e3a8
  - [net-next,13/15] ice: add VF representors one by one
    https://git.kernel.org/netdev/net-next/c/fff292b47ac1
  - [net-next,14/15] ice: adjust switchdev rebuild path
    https://git.kernel.org/netdev/net-next/c/c9663f79cd82
  - [net-next,15/15] ice: reserve number of CP queues
    https://git.kernel.org/netdev/net-next/c/19b39caec062

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



