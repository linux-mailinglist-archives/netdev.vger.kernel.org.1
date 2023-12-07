Return-Path: <netdev+bounces-54714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B82807F34
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 04:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C5A281B9A
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 03:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A6E5229;
	Thu,  7 Dec 2023 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk2ZjadO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276444C97
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 03:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97BC4C433C7;
	Thu,  7 Dec 2023 03:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701920423;
	bh=JSt02PB4YOdWbXyANgxT1uEFC2W39xGWDHp13WWM3H0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hk2ZjadOWb6G5VOeN48cM5pMlLBJnuy6sQIV2gU5TyrZynEXCgOcwolEdYwpTBCk7
	 38MT11/ThB+IY6vOwpOCcmPXUy+8B2VCvH2qK4Ke9ZCkL+nE+GuWtBJgyvO3f9xhJp
	 XsDCshHjdTDCF7INpkskX9ha/KuYNISOWX6uYqccqa7G0wZE5yKcVyBZa0MpJyxlyE
	 ayzbrdgDnOVFFqWkjPlWirThgeJc8awYFoP+PWGVxx79V6cuNBI1JX/hkEzd2RJF3e
	 j5FDfGfB2/1Glx37T7eW8uxnywW/8afNWHHCsBmGErZ1ZnwIigBICXXvwJojfTeDJL
	 unuVTfBhC19eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DE46C395DC;
	Thu,  7 Dec 2023 03:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: rtnetlink: remove local list in
 __linkwatch_run_queue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170192042351.21604.5809466447036359247.git-patchwork-notify@kernel.org>
Date: Thu, 07 Dec 2023 03:40:23 +0000
References: <20231205170011.56576dcc1727.I698b72219d9f6ce789bd209b8f6dffd0ca32a8f2@changeid>
In-Reply-To: <20231205170011.56576dcc1727.I698b72219d9f6ce789bd209b8f6dffd0ca32a8f2@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, johannes.berg@intel.com, jiri@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Dec 2023 17:00:11 +0100 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Due to linkwatch_forget_dev() (and perhaps others?) checking for
> list_empty(&dev->link_watch_list), we must have all manipulations
> of even the local on-stack list 'wrk' here under spinlock, since
> even that list can be reached otherwise via dev->link_watch_list.
> 
> [...]

Here is the summary with links:
  - [net-next] net: rtnetlink: remove local list in __linkwatch_run_queue()
    https://git.kernel.org/netdev/net-next/c/b8dbbbc535a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



