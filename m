Return-Path: <netdev+bounces-110231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1557292B87B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA8D1C21A1B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EBC1581FD;
	Tue,  9 Jul 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbQ+0UFR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842A14E2F4;
	Tue,  9 Jul 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525230; cv=none; b=SSN/l3yc6yu7/9tWN3HRGh81ik9RE/kh3K77rTbkMSGMD22zqcwDobJvIUpqMZtzKZL87IVfRr2LQ5c/J8StEbK6IIzxtNEilg17rn7vxxb1BRlUjeqrq4rfGO8P2gte/0En3Chpw+dJoBnc2HoWzoduYAFGxJ7sdV2rIJqcLg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525230; c=relaxed/simple;
	bh=xsBl9e8QCqfrvUpdjtobQ6OrEQ/DXbcLXlkYT62dAT8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UOB1ZaxVHvGXA41PBWXjm9OgCAlMhtYnWyc2EB/OMwvmrygYggzS0p5EVZKUsp0u5RClogFdf7N2XhrScUFZFgaYVQCtnQAAt9ZXVQrk0Ds6d+UImXxH5Bce0fckl33y2U1Lka72cSkKsmj/sol1mE+tLVGKTCaCYFeUPoXEmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbQ+0UFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F380FC4AF0A;
	Tue,  9 Jul 2024 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720525230;
	bh=xsBl9e8QCqfrvUpdjtobQ6OrEQ/DXbcLXlkYT62dAT8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WbQ+0UFRriUHUOL5PzLHbU9Ds0HCnwtQ9Jvc2D1nmiMvtzsxEVx9D11tHEvlRWSCc
	 Vj3Qp8sQ2Wf4Ag1ibTnW8t34KNOFNDSe9DfItAt3dPKVIXnnRvtzPmoTqluutFHIzF
	 xZMPovNp6aZihvJOc1Hyg9OxRghInyPat45FULAV8gH1e3HioTzR9SZcy3kC/GB1mz
	 sZWiQxgszUALGy0BR3V3tC+yl8GyOu+m8V01Er6+E5wrX945fS0j8EgKDSZDsObQ8S
	 UpY8IIaz4GI6+kjVor0ZNNGfkoTsFYB2jYrgRxmj6bSLnz2Sp/raaPAXY0idPhxMYB
	 zY7cO/l/R65Wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0EFFDF370E;
	Tue,  9 Jul 2024 11:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] udp: Remove duplicate included header file
 trace/events/udp.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172052522991.22504.14341003716947156675.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 11:40:29 +0000
References: <20240706071132.274352-2-thorsten.blum@toblux.com>
In-Reply-To: <20240706071132.274352-2-thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  6 Jul 2024 09:11:33 +0200 you wrote:
> Remove duplicate included header file trace/events/udp.h and the
> following warning reported by make includecheck:
> 
>   trace/events/udp.h is included more than once
> 
> Compile-tested only.
> 
> [...]

Here is the summary with links:
  - [net-next] udp: Remove duplicate included header file trace/events/udp.h
    https://git.kernel.org/netdev/net-next/c/0787ab206f80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



