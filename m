Return-Path: <netdev+bounces-18546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9095F757944
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09781C20CB8
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6E779E6;
	Tue, 18 Jul 2023 10:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BA315AC1
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 126DBC433CA;
	Tue, 18 Jul 2023 10:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689676222;
	bh=wJb5Tkb0KPUMcoVKEvFO/azYdR3u8GibeaQNPl26FNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QgYFfGQBZugOjTonWriAcc0Ds4Qn9kxivZDdI9oc7o2V+HtzfQGhmmK7MOnk7e0jw
	 q/evHrCSWb2tk+1K49/wuq2zE0Anq9C8+NrA08ZFObYALcFB3FOg4DFkm9/fNP0c44
	 s7OUW0gmUyek2EkGDbZy478h+G7ujR0YL/syDjMevaUhHioN3E5FsgKQ8MYSV9trok
	 WAKrmJyijNez86HwDKq6AE62KODeyCPPoN3BANDR8QYJqBhGuJFy0u4x7GrVfxuuf7
	 gcy459bssxwiWCl9oYaMVOdU+yRSusdo6+XHfH4SabYwWtAunNZEW1PAYkIoF+Eo7V
	 CspT7vybqIyCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E627EE22AE6;
	Tue, 18 Jul 2023 10:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] igc: Add TransmissionOverrun counter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168967622193.32239.15471079383200468311.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jul 2023 10:30:21 +0000
References: <20230714201428.1718097-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230714201428.1718097-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org,
 muhammad.husaini.zulkifli@intel.com, sasha.neftin@intel.com,
 vladimir.oltean@nxp.com, naamax.meir@linux.intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Jul 2023 13:14:28 -0700 you wrote:
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> Add TransmissionOverrun as per defined by IEEE 802.1Q Bridges.
> TransmissionOverrun counter shall be incremented if the implementation
> detects that a frame from a given queue is still being transmitted by
> the MAC when that gate-close event for that queue occurs.
> 
> [...]

Here is the summary with links:
  - [net-next] igc: Add TransmissionOverrun counter
    https://git.kernel.org/netdev/net-next/c/d3750076d464

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



