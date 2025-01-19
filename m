Return-Path: <netdev+bounces-159595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808B1A15FDB
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A0A7A11E8
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 01:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BB317F4F2;
	Sun, 19 Jan 2025 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/ecxYvG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77557171658;
	Sun, 19 Jan 2025 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737251418; cv=none; b=mULYycVqDe0xzn1sLGhsF6x94HtsV76BAjvHGr5f6uA/gxms4H56iZ2m8x6L6oJwNQ2/g/pwMEtxHzvBkJrfn8zssJKK7ijvDqAQYh2bnWkkoTI8ZFMmyGjd1aGbx/xuBafALZdXEOKU5iHIIaq8lzIsK3QffVIQ6/hIRquZXHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737251418; c=relaxed/simple;
	bh=o2i9mDamoEVz/LURKZ6Fl6w8T10aPxevPcV1l98COJo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=prNXiBBXIwxADg2KaTcFa/AA1scZuhLnvtMpNB4IZjbrUOtxNCK7OLtJ0QW1yAnyOkFvIKoaFCx9T2e11aFjLL+/VgBp02q126FaMJPVZE355DpHBbgiSH0ZT7oaMjE4YDK4MnJDqGYjyzNbqHkSxZ2KxVgwwVt12pp+wrIOGjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/ecxYvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5303CC4CED1;
	Sun, 19 Jan 2025 01:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737251418;
	bh=o2i9mDamoEVz/LURKZ6Fl6w8T10aPxevPcV1l98COJo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e/ecxYvGSjeRYWnx359x7zYIjVXtDOBGOvbmwneBU4h/dv/fYkYu6WwYqQpPbzvI3
	 0DU7eD+UL4VsjVOnKUTMXyGyg5UEGyLTGJ1WYuKGxaCdO+3PQebJQJ8ZHMWoIsKzVC
	 KAR4GV44tn3nVqhrax6TGDQm0jFmCKaoeyYbOXhey5Ka9LbXsCvSP6P69JqQ8NBtAN
	 l2cg6fE44vPQjnC8LX9HbeMQbWlpL46SmXauGgdGqBnfK7nGuz7VR0zAGKFRAYHrBq
	 4Ppa2RpWnpeAd1g0pJzUvKpzlPOmBMWLW+riS+Lz5HSqBiYudyj0nvHC7knLLZ+MhF
	 w9oXoD0hZ7Ymw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9B380AA62;
	Sun, 19 Jan 2025 01:50:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mptcp: sysctl: add
 syn_retrans_before_tcp_fallback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725144173.2533015.12381253219844208530.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 01:50:41 +0000
References: <20250117-net-next-mptcp-syn_retrans_before_tcp_fallback-v1-1-ab4b187099b0@kernel.org>
In-Reply-To: <20250117-net-next-mptcp-syn_retrans_before_tcp_fallback-v1-1-ab4b187099b0@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jan 2025 18:40:31 +0100 you wrote:
> The number of SYN + MPC retransmissions before falling back to TCP was
> fixed to 2. This is certainly a good default value, but having a fixed
> number can be a problem in some environments.
> 
> The current behaviour means that if all packets are dropped, there will
> be:
> 
> [...]

Here is the summary with links:
  - [net-next] mptcp: sysctl: add syn_retrans_before_tcp_fallback
    https://git.kernel.org/netdev/net-next/c/5b4fd35343d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



