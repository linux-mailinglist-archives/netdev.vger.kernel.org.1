Return-Path: <netdev+bounces-229241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25534BD9B5A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62FF19A6691
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544273161BB;
	Tue, 14 Oct 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSUQL2sB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301B531282E
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448026; cv=none; b=YXuWknahS/D2uIi9ihzcQnyt5VjzCaF94V+JP8U8PbHMmwCQaVwKSiQwnU2mSDQukkVjtXCd+mDdcHHz5/Jvv8pkIQYbBcdbqnZ6SWAcUl/uVMaYfHxv3AOyntfsVAtTtce5DPACQveBsUVhtUFabhO4aBveILsZg10HlixKp6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448026; c=relaxed/simple;
	bh=mv4VdiBhTTt2+TPTAK/uyPzeVH0PQv4p/1dJ7rSz2hA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jbBz8w5HXTBgLgpp/Li7xCUeqlACvFYSbpaAj2X+7eIN+8LRx0+Q6de3MWqkK5aF5WmTToTQ8r6J2XEA7/jBJA5BWPXFXNwhlHYjG5Ro6fkaURLp4f9MvpuUM5vfevqcS4zms8PjNoml6WsaHcZIUNLC1itHEH+MqtAf4Huc96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSUQL2sB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BD8C4CEE7;
	Tue, 14 Oct 2025 13:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760448025;
	bh=mv4VdiBhTTt2+TPTAK/uyPzeVH0PQv4p/1dJ7rSz2hA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HSUQL2sB+1DC7k+2/eGjl4Vf5MKmKwD7lvjdt+L5n3fgPho+qn0tv0QU9/UdOo4Mf
	 dDW0vwj+psz339uMLWJ+ED6rB/NAGyNilC/rwSMa54W5AJq9cnrB7/oNzlg1SRiMEd
	 DH6hCguff/ylDtCFIkghMxgED7itWm0Lb097n/KAShv8HZaGltmIO2XU0cbZlhwDBm
	 cPrJLYkgwauspwM4qgvgYgGjgmYNATnncw2AYuHxpnBt/wbKUNeWw04c4m4mjc9BSD
	 YQh+MD3QbEXSJkLRZtp+zzmdbKj2nChHmPAbUchGLxFavaejv6m63e/vITgRJOrud9
	 dkv9LwWuOANcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF39380AA64;
	Tue, 14 Oct 2025 13:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] net/hsr: add protocol version to fill_info
 output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176044801049.3743717.7318276453676504978.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 13:20:10 +0000
References: <20251009210903.1055187-6-jvaclav@redhat.com>
In-Reply-To: <20251009210903.1055187-6-jvaclav@redhat.com>
To: Jan Vaclav <jvaclav@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  9 Oct 2025 23:09:08 +0200 you wrote:
> Currently, it is possible to configure IFLA_HSR_VERSION, but
> there is no way to check in userspace what the currently
> configured HSR protocol version is.
> 
> Add it to the output of hsr_fill_info(), when the interface
> is using the HSR protocol. Let's not expose it when using
> the PRP protocol, since it only has one version and it's
> not possible to set it from userspace.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net/hsr: add protocol version to fill_info output
    https://git.kernel.org/netdev/net-next/c/16a2206354d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



