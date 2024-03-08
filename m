Return-Path: <netdev+bounces-78848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E41876C56
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 22:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65877B20ECC
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 21:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0AF5F879;
	Fri,  8 Mar 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttkDhhhw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDAF5F56A
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709932836; cv=none; b=rydwdSFdFE+vI/EXsfIb/C0bxV1cs0ubNtqG6Pc9d14t3sWvVstP8mwT1w3z1OnFF8ppKjUzXGu+6lC18p+r5rhH8h+mzCxI9TpgwDFfozU2c6oVocwGfWx3BVGRGU1ubsP9HpuvyaLSrpGZ+jKgG/TSOMd9UGbpsaTq+q3BQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709932836; c=relaxed/simple;
	bh=idcW0njKGXLSQuG+r/fW91F9NRdIyGTgJXht6dwcQOU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YoJP4T1klcA6CX+bEg5Ncz5e6Q1NHhYy97U9nwEXA9AMbtopOaMZHLyg+rnCxv7sQZP4zFvMraZzElojV2z1gQF+nMghkQOT7IpszUDrdNiRiI3CseHhrBz/RJuxXR3unirvvsA+vQvt2wJRiOnqs8hwvT2xJqcV1A3ydzzkdn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttkDhhhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80209C433F1;
	Fri,  8 Mar 2024 21:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709932835;
	bh=idcW0njKGXLSQuG+r/fW91F9NRdIyGTgJXht6dwcQOU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ttkDhhhwfocTAiRMpi7C1CV5cZ96ULlnqaOIp5W6Y10ILxMM8J3b+z7k05KdYutIY
	 FSW/L8cMTOouOnX+vwFbnmcrOnCu8PQdSKzHjMY6+yrgd3i0KGJ66H74UW1wOcK4xD
	 E46Xwr6abd92LMp0ZOl2iguwoFDq/5+OG7JsCDrld2YfaZ4LT20688EliIDznOjuH9
	 w6GJjol6bow5UBKKLk9afe/Yp1QhTsnkMjNqwU7DkC7jamDHcdOZp5qEWkZhNyvPhA
	 yilQXZMY5gs3XnSWo3BtXeYkl8xocf6J8W8zDc6NnpAhmRcENMj57HrEbXh7lLsm1/
	 +qZz7SrB5dMuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65601C59A4C;
	Fri,  8 Mar 2024 21:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: add skb_data_unref() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170993283541.29743.10698098060752281245.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 21:20:35 +0000
References: <20240307123446.2302230-1-edumazet@google.com>
In-Reply-To: <20240307123446.2302230-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Mar 2024 12:34:46 +0000 you wrote:
> Similar to skb_unref(), add skb_data_unref() to save an expensive
> atomic operation (and cache line dirtying) when last reference
> on shinfo->dataref is released.
> 
> I saw this opportunity on hosts with RAW sockets accidentally
> bound to UDP protocol, forcing an skb_clone() on all received packets.
> 
> [...]

Here is the summary with links:
  - [net-next] net: add skb_data_unref() helper
    https://git.kernel.org/netdev/net-next/c/1cface552a5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



