Return-Path: <netdev+bounces-70777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D4F8505CB
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 18:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A01B1F24E7D
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 17:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB99F5D478;
	Sat, 10 Feb 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JO/Va7Jq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F05D468
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707587427; cv=none; b=PUpWQjcDwUrJ8SIykKgYPPTSQSWMKLRHrbU2gJcvoik/j9KvZPdjFhGJHx9Ao47rjbF8Gw27T1f4cb9YQYVQNawJUN28dxkh8gziaKf4S1qV+pMQKR2ZA/pDRgS4NGksMUBDhHuOqEiGyRUudpptOrzr/CecB+w06gmjEfW9HvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707587427; c=relaxed/simple;
	bh=DHGLSL3CQJIdRpDLztqJgC7Ue0voMjHRKtRM3MIamvo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nP8hsZ52xLRGtrvCObploY+w2vZMc4e/fC1NWqWoMdKUQ/hxjy4noqAgOY2Fumzh9eN3dhMIac4FKFLhkWvaf3ZHjkqAWaYA8SEAFT7VZQXBJ0jZcJFALUsre5HOJD+nc+WVmdOC+YxsN3oc0r4Fodlme4LU0fZ2SZJ8Ff0SQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JO/Va7Jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 520E6C43394;
	Sat, 10 Feb 2024 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707587427;
	bh=DHGLSL3CQJIdRpDLztqJgC7Ue0voMjHRKtRM3MIamvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JO/Va7JqoDY8u/BeS7BAa06izZYUo2DLnxqb/CmMKNvYY/CBss2UrIr6yhPsgaGY0
	 JM6I6u8VDKKnHMMw0jyqpHgN6R5tAzuJB6JGanX0GuaF3IYbCkyj7RAqOeQDwUlQc7
	 GG6mDZhboDqLBn4b396a4qb6Oni45+paKK9KzjSLUmFJbr9XqCBY4zzB+wbGsYoXmj
	 iR2BTBe0f/Zgm1ByEJQat6b8urpJScgyUXK24YZwDw3ALMqV9Bxrz01NzEu6wJj/TP
	 vdBh/1RqKs+1iQrjCCGdOfO4cu4R9sPZ76kEs/JP4U2Ug0B/rtRhwIvZck2vJHj1ea
	 JTf4JWxluJeKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38664D8C98B;
	Sat, 10 Feb 2024 17:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] tc: Support json option in tc-fw.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170758742722.9212.7117414751285405568.git-patchwork-notify@kernel.org>
Date: Sat, 10 Feb 2024 17:50:27 +0000
References: <0106018d8e3feccb-51048e17-d81c-4a1b-97cb-bc3809ad3eca-000000@ap-northeast-1.amazonses.com>
In-Reply-To: <0106018d8e3feccb-51048e17-d81c-4a1b-97cb-bc3809ad3eca-000000@ap-northeast-1.amazonses.com>
To: Takanori Hirano <me@hrntknr.net>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 9 Feb 2024 14:22:50 +0000 you wrote:
> Fix json corruption when using the "-json" option in cases where tc-fw is set.
> 
> Signed-off-by: Takanori Hirano <me@hrntknr.net>
> ---
>  tc/f_fw.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [iproute2] tc: Support json option in tc-fw.
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=49a8b895adb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



