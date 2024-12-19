Return-Path: <netdev+bounces-153221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 944219F735E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 04:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D521169151
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E009819CD19;
	Thu, 19 Dec 2024 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohXIWaMb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AED19D060
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734579020; cv=none; b=A0mpxwIAqWMjU0Fq5Cd27gVUVLw3d18HPknBqIAA/L6HOEc761id4xQYEY6gUkQpwIol4w6PNzbjorVUf71ERbWiSts7SL+RJIZxJHHJr7snXjyRj9ytB7VqIK3Z5Pv89NDaVaZUTx36Nsh388Q01GQ8IGFoxR2gFLlb1iz0ETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734579020; c=relaxed/simple;
	bh=LFHR20RHY8nmBaqSqYQkrjDpnuy0heCuaw5A/Pz8hJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h5QN59gfikIdOfT1NNDsyKG3gsh08JciPUfR1ECbYzJihb55b/+2dYDkS8VPFolabbyM4XrAg2gU79ygoHuqnMrSmi5RS3RCBdmwoJBFsn0/GHEcNO1qynFCsgqAq4X2cUPq3PLEKj0DJrlNF+mabyc4T0nXbiugbiEvaf9b4oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohXIWaMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3500FC4CEDE;
	Thu, 19 Dec 2024 03:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734579019;
	bh=LFHR20RHY8nmBaqSqYQkrjDpnuy0heCuaw5A/Pz8hJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ohXIWaMbDNl94TVkRCDL85N1JpZPU0cb0/+ojQgWcL9P7gbkUJd1Sj80VmuQCHh98
	 AN6JJ+x0x+WGDMJgh5FkUXME1ODWPRIh77n1KVvzwmh2iJJQV9KeLBKo6Ftuk/nyMe
	 menXysbeAqEeMN9R8BxwJpVGc+NxIVpFI9nC6E1rEv5Ft8r6ruNc9GEtgg7BVYAkKa
	 0n1gXE3J4Hf75Fl90F58M/75Vx9HLEEi+ZFW5obw93zBa/xFtshZG0eRqExsP8M4CP
	 qQ/oXTmI17W7iZlGd1OodLneDwKN4QCazPsmLZg2gE4S7K9V9Lko5cNwevnsHPdlQJ
	 P1tEfkZ2YD0DQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF603805DB1;
	Thu, 19 Dec 2024 03:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2][pull request] idpf: trigger SW interrupt when exiting
 wb_on_itr mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173457903649.1807897.8033600250266557543.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 03:30:36 +0000
References: <20241217225715.4005644-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20241217225715.4005644-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 aleksander.lobakin@intel.com, joshua.a.hay@intel.com,
 przemyslaw.kitszel@intel.com, michal.kubiak@intel.com,
 madhu.chittim@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 17 Dec 2024 14:57:11 -0800 you wrote:
> Joshua Hay says:
> 
> This patch series introduces SW triggered interrupt support for idpf,
> then uses said interrupt to fix a race condition between completion
> writebacks and re-enabling interrupts.
> ---
> IWL: https://lore.kernel.org/intel-wired-lan/20241125235855.64850-1-joshua.a.hay@intel.com/
> 
> [...]

Here is the summary with links:
  - [net,1/2] idpf: add support for SW triggered interrupts
    https://git.kernel.org/netdev/net/c/93433c1d9197
  - [net,2/2] idpf: trigger SW interrupt when exiting wb_on_itr mode
    https://git.kernel.org/netdev/net/c/0c1683c68168

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



