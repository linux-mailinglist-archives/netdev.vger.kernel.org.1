Return-Path: <netdev+bounces-142789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4AA9C05FA
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934431C21372
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D907A20C474;
	Thu,  7 Nov 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmtHNgc5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3051DB534;
	Thu,  7 Nov 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983228; cv=none; b=XS8RI0hKdKhik+2ZAjp7tjMLMY4JChwDlxOJVjoWel7JSZPJwaEL3RpeBmYNpYi6IbjcmC0MK/KVC2TDpEP4TtmrqhE+oey1ZzB9hKrK5BNAk9IXXssMYP/wy+xLuGoIS0LtCibEv96da2wKd4Yg/fOe9dvNOoERPsIikZWw24U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983228; c=relaxed/simple;
	bh=VZ/R76eZ40KfZxIQM47Eo9NR0UwGvAKmLQ8wW76gHE8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q3vXZhR4Lhe6E//Sck0fS0SKfmdxiJysf6ker/PwNn4mfzBoAaNH5GPZvR6XbUAU8eTYhe44GIpRSaKLUBgNU0pOj/pdZd4BDBN5QgRVjD880YpMRHmZcTsVQw1ZxnvwtAh/Jsrbs9NRavrUIp7YziQcf4LW6tO4syRn8cncxZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmtHNgc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF80C4CECC;
	Thu,  7 Nov 2024 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730983226;
	bh=VZ/R76eZ40KfZxIQM47Eo9NR0UwGvAKmLQ8wW76gHE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RmtHNgc5aEh2jxi4LKZXroPeeq47lr+t5xy/sjX88jCya+GqX/J23XpfTXiHkbo+P
	 RkA8aL9tmby/TCWLNUuHku7wuB8l63MMBCBNrFM9wX0+3Ymg8fydtjGDkRIgzVX6Bs
	 vtTE28ikWXgdpm4UILIzcRJ+/JYjeuX3+/r+CFtodst2X9BkJa/4/cYOlCgl/3nuRA
	 AwcqX74NgvsR86bxTMveB+M1h+M5NmIk9+D7LGHotpxVd3EY36gpbiOP9OVqkOg2Wh
	 IYM2FJN7T9qe5mjoTjKMgcgO82f1BhXBcVrVaHb8TJwEvm0CQ4uES1rNlZP1vHwC6v
	 88HD52YJcLtBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F763809A80;
	Thu,  7 Nov 2024 12:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v8 0/3] net: wwan: t7xx: Add t7xx debug ports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173098323525.1650074.3036692889717501713.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 12:40:35 +0000
References: <20241104094436.466861-1-jinjian.song@fibocom.com>
In-Reply-To: <20241104094436.466861-1-jinjian.song@fibocom.com>
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com, corbet@lwn.net,
 linux-mediatek@lists.infradead.org, helgaas@kernel.org,
 danielwinkler@google.com, korneld@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  4 Nov 2024 17:44:33 +0800 you wrote:
> Add support for t7xx WWAN device to debug by ADB (Android Debug Bridge)
> port and MTK MIPCi (Modem Information Process Center) port.
> 
> Application can use ADB (Android Debug Bridge) port to implement
> functions (shell, pull, push ...) by ADB protocol commands.
> 
> Application can use MIPC (Modem Information Process Center) port
> to debug antenna tuner or noise profiling through this MTK modem
> diagnostic interface.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/3] wwan: core: Add WWAN ADB and MIPC port type
    https://git.kernel.org/netdev/net-next/c/495e7c8e9601
  - [net-next,v8,2/3] net: wwan: t7xx: Add debug ports
    https://git.kernel.org/netdev/net-next/c/61329a1152dd
  - [net-next,v8,3/3] net: wwan: t7xx: Unify documentation column width
    https://git.kernel.org/netdev/net-next/c/238f2ca1e61f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



