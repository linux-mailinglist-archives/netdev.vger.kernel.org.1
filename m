Return-Path: <netdev+bounces-102292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF4190238F
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D543F28B84D
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713CC15098A;
	Mon, 10 Jun 2024 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r60OMkwd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A814F9FD;
	Mon, 10 Jun 2024 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028212; cv=none; b=KleBnQUdN25n8m3yX0EnGRw8dxIJpj8RBggcP3qiijDz/TWgrjHMla5BuFSMe+bDoJKYEzKiUeuDy0Q262xUIcoq3BHxTRsXEiRw6HPnigye6zXPOIHt0TuZNCaakC/3mjV4tvp+346niYzoVaezEyQEm5sOUSu3W8wAsA7vE1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028212; c=relaxed/simple;
	bh=TJFgYFoarlwarKU8ibHn8fuCcroyby1ChvuIleGsJrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mOw/IjR2Nu1HlUvJ/7Pq2bIX2jBwrZgX1GVA+hjei52fbRtOHbyKUOlBalFMiJNDvL3J4LF1x0+h36WQTX4z8qL3Dpt+qw4jybyVlyVdAwHj/d0aqAMgKW6z8AW5fMDa9vM4GoFH/PpD8r2A3tBpO04/aVhxC3KD6kvTJ0CPTYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r60OMkwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB34DC32786;
	Mon, 10 Jun 2024 14:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718028212;
	bh=TJFgYFoarlwarKU8ibHn8fuCcroyby1ChvuIleGsJrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r60OMkwdsYA8f7hYSD3gNv6dnEwMwUo616a+rOteItKAOlpGgspNh2UE/XQXB0S0d
	 HrpIjPY5iwEOAu4/ZXtlA8X/Cr/4CskglLCDR9+NBAk7n5WPuuONfNqaZd75l/iZC6
	 NKbgm5rpY+zvroS418vQ+gEkg8h7L0ZXLELZdN+A3pCBE292UIfDkwxONQBBifwgpZ
	 eY5IGMS7G3jD0E2pbHJVINu/UDlVYd3Bg78jFco5AjNmm8Tq6HIIYs33MFvZFMs0Pj
	 8GRRQ5qSQb9nwB1cLkhpLw6BdV1MoZyzyzIVWhupltVgg1b0eVgvL6Ko3lElv/HdJ2
	 7BtHbdlKR25lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D16AFE7B609;
	Mon, 10 Jun 2024 14:03:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2024-05-14
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171802821184.16143.6011335078863757009.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jun 2024 14:03:31 +0000
References: <20240514150206.606432-1-luiz.dentz@gmail.com>
In-Reply-To: <20240514150206.606432-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 May 2024 11:02:05 -0400 you wrote:
> The following changes since commit 5c1672705a1a2389f5ad78e0fea6f08ed32d6f18:
> 
>   net: revert partially applied PHY topology series (2024-05-13 18:35:02 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2024-05-14
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2024-05-14
    https://git.kernel.org/bluetooth/bluetooth-next/c/79982e8f8a01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



