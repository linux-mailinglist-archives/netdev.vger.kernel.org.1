Return-Path: <netdev+bounces-63461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C72482D1F0
	for <lists+netdev@lfdr.de>; Sun, 14 Jan 2024 20:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CCC3B2103E
	for <lists+netdev@lfdr.de>; Sun, 14 Jan 2024 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F23010796;
	Sun, 14 Jan 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwJHsco6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562DEF9D8
	for <netdev@vger.kernel.org>; Sun, 14 Jan 2024 19:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6388C433C7;
	Sun, 14 Jan 2024 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705258824;
	bh=u75k7k3FVhcq26XCjCfdiU94ik5k9Kd922OdqEhxH/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QwJHsco6sa9m8vrOUYYYC9uxJppyadYfzFBpmYsQnDyneHQEtRKo4biZDIb15Vr3f
	 ogo6OXaYWHN7gMRFx7MryUulWgfSyosXQUJpyu4OiWHOtuks2TQzwpNbQ76cztVUIY
	 NKb1jMmCrMJtM/v7ww9b8wNFcR9o64ZaEnb2v73V5SmQGM3WtYbCyhcbbxrw5INnvM
	 XRNzTZeZFL4K5SYalxwdaHMk/c24ag5VztLNsxqWEQnaFiw4Tf7Vy65Exe9XxuWhqL
	 GTJGF4U1+LUKcSv35Md975TMbqn4DoRULLT8gOGuoohbzllAlFUb+zipgcCH8i2pbG
	 NZ7AfQGFlOiMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA213D8C977;
	Sun, 14 Jan 2024 19:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] Revert "ss: prevent "Process" column from being
 printed unless requested"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170525882475.7355.238306960540225489.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jan 2024 19:00:24 +0000
References: <20240113165458.22935-1-stephen@networkplumber.org>
In-Reply-To: <20240113165458.22935-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: qde@naccy.de, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat, 13 Jan 2024 08:54:10 -0800 you wrote:
> This reverts commit 1607bf531fd2f984438d227ea97312df80e7cf56.
> 
> This commit is being reverted because it breaks output of tcp info.
> 
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=218372
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> [...]

Here is the summary with links:
  - [iproute2] Revert "ss: prevent "Process" column from being printed unless requested"
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f22c49730c36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



