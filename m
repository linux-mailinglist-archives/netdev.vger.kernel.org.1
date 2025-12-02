Return-Path: <netdev+bounces-243144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEF2C9A064
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 05:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA5C3A3C44
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 04:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D2329D292;
	Tue,  2 Dec 2025 04:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKVlah/N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5FC176ADE
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 04:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764650598; cv=none; b=Iivl+EIa1mQKlxAE68o67fnrTJnWcMoxMCrhYJKGQA+uLcIt+5x/k6eYIV8Xerf4xTJBRdHtN3UCPFlMBo0iMDxZn+1PfGA2mx4c682jnG1VoByQ+lMcU99DmllPBxLLYF28IAOzqb/0YJfo32IuEsEAaRR49ez1o/mleoOq4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764650598; c=relaxed/simple;
	bh=L4aGpbvAgLEJBuDAj0z10+DLy43Y7jJWfHpY9n0Lz5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RpWfLK2uYA8uNzFdWUGYj0hhUOZXBE/jTMDM4j3VTPqBFv6ZA+YyHNppl1si6ijYBj7wMStG/mG5WQsCxBvUCp1BvxFBsIMJLFkPCAnGkGnWz275y9tpFvfkeYCImN2c9kupRj0OVP8AFZOtCf+UTjPiZfgdNRSifvGpN1ooBpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKVlah/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81934C4CEF1;
	Tue,  2 Dec 2025 04:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764650597;
	bh=L4aGpbvAgLEJBuDAj0z10+DLy43Y7jJWfHpY9n0Lz5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rKVlah/NITxxjt0E9PPTPvXzKWxqN/Dt8ywL+o40iL8BJVYKPvX6UohDj8NLHGppe
	 /a4aiCJHYAaWLRTZ2+Sw5mSRFrLbyaGWCaLe4a6LEMEYf1FiFteYpXRnv5EM6DVn/i
	 4JfW97dFwcpACPYcXo5i+18lAGR5T5qLQvkS4w0QRAzm5UK07fnXBz9gRXemhwj7jh
	 2ipWEiPV9IE6HAm++e/FTI+CK6Vtwh2B7qhDERoo2Z6cI1mtJIeq0cF/vuEMG0X4N2
	 WDwI84RJAjaPKMr1x5ll4Ibt1Kbtgf36F9+rUY3JAxDdKOF3Cehti8gxClRNG2Kava
	 FW40EH19Hrbcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 786CD3811972;
	Tue,  2 Dec 2025 04:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] wireguard updates for 6.19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176465041729.2674275.13136738775993392206.git-patchwork-notify@kernel.org>
Date: Tue, 02 Dec 2025 04:40:17 +0000
References: <20251201022849.418666-1-Jason@zx2c4.com>
In-Reply-To: <20251201022849.418666-1-Jason@zx2c4.com>
To: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jason A. Donenfeld <Jason@zx2c4.com>:

On Mon,  1 Dec 2025 03:28:38 +0100 you wrote:
> Hi Jakub,
> 
> Please find here Asbjørn's yml series. This has been sitting in my
> testing for the last week or so, since he sent out the latest series,
> and I haven't found any issues so far. Please pull!
> 
> Regards,
> Jason
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] wireguard: netlink: enable strict genetlink validation
    https://git.kernel.org/netdev/net-next/c/e0e1b6db2e4b
  - [net-next,02/11] wireguard: netlink: validate nested arrays in policy
    https://git.kernel.org/netdev/net-next/c/aea199fa1571
  - [net-next,03/11] wireguard: netlink: use WG_KEY_LEN in policies
    https://git.kernel.org/netdev/net-next/c/9755f9de8fac
  - [net-next,04/11] wireguard: netlink: convert to split ops
    https://git.kernel.org/netdev/net-next/c/73af07d7f2f6
  - [net-next,05/11] wireguard: netlink: lower .maxattr for WG_CMD_GET_DEVICE
    https://git.kernel.org/netdev/net-next/c/b8bcc17f583b
  - [net-next,06/11] netlink: specs: add specification for wireguard
    https://git.kernel.org/netdev/net-next/c/6b0f4ca079db
  - [net-next,07/11] wireguard: uapi: move enum wg_cmd
    https://git.kernel.org/netdev/net-next/c/b5c5a82bf5cb
  - [net-next,08/11] wireguard: uapi: move flag enums
    https://git.kernel.org/netdev/net-next/c/8d974872ab29
  - [net-next,09/11] wireguard: uapi: generate header with ynl-gen
    https://git.kernel.org/netdev/net-next/c/88cedad45ba1
  - [net-next,10/11] tools: ynl: add sample for wireguard
    (no matching commit)
  - [net-next,11/11] wireguard: netlink: generate netlink code
    https://git.kernel.org/netdev/net-next/c/3fd2f3d2f425

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



