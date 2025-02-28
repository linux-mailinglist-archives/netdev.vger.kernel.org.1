Return-Path: <netdev+bounces-170538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E3BA48EB7
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4DA3B6BF9
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26D87602D;
	Fri, 28 Feb 2025 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQQHrPpD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3852F37;
	Fri, 28 Feb 2025 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710398; cv=none; b=ZaiJ+rSknV+sWLWv/04SdlGkOVthTq1BAI3glUg9a1Z9ByK9CaRgZDygoMqOvcvNIvWX8OLmEPCSkGv/1NxyXZRMd4RuoIMTeJz/x+3D7ynLcec1+Y7kjqAKMgLl5xO2uBmsFM8bQCMXjaxQf7xF9+M1Dvb5Z2XUVWHOkRByQZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710398; c=relaxed/simple;
	bh=n0lGgWpVMdnQZ8WaaunYSs+CDhI/VkhN2UbParMgr2A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VgWCZx/qSG2kbclTAGxvNQcIniibLtr6//thx7aso9SC9e6pKCyAXYhLjI1MM9qLCA/akkXh1JMz2mSb5svSS85jrQ7kDg9tfTz3V5hgF5sSGf1uZ1X+LqgJsw1wYlgEIhZQlX0fxxiZ2ooz3MzCwzivQmaWqhzLuXtyJJ8j8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQQHrPpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26155C4CEDD;
	Fri, 28 Feb 2025 02:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740710398;
	bh=n0lGgWpVMdnQZ8WaaunYSs+CDhI/VkhN2UbParMgr2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lQQHrPpD+qj/hLOXAvWRKd+wUtlnOEvLwA1qNuPa0Xm5IeQ/ApRUE7/M4B38OJUMS
	 UoiDSempoQesgGf/J74EmhD5qO7Mo+DWCWNcFzLU6+mM08kmZr7cJ4l0LsEuIIUJ1P
	 hNgzdZWAlSS3XFGwO9njIS0gbOunwlhPhC7SoMZt5zxZ036v/gTh+81ARspORygJDx
	 ahb415ZWI8n7o4OwrbaZuL0Y0TOOiDLt/2fbx8PXTVO30LyTFaRDwoLaDMbEHC8Jj6
	 rzhwWa/+a4KryvShnTEUYuVPzG+jgN51Y5N2yZCmLirQbxUGdBKRUvneN5YHsqnq7W
	 fjtLvWFYOFNrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71F10380AACB;
	Fri, 28 Feb 2025 02:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/4] stmmac: Several PCI-related improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174071043026.1661895.15370002818806136916.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 02:40:30 +0000
References: <20250226085208.97891-1-phasta@kernel.org>
In-Reply-To: <20250226085208.97891-1-phasta@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, chenhuacai@kernel.org, si.yanteng@linux.dev,
 guyinggang@loongson.cn, chenfeiyang@loongson.cn, pstanner@redhat.com,
 jiaxun.yang@flygoat.com, zhangqing@loongson.cn, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Feb 2025 09:52:04 +0100 you wrote:
> Changes in v4:
>   - Add missing full stop. (Yanteng)
>   - Move forgotten unused-variable-removes to the appropriate places.
>   - Add applicable RB / TB tags
> 
> Changes in v3:
>   - Several formatting nits (Paolo)
>   - Split up patch into a patch series (Yanteng)
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] stmmac: loongson: Pass correct arg to PCI function
    https://git.kernel.org/netdev/net/c/00371a3f4877
  - [net-next,v4,2/4] stmmac: loongson: Remove surplus loop
    (no matching commit)
  - [net-next,v4,3/4] stmmac: Remove pcim_* functions for driver detach
    (no matching commit)
  - [net-next,v4,4/4] stmmac: Replace deprecated PCI functions
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



