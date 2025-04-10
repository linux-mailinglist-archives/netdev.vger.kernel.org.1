Return-Path: <netdev+bounces-180975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 965EEA83550
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A0516AC5E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAF0154BE2;
	Thu, 10 Apr 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFxnlM3O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B814658C;
	Thu, 10 Apr 2025 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744246795; cv=none; b=VoTxGb8KJEIekGr7GFNHgV7XufMggiovXadEfqTH1+FFi7gVMAQovpJhYQxh7DkQffo9sIsttiPmBTqbyQL7VoeQP6TwSwem6ocCGcTofYZi6opAoxp7B/Qfu0pwFRmoxq2nxr5UKy+Kb5g4AYoakjSh5butz7koW4cS662UEU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744246795; c=relaxed/simple;
	bh=ry72hZFX4KlyQ+rujBtRU1VRSJptD+YXRI6hgi9jtUc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YCZgWHAwWBhuZnUv1xjGOJrU3qGKOv9nZYKIRE56k+p7Aoqzf3EhA75Jy+dfFOWbvXeQcz4XS1rwQYjl3zyKzEU/CwvaGIe7epr/t+KKBhH4SSgFWDQC/GN3hx9f0pEl1vxqfeXEK+kB17QTB8Ma+EmGwL5mXs2eP7ALCeuqffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFxnlM3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CC2C4CEE2;
	Thu, 10 Apr 2025 00:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744246795;
	bh=ry72hZFX4KlyQ+rujBtRU1VRSJptD+YXRI6hgi9jtUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jFxnlM3OglH9ih5sn6CjFbZuXJaykogxxYzlgYRkJRcCEhk6O36RrSi8dwGarZj3G
	 g4CeFTnYNwCioxlqgtvhlCwbLmoXCoq6dkEY9Kpgw/rb0+7fJRPQYKeSjQqUZSCY1B
	 Fk9Ji9Pqh5rIXqkNE9o5duqbyaOpAQNDKWagBh9SmcUPN9j/J7oH92JbJxjAA3Ui6n
	 rpDzTs8ROj6arGnpOECF5eAYKpR//aicfKDEPLy6dKytZcW93eG3a/eYcojQb9qsTh
	 VBVNQOEXiwTnfRnC+L6HIYildiJIfpygB/8yGEUi1Fr+WkY34GLaw84SPWPM29L1H4
	 6hObWMbmHPEzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB44A38111DC;
	Thu, 10 Apr 2025 01:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ipvlan: remove __get_unaligned_cpu32 from ipvlan driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174424683276.3096919.13635911200697987681.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 01:00:32 +0000
References: <20250408091946.2266271-1-julian@outer-limits.org>
In-Reply-To: <20250408091946.2266271-1-julian@outer-limits.org>
To: Julian Vetter <julian@outer-limits.org>
Cc: arnd@arndb.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com,
 gnault@redhat.com, yuehaibing@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Apr 2025 11:19:46 +0200 you wrote:
> The __get_unaligned_cpu32 function is deprecated. So, replace it with
> the more generic get_unaligned and just cast the input parameter.
> 
> Signed-off-by: Julian Vetter <julian@outer-limits.org>
> ---
>  drivers/net/ipvlan/ipvlan_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: ipvlan: remove __get_unaligned_cpu32 from ipvlan driver
    https://git.kernel.org/netdev/net-next/c/1635eecdd298

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



