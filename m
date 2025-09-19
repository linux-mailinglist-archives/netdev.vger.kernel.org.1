Return-Path: <netdev+bounces-224782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203D2B89FD7
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 16:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B623BFEB5
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907A53168FE;
	Fri, 19 Sep 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4zkv2tF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C62D314D15
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292225; cv=none; b=hnTGJH3LKFabJgl5/jFVp/jf/iRsYJ4B+WkbKJwKVNGzKtSUjLr4bAciqu5ng445Jt/kRX9hUfcjVjwSul4NHZ45UM+z/9jutZWYjpKV5G15aFKvWIhWVic/LrSfUTa251CWe3ZtT33U+9f+2mSjaC0zm6DN2VQe2s3O77zXUDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292225; c=relaxed/simple;
	bh=fOvNkRQRh5gUnDHeugADt8bDk5JJAJ9aGYkmWTmR/ks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DvaEMSxGnQ1ntdrbSUuf7dVE6dlz0h9n8+W40JhkZc023+Iu9mcFhtZgUOayOH2XYCxV9/426UaIA3i5GecQ7EWrOb8hGLfCeYljYJGUJ8a1M+ogQKytTGNfJDR67XJ8FsTDYuLTO0b2AFObXzOpzuyHm3vI4vcTViW8RErPVuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4zkv2tF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AF5C4CEF5;
	Fri, 19 Sep 2025 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758292225;
	bh=fOvNkRQRh5gUnDHeugADt8bDk5JJAJ9aGYkmWTmR/ks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M4zkv2tFXhUyTJE5tBGTiGmuAYyuPtLYJD0w3lKFPEcVHx/RcgZJcIMG88Iy4aqkL
	 N+uhbsBwTEMdxi1Gec+p6NS8x0p3+FYpbsGIeHUQw04onDaPlVzAG6S92HBk0TC7iz
	 R4NVT2VfkwJU/lJdG3eC7r4h7GSpq6AsO6eNW/QnQzMb++VcDBnxlvnCcxaB+H8oEm
	 GbhlPaTZBhzIqN8Ua4DDyQ7HIs3n2DRf9sd2Wn+H7j5daXf7R6KETQ66uuz3isLO6Q
	 GfMtq9rP+fshDJXIM58NiiISCVWhcECPIlO4YE9GAeb/+7LA1csoWKV1JjiN8uJn0o
	 iR7Iyi/It9lJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB6D39D0C20;
	Fri, 19 Sep 2025 14:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] psp: do not use sk_dst_get() in
 psp_dev_get_for_sock()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175829222449.3219626.14565857704292807612.git-patchwork-notify@kernel.org>
Date: Fri, 19 Sep 2025 14:30:24 +0000
References: <20250918115238.237475-1-edumazet@google.com>
In-Reply-To: <20250918115238.237475-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, daniel.zahka@gmail.com,
 kuniyu@google.com, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 11:52:38 +0000 you wrote:
> Use __sk_dst_get() and dst_dev_rcu(), because dst->dev could
> be changed under us.
> 
> Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Daniel Zahka <daniel.zahka@gmail.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] psp: do not use sk_dst_get() in psp_dev_get_for_sock()
    https://git.kernel.org/netdev/net-next/c/17f1b7711e81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



