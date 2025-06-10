Return-Path: <netdev+bounces-196381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C368AD46E0
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E73D3A61E9
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F369428BA88;
	Tue, 10 Jun 2025 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jrl/OxKH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903928A1DD;
	Tue, 10 Jun 2025 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598729; cv=none; b=ngES4tBvqgTXAXEdsDw0s8QJgPrv9V6Di/zOB908mKSiq+KQ7Dk+za8Xt4Yf5wUJ2VpFjj1u8PDBD2NYhQpL/JSLF9UoL7z7XFhUlXfxZOk9uaMCreXby8vNsrtMgCpQe85PxkAegTous9bQe0GM4SUBnUqqC+193bA2AnrTZnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598729; c=relaxed/simple;
	bh=G20cjLJ/dBH2r0uLWZlZsDPhGE9/9eBE9wGuTSO0kyM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PY1gk/BFKoP5nAF0DRm81Dn3T8FNruaAJF1uKV/ZZ0Zo9Rp6hghvoxqPJtfwXov2TyV4WBw1Gsh4bt68WKrmduoD8QEb/5fZ01mAKi49uKB95BOVbG+hs8K7YCIfjPgv37b66Jd1EJmB4tWgQOWTpziPWYp27pcw42F/W8RYmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jrl/OxKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5518FC4CEED;
	Tue, 10 Jun 2025 23:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749598729;
	bh=G20cjLJ/dBH2r0uLWZlZsDPhGE9/9eBE9wGuTSO0kyM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jrl/OxKHzbGESzMU8mN3QpQ5FOYB2WlNmbwDcG0LfQH622kdRnmVN4kU8epXP/diX
	 0+RXc4UYQWiL+DUMWnx9MS+Sx1yN9tcNM980HeDT4k26LId2OuL0/TyMYTSDVTuIJu
	 7LDl8wEzwQe3jpmWCKGm2zGf4z+8b/zsw/UHCK5l5IBeqWgGrXleCe2MQi6eH8oud+
	 f51QtGwuBOsb0KB3jIBuEIwqWCwc0mtpTiLOdMvq/I/+AfqIWcNQgMXKJAEkQH5I5l
	 eruUNqlUBGYQ0YmgEIS7Z4DN4584q3cAYKddXjlJEbd8aIWq2AfOf1wuLLI5bCPd1K
	 NGnawvG35UwgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD7838111E3;
	Tue, 10 Jun 2025 23:39:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netconsole: fix appending sysdata when sysdata_fields
 == SYSDATA_RELEASE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959875949.2630805.13662322579753682598.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 23:39:19 +0000
References: <20250609-netconsole-fix-v1-1-17543611ae31@gmail.com>
In-Reply-To: <20250609-netconsole-fix-v1-1-17543611ae31@gmail.com>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Jun 2025 11:24:20 -0700 you wrote:
> Before appending sysdata, prepare_extradata() checks if any feature is
> enabled in sysdata_fields (and exits early if none is enabled).
> 
> When SYSDATA_RELEASE was introduced, we missed adding it to the list of
> features being checked against sysdata_fields in prepare_extradata().
> The result was that, if only SYSDATA_RELEASE is enabled in
> sysdata_fields, we incorreclty exit early and fail to append the
> release.
> 
> [...]

Here is the summary with links:
  - [net] netconsole: fix appending sysdata when sysdata_fields == SYSDATA_RELEASE
    https://git.kernel.org/netdev/net/c/c85bf1975108

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



