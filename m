Return-Path: <netdev+bounces-116246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB5494990C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 22:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E602283DD7
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB0315FA92;
	Tue,  6 Aug 2024 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjKbp61A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C0A15F330;
	Tue,  6 Aug 2024 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976082; cv=none; b=t/cyR10WOEmNgdYqnGd0zDbJ3JQCjmkFuAEBygLm/M0oBJB/0/3/gwls35E8KFheWPv1QkseCMAFnzsbCXWnIwSESujADGeANnP3qIbKuH57bSsODPsJ2BBBqzkjA4kPZGxwbbDpxFJjYkRQu690BEisxVBH8giRLxDCvxYOo+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976082; c=relaxed/simple;
	bh=PGidN50VqSMsxH5WPybaRo3PQQ3ZFjgWPFywza87M2Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=snOzZn47Bip8oMCVTIjLw4StGDMyoExZtwclP7SICsnUTPYnysCrohKF6OmH5ciiUbpJZgTIt7TwSghwv8K07KHbm5A7ctIIbDh4bJXjFCkCxVpOUrt9151dD2ZEpVSRzxuxwBTWj6Pj20GxrApAQNhsxgz1RJdTFGLJo0Uqncs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjKbp61A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F00C4AF11;
	Tue,  6 Aug 2024 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976082;
	bh=PGidN50VqSMsxH5WPybaRo3PQQ3ZFjgWPFywza87M2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mjKbp61AtvZojlrEeyKxTIBYhokiQPE1EMUXZCR1QvueH/kisy9s0RQQdLiL64hF2
	 XO1jdpMRNol1yKqezjW83AG/yvLfcbFIIqiRMKykmv+WeEAlRal2ovtD0gjWiT7+6d
	 tdTXNwHuHQ25XfFjd02WSYAHA7ZlzNjCnZzuWQC0/bOUisDjpJ+MCfp2bjbKoGnOAL
	 oNba+4x66OGM1Cr2l5+KPISZXHfh3RiwrHVX+DJUQpwH60uzvUMoBlyA53l69M5XFL
	 hgic2k9M/PeVt3z6JvEkxNFrbGkiRiCWOm7Hh0Dk3UvTKlzgCKNJwec7cUjxmM7DbM
	 BQ5PDpYWrm9GA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1F93824F34;
	Tue,  6 Aug 2024 20:28:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ethtool: cmis_cdb: Remove unused declaration
 ethtool_cmis_page_fini()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172297608133.1692635.2165578555125490106.git-patchwork-notify@kernel.org>
Date: Tue, 06 Aug 2024 20:28:01 +0000
References: <20240803112213.4044015-1-yuehaibing@huawei.com>
In-Reply-To: <20240803112213.4044015-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, danieller@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 3 Aug 2024 19:22:13 +0800 you wrote:
> ethtool_cmis_page_fini() is declared but never implemented.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/ethtool/cmis.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] ethtool: cmis_cdb: Remove unused declaration ethtool_cmis_page_fini()
    https://git.kernel.org/netdev/net-next/c/edfa53dd617f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



