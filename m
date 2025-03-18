Return-Path: <netdev+bounces-175895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA28A67E25
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 21:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D693B32F0
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05B121146B;
	Tue, 18 Mar 2025 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO7Se1Kh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89158211469;
	Tue, 18 Mar 2025 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330567; cv=none; b=eHY9mN8DdZ/RP9OAEI1tSS/svGUqm/kGxuIOj7O3A42vDW1K7qyc6TrLfaoxj+Fl0QFP6FqN+xwMQjplMvGPenYf48BklSCwv+Oqjef/JoFtfa4+1OMzsgbHrZ1+gD9nNlyAV/2ClyCz8r+5ycWbq0raoXbL1zjESlAcHQGcx8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330567; c=relaxed/simple;
	bh=7pUlekghFkawj7eZRcp8JZr5LG2ZYk+481ioLihrxF8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uc6+kQRN6bP6SSw/w3OBSXmqwLsuXJIjD7Z9LQdOsb5zjtAW+v+KcUZwen8nnGkDsK8lyGN2U6hxYHh0itEDzhz76pvi72UDRSxvG7vv9HhcakbIRX8yQdRtAmRXKjMwcwXMepmgBe0FKHQswG43zLktk7QYzkbn86rja79jZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO7Se1Kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9A3C4CEF0;
	Tue, 18 Mar 2025 20:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742330567;
	bh=7pUlekghFkawj7eZRcp8JZr5LG2ZYk+481ioLihrxF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PO7Se1KhyEaGh9pbrW2+KaIXdCVP2+9YF65+eNNmQHJ24O81lE3CBRDnrZZnahx32
	 Su6T4FZqF1M8CyJGx0gWyEB2Qlb8iNRQolAvLlXzCoA5STRer9/Z0LdOPq9O4vQpfs
	 ATBz8MRI6+C9pyJ/1LZIv9oFuqX51sgenDwX4UN1QAutqboN8r4b9nXLyfksHQasca
	 i9+bwh4APtb9lu/Ku7U5uwBfSOu6sM3Tn1ZoV6s076L2DgAUmUIHhKICSs625fRYtN
	 I9lSGmt9UUoK7XNZbQFhOWB/TZiPf4Vp6UNn465d9xRzNcDQRDSTlMh/Bm8USdTKl3
	 YY9xA3TsjuTtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE02A380DBE8;
	Tue, 18 Mar 2025 20:43:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-02-21
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174233060224.450362.9417723444677002801.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 20:43:22 +0000
References: <20250221154941.2139043-1-luiz.dentz@gmail.com>
In-Reply-To: <20250221154941.2139043-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Feb 2025 10:49:41 -0500 you wrote:
> The following changes since commit dd3188ddc4c49cb234b82439693121d2c1c69c38:
> 
>   Merge branch 'net-remove-the-single-page-frag-cache-for-good' (2025-02-20 10:53:32 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-02-21
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-02-21
    https://git.kernel.org/bluetooth/bluetooth-next/c/fde9836c40d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



