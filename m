Return-Path: <netdev+bounces-242470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F300FC909A7
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD083AC823
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B779226FD9D;
	Fri, 28 Nov 2025 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo4ggw4A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F55526E6E4;
	Fri, 28 Nov 2025 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295988; cv=none; b=P18qFl6IsrwrrYenoNNYWt6dM8HZ9V3bttVLQLC55iwMnAEYc6xsPSQcTBZUAO+o/oXKRNZjuHMnsVoQh6R79Dl1ogzwswNaiEaRygePcrtfMKfO2T3ukwoAIet0jJUn65+zzWrPIznhcMLgr7uyDEJmaG3xDZbAMKnLJuIW0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295988; c=relaxed/simple;
	bh=NberzIKstWpJhkRDZwOMPC5eimdM4ACC4Dp1LcvG6zc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ezc49nZ8slNauDdHr7MHJOeJ+svNT9OPIKVc99ty/5BzRYnHZS30l3mLohY7jr6ndPkpUCdmNQ9cPBF1uRLZ4xMmQaS5JAQtxLkyGk0w603tSWoG2nlMIgtdxTWb9v9UIHbNLoMFpqTmj3cPlRu8nGFfKoyehQEFcwdOE5hviaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo4ggw4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8446AC4CEF8;
	Fri, 28 Nov 2025 02:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764295984;
	bh=NberzIKstWpJhkRDZwOMPC5eimdM4ACC4Dp1LcvG6zc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xo4ggw4Ainal5UoqtfOtsPrB2mImTiG/Czbpc/jd0DS9gWzT8w/6sWvKUnv+IiC7X
	 geTd6++6IXtY3syRpxcXYp38Y4Q2rbtGdMzb0aSPE1YMk+3g4SbSKjIA28gF0U0Gt8
	 c07WljIavqpQHpLUp/XqQYt38DcAEytaA9KAXrjjHolKIV5FZ8Avo/BLyhfUZiR9Gs
	 B6+cfVVtaUOH5Z8Ilfq9qbYsAxSmZTUJplf6vCQBSnplpDtT9f3K8dUp64enSp1ugE
	 mXDQnE+8Wk4MXO67ZHXmj/pAw7Sd9NhuAhd+gcaRG1U/geBKa3A9f9/NbI+zHk05cd
	 w8oTbH32FSZkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2B6C3808204;
	Fri, 28 Nov 2025 02:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] iavf: Implement settime64 with -EOPNOTSUPP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176429580680.112305.4866761396083363563.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 02:10:06 +0000
References: <20251126094850.2842557-1-mschmidt@redhat.com>
In-Reply-To: <20251126094850.2842557-1-mschmidt@redhat.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 mateusz.polchlopek@intel.com, saikrishnag@marvell.com, horms@kernel.org,
 jacob.e.keller@intel.com, thostet@google.com, ahmed.zaki@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 10:48:49 +0100 you wrote:
> ptp_clock_settime() assumes every ptp_clock has implemented settime64().
> Stub it with -EOPNOTSUPP to prevent a NULL dereference.
> 
> The fix is similar to commit 329d050bbe63 ("gve: Implement settime64
> with -EOPNOTSUPP").
> 
> Fixes: d734223b2f0d ("iavf: add initial framework for registering PTP clock")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net] iavf: Implement settime64 with -EOPNOTSUPP
    https://git.kernel.org/netdev/net/c/1e43ebcd5152

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



