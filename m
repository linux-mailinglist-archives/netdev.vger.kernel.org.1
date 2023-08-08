Return-Path: <netdev+bounces-25637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1E9774F8E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D268B1C21039
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A973D1C9F8;
	Tue,  8 Aug 2023 23:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C21BB4B
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E36C2C433CC;
	Tue,  8 Aug 2023 23:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691538621;
	bh=114riDFUpQjWkJtCP3k3d8ja1snCzoP6qxT01yQBUjE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L4Q0HgK91f+LfYw+J3ga6ljGeu3QjdyIE1mdA7pzZRFF9Z0OkymcE5rcomkzTWWxm
	 vemgDbnzICAU8j6cBwW0t+earguIB6yRsiiK6vrq1pq5gfF/Y2OA/oa9It6S05hyPY
	 7VgEfbX/geVlLy9yx0LxbELXt6Xz4OvqHvV5GjlZT8FftZQUNuRSFWlC5CNDUv+/+k
	 J4KXaEGwTkzgchilq3fN/qkUs5IeiPPg70f5GKahqI+9rw7xiTSxsVKtl6WUo3PTYf
	 OSeY6eKiIA6sJBLF5KHnYbxXxe2BU7ibOWl0BC+raw4LpiZ0Zta+yHPTgneg77VLiP
	 buY8I5Dta3Cyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCA49C64459;
	Tue,  8 Aug 2023 23:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igc: Add lock to safeguard global Qbv variables
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153862083.1266.9348831842382997225.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 23:50:20 +0000
References: <20230807205129.3129346-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230807205129.3129346-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org,
 muhammad.husaini.zulkifli@intel.com, leon@kernel.org,
 naamax.meir@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 13:51:29 -0700 you wrote:
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> Access to shared variables through hrtimer requires locking in order
> to protect the variables because actions to write into these variables
> (oper_gate_closed, admin_gate_closed, and qbv_transition) might potentially
> occur simultaneously. This patch provides a locking mechanisms to avoid
> such scenarios.
> 
> [...]

Here is the summary with links:
  - [net] igc: Add lock to safeguard global Qbv variables
    https://git.kernel.org/netdev/net/c/06b412589eef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



