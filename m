Return-Path: <netdev+bounces-168237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E06A3E377
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA4B1899B2E
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F35214A84;
	Thu, 20 Feb 2025 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZAmqE7H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F8921481A;
	Thu, 20 Feb 2025 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075006; cv=none; b=XYfxe9kYTR+aRNzkN0FxzSwtcqi8y85Ducsc7yO2wBNtbL37aOGzDMFyckKStgGA3lZY0OwTOh3dNLF5j6NppW4366FUrGPOPfNnmrVC02+nOKQO0wMMER9DnMVua387mujkOovBmI5w9wH9O+r8v18MYrHrbAGMyNJbn6OKrkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075006; c=relaxed/simple;
	bh=PXo9iI3CNi+iDC5Lutu4qdjJgJZ+JmddgfrV+YOpQk0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GRk0Dqdc6Qt88VcjFL9+PoHho+sU1E7EkAxdlOYofL3xFlweozZ8b5JISBaS1Wm6+xycxWcJlY7uAZta6CATQcPcWxxedG2o4rr3r7loA62yvbfvqaMw13QdLMCBW8feD34WP+Ox7S+eUB5Z4lQ+Eazw+JItTy85X2H/ELsk4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZAmqE7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5AAC4CEE2;
	Thu, 20 Feb 2025 18:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740075005;
	bh=PXo9iI3CNi+iDC5Lutu4qdjJgJZ+JmddgfrV+YOpQk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VZAmqE7Hvo0fPmM/eXxYK8ZSbTOfZ9bjSjw6nY7lrPdin7gH2NKlySDv7raaaaKY+
	 GXB7KyIf8ddTqzsWDhsWjTokHdZiH/inPApJZIKkXIpyUjTSophY8dfR9KcS7sFsMD
	 nGDyQoQvVYEwvQ883QgU72D30BzvnewjdXi7H0Fci+e5VZJWnd2BI2Sq6a05vpAY0v
	 p666+E4Mi66GJYEm37JB07fuNiICbx2Zzq8i87Cl6qfXLxwvDpf4l4Qn/a2t5gtcu7
	 0koMtwoVh1f6X9f+BAIjLPZQlQ6fp51iFm+eXn4nCUM1ic/K5OQQKDxptbDf3ScLKE
	 jdJQIfhK8N1qQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF73D380CEE2;
	Thu, 20 Feb 2025 18:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] Bluetooth: Converge on using secs_to_jiffies()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174007503650.1411319.5848218735916176196.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 18:10:36 +0000
References: <20250219-bluetooth-converge-secs-to-jiffies-v1-0-6ab896f5fdd4@linux.microsoft.com>
In-Reply-To: <20250219-bluetooth-converge-secs-to-jiffies-v1-0-6ab896f5fdd4@linux.microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Feb 2025 22:51:28 +0000 you wrote:
> This series converts users of msecs_to_jiffies() that either use the
> multiply pattern of either of:
> - msecs_to_jiffies(N*1000) or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
> 
> where N is a constant or an expression, to avoid the multiplication.
> 
> [...]

Here is the summary with links:
  - [1/4] Bluetooth: hci_vhci: convert timeouts to secs_to_jiffies()
    https://git.kernel.org/bluetooth/bluetooth-next/c/44174b3bb552
  - [2/4] Bluetooth: MGMT: convert timeouts to secs_to_jiffies()
    https://git.kernel.org/bluetooth/bluetooth-next/c/b0ade3137c2a
  - [3/4] Bluetooth: SMP: convert timeouts to secs_to_jiffies()
    https://git.kernel.org/bluetooth/bluetooth-next/c/a6228ba15de0
  - [4/4] Bluetooth: L2CAP: convert timeouts to secs_to_jiffies()
    https://git.kernel.org/bluetooth/bluetooth-next/c/12159413e3fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



