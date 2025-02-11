Return-Path: <netdev+bounces-165114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8125DA3081D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97743A74E0
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 10:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777AE1F3D4C;
	Tue, 11 Feb 2025 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mqfz+9/6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0E1F3B9D;
	Tue, 11 Feb 2025 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268605; cv=none; b=ZbQfWTqZh09JDf73V/Z/K+iKUOv1AaYMlOfGhxVrQHmJMi6hl9cPhuY2DNGmiBTnda4X0nhWLRPf9IvgHO2sivp7/rSZkbpVnPhFNh7LweuMzyGDyPcQU9VXZn/6TYf4A7nLuZw4ozyIm4YEDQGMuCfVlmvDINl68W+TE3TWEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268605; c=relaxed/simple;
	bh=YJANGVTw8wTx34KTjdL2OijBvng9VAE9hp6jSaJbIsM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=anNE382ojJ0DbgxUf6oG9jzrrzPpG3WEcBrK3Uv2EujaP/Fxi219xa/DrAuJTNCA8ZWnRhfQhIpokQuC1Pc66ldMAvlObGrdguj53Y5c5VBhaQqYzdRyLMxiL40qilpg96+4n9aoJc18I9DpJxt96MzhEVJMDp0bGLXUaw8wLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mqfz+9/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA96C4CEDD;
	Tue, 11 Feb 2025 10:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739268605;
	bh=YJANGVTw8wTx34KTjdL2OijBvng9VAE9hp6jSaJbIsM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mqfz+9/6VXtPhsDOGmu5397bcjD6Gl8eXNCxDBXv5zpWkhJom9ud1V42o5f2QNJqM
	 w8zyqm8o/XfEwB6OPtNIkwY2QsrfiSvdgdgvqvFIC9lG1kw/jZaOXCcMuHEN0NuEU9
	 KJpnF393A9QT66x7VISGI2ZeQvClIbyV4kEUNfwMZCipmKhKClm3Tr9YVz+Jnd7VD9
	 lAnX0DM7vuYZXEqkin8i7PpEOY0kwcVyXnD5pDP9WN6mEWNlfdIycxU4aX8r/60b8g
	 WKDx5BSxyCi/rfXvPZ3KWrswiRFxKK3ByYBzRk+NdDcwWj9OhmSByCmHX86ftVS+WK
	 3jHKG16Y5daOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBAE1380AA7A;
	Tue, 11 Feb 2025 10:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: fec: Refactor MAC reset to function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173926863381.4015335.12106412978404201635.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 10:10:33 +0000
References: <20250207121255.161146-2-csokas.bence@prolan.hu>
In-Reply-To: <20250207121255.161146-2-csokas.bence@prolan.hu>
To: =?utf-8?b?Q3PDs2vDoXMgQmVuY2UgPGNzb2thcy5iZW5jZUBwcm9sYW4uaHU+?=@codeaurora.org
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michal.swiatkowski@linux.intel.com, jacob.e.keller@intel.com,
 horms@kernel.org, wei.fang@nxp.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 7 Feb 2025 13:12:55 +0100 you wrote:
> The core is reset both in `fec_restart()` (called on link-up) and
> `fec_stop()` (going to sleep, driver remove etc.). These two functions
> had their separate implementations, which was at first only a register
> write and a `udelay()` (and the accompanying block comment). However,
> since then we got soft-reset (MAC disable) and Wake-on-LAN support, which
> meant that these implementations diverged, often causing bugs.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: fec: Refactor MAC reset to function
    https://git.kernel.org/netdev/net-next/c/67800d296191

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



