Return-Path: <netdev+bounces-161411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4584A21321
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 21:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CA01888141
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 20:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053291E98E8;
	Tue, 28 Jan 2025 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMAVSXuZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C808C1DE2C3;
	Tue, 28 Jan 2025 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738096207; cv=none; b=UtV1goSI9oojvf6NmjgBhF3o2Q83MUyCe4RR8OsBzp0pnW1E5kaLQFaWKdf0lKLTGJRIqgeVqcg2UkjzXKx/2isv56716sr3Jrjk+hz+UzzjtondSxAJLRstsulxJBW9yJEnIQaAR/s7LAE/ub8F+ilgdrGW/4bqxU65+Wf0hNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738096207; c=relaxed/simple;
	bh=MhLQhkH2iTv4pZiXNhY7bLzBF5m5NLcz07Y9mN16uXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TjsgOx2RwgS/3dJsgw71XbqyIZbxOIcsM5UKC20LRyNZPi//2FIJFZwOM1RFYkGSCK9TR6OPFuWOTDYoKRVqp4L2AAmKMLeaK9RbFwQqTHtc4VQ+FqRE2ZhBwhCFcuYHSHeZzEPnuBO1Yy116R4Xg88kuOEqfJ0OG8TiRphQPuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMAVSXuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DCBC4CED3;
	Tue, 28 Jan 2025 20:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738096207;
	bh=MhLQhkH2iTv4pZiXNhY7bLzBF5m5NLcz07Y9mN16uXM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qMAVSXuZXeIcLhN385+X6uNWYptut8BS0i2booUzU/Hrpv+YmY1oS/YZhh1MnO0oC
	 56RjkVA+zbu7uTlhvXIbrHllCuvfKyGBTkZ7oX1bm0w/Imix+AIyer1aPwvwYC2EYU
	 Sb9ktO3sdZPlag3yU8MKwfni3Gj4UMdB7L48Px2onJQrEB0CduxD5sLv3FBTtqALqm
	 3DA1l+OfoNjwujsH3UhaK2MemAsldYaE2jOViTx8Xx7xQRAEny8+6b0rCxMR75wdMJ
	 8GFO1Iqglr4koQkEtzKX+japg2pjG+q9L72ZCcJuRiYnBrRhz4Vm2ruI2Najnlf9QT
	 A7oeqXybMzDAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 349E9380AA66;
	Tue, 28 Jan 2025 20:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: MGMT: Deadcode cleanup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173809623301.3912505.5958977606230134366.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jan 2025 20:30:33 +0000
References: <20250127213716.232551-1-linux@treblig.org>
In-Reply-To: <20250127213716.232551-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Jan 2025 21:37:14 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   A couple of deadcode removal patches.
> 
> They're both strictly function removals, no internal changes
> to a function.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: MGMT: Remove unused mgmt_pending_find_data
    https://git.kernel.org/bluetooth/bluetooth-next/c/f694e720fddd
  - [2/2] Bluetooth: MGMT: Remove unused mgmt_*_discovery_complete
    https://git.kernel.org/bluetooth/bluetooth-next/c/55b8d4c01dde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



