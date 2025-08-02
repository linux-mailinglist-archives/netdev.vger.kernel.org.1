Return-Path: <netdev+bounces-211427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7DAB189C4
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 02:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABC05A0170
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 00:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929297F9;
	Sat,  2 Aug 2025 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZuLlZa3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E417367
	for <netdev@vger.kernel.org>; Sat,  2 Aug 2025 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754093636; cv=none; b=uLTJN2UUzKBRTd5WV9ZT8nJ10xmZ8YhGAsIZh6r/xSYTjvb+DIvRn7BWFLspPR5NgceOygheLGO3ZTboFbIvSiCi8nLht/1tJdnVMTljGVXGCjG866Jxq+5XBNSc6JbYtJ8qW0PfzoYdpLIpG7/ZYBh8ij3LU10mo0GGXImPznc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754093636; c=relaxed/simple;
	bh=gYBqyL19CRMq62682mQhzP/WOubADsrYfMb7Ss+D0PI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KbuJYBCceiZhsnLcX2Oo2WXqEkPObSHJhoZB6bOeokbtdwaiYeJyzjexAirxt7Cyy+lHGpKkmc87baYxTumKpZk1sG5BaHV5F8g8oSj6hsG4yB38b2aW3/xj6Euto+Vz7F1KAUgwfGpIK0PuQvO9xpbgqszUfLEaqJzoupJ9s+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZuLlZa3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D22C4CEE7;
	Sat,  2 Aug 2025 00:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754093636;
	bh=gYBqyL19CRMq62682mQhzP/WOubADsrYfMb7Ss+D0PI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RZuLlZa3rCfpMKtULVLJKubQiTwodnUvlBC2D8MMfVtig38a/hglQOOi8XW4BwHKp
	 +LoW0MJnEN9v5JOoPZjtannHd9YtBaGmr7kOwtYSWz3jB2pOCxyXAWTjQ5qY7ezt6z
	 7AFbO1RjDDAOmK4CDO4MJLnXHnmLNHhK6DClrapgQ23ANTYAbxMQGq//hIN/7HWI4T
	 Hwfx9U0Yn9g8zO2+aNU/M1wu5A4K92Gs9QhaHrYqnpQfg5ysxzSB0ZDptBufVGVMxp
	 oFQ+ulhDOK01BPNw5xD40dsxCKo26pgVJSeLFxMgv80lQuZ8XKEYQ5JSNXtWA9airB
	 TFnJV/H8H7/Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D87383BF56;
	Sat,  2 Aug 2025 00:14:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: avoid using ifconfig
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175409365099.4093813.16108037580609492472.git-patchwork-notify@kernel.org>
Date: Sat, 02 Aug 2025 00:14:10 +0000
References: <20250730115313.3356036-1-edumazet@google.com>
In-Reply-To: <20250730115313.3356036-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, dongchenchen2@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Jul 2025 11:53:13 +0000 you wrote:
> ifconfig is deprecated and not always present, use ip command instead.
> 
> Fixes: e0f3b3e5c77a ("selftests: Add test cases for vlan_filter modification during runtime")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Dong Chenchen <dongchenchen2@huawei.com>
> ---
>  tools/testing/selftests/net/vlan_hw_filter.sh | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [net] selftests: avoid using ifconfig
    https://git.kernel.org/netdev/net/c/7cbd49795d4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



