Return-Path: <netdev+bounces-183379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ABCA90895
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FEB63BF8DA
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D1220E315;
	Wed, 16 Apr 2025 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohfdzcEq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B223204F8A;
	Wed, 16 Apr 2025 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820394; cv=none; b=ftQaiFW0TeXcXeS7iI/r06UPEaLXoYfXWyY7sWi5PwPnHk1TY3tJ52RAT1uZPxgVzJ5czCLh6bjhdOforNXw0OHxEQF9SX+XNgsuZa7dsipZmhBpeahdaW0sjbc5/utL4J0HgTU/J8IQdfVZj2Uk6me5BBH+WyhS3GSlDtDnzWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820394; c=relaxed/simple;
	bh=KstZziaNodfbJGDpMOYATqgz7fJwSStO2y7FfcYiK3s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nrPXrXfHDgKjmL6BQHF/CrERvdKDA0IgkYnUtzYKRIH5AaRQQopH2quHC++O+mUqCUbrM8fkgaOP43KTP9NSZDRfeDkJKAIA3PYd7TnUzmz6BeAMHzdLvnp7K7Ej2OafUzhYkvVQTYbY7lbUOpEIYOmOdMSogEESP1ENfrjuJmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohfdzcEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071B2C4CEE4;
	Wed, 16 Apr 2025 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744820394;
	bh=KstZziaNodfbJGDpMOYATqgz7fJwSStO2y7FfcYiK3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ohfdzcEqGWf/Wwu5J2drjdMG5sMnG/exrEZVj8GtyaOwX72bV8+d+uT1rcnaZVp9Q
	 OuTcqtbGqTc/4cLhQ2WwckuQFQ2HW6n8Mj9Wdt9X0/bNCf9Z5BrP+AhoR2n2eYClww
	 7L2AGqM7sWGfYymtwbDt6zrD7O+GJ+cG/9jTvNPAY9QhYfc/2ywMaUTOeA29kQdbmd
	 Ays6CYxm01VNHGIqr7zW+MUz/RtbxDmtvaDhGtwYCNaNces/NaShuJ56NTu0qeC6xo
	 mKP2BPETnKAwprWsRkhPynYq+Jsa05KffUqdyGOHq3HYWKAPOuOIOEcnsby6ONS3yg
	 zyVuqUXChY5nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C243822D27;
	Wed, 16 Apr 2025 16:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/4] Bluetooth: Introduce HCI Driver protocol
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174482043201.3420647.14476412419394286176.git-patchwork-notify@kernel.org>
Date: Wed, 16 Apr 2025 16:20:32 +0000
References: <20250416095505.769906-1-chharry@google.com>
In-Reply-To: <20250416095505.769906-1-chharry@google.com>
To: Hsin-chen Chuang <chharry@google.com>
Cc: luiz.dentz@gmail.com, chharry@chromium.org,
 chromeos-bluetooth-upstreaming@chromium.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, johan.hedberg@gmail.com,
 marcel@holtmann.org, pabeni@redhat.com, horms@kernel.org,
 yinghsu@chromium.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 16 Apr 2025 09:53:35 +0000 you wrote:
> From: Hsin-chen Chuang <chharry@chromium.org>
> 
> Although commit 75ddcd5ad40e ("Bluetooth: btusb: Configure altsetting
> for HCI_USER_CHANNEL") has enabled the HCI_USER_CHANNEL user to send out
> SCO data through USB Bluetooth chips, it's observed that with the patch
> HFP is flaky on most of the existing USB Bluetooth controllers: Intel
> chips sometimes send out no packet for Transparent codec; MTK chips may
> generate SCO data with a wrong handle for CVSD codec; RTK could split
> the data with a wrong packet size for Transparent codec; ... etc.
> 
> [...]

Here is the summary with links:
  - [v2,1/4] Bluetooth: Introduce HCI Driver protocol
    (no matching commit)
  - [v2,2/4] Bluetooth: btusb: Add HCI Drv commands for configuring altsetting
    (no matching commit)
  - [v2,3/4] Revert "Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL"
    https://git.kernel.org/bluetooth/bluetooth-next/c/3947fa617367
  - [v2,4/4] Revert "Bluetooth: btusb: add sysfs attribute to control USB alt setting"
    https://git.kernel.org/bluetooth/bluetooth-next/c/79f21135b7b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



