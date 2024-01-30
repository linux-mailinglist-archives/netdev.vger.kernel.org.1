Return-Path: <netdev+bounces-67264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6116842863
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E071F275E1
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81F17F7F8;
	Tue, 30 Jan 2024 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgqBRwj9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B458160B9C
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629826; cv=none; b=p+KesoxzQVdfH8b74xNQtGOape1u8Wj8k1j1nBXYE971I/JGBziU2pGqeKqZFahu1ufm/PUgLNR0BjLIasIZ9wHwn6LuhUVPxO1vo9xHBBMgV2fL2NEXywxotltOcIpzyLtr2Wua26J0ZGyjUeqj0WXN3mFq3ai7nPzrdH4oEwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629826; c=relaxed/simple;
	bh=7eTDma3LoGnTBW5qdGxJhlx3cYP0+phX0+u5TexGGno=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fqJvDfZKoS0BhWeIX8UB+Oc2smVCj7ch72Nuo/FUJQ69IZH7/BESGYiD4KXinTEUzoYXQKsr30Y/FMXCsO/NLIE359mTxgy6hvs2UiJCJz9SuBdJdKoVkpqQ3MmPKKAlntSpXbNVAXRT6hwSMzREwWWONEN5b7dg7tvxbW+b0cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgqBRwj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FC69C43394;
	Tue, 30 Jan 2024 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706629826;
	bh=7eTDma3LoGnTBW5qdGxJhlx3cYP0+phX0+u5TexGGno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VgqBRwj9+uJq0fO7a49li1cdViabhS/uw8a0disztIeI72Hlh6SH8EaVGCQRAijK5
	 xtUkhBinCT3iw39/4WaSCpyF+3/2FFe8CC9Rb3QvUgpeKn1bBQ8641LeSWpQbdG7C+
	 ngfxUGmHZy2CzuzF0G3dpJ1ELttdwAUm42z6UpRw+wN6djyRJdV2yRCvj1+tBg7JF+
	 kAfTbjb4s2MIupHAWZc4o/wHhh+f5sXeeYdBsKPnycaydxUOWdfVbREx4hGt6pUTWC
	 aIl8oo1PNsmFndyuU5PSIWFaLJ0BgOAXXi9C1LmCXnvpf2dkKQjb44UaZ4dvbX/xRi
	 crRpjcmnkvULg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11146C4166F;
	Tue, 30 Jan 2024 15:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/2] tc: add NLM_F_ECHO support for actions and
 filters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170662982606.21426.5326733957699110382.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 15:50:26 +0000
References: <20240124153456.117048-1-victor@mojatatu.com>
In-Reply-To: <20240124153456.117048-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org,
 liuhangbin@gmail.com, jhs@mojatatu.com, kernel@mojatatu.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 24 Jan 2024 12:34:54 -0300 you wrote:
> Continuing on what Hangbin Liu started [1], this patch set adds support for
> the NLM_F_ECHO flag for tc actions and filters. For qdiscs it will require
> some kernel surgery, and we'll send it soon after this surgery is merged.
> 
> When user space configures the kernel with netlink messages, it can set
> NLM_F_ECHO flag to request the kernel to send the applied configuration
> back to the caller. This allows user space to receive back configuration
> information that is populated by the kernel. Often because there are
> parameters that can only be set by the kernel which become visible with the
> echo, or because user space lets the kernel choose a default value.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/2] tc: add NLM_F_ECHO support for actions
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=071144c0bbb9
  - [iproute2-next,2/2] tc: Add NLM_F_ECHO support for filters
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=cf0eae9a9fc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



