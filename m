Return-Path: <netdev+bounces-241745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4F2C87E66
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 538B04EB4DA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF1730C343;
	Wed, 26 Nov 2025 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBId4o2a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB32FDC30;
	Wed, 26 Nov 2025 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764126066; cv=none; b=BnUSD0UHoV397ShfcIGFjYwHR8V+FJ+6wbfdcwmGNYM+fxjKUNYt65tqKh0P5Eq7lOydOdnD0XG5i2lA9285Jh8zCkbimKqikArpM4+L/H2WQW1Ts7zf7FK7Uxl7TjksKiL5IA8Y4tk60kQpWBMaDi9D5RQPw9nadP6eiYoBpfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764126066; c=relaxed/simple;
	bh=kvdM6ffrf69FMNVVcjLkX1kVVihs0UPl11nsBmtHA6Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VnPLh+wOYSDMZQADxUGsfsNf91qWmQHf1KWryWqcbc8mpQ+M1FyMBimJOlpSXWo3P5FfH/aEjxSFeL5JHB+kI961o/Ei/SvPuG3UxijM2+FKEdVqRclKnOQmCrXfZgb4Q/4OVkhissdsemxLyiqVsCNBH9x61HQccqRKy0otmmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBId4o2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044A4C116C6;
	Wed, 26 Nov 2025 03:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764126065;
	bh=kvdM6ffrf69FMNVVcjLkX1kVVihs0UPl11nsBmtHA6Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WBId4o2axFHhDwb7Z+JsHtWOR5dgQYqWtBftha8YPL2eZoiXMfTAOWkL7VWdnITDr
	 FFvWOwz/2r9P9yPA3lKCKbVoBaQMy3owFpwbMkAHaYlO+UGIfEx2pN5R8aELqirfE2
	 riJMKU6TTGSg+bPPefhY4gAKViG/OZcuQtRehYOWZ7njdc8k+Z9AKhadzH06oU5f0H
	 LzsMsRwYfYJS1uLnZgzBL77E2E15+DcU+Nz2ONXQXsMVu9Ij0LKanF7HMd9h0TeA42
	 XhWHPGMdato1Wm9oezYj4Eia6Kx7oLMuft/3EY19kQQhMyVz4uZMGvThgl/bnb3Ab6
	 EVQfEaLZk4RWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FAD380AAE9;
	Wed, 26 Nov 2025 03:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] r8169: add support for RTL9151A
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412602699.975105.18102053890905739629.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 03:00:26 +0000
References: <20251121090104.3753-1-javen_xu@realsil.com.cn>
In-Reply-To: <20251121090104.3753-1-javen_xu@realsil.com.cn>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Nov 2025 17:01:04 +0800 you wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This adds support for chip RTL9151A. Its XID is 0x68b. It is bascially
> basd on the one with XID 0x688, but with different firmware file.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] r8169: add support for RTL9151A
    https://git.kernel.org/netdev/net-next/c/d6eea0048bc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



