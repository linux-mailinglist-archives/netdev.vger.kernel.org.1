Return-Path: <netdev+bounces-169444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA29A43F65
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1ED0189CFA4
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BAD267B86;
	Tue, 25 Feb 2025 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7kesyG/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C5266B4D
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486600; cv=none; b=qr776I/4eRBrCCbI39sQDGTtXp+vWEEJTHg+xYM6wXle+M5gbDlFA3B8BSPas6+enCcg9XUdz75Pgvr5itD73ma59WWdfusmrP4murqv2kaMzKTJtMiCG3Lmh58KpRgF8NeJkdd2zLVnWkbSakrMMK/8snyxV4j5Qd3b+pZdw4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486600; c=relaxed/simple;
	bh=CCZZVLrAd+VY3mI5UVR9eb10N1U94kjdMS/sPyBJNgo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SccJFtnDo0/WZq5ezRTYcnNvzlFzgPpgbMRfoUJ0RWL26JqlRgUipWFwRX4ARih2ckuxShOX4aXLMZPVo19E/iopThIvDINHrj7taxgCoqXQzDj/PEUhKiufATR436uIl4bNJyHWfvkV5qymRNtRfmELoG79Ag01TwYl9xY/AsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7kesyG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656C3C4CEDD;
	Tue, 25 Feb 2025 12:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740486599;
	bh=CCZZVLrAd+VY3mI5UVR9eb10N1U94kjdMS/sPyBJNgo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O7kesyG/qK51aMKM2K1lsdiMwdCfV6pfjWGQBo5nXMNDR84xRjI8zuQO/AYJS7Roz
	 6VKNMNERKjt5NtNQdc1fkn03UTjVM2Gghcbz/4j4mKC3AODpZlVsr4LYmVpR1GlsNv
	 +w6AUCZHz7bk85reo9NpyHLu7Vp1TdTPgx5kWMpSp8NYDmTvsUHb6xI7iABFxjwbjx
	 cn4kpgmv006ZwI8uAlpGNZdQRDAcmY8q1rwOn/luW9MkJBRwdsf8onr3FNdqKvkGfA
	 HvjClOOTG7eHzqqrwTgK71yBE5oKEenfL9R8mqRiUMbQ9apDOWOK3vW0deNjaX/mfm
	 r9G0S+s6b6miw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F98380CEDC;
	Tue, 25 Feb 2025 12:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: socket timestamping: add Jason Xing as
 reviewer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174048663100.4155054.3311142438178219679.git-patchwork-notify@kernel.org>
Date: Tue, 25 Feb 2025 12:30:31 +0000
References: <20250222172839.642079-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250222172839.642079-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 kerneljasonxing@gmail.com, kernelxing@tencent.com, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 22 Feb 2025 12:28:04 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Jason has been helping as reviewer for this area already, and has
> contributed various features directly, notably BPF timestamping.
> 
> Also extend coverage to all timestamping tests, including those new
> with BPF timestamping.
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: socket timestamping: add Jason Xing as reviewer
    https://git.kernel.org/netdev/net/c/bc50682128bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



