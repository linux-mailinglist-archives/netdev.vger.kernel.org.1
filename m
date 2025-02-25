Return-Path: <netdev+bounces-169441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55BFA43EEF
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB453B0EFD
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C079267F67;
	Tue, 25 Feb 2025 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBPCBiR0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68843260A57
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485404; cv=none; b=kf3kiUibh/bIKob/lF/I1gTmgfVwnW7Hmi/lNgichVDvebOTK+WLlvUH9A9U24JaY6mrqUCwlrG1O8sUGIoaOWB+w1rmNWwyHr1Ct1IrV/27LjPyBg01LvXn9m4oEy8t74pugXVs+1t7FZW5BMHDsfvU7Ih0D4XgGkigYjLfOIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485404; c=relaxed/simple;
	bh=4zBQ4jL9wWWtuO+yfV/X1NfdlCkJ8R7ycnnp97OGjqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H11Y/rfjI3C0F0/v6d/cP8h06btf8nIu9UBYbUe2G+v2iAZZv8XuvakYD+kcxAnKwXjL5RgTFdR4mztj/HeIeVgFS91M7Uv4FhjUB0maTs6SvnekdTOkre6CwSSRnllbi83+diGQ+DNJJA3NgC9Je/Ihkr+jWFctmHQtJJGx5sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBPCBiR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81C6C4CEDD;
	Tue, 25 Feb 2025 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740485403;
	bh=4zBQ4jL9wWWtuO+yfV/X1NfdlCkJ8R7ycnnp97OGjqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CBPCBiR0tcGrNpzJ3aea3Fc+Bzd6BKAWrLVvSFRZ4JSuXSc5JaUY80Uzg4YJlOsV3
	 eYS1zqNEquXqLOVxd/8zgxB7WGul2Jw/bK+zVOGruV4dE/rqcL2NleI8G83wLrTOTD
	 zZmGtGp5GeLcdIbiI9ivH4HbRlUwcXQViClS++v5NpbopseaZ3yRrKdPScDrsnX9YF
	 7rS+2P1N3cdhxCCouQZ/V542Q863POQlPawvmPSg1FFx4+Kk8tYDNnS7c9Gjq9gQ/X
	 VvcYPlJjJ6TxQfUFksPKUGKl7S1DcOrsicBOZNovCEJw1qdO0HgarBI8vR992zIoDY
	 1mSI6xcUg8l9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEF2380CEDC;
	Tue, 25 Feb 2025 12:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] eth: fbnic: Update fbnic driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174048543551.4149470.1578682154331880325.git-patchwork-notify@kernel.org>
Date: Tue, 25 Feb 2025 12:10:35 +0000
References: <20250221201813.2688052-1-mohsin.bashr@gmail.com>
In-Reply-To: <20250221201813.2688052-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jdamato@fastly.com, sanman.p211993@gmail.com,
 vadim.fedorenko@linux.dev, sdf@fomichev.me, kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 21 Feb 2025 12:18:10 -0800 you wrote:
> This patchset makes following trivial changes to the fbnic driver:
> 1) Add coverage for PCIe CSRs in the ethtool register dump.
> 
> 2) Consolidate the PUL_USER CSR section, update the end boundary,
> and remove redundant definition of the end boundary.
> 
> 3) Update the return value in kdoc for fbnic_netdev_alloc().
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] eth: fbnic: Add PCIe registers dump
    https://git.kernel.org/netdev/net-next/c/c6aa4e2cdff6
  - [net-next,2/3] eth: fbnic: Consolidate PUL_USER CSR section
    https://git.kernel.org/netdev/net-next/c/e4e7c9be2117
  - [net-next,3/3] eth: fbnic: Update return value in kdoc
    https://git.kernel.org/netdev/net-next/c/26aa7992b456

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



