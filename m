Return-Path: <netdev+bounces-155559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1C5A02F80
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 19:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D26B16511C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C3D1DF991;
	Mon,  6 Jan 2025 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOVgnalF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A021DF26B;
	Mon,  6 Jan 2025 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736187017; cv=none; b=YHky0irzZGzDbsK7ot3WH4znWgxcKCHlhaE0ByoHfgFIdZq7z2VepCUKivqTgtfT4pEguehAGuQ2el0K5ewI+aBQXLgE/SqWksdo40JzKTR17DFzg3mOx/lzYIDQtDgFAZAc79NOdVYcXPQpaWSukfIO0dI3USPPv3MjoiPNMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736187017; c=relaxed/simple;
	bh=HDRfwyjWcpZdxGe5mxw9b0857FneO9FKBH8ns7GXGxw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kNm9tR8js/84DAkjWT9Ye8gCUmtr3Bmdcb9/toCzqgam16H0QJSIVuCGrypzT51rtgFvAxCTKsrzbOKbQaGXKoHxL0u/f4dHHHpPvlhZMs/r8WDh4EEC7gQwAZWFmxCu3FhS2ttVpVdJIYCv8zRzTtFM+mAod6qGyNjE/x4qSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOVgnalF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F968C4CED6;
	Mon,  6 Jan 2025 18:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736187017;
	bh=HDRfwyjWcpZdxGe5mxw9b0857FneO9FKBH8ns7GXGxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UOVgnalFgutDkFsC+tNuoRxsxHIr/2rY1RsPmvafSF+pWmAc8NC6fFhSKf3IYERUG
	 N43OaL2mZrwQXP8UEGCvVGbD7uT5LqLAVlOeb/eKFTn5JiU2M6DrWaiWBbLcRtS/vs
	 Pe4Ji2NN73tyiNr2SRNdwggvYnaXoAiaG2R3DMh3KIY7asXTVi78P5ItAJmz95aku4
	 KYlKBux4/PtF5milAIha1n9nDSpwlbORZuRBgzaLPJru6migAeQB7grKWWa/VzCG7a
	 QSsmLMG1x0QpdLsxpWVNdJOGZRkHqJMCnU7EngN+wwCNKFgWYMCA7hVAQtB9T/0DMt
	 KhoZQewqIBIfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB9380A97E;
	Mon,  6 Jan 2025 18:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci: Remove deadcode
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173618703849.3577621.11756538459673947760.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jan 2025 18:10:38 +0000
References: <20241216012636.484775-1-linux@treblig.org>
In-Reply-To: <20241216012636.484775-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Dec 2024 01:26:36 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> hci_bdaddr_list_del_with_flags() was added in 2020's
> commit 8baaa4038edb ("Bluetooth: Add bdaddr_list_with_flags for classic
> whitelist")
> but has remained unused.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci: Remove deadcode
    https://git.kernel.org/bluetooth/bluetooth-next/c/5db2921c27a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



