Return-Path: <netdev+bounces-177526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B24A7073D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9BE3B463B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E37525E445;
	Tue, 25 Mar 2025 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2yMsc99"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8D25DD12;
	Tue, 25 Mar 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920800; cv=none; b=oUZOh7v8apTSljQYVZa8MgrcqwxNYBYcHNhtbhZEmahGJVTuLkb8DdLGAyYBsiUew9lnHfs6399enDPebXX8sIitccN5J/eWDsO+is+pb4as/WMUzxwL6OW/2ehoz/y20Mxo/Pp828xEqcjAhUPM4npoNt3E+/dcsLzSCvwMxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920800; c=relaxed/simple;
	bh=NK1dlf8+8S3DrDw4WsveBGEmoi51gHV1zyG163bVKik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DbcTu1AYXjFjNJm7Fo7czMiHNW4samwU9Sb9Dml41UtyRpM8UusihLwcXLZgqORLxUHOZErQXOdza5blwXe2tyL0mhTfkmMZtieZiyFbH0J5lM4YfJzi5hikI8BnGdqmkFN5Xe2WhtEAJWfDW3ZgtsfaTLd9A3doFUTcn8FmW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2yMsc99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEDFC4CEEA;
	Tue, 25 Mar 2025 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742920799;
	bh=NK1dlf8+8S3DrDw4WsveBGEmoi51gHV1zyG163bVKik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J2yMsc99AnqvdSenxe6ZwgbBNzbFfdGbEIxip5DysWJhEvXcPJjl4Z4ixHmAPTXMj
	 Z0REwDPjKnwQD8lRapbTnv6WVV17807KkKmWTuXF51DsZDwYpFDiw7/I2KOsKhfYiJ
	 4VLlXpxTWAr+lOMffvH0gzukItq5aG8MqQBS535JFRYmHbHCzeNkEp/k6RuQhrc99e
	 +6O/zWa+mczzgzkiUYSkcwY35EqhlHRdLF6U0m2jOayvgW9NSaLj0p83I1KNXFbMSF
	 YK28dbo0GGuQ/4YL2q9ezgDHN6fOdbvEVORbw0Elq3bzwcio0j4zP3Tg/VKugzn25S
	 qcih1BFY7ShQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFFE380CFE7;
	Tue, 25 Mar 2025 16:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-af: mcs: Remove redundant
 'flush_workqueue()' calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174292083576.643641.11253209858522638305.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 16:40:35 +0000
References: <20250324080854.408188-1-nichen@iscas.ac.cn>
In-Reply-To: <20250324080854.408188-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Mar 2025 16:08:54 +0800 you wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> This was generated with coccinelle:
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: mcs: Remove redundant 'flush_workqueue()' calls
    https://git.kernel.org/netdev/net-next/c/b2d1e4c2cb8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



