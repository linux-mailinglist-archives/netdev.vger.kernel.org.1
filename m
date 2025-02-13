Return-Path: <netdev+bounces-166216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA948A350AB
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 22:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F3E3ABB8A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 21:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234F2266B56;
	Thu, 13 Feb 2025 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDeYuDdT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB1200132;
	Thu, 13 Feb 2025 21:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483279; cv=none; b=HeWuYNeIOO9xi1LqgiPm29qCl4QiZ3t3BfpX+rXCi2lpfZCUOzZZ008UakntoZLY27wSeT96fZcdqBsIG6gPv5qu/PV1RYZ8jAfaw2/U1YBVW6cs7JFbInFy+xOpPqpjoB/65hxmuGHVB1p7MqxRCT5A1eGZytfL5i/tDsSn+RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483279; c=relaxed/simple;
	bh=QSQF07/tj7d71QOr4EKEeyx34uFoxlVNmLVS9PS30iw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UydWwsGQicSgTePdTesN8uT2A2GZ4uIHpilcJr6gIJUllgc3sICLXHad8+b8Yd1QG90rLCsLKn85307cY1Dn6aPxyEqPYCRf0H9KihcA0mWcTr0Og0nW281Vrk7IaIABrg7hnv9V6QrbI8QKbP2ukDJpmiENbrMt6xYkWx1yigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDeYuDdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4C7C4CED1;
	Thu, 13 Feb 2025 21:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739483278;
	bh=QSQF07/tj7d71QOr4EKEeyx34uFoxlVNmLVS9PS30iw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lDeYuDdTejZlQhbEraGtVNpMdsXOCxxYwC5MwjBbW9byax9jAIKjFASi3pz1J79+y
	 S+oyFLbC7tI2vNwtrnq77jjfKTPa5tZ+cNI6UVnWBDX4s/uTxiQlJmQnvPYBULqC+r
	 FPfIvRRTdh7xmtBl4VYA+poTVmVPM6kfJfNVdQHjjJTeTQ/5aYFZiwZW3sgMT/afm2
	 F6N7KvbZhOv3+2BrJSOLbmdj9xDz/MW/Bv0l/t0ZbkeKR5LtnbLsPXJF/js3fOFv5I
	 j2xBH/L9R2Jaf/RcWd6Wh8rlYaIih5zyw8TzS5CcVJkstKJUL6EjhWjP5b4HapFgcQ
	 cYiX37aF1ifBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD5A380CEF1;
	Thu, 13 Feb 2025 21:48:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2025-01-29
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173948330776.1382183.9349026567293779428.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 21:48:27 +0000
References: <20250129210057.1318963-1-luiz.dentz@gmail.com>
In-Reply-To: <20250129210057.1318963-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 29 Jan 2025 16:00:57 -0500 you wrote:
> The following changes since commit 9e6c4e6b605c1fa3e24f74ee0b641e95f090188a:
> 
>   bonding: Correctly support GSO ESP offload (2025-01-28 13:20:48 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-01-29
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2025-01-29
    https://git.kernel.org/bluetooth/bluetooth-next/c/da5ca229b625

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



