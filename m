Return-Path: <netdev+bounces-249489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEF2D19CFF
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06D37300C6FA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ACA392B80;
	Tue, 13 Jan 2026 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHbf8sIA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB1F392B68;
	Tue, 13 Jan 2026 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317213; cv=none; b=ERshuWpZi9/qtGed0gNPX6+Mesu6V6zAZ9AXklo/3az7VyY1GNH6ufShS3wTTIjVRkC++D448C90B/fVyqTL5FkMwKhFv3aOtbxf6XEV9ZbMHy31SQ3350UmXBEDO4VaFK6go3QcZiikZmYwvesXc8sS/DkFPZoJeYCI3zXqjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317213; c=relaxed/simple;
	bh=ogyBPwEl2kLjnHwSzJ6tn0JU+Pl+B4TgKzZ7v+/NVtg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pqAQ1VtQLTWltecDtMh3mq6dGSw4vyvppA9gpslWXmg8hNNgx+ReGqv5Z66wBCC/FRsRQGlmaesXDtKU2wyy40U6YkumrOn3p8NV0vVa8Bkw0SacNJZLi5r4codJOG2226UcwcP6loIt+3OZ8C4L/5ytp2PWPci/iAmdORUHQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHbf8sIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491F2C2BC9E;
	Tue, 13 Jan 2026 15:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768317213;
	bh=ogyBPwEl2kLjnHwSzJ6tn0JU+Pl+B4TgKzZ7v+/NVtg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cHbf8sIAknuIkoIKXAZ9Kio4X2id1ByWBU/znd5GdRn2aqNQbu56gAnI6Qmwz40YI
	 ja8Po1/GTvBbc+z4LR/e+6t+ntHxbfzc7E4cYZKukCdAguZFzjQLHvQogVfIxjaAuD
	 jFyD392K0ta91S+3LZe8C3AOzsOTPIWlPNP09CQVRSfqejQ8uPfBEYKDwPXB8kQwpm
	 lfkOl+4VZbi49UzMTHDaZCfk11xCxfxtIObY/k7ksqYPEFhWDC7JKNZs3YvuQdR0y+
	 0Z1BU6zpBdEcHZ3VgY1nl9NX+e0SHpCVZkeFdXnvyofFAJQgSrePLveZWuWenndkYs
	 yxbXX1MMNsS5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B675D3808200;
	Tue, 13 Jan 2026 15:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: airoha: implement get_link_ksettings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176831700647.2290468.15768850457756402576.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 15:10:06 +0000
References: <20260110170212.570793-1-olek2@wp.pl>
In-Reply-To: <20260110170212.570793-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 10 Jan 2026 18:02:05 +0100 you wrote:
> Implement the .get_link_ksettings to get the rate, duplex, and
> auto-negotiation status.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - net: airoha: implement get_link_ksettings
    https://git.kernel.org/netdev/net-next/c/50e194b6da72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



