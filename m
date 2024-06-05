Return-Path: <netdev+bounces-100888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7408FC788
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438CB1C236B4
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D93218F2EC;
	Wed,  5 Jun 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwSlNIXI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570F31946CE;
	Wed,  5 Jun 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579231; cv=none; b=SqH345cM4KbefJBBDoB4chuYJ1M2tHy19FbFnV0s+ojqi3GtFyQ17Pu+lUIIUWII2KITe51k4P+51VOMGQmt5rQPEiPZMQ3h4HCS+5eYR7CJTAAxMwah2swpK3hxBgd6RUZuvooRDJY+TDpObCur4ofcDBgkWpvjlaMtjm+BJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579231; c=relaxed/simple;
	bh=pXJvOiDTrMyXmV1/40sRtUqWFIp6Ab5KNooW28V0a1c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ejDyumLSt2x8uuLrRKkoE6bP01GdEygORmrpGqyq6idExzqIGTfTK/urzk2e3OKjI8aU2RAQBGU1uPlfI2EWHHSAqOmOkdaq/TD6fP9UHMoIm4kY/44sp+xB2hh7qepQQep5w3wjCknAPz3JAAfVY4pb7o+kDSkNMY25yiejTO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwSlNIXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F34EDC4AF07;
	Wed,  5 Jun 2024 09:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717579231;
	bh=pXJvOiDTrMyXmV1/40sRtUqWFIp6Ab5KNooW28V0a1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dwSlNIXISHPCynaenVaSJfUDQSJDFAbrMVX/WOrW1zL6ObJCpds1bFhx57W6GyU5n
	 RC/eToFia+8tscsaDnLD8IP77B0UOuy7tCY8ixm9SyKKa/gQQGuTAU3FW8kKVNMmyr
	 F0MFxqer+pfKlApcUulUySGUngHfWA5CR+ah5TBGfYcyQtfUf5CoeJmZDqTMEUQMmR
	 4ysxZjQ+j0LfzZYgDfsB3w5mBoZcNQIwVJOOGAhCPF9/06iUlaGaCF8W3GLhh/bz5t
	 NA2BpHcLFLErlFBGDuRgCgAEres0vmwQu6ZyStlZYSR+tGB5ZT7n+UVKM7N5aAnBFx
	 Ev+56yk6SuVzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1007D3E996;
	Wed,  5 Jun 2024 09:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: caif: remove unused structs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171757923091.31707.3192510083025211160.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 09:20:30 +0000
References: <20240531232917.302386-1-linux@treblig.org>
In-Reply-To: <20240531232917.302386-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat,  1 Jun 2024 00:29:17 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'cfpktq' has been unused since
> commit 73d6ac633c6c ("caif: code cleanup").
> 
> 'caif_packet_funcs' is declared but never defined.
> 
> [...]

Here is the summary with links:
  - net: caif: remove unused structs
    https://git.kernel.org/netdev/net-next/c/6f49c3fb563c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



