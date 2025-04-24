Return-Path: <netdev+bounces-185357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F46A99E7A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 03:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EEE441EFA
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4463418A6AD;
	Thu, 24 Apr 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIPvj4BL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7BA17A2EE;
	Thu, 24 Apr 2025 01:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745459391; cv=none; b=fWTNDnAnH9druUAWavH8r9W8wpJ/ExTsFbU0G6h17xkSPi4OSJoSvZQJw364WzKhSFK+YcDuFdKt0cZYdpPWBDUGfKmU/XWFkjlp+SWG1LhClkgHlBsJ9uMFvrHsJst7ulJtXfwlKW0GIUBN5rALRoEn9JrYg3s8imN1tp1V5po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745459391; c=relaxed/simple;
	bh=okAdnUMdkt77fPNOGoNov2VzUCP19KzZkGl46/1y+w8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jzzfBvLA0owctqXB0YlFdP6Nyjip87urmG/N+YV2erpqyiUvakzxHeB4Cc+WX7UWWgLYL6PD2Tqf6IzeqGP+a+Ie6hO6cXrMp+U5eFFFLGdlmUgUctIsn0oceyWA4rMpBqMhDgyNuvIXEZvaksrsP/PxO1evVqRsCLqYcrczEj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIPvj4BL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A68C4CEEA;
	Thu, 24 Apr 2025 01:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745459390;
	bh=okAdnUMdkt77fPNOGoNov2VzUCP19KzZkGl46/1y+w8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YIPvj4BLeYeqMXk0isir7s8Yu2WBUBo1eModjU8uNIXQn3QFOw5gaLqgkwZBTN/dd
	 OHkZKKCrB/7v0p4xQqGqKLyN8zfNfjDG/0xwxY2ODJ8eQY5fRHyhrkdEE8qa/dAK1R
	 YWPRKbovTAsm3hJkSnMwsuu6y09Ocn+F9HPZUl7J628Sx/MhnsNxEJiolbu7eVV3ZK
	 vvGDISucdRKhKXodmfxj2iH1uGOoVrmAxL7mKuTfQplKieAhtmBnxDaK8Qri5mSkQe
	 lBVqaIGkFCnkmxTDElagKq45fTO4uIlYyo1gHFNmUrJ9Gx0JnVGTmFhX08FSNXSHM9
	 Q8ckLFRJ4tMLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B77380CED9;
	Thu, 24 Apr 2025 01:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: mt7530: sync driver-specific behavior of
 MT7531 variants
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174545942875.2829412.8607382949348037647.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 01:50:28 +0000
References: <89ed7ec6d4fa0395ac53ad2809742bb1ce61ed12.1745290867.git.daniel@makrotopia.org>
In-Reply-To: <89ed7ec6d4fa0395ac53ad2809742bb1ce61ed12.1745290867.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: chester.a.unal@arinc9.com, dqfext@gmail.com, neal.yen@mediatek.com,
 sean.wang@mediatek.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Apr 2025 04:10:20 +0100 you wrote:
> MT7531 standalone and MMIO variants found in MT7988 and EN7581 share
> most basic properties. Despite that, assisted_learning_on_cpu_port and
> mtu_enforcement_ingress were only applied for MT7531 but not for MT7988
> or EN7581, causing the expected issues on MMIO devices.
> 
> Apply both settings equally also for MT7988 and EN7581 by moving both
> assignments form mt7531_setup() to mt7531_setup_common().
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: mt7530: sync driver-specific behavior of MT7531 variants
    https://git.kernel.org/netdev/net/c/497041d76301

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



