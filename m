Return-Path: <netdev+bounces-167135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ED9A39007
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 090357A3B12
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 00:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4011574040;
	Tue, 18 Feb 2025 00:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm93hDUF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144155A79B;
	Tue, 18 Feb 2025 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739839209; cv=none; b=YMdNg9/dQn+cSqQn+JgHJ0CoIn/4oeT6T6K3PXlcR9283keExIrHDf9KO4HsBxKwftMhQcQYhHGx8tscsLNqjTO2XKF4mIFIrpH7OrjwZcmR6jV+F3pKoW+67Lq5sISIW2XV6RNApjZD5v8bJCtNZqp7LHLnJ786MNhWlznntrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739839209; c=relaxed/simple;
	bh=fe2QDBrRS4AE8XkO7LxWl4E9t5ur/igenByD+nEO77Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EPNMnOjI4vIUKJIHhOZZTI57KjND1ovUCFsiDULNb7+QzVzRR8HS5RuGbcz67Shw2j+6Det81zgQnqeme4DGohOTIEekBm7kvM+qPoBGAJ4jV7k5VIPan/JAifhhYQT9iXTIP8DGsacsmOljhcBxp4Jx9l63Rq0tBNYr138S9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm93hDUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E41C4CED1;
	Tue, 18 Feb 2025 00:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739839208;
	bh=fe2QDBrRS4AE8XkO7LxWl4E9t5ur/igenByD+nEO77Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gm93hDUFPSU0zFwLtZ9+Uz9aNanNbWnwJwJzvQVdIbjYIWHkL60PkbQMg7Kq70geO
	 p4HXZBebI1pmrajOn2q9jUTD39F5vUr8pzLWNaNVTUhNx8THzvHrKkfhv57L+hfxHN
	 KOYFpygyJFlImO3D8XKJKatGrzWfTdAj+zVSr2qKSKECzsuc7AtPlxnqq+5d9WyJAx
	 UoSEPc3TDlgN5sRj471V4rePlruhXxzPGnl1wzWfb26bqkR9RWCNQ2jhgzx/2DaXDg
	 BnHhYLWUAhhk4Qthn/90ZQQoQDgQjHfXsLJn0845JDfoTl1bon+zpRn7JorRhv9ivF
	 lH7mfhXkQjGvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF79380CEE2;
	Tue, 18 Feb 2025 00:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: fix grammar in
 reuseaddr_ports_exhausted.c log message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173983923876.3583210.5233626210014898247.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 00:40:38 +0000
References: <20250213152612.4434-1-pranav.tyagi03@gmail.com>
In-Reply-To: <20250213152612.4434-1-pranav.tyagi03@gmail.com>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org,
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Feb 2025 20:56:11 +0530 you wrote:
> This patch fixes a grammatical error in a test log message in
> reuseaddr_ports_exhausted.c for better clarity as a part of lfx
> application tasks
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> ---
>  tools/testing/selftests/net/reuseaddr_ports_exhausted.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] selftests: net: fix grammar in reuseaddr_ports_exhausted.c log message
    https://git.kernel.org/netdev/net-next/c/dbcbec81c9b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



