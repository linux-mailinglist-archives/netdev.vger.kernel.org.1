Return-Path: <netdev+bounces-235334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DB1C2EB57
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4363E3B94F2
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28F722B8AB;
	Tue,  4 Nov 2025 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0IOTk/N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD86227B83;
	Tue,  4 Nov 2025 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218650; cv=none; b=qcrG7EURgFiPs4yninMlmHMgIAgLKbpcF8Rm8K0wdwbqjjI05yfsPKEqgyuWNP7mJxZaKcV6zZbe7banb018ehojmRVthpFIBZponnLvgj15O0BRjrWtHNN3NsnZl51SVnUZ2N0IrtbB3aUwqDBq4wza7r4E9LIFQdqmEhtphfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218650; c=relaxed/simple;
	bh=NBfH1IBbb9xwRI2sTNGRqucISVDUqKFUbuxupe5QKZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QhaPyGzzVNzfh7mNZWMVbzFnJoBXadVfC0BaThaXMmZ0pevrRplU0klyhm8CJMwDOI4I/jqnX8bD6h4tNZfzczpCq10TiWKHvoSVEvQAGQXfy1G1uFpFcqu8QJ2yJP4sLZHRlXOcsgXpW/Tfz6PZ4y5TPWA/oiFqLUbxrNiOoS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0IOTk/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B97C4CEE7;
	Tue,  4 Nov 2025 01:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762218650;
	bh=NBfH1IBbb9xwRI2sTNGRqucISVDUqKFUbuxupe5QKZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A0IOTk/NyLTExtCCvX/pMwDR3DusNkeLiqkKjU5932oYupK3WjgCz7+UVr5eQYvhj
	 uJg4dkuYZMkCPP1gmYP0plE9gIQLqTT61gDyB283wlbYJfG3PeGGhSKYckitKNSd9Q
	 w3yhiSInkzX8jU3fzYt2lCHmlNqkZV/KL7qPaB/fE+Iw7az1JcEqI1oNJbW3cA8Ddx
	 gokX16Lri/tFzk40T8tY0ckrhJH9gEs+C3tQRWRop7WJnvq/+OJhjZEo5EWzAuwqTf
	 yj9A90jHL75p+fc9vR/OcD5M7//PJw0QLrGcM9MqLwlzuxvxo2cnNCIxTdGyvohQ+d
	 5xwXAp8OyTFiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC323809A8A;
	Tue,  4 Nov 2025 01:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add brcm tag driver to b53
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176221862424.2276313.8273095778671397872.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 01:10:24 +0000
References: <20251101103954.29816-1-jonas.gorski@gmail.com>
In-Reply-To: <20251101103954.29816-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  1 Nov 2025 11:39:54 +0100 you wrote:
> The b53 entry was missing the brcm tag driver, so add it.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/netdev/20251029181216.3f35f8ba@kernel.org/
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: add brcm tag driver to b53
    https://git.kernel.org/netdev/net/c/7ed8b63ddc9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



