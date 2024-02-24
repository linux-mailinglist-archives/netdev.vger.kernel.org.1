Return-Path: <netdev+bounces-74665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10119862274
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 04:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70766B22D53
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 03:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A7912B87;
	Sat, 24 Feb 2024 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pk0agqNV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61661DF60
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708744233; cv=none; b=VzhIdO0ppEPzax5jp8W4x+OaQWgLwLOGVKUCP3PRujE8XCslWDxUtcdl8OtHMLPDsd13cVBEDQ91lMQswLI94WtFa+0TeHwT225LDcueQARBXEe7Z/IFMxkOx54dtNvQaasIn/uuLuFzU7YjtfAfIeBbOeEJhUhiOj4WUliVIsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708744233; c=relaxed/simple;
	bh=O8s7eSfFNhANSRMaZuZbx+8RJMO35WW2wzocMEKDtxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MeRva6RLx/k71lqogBgXqcCu5446u2VjJFpJmeELiigDlkA/4VDwoU5Ui/gMupdFXeCPPJi7GymJj7XptXh4vGgmaZOJX4+WgehqI4mqcJVMMa0+Tye7uYDIIrAVyfZ6o3CnGsxEkORhwf+gQzQRYO5qDhJrZV1U3SbKki6EIQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pk0agqNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9409C43399;
	Sat, 24 Feb 2024 03:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708744233;
	bh=O8s7eSfFNhANSRMaZuZbx+8RJMO35WW2wzocMEKDtxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pk0agqNVlwby/SZW1O8MjUXcyso+qGPiEey+uHmsGEV7xL8WUoB/Q2zfHbLfWw2om
	 M2JCz6RMW1306IUJtZHSoAiCGp/A2Smky5gKZn4fJlJP9am5TzyDAxnesrl0qb6VF+
	 eP+5HY8iWCSWQ+YXCCjUcPDEkGRyqpU0ql2mOJO1IGiY5+2Oe/Xp0UjsV9idM0DpqS
	 vCIDsksjNIHGnTjZGtnFbVfdkZ+xCqgRPrHtS1b4SZiwXapyU2mPd+49ExDHHFnvii
	 MioFXBF8V9U/dJ/5b4J2SQ9zU8kKg2zzzDzyVXsvqIsMCA1U12bzPoG8sGvzq9kNy4
	 yPpF07bMqdFHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D32F0D84BC2;
	Sat, 24 Feb 2024 03:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] genetlink: make info in GENL_REQ_ATTR_CHECK() const
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170874423286.898.6247241029437215733.git-patchwork-notify@kernel.org>
Date: Sat, 24 Feb 2024 03:10:32 +0000
References: <20240222222819.156320-1-kuba@kernel.org>
In-Reply-To: <20240222222819.156320-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Feb 2024 14:28:19 -0800 you wrote:
> Make the local variable in GENL_REQ_ATTR_CHECK() const.
> genl_info_dump() returns a const pointer, so the macro
> is currently hard to use in genl dumps.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> 
> [...]

Here is the summary with links:
  - [net-next] genetlink: make info in GENL_REQ_ATTR_CHECK() const
    https://git.kernel.org/netdev/net-next/c/5fd5403964ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



