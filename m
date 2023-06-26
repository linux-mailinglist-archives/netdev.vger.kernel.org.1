Return-Path: <netdev+bounces-14067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7346373EBF4
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 22:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86A0280E59
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 20:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E9C14A82;
	Mon, 26 Jun 2023 20:42:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15505107AC
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 20:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CE3AC433C9;
	Mon, 26 Jun 2023 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687812134;
	bh=+L005PfmtR6wWWP0Xltnl1KnCOk0d39rmSCki7NghLw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DyDjgqgAM8w77q7+810tcqBaJWt2ouE/nmLhgYxjjreo5izhFTMUiYXrtqc7WMl8e
	 /d/fE/VpZbclT6Kbi9Q8M3LTzSgrurZ7xXyryZ3rJWLhMUea9UTRVDntnmQubgX3kv
	 F7LyohwcoTlyEha2uAoFMep5gKMk/s5PU1FlA4AOrKcm1qHCRo1iaa33QHZx8UkZW0
	 6X7wp3KhApY0tY+hglXQd6RVb0LxG27NdcOMBraBchI/tZt0I+Mn+aSKmuODCBEESD
	 uwTqquZmaW6aFFy3vjIWd55RX08Kk0C+uxnU0hliyD9P89c2bni2PA31wbCkXrdG94
	 kl+RN5FsGxb4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78FA8E53808;
	Mon, 26 Jun 2023 20:42:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] Bluetooth: msft: Extended monitor tracking by address
 filter
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <168781213448.29844.3605670439854920705.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jun 2023 20:42:14 +0000
References: <20230621100031.19477-1-hildawu@realtek.com>
In-Reply-To: <20230621100031.19477-1-hildawu@realtek.com>
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, apusaka@chromium.org, mmandlik@google.com,
 yinghsu@chromium.org, simon.horman@corigine.com, max.chou@realtek.com,
 alex_lu@realsil.com.cn, kidman@realtek.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Jun 2023 18:00:31 +0800 you wrote:
> From: Hilda Wu <hildawu@realtek.com>
> 
> Since limited tracking device per condition, this feature is to support
> tracking multiple devices concurrently.
> When a pattern monitor detects the device, this feature issues an address
> monitor for tracking that device. Let pattern monitor can keep monitor
> new devices.
> This feature adds an address filter when receiving a LE monitor device
> event which monitor handle is for a pattern, and the controller started
> monitoring the device. And this feature also has cancelled the monitor
> advertisement from address filters when receiving a LE monitor device
> event when the controller stopped monitoring the device specified by an
> address and monitor handle.
> 
> [...]

Here is the summary with links:
  - [v5] Bluetooth: msft: Extended monitor tracking by address filter
    https://git.kernel.org/bluetooth/bluetooth-next/c/53c7c193d66a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



