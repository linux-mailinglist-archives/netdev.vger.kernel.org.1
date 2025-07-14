Return-Path: <netdev+bounces-206848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C6DB048DF
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6EC4A17F3
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1C7238C2A;
	Mon, 14 Jul 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gc2/GmZu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323BF2309B3;
	Mon, 14 Jul 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526786; cv=none; b=jy0meB6wfgBTlF4oXYAPDxrqQAmadyninB44wxpheC0dVLj2vJo1O94T/oHx6V6EvVZuguJNB8JeTCz2RA4xiiyKTrU+FJQnbQupey4B8zvkI1x9JpIpz3gmMzbEbRCkk7EzGKCWHencY5DrpWXg6lCdQIXrExe8iZNv1oCke00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526786; c=relaxed/simple;
	bh=AKg3u/1beg9ku7KUMG0/joiB9u+EyqGoTep9cjfVYkA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qhFjWDVSH/39MjHZ4f5GW2c+Bww5Hx9WahaTnsH4LFcGB9LOFkJc7isk9VCxkS8wxnLLCp1DN02uemXtjkqBGMKZGhSLgilCQYqPmL8Q7Uyf2CZuBsJVi10+VdIg3GCF1tdJMy58Tusp+wJe3t9LsKt6jYKpWZGS94u98qZOqZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gc2/GmZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976DEC4CEED;
	Mon, 14 Jul 2025 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752526785;
	bh=AKg3u/1beg9ku7KUMG0/joiB9u+EyqGoTep9cjfVYkA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gc2/GmZupd273ndF9fZ++59H3lKj1CVkT6bBnevagiuTfX/RGF1xSotpgYN5oMLRP
	 //GTOR9z7UW2mkNcH7UPnqGF16eJ+aFrYACgRbMzl962cfLrrkpRMZoXBBsdkBhFOF
	 bTQiz4SkvEq7Jf/olxaRxdy52re7lfSqQZ+XOjDgnxN6TTVXpqhRTB1x93RVcriD/5
	 Q5DWWeWmyO7vk7+42WZHoI0hwSF/UYsPZAxeY+VsNtFKB3K1mHq9lxF2olt0zIXSLR
	 l26G1Le1GkDXoPHtdi71OTEWK04r7oTYtHklQAROpJTSLofLaCB46+MPpr0QxQ1EQH
	 JXVS6ZB8floRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD5D383B276;
	Mon, 14 Jul 2025 21:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: ISO: add socket option to report packet
 seqnum
 via CMSG
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175252680551.3985397.8458330929215889889.git-patchwork-notify@kernel.org>
Date: Mon, 14 Jul 2025 21:00:05 +0000
References: 
 <712e0e6752a8619bdde98d55af0a9e672aa290c2.1752511130.git.pav@iki.fi>
In-Reply-To: 
 <712e0e6752a8619bdde98d55af0a9e672aa290c2.1752511130.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 johan.hedberg@gmail.com, luiz.dentz@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Jul 2025 19:40:37 +0300 you wrote:
> User applications need a way to track which ISO interval a given SDU
> belongs to, to properly detect packet loss. All controllers do not set
> timestamps, and it's not guaranteed user application receives all packet
> reports (small socket buffer, or controller doesn't send all reports
> like Intel AX210 is doing).
> 
> Add socket option BT_PKT_SEQNUM that enables reporting of received
> packet ISO sequence number in BT_SCM_PKT_SEQNUM CMSG.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: ISO: add socket option to report packet seqnum via CMSG
    https://git.kernel.org/bluetooth/bluetooth-next/c/b3a08d3efd5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



